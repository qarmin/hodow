// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// What changed between one sweep of the corpus and the next.
//
// An epoch touches every case in a pool exactly once, which makes a second epoch a
// free comparison: the same cases, the same driver, a different arrangement. A case
// that passed in epoch 1 and fails in epoch 2 is saying something no single run can -
// either it is flaky, or the driver has degraded over the hours in between, and both
// are findings the pass/fail totals hide completely.
//
// One byte per case, indexed by position in the pool, so a 625k-case Vulkan pool is a
// 625 KB file rather than the 90 MB a map of names to verdicts would be. Rewritten
// once per group, never per case.
//
// The byte values are pinned below and must not be renumbered: a file from the previous
// epoch is read back by the next one, and a renumbering would silently turn every case
// into a spurious change.

use std::collections::HashMap;
use std::path::{Path, PathBuf};

use super::store::write_atomic_bytes;
use crate::tcu::TestResult;

/// Not yet run this epoch.
const UNSEEN: u8 = 0;

/// Fixed for ever - see the module comment.
fn encode(status: TestResult) -> u8 {
    match status {
        TestResult::Pass => 1,
        TestResult::Fail => 2,
        TestResult::NotSupported => 3,
        TestResult::Crash => 4,
        TestResult::Timeout => 5,
        TestResult::DeviceLost => 6,
        TestResult::QualityWarning => 7,
        TestResult::CompatibilityWarning => 8,
        TestResult::CapabilityWarning => 9,
        _ => 10,
    }
}

fn decode(byte: u8) -> &'static str {
    match byte {
        UNSEEN => "not run",
        1 => "Pass",
        2 => "Fail",
        3 => "NotSupported",
        4 => "Crash",
        5 => "Timeout",
        6 => "DeviceLost",
        7 => "QualityWarning",
        8 => "CompatibilityWarning",
        9 => "CapabilityWarning",
        _ => "other",
    }
}

/// One epoch's verdict for every case in a pool.
pub struct EpochStatus {
    path: PathBuf,
    bytes: Vec<u8>,
}

impl EpochStatus {
    pub fn open(dir: &Path, root: &str, epoch: u64, pool_size: usize) -> Self {
        let path = dir.join(format!("epoch-{root}-{epoch}.status"));
        let mut bytes = std::fs::read(&path).unwrap_or_default();
        bytes.resize(pool_size, UNSEEN);
        Self { path, bytes }
    }

    /// Records what a group's cases did. `index_of` maps a case name to its position in
    /// the pool; a name it does not know is skipped rather than guessed at.
    pub fn record(&mut self, results: &[crate::report::CaseResult], index_of: &HashMap<&str, usize>) {
        for result in results {
            if let Some(&index) = index_of.get(result.name.as_str())
                && index < self.bytes.len()
            {
                // Last verdict wins. With `--repeats` a case appears several times in
                // one group, and what matters for the next epoch's comparison is where
                // it ended up.
                self.bytes[index] = encode(result.status);
            }
        }
    }

    /// Replaced rather than rewritten: a torn vector after a crash would read as
    /// hundreds of cases having changed verdict, which is the one thing this file
    /// exists to report honestly.
    pub fn save(&self) -> std::io::Result<()> {
        write_atomic_bytes(&self.path, &self.bytes)
    }
}

/// One case whose verdict moved between two epochs.
pub struct Change {
    pub case: String,
    pub was: &'static str,
    pub now: &'static str,
}

/// Compares two finished epochs.
///
/// Cases that were not run in either epoch are ignored: a pool that grew, or an epoch
/// that was abandoned part-way, would otherwise read as hundreds of changes.
pub fn compare(dir: &Path, root: &str, previous: u64, current: u64, names: &[String]) -> Vec<Change> {
    let Ok(before) = std::fs::read(dir.join(format!("epoch-{root}-{previous}.status"))) else {
        return Vec::new();
    };
    let Ok(after) = std::fs::read(dir.join(format!("epoch-{root}-{current}.status"))) else {
        return Vec::new();
    };

    names
        .iter()
        .enumerate()
        .filter_map(|(index, name)| {
            let was = *before.get(index)?;
            let now = *after.get(index)?;
            (was != UNSEEN && now != UNSEEN && was != now).then(|| Change {
                case: name.clone(),
                was: decode(was),
                now: decode(now),
            })
        })
        .collect()
}

