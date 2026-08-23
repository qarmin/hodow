//! Job queue/history persistence: flat JSON/JSONL files only, no embedded database (the
//! project must stay cross-compilable without native C/C++ dependencies, which rules out
//! e.g. `rusqlite`'s bundled SQLite).
//!
//! Layout under `<data-dir>/`:
//!   index.json        - one `JobRecord` per job ever submitted (status + summary only,
//!                        never per-test detail), rewritten atomically (write-tmp + rename)
//!                        on every state transition. Loaded in full at startup.
//!   jobs/<id>.jsonl    - append-only `JobEvent` log for that job, read only on demand when
//!                        a client asks for that job's detail.

use std::fs;
use std::io::Write;
use std::path::PathBuf;
use std::sync::RwLock;

use serde::{Deserialize, Serialize};

use super::model::{JobEvent, JobId, JobKind, JobRecord, JobStatus, JobSummary, now_ms};

#[derive(Serialize, Deserialize, Default)]
struct IndexFile {
    next_job_id: JobId,
    jobs: Vec<JobRecord>,
}

pub struct Store {
    dir: PathBuf,
    next_id: RwLock<JobId>,
    jobs: RwLock<Vec<JobRecord>>,
}

impl Store {
    /// Opens (or creates) the store at `dir`. Any job left `Running` in the index - the
    /// server died before it could record a `Finished` event - is reclassified to
    /// `Interrupted` right here, before any HTTP traffic is served.
    pub fn open(dir: PathBuf) -> std::io::Result<Self> {
        fs::create_dir_all(dir.join("jobs"))?;
        let index_path = dir.join("index.json");
        let mut index: IndexFile = if index_path.exists() {
            serde_json::from_str(&fs::read_to_string(&index_path)?).unwrap_or_default()
        } else {
            IndexFile::default()
        };

        let mut changed = false;
        for job in &mut index.jobs {
            if job.status == JobStatus::Running {
                job.status = JobStatus::Interrupted;
                job.finished_at_ms = Some(now_ms());
                changed = true;
            }
        }

        let store = Store { dir, next_id: RwLock::new(index.next_job_id), jobs: RwLock::new(index.jobs) };
        if changed {
            store.persist_index()?;
        }
        Ok(store)
    }

    fn persist_index(&self) -> std::io::Result<()> {
        let index = IndexFile { next_job_id: *self.next_id.read().unwrap(), jobs: self.jobs.read().unwrap().clone() };
        let text = serde_json::to_string_pretty(&index).unwrap_or_default();
        let tmp = self.dir.join("index.json.tmp");
        fs::write(&tmp, text)?;
        fs::rename(&tmp, self.dir.join("index.json"))
    }

    fn append_event(&self, id: JobId, event: &JobEvent) -> std::io::Result<()> {
        let path = self.dir.join("jobs").join(format!("{id}.jsonl"));
        let mut f = fs::OpenOptions::new().create(true).append(true).open(path)?;
        writeln!(f, "{}", serde_json::to_string(event).unwrap_or_default())?;
        f.flush()
    }

    /// Enqueue a new job. The id is only handed back after `index.json` is durably written,
    /// so a crash right after this call never hands out an id that vanishes on restart.
    pub fn submit(&self, kind: JobKind) -> std::io::Result<JobId> {
        let id = {
            let mut next = self.next_id.write().unwrap();
            let id = *next;
            *next += 1;
            id
        };
        let record = JobRecord {
            id,
            kind: kind.clone(),
            status: JobStatus::Queued,
            submitted_at_ms: now_ms(),
            started_at_ms: None,
            finished_at_ms: None,
            summary: JobSummary::default(),
        };
        self.jobs.write().unwrap().push(record);
        self.persist_index()?;
        self.append_event(id, &JobEvent::Queued { kind, ts_ms: now_ms() })?;
        Ok(id)
    }

    pub fn mark_started(&self, id: JobId) -> std::io::Result<()> {
        {
            let mut jobs = self.jobs.write().unwrap();
            if let Some(j) = jobs.iter_mut().find(|j| j.id == id) {
                j.status = JobStatus::Running;
                j.started_at_ms = Some(now_ms());
            }
        }
        self.persist_index()?;
        self.append_event(id, &JobEvent::Started { ts_ms: now_ms() })
    }

