//! What goes on without a job: the list of kept runs, runs a terminal started, and what each module can do here.

use std::collections::HashSet;
use std::io::{Read, Seek, SeekFrom};
use std::process::{Command, Stdio};
use std::sync::Arc;
use std::time::{Duration, Instant};

use hodow_common::store::{EVENTS_FILE, Record};
use hodow_common::time::now_ms;
use hodow_common::{RunState, RunStatus};

use super::{AppState, Foreign};
use crate::probe::Availability;

const KEPT_RUNS: usize = 200;
const PROBE_TIMEOUT: Duration = Duration::from_secs(20);
const TAIL_CHUNK: u64 = 4 * 1024 * 1024;

pub fn spawn(state: Arc<AppState>) {
    set_static_probes(&state);
    probe_gpu_in_background(state.clone());
    std::thread::spawn(move || {
        loop {
            refresh_runs(&state);
            tail_foreign(&state);
            std::thread::sleep(Duration::from_secs(1));
        }
    });
}

pub fn refresh_runs(state: &AppState) {
    let mut runs = state.store.list();
    runs.truncate(KEPT_RUNS);
    let mut live = state.live();
    if live.runs != runs {
        live.runs = runs;
        drop(live);
        state.bump();
    }
}

fn tail_foreign(state: &AppState) {
    let mut live = state.live();
    let ours = live.active.as_ref().and_then(|a| a.job.run.clone());
    let running: Vec<_> = live
        .runs
        .iter()
        .filter(|r| r.status == RunStatus::Running && Some(&r.id) != ours.as_ref())
        .cloned()
        .collect();
    let ids: HashSet<&str> = running.iter().map(|r| r.id.as_str()).collect();
    let before = live.foreign.len();
    live.foreign.retain(|id, _| ids.contains(id.as_str()));
    let mut changed = live.foreign.len() != before;
    for meta in &running {
        let entry = live.foreign.entry(meta.id.clone()).or_insert_with(|| Foreign {
            state: RunState::new(meta.module.clone(), meta.title.clone(), meta.started_ms),
            offset: 0,
        });
        let Some(dir) = state.store.run_dir(&meta.id) else {
            continue;
        };
        if read_new(&dir.join(EVENTS_FILE), entry) {
            changed = true;
        }
    }
    drop(live);
    if changed {
        state.bump();
    }
}

/// Feeds the whole lines written since last time into the run's state. A partial last line waits for the next round.
fn read_new(path: &std::path::Path, run: &mut Foreign) -> bool {
    let Ok(mut file) = std::fs::File::open(path) else {
        return false;
    };
    if file.seek(SeekFrom::Start(run.offset)).is_err() {
        return false;
    }
    let mut buffer = Vec::new();
    if file.take(TAIL_CHUNK).read_to_end(&mut buffer).is_err() {
        return false;
    }
    let complete = buffer.iter().rposition(|b| *b == b'\n').map_or(0, |i| i + 1);
    let mut any = false;
    for line in buffer[..complete].split(|b| *b == b'\n').filter(|l| !l.is_empty()) {
        if let Ok(record) = serde_json::from_slice::<Record>(line) {
            run.state.apply(&record.event, record.t);
            any = true;
        }
    }
    run.offset += complete as u64;
    any
}

fn set_static_probes(state: &AppState) {
    let cpu = Availability::ok(
        format!(
            "{} extensions detected, {} tests",
            hodow_cpu::available_modes().len(),
            hodow_cpu::all_tests().len()
        ),
        Vec::new(),
    );
    let unix_only = |what: &str| {
        if cfg!(unix) {
            Availability::ok(what.to_string(), Vec::new())
        } else {
            Availability::unavailable("needs Unix process groups and signals; not available on this platform")
        }
    };
    let halves = crate::cts::built_in();
    let cts = if halves.is_empty() {
        Availability {
            state: "not_built".into(),
            detail: "built without --features cts_opengles, cts_opengl or cts_vulkan".into(),
            devices: Vec::new(),
        }
    } else {
        Availability::ok(format!("{} compiled in", halves.join(", ")), Vec::new())
    };
    let mut live = state.live();
    live.probes.insert("cts".into(), cts);
    live.probes.insert("cpu".into(), cpu.clone());
    live.probes.insert("stress".into(), cpu);
    live.probes.insert("burn".into(), unix_only("CPU, RAM and GPU load"));
    live.probes.insert("bench".into(), unix_only("kernel timings"));
}

