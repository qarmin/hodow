// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// What a campaign leaves on disk, and where.
//
// Everything here is written on the assumption that the machine can vanish between two
// statements - that is the subject under test, not a remote possibility. So: the
// in-flight record is fsynced before the work it describes begins, `state.json` is
// replaced rather than rewritten in place, and the append-only files are flushed per
// record. The cost is a handful of syscalls against cases measured in milliseconds.
//
// Times are stored as epoch seconds and never formatted as a clock by this binary.
// A board's timezone is whatever the image shipped with, and a wrong local time in a
// filename is worse than no local time; `status` reports ages relative to now, which
// needs no timezone, and the timestamped directory name comes from the shell that
// started the campaign, where `date` already knows where it is.

use std::io::Write;
use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

/// The base directory holding every campaign on this machine, plus the knowledge
/// (baseline, quarantine) that outlives any one of them.
///
/// Inside a checkout that is `tmp/cts-fuzz`, which is git-ignored and where every other
/// artefact in this repo already goes. Anywhere else - i.e. on a board, where the
/// binary sits in a home directory and there is no repo - it is `~/hodow-cts-fuzz`.
/// Deliberately never `/tmp`: on a Yocto image that is a tmpfs, and a journal that does
/// not survive a reset is the one thing this whole mechanism exists to avoid.
pub fn default_base_dir() -> PathBuf {
    if Path::new("hodow_cts/Cargo.toml").is_file() && Path::new(".git").exists() {
        return PathBuf::from("tmp/cts-fuzz");
    }
    match std::env::var_os("HOME") {
        Some(home) => PathBuf::from(home).join("hodow-cts-fuzz"),
        None => PathBuf::from("hodow-cts-fuzz"),
    }
}

/// Everything about a campaign that is fixed when it is created.
///
/// `pools` carries a fingerprint per API rather than one for the whole run: the epoch
/// permutation is built per pool, so it is a change to *that* pool that makes a stored
/// seed name a different group. There is no source-commit field - the fingerprint is
/// the thing that actually matters and is available on a board, where there is no git.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Campaign {
    pub label: String,
    pub created_epoch: u64,
    pub hodow_cts_version: String,
    pub upstream_revision: String,
    pub seed: u64,
    pub group_size: usize,
    pub case_filters: Vec<String>,
    pub exclude_filters: Vec<String>,
    pub device_id: usize,
    pub validation: bool,
    pub timeout_secs: u64,
    pub wedge_threshold: usize,
    /// How many times a finding's list is re-run before anything is believed about it.
    #[serde(default = "default_repro_attempts")]
    pub repro_attempts: u32,
    /// Recorded rather than taken from the command line on every resume, so a campaign
    /// started with `--no-quarantine` keeps drawing from the whole pool when it is
    /// picked up again - otherwise its later groups would not match its earlier ones.
    #[serde(default = "default_true")]
    pub use_quarantine: bool,
    /// Oracle calls one finding's minimisation may spend before it is parked.
    #[serde(default = "default_minimize_budget")]
    pub minimize_budget: u32,
    /// How many times one process runs the whole group over, to accumulate state.
    #[serde(default = "default_one_u32")]
    pub repeats: u32,
    /// How many separate processes run the identical group, to catch a verdict that
    /// does not hold still.
    #[serde(default = "default_one_u32")]
    pub replicas: u32,
    /// Workers sharing the driver at once.
    #[serde(default = "default_one_usize")]
    pub jobs: usize,
    pub pools: Vec<PoolInfo>,
}

fn default_repro_attempts() -> u32 {
    3
}

fn default_true() -> bool {
    true
}

fn default_minimize_budget() -> u32 {
    200
}

fn default_one_u32() -> u32 {
    1
}

