//! Runs queued jobs one at a time, as child processes, and turns what they print into live state.

use std::io::{BufRead, BufReader};
use std::process::{Child, Command, ExitStatus, Stdio};
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, mpsc};
use std::time::{Duration, Instant};

use hodow_common::time::now_ms;
use hodow_common::{Event, Level, RunState, RunStatus};

use super::jobs::{Job, JobStatus};
use super::{Active, AppState};

const HISTORY: usize = 50;
const POLL: Duration = Duration::from_millis(100);
const TERM_GRACE: Duration = Duration::from_secs(3);

enum Line {
    Out(String),
    Err(String),
}

pub fn spawn(state: Arc<AppState>) {
    std::thread::spawn(move || {
        loop {
            match next_job(&state) {
                Some((job, cancel)) => run_job(&state, job, cancel),
                None => std::thread::sleep(Duration::from_millis(200)),
            }
        }
    });
}

fn next_job(state: &AppState) -> Option<(Job, Arc<AtomicBool>)> {
    let mut live = state.live();
    if live.active.is_some() {
        return None;
    }
    let mut job = live.queue.pop_front()?;
    job.status = JobStatus::Running;
    job.started_ms = Some(now_ms());
    let cancel = Arc::new(AtomicBool::new(false));
    live.active = Some(Active {
        state: RunState::new(job.module.clone(), job.module.clone(), now_ms()),
        job: job.clone(),
        cancel: cancel.clone(),
    });
    drop(live);
    state.bump();
    Some((job, cancel))
}

fn spawn_child(state: &AppState, job: &Job) -> std::io::Result<Child> {
    let mut command = Command::new(&state.exe);
    command
        .arg("--events")
        .arg("--data-dir")
        .arg(state.data_dir.root())
        .args(&job.args)
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped());
    #[cfg(unix)]
    {
        use std::os::unix::process::CommandExt;
        command.process_group(0);
    }
    command.spawn()
}

fn pipe_lines(
    reader: impl std::io::Read + Send + 'static,
    tx: mpsc::Sender<Line>,
    wrap: fn(String) -> Line,
) -> std::thread::JoinHandle<()> {
    std::thread::spawn(move || {
        for line in BufReader::new(reader).lines().map_while(Result::ok) {
            if tx.send(wrap(line)).is_err() {
                break;
            }
        }
    })
}

#[cfg(unix)]
fn signal_group(child: &Child, signal: i32) {
    unsafe {
        libc::kill(-(child.id() as i32), signal);
    }
}

#[cfg_attr(
    unix,
    expect(clippy::needless_pass_by_ref_mut, reason = "the non-unix branch kills the child")
)]
fn terminate(child: &mut Child) {
    #[cfg(unix)]
    signal_group(child, libc::SIGTERM);
    #[cfg(not(unix))]
    let _ = child.kill();
}

fn kill(child: &mut Child) {
    #[cfg(unix)]
    signal_group(child, libc::SIGKILL);
    let _ = child.kill();
}

fn apply(state: &AppState, line: Line) {
    let mut live = state.live();
    let Some(active) = live.active.as_mut() else { return };
    match line {
        Line::Out(text) => {
            if let Ok(Some(event)) = Event::parse_line(&text) {
                if let Event::RunStarted { run: Some(run), .. } = &event {
                    active.job.run = Some(run.clone());
                }
                active.state.apply(&event, now_ms());
            }
        }
        Line::Err(text) => active.state.push_log(Level::Info, text),
    }
    drop(live);
    state.bump();
}

#[expect(clippy::needless_pass_by_value, reason = "moved into the job thread by the caller")]
fn run_job(state: &AppState, job: Job, cancel: Arc<AtomicBool>) {
    let (exit, cancelled) = match spawn_child(state, &job) {
        Ok(child) => supervise(state, child, &cancel),
        Err(e) => {
            let mut live = state.live();
            if let Some(active) = live.active.as_mut() {
                active.state.push_log(Level::Error, format!("could not start: {e}"));
            }
            (None, false)
        }
    };
    finish(state, exit, cancelled);
}

fn supervise(state: &AppState, mut child: Child, cancel: &AtomicBool) -> (Option<ExitStatus>, bool) {
    let (tx, rx) = mpsc::channel();
    let readers = [
        child.stdout.take().map(|s| pipe_lines(s, tx.clone(), Line::Out)),
        child.stderr.take().map(|s| pipe_lines(s, tx.clone(), Line::Err)),
    ];
    drop(tx);
    let mut terminated: Option<Instant> = None;
    let mut cancelled = false;
    let exit = loop {
        match rx.recv_timeout(POLL) {
            Ok(line) => apply(state, line),
            Err(mpsc::RecvTimeoutError::Timeout | mpsc::RecvTimeoutError::Disconnected) => {}
        }
        if cancel.load(Ordering::Relaxed) {
            cancelled = true;
            match terminated {
                None => {
                    terminate(&mut child);
                    terminated = Some(Instant::now());
                }
                Some(at) if at.elapsed() > TERM_GRACE => kill(&mut child),
                Some(_) => {}
            }
        }
        if let Ok(Some(status)) = child.try_wait() {
            break Some(status);
        }
    };
    for reader in readers.into_iter().flatten() {
        let _ = reader.join();
    }
    while let Ok(line) = rx.try_recv() {
        apply(state, line);
    }
    (exit, cancelled)
}

fn finish(state: &AppState, exit: Option<ExitStatus>, cancelled: bool) {
    let code = exit.and_then(|s| s.code());
    let (finished_job, abandoned_run) = {
        let mut live = state.live();
        let Some(active) = live.active.take() else { return };
        let mut job = active.job;
        job.finished_ms = Some(now_ms());
        job.exit_code = code;
        job.status = match (cancelled, code) {
            (true, _) => JobStatus::Cancelled,
            (_, Some(0)) => JobStatus::Succeeded,
            (_, Some(2)) => JobStatus::Skipped,
            _ => JobStatus::Failed,
        };
        let abandoned = job.run.clone().filter(|_| !active.state.status.is_finished());
        live.history.push_front(job.clone());
        live.history.truncate(HISTORY);
        (job, abandoned)
    };
    if let Some(run) = abandoned_run {
        let status = if cancelled {
            RunStatus::Cancelled
        } else {
            RunStatus::Crashed
        };
        let _ = state.store.finish_abandoned(&run, status);
    }
    super::watch::refresh_runs(state);
    log::info!(
        "Job {} ({}) finished: {:?}",
        finished_job.id,
        finished_job.module,
        finished_job.status
    );
    state.bump();
}
