// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The loop, and the resume that puts it back together after the machine goes down.
//
// Every iteration is: write down what is about to run, run it, write down what it did,
// erase the note. The note is the whole mechanism - it is fsynced before the group
// starts, so finding one at start-up is proof that the previous process did not reach
// the end of the group the note describes. What that means is not the fuzzer's to
// decide: only a person knows whether the board wedged, the machine panicked, or they
// hit Ctrl-C. That verdict arrives with the resume verb.

use std::io::Write;
use std::path::{Path, PathBuf};
use std::time::{Duration, Instant};

use super::health::{self, Health};
use super::minimize::{self, Budget, MinimizeState};
use super::oracle::{self, Settings};
use super::pool::{self, Pool};
use super::quarantine::Quarantine;
use super::store::{
    ApiState, Campaign, Finding, Inflight, IterationRecord, JournalEntry, PoolInfo, State, Store, ago, now_epoch,
};
use super::triage::{self, Baseline, ReproReport};
use super::{drift, rng};
use crate::report::{CaseResult, Summary};
use crate::runner::Api;
use crate::tcu::TestResult;

/// The in-flight phase that means "re-running a finding's list", as opposed to running
/// a fresh group. The two are settled completely differently after a hard death.
pub const PHASE_VERIFY: &str = "verify";

/// The in-flight phase that means "testing one candidate of a minimisation". A hard
/// death here is not a lost step - it is that candidate answering yes.
pub const PHASE_MINIMIZE: &str = "minimize";

/// Wall-clock cap on one minimisation, alongside the oracle-call budget. Two hours is
/// long enough for a slow board to get somewhere and short enough that one nasty bug
/// cannot swallow a campaign that was meant to keep sweeping.
const MINIMIZE_WALL_SECS: u64 = 2 * 3600;

/// How many individual moved verdicts go into the journal when an epoch is compared.
/// The grouped summary carries the shape; a thousand lines would bury everything else.
const DRIFT_LOGGED: usize = 50;

/// What a person says happened while the fuzzer was not looking.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Verdict {
    /// The in-flight group is presumed to have taken the machine with it. This is the
    /// default because it is overwhelmingly what a vanished supervisor means.
    Reproduced(Severity),
    /// It was not the test: a Ctrl-C, a pulled cable, a deliberate reboot.
    Fine,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Severity {
    /// Nothing more specific was claimed.
    Unspecified,
    GpuHang,
    SystemDown,
}

impl Severity {
    fn label(self) -> Option<&'static str> {
        match self {
            Self::Unspecified => None,
            Self::GpuHang => Some("gpu-hang"),
            Self::SystemDown => Some("system-down"),
        }
    }
}

pub struct Runner {
    store: Store,
    campaign: Campaign,
    pools: Vec<Pool>,
    state: State,
    /// Shared across every campaign on this machine: how cases behave on their own is a
    /// fact about this driver, not about one run.
    baseline: Baseline,
    quarantine: Quarantine,
}

/// Why the loop stopped, which is what the exit code and the closing message are made of.
pub enum Stopped {
    BudgetSpent,
    PoolExhausted,
    NeedsAttention(String),
    DriverUnavailable(String),
}

impl Runner {
    /// Creates a campaign directory and points `current` at it.
    pub fn create(base_dir: PathBuf, label: String, settings: NewCampaign) -> std::io::Result<Self> {
        let pools = pool::build(&settings.case_filters, &settings.exclude_filters);
        if pools.is_empty() {
            return Err(std::io::Error::other(
                "no cases matched - try --case, or `hodow_cts --list` to see what there is",
            ));
        }

        let campaign = Campaign {
            label: label.clone(),
            created_epoch: now_epoch(),
            hodow_cts_version: env!("CARGO_PKG_VERSION").to_string(),
            upstream_revision: crate::runner::UPSTREAM_REVISION.trim().to_string(),
            seed: settings.seed,
            group_size: settings.group_size.max(1),
            case_filters: settings.case_filters,
            exclude_filters: settings.exclude_filters,
            device_id: settings.device_id,
            validation: settings.validation,
            timeout_secs: settings.timeout_secs,
            wedge_threshold: settings.wedge_threshold,
            repro_attempts: settings.repro_attempts.max(1),
            use_quarantine: settings.use_quarantine,
            minimize_budget: settings.minimize_budget,
            repeats: settings.repeats.max(1),
            replicas: settings.replicas.max(1),
            jobs: settings.jobs.max(1),
            pools: pools
                .iter()
                .map(|p| PoolInfo {
                    root: p.api.root().to_string(),
                    cases: p.names.len(),
                    fingerprint: p.fingerprint,
                })
                .collect(),
        };

        let state = State {
            apis: pools
                .iter()
                .map(|p| ApiState {
                    root: p.api.root().to_string(),
                    epoch: 1,
                    epoch_seed: rng::derive(campaign.seed, p.api.root(), 1),
                    group: 0,
                })
                .collect(),
            ..State::default()
        };

        let store = Store::new(base_dir.join(&label));
        store.create(&campaign)?;
        store.write_state(&state)?;
        store.append_journal(&JournalEntry::new(
            "created",
            format!("seed {:#018x}, group size {}", campaign.seed, campaign.group_size),
        ))?;
        point_current_at(&base_dir, &label)?;

        Ok(Self {
            store,
            campaign,
            pools,
            state,
            baseline: Baseline::load(&base_dir),
            quarantine: load_quarantine(&base_dir, settings.use_quarantine),
        })
    }