fn default_one_usize() -> usize {
    1
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PoolInfo {
    pub root: String,
    pub cases: usize,
    pub fingerprint: u64,
}

/// Where the campaign is, and why it stopped if it did. Replaced after every group.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct State {
    pub apis: Vec<ApiState>,
    /// Round-robin cursor into `apis`, so the roots interleave rather than one root
    /// running to exhaustion before the next is touched.
    pub next_api: usize,
    pub iterations: u64,
    pub findings: u32,
    /// Reset by any group that completes without dying. The threshold on this is what
    /// separates "a bug" from "the driver is gone and every result since is noise".
    pub consecutive_crashes: usize,
    pub stopped: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ApiState {
    pub root: String,
    pub epoch: u64,
    pub epoch_seed: u64,
    /// Index of the next group within this epoch's permutation.
    pub group: usize,
}

/// One line of `iterations.jsonl`: what a group was, and what it did.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IterationRecord {
    pub n: u64,
    pub api: String,
    pub epoch: u64,
    pub epoch_seed: u64,
    pub group: usize,
    pub size: usize,
    pub outcome: String,
    pub passed: usize,
    pub failed: usize,
    pub not_supported: usize,
    pub warnings: usize,
    pub crashed: usize,
    pub other: usize,
    pub culprit: Option<String>,
    pub finding: Option<u32>,
    pub duration_s: f64,
}

/// The record that exists only while a group is running.
///
/// Written and fsynced *before* the work starts, removed after it finishes. Finding one
/// at start-up is the only evidence that the previous process did not get to finish -
/// after a power cut there is nothing else left. It holds no case list: the group is
/// regenerable from `(epoch_seed, group, size)` against a pool of the recorded
/// fingerprint, and materialising 130 KB per group would be the one write that made
/// this expensive.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Inflight {
    pub phase: String,
    pub started_epoch: u64,
    pub api: String,
    pub epoch: u64,
    pub epoch_seed: u64,
    pub group: usize,
    pub size: usize,
    pub pool_fingerprint: u64,
    /// Set when the phase is about an existing finding rather than a fresh group - a
    /// reproduction attempt is itself something that can take the machine down, and it
    /// has to be attributable to the finding it was attempting.
    #[serde(default)]
    pub finding: Option<u32>,
}

/// A crash, a hang, or a machine that never came back.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Finding {
    pub id: u32,
    pub kind: String,
    /// Only a human knows this, and only after the fact - it arrives with the resume
    /// verb (`fuzz gpucrash` / `fuzz systemcrash`), never from the fuzzer's own guess.
    pub severity: Option<String>,
    pub detected_epoch: u64,
    pub api: String,
    pub epoch: u64,
    pub epoch_seed: u64,
    pub group: usize,
    pub size: usize,
    pub culprit: Option<String>,
    pub message: String,
    /// How many cases had reported before things went wrong.
    pub completed: usize,
    /// False when `completed` was recovered from the progress file after a hard death,
    /// which the kernel is free to have truncated - the prefix is then a lower bound,
    /// not a fact, and nothing downstream may treat it as one.
    pub completed_exact: bool,
    /// How the prefix behaved when it was run again. `attempts: 0` means nothing was
    /// asked yet, which is not the same as "it did not reproduce".
    #[serde(default)]
    pub repro: super::triage::ReproReport,
}

/// One campaign's directory.
pub struct Store {
    pub dir: PathBuf,
}

impl Store {
    pub fn new(dir: PathBuf) -> Self {
        Self { dir }
    }

    pub fn campaign_path(&self) -> PathBuf {
        self.dir.join("campaign.json")
    }
    pub fn state_path(&self) -> PathBuf {
        self.dir.join("state.json")
    }
    pub fn inflight_path(&self) -> PathBuf {
        self.dir.join("inflight.json")
    }
    pub fn progress_path(&self) -> PathBuf {
        self.dir.join("inflight-progress.txt")
    }
    pub fn iterations_path(&self) -> PathBuf {
        self.dir.join("iterations.jsonl")
    }
    pub fn journal_path(&self) -> PathBuf {
        self.dir.join("journal.jsonl")
    }
    pub fn findings_dir(&self) -> PathBuf {
        self.dir.join("findings")
    }