/// A one-line summary of a comparison, grouped by transition, for a log where the
/// individual cases would be hundreds of lines.
pub fn summarise(changes: &[Change]) -> Vec<String> {
    let mut counts: Vec<(String, usize)> = Vec::new();
    for change in changes {
        let key = format!("{} -> {}", change.was, change.now);
        match counts.iter_mut().find(|(k, _)| *k == key) {
            Some((_, n)) => *n += 1,
            None => counts.push((key, 1)),
        }
    }
    counts.sort_by_key(|(_, n)| std::cmp::Reverse(*n));
    counts.into_iter().map(|(key, n)| format!("{key}: {n}")).collect()
}

/// Deletes status files older than the previous epoch. Two are all a comparison needs,
/// and a 625 KB file per epoch would otherwise pile up for weeks on a board's SD card.
pub fn prune(dir: &Path, root: &str, keep_from: u64) {
    let Ok(entries) = std::fs::read_dir(dir) else { return };
    let prefix = format!("epoch-{root}-");
    for entry in entries.filter_map(Result::ok) {
        let name = entry.file_name();
        let Some(name) = name.to_str() else { continue };
        let Some(rest) = name.strip_prefix(&prefix) else {
            continue;
        };
        let Some(number) = rest.strip_suffix(".status").and_then(|n| n.parse::<u64>().ok()) else {
            continue;
        };
        if number < keep_from {
            let _ = std::fs::remove_file(entry.path());
        }
    }
}

/// Every case in one epoch whose verdict was `wanted` (`all` for every case that ran),
/// with what it was, in pool order.
///
/// The epoch file already holds a verdict per case, which makes a campaign a whole-corpus
/// screen as a side effect - and until this nothing could read one back out. A group
/// reports "4 fail" and the four names existed only in a worker's stdout.
pub fn cases_with(dir: &Path, root: &str, epoch: u64, names: &[String], wanted: &str) -> Vec<(String, &'static str)> {
    let Ok(bytes) = std::fs::read(dir.join(format!("epoch-{root}-{epoch}.status"))) else {
        return Vec::new();
    };
    let every = wanted.eq_ignore_ascii_case("all");
    names
        .iter()
        .enumerate()
        .filter_map(|(index, name)| {
            let byte = *bytes.get(index)?;
            let verdict = decode(byte);
            (byte != UNSEEN && (every || verdict.eq_ignore_ascii_case(wanted))).then(|| (name.clone(), verdict))
        })
        .collect()
}