    /// Opens an existing campaign, rebuilding its pools from the filters it recorded.
    ///
    /// A pool whose fingerprint has moved since the campaign was created is fatal
    /// rather than a warning: every stored `(epoch_seed, group)` names a different set
    /// of cases now, so resuming would carry on testing something else under the old
    /// campaign's name and its findings would stop meaning what they say.
    pub fn open(dir: PathBuf) -> std::io::Result<Self> {
        let base_dir = dir.parent().unwrap_or(Path::new(".")).to_path_buf();
        let store = Store::new(dir);
        let campaign = store.read_campaign()?;
        let state = store.read_state()?;
        let pools = pool::build(&campaign.case_filters, &campaign.exclude_filters);

        for expected in &campaign.pools {
            let found = pools.iter().find(|p| p.api.root() == expected.root);
            match found {
                Some(p) if p.fingerprint == expected.fingerprint => {}
                Some(p) => {
                    return Err(std::io::Error::other(format!(
                        "{} has changed since this campaign started ({} cases then, {} now) - every stored seed \
                         now names a different group, so this campaign cannot be resumed against this binary. \
                         Its findings stay valid: each one holds its own case list.",
                        expected.root,
                        expected.cases,
                        p.names.len()
                    )));
                }
                None => {
                    return Err(std::io::Error::other(format!(
                        "{} has no cases at all in this binary any more",
                        expected.root
                    )));
                }
            }
        }

        Ok(Self {
            store,
            pools,
            state,
            baseline: Baseline::load(&base_dir),
            quarantine: load_quarantine(&base_dir, campaign.use_quarantine),
            campaign,
        })
    }

    pub fn store(&self) -> &Store {
        &self.store
    }
    pub fn campaign(&self) -> &Campaign {
        &self.campaign
    }
    pub fn state(&self) -> &State {
        &self.state
    }

    /// Settles whatever was in flight when the previous process disappeared.
    ///
    /// Returns what was done, for the caller to print. Doing nothing is the normal case
    /// - a campaign that stopped cleanly has no in-flight record.
    pub fn settle(&mut self, verdict: Verdict) -> std::io::Result<Option<String>> {
        let Some(inflight) = self.store.read_inflight() else {
            return Ok(None);
        };

        if let (PHASE_VERIFY, Some(id)) = (inflight.phase.as_str(), inflight.finding) {
            return self.settle_verification(&inflight, id, verdict).map(Some);
        }
        if let (PHASE_MINIMIZE, Some(id)) = (inflight.phase.as_str(), inflight.finding) {
            return self.settle_minimization(&inflight, id, verdict).map(Some);
        }

        let completed = self.store.read_progress();
        let age = ago(inflight.started_epoch);
        let cases = self.group_for(&inflight);

        let message = match verdict {
            Verdict::Fine => {
                self.store.append_journal(&JournalEntry::new(
                    "settled",
                    format!(
                        "{} group {} of {}: not the test's doing, discarded",
                        inflight.api, inflight.group, inflight.epoch
                    ),
                ))?;
                format!(
                    "the in-flight group from {age} ({}, epoch {} group {}, {} of {} cases reported) is being \
                     discarded, not recorded - you said it was not the test",
                    inflight.api,
                    inflight.epoch,
                    inflight.group,
                    completed,
                    cases.len()
                )
            }
            Verdict::Reproduced(severity) => {
                let id = self.next_finding_id();
                let finding = Finding {
                    id,
                    kind: "machine-died".to_string(),
                    severity: severity.label().map(str::to_string),
                    detected_epoch: inflight.started_epoch,
                    api: inflight.api.clone(),
                    epoch: inflight.epoch,
                    epoch_seed: inflight.epoch_seed,
                    group: inflight.group,
                    size: cases.len(),
                    culprit: cases.get(completed).cloned(),
                    message: format!("the machine did not come back; the supervisor vanished {age}"),
                    completed,
                    // The progress file is not fsynced per case, so after a hard death
                    // its tail is whatever writeback had reached. A lower bound.
                    completed_exact: false,
                    // A machine that did not come back is its own first reproduction.
                    repro: ReproReport {
                        attempts: 1,
                        reproduced: 1,
                        kinds: vec!["machine-died".to_string()],
                    },
                };
                let dir = self.store.write_finding(&finding, &cases)?;
                self.state.findings = self.state.findings.max(id);
                self.state.consecutive_crashes += 1;
                self.store.append_journal(&JournalEntry::new(
                    "settled",
                    format!(
                        "finding {id}: {} group {} killed the machine{}",
                        inflight.api,
                        inflight.group,
                        severity.label().map(|s| format!(" ({s})")).unwrap_or_default()
                    ),
                ))?;
                format!(
                    "recorded finding {id} ({}) - {} of {} cases had reported, so the case in flight was\n  {}\n  {}",
                    severity.label().unwrap_or("machine died"),
                    completed,
                    cases.len(),
                    finding
                        .culprit
                        .clone()
                        .unwrap_or_else(|| "(past the end of the group)".to_string()),
                    dir.display()
                )
            }
        };

        // Either way the group is spent: rerunning it now would be a replay nobody
        // asked for, and `fuzz replay` will exist for when that is what is wanted.
        self.advance_past(&inflight.api);
        self.state.stopped = None;
        self.store.write_state(&self.state)?;
        self.store.end_inflight()?;
        Ok(Some(message))
    }