    pub fn create(&self, campaign: &Campaign) -> std::io::Result<()> {
        std::fs::create_dir_all(self.findings_dir())?;
        write_atomic(&self.campaign_path(), &to_json(campaign)?)
    }

    pub fn read_campaign(&self) -> std::io::Result<Campaign> {
        read_json(&self.campaign_path())
    }

    pub fn read_state(&self) -> std::io::Result<State> {
        read_json(&self.state_path())
    }

    pub fn write_state(&self, state: &State) -> std::io::Result<()> {
        write_atomic(&self.state_path(), &to_json(state)?)
    }

    /// Records what is about to run, durably, before it runs.
    ///
    /// The fsync is the entire point: without it the record lives in the page cache and
    /// a power cut takes it with the very group it was meant to name.
    pub fn begin_inflight(&self, inflight: &Inflight) -> std::io::Result<()> {
        let _ = std::fs::remove_file(self.progress_path());
        write_atomic(&self.inflight_path(), &to_json(inflight)?)
    }

    pub fn end_inflight(&self) -> std::io::Result<()> {
        let _ = std::fs::remove_file(self.progress_path());
        match std::fs::remove_file(self.inflight_path()) {
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(()),
            other => other,
        }
    }

    pub fn read_inflight(&self) -> Option<Inflight> {
        read_json(&self.inflight_path()).ok()
    }

    /// How many cases the in-flight group had reported, as far as the file knows.
    ///
    /// Not fsynced per line - that would be a durability barrier per case, against work
    /// measured in milliseconds. After an orderly death the count is exact; after a
    /// power cut the tail of it is whatever writeback had got to, so it is a lower
    /// bound. A lower bound still cuts a thousand-case replay down by an order of
    /// magnitude, which is worth more than the certainty costs.
    pub fn read_progress(&self) -> usize {
        std::fs::read_to_string(self.progress_path())
            .map(|s| s.lines().filter(|l| !l.is_empty()).count())
            .unwrap_or(0)
    }

    pub fn append_iteration(&self, record: &IterationRecord) -> std::io::Result<()> {
        append_line(&self.iterations_path(), &to_json(record)?)
    }

    pub fn append_journal(&self, entry: &JournalEntry) -> std::io::Result<()> {
        append_line(&self.journal_path(), &to_json(entry)?)
    }

    /// Writes a finding out whole: its metadata, the group in execution order, and the
    /// prefix up to and including whatever died.
    ///
    /// The case list *is* materialised here, unlike for an ordinary iteration - a
    /// finding has to stay replayable after the corpus moves under it, and at that
    /// point a regenerating seed is worth nothing.
    pub fn write_finding(&self, finding: &Finding, cases: &[String]) -> std::io::Result<PathBuf> {
        let dir = self.findings_dir().join(format!("{:04}-{}", finding.id, finding.kind));
        std::fs::create_dir_all(&dir)?;
        write_atomic(&dir.join("finding.json"), &to_json(finding)?)?;
        write_atomic(&dir.join("cases.txt"), &joined(cases))?;

        // One past the last case that reported is the one that was in flight. Clamped,
        // because a worker that reported everything and then failed to exit leaves
        // nothing past the end to blame.
        let end = (finding.completed + 1).min(cases.len());
        write_atomic(&dir.join("prefix.txt"), &joined(&cases[..end]))?;
        Ok(dir)
    }

