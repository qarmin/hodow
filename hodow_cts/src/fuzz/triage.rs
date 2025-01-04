// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Telling a finding from noise, while the driver is still alive to ask.
//
// Two questions, both answered by running something again:
//
//   Does it reproduce?  The list is run R times and the rate recorded. 0/R is not a
//                       finding to work on, it is a finding to note - and minimisation
//                       on an oracle that never says yes would produce a confident,
//                       meaningless answer.
//   Does it fail alone? A case that fails inside a group and passes on its own is an
//                       order-dependent failure, which is the same class of bug as a
//                       crash and just as invisible: in a run of a thousand cases, a
//                       Fail looks like any other Fail. One that fails on its own is
//                       simply broken, and is nobody's idea of a finding.
//
// The second is answered lazily and cached. Verifying a whole pool up front is hours
// before the first group runs, and almost all of it is wasted on cases that never fail.
// Verifying only what actually failed costs a process each and builds the same table.
//
// Both happen immediately after the group, on purpose: deferring them to a triage pass
// means that when the board finally wedges for good, nothing has been verified at all.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use serde::{Deserialize, Serialize};

use super::oracle::{self, Settings};
use super::store::{Inflight, Store, now_epoch, write_atomic};
use crate::runner::Api;
use crate::tcu::TestResult;

/// How a list behaved when it was run again, several times.
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct ReproReport {
    pub attempts: u32,
    pub reproduced: u32,
    /// What it looked like each time it did reproduce. A list that crashes twice and
    /// times out once is saying something a single rate does not.
    pub kinds: Vec<String>,
}

impl ReproReport {
    pub fn rate(&self) -> f64 {
        if self.attempts == 0 {
            0.0
        } else {
            f64::from(self.reproduced) / f64::from(self.attempts)
        }
    }

    pub fn is_reproducible(&self) -> bool {
        self.reproduced > 0
    }

    pub fn summary(&self) -> String {
        format!("{}/{} ({:.0}%)", self.reproduced, self.attempts, self.rate() * 100.0)
    }
}

/// Runs `cases` `attempts` times and counts how often `reproduced` says it happened
/// again.
///
/// The predicate is the caller's because the two things worth reproducing look nothing
/// alike: a crash is "the worker died", an order-dependent failure is "that one case
/// failed again, in company". Hard-coding the first would silently never confirm the
/// second.
///
/// `on_attempt` runs before each one, so the caller can say what is about to happen -
/// an attempt at reproducing a crash is itself a thing that can take the machine down.
/// `on_case` runs as each verdict arrives, which is what lets the attempt that *does*
/// take the machine down still say how far it got.
pub fn gate(
    api: Api,
    cases: &[String],
    attempts: u32,
    settings: &Settings,
    reproduced: impl Fn(&oracle::GroupOutcome) -> Option<String>,
    mut on_attempt: impl FnMut(u32),
    mut on_case: impl FnMut(&crate::report::CaseResult),
) -> ReproReport {
    let mut report = ReproReport {
        attempts: 0,
        reproduced: 0,
        kinds: Vec::new(),
    };

    for attempt in 1..=attempts.max(1) {
        on_attempt(attempt);
        report.attempts += 1;
        match oracle::run_group(api, cases, settings, &mut on_case) {
            Ok(outcome) => {
                if let Some(kind) = reproduced(&outcome) {
                    report.reproduced += 1;
                    if !report.kinds.contains(&kind) {
                        report.kinds.push(kind);
                    }
                }
            }
            // No driver, or the API could not be brought up. Not evidence either way,
            // and counting it as "did not reproduce" would be a lie about the run.
            Err(e) => {
                log::warn!("attempt {attempt} could not run: {e}");
                report.attempts -= 1;
            }
        }
    }

    report
}

/// What a case does when it is the only thing in its process.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alone {
    pub status: String,
    pub message: String,
    pub checked_epoch: u64,
}

impl Alone {
    pub fn passes(&self) -> bool {
        self.status == TestResult::Pass.as_str()
    }
}

/// The per-machine record of how cases behave on their own.
///
/// Lives beside the campaigns rather than inside one, because it is a fact about this
/// driver and this board, not about a campaign - and a new campaign that had to
/// rediscover all of it would spend its first hour re-running cases whose answer is
/// already written down. It is also, deliberately, not committed anywhere: the same
/// case behaves differently on lavapipe and on a Vivante GC2000.
pub struct Baseline {
    path: PathBuf,
    cases: BTreeMap<String, Alone>,
    dirty: bool,
}

