//! Sequential job executor: one FIFO queue, one job at a time.
//!
//! `Cpu` jobs run through the exact same per-test subprocess isolation as `hodow_cli cpu
//! --isolate` (see `isolate::run_isolated_core`) so a genuine hardware crash/hang can never
//! take down the server process itself - only the isolate worker subprocess dies, and it's
//! cheap to respawn (see `isolate.rs`'s module docs: one worker runs every test in-process,
//! a fresh one is only spawned when the current one actually crashes).
//!
//! `Gpu`/`Vulkan` jobs run as a **whole-process** subprocess instead (`run_subprocess_job`):
//! neither `test_all_opengl` nor `run_compute_validation` has a per-test crash-isolation
//! entry point like the CPU suite's `all_tests()`, so a crash/hang there is attributed to
//! the whole job rather than a specific test - still enough to guarantee the server process
//! itself is never at risk, just coarser-grained than the CPU path.
//!
//! `stress` jobs are deliberately NOT supported here: `stress::run_stress` runs entirely
//! in-process across pinned threads with no subprocess isolation, so a real crash there
//! would kill the server. If stress-as-a-job is wanted later, it needs the same whole-
//! process wrapping `Gpu`/`Vulkan` jobs get here.
//!
//! Runs on a plain OS thread (not a tokio task) since it's a blocking loop; `Store`/
//! `Broadcaster` are safe to call from here because they're guarded by `std::sync`
//! primitives, not tokio's.

use std::io::Read;
use std::process::{Command, Stdio};
use std::sync::Arc;
use std::sync::mpsc;
use std::thread;
use std::time::Duration;

use log::info;

use crate::cli::CpuArgs;
use crate::isolate::{Outcome, run_isolated_core};

use super::AppState;
use super::model::{GpuJobSpec, JobId, JobKind, JobStatus, JobSummary, TestOutcome, VulkanJobSpec};
use super::ws::WsMessage;

const POLL_INTERVAL: Duration = Duration::from_millis(500);
/// Whole-job timeout for Gpu/Vulkan jobs, which have no internal per-test isolation to fall
/// back on - a genuinely hung driver call would otherwise block the executor forever.
const SUBPROCESS_JOB_TIMEOUT: Duration = Duration::from_secs(300);

pub fn spawn_executor(state: Arc<AppState>) {
    thread::spawn(move || {
        loop {
            match state.store.queued_ids().into_iter().next() {
                Some(id) => run_job(&state, id),
                None => thread::sleep(POLL_INTERVAL),
            }
        }
    });
}

fn run_job(state: &AppState, id: JobId) {
    let Some(record) = state.store.get(id) else { return };

    info!("serve: starting job {id}");
    if let Err(e) = state.store.mark_started(id) {
        log::error!("serve: failed to persist job {id} start: {e}");
    }
    state.bus.send(WsMessage::JobStarted { id });

    let (status, summary) = match record.kind {
        JobKind::Cpu(spec) => run_cpu_job(state, id, &spec),
        JobKind::Gpu(spec) => run_subprocess_job(&gpu_argv(&spec), parse_gpu_summary),
        JobKind::Vulkan(spec) => run_subprocess_job(&vulkan_argv(&spec), parse_vulkan_summary),
    };

    info!("serve: job {id} finished: {status:?}");
    if let Err(e) = state.store.mark_finished(id, status.clone(), summary.clone()) {
        log::error!("serve: failed to persist job {id} completion: {e}");
    }
    state.bus.send(WsMessage::JobFinished { id, status, summary });
}

fn run_cpu_job(state: &AppState, id: JobId, spec: &super::model::CpuJobSpec) -> (JobStatus, JobSummary) {
    let args = CpuArgs {
        iterations: spec.iterations,
        list_modes: false,
        list_functions: false,
        test_function: spec.test_function.clone(),
        feature: spec.feature.clone(),
        skip: spec.skip.clone(),
        isolate: true,
        isolate_timeout_ms: spec.isolate_timeout_ms,
        stress: false,
        stress_secs: None,
        worker_start: None,
        submit_to: None,
    };

    let mut summary = JobSummary::default();
    let mut crash: Option<(usize, String)> = None;

    let result = run_isolated_core(&args, |idx, name, outcome| {
        let test_outcome = match outcome {
            Outcome::Pending => return,
            Outcome::Pass => {
                summary.passed += 1;
                TestOutcome::Pass
            }
            Outcome::Fail(msg) => {
                summary.failed += 1;
                TestOutcome::Fail(msg.clone())
            }
            Outcome::Panic => {
                summary.panicked += 1;
                TestOutcome::Panic
            }
            Outcome::Timeout => {
                summary.timed_out += 1;
                crash = Some((idx, name.to_string()));
                TestOutcome::Timeout
            }
            Outcome::Crashed => {
                summary.crashed += 1;
                crash = Some((idx, name.to_string()));
                TestOutcome::Crashed
            }
        };
        summary.total += 1;
        if let Err(e) = state.store.record_test(id, idx, name, test_outcome.clone()) {
            log::error!("serve: failed to persist test event for job {id}: {e}");
        }
        state.bus.send(WsMessage::JobProgress { id, idx, name: name.to_string(), outcome: test_outcome });
    });

    let status = match (result, crash) {
        (None, _) => JobStatus::Succeeded, // no tests matched the filter - nothing to fail on
        (Some(_), Some((culprit_index, culprit_test))) => JobStatus::Crashed { culprit_index: Some(culprit_index), culprit_test: Some(culprit_test) },
        (Some(_), None) if summary.failed > 0 || summary.panicked > 0 => JobStatus::Failed,
        (Some(_), None) => JobStatus::Succeeded,
    };
    (status, summary)
}