/// Asks the GPU drivers what they can do, one process each. Returns false when a re-check is already under way.
pub fn probe_gpu_in_background(state: Arc<AppState>) -> bool {
    const KINDS: [&str; 2] = ["gl", "vulkan"];
    {
        let mut live = state.live();
        if live.probing {
            return false;
        }
        live.probing = true;
        for key in KINDS {
            live.probes.insert(
                key.into(),
                Availability {
                    state: "probing".into(),
                    detail: String::new(),
                    devices: Vec::new(),
                },
            );
        }
    }
    state.bump();
    std::thread::spawn(move || {
        for key in KINDS {
            let result = probe(&state, key);
            state.live().probes.insert(key.into(), result);
            state.bump();
        }
        let mut live = state.live();
        live.probing = false;
        live.probed_ms = Some(now_ms());
        drop(live);
        state.bump();
    });
    true
}

fn probe(state: &AppState, kind: &str) -> Availability {
    let mut command = Command::new(&state.exe);
    command
        .arg("probe")
        .arg(kind)
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::null());
    #[cfg(unix)]
    {
        use std::os::unix::process::CommandExt;
        command.process_group(0);
    }
    let mut child = match command.spawn() {
        Ok(c) => c,
        Err(e) => return Availability::failed(format!("could not start the probe: {e}")),
    };
    let began = Instant::now();
    let status = loop {
        match child.try_wait() {
            Ok(Some(status)) => break status,
            Ok(None) if began.elapsed() < PROBE_TIMEOUT => std::thread::sleep(Duration::from_millis(50)),
            Ok(None) => {
                let _ = child.kill();
                let _ = child.wait();
                return Availability::failed(format!(
                    "the probe did not finish in {} s - a driver that hangs on start-up",
                    PROBE_TIMEOUT.as_secs()
                ));
            }
            Err(e) => return Availability::failed(format!("could not wait for the probe: {e}")),
        }
    };
    if !status.success() {
        return Availability::failed(format!(
            "the probe crashed: {}",
            crate::isolate::crash_reason(Some(status))
        ));
    }
    let mut text = String::new();
    if let Some(mut out) = child.stdout.take() {
        let _ = out.read_to_string(&mut text);
    }
    text.lines()
        .rev()
        .find_map(|l| serde_json::from_str::<Availability>(l).ok())
        .unwrap_or_else(|| Availability::failed("the probe printed no answer"))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    #[expect(
        clippy::string_slice,
        reason = "every offset comes from a search of the same string, so it sits on a character boundary"
    )]
    fn only_whole_lines_are_consumed_and_the_rest_waits() {
        let dir = tempfile_dir();
        let path = dir.join("events.jsonl");
        let line = |name: &str| {
            let record = Record {
                t: 5,
                event: hodow_common::Event::Finding(hodow_common::Finding::new(name, hodow_common::Verdict::Failed)),
            };
            serde_json::to_string(&record).unwrap()
        };
        let half = &line("b")[..10];
        std::fs::write(&path, format!("{}\n{half}", line("a"))).unwrap();
        let mut run = Foreign {
            state: RunState::new("cpu", "CPU", 0),
            offset: 0,
        };
        assert!(read_new(&path, &mut run));
        assert_eq!(run.state.summary.failed, 1);
        assert!(!read_new(&path, &mut run), "nothing new yet");
        std::fs::write(&path, format!("{}\n{}\n", line("a"), line("b"))).unwrap();
        assert!(read_new(&path, &mut run));
        assert_eq!(run.state.summary.failed, 2);
    }

    fn tempfile_dir() -> std::path::PathBuf {
        let dir = std::env::temp_dir().join(format!("hodow-watch-{}-{}", std::process::id(), now_ms()));
        std::fs::create_dir_all(&dir).unwrap();
        dir
    }
}
