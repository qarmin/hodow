// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// What a board has shown so far: `findings.json` is the record, `FINDINGS.md` and the
// per-finding directories are written from it for a person (or a later repro port) to read.

use std::fmt::Write as _;
use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

use super::target::FatalKind;
use crate::fuzz::minimize::MinimizeState;
use crate::fuzz::store::{now_epoch, write_atomic};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Kind {
    Fatal(FatalKind),
    /// Fails after some other case and passes on its own.
    OrderFail,
    /// Passed in one shuffled epoch and failed in the next, or the other way round.
    FlakyVerdict,
}

impl Kind {
    pub fn label(self) -> &'static str {
        match self {
            Self::Fatal(kind) => kind.label(),
            Self::OrderFail => "ORDERFAIL",
            Self::FlakyVerdict => "FLAKYVERDICT",
        }
    }

    pub fn fatal(self) -> Option<FatalKind> {
        match self {
            Self::Fatal(kind) => Some(kind),
            _ => None,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Status {
    Confirming,
    Minimizing,
    /// A second, independent try at dropping each case one at a time.
    Rechecking,
    Verifying,
    /// Shrunk and re-verified from a fresh boot.
    Minimal,
    /// Reproduces too rarely to shrink reliably; the full list is the reproducer.
    Flaky,
    /// The budget ran out before the list stopped shrinking.
    Parked,
    NotReproducible,
    Recorded,
}

impl Status {
    pub fn label(self) -> &'static str {
        match self {
            Self::Confirming => "confirming",
            Self::Minimizing => "minimizing",
            Self::Rechecking => "rechecking",
            Self::Verifying => "verifying",
            Self::Minimal => "minimal",
            Self::Flaky => "flaky",
            Self::Parked => "parked",
            Self::NotReproducible => "not reproducible",
            Self::Recorded => "recorded",
        }
    }

    pub fn in_progress(self) -> bool {
        matches!(
            self,
            Self::Confirming | Self::Minimizing | Self::Rechecking | Self::Verifying
        )
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Finding {
    pub id: u32,
    pub kind: Kind,
    pub status: Status,
    pub victim: String,
    pub message: String,
    /// Where it turned up, e.g. "phase 2, GLES3 epoch 3 group 12/49".
    pub found_in: String,
    pub found_epoch: u64,
    /// The shortest list known to reproduce, victim last.
    pub cases: Vec<String>,
    pub original_len: usize,
    /// Every list a minimisation step accepted, longest first.
    #[serde(default)]
    pub accepted: Vec<Vec<String>>,
    /// Successes over the attempts that ended in one: the reproduction rate estimate.
    pub successes: u32,
    pub attempts: u32,
    pub oracle_calls: u32,
    #[serde(default)]
    pub minimize: Option<MinimizeState>,
    /// Lists a minimisation step already found not to reproduce.
    #[serde(default)]
    pub rejected: Vec<Vec<String>>,
    /// The last list that reproduced in a run started from a fresh boot.
    #[serde(default)]
    pub fresh_hit: Option<Vec<String>>,
    /// Where the recheck has got to.
    #[serde(default)]
    pub recheck_at: usize,
    #[serde(default)]
    pub quarantined: Vec<String>,
    /// Nothing recorded earlier has the same trigger (or victim, where there is no trigger).
    #[serde(default)]
    pub new: bool,
    pub dir: String,
}

impl Finding {
    pub fn rate(&self) -> f64 {
        if self.attempts == 0 {
            0.0
        } else {
            f64::from(self.successes) / f64::from(self.attempts)
        }
    }

    pub fn trigger(&self) -> Option<&String> {
        (self.status == Status::Minimal).then(|| self.cases.first()).flatten()
    }

    fn key(&self) -> (Kind, &str) {
        let name = match (self.trigger(), self.kind) {
            (Some(trigger), _) => trigger.as_str(),
            (None, _) => self.victim.as_str(),
        };
        let kind = match self.kind {
            Kind::Fatal(k) if k.is_stall() => Kind::Fatal(FatalKind::Hang),
            other => other,
        };
        (kind, name)
    }
}

/// One line per case known to fail on its own, so it is not checked again.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct Baseline {
    #[serde(default)]
    pub alone: std::collections::BTreeMap<String, Alone>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alone {
    pub passes: bool,
    pub message: String,
}

pub struct Findings {
    dir: PathBuf,
    pub list: Vec<Finding>,
    pub baseline: Baseline,
    /// Which hodow_cts the board ran, written into every finding.
    pub binary: String,
}

impl Findings {
    pub fn load(dir: &Path) -> std::io::Result<Self> {
        std::fs::create_dir_all(dir.join("findings"))?;
        let list = read_json(&dir.join("findings.json"))?.unwrap_or_default();
        let baseline = read_json(&dir.join("baseline.json"))?.unwrap_or_default();
        Ok(Self {
            dir: dir.to_path_buf(),
            list,
            baseline,
            binary: String::new(),
        })
    }

    pub fn create(
        &mut self,
        kind: Kind,
        victim: &str,
        message: &str,
        found_in: &str,
        cases: Vec<String>,
    ) -> std::io::Result<usize> {
        let id = self.list.iter().map(|f| f.id).max().unwrap_or(0) + 1;
        let dir = format!("{id:03}-{}", kind.label().to_lowercase());
        std::fs::create_dir_all(self.dir.join("findings").join(&dir))?;
        self.list.push(Finding {
            id,
            kind,
            status: if kind == Kind::FlakyVerdict {
                Status::Recorded
            } else {
                Status::Confirming
            },
            victim: victim.to_string(),
            message: message.to_string(),
            found_in: found_in.to_string(),
            found_epoch: now_epoch(),
            original_len: cases.len(),
            cases,
            accepted: Vec::new(),
            successes: 0,
            attempts: 0,
            oracle_calls: 0,
            minimize: None,
            rejected: Vec::new(),
            fresh_hit: None,
            recheck_at: 0,
            quarantined: Vec::new(),
            new: false,
            dir,
        });
        self.save()?;
        Ok(self.list.len() - 1)
    }

    pub fn finding_dir(&self, index: usize) -> PathBuf {
        self.dir.join("findings").join(&self.list[index].dir)
    }

    pub fn write_file(&self, index: usize, name: &str, text: &str) -> std::io::Result<()> {
        if text.is_empty() {
            return Ok(());
        }
        write_atomic(&self.finding_dir(index).join(name), text)
    }

    /// Settles the finding: whether it is new, its directory name, `cases.txt` and `info.toml`.
    pub fn finish(&mut self, index: usize) -> std::io::Result<()> {
        let key = self.list[index].key();
        let key = (key.0, key.1.to_string());
        self.list[index].new = !self.list[..index]
            .iter()
            .chain(&self.list[index + 1..])
            .filter(|f| !f.status.in_progress())
            .any(|f| {
                let (k, n) = f.key();
                k == key.0 && n == key.1
            });

        let finding = &self.list[index];
        let named = finding.trigger().unwrap_or(&finding.victim);
        let wanted = format!(
            "{:03}-{}-{}",
            finding.id,
            finding.kind.label().to_lowercase(),
            short_name(named)
        );
        if wanted != finding.dir {
            let from = self.finding_dir(index);
            let to = self.dir.join("findings").join(&wanted);
            if std::fs::rename(&from, &to).is_ok() {
                self.list[index].dir = wanted;
            }
        }

        let finding = &self.list[index];
        let mut cases = String::new();
        for case in &finding.cases {
            cases.push_str(case);
            cases.push('\n');
        }
        self.write_file(index, "cases.txt", &cases)?;
        self.write_file(index, "info.toml", &info_toml(finding, &self.binary))?;
        self.save()
    }

    pub fn save(&self) -> std::io::Result<()> {
        write_atomic(
            &self.dir.join("findings.json"),
            &serde_json::to_string_pretty(&self.list).map_err(std::io::Error::other)?,
        )?;
        write_atomic(
            &self.dir.join("baseline.json"),
            &serde_json::to_string_pretty(&self.baseline).map_err(std::io::Error::other)?,
        )?;
        write_atomic(&self.dir.join("FINDINGS.md"), &self.markdown())
    }

    fn markdown(&self) -> String {
        let mut out = String::from("# Findings\n\nWritten by `hodow_cts board`; `findings.json` is the record.\n\n");
        out.push_str("| id | kind | status | trigger / victim | cases | reproduced | quarantined | directory |\n");
        out.push_str("|---|---|---|---|---|---|---|---|\n");
        for f in &self.list {
            let who = match f.trigger() {
                Some(trigger) if f.cases.len() > 1 => format!("`{trigger}` -> `{}`", f.victim),
                Some(trigger) => format!("`{trigger}`"),
                None => format!("`{}`", f.victim),
            };
            let rate = if f.attempts == 0 {
                "-".to_string()
            } else {
                format!("{}/{}", f.successes, f.attempts)
            };
            let _ = writeln!(
                out,
                "| {} | {} | {} | {who} | {} (from {}) | {rate} | {} | [{}](findings/{}) |",
                f.id,
                f.kind.label(),
                f.status.label(),
                f.cases.len(),
                f.original_len,
                if f.quarantined.is_empty() {
                    "no".to_string()
                } else {
                    f.quarantined.len().to_string()
                },
                f.dir,
                f.dir
            );
        }

        let failing: Vec<_> = self.baseline.alone.iter().filter(|(_, a)| !a.passes).collect();
        let _ = writeln!(out, "\n## Cases that fail on their own ({})\n", failing.len());
        out.push_str("Run alone, in a process of their own; not minimised and not quarantined.\n\n");
        for (case, alone) in failing {
            let _ = writeln!(out, "- `{case}`: {}", alone.message);
        }
        out
    }
}

fn info_toml(f: &Finding, binary: &str) -> String {
    let mut out = String::new();
    let _ = writeln!(out, "id = {}", f.id);
    let _ = writeln!(out, "kind = {:?}", f.kind.label());
    let _ = writeln!(out, "status = {:?}", f.status.label());
    let _ = writeln!(out, "victim = {:?}", f.victim);
    if let Some(trigger) = f.trigger() {
        let _ = writeln!(out, "trigger = {trigger:?}");
    }
    let _ = writeln!(out, "message = {:?}", f.message);
    let _ = writeln!(out, "found_in = {:?}", f.found_in);
    let _ = writeln!(out, "found_epoch = {}", f.found_epoch);
    let _ = writeln!(out, "cases = {}", f.cases.len());
    let _ = writeln!(out, "original_cases = {}", f.original_len);
    let _ = writeln!(out, "reproduced = {}", f.successes);
    let _ = writeln!(out, "attempts = {}", f.attempts);
    let _ = writeln!(out, "oracle_calls = {}", f.oracle_calls);
    let _ = writeln!(out, "quarantined = {:?}", f.quarantined);
    let _ = writeln!(out, "hodow_cts = {binary:?}");
    out
}

/// The last two components of a case name, which is what tells cases of one group apart.
pub fn short_name(case: &str) -> String {
    let parts: Vec<&str> = case.split('.').collect();
    let tail = parts[parts.len().saturating_sub(2)..].join(".");
    tail.chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() || c == '.' || c == '_' || c == '-' {
                c
            } else {
                '_'
            }
        })
        .collect()
}

/// `None` for a file that is not there; a file that is there and does not parse is an error,
/// since starting over would silently throw away what it recorded.
pub fn read_json<T: serde::de::DeserializeOwned>(path: &Path) -> std::io::Result<Option<T>> {
    let text = match std::fs::read_to_string(path) {
        Ok(text) => text,
        Err(e) if e.kind() == std::io::ErrorKind::NotFound => return Ok(None),
        Err(e) => return Err(e),
    };
    serde_json::from_str(&text)
        .map(Some)
        .map_err(|e| std::io::Error::other(format!("{}: {e}", path.display())))
}