fn gpu_argv(spec: &GpuJobSpec) -> Vec<String> {
    let mut argv = vec!["gpu".to_string()];
    if spec.no_window {
        argv.push("-w".into());
    }
    if let Some(ms) = spec.time_limit_ms {
        argv.push("-t".into());
        argv.push(ms.to_string());
    }
    if let Some(f) = spec.frame_limit {
        argv.push("-f".into());
        argv.push(f.to_string());
    }
    if let Some(ref a) = spec.display_api {
        argv.push("-a".into());
        argv.push(a.clone());
    }
    if let Some(ref g) = spec.gl_api {
        argv.push("-g".into());
        argv.push(g.clone());
    }
    if spec.force_software {
        argv.push("-s".into());
    }
    if spec.memtest {
        argv.push("-m".into());
        if let Some(mb) = spec.memtest_mb {
            argv.push("--memtest-mb".into());
            argv.push(mb.to_string());
        }
    }
    argv
}

fn vulkan_argv(_spec: &VulkanJobSpec) -> Vec<String> {
    vec!["vulkan".to_string()]
}

/// "GL tests finished. Run: 40, Skipped: 0, Errors: 0"
fn parse_gpu_summary(stdout: &str) -> JobSummary {
    for line in stdout.lines() {
        if let Some(rest) = line.split_once("Run: ").map(|(_, r)| r) {
            let nums: Vec<usize> = rest.split(|c: char| !c.is_ascii_digit()).filter(|s| !s.is_empty()).filter_map(|s| s.parse().ok()).collect();
            if let [run, skipped, errors] = nums[..] {
                return JobSummary { total: run + skipped, passed: run.saturating_sub(errors), failed: errors, ..Default::default() };
            }
        }
    }
    JobSummary::default()
}

/// "Vulkan validation finished: 2 device(s), 0 error(s)"
fn parse_vulkan_summary(stdout: &str) -> JobSummary {
    for line in stdout.lines() {
        if line.contains("device(s)") && line.contains("error(s)") {
            let nums: Vec<usize> = line.split(|c: char| !c.is_ascii_digit()).filter(|s| !s.is_empty()).filter_map(|s| s.parse().ok()).collect();
            if let [devices, errors] = nums[..] {
                return JobSummary { total: devices, passed: devices.saturating_sub(errors), failed: errors, ..Default::default() };
            }
        }
    }
    JobSummary::default()
}

/// Runs `hodow_cli <argv>` as a whole subprocess and classifies the outcome: a clean exit
/// (any code) is `Succeeded`/`Failed` depending on whether it reported errors; dying to a
/// signal or exceeding `SUBPROCESS_JOB_TIMEOUT` is `Crashed` (no per-test culprit - see
/// module docs). This is the safety boundary for `Gpu`/`Vulkan` jobs: whatever happens to
/// the child, this function always returns rather than propagating a crash to the caller.
fn run_subprocess_job(argv: &[String], parse_summary: fn(&str) -> JobSummary) -> (JobStatus, JobSummary) {
    let exe = match std::env::current_exe() {
        Ok(e) => e,
        Err(e) => {
            log::error!("serve: failed to resolve current executable: {e}");
            return (JobStatus::Crashed { culprit_index: None, culprit_test: None }, JobSummary::default());
        }
    };

    let mut cmd = Command::new(&exe);
    cmd.args(argv);
    let mut child = match cmd.stdout(Stdio::piped()).stderr(Stdio::piped()).spawn() {
        Ok(c) => c,
        Err(e) => {
            log::error!("serve: failed to spawn subprocess job {argv:?}: {e}");
            return (JobStatus::Crashed { culprit_index: None, culprit_test: None }, JobSummary::default());
        }
    };

    let mut stdout_pipe = child.stdout.take().expect("child stdout");
    let (tx, rx) = mpsc::channel();
    thread::spawn(move || {
        let mut buf = String::new();
        let _ = stdout_pipe.read_to_string(&mut buf);
        let _ = tx.send(buf);
    });

    let status = match child.wait_timeout(SUBPROCESS_JOB_TIMEOUT) {
        Some(exit) => exit,
        None => {
            let _ = child.kill();
            let _ = child.wait();
            return (JobStatus::Crashed { culprit_index: None, culprit_test: None }, JobSummary::default());
        }
    };

    let stdout = rx.recv_timeout(Duration::from_secs(5)).unwrap_or_default();
    let summary = parse_summary(&stdout);

    #[cfg(unix)]
    {
        use std::os::unix::process::ExitStatusExt;
        if status.signal().is_some() {
            return (JobStatus::Crashed { culprit_index: None, culprit_test: None }, summary);
        }
    }

    if status.success() {
        (JobStatus::Succeeded, summary)
    } else {
        (JobStatus::Failed, summary)
    }
}

/// `std::process::Child` has no built-in wait-with-timeout; poll at a short interval instead
/// of pulling in a crate for it (the process either finishes in well under a second or is
/// genuinely hung, so polling granularity doesn't matter).
trait WaitTimeout {
    fn wait_timeout(&mut self, timeout: Duration) -> Option<std::process::ExitStatus>;
}

impl WaitTimeout for std::process::Child {
    fn wait_timeout(&mut self, timeout: Duration) -> Option<std::process::ExitStatus> {
        let deadline = std::time::Instant::now() + timeout;
        loop {
            if let Ok(Some(status)) = self.try_wait() {
                return Some(status);
            }
            if std::time::Instant::now() >= deadline {
                return None;
            }
            thread::sleep(Duration::from_millis(100));
        }
    }
}
