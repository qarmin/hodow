// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// What the fuzzer stops drawing, and why.
//
// Without this a campaign stops making progress the moment it finds anything: if some
// case wedges the GPU, every later group that happens to contain it wedges the GPU too,
// and each one costs a reset. One finding would be the last useful thing a campaign
// ever did.
//
// **What gets excluded is the trigger, not the casualty.** When a case poisons the
// driver, the case that dies is whatever ran next - innocent, and a different one every
// permutation. Excluding it would remove a healthy case, leave the real cause in the
// pool, and bring the bug straight back with a new victim; do that a dozen times and
// the quarantine is full of healthy cases while nothing has actually been contained.
// So the entry comes from the *first* element of a minimised repro. Until a
// minimisation has run there is nothing here to add, which is deliberate.
//
// Entries are globs, matched the way `--case` is, so a hand-written line can cover a
// family. `reason` is mandatory - same rule as `data/cpu/function_policy.toml`, for the
// same reason: an exclusion whose justification was never written down is one nobody can
// ever safely remove.
//
// Not committed anywhere, and it must not be: a case that wedges a Vivante GC2000 is
// perfectly fine on lavapipe. This is a fact about one machine.

use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

use super::store::{now_epoch, write_atomic};
use crate::runner::matches_filter;

const HEADER: &str = "\
# Cases the fuzzer will not draw. Hand-editable: `case` is a glob matched the way
# `--case` is, and `reason` is mandatory - an exclusion nobody wrote a reason for is one
# nobody can safely remove later.
#
# Entries added automatically name the *trigger* of a minimised repro, not the case that
# died: the casualty is usually innocent and differs every run. See fuzz/quarantine.rs.
#
# Facts about this machine and this driver only. Do not commit this file.
# `fuzz run --no-quarantine` ignores all of it, e.g. to check whether a driver update
# fixed something.
";

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Entry {
    pub case: String,
    pub reason: String,
    #[serde(default)]
    pub added_epoch: u64,
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
struct File {
    #[serde(default)]
    entry: Vec<Entry>,
}

pub struct Quarantine {
    path: PathBuf,
    entries: Vec<Entry>,
    /// Set by `--no-quarantine`: the file is still read and still written to, so a
    /// campaign run this way does not lose what earlier ones learned - it just does not
    /// act on it.
    disabled: bool,
}

impl Quarantine {
    pub fn load(base_dir: &Path) -> Self {
        let path = base_dir.join("quarantine.toml");
        let entries = match std::fs::read_to_string(&path) {
            Ok(text) => match toml::from_str::<File>(&text) {
                Ok(file) => file.entry,
                Err(e) => {
                    // Loud, and empty rather than fatal: a typo in a hand-edited file
                    // must not make an overnight campaign refuse to start, but it must
                    // not silently un-exclude a case that wedges the GPU either.
                    log::error!("{}: {e}", path.display());
                    log::error!("nothing is excluded until that is fixed - stop now if a case here wedges the driver");
                    Vec::new()
                }
            },
            Err(_) => Vec::new(),
        };
        Self {
            path,
            entries,
            disabled: false,
        }
    }

    pub fn disabled(mut self) -> Self {
        self.disabled = true;
        self
    }

    pub fn is_disabled(&self) -> bool {
        self.disabled
    }

    pub fn entries(&self) -> &[Entry] {
        &self.entries
    }

    pub fn len(&self) -> usize {
        self.entries.len()
    }

    pub fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }

    /// Whether this case is kept out of a group.
    pub fn excludes(&self, case: &str) -> bool {
        !self.disabled && self.entries.iter().any(|e| matches_filter(case, &e.case))
    }

    /// Adds an entry unless the case is already covered. Returns whether it added one.
    pub fn add(&mut self, case: &str, reason: &str) -> std::io::Result<bool> {
        if self.entries.iter().any(|e| matches_filter(case, &e.case)) {
            return Ok(false);
        }
        self.entries.push(Entry {
            case: case.to_string(),
            reason: reason.to_string(),
            added_epoch: now_epoch(),
        });
        self.save()?;
        Ok(true)
    }

    /// Removes every entry whose pattern is exactly `case`. Returns how many went.
    ///
    /// Exact rather than glob-matched: removing by pattern means the thing typed is the
    /// thing removed, where removing everything a glob happens to cover would quietly
    /// re-admit far more than intended.
    pub fn remove(&mut self, case: &str) -> std::io::Result<usize> {
        let before = self.entries.len();
        self.entries.retain(|e| e.case != case);
        let removed = before - self.entries.len();
        if removed > 0 {
            self.save()?;
        }
        Ok(removed)
    }

    fn save(&self) -> std::io::Result<()> {
        let body = toml::to_string_pretty(&File {
            entry: self.entries.clone(),
        })
        .map_err(std::io::Error::other)?;
        write_atomic(&self.path, &format!("{HEADER}\n{body}"))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn temp() -> PathBuf {
        static N: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
        let n = N.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let dir = std::env::temp_dir().join(format!("hodow-quarantine-{}-{n}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        dir
    }

    #[test]
    fn an_added_entry_excludes_its_case_and_survives_a_reload() {
        let dir = temp();
        let mut q = Quarantine::load(&dir);
        assert!(!q.excludes("dEQP-GLES2.a"));
        assert!(q.add("dEQP-GLES2.a", "auto: finding 1").unwrap());

        let reloaded = Quarantine::load(&dir);
        assert!(reloaded.excludes("dEQP-GLES2.a"));
        assert!(!reloaded.excludes("dEQP-GLES2.b"));
        assert_eq!(reloaded.entries()[0].reason, "auto: finding 1");
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// Hand-written entries are the reason this is TOML rather than JSON, and a glob is
    /// how one line covers a family.
    #[test]
    fn a_hand_written_glob_covers_a_family() {
        let dir = temp();
        std::fs::write(
            dir.join("quarantine.toml"),
            "# a comment, which is why this file is TOML\n[[entry]]\ncase = \"dEQP-VK.memory.*\"\nreason = \"eats the heap\"\n",
        )
        .unwrap();

        let q = Quarantine::load(&dir);
        assert!(q.excludes("dEQP-VK.memory.allocation.basic"));
        assert!(!q.excludes("dEQP-VK.compute.basic"));
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn a_case_already_covered_is_not_added_twice() {
        let dir = temp();
        let mut q = Quarantine::load(&dir);
        assert!(q.add("dEQP-GLES2.*", "a family").unwrap());
        assert!(!q.add("dEQP-GLES2.a", "already covered by the glob above").unwrap());
        assert_eq!(q.len(), 1);
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// Removing by the pattern that was typed, not by what it covers: `--remove
    /// dEQP-GLES2.a` must not take a `dEQP-GLES2.*` line with it.
    #[test]
    fn removal_is_by_exact_pattern() {
        let dir = temp();
        let mut q = Quarantine::load(&dir);
        q.add("dEQP-GLES2.*", "a family").unwrap();
        assert_eq!(q.remove("dEQP-GLES2.a").unwrap(), 0);
        assert_eq!(q.remove("dEQP-GLES2.*").unwrap(), 1);
        assert!(q.is_empty());
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// A broken file has to be loud and inert, never fatal: an overnight campaign must
    /// not refuse to start over a typo, and must not pretend the file said nothing.
    #[test]
    fn a_malformed_file_excludes_nothing_rather_than_failing() {
        let dir = temp();
        std::fs::write(dir.join("quarantine.toml"), "[[entry]]\ncase = \n").unwrap();
        let q = Quarantine::load(&dir);
        assert!(q.is_empty());
        assert!(!q.excludes("dEQP-GLES2.a"));
        let _ = std::fs::remove_dir_all(&dir);
    }

    /// `reason` is mandatory, so an entry without one is a parse error rather than an
    /// exclusion nobody can justify later.
    #[test]
    fn an_entry_without_a_reason_does_not_load() {
        let dir = temp();
        std::fs::write(dir.join("quarantine.toml"), "[[entry]]\ncase = \"dEQP-GLES2.a\"\n").unwrap();
        assert!(Quarantine::load(&dir).is_empty());
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn disabling_stops_it_acting_without_losing_it() {
        let dir = temp();
        let mut q = Quarantine::load(&dir);
        q.add("dEQP-GLES2.a", "auto").unwrap();

        let off = Quarantine::load(&dir).disabled();
        assert!(!off.excludes("dEQP-GLES2.a"));
        assert_eq!(off.len(), 1, "the entries are still there, just not acted on");
        let _ = std::fs::remove_dir_all(&dir);
    }
}
