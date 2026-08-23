//! Sequential job executor: one FIFO queue, one job at a time, run through the exact same
//! per-test subprocess isolation as `hodow_cli cpu --isolate` (see `isolate::run_isolated_core`)
//! so a genuine hardware crash/hang during a queued job can never take down the server
//! process itself - only the isolate worker subprocess dies, and it's cheap to respawn
//! (see `isolate.rs`'s module docs: one worker runs every test in-process, a fresh one is
//! only spawned when the current one actually crashes).
//!
//! `stress` jobs are deliberately NOT supported here: `stress::run_stress` runs entirely
//! in-process across pinned threads with no subprocess isolation, so a real crash there
//! would kill the server. If stress-as-a-job is wanted later, it needs its own subprocess
//! indirection first.
//!
//! Runs on a plain OS thread (not a tokio task) since it's a blocking loop; `Store`/
//! `Broadcaster` are safe to call from here because they're guarded by `std::sync`
//! primitives, not tokio's.

use std::sync::Arc;
use std::thread;
use std::time::Duration;

use log::info;

use crate::cli::CpuArgs;
use crate::isolate::{Outcome, run_isolated_core};

use super::AppState;
use super::model::{JobId, JobKind, JobStatus, JobSummary, TestOutcome};
use super::ws::WsMessage;

const POLL_INTERVAL: Duration = Duration::from_millis(500);

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
    let JobKind::Cpu(spec) = record.kind;

    info!("serve: starting job {id}");
    if let Err(e) = state.store.mark_started(id) {
        log::error!("serve: failed to persist job {id} start: {e}");
    }
    state.bus.send(WsMessage::JobStarted { id });

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
        (Some(_), Some((culprit_index, culprit_test))) => JobStatus::Crashed { culprit_index, culprit_test },
        (Some(_), None) if summary.failed > 0 || summary.panicked > 0 => JobStatus::Failed,
        (Some(_), None) => JobStatus::Succeeded,
    };

    info!("serve: job {id} finished: {status:?}");
    if let Err(e) = state.store.mark_finished(id, status.clone(), summary.clone()) {
        log::error!("serve: failed to persist job {id} completion: {e}");
    }
    state.bus.send(WsMessage::JobFinished { id, status, summary });
}
