//! Running workers and deciding what happened to them.
//!
//! A worker is judged only by what it said and how it ended: a `Done` line, a signal, or
//! silence. Silence past the hang timeout gets a SIGKILL, and a worker the kernel will not
//! let die (state `D` inside a GPU driver) is reported rather than waited on - the same
//! bounded reap `hodow_cts`' `runner::reap` does, which this crate cannot depend on.

use std::collections::VecDeque;
use std::io::{BufRead, BufReader};
use std::process::{Child, Command, ExitStatus, Stdio};
use std::sync::mpsc::{self, RecvTimeoutError};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use serde::{Deserialize, Serialize};

use super::protocol::{Msg, WorkerSpec, WorkerVerdict, parse};

/// How long a worker may take to exit after reporting `Done` before it counts as stuck.
const EXIT_GRACE: Duration = Duration::from_secs(10);
const REAP_GRACE: Duration = Duration::from_secs(10);
const STDERR_TAIL: usize = 12;

#[derive(Serialize, Deserialize, Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
#[serde(rename_all = "snake_case")]
pub enum Status {
    Skip,
    Ok,
    Warn,
    Error,
    Crash,
    Hang,
    Abort,
}

impl Status {
    pub fn is_failure(self) -> bool {
        matches!(self, Status::Error | Status::Crash | Status::Hang | Status::Abort)
    }
}

#[derive(Clone, Debug)]
pub struct PartOutcome {
    pub role: &'static str,
    pub status: Status,
    pub detail: String,
    pub errors: u64,
    pub samples: Vec<String>,
    pub warnings: Vec<String>,
    /// The worker outlived SIGKILL - the driver it sits in is wedged.
    pub stuck: bool,
}

pub enum Control {
    Continue,
    Abort(String),
}

struct Running {
    role: &'static str,
    child: Child,
    last_beat: Instant,
    done: Option<(Msg, Instant)>,
    warnings: Vec<String>,
    stderr: Arc<Mutex<VecDeque<String>>>,
    /// When its stdout closed - the last line it wrote has been read by then.
    eof: Option<Instant>,
    exited_at: Option<Instant>,
    outcome: Option<PartOutcome>,
}

/// Starts every worker at once and returns when all of them have an outcome. `tick` runs
/// about ten times a second and may abort the lot.
pub fn run_parts(
    specs: Vec<WorkerSpec>,
    hang_timeout: Duration,
    mut tick: impl FnMut() -> Control,
) -> Vec<PartOutcome> {
    let exe = std::env::current_exe().unwrap_or_else(|_| "hodow".into());
    let (tx, rx) = mpsc::channel::<(usize, Option<Msg>)>();
    let mut running: Vec<Running> = Vec::new();
    for (index, spec) in specs.iter().enumerate() {
        let role = spec.job.role();
        let json = serde_json::to_string(spec).expect("worker spec serializes");
        let spawned = Command::new(&exe)
            .args(["burn", "--worker", &json])
            .stdin(Stdio::null())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn();
        let mut child = match spawned {
            Ok(child) => child,
            Err(e) => {
                // Keep indices aligned with `specs`: a placeholder that is already decided.
                let placeholder = Command::new("true").spawn().expect("can spawn `true`");
                running.push(Running {
                    role,
                    child: placeholder,
                    last_beat: Instant::now(),
                    done: None,
                    warnings: Vec::new(),
                    stderr: Arc::default(),
                    eof: None,
                    exited_at: None,
                    outcome: Some(outcome(role, Status::Crash, format!("could not start the worker: {e}"))),
                });
                continue;
            }
        };
        let stdout = child.stdout.take().expect("piped stdout");
        let tx = tx.clone();
        std::thread::spawn(move || {
            for line in BufReader::new(stdout).lines().map_while(Result::ok) {
                if let Some(msg) = parse(&line) {
                    let _ = tx.send((index, Some(msg)));
                }
            }
            let _ = tx.send((index, None));
        });
        let stderr = Arc::new(Mutex::new(VecDeque::new()));
        let pipe = child.stderr.take().expect("piped stderr");
        let tail = stderr.clone();
        std::thread::spawn(move || {
            for line in BufReader::new(pipe).lines().map_while(Result::ok) {
                let mut tail = tail.lock().unwrap_or_else(|e| e.into_inner());
                if tail.len() == STDERR_TAIL {
                    tail.pop_front();
                }
                tail.push_back(line);
            }
        });
        running.push(Running {
            role,
            child,
            last_beat: Instant::now(),
            done: None,
            warnings: Vec::new(),
            stderr,
            eof: None,
            exited_at: None,
            outcome: None,
        });
    }
    drop(tx);

    while running.iter().any(|r| r.outcome.is_none()) {
        match rx.recv_timeout(Duration::from_millis(100)) {
            Ok((index, Some(msg))) => {
                let worker = &mut running[index];
                worker.last_beat = Instant::now();
                match msg {
                    Msg::Beat { .. } => {}
                    Msg::Warn { msg } => worker.warnings.push(msg),
                    done @ Msg::Done { .. } => worker.done = Some((done, Instant::now())),
                }
            }
            Ok((index, None)) => running[index].eof = Some(Instant::now()),
            Err(RecvTimeoutError::Timeout) | Err(RecvTimeoutError::Disconnected) => {}
        }
        if let Control::Abort(why) = tick() {
            for worker in running.iter_mut().filter(|w| w.outcome.is_none()) {
                let reaped = kill_and_reap(&mut worker.child);
                let mut aborted = outcome(worker.role, Status::Abort, why.clone());
                aborted.stuck = reaped.is_some();
                worker.outcome = Some(aborted);
            }
            break;
        }
        for worker in running.iter_mut().filter(|w| w.outcome.is_none()) {
            worker.outcome = judge(worker, hang_timeout);
        }
    }
    running
        .into_iter()
        .map(|w| w.outcome.expect("every worker was judged"))
        .collect()
}