impl Baseline {
    pub fn load(base_dir: &Path) -> Self {
        let path = base_dir.join("baseline.json");
        let cases = std::fs::read_to_string(&path)
            .ok()
            .and_then(|text| serde_json::from_str(&text).ok())
            .unwrap_or_default();
        Self {
            path,
            cases,
            dirty: false,
        }
    }

    pub fn get(&self, name: &str) -> Option<&Alone> {
        self.cases.get(name)
    }

    pub fn len(&self) -> usize {
        self.cases.len()
    }

    pub fn is_empty(&self) -> bool {
        self.cases.is_empty()
    }

    /// Runs `name` on its own unless the answer is already known.
    ///
    /// Returns `None` when the run could not happen at all - no driver, say - which is
    /// different from "it passed" and must not be cached as an answer.
    pub fn verify(&mut self, api: Api, name: &str, settings: &Settings) -> Option<&Alone> {
        if !self.cases.contains_key(name) {
            let list = [name.to_string()];
            let outcome = oracle::run_group(api, &list, settings, |_| {}).ok()?;
            let result = outcome.results.first()?;
            self.cases.insert(
                name.to_string(),
                Alone {
                    status: result.status.as_str().to_string(),
                    message: result.message.clone(),
                    checked_epoch: now_epoch(),
                },
            );
            self.dirty = true;
        }
        self.cases.get(name)
    }

    /// Writes the table back if anything was learned. Cheap to call after every group.
    pub fn save(&mut self) -> std::io::Result<()> {
        if !self.dirty {
            return Ok(());
        }
        let text = serde_json::to_string_pretty(&self.cases).map_err(std::io::Error::other)?;
        write_atomic(&self.path, &text)?;
        self.dirty = false;
        Ok(())
    }
}

/// Runs a finding's saved list again and folds the result into what is already known
/// about it.
///
/// Deliberately not routed through `Runner`: opening a campaign refuses once the corpus
/// has moved, and a finding has to stay replayable long after that - which is the whole
/// reason it carries its own case list rather than a seed.
pub fn replay_finding(
    store: &Store,
    campaign: &super::store::Campaign,
    id: u32,
    attempts: u32,
    whole_group: bool,
    mut on_attempt: impl FnMut(u32),
) -> std::io::Result<ReproReport> {
    let mut finding = store.read_finding(id)?;
    let list = store.read_finding_list(id, whole_group)?;
    if list.is_empty() {
        return Err(std::io::Error::other(format!("finding {id} has an empty case list")));
    }
    let api = Api::from_case_name(&finding.api)
        .ok_or_else(|| std::io::Error::other(format!("finding {id} names no known API: {}", finding.api)))?;

    let settings = Settings {
        device_id: campaign.device_id,
        validation: campaign.validation,
        timeout: std::time::Duration::from_secs(campaign.timeout_secs),
    };

    // An attempt can take the machine down, so it is bracketed the same way a group is.
    store.begin_inflight(&Inflight {
        phase: super::campaign::PHASE_VERIFY.to_string(),
        started_epoch: now_epoch(),
        api: finding.api.clone(),
        epoch: 0,
        epoch_seed: 0,
        group: 0,
        size: list.len(),
        pool_fingerprint: 0,
        finding: Some(id),
    })?;

    // The same progress file a group keeps, for the same reason: the attempt that takes
    // the machine down is the one whose "how far did it get" nobody else can answer.
    let path = store.progress_path();
    let progress = std::cell::RefCell::new(super::campaign::ProgressFile::open(&path));
    let report = gate(
        api,
        &list,
        attempts,
        &settings,
        reproduction_test(&finding),
        |n| {
            on_attempt(n);
            progress.borrow_mut().restart(&path);
        },
        |r| progress.borrow_mut().record(&r.name),
    );
    store.end_inflight()?;

    // Folded in rather than replacing: every attempt ever made at this finding is
    // evidence about it, and a fresh 0/3 today does not unmake a 3/3 last week.
    finding.repro.attempts += report.attempts;
    finding.repro.reproduced += report.reproduced;
    for kind in &report.kinds {
        if !finding.repro.kinds.contains(kind) {
            finding.repro.kinds.push(kind.clone());
        }
    }
    store.update_finding(&finding)?;

    Ok(report)
}