/// How many cases ended each epoch with each verdict, commonest first.
pub fn tally(dir: &Path, root: &str, epoch: u64, pool_size: usize) -> Vec<(&'static str, usize)> {
    let Ok(bytes) = std::fs::read(dir.join(format!("epoch-{root}-{epoch}.status"))) else {
        return Vec::new();
    };
    let mut counts: Vec<(&'static str, usize)> = Vec::new();
    for byte in bytes.iter().take(pool_size) {
        let verdict = decode(*byte);
        match counts.iter_mut().find(|(k, _)| *k == verdict) {
            Some((_, n)) => *n += 1,
            None => counts.push((verdict, 1)),
        }
    }
    counts.sort_by_key(|(_, n)| std::cmp::Reverse(*n));
    counts
}

/// Maps each case name to its position in the pool, for `record`.
pub fn index_of(names: &[String]) -> HashMap<&str, usize> {
    names.iter().enumerate().map(|(i, n)| (n.as_str(), i)).collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::report::CaseResult;

    fn dir() -> PathBuf {
        static N: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
        let n = N.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let dir = std::env::temp_dir().join(format!("hodow-drift-{}-{n}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        dir
    }

    fn names(n: usize) -> Vec<String> {
        (0..n).map(|i| format!("c{i}")).collect()
    }

    fn result(name: &str, status: TestResult) -> CaseResult {
        CaseResult {
            name: name.to_string(),
            status,
            message: String::new(),
            duration_us: 0,
        }
    }

    fn write_epoch(dir: &Path, epoch: u64, names: &[String], results: &[CaseResult]) {
        let mut status = EpochStatus::open(dir, "dEQP-GLES2", epoch, names.len());
        status.record(results, &index_of(names));
        status.save().unwrap();
    }

    /// A group reports "4 fail" and nothing else records which four; the epoch file has
    /// known them all along.
    #[test]
    fn the_cases_that_failed_an_epoch_can_be_named() {
        let dir = dir();
        let names = names(4);
        write_epoch(
            &dir,
            1,
            &names,
            &[
                result("c0", TestResult::Pass),
                result("c1", TestResult::Fail),
                result("c3", TestResult::NotSupported),
            ],
        );

        let failed = cases_with(&dir, "dEQP-GLES2", 1, &names, "fail");
        assert_eq!(failed, vec![("c1".to_string(), "Fail")]);

        // `all` is every case that ran - `c2` was never reached and is in neither list.
        let ran: Vec<String> = cases_with(&dir, "dEQP-GLES2", 1, &names, "all")
            .into_iter()
            .map(|(n, _)| n)
            .collect();
        assert_eq!(ran, vec!["c0".to_string(), "c1".to_string(), "c3".to_string()]);

        let tally = tally(&dir, "dEQP-GLES2", 1, names.len());
        assert_eq!(tally.iter().find(|(v, _)| *v == "not run").map(|(_, n)| *n), Some(1));
        assert_eq!(tally.iter().find(|(v, _)| *v == "Fail").map(|(_, n)| *n), Some(1));

        assert!(
            cases_with(&dir, "dEQP-GLES2", 9, &names, "fail").is_empty(),
            "an epoch with no file names nothing"
        );
    }

    #[test]
    fn a_verdict_that_moves_between_epochs_is_reported() {
        let dir = dir();
        let names = names(4);
        write_epoch(
            &dir,
            1,
            &names,
            &[result("c0", TestResult::Pass), result("c1", TestResult::Pass)],
        );
        write_epoch(
            &dir,
            2,
            &names,
            &[result("c0", TestResult::Pass), result("c1", TestResult::Fail)],
        );

        let changes = compare(&dir, "dEQP-GLES2", 1, 2, &names);
        assert_eq!(changes.len(), 1);
        assert_eq!(changes[0].case, "c1");
        assert_eq!((changes[0].was, changes[0].now), ("Pass", "Fail"));
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// A case that one epoch never got to is not a change. An abandoned epoch would
    /// otherwise read as hundreds of them.
    #[test]
    fn a_case_missing_from_either_epoch_is_not_a_change() {
        let dir = dir();
        let names = names(4);
        write_epoch(&dir, 1, &names, &[result("c0", TestResult::Pass)]);
        write_epoch(
            &dir,
            2,
            &names,
            &[result("c0", TestResult::Pass), result("c3", TestResult::Fail)],
        );
        assert!(compare(&dir, "dEQP-GLES2", 1, 2, &names).is_empty());
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn comparing_against_an_epoch_that_was_never_written_is_empty_not_an_error() {
        let dir = dir();
        let names = names(4);
        write_epoch(&dir, 2, &names, &[result("c0", TestResult::Pass)]);
        assert!(compare(&dir, "dEQP-GLES2", 1, 2, &names).is_empty());
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// With `--repeats` a case reports several times in one group; the epoch's answer is
    /// where it ended up.
    #[test]
    fn the_last_verdict_of_a_repeated_case_is_the_one_kept() {
        let dir = dir();
        let names = names(2);
        write_epoch(
            &dir,
            1,
            &names,
            &[
                result("c0", TestResult::Pass),
                result("c0", TestResult::Pass),
                result("c0", TestResult::Fail),
            ],
        );
        write_epoch(&dir, 2, &names, &[result("c0", TestResult::Fail)]);
        assert!(compare(&dir, "dEQP-GLES2", 1, 2, &names).is_empty());
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn a_summary_groups_by_transition_commonest_first() {
        let changes = vec![
            Change {
                case: "a".to_string(),
                was: "Pass",
                now: "Fail",
            },
            Change {
                case: "b".to_string(),
                was: "Pass",
                now: "Fail",
            },
            Change {
                case: "c".to_string(),
                was: "Fail",
                now: "Pass",
            },
        ];
        assert_eq!(summarise(&changes), vec!["Pass -> Fail: 2", "Fail -> Pass: 1"]);
    }

    #[test]
    fn pruning_keeps_the_epochs_a_comparison_needs() {
        let dir = dir();
        let names = names(2);
        for epoch in 1..=4 {
            write_epoch(&dir, epoch, &names, &[result("c0", TestResult::Pass)]);
        }
        prune(&dir, "dEQP-GLES2", 3);
        assert!(!dir.join("epoch-dEQP-GLES2-2.status").exists());
        assert!(dir.join("epoch-dEQP-GLES2-3.status").exists());
        assert!(dir.join("epoch-dEQP-GLES2-4.status").exists());
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// The byte values are a file format read back by the next epoch. Renumbering them
    /// would turn every case into a spurious change, silently.
    #[test]
    fn the_encoding_is_pinned() {
        assert_eq!(encode(TestResult::Pass), 1);
        assert_eq!(encode(TestResult::Fail), 2);
        assert_eq!(encode(TestResult::NotSupported), 3);
        assert_eq!(encode(TestResult::Crash), 4);
        assert_eq!(encode(TestResult::Timeout), 5);
        assert_eq!(encode(TestResult::DeviceLost), 6);
        assert_eq!(decode(0), "not run");
        assert_eq!(decode(1), "Pass");
    }
}
