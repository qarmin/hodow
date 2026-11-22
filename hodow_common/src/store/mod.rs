mod reader;
pub mod retention;
mod writer;

use std::io;
use std::path::{Path, PathBuf};

pub use reader::Events;
use serde::{Deserialize, Serialize};
pub use writer::RunWriter;

use crate::event::{Event, RunStatus, Summary};
use crate::time::{now_ms, timestamp};

pub const META_FILE: &str = "meta.json";
pub const EVENTS_FILE: &str = "events.jsonl";
pub const EVENTS_GZ_FILE: &str = "events.jsonl.gz";
const PINNED_FILE: &str = "pinned";
/// A run still marked running whose event file has been silent this long died without saying so.
/// Set by `hodow serve` in the environment of every job it starts.
pub const SERVER_JOB_ENV: &str = "HODOW_SERVER_JOB";
pub const STALE_AFTER_MS: u64 = 60 * 60 * 1000;

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct RunMeta {
    pub id: String,
    pub module: String,
    pub title: String,
    #[serde(default)]
    pub args: Vec<String>,
    pub started_ms: u64,
    #[serde(default)]
    pub finished_ms: Option<u64>,
    pub status: RunStatus,
    #[serde(default)]
    pub summary: Option<Summary>,
    pub version: String,
    pub os: String,
    pub arch: String,
    #[serde(default)]
    pub host: Option<String>,
    /// The process writing the run, and whether a `hodow serve` job started it: how a later server finds what it left behind.
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub pid: Option<u32>,
    #[serde(default, skip_serializing_if = "std::ops::Not::not")]
    pub by_server: bool,
}

/// One line of a result file: the event and when it was recorded.
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Record {
    pub t: u64,
    #[serde(flatten)]
    pub event: Event,
}

/// Ids arrive from outside once a server exposes them, so only plain names are accepted.
pub fn is_valid_id(id: &str) -> bool {
    !id.is_empty()
        && id != "."
        && !id.starts_with('.')
        && id
            .bytes()
            .all(|b| b.is_ascii_alphanumeric() || matches!(b, b'-' | b'_' | b'.'))
}

pub struct Store {
    dir: PathBuf,
}

impl Store {
    pub fn new(results_dir: impl Into<PathBuf>) -> Self {
        Self {
            dir: results_dir.into(),
        }
    }

    pub fn dir(&self) -> &Path {
        &self.dir
    }

    pub fn run_dir(&self, id: &str) -> Option<PathBuf> {
        is_valid_id(id).then(|| self.dir.join(id))
    }

    pub fn create_run(&self, module: &str, title: &str, args: &[String]) -> io::Result<RunWriter> {
        let stem = format!("{}-{module}", timestamp());
        let mut id = stem.clone();
        let mut n = 1;
        while self.dir.join(&id).exists() {
            n += 1;
            id = format!("{stem}-{n}");
        }
        self.open_run(RunMeta {
            id,
            module: module.to_owned(),
            title: title.to_owned(),
            args: args.to_vec(),
            started_ms: now_ms(),
            finished_ms: None,
            status: RunStatus::Running,
            summary: None,
            version: env!("CARGO_PKG_VERSION").to_owned(),
            os: std::env::consts::OS.to_owned(),
            arch: std::env::consts::ARCH.to_owned(),
            host: host_name(),
            pid: Some(std::process::id()),
            by_server: std::env::var_os(SERVER_JOB_ENV).is_some(),
        })
    }