/// What counts as "it happened again", which depends on what happened the first time.
///
/// For a crash it is the worker dying. For an order-dependent failure it is that one
/// named case failing in company - the group as a whole finishing perfectly well is
/// exactly what is expected there, and treating that as "did not reproduce" would
/// confirm nothing that class of finding ever claimed.
pub fn reproduction_test(finding: &super::store::Finding) -> impl Fn(&oracle::GroupOutcome) -> Option<String> + use<> {
    let case = finding.culprit.clone().unwrap_or_default();
    let wants_fail = finding.kind == ORDER_DEPENDENT_FAIL;
    move |outcome: &oracle::GroupOutcome| {
        if wants_fail {
            outcome
                .results
                .iter()
                .find(|r| r.name == case && r.status == TestResult::Fail)
                .map(|_| TestResult::Fail.as_str().to_string())
        } else {
            outcome.culprit.as_ref().map(|c| c.status.as_str().to_string())
        }
    }
}

/// The `kind` of a finding where a case fails only in company.
pub const ORDER_DEPENDENT_FAIL: &str = "order-dependent-fail";

/// A case that failed inside a group but passes on its own.
pub struct OrderDependent {
    pub case: String,
    pub message: String,
}

/// Sorts a group's failures into the ones worth a finding and the ones that are just
/// broken cases.
///
/// Anything the baseline cannot answer - because the verification itself could not run -
/// is left out rather than guessed at in either direction.
pub fn order_dependent_failures(
    api: Api,
    results: &[crate::report::CaseResult],
    baseline: &mut Baseline,
    settings: &Settings,
) -> Vec<OrderDependent> {
    let failed: Vec<&crate::report::CaseResult> = results.iter().filter(|r| r.status == TestResult::Fail).collect();
    let mut found = Vec::new();

    for result in failed {
        let Some(alone) = baseline.verify(api, &result.name, settings) else {
            continue;
        };
        if alone.passes() {
            found.push(OrderDependent {
                case: result.name.clone(),
                message: result.message.clone(),
            });
        }
    }

    found
}

#[cfg(test)]
mod tests {
    use super::*;

    fn report(attempts: u32, reproduced: u32) -> ReproReport {
        ReproReport {
            attempts,
            reproduced,
            kinds: vec![],
        }
    }

    #[test]
    fn a_rate_is_reproductions_over_attempts() {
        assert_eq!(report(3, 3).summary(), "3/3 (100%)");
        assert_eq!(report(3, 1).summary(), "1/3 (33%)");
        assert_eq!(report(5, 0).summary(), "0/5 (0%)");
    }

    /// Zero attempts happens when every attempt failed to run at all - no driver. It is
    /// not a 0% reproduction rate, and dividing by it would say it was.
    #[test]
    fn no_attempts_is_not_a_zero_percent_rate() {
        assert_eq!(report(0, 0).rate(), 0.0);
        assert!(!report(0, 0).is_reproducible());
        assert_eq!(report(0, 0).summary(), "0/0 (0%)");
    }

    #[test]
    fn anything_that_reproduced_even_once_counts_as_reproducible() {
        assert!(report(10, 1).is_reproducible());
        assert!(!report(10, 0).is_reproducible());
    }

    #[test]
    fn a_case_that_passes_alone_is_the_one_worth_reporting() {
        let alone = |status: &str| Alone {
            status: status.to_string(),
            message: String::new(),
            checked_epoch: 0,
        };
        assert!(alone("Pass").passes());
        assert!(!alone("Fail").passes());
        assert!(!alone("NotSupported").passes());
    }

    #[test]
    fn a_baseline_round_trips_through_its_file() {
        let dir = std::env::temp_dir().join(format!("hodow-baseline-test-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();

        let mut baseline = Baseline::load(&dir);
        assert!(baseline.is_empty());
        baseline.cases.insert(
            "dEQP-GLES2.a".to_string(),
            Alone {
                status: "Fail".to_string(),
                message: "broken".to_string(),
                checked_epoch: 7,
            },
        );
        baseline.dirty = true;
        baseline.save().unwrap();

        let reloaded = Baseline::load(&dir);
        assert_eq!(reloaded.len(), 1);
        assert_eq!(reloaded.get("dEQP-GLES2.a").map(|a| a.status.as_str()), Some("Fail"));
        assert!(!reloaded.get("dEQP-GLES2.a").unwrap().passes());

        let _ = std::fs::remove_dir_all(&dir);
    }

    /// A corrupt file must not stop a campaign: the table is a cache, and the worst a
    /// lost one costs is re-running some single cases.
    #[test]
    fn an_unreadable_baseline_starts_empty_rather_than_failing() {
        let dir = std::env::temp_dir().join(format!("hodow-baseline-bad-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        std::fs::write(dir.join("baseline.json"), "{not json").unwrap();
        assert!(Baseline::load(&dir).is_empty());
        let _ = std::fs::remove_dir_all(&dir);
    }
}