    /// The machine went down while *reproducing* an existing finding.
    ///
    /// That is not a new finding - it is the strongest possible answer to the question
    /// the attempt was asking. The cursor does not move either: the group it came from
    /// was accounted for when it first ran.
    fn settle_verification(&mut self, inflight: &Inflight, id: u32, verdict: Verdict) -> std::io::Result<String> {
        let age = ago(inflight.started_epoch);
        let mut finding = self.store.read_finding(id)?;
        // Where the attempt got to before it died. The list is the finding's own, so
        // this names a case - and on a driver whose hang costs a reboot, that single
        // line is worth more than the whole attempt.
        // Whichever of the two saved lists is the length the attempt actually ran -
        // `replay --full` takes the whole group, everything else the prefix.
        let reached = self.store.read_progress();
        let reached_case = [false, true]
            .into_iter()
            .find_map(|whole| {
                self.store
                    .read_finding_list(id, whole)
                    .ok()
                    .filter(|l| l.len() == inflight.size)
            })
            .and_then(|list| list.get(reached).cloned());

        let message = match verdict {
            Verdict::Fine => {
                self.store.append_journal(&JournalEntry::new(
                    "settled",
                    format!("verification of finding {id}: not the test's doing, discarded"),
                ))?;
                format!("an attempt from {age} at reproducing finding {id} was interrupted - not counted either way")
            }
            Verdict::Reproduced(severity) => {
                finding.repro.attempts += 1;
                finding.repro.reproduced += 1;
                let kind = "machine-died".to_string();
                if !finding.repro.kinds.contains(&kind) {
                    finding.repro.kinds.push(kind);
                }
                // A severity claimed now describes the finding, not just this attempt;
                // an earlier, milder one is not evidence against it.
                if let Some(label) = severity.label() {
                    finding.severity = Some(label.to_string());
                }
                self.store.update_finding(&finding)?;
                let where_it_got_to = match &reached_case {
                    Some(case) => format!(
                        "\n  it had reported {reached} of {} cases, so the one in flight was\n  {case}",
                        inflight.size
                    ),
                    None => String::new(),
                };
                self.store.append_journal(&JournalEntry::new(
                    "settled",
                    format!(
                        "finding {id} reproduced: the attempt from {age} killed the machine{}",
                        reached_case.as_ref().map(|c| format!(" at {c}")).unwrap_or_default()
                    ),
                ))?;
                format!(
                    "finding {id} reproduced - the attempt from {age} took the machine with it, now {}{where_it_got_to}",
                    finding.repro.summary()
                )
            }
        };

        self.state.stopped = None;
        self.store.write_state(&self.state)?;
        self.store.end_inflight()?;
        Ok(message)
    }

    /// The machine went down mid-minimisation.
    ///
    /// That is not a lost step - it is the candidate that was being tested answering
    /// yes, as emphatically as anything can. The candidate itself was never written
    /// down and does not need to be: the saved state is indices, so the same list falls
    /// straight back out of it.
    fn settle_minimization(&mut self, inflight: &Inflight, id: u32, verdict: Verdict) -> std::io::Result<String> {
        let age = ago(inflight.started_epoch);
        let Some(mut state) = minimize::load_state(&self.store, id) else {
            self.store.end_inflight()?;
            return Ok(format!(
                "a minimisation of finding {id} was interrupted {age}, but it left no state to resume from"
            ));
        };

        let message = match verdict {
            Verdict::Fine => {
                self.store.append_journal(&JournalEntry::new(
                    "settled",
                    format!("minimisation of finding {id}: interrupted, step discarded"),
                ))?;
                format!(
                    "the minimisation step of finding {id} from {age} was interrupted - not counted, it will simply be tried again"
                )
            }
            Verdict::Reproduced(_) => match minimize::record_death_as_reproduction(&mut state) {
                Some(candidate) => {
                    minimize::save_state(&self.store, &state)?;
                    minimize::write_repro(&self.store, &state)?;
                    self.store.append_journal(&JournalEntry::new(
                        "settled",
                        format!("minimisation of finding {id}: the step in flight killed the machine, so it counts - now {} cases", candidate.len()),
                    ))?;
                    format!(
                        "the minimisation step of finding {id} from {age} took the machine with it, which is the answer it was asking for -\n  \
                         {} case(s) now, `fuzz minimize {id}` carries on",
                        candidate.len()
                    )
                }
                None => format!("finding {id} had no minimisation step in flight to credit"),
            },
        };

        self.state.stopped = None;
        self.store.write_state(&self.state)?;
        self.store.end_inflight()?;
        Ok(message)
    }

    /// The group the next iteration would run, without running it.
    ///
    /// `selftest` needs this: to check that a poisoning fault is minimised to the case
    /// that *caused* it rather than the one that died, it has to know which case follows
    /// which before it injects anything.
    pub fn peek_next_group(&mut self) -> Option<Vec<String>> {
        let index = self.pick_api()?;
        self.roll_epoch_if_needed(index);
        let state = &self.state.apis[index];
        Some(self.pools[index].group(
            state.epoch_seed,
            state.group,
            self.campaign.group_size,
            &self.quarantine,
        ))
    }

    /// Runs groups until the budget runs out, something needs a person, or forever.
    pub fn run_loop(
        &mut self,
        budget: Option<u64>,
        mut on_iteration: impl FnMut(&IterationRecord),
    ) -> std::io::Result<Stopped> {
        let mut done = 0u64;
        loop {
            if budget.is_some_and(|b| done >= b) {
                return Ok(Stopped::BudgetSpent);
            }
            let Some(index) = self.pick_api() else {
                return Ok(Stopped::PoolExhausted);
            };

            match self.run_one(index)? {
                Some(record) => {
                    on_iteration(&record);
                    done += 1;
                }
                None => continue,
            }

            if let Some(reason) = self.wedge_check() {
                self.state.stopped = Some(reason.clone());
                self.store.write_state(&self.state)?;
                self.store
                    .append_journal(&JournalEntry::new("stopped", reason.clone()))?;
                return Ok(Stopped::NeedsAttention(reason));
            }
        }
    }