    pub fn open_run(&self, meta: RunMeta) -> io::Result<RunWriter> {
        let dir = self
            .run_dir(&meta.id)
            .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidInput, "invalid run id"))?;
        std::fs::create_dir_all(&dir)?;
        RunWriter::create(dir, meta)
    }

    pub fn meta(&self, id: &str) -> Option<RunMeta> {
        let dir = self.run_dir(id)?;
        let mut meta: RunMeta = serde_json::from_slice(&std::fs::read(dir.join(META_FILE)).ok()?).ok()?;
        if meta.status == RunStatus::Running && is_stale(&dir, now_ms()) {
            meta.status = RunStatus::Interrupted;
        }
        Some(meta)
    }

    /// Newest first. A directory without a readable `meta.json` is not a run and is skipped.
    pub fn list(&self) -> Vec<RunMeta> {
        let Ok(entries) = std::fs::read_dir(&self.dir) else {
            return Vec::new();
        };
        let mut runs: Vec<RunMeta> = entries
            .filter_map(Result::ok)
            .filter_map(|e| self.meta(e.file_name().to_str()?))
            .collect();
        runs.sort_by(|a, b| b.started_ms.cmp(&a.started_ms).then_with(|| b.id.cmp(&a.id)));
        runs
    }

    pub fn read_events(&self, id: &str) -> io::Result<Events> {
        let dir = self
            .run_dir(id)
            .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidInput, "invalid run id"))?;
        Events::open(&dir)
    }

    pub fn is_pinned(&self, id: &str) -> bool {
        self.run_dir(id).is_some_and(|d| d.join(PINNED_FILE).exists())
    }

    pub fn pin(&self, id: &str, pinned: bool) -> io::Result<()> {
        let dir = self
            .run_dir(id)
            .filter(|d| d.is_dir())
            .ok_or_else(|| io::Error::new(io::ErrorKind::NotFound, "no such run"))?;
        let marker = dir.join(PINNED_FILE);
        if pinned {
            std::fs::write(marker, b"")
        } else {
            match std::fs::remove_file(marker) {
                Err(e) if e.kind() != io::ErrorKind::NotFound => Err(e),
                _ => Ok(()),
            }
        }
    }

    pub fn remove(&self, id: &str) -> io::Result<()> {
        let dir = self
            .run_dir(id)
            .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidInput, "invalid run id"))?;
        std::fs::remove_dir_all(dir)
    }

    /// Gives a run its final status when whoever was writing it is gone (killed on purpose, say). Does nothing for a run
    /// that already finished.
    pub fn finish_abandoned(&self, id: &str, status: RunStatus) -> io::Result<()> {
        let dir = self
            .run_dir(id)
            .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidInput, "invalid run id"))?;
        let mut meta: RunMeta =
            serde_json::from_slice(&std::fs::read(dir.join(META_FILE))?).map_err(io::Error::other)?;
        if meta.status != RunStatus::Running {
            return Ok(());
        }
        meta.status = status;
        meta.finished_ms = Some(last_activity_ms(&dir).unwrap_or_else(now_ms));
        writer::write_meta(&dir, &meta)
    }

    /// Records the interruption of runs that died without finishing, so the next reader sees the real status on disk.
    pub fn reap_stale(&self) -> usize {
        let mut reaped = 0;
        let Ok(entries) = std::fs::read_dir(&self.dir) else {
            return 0;
        };
        for entry in entries.filter_map(Result::ok) {
            let dir = entry.path();
            let Ok(bytes) = std::fs::read(dir.join(META_FILE)) else {
                continue;
            };
            let Ok(mut meta) = serde_json::from_slice::<RunMeta>(&bytes) else {
                continue;
            };
            if meta.status == RunStatus::Running && is_stale(&dir, now_ms()) {
                meta.status = RunStatus::Interrupted;
                meta.finished_ms = Some(last_activity_ms(&dir).unwrap_or_else(now_ms));
                if writer::write_meta(&dir, &meta).is_ok() {
                    reaped += 1;
                }
            }
        }
        reaped
    }
}

fn last_activity_ms(dir: &Path) -> Option<u64> {
    [EVENTS_FILE, EVENTS_GZ_FILE, META_FILE]
        .iter()
        .filter_map(|f| std::fs::metadata(dir.join(f)).ok()?.modified().ok())
        .max()
        .and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())
        .map(|d| d.as_millis() as u64)
}

fn is_stale(dir: &Path, now: u64) -> bool {
    last_activity_ms(dir).is_some_and(|t| now.saturating_sub(t) > STALE_AFTER_MS)
}

#[cfg(unix)]
fn host_name() -> Option<String> {
    let mut buf = [0u8; 256];
    let rc = unsafe { libc::gethostname(buf.as_mut_ptr().cast(), buf.len() - 1) };
    if rc != 0 {
        return None;
    }
    let len = buf.iter().position(|b| *b == 0).unwrap_or(buf.len());
    Some(String::from_utf8_lossy(&buf[..len]).into_owned()).filter(|s| !s.is_empty())
}

#[cfg(not(unix))]
fn host_name() -> Option<String> {
    std::env::var("COMPUTERNAME").ok().filter(|s| !s.is_empty())
}

#[cfg(test)]
mod tests;
