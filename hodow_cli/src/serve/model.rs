//! Job-queue data model. Kept dependency-light (only `serde`) so it's usable/testable
//! without pulling in `tokio`/`axum`.

use std::time::{SystemTime, UNIX_EPOCH};

use serde::{Deserialize, Serialize};

pub type JobId = u64;

pub fn now_ms() -> u64 {
    SystemTime::now().duration_since(UNIX_EPOCH).unwrap_or_default().as_millis() as u64
}

/// Same argument surface as `CpuArgs`, minus the flags that don't make sense as a queued
/// job (`stress` runs in-process with no subprocess isolation, so it's excluded for now -
/// see the module docs on `executor`; `worker_start` is an internal implementation detail).
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct CpuJobSpec {
    #[serde(default)]
    pub iterations: Option<usize>,
    #[serde(default)]
    pub test_function: Option<Vec<String>>,
    #[serde(default)]
    pub feature: Vec<String>,
    #[serde(default)]
    pub skip: Vec<String>,
    #[serde(default)]
    pub isolate_timeout_ms: Option<u64>,
}

/// Same argument surface as `GpuArgs`.
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct GpuJobSpec {
    #[serde(default)]
    pub no_window: bool,
    #[serde(default)]
    pub time_limit_ms: Option<u64>,
    #[serde(default)]
    pub frame_limit: Option<u64>,
    #[serde(default)]
    pub display_api: Option<String>,
    #[serde(default)]
    pub gl_api: Option<String>,
    #[serde(default)]
    pub force_software: bool,
    #[serde(default)]
    pub memtest: bool,
    #[serde(default)]
    pub memtest_mb: Option<usize>,
}

/// `VulkanArgs` has no fields today; kept as its own (empty) type rather than `()` so a
/// future field addition doesn't need a `JobKind` shape change.
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct VulkanJobSpec {}

/// Same argument surface as `stress::run_stress` reads off `CpuArgs` (just `stress_secs`).
#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct StressJobSpec {
    #[serde(default)]
    pub stress_secs: Option<u64>,
}

/// The kind of work a job represents. `Gpu`/`Vulkan`/`Stress` jobs run as a whole-process
/// subprocess (see `executor::run_subprocess_job`) rather than per-test isolation like `Cpu`:
/// none of `test_all_opengl`, `run_compute_validation`, or `stress::run_stress` have a
/// per-test crash-isolation entry point today (unlike the CPU suite's `all_tests()`/
/// `isolate.rs`), so a crash/hang is attributed to the whole job, not a specific test.
#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(tag = "kind", content = "spec", rename_all = "snake_case")]
pub enum JobKind {
    Cpu(CpuJobSpec),
    Gpu(GpuJobSpec),
    Vulkan(VulkanJobSpec),
    Stress(StressJobSpec),
}

/// Terminal (and non-terminal) states a job can be in. Three distinct failure-ish states
/// matter: `Failed` (ran fine, wrong result), `Crashed` (something took the job's process
/// down - for `Cpu` jobs the specific culprit test is known via isolate.rs; for `Gpu`/
/// `Vulkan` jobs only the whole-job outcome is), and `Interrupted` (the *server process
/// itself* died before the job finished - detected at startup, see `store::Store::open`).
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
#[serde(tag = "status", rename_all = "snake_case")]
pub enum JobStatus {
    Queued,
    Running,
    Succeeded,
    Failed,
    Crashed { culprit_index: Option<usize>, culprit_test: Option<String> },
    Interrupted,
    Cancelled,
}

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
pub struct JobSummary {
    pub total: usize,
    pub passed: usize,
    pub failed: usize,
    pub panicked: usize,
    pub timed_out: usize,
    pub crashed: usize,
}

/// The durable, index-wide record for one job. Deliberately holds only aggregate counts
/// (`JobSummary`), never the full per-test list - that stays in the job's own event log
/// (`store::Store::read_events`) so the index stays small and cheap to load in full at
/// every server startup regardless of how many tests a job ran.
#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct JobRecord {
    pub id: JobId,
    pub kind: JobKind,
    pub status: JobStatus,
    pub submitted_at_ms: u64,
    pub started_at_ms: Option<u64>,
    pub finished_at_ms: Option<u64>,
    pub summary: JobSummary,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub enum TestOutcome {
    Pass,
    Fail(String),
    Panic,
    Timeout,
    /// Carries the signal name / exit status - see `isolate::crash_reason`. Records written
    /// before this carried a reason were a bare `"Crashed"` string and no longer deserialize;
    /// `Store::read_events` already skips lines it cannot parse.
    Crashed(String),
}

/// One line of a job's `jobs/<id>.jsonl` event log.
#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(tag = "type", rename_all = "snake_case")]
pub enum JobEvent {
    Queued { kind: JobKind, ts_ms: u64 },
    Started { ts_ms: u64 },
    Test { idx: usize, name: String, outcome: TestOutcome, ts_ms: u64 },
    Finished { status: JobStatus, summary: JobSummary, ts_ms: u64 },
}