    /// Runs the next group of API `index`. `None` means the group was empty and the
    /// cursor moved on - nothing ran, so it does not count against the budget.
    fn run_one(&mut self, index: usize) -> std::io::Result<Option<IterationRecord>> {
        self.roll_epoch_if_needed(index);

        let api = self.pools[index].api;
        let api_state = self.state.apis[index].clone();
        let drawn = self.pools[index].group(
            api_state.epoch_seed,
            api_state.group,
            self.campaign.group_size,
            &self.quarantine,
        );
        if drawn.is_empty() {
            self.state.apis[index].group += 1;
            return Ok(None);
        }

        // `--repeats` before `--jobs`: the repetition is what accumulates state inside
        // one process, so it has to be part of each worker's list rather than a way of
        // handing the same list to several workers.
        let group = oracle::repeated(&drawn, self.campaign.repeats);
        let lists = oracle::split(&group, self.campaign.jobs);

        let inflight = Inflight {
            phase: "group".to_string(),
            started_epoch: now_epoch(),
            api: api.root().to_string(),
            epoch: api_state.epoch,
            epoch_seed: api_state.epoch_seed,
            group: api_state.group,
            size: group.len(),
            pool_fingerprint: self.pools[index].fingerprint,
            finding: None,
        };
        self.store.begin_inflight(&inflight)?;

        let started = Instant::now();
        let run = self.run_replicas(api, &lists);
        let duration_s = started.elapsed().as_secs_f64();

        let run = match run {
            Ok(run) => run,
            Err(e) => {
                self.store.end_inflight()?;
                if oracle::is_driver_unavailable(e.as_ref()) {
                    let reason = format!("{} is not usable here - nothing was run", api.label());
                    self.state.stopped = Some(reason.clone());
                    self.store.write_state(&self.state)?;
                    self.store
                        .append_journal(&JournalEntry::new("driver-unavailable", reason))?;
                }
                return Err(std::io::Error::other(e.to_string()));
            }
        };
        // The list the finding has to name is the one the *dying worker* was running,
        // not the whole group: with `--jobs` the others were somewhere else entirely.
        let cases = run.dying_list.clone().unwrap_or(group);
        let outcome = &run.outcome;

        self.store.end_inflight()?;
        self.record_epoch_status(index, &run.all_results)?;
        self.state.iterations += 1;
        self.state.apis[index].group += 1;
        self.state.next_api = (index + 1) % self.pools.len();

        let mut finding_id = None;
        if let Some(culprit) = &outcome.culprit {
            let mut finding = Finding {
                id: self.next_finding_id(),
                kind: kind_of(culprit.status),
                severity: None,
                detected_epoch: now_epoch(),
                api: api.root().to_string(),
                epoch: api_state.epoch,
                epoch_seed: api_state.epoch_seed,
                group: api_state.group,
                size: cases.len(),
                culprit: Some(culprit.name.clone()),
                message: culprit.message.clone(),
                completed: outcome.completed,
                // The supervisor watched this one happen and counted the verdicts
                // itself, so unlike a machine that never came back, this is exact.
                completed_exact: true,
                repro: ReproReport::default(),
            };
            let id = finding.id;
            self.store.write_finding(&finding, &cases)?;
            self.state.findings = self.state.findings.max(id);
            self.state.consecutive_crashes += 1;
            finding_id = Some(id);

            // Straight away, while the driver is still in whatever state produced this.
            // A rate measured tomorrow, after a reboot, is a different measurement.
            let prefix = cases[..(outcome.completed + 1).min(cases.len())].to_vec();
            finding.repro = self.reproduce(id, api, &prefix, |o| {
                o.culprit.as_ref().map(|c| c.status.as_str().to_string())
            })?;
            self.store.update_finding(&finding)?;
            self.store.append_journal(&JournalEntry::new(
                "finding",
                format!(
                    "{id}: {} in {}, reproduced {}",
                    finding.kind,
                    culprit.name,
                    finding.repro.summary()
                ),
            ))?;

            // A crash found with other workers alive alongside it might be an ordinary
            // bug that contention merely brought forward, or a genuine race. Serially
            // first, because if it reproduces that way it is the former - and then
            // everything downstream is simple and repeatable.
            if run.parallel && !finding.repro.is_reproducible() {
                finding.severity = Some("race".to_string());
                finding.repro = self.reproduce_in_parallel(id, api, &lists)?;
                self.store.update_finding(&finding)?;
            }

            // Only what reproduces. Shrinking a list against an oracle that never says
            // yes yields a short, confident answer that means nothing - and a race has
            // no stable list to shrink in the first place.
            if finding.repro.is_reproducible() && finding.severity.as_deref() != Some("race") {
                self.minimize_finding(id, false)?;
            }
        } else {
            self.state.consecutive_crashes = 0;
        }

        for id in self.record_order_dependent_failures(api, &run.all_results, &cases, &api_state)? {
            self.store.append_journal(&JournalEntry::new(
                "finding",
                format!("{id}: a case that passes alone failed in this group"),
            ))?;
        }
        for id in self.record_flaky_verdicts(api, &run, &cases, &api_state)? {
            self.store.append_journal(&JournalEntry::new(
                "finding",
                format!("{id}: a case did not give the same verdict twice"),
            ))?;
        }

        let record = IterationRecord {
            n: self.state.iterations,
            api: api.root().to_string(),
            epoch: api_state.epoch,
            epoch_seed: api_state.epoch_seed,
            group: api_state.group,
            size: cases.len(),
            outcome: outcome
                .culprit
                .as_ref()
                .map(|c| kind_of(c.status))
                .unwrap_or_else(|| "ok".to_string()),
            passed: outcome.summary.passed,
            failed: outcome.summary.failed,
            not_supported: outcome.summary.not_supported,
            warnings: outcome.summary.warnings,
            crashed: outcome.summary.crashed + outcome.summary.timed_out,
            other: outcome.summary.other,
            culprit: outcome.culprit.as_ref().map(|c| c.name.clone()),
            finding: finding_id,
            duration_s,
        };
        self.store.append_iteration(&record)?;
        self.store.write_state(&self.state)?;
        Ok(Some(record))
    }

