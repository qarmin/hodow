use std::collections::{HashMap, HashSet};
use std::io;
use std::path::{Path, PathBuf};
use std::time::UNIX_EPOCH;

use super::Store;
use crate::datadir::DataDir;
use crate::event::RunStatus;

pub const DEFAULT_LIMIT_BYTES: u64 = 5 * 1024 * 1024 * 1024;

#[derive(Debug, Default, PartialEq, Eq)]
pub struct RetentionReport {
    pub removed: Vec<String>,
    pub freed: u64,
    pub remaining: u64,
    /// Still above the limit once nothing else was allowed to go (running, pinned, newest-per-module).
    pub over_limit: bool,
}

struct Candidate {
    path: PathBuf,
    label: String,
    bytes: u64,
    time_ms: u64,
}

pub fn size_of(path: &Path) -> u64 {
    let Ok(meta) = std::fs::symlink_metadata(path) else {
        return 0;
    };
    if !meta.is_dir() {
        return meta.len();
    }
    std::fs::read_dir(path)
        .map(|entries| entries.filter_map(Result::ok).map(|e| size_of(&e.path())).sum())
        .unwrap_or(0)
}

fn mtime_ms(path: &Path) -> u64 {
    std::fs::metadata(path)
        .and_then(|m| m.modified())
        .ok()
        .and_then(|t| t.duration_since(UNIX_EPOCH).ok())
        .map_or(0, |d| d.as_millis() as u64)
}

fn run_candidates(store: &Store) -> Vec<Candidate> {
    let runs = store.list();
    let mut newest_finished: HashMap<&str, &str> = HashMap::new();
    for run in runs.iter().filter(|r| r.status.is_finished()) {
        newest_finished.entry(run.module.as_str()).or_insert(run.id.as_str());
    }
    let keep: HashSet<&str> = newest_finished.values().copied().collect();
    runs.iter()
        .filter(|r| r.status != RunStatus::Running && !keep.contains(r.id.as_str()) && !store.is_pinned(&r.id))
        .filter_map(|r| {
            let path = store.run_dir(&r.id)?;
            Some(Candidate {
                bytes: size_of(&path),
                path,
                label: r.id.clone(),
                time_ms: r.started_ms,
            })
        })
        .collect()
}

/// Every plain log file except the newest in each directory; symlinks such as `<command>-last.log` are left alone.
fn log_candidates(dir: &Path, out: &mut Vec<Candidate>) {
    let Ok(entries) = std::fs::read_dir(dir) else { return };
    let mut files = Vec::new();
    for entry in entries.filter_map(Result::ok) {
        let path = entry.path();
        match entry.file_type() {
            Ok(t) if t.is_dir() => log_candidates(&path, out),
            Ok(t) if t.is_file() => files.push((mtime_ms(&path), path)),
            _ => {}
        }
    }
    files.sort_by_key(|(t, _)| std::cmp::Reverse(*t));
    for (time_ms, path) in files.into_iter().skip(1) {
        out.push(Candidate {
            bytes: size_of(&path),
            label: path.display().to_string(),
            path,
            time_ms,
        });
    }
}

/// Deletes the oldest finished runs and old logs until the whole data directory fits `limit_bytes`.
pub fn enforce(dir: &DataDir, limit_bytes: u64) -> io::Result<RetentionReport> {
    let store = Store::new(dir.results());
    store.reap_stale();
    let mut remaining = size_of(dir.root());
    let mut report = RetentionReport::default();
    let mut candidates = run_candidates(&store);
    log_candidates(&dir.logs(), &mut candidates);
    candidates.sort_by_key(|c| c.time_ms);
    for candidate in candidates {
        if remaining <= limit_bytes {
            break;
        }
        let removed = if candidate.path.is_dir() {
            std::fs::remove_dir_all(&candidate.path)
        } else {
            std::fs::remove_file(&candidate.path)
        };
        if removed.is_ok() {
            remaining = remaining.saturating_sub(candidate.bytes);
            report.freed += candidate.bytes;
            report.removed.push(candidate.label);
        }
    }
    report.remaining = remaining;
    report.over_limit = remaining > limit_bytes;
    Ok(report)
}