fn outcome(role: &'static str, status: Status, detail: String) -> PartOutcome {
    PartOutcome {
        role,
        status,
        detail,
        errors: 0,
        samples: Vec::new(),
        warnings: Vec::new(),
        stuck: false,
    }
}

fn judge(worker: &mut Running, hang_timeout: Duration) -> Option<PartOutcome> {
    let mut exited = worker.child.try_wait().ok().flatten();
    if exited.is_some() {
        let at = *worker.exited_at.get_or_insert_with(Instant::now);
        // Its last line may still be in the pipe; a grandchild holding the pipe open is the
        // only reason to give up waiting for it.
        if worker.eof.is_none() && at.elapsed() < Duration::from_secs(2) {
            exited = None;
        }
    }
    let mut result = match (&worker.done, exited) {
        (Some((done, _)), Some(_)) => from_done(worker.role, done),
        (None, Some(status)) => crashed(worker, status),
        (Some((done, at)), None) if worker.exited_at.is_none() && at.elapsed() > EXIT_GRACE => {
            let mut result = from_done(worker.role, done);
            let stuck = kill_and_reap(&mut worker.child);
            result.stuck = stuck.is_some();
            result.warnings.push(format!(
                "worker reported its result but did not exit within {}s{}",
                EXIT_GRACE.as_secs(),
                stuck.map(|s| format!(" - {s}")).unwrap_or_default()
            ));
            result
        }
        (None, None) if worker.exited_at.is_none() && worker.last_beat.elapsed() > hang_timeout => {
            let silent = worker.last_beat.elapsed().as_secs();
            let stuck = kill_and_reap(&mut worker.child);
            let mut result = outcome(worker.role, Status::Hang, format!("no progress for {silent}s"));
            if let Some(stuck) = stuck {
                result.detail = format!("no progress for {silent}s; {stuck}");
                result.stuck = true;
            }
            result
        }
        _ => return None,
    };
    result.warnings.splice(0..0, worker.warnings.drain(..));
    Some(result)
}

fn from_done(role: &'static str, done: &Msg) -> PartOutcome {
    let Msg::Done {
        verdict,
        detail,
        errors,
        samples,
    } = done
    else {
        unreachable!("only Done is stored as done")
    };
    let status = match verdict {
        WorkerVerdict::Ok => Status::Ok,
        WorkerVerdict::Error => Status::Error,
        WorkerVerdict::Skip => Status::Skip,
    };
    PartOutcome {
        errors: *errors,
        samples: samples.clone(),
        ..outcome(role, status, detail.clone())
    }
}

fn crashed(worker: &Running, status: ExitStatus) -> PartOutcome {
    let reason = if status.success() {
        "exited without reporting a result".to_string()
    } else {
        crate::isolate::crash_reason(Some(status))
    };
    let mut result = outcome(worker.role, Status::Crash, reason);
    result.samples = worker
        .stderr
        .lock()
        .unwrap_or_else(|e| e.into_inner())
        .iter()
        .cloned()
        .collect();
    result
}

/// SIGKILL, then a bounded reap. `Some` describes a child that would not die.
pub(crate) fn kill_and_reap(child: &mut Child) -> Option<String> {
    let _ = child.kill();
    let deadline = Instant::now() + REAP_GRACE;
    loop {
        match child.try_wait() {
            Ok(Some(_)) | Err(_) => return None,
            Ok(None) if Instant::now() >= deadline => {
                let pid = child.id();
                let read = |what: &str| std::fs::read_to_string(format!("/proc/{pid}/{what}")).ok();
                let state = read("status")
                    .and_then(|s| {
                        s.lines()
                            .find_map(|l| l.strip_prefix("State:"))
                            .map(|s| s.trim().to_string())
                    })
                    .unwrap_or_else(|| "unknown".into());
                if state.starts_with('Z') {
                    let _ = child.try_wait();
                    return None;
                }
                let wchan = read("wchan")
                    .map(|s| s.trim().to_string())
                    .filter(|s| !s.is_empty())
                    .unwrap_or_else(|| "unknown".into());
                let stack = read("stack")
                    .map(|s| {
                        format!(
                            ", kernel stack: {}",
                            s.split_whitespace()
                                .filter(|w| w.contains('+'))
                                .take(6)
                                .collect::<Vec<_>>()
                                .join(" <- ")
                        )
                    })
                    .unwrap_or_default();
                return Some(format!(
                    "pid {pid} survived SIGKILL in state {state}, blocked in {wchan}{stack}"
                ));
            }
            Ok(None) => std::thread::sleep(Duration::from_millis(20)),
        }
    }
}