    /// One iteration's worth of running: `--replicas` passes, each split across
    /// `--jobs` workers, stopping the moment anything dies.
    ///
    /// Stopping early is not impatience: the gate is about to re-run this anyway, and
    /// further replicas after a crash would be running against a driver that has just
    /// been restarted - a different experiment wearing the same label.
    fn run_replicas(&self, api: Api, lists: &[Vec<String>]) -> Result<Run, Box<dyn std::error::Error>> {
        let settings = self.settings();
        let mut run = Run::default();

        for _ in 0..self.campaign.replicas.max(1) {
            let outcomes = if lists.len() > 1 {
                oracle::run_parallel(api, lists, &settings)
            } else {
                let mut progress = ProgressFile::open(&self.store.progress_path());
                vec![
                    oracle::run_group(api, &lists[0], &settings, |r: &CaseResult| progress.record(&r.name))
                        .map_err(|e| e.to_string()),
                ]
            };

            for (worker, outcome) in outcomes.into_iter().enumerate() {
                let outcome = outcome.map_err(std::io::Error::other)?;
                run.summary.merge(&outcome.summary);
                run.all_results.extend(outcome.results.iter().cloned());
                if outcome.culprit.is_some() && run.outcome.culprit.is_none() {
                    run.dying_list = Some(lists[worker].clone());
                    run.parallel = lists.len() > 1;
                    run.outcome = outcome;
                }
            }
            run.replicas += 1;
            if run.outcome.culprit.is_some() {
                break;
            }
        }

        // The merged summary is what the iteration line reports; the outcome's own is
        // only one worker's share of it.
        run.outcome.summary = run.summary.clone();
        Ok(run)
    }

    /// Re-runs the whole split, workers and all, for a finding that would not reproduce
    /// serially.
    ///
    /// There is no shorter list to try: what is being reproduced is an interleaving, and
    /// the only handle on it is the arrangement that produced it. Expect a rate well
    /// under 1 - a race that reproduced 2/5 is still a finding, and the rate is the
    /// number that says how much patience it will take.
    fn reproduce_in_parallel(&mut self, id: u32, api: Api, lists: &[Vec<String>]) -> std::io::Result<ReproReport> {
        let attempts = self.campaign.repro_attempts.max(1);
        self.store.begin_inflight(&Inflight {
            phase: PHASE_VERIFY.to_string(),
            started_epoch: now_epoch(),
            api: api.root().to_string(),
            epoch: 0,
            epoch_seed: 0,
            group: 0,
            size: lists.iter().map(Vec::len).sum(),
            pool_fingerprint: 0,
            finding: Some(id),
        })?;

        let settings = self.settings();
        let mut report = ReproReport::default();
        for attempt in 1..=attempts {
            log::info!("finding {id}: parallel reproduction attempt {attempt} of {attempts}");
            report.attempts += 1;
            let outcomes = oracle::run_parallel(api, lists, &settings);
            if let Some(kind) = outcomes
                .iter()
                .flatten()
                .find_map(|o| o.culprit.as_ref())
                .map(|c| c.status.as_str().to_string())
            {
                report.reproduced += 1;
                if !report.kinds.contains(&kind) {
                    report.kinds.push(kind);
                }
            }
        }

        self.store.end_inflight()?;
        Ok(report)
    }

    /// Records cases that did not give the same verdict twice.
    ///
    /// Two sources, both free: `--repeats` puts a case in one process several times, and
    /// `--replicas` puts the identical list through several processes. Either way a name
    /// with two different verdicts is saying something the totals cannot.
    ///
    /// Not minimised and not gated further: what would be shrunk is not a sequence, and
    /// the observations here already are the evidence. `fuzz replay` asks again.
    fn record_flaky_verdicts(
        &mut self,
        api: Api,
        run: &Run,
        cases: &[String],
        api_state: &ApiState,
    ) -> std::io::Result<Vec<u32>> {
        let mut seen: Vec<(&str, Vec<TestResult>)> = Vec::new();
        for result in &run.all_results {
            match seen.iter_mut().find(|(name, _)| *name == result.name) {
                Some((_, statuses)) if !statuses.contains(&result.status) => statuses.push(result.status),
                Some(_) => {}
                None => seen.push((result.name.as_str(), vec![result.status])),
            }
        }

        let mut ids = Vec::new();
        for (name, statuses) in seen.into_iter().filter(|(_, s)| s.len() > 1) {
            let verdicts: Vec<&str> = statuses.iter().map(|s| s.as_str()).collect();
            let observations = run.all_results.iter().filter(|r| r.name == name).count() as u32;
            let finding = Finding {
                id: self.next_finding_id(),
                kind: "flaky-verdict".to_string(),
                severity: None,
                detected_epoch: now_epoch(),
                api: api.root().to_string(),
                epoch: api_state.epoch,
                epoch_seed: api_state.epoch_seed,
                group: api_state.group,
                size: cases.len(),
                culprit: Some(name.to_string()),
                message: format!(
                    "gave {} different verdicts in one iteration: {}",
                    statuses.len(),
                    verdicts.join(", ")
                ),
                completed: cases.iter().position(|c| c == name).unwrap_or(0),
                completed_exact: true,
                // The observations are the evidence, so they are what the rate reports:
                // how many of them agreed with the verdict that was not the first one.
                repro: ReproReport {
                    attempts: observations,
                    reproduced: observations.saturating_sub(1).min(observations),
                    kinds: verdicts.iter().map(|s| (*s).to_string()).collect(),
                },
            };
            let id = finding.id;
            self.store.write_finding(&finding, cases)?;
            self.state.findings = self.state.findings.max(id);
            ids.push(id);
        }
        Ok(ids)
    }