    pub fn record_test(&self, id: JobId, idx: usize, name: &str, outcome: super::model::TestOutcome) -> std::io::Result<()> {
        self.append_event(id, &JobEvent::Test { idx, name: name.to_string(), outcome, ts_ms: now_ms() })
    }

    pub fn mark_finished(&self, id: JobId, status: JobStatus, summary: JobSummary) -> std::io::Result<()> {
        {
            let mut jobs = self.jobs.write().unwrap();
            if let Some(j) = jobs.iter_mut().find(|j| j.id == id) {
                j.status = status.clone();
                j.finished_at_ms = Some(now_ms());
                j.summary = summary.clone();
            }
        }
        self.persist_index()?;
        self.append_event(id, &JobEvent::Finished { status, summary, ts_ms: now_ms() })
    }

    /// Ids of every job still `Queued`, in FIFO (submission) order.
    pub fn queued_ids(&self) -> Vec<JobId> {
        self.jobs.read().unwrap().iter().filter(|j| j.status == JobStatus::Queued).map(|j| j.id).collect()
    }

    pub fn snapshot(&self) -> Vec<JobRecord> {
        self.jobs.read().unwrap().clone()
    }

    pub fn get(&self, id: JobId) -> Option<JobRecord> {
        self.jobs.read().unwrap().iter().find(|j| j.id == id).cloned()
    }

    /// Reads a job's full event log from disk. Never held in memory otherwise - only
    /// fetched lazily when a client asks for one job's detail. Tolerates a truncated
    /// trailing line (e.g. a crash mid-write).
    pub fn read_events(&self, id: JobId) -> Vec<JobEvent> {
        let path = self.dir.join("jobs").join(format!("{id}.jsonl"));
        let Ok(text) = fs::read_to_string(path) else { return Vec::new() };
        text.lines().filter_map(|l| serde_json::from_str(l).ok()).collect()
    }

    /// Cancels a still-`Queued` job. Returns false if it's not queued anymore (already
    /// running/finished) - the caller is responsible for killing a running job's worker.
    pub fn cancel_queued(&self, id: JobId) -> bool {
        let cancelled = {
            let mut jobs = self.jobs.write().unwrap();
            match jobs.iter_mut().find(|j| j.id == id && j.status == JobStatus::Queued) {
                Some(j) => {
                    j.status = JobStatus::Cancelled;
                    j.finished_at_ms = Some(now_ms());
                    true
                }
                None => false,
            }
        };
        if cancelled {
            let _ = self.persist_index();
            let _ = self.append_event(id, &JobEvent::Finished { status: JobStatus::Cancelled, summary: JobSummary::default(), ts_ms: now_ms() });
        }
        cancelled
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn temp_dir() -> PathBuf {
        use std::sync::atomic::{AtomicU64, Ordering};
        static COUNTER: AtomicU64 = AtomicU64::new(0);
        let n = COUNTER.fetch_add(1, Ordering::Relaxed);
        std::env::temp_dir().join(format!("hodow_store_test_{}_{n}", now_ms()))
    }

    #[test]
    fn submit_and_reload_reconstructs_state() {
        let dir = temp_dir();
        let store = Store::open(dir.clone()).unwrap();
        let id = store.submit(JobKind::Cpu(super::super::model::CpuJobSpec::default())).unwrap();
        store.mark_started(id).unwrap();

        // Simulate a crash: server dies while the job is "Running", never reaches Finished.
        drop(store);
        let reopened = Store::open(dir.clone()).unwrap();
        let record = reopened.get(id).unwrap();
        assert_eq!(record.status, JobStatus::Interrupted);

        fs::remove_dir_all(&dir).ok();
    }

    #[test]
    fn cancel_only_affects_queued_jobs() {
        let dir = temp_dir();
        let store = Store::open(dir.clone()).unwrap();
        let id = store.submit(JobKind::Cpu(super::super::model::CpuJobSpec::default())).unwrap();
        assert!(store.cancel_queued(id));
        assert_eq!(store.get(id).unwrap().status, JobStatus::Cancelled);
        // Already cancelled -> cancelling again is a no-op (not queued anymore).
        assert!(!store.cancel_queued(id));

        fs::remove_dir_all(&dir).ok();
    }
}