    /// A finding's directory, found by its number rather than by its kind - the caller
    /// knows the id from the log and should not have to know how it died as well.
    pub fn finding_dir(&self, id: u32) -> std::io::Result<PathBuf> {
        let prefix = format!("{id:04}-");
        std::fs::read_dir(self.findings_dir())?
            .filter_map(Result::ok)
            .map(|e| e.path())
            .find(|p| {
                p.file_name()
                    .and_then(|n| n.to_str())
                    .is_some_and(|n| n.starts_with(&prefix))
            })
            .ok_or_else(|| {
                std::io::Error::other(format!("there is no finding {id} in {}", self.findings_dir().display()))
            })
    }

    pub fn read_finding(&self, id: u32) -> std::io::Result<Finding> {
        read_json(&self.finding_dir(id)?.join("finding.json"))
    }

    /// Rewrites a finding in place, for when something new is learned about it - a
    /// reproduction rate, a severity a person supplied later.
    pub fn update_finding(&self, finding: &Finding) -> std::io::Result<()> {
        write_atomic(&self.finding_dir(finding.id)?.join("finding.json"), &to_json(finding)?)
    }

    /// `prefix.txt` by default: the shortest list known to contain whatever went wrong,
    /// and therefore the one worth re-running. `cases.txt` is the whole group.
    pub fn read_finding_list(&self, id: u32, whole_group: bool) -> std::io::Result<Vec<String>> {
        let file = if whole_group { "cases.txt" } else { "prefix.txt" };
        let text = std::fs::read_to_string(self.finding_dir(id)?.join(file))?;
        Ok(text.lines().filter(|l| !l.is_empty()).map(str::to_string).collect())
    }

    /// Every finding, lowest id first.
    pub fn findings(&self) -> Vec<Finding> {
        let Ok(entries) = std::fs::read_dir(self.findings_dir()) else {
            return Vec::new();
        };
        let mut found: Vec<Finding> = entries
            .filter_map(Result::ok)
            .filter_map(|e| read_json::<Finding>(&e.path().join("finding.json")).ok())
            .collect();
        found.sort_by_key(|f| f.id);
        found
    }
}

/// The append-only narrative of a campaign, in the order things happened.
///
/// Separate from `iterations.jsonl` because the two answer different questions: that
/// one is "what did group 341 do", this one is "what happened to this campaign,
/// including the parts that were not a group" - it started, it was resumed, a human
/// said the machine went down, it stopped.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JournalEntry {
    pub epoch_seconds: u64,
    pub event: String,
    pub detail: String,
}

impl JournalEntry {
    pub fn new(event: &str, detail: impl Into<String>) -> Self {
        Self {
            epoch_seconds: now_epoch(),
            event: event.to_string(),
            detail: detail.into(),
        }
    }
}

pub fn now_epoch() -> u64 {
    std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .map(|d| d.as_secs())
        .unwrap_or(0)
}

/// How long ago, in the coarsest unit that still says something.
///
/// Relative on purpose: it is the same answer whatever timezone the board thinks it is
/// in, and "47 min ago" is the question actually being asked after a reset.
pub fn ago(epoch_seconds: u64) -> String {
    let now = now_epoch();
    if epoch_seconds > now {
        return "in the future (clock skew?)".to_string();
    }
    let secs = now - epoch_seconds;
    match secs {
        0..=90 => format!("{secs} s ago"),
        91..=5400 => format!("{} min ago", secs / 60),
        5401..=172_800 => format!("{} h ago", secs / 3600),
        _ => format!("{} days ago", secs / 86_400),
    }
}

fn joined(lines: &[String]) -> String {
    let mut out = String::new();
    for line in lines {
        out.push_str(line);
        out.push('\n');
    }
    out
}

fn to_json<T: Serialize>(value: &T) -> std::io::Result<String> {
    serde_json::to_string(value).map_err(std::io::Error::other)
}

fn read_json<T: for<'de> Deserialize<'de>>(path: &Path) -> std::io::Result<T> {
    let text = std::fs::read_to_string(path)?;
    serde_json::from_str(&text).map_err(|e| std::io::Error::other(format!("{}: {e}", path.display())))
}