    /// Folds a group's verdicts into this epoch's status vector, so the next epoch has
    /// something to compare against.
    fn record_epoch_status(&self, index: usize, results: &[CaseResult]) -> std::io::Result<()> {
        let pool = &self.pools[index];
        let api_state = &self.state.apis[index];
        let mut status = drift::EpochStatus::open(&self.store.dir, pool.api.root(), api_state.epoch, pool.names.len());
        status.record(results, &drift::index_of(&pool.names));
        status.save()
    }

    /// Shrinks a finding to the shortest list that still reproduces it, and excludes
    /// whatever turns out to be the trigger.
    ///
    /// Resumable: the state lives beside the finding and is written after every oracle
    /// call, so a bug that hangs the GPU can be minimised across a dozen resets. One
    /// in-flight record covers the whole run of it rather than one per step - the state
    /// file already says which step was in progress, and `record_death_as_reproduction`
    /// reconstructs the exact candidate from it.
    pub fn minimize_finding(&mut self, id: u32, whole_group: bool) -> std::io::Result<minimize::Outcome> {
        let finding = self.store.read_finding(id)?;
        let api = Api::from_case_name(&finding.api)
            .ok_or_else(|| std::io::Error::other(format!("finding {id} names no known API")))?;

        let mut state = match minimize::load_state(&self.store, id) {
            Some(state) => state,
            None => MinimizeState::new(id, &finding.api, self.store.read_finding_list(id, whole_group)?),
        };
        // A finished minimisation still has to reach the quarantine on its way out. The
        // entry is written once, at the moment the last step lands, so a finding that
        // got there under a different binary - or whose entry someone removed to ask a
        // new driver about it - would otherwise never be excluded again, and asking for
        // it a second time is the obvious thing to try.
        if state.is_done() {
            minimize::write_repro(&self.store, &state)?;
            self.quarantine_trigger(&state, &finding)?;
            return Ok(minimize::Outcome::Minimal);
        }

        self.store.begin_inflight(&Inflight {
            phase: PHASE_MINIMIZE.to_string(),
            started_epoch: now_epoch(),
            api: finding.api.clone(),
            epoch: 0,
            epoch_seed: 0,
            group: 0,
            size: state.current.len(),
            pool_fingerprint: 0,
            finding: Some(id),
        })?;

        let settings = self.settings();
        let attempts = self.campaign.repro_attempts.max(1);
        let budget = Budget {
            oracle_calls: self.campaign.minimize_budget,
            wall: Duration::from_secs(MINIMIZE_WALL_SECS),
        };

        let outcome = {
            let store = &self.store;
            minimize::run(
                &mut state,
                api,
                attempts,
                &settings,
                &budget,
                |state| minimize::save_state(store, state),
                |state, size, result| {
                    log::info!(
                        "finding {id}: {size} cases {} (call {})",
                        result.label(),
                        state.oracle_calls
                    );
                },
            )?
        };
        self.store.end_inflight()?;
        minimize::write_repro(&self.store, &state)?;

        if state.is_done() {
            self.quarantine_trigger(&state, &finding)?;
        }
        self.store.append_journal(&JournalEntry::new(
            "minimize",
            format!(
                "finding {id}: {} case(s) after {} oracle call(s)",
                state.current.len(),
                state.oracle_calls
            ),
        ))?;
        Ok(outcome)
    }

    /// Keeps the trigger out of future groups.
    ///
    /// The *first* element of the minimised list, never the casualty - see
    /// fuzz/quarantine.rs. The entry is written even when the campaign is running with
    /// `--no-quarantine`: that flag means "do not act on it", and throwing the knowledge
    /// away as well would make the next campaign rediscover the same thing.
    fn quarantine_trigger(&mut self, state: &MinimizeState, finding: &Finding) -> std::io::Result<Option<String>> {
        let Some(trigger) = minimize::trigger(state).cloned() else {
            return Ok(None);
        };
        let reason = minimize::quarantine_reason(state, finding);
        if self.quarantine.add(&trigger, &reason)? {
            self.store
                .append_journal(&JournalEntry::new("quarantine", format!("{trigger} ({reason})")))?;
            return Ok(Some(trigger));
        }
        Ok(None)
    }

    /// Re-runs a finding's list and records how often it does the same thing.
    ///
    /// Bracketed by an in-flight record of its own, because an attempt at reproducing a
    /// crash is itself a thing that can take the machine down - and when it does, that
    /// is the strongest answer the attempt could have given rather than a lost group,
    /// which is what `settle_verification` makes of it.
    fn reproduce(
        &mut self,
        id: u32,
        api: Api,
        list: &[String],
        reproduced: impl Fn(&oracle::GroupOutcome) -> Option<String>,
    ) -> std::io::Result<ReproReport> {
        let attempts = self.campaign.repro_attempts.max(1);
        let inflight = Inflight {
            phase: PHASE_VERIFY.to_string(),
            started_epoch: now_epoch(),
            api: api.root().to_string(),
            // The epoch coordinates describe where a *group* came from; a verification
            // runs a finding's saved list, which `finding` points at instead.
            epoch: 0,
            epoch_seed: 0,
            group: 0,
            size: list.len(),
            pool_fingerprint: 0,
            finding: Some(id),
        };
        self.store.begin_inflight(&inflight)?;

        let settings = self.settings();
        // The attempt's own progress, for the same reason a group keeps one: if this is
        // the attempt that takes the machine down, how far it got is the only thing left
        // to read, and on a driver whose hang needs a reboot it is worth more than the
        // attempt cost. A RefCell because both callbacks want it and only one at a time.
        let path = self.store.progress_path();
        let progress = std::cell::RefCell::new(ProgressFile::open(&path));
        let report = triage::gate(
            api,
            list,
            attempts,
            &settings,
            reproduced,
            |n| {
                log::info!("finding {id}: reproduction attempt {n} of {attempts}");
                progress.borrow_mut().restart(&path);
            },
            |r| progress.borrow_mut().record(&r.name),
        );

        self.store.end_inflight()?;
        Ok(report)
    }