/// Replace, never rewrite in place.
///
/// A half-written `state.json` is a campaign nobody can resume, and rewriting in place
/// is exactly how one is produced when the machine goes down mid-write. Both the file
/// and the directory are fsynced - without the directory the rename itself is free to
/// be lost, which on a board's ext4 with the default mount options is not theoretical.
pub fn write_atomic(path: &Path, contents: &str) -> std::io::Result<()> {
    write_atomic_bytes(path, contents.as_bytes())
}

/// The same, for a file that is not text - the per-epoch status vectors.
pub fn write_atomic_bytes(path: &Path, contents: &[u8]) -> std::io::Result<()> {
    let parent = path.parent().unwrap_or(Path::new("."));
    std::fs::create_dir_all(parent)?;
    let tmp = path.with_extension("tmp");

    let mut file = std::fs::File::create(&tmp)?;
    file.write_all(contents)?;
    file.sync_all()?;
    drop(file);

    std::fs::rename(&tmp, path)?;
    if let Ok(dir) = std::fs::File::open(parent) {
        let _ = dir.sync_all();
    }
    Ok(())
}

fn append_line(path: &Path, line: &str) -> std::io::Result<()> {
    if let Some(parent) = path.parent() {
        std::fs::create_dir_all(parent)?;
    }
    let mut file = std::fs::OpenOptions::new().create(true).append(true).open(path)?;
    writeln!(file, "{line}")?;
    file.flush()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn store() -> (tempdir::TempDir, Store) {
        let dir = tempdir::TempDir::new();
        let store = Store::new(dir.path().join("campaign"));
        (dir, store)
    }

    fn finding(id: u32, completed: usize, size: usize) -> Finding {
        Finding {
            id,
            kind: "crash".to_string(),
            severity: None,
            detected_epoch: 0,
            api: "dEQP-GLES2".to_string(),
            epoch: 1,
            epoch_seed: 7,
            group: 3,
            size,
            culprit: Some("c".to_string()),
            message: "boom".to_string(),
            completed,
            completed_exact: true,
            repro: crate::fuzz::triage::ReproReport::default(),
        }
    }

    fn names(n: usize) -> Vec<String> {
        (0..n).map(|i| format!("dEQP-GLES2.case{i}")).collect()
    }

    #[test]
    fn an_inflight_record_survives_being_written_and_is_gone_once_ended() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(&store.dir).unwrap();
        let inflight = Inflight {
            phase: "group".to_string(),
            started_epoch: 123,
            api: "dEQP-GLES2".to_string(),
            epoch: 1,
            epoch_seed: 9,
            group: 4,
            size: 1000,
            pool_fingerprint: 0xABCD,
            finding: None,
        };
        store.begin_inflight(&inflight).unwrap();

        let read = store.read_inflight().expect("an in-flight record was just written");
        assert_eq!(read.group, 4);
        assert_eq!(read.epoch_seed, 9);
        assert_eq!(read.pool_fingerprint, 0xABCD);

        store.end_inflight().unwrap();
        assert!(store.read_inflight().is_none());
    }

    /// Ending twice happens whenever a resume tidies up after a death that had already
    /// removed the record; it must not be an error.
    #[test]
    fn ending_an_inflight_that_is_not_there_is_fine() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(&store.dir).unwrap();
        store.end_inflight().unwrap();
        store.end_inflight().unwrap();
    }

    #[test]
    fn progress_counts_the_cases_that_reported() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(&store.dir).unwrap();
        assert_eq!(store.read_progress(), 0);
        std::fs::write(store.progress_path(), "a\nb\nc\n").unwrap();
        assert_eq!(store.read_progress(), 3);
        // A truncated final line is what a power cut leaves; it still counts as seen.
        std::fs::write(store.progress_path(), "a\nb\nc").unwrap();
        assert_eq!(store.read_progress(), 3);
    }

    #[test]
    fn beginning_an_inflight_clears_the_previous_groups_progress() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(&store.dir).unwrap();
        std::fs::write(store.progress_path(), "a\nb\n").unwrap();
        store
            .begin_inflight(&Inflight {
                phase: "group".to_string(),
                started_epoch: 1,
                api: "dEQP-GLES2".to_string(),
                epoch: 1,
                epoch_seed: 1,
                group: 1,
                size: 1,
                pool_fingerprint: 1,
                finding: None,
            })
            .unwrap();
        assert_eq!(store.read_progress(), 0);
    }

    #[test]
    fn a_finding_keeps_the_whole_group_and_the_prefix_up_to_the_culprit() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(store.findings_dir()).unwrap();
        let cases = names(10);
        let dir = store.write_finding(&finding(1, 6, 10), &cases).unwrap();

        let all: Vec<String> = std::fs::read_to_string(dir.join("cases.txt"))
            .unwrap()
            .lines()
            .map(str::to_string)
            .collect();
        assert_eq!(all, cases);

        // Six reported, so the seventh - index 6 - was in flight and is the last line.
        let prefix: Vec<String> = std::fs::read_to_string(dir.join("prefix.txt"))
            .unwrap()
            .lines()
            .map(str::to_string)
            .collect();
        assert_eq!(prefix.len(), 7);
        assert_eq!(prefix.last().unwrap(), &cases[6]);
    }

    /// A worker that reported every case and then failed to exit leaves nothing past
    /// the end to blame, and slicing for it would panic.
    #[test]
    fn a_prefix_past_the_end_of_the_group_is_clamped() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(store.findings_dir()).unwrap();
        let cases = names(4);
        let dir = store.write_finding(&finding(2, 4, 4), &cases).unwrap();
        let prefix: Vec<String> = std::fs::read_to_string(dir.join("prefix.txt"))
            .unwrap()
            .lines()
            .map(str::to_string)
            .collect();
        assert_eq!(prefix, cases);
    }

    #[test]
    fn state_round_trips_and_is_replaced_not_appended() {
        let (_tmp, store) = store();
        std::fs::create_dir_all(&store.dir).unwrap();
        let mut state = State {
            apis: vec![ApiState {
                root: "dEQP-GLES2".to_string(),
                epoch: 1,
                epoch_seed: 5,
                group: 0,
            }],
            ..State::default()
        };
        store.write_state(&state).unwrap();
        state.apis[0].group = 12;
        state.iterations = 40;
        store.write_state(&state).unwrap();

        let read = store.read_state().unwrap();
        assert_eq!(read.apis[0].group, 12);
        assert_eq!(read.iterations, 40);
        assert!(!store.state_path().with_extension("tmp").exists());
    }

    #[test]
    fn ago_reads_in_the_coarsest_unit_that_still_says_something() {
        let now = now_epoch();
        assert_eq!(ago(now), "0 s ago");
        assert_eq!(ago(now - 600), "10 min ago");
        assert_eq!(ago(now - 7200), "2 h ago");
        assert_eq!(ago(now - 3 * 86_400), "3 days ago");
        assert!(ago(now + 600).contains("clock skew"));
    }
}

/// A directory that removes itself, so the tests above need no dependency for one.
#[cfg(test)]
mod tempdir {
    use std::path::{Path, PathBuf};

    pub struct TempDir(PathBuf);

    impl TempDir {
        pub fn new() -> Self {
            static COUNTER: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
            let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
            let path = std::env::temp_dir().join(format!("hodow-cts-fuzz-test-{}-{n}", std::process::id()));
            std::fs::create_dir_all(&path).expect("a temporary directory");
            Self(path)
        }

        pub fn path(&self) -> &Path {
            &self.0
        }
    }

    impl Drop for TempDir {
        fn drop(&mut self) {
            let _ = std::fs::remove_dir_all(&self.0);
        }
    }
}