    /// Records the group's failures that pass when run on their own.
    ///
    /// A Fail inside a thousand-case run looks like any other Fail, so this class of
    /// bug is invisible without asking the second question - and it is the same class
    /// as a crash, one case leaving the driver in a state the next one trips over.
    ///
    /// Takes every result of the iteration, not the dying worker's outcome: that one is
    /// empty whenever nothing died, which is most of the time and exactly when ordinary
    /// failures are what there is to look at.
    fn record_order_dependent_failures(
        &mut self,
        api: Api,
        results: &[CaseResult],
        cases: &[String],
        api_state: &ApiState,
    ) -> std::io::Result<Vec<u32>> {
        let settings = self.settings();
        let found = triage::order_dependent_failures(api, results, &mut self.baseline, &settings);
        self.baseline.save()?;

        let mut ids = Vec::new();
        for od in found {
            let completed = cases.iter().position(|c| *c == od.case).unwrap_or(0);
            let mut finding = Finding {
                id: self.next_finding_id(),
                kind: triage::ORDER_DEPENDENT_FAIL.to_string(),
                severity: None,
                detected_epoch: now_epoch(),
                api: api.root().to_string(),
                epoch: api_state.epoch,
                epoch_seed: api_state.epoch_seed,
                group: api_state.group,
                size: cases.len(),
                culprit: Some(od.case.clone()),
                message: format!("{} - but it passes when run on its own", od.message),
                completed,
                completed_exact: true,
                repro: ReproReport::default(),
            };
            let id = finding.id;
            self.store.write_finding(&finding, cases)?;
            self.state.findings = self.state.findings.max(id);

            // Gated like a crash is, and for the same reason: a merely flaky case would
            // otherwise look order-dependent every time it happened to fail in company.
            let prefix = cases[..=completed].to_vec();
            let case = od.case.clone();
            finding.repro = self.reproduce(id, api, &prefix, move |o| {
                o.results
                    .iter()
                    .find(|r| r.name == case && r.status == TestResult::Fail)
                    .map(|_| "Fail".to_string())
            })?;
            self.store.update_finding(&finding)?;
            ids.push(id);
        }

        Ok(ids)
    }

    /// Both wedge signals, checked only after a group that died - a healthy group is
    /// its own proof that the driver answers, and probing after one would be a second
    /// context bring-up per group for nothing.
    fn wedge_check(&mut self) -> Option<String> {
        if self.state.consecutive_crashes == 0 {
            return None;
        }
        if health::wedged_by_repetition(self.state.consecutive_crashes, self.campaign.wedge_threshold) {
            let n = self.state.consecutive_crashes;
            let groups = if n == 1 { "group" } else { "groups" };
            return Some(format!(
                "{n} {groups} died in a row - past what one bug explains, so everything from here would be noise"
            ));
        }

        let api = self.pools[self.state.next_api.min(self.pools.len() - 1)].api;
        match health::check(
            api,
            self.campaign.device_id,
            self.campaign.validation,
            Duration::from_secs(self.campaign.timeout_secs),
        ) {
            Health::Alive(_) => None,
            Health::Dead(why) => Some(format!("the {} driver no longer answers: {why}", api.root())),
        }
    }

    fn settings(&self) -> Settings {
        Settings {
            device_id: self.campaign.device_id,
            validation: self.campaign.validation,
            timeout: Duration::from_secs(self.campaign.timeout_secs),
        }
    }

    /// Round-robin, so the roots interleave rather than one running to exhaustion.
    fn pick_api(&self) -> Option<usize> {
        (!self.pools.is_empty()).then(|| self.state.next_api % self.pools.len())
    }

    fn roll_epoch_if_needed(&mut self, index: usize) {
        let per_epoch = self.pools[index].groups_per_epoch(self.campaign.group_size);
        if self.state.apis[index].group < per_epoch {
            return;
        }
        let root = self.pools[index].api.root();
        let finished = self.state.apis[index].epoch;
        self.state.apis[index].epoch = finished + 1;
        self.state.apis[index].epoch_seed = rng::derive(self.campaign.seed, root, finished + 1);
        self.state.apis[index].group = 0;
        let _ = self.store.append_journal(&JournalEntry::new(
            "epoch",
            format!("{root} starts epoch {}", finished + 1),
        ));

        // A sweep just finished, so there is something to compare it against. Same
        // cases, same driver, a different arrangement and some hours in between - a
        // verdict that moved is either flaky or the driver degrading, and the totals
        // show neither.
        if finished > 1 {
            let changes = drift::compare(&self.store.dir, root, finished - 1, finished, &self.pools[index].names);
            if !changes.is_empty() {
                let summary = drift::summarise(&changes).join(", ");
                log::warn!(
                    "{root} epoch {} vs {}: {} verdict(s) moved - {summary}",
                    finished - 1,
                    finished,
                    changes.len()
                );
                let _ = self.store.append_journal(&JournalEntry::new(
                    "drift",
                    format!("{root} epoch {} -> {finished}: {summary}", finished - 1),
                ));
                for change in changes.iter().take(DRIFT_LOGGED) {
                    let _ = self.store.append_journal(&JournalEntry::new(
                        "drift-case",
                        format!("{}: {} -> {}", change.case, change.was, change.now),
                    ));
                }
            }
            // Two epochs are all a comparison needs, and 625 KB each would otherwise
            // pile up on a board's SD card for weeks.
            drift::prune(&self.store.dir, root, finished);
        }
    }

    fn advance_past(&mut self, root: &str) {
        if let Some(index) = self.state.apis.iter().position(|a| a.root == root) {
            self.state.apis[index].group += 1;
            self.state.next_api = (index + 1) % self.state.apis.len().max(1);
        }
    }

    /// Rebuilds the group an in-flight record names.
    ///
    /// The record holds no case list on purpose; it holds what the list is a function
    /// of. `open` has already refused to get this far if the pool moved.
    fn group_for(&self, inflight: &Inflight) -> Vec<String> {
        self.pools
            .iter()
            .find(|p| p.api.root() == inflight.api)
            .map(|p| p.group(inflight.epoch_seed, inflight.group, inflight.size, &self.quarantine))
            .unwrap_or_default()
    }

    fn next_finding_id(&self) -> u32 {
        self.state.findings + 1
    }
}

/// What one iteration's running produced, across every replica and every worker.
#[derive(Default)]
struct Run {
    /// The first worker outcome that died, or an empty one if nothing did.
    outcome: oracle::GroupOutcome,
    /// What that worker was running. `None` when nothing died.
    dying_list: Option<Vec<String>>,
    /// Whether it died with other workers alive alongside it, which is what makes a
    /// finding a candidate race rather than an ordinary one.
    parallel: bool,
    summary: Summary,
    all_results: Vec<CaseResult>,
    replicas: u32,
}

/// Everything `fuzz run` needs that is not the directory.
pub struct NewCampaign {
    pub seed: u64,
    pub repro_attempts: u32,
    pub repeats: u32,
    pub replicas: u32,
    pub jobs: usize,
    pub use_quarantine: bool,
    pub minimize_budget: u32,
    pub group_size: usize,
    pub case_filters: Vec<String>,
    pub exclude_filters: Vec<String>,
    pub device_id: usize,
    pub validation: bool,
    pub timeout_secs: u64,
    pub wedge_threshold: usize,
}

fn kind_of(status: crate::tcu::TestResult) -> String {
    match status {
        crate::tcu::TestResult::Timeout => "timeout".to_string(),
        crate::tcu::TestResult::DeviceLost => "device-lost".to_string(),
        _ => "crash".to_string(),
    }
}

/// Appends each finished case name as it arrives.
///
/// Flushed per case but deliberately not fsynced: a durability barrier per case would
/// dominate work measured in milliseconds, and the value here is a *bound* on how far a
/// group got, not a fact. After an orderly death it is exact anyway, because the
/// process got to close the file.
pub(super) struct ProgressFile(Option<std::fs::File>);

impl ProgressFile {
    pub(super) fn open(path: &std::path::Path) -> Self {
        Self(std::fs::OpenOptions::new().create(true).append(true).open(path).ok())
    }

    /// Empties it for a fresh attempt. Only the attempt that killed the machine has
    /// anything to say afterwards, and the ones before it would be read as its tail.
    pub(super) fn restart(&mut self, path: &std::path::Path) {
        self.0 = std::fs::File::create(path).ok();
    }

    pub(super) fn record(&mut self, name: &str) {
        if let Some(file) = &mut self.0 {
            let _ = writeln!(file, "{name}");
            let _ = file.flush();
        }
    }
}

/// The quarantine as this campaign wants it: always read, so nothing earlier campaigns
/// learned is lost, but inert when the campaign was started with `--no-quarantine`.
fn load_quarantine(base_dir: &Path, enabled: bool) -> Quarantine {
    let quarantine = Quarantine::load(base_dir);
    if enabled { quarantine } else { quarantine.disabled() }
}

/// Repoints `current` at `label`, so `fuzz continue` needs no argument.
///
/// A relative link, like `tmp/cts-last.log` elsewhere in this repo: the base directory
/// gets copied off a board wholesale, and an absolute link would break the moment it
/// landed somewhere else.
fn point_current_at(base_dir: &std::path::Path, label: &str) -> std::io::Result<()> {
    let link = base_dir.join("current");
    let _ = std::fs::remove_file(&link);
    #[cfg(unix)]
    {
        std::os::unix::fs::symlink(label, &link)
    }
    #[cfg(not(unix))]
    {
        std::fs::write(&link, label)
    }
}

/// The campaign `fuzz continue` means when no `--dir` is given.
pub fn current_dir(base_dir: &std::path::Path) -> Option<PathBuf> {
    let link = base_dir.join("current");
    let target = std::fs::read_link(&link)
        .ok()
        .or_else(|| std::fs::read_to_string(&link).ok().map(PathBuf::from))?;
    let dir = if target.is_absolute() {
        target
    } else {
        base_dir.join(target)
    };
    dir.join("campaign.json").is_file().then_some(dir)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_severity_only_labels_itself_when_one_was_claimed() {
        assert_eq!(Severity::Unspecified.label(), None);
        assert_eq!(Severity::GpuHang.label(), Some("gpu-hang"));
        assert_eq!(Severity::SystemDown.label(), Some("system-down"));
    }

    #[test]
    fn a_findings_kind_comes_from_how_the_group_died() {
        use crate::tcu::TestResult;
        assert_eq!(kind_of(TestResult::Crash), "crash");
        assert_eq!(kind_of(TestResult::Timeout), "timeout");
        assert_eq!(kind_of(TestResult::DeviceLost), "device-lost");
    }
}
