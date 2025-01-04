// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The loop: run a unit, and when something dies, find out what it takes.
//
// A step that did not reproduce is weak evidence and one that did is strong, so a
// candidate is run up to R times and counts on its first reproduction. R comes from the
// rate the finding itself reproduced at, so a deterministic hang costs two runs per step
// and only a flaky one pays more. The final list is run once more from a fresh boot
// before anything is quarantined, falling back to longer lists if it does not reproduce.

use std::collections::HashMap;
use std::path::PathBuf;
use std::time::{Duration, Instant};

use log::{info, warn};

use super::findings::{Alone, Findings, Kind, Status};
use super::plan::{self, Corpus, Event, State, Unit};
use super::target::{Board, FatalKind, Run, RunOpts, Stop};
use crate::fuzz::minimize::{self, MinimizeState, Phase};
use crate::fuzz::quarantine::Quarantine;
use crate::fuzz::store::{now_epoch, write_atomic};
use crate::tcu::TestResult;

pub struct Config {
    pub batch: usize,
    pub dry_epochs: u32,
    pub confirm_attempts: u32,
    pub max_attempts: u32,
    /// Below this reproduction rate a finding is not minimised.
    pub min_rate: f64,
    /// The chance a step may wrongly answer "does not reproduce".
    pub miss_chance: f64,
    pub budget_calls: u32,
    pub budget_wall: Duration,
    /// A parked list at most this long is quarantined whole; a longer one splits its unit.
    pub park_quarantine_max: usize,
    pub alone_runs: usize,
    /// Stop once phase 3 has run every API, instead of starting phase 2 again.
    pub once: bool,
    /// Stop dead after this many board runs, as if the host had died.
    pub max_runs: Option<u64>,
}

impl Default for Config {
    fn default() -> Self {
        Self {
            batch: 500,
            dry_epochs: 6,
            confirm_attempts: 8,
            max_attempts: 12,
            min_rate: 0.25,
            miss_chance: 0.05,
            budget_calls: 40,
            budget_wall: Duration::from_secs(3 * 3600),
            park_quarantine_max: 10,
            alone_runs: 3,
            once: false,
            max_runs: None,
        }
    }
}

#[derive(Debug)]
pub enum Halt {
    Interrupted,
    Killed,
    Once,
    Io(std::io::Error),
}

impl From<std::io::Error> for Halt {
    fn from(e: std::io::Error) -> Self {
        Self::Io(e)
    }
}

enum Action {
    Continue,
    Split,
}

pub struct Tester<B: Board> {
    pub board: B,
    dir: PathBuf,
    corpus: Corpus,
    index: HashMap<String, usize>,
    pub state: State,
    pub findings: Findings,
    pub quarantine: Quarantine,
    cfg: Config,
    runs: u64,
}

impl<B: Board> Tester<B> {
    pub fn open(board: B, dir: PathBuf, corpus: Corpus, seed: u64, cfg: Config) -> std::io::Result<Self> {
        let fingerprint = corpus.fingerprint();
        let state = match super::findings::read_json::<State>(&dir.join("state.json"))? {
            Some(state) if state.fingerprint == fingerprint => state,
            Some(_) => {
                warn!(
                    "The case list changed since the last run - the phases start over (findings and quarantine are kept)"
                );
                State::new(fingerprint, seed)
            }
            None => State::new(fingerprint, seed),
        };
        let index = corpus
            .apis
            .iter()
            .flat_map(|(_, cases)| cases.iter().enumerate().map(|(i, c)| (c.clone(), i)))
            .collect();
        Ok(Self {
            board,
            findings: Findings::load(&dir)?,
            quarantine: Quarantine::load(&dir),
            dir,
            corpus,
            index,
            state,
            cfg,
            runs: 0,
        })
    }

    pub fn run(&mut self) -> Halt {
        match self.drive() {
            Ok(never) => match never {},
            Err(halt) => {
                if !matches!(halt, Halt::Killed)
                    && let Err(e) = self.save_state()
                {
                    return Halt::Io(e);
                }
                halt
            }
        }
    }

    fn drive(&mut self) -> Result<std::convert::Infallible, Halt> {
        for i in 0..self.findings.list.len() {
            if self.findings.list[i].status.in_progress() {
                info!(
                    "Finding {} was {} when the last run stopped - carrying on with it",
                    self.findings.list[i].id,
                    self.findings.list[i].status.label()
                );
                if let Action::Split = self.pipeline(i)?
                    && let Some(unit) = self.state.active.take()
                {
                    self.split(unit);
                }
                self.save_state()?;
            }
        }

        loop {
            if self.state.active.is_none() {
                let settings = plan::Settings {
                    batch: self.cfg.batch,
                    dry_epochs: self.cfg.dry_epochs,
                };
                let mut events = Vec::new();
                let unit = plan::next_unit(&mut self.state, &self.corpus, &settings, &mut events);
                self.state.active = Some(unit);
                for event in events {
                    self.on_event(event)?;
                }
                self.save_state()?;
            }
            self.run_unit()?;
            self.state.active = None;
            self.save_state()?;
        }
    }

    fn on_event(&mut self, event: Event) -> Result<(), Halt> {
        match event {
            Event::PhaseStarted(what) => info!("Starting {what}"),
            Event::CycleDone => {
                info!("Phase 3 done for every API ({})", self.totals());
                if self.cfg.once {
                    return Err(Halt::Once);
                }
            }
            Event::EpochDone { api, epoch, new, flips } => {
                let mut fresh = 0;
                for (case, before, now) in flips {
                    // A case already known to fail only after certain others is expected to
                    // flip as the shuffle moves its neighbours around.
                    if self
                        .findings
                        .list
                        .iter()
                        .any(|f| matches!(f.kind, Kind::FlakyVerdict | Kind::OrderFail) && f.victim == case)
                    {
                        continue;
                    }
                    let message = format!("{before} in epoch {}, {now} in epoch {epoch}", epoch - 1);
                    let i = self.findings.create(
                        Kind::FlakyVerdict,
                        &case,
                        &message,
                        &format!("phase 2: {} epoch {epoch}", plan::short_api(&api)),
                        vec![case.clone()],
                    )?;
                    self.findings.finish(i)?;
                    warn!(
                        "Verdict of {case} flipped: {message} (finding {})",
                        self.findings.list[i].id
                    );
                    fresh += 1;
                }
                let stats = self.state.apis.entry(api.clone()).or_default();
                if fresh > 0 {
                    stats.dry = 0;
                }
                let note = if new || fresh > 0 {
                    "new findings"
                } else {
                    "no new findings"
                };
                info!(
                    "Phase 2: {} epoch {epoch} done, {note} (dry {}/{})",
                    plan::short_api(&api),
                    stats.dry,
                    self.cfg.dry_epochs
                );
            }
        }
        Ok(())
    }

    fn run_unit(&mut self) -> Result<(), Halt> {
        let mut no_driver = 0;
        loop {
            let unit = self.state.active.as_ref().expect("a unit is active");
            let list: Vec<String> = unit.cases[unit.from..]
                .iter()
                .filter(|c| !self.quarantine.excludes(c))
                .cloned()
                .collect();
            if list.is_empty() {
                return Ok(());
            }
            let label = unit.label.clone();
            let resumed = if unit.from > 0 {
                format!(", from case {}", unit.from + 1)
            } else {
                String::new()
            };
            info!("Testing {label}{resumed}: {} cases", list.len());

            let started = Instant::now();
            let run = self.board_run(&list, RunOpts::default(), Some(&label))?;
            self.record_verdicts(&run);
            match &run.stop {
                Stop::Interrupted => return Err(Halt::Interrupted),
                Stop::NoDriver => self.no_driver(&mut no_driver),
                Stop::Finished => {
                    info!(
                        "Done {label}: {} in {:.0}s ({})",
                        tally(&run),
                        started.elapsed().as_secs_f64(),
                        self.totals()
                    );
                    self.check_fails(&run, &label)?;
                    return Ok(());
                }
                Stop::Fatal(fatal) => {
                    let fatal = fatal.clone();
                    info!(
                        "Stopped {label}: {} in {:.0}s",
                        tally(&run),
                        started.elapsed().as_secs_f64()
                    );
                    let action = self.on_fatal(&run, &label)?;
                    self.check_fails(&run, &label)?;
                    let unit = self.state.active.as_mut().expect("a unit is active");
                    match action {
                        Action::Split => {
                            let unit = self.state.active.take().expect("a unit is active");
                            self.split(unit);
                            return Ok(());
                        }
                        Action::Continue => {
                            let at = unit
                                .cases
                                .iter()
                                .skip(unit.from)
                                .position(|c| *c == fatal.case)
                                .map_or(unit.cases.len(), |p| p + unit.from);
                            if unit.died.contains(&fatal.case) {
                                warn!("{} died twice in {label} - stepping over it", fatal.case);
                                unit.from = at + 1;
                            } else {
                                unit.died.push(fatal.case.clone());
                                unit.from = at;
                            }
                        }
                    }
                    self.save_state()?;
                }
            }
        }
    }

    fn split(&mut self, unit: Unit) {
        let half = unit.cases.len() / 2;
        let halves = [&unit.cases[..half], &unit.cases[half..]];
        warn!(
            "Splitting {} into halves of {} and {} cases",
            unit.label,
            halves[0].len(),
            halves[1].len()
        );
        for (n, cases) in halves.iter().enumerate().rev() {
            if cases.is_empty() {
                continue;
            }
            self.state.queue.insert(
                0,
                Unit {
                    label: format!("{}, half {}/2", unit.label, n + 1),
                    api: unit.api.clone(),
                    cases: cases.to_vec(),
                    from: 0,
                    died: Vec::new(),
                    shuffled: unit.shuffled,
                },
            );
        }
    }

    fn record_verdicts(&mut self, run: &Run) {
        let Some(unit) = self.state.active.as_ref().filter(|u| u.shuffled) else {
            return;
        };
        let Some(stats) = self.state.apis.get_mut(&unit.api) else {
            return;
        };
        let mut bytes = std::mem::take(&mut stats.verdicts).into_bytes();
        for result in &run.results {
            let mark = match result.status {
                TestResult::Pass => b'P',
                TestResult::Fail => b'F',
                _ => continue,
            };
            if let Some(&i) = self.index.get(&result.name)
                && i < bytes.len()
            {
                bytes[i] = mark;
            }
        }
        stats.verdicts = String::from_utf8(bytes).unwrap_or_default();
    }

    fn on_fatal(&mut self, run: &Run, label: &str) -> Result<Action, Halt> {
        let fatal = run.fatal().expect("a fatal run").clone();
        let before = run.before(&fatal.case);
        warn!(
            "{} in {label} on {} after {} cases: {}",
            fatal.kind.label(),
            fatal.case,
            before.len(),
            first_line(&fatal.message)
        );

        let diag = if matches!(fatal.kind, FatalKind::Hang | FatalKind::ClientHang) {
            self.board.diag()
        } else {
            String::new()
        };
        self.recover(fatal.kind)?;

        let mut cases = before;
        cases.push(fatal.case.clone());
        let i = self.findings.create(
            Kind::Fatal(fatal.kind),
            &fatal.case,
            &fatal.message,
            label,
            cases.clone(),
        )?;
        self.findings.list[i].accepted.push(cases.clone());
        self.findings
            .write_file(i, "original-cases.txt", &(cases.join("\n") + "\n"))?;
        self.findings.write_file(i, "output.log", &run.output)?;
        self.findings.write_file(i, "kernel.log", &run.kernel)?;
        self.findings.write_file(i, "diag.txt", &diag)?;
        self.findings.save()?;
        self.save_state()?;
        let action = self.pipeline(i)?;
        self.note_new(i);
        Ok(action)
    }

    fn note_new(&mut self, i: usize) {
        if !self.findings.list[i].new {
            return;
        }
        if let Some(unit) = self.state.active.as_ref().filter(|u| u.shuffled) {
            self.state.apis.entry(unit.api.clone()).or_default().new_this_epoch = true;
        }
    }

    /// Fails get asked whether they fail alone: a case broken on its own is noted once, one
    /// that only fails after something else is minimised like a crash.
    fn check_fails(&mut self, run: &Run, label: &str) -> Result<(), Halt> {
        let mut fails: Vec<String> = Vec::new();
        for r in &run.results {
            if r.status == TestResult::Fail && !fails.contains(&r.name) {
                fails.push(r.name.clone());
            }
        }
        let unknown: Vec<String> = fails
            .iter()
            .filter(|c| !self.findings.baseline.alone.contains_key(*c))
            .cloned()
            .collect();
        if !unknown.is_empty() {
            self.check_alone(&unknown)?;
        }
        for case in fails {
            if !self.findings.baseline.alone.get(&case).is_some_and(|a| a.passes) {
                continue;
            }
            if self
                .findings
                .list
                .iter()
                .any(|f| f.kind == Kind::OrderFail && f.victim == case)
            {
                continue;
            }
            let mut cases = run.before(&case);
            cases.push(case.clone());
            let message = run
                .results
                .iter()
                .find(|r| r.name == case)
                .map(|r| r.message.clone())
                .unwrap_or_default();
            warn!(
                "{case} fails after {} other cases and passes alone - minimising it",
                cases.len() - 1
            );
            let i = self
                .findings
                .create(Kind::OrderFail, &case, &message, label, cases.clone())?;
            self.findings.list[i].accepted.push(cases.clone());
            self.findings
                .write_file(i, "original-cases.txt", &(cases.join("\n") + "\n"))?;
            self.findings.write_file(i, "output.log", &run.output)?;
            self.findings.save()?;
            self.pipeline(i)?;
            self.note_new(i);
        }
        Ok(())
    }

    fn check_alone(&mut self, cases: &[String]) -> Result<(), Halt> {
        info!(
            "Checking {} failing cases alone, {} runs each",
            cases.len(),
            self.cfg.alone_runs
        );
        let mut pending: Vec<String> = cases.to_vec();
        while !pending.is_empty() {
            let list: Vec<String> = pending
                .iter()
                .flat_map(|c| std::iter::repeat_n(c.clone(), self.cfg.alone_runs))
                .collect();
            let (run, _) = self.run_with_driver(
                &list,
                RunOpts {
                    isolate_each: true,
                    ..RunOpts::default()
                },
            )?;
            let fatal = run.fatal().cloned();
            let mut done = Vec::new();
            for case in &pending {
                let mine: Vec<_> = run.results.iter().filter(|r| r.name == *case).collect();
                let died_here = fatal.as_ref().is_some_and(|f| f.case == *case);
                if mine.len() < self.cfg.alone_runs && !died_here {
                    continue;
                }
                let passes = !died_here && mine.iter().all(|r| r.status == TestResult::Pass);
                let message = match &fatal {
                    Some(f) if died_here => format!("{} alone: {}", f.kind.label(), first_line(&f.message)),
                    _ => mine
                        .iter()
                        .find(|r| r.status != TestResult::Pass)
                        .map(|r| first_line(&r.message).to_string())
                        .unwrap_or_default(),
                };
                if passes {
                    info!("  {case} passes alone - it only fails after other cases");
                } else {
                    info!("  {case} fails alone too: {message}");
                }
                self.findings
                    .baseline
                    .alone
                    .insert(case.clone(), Alone { passes, message });
                done.push(case.clone());
            }
            pending.retain(|c| !done.contains(c));
            if let Some(f) = fatal {
                warn!(
                    "{} while checking {} alone: {}",
                    f.kind.label(),
                    f.case,
                    first_line(&f.message)
                );
                self.recover(f.kind)?;
            } else if !pending.is_empty() {
                warn!(
                    "{} cases reported nothing when run alone - leaving them unchecked",
                    pending.len()
                );
                break;
            }
        }
        self.findings.save()?;
        Ok(())
    }

    fn pipeline(&mut self, i: usize) -> Result<Action, Halt> {
        loop {
            match self.findings.list[i].status {
                Status::Confirming => self.confirm(i)?,
                Status::Minimizing => self.minimize(i)?,
                Status::Rechecking => self.recheck(i)?,
                Status::Verifying => self.verify(i)?,
                _ => break,
            }
        }
        let f = &self.findings.list[i];
        let split =
            f.status == Status::Parked && f.kind.fatal().is_some() && f.cases.len() > self.cfg.park_quarantine_max;
        Ok(if split { Action::Split } else { Action::Continue })
    }

    fn confirm(&mut self, i: usize) -> Result<(), Halt> {
        let (id, label, len) = self.describe(i);
        info!("Finding {id} ({label}): checking that its {len} cases reproduce from a fresh boot");
        self.ensure_fresh();
        let cases = self.findings.list[i].cases.clone();
        let mut hit_at = None;
        for attempt in 1..=self.cfg.confirm_attempts {
            if self.attempt(i, &cases)? {
                hit_at = Some(attempt);
                break;
            }
            info!(
                "Finding {id}: attempt {attempt}/{} did not reproduce",
                self.cfg.confirm_attempts
            );
        }
        self.findings.list[i].oracle_calls += 1;
        let Some(attempt) = hit_at else {
            self.findings.list[i].attempts += self.cfg.confirm_attempts;
            self.findings.list[i].status = Status::NotReproducible;
            self.findings.finish(i)?;
            warn!(
                "Finding {id} ({label}) did not reproduce in {} attempts - recorded, not quarantined",
                self.cfg.confirm_attempts
            );
            return Ok(());
        };
        let f = &mut self.findings.list[i];
        f.successes += 1;
        f.attempts += attempt;
        let rate = f.rate();
        if rate < self.cfg.min_rate {
            f.status = Status::Flaky;
            warn!(
                "Finding {id} ({label}) reproduced only 1 in {attempt} - too rare to minimise, its {len} cases are the reproducer"
            );
            if len == 1 {
                self.quarantine_cases(i, &[cases[0].clone()], "reproduces on its own, rarely")?;
            }
            self.findings.finish(i)?;
            return Ok(());
        }
        info!(
            "Finding {id} ({label}) reproduces (1 in {attempt}), each step gets up to {} runs",
            self.attempts_for(i)
        );
        let f = &mut self.findings.list[i];
        if cases.len() == 1 {
            f.status = Status::Verifying;
        } else {
            f.status = Status::Minimizing;
            f.minimize = Some(MinimizeState::new(f.id, root_of(&f.victim), cases));
        }
        self.findings.save()?;
        Ok(())
    }

    fn minimize(&mut self, i: usize) -> Result<(), Halt> {
        let (id, label, _) = self.describe(i);
        let order_fail = self.findings.list[i].kind == Kind::OrderFail;
        let mut state = match self.findings.list[i].minimize.clone() {
            Some(state) => state,
            None => MinimizeState::new(
                id,
                root_of(&self.findings.list[i].victim),
                self.findings.list[i].cases.clone(),
            ),
        };
        // Most cases that take a driver down do it on their own, and asking that first
        // costs one short run instead of a bisection over the whole prefix.
        if !order_fail && state.oracle_calls == 0 && state.current.len() > 1 {
            let alone = vec![self.findings.list[i].victim.clone()];
            let runs = self.attempts_for(i);
            info!("Minimizing finding {id} ({label}): does the victim do it alone? (up to {runs} runs)");
            let hit = self.reproduces(i, &alone, runs)?;
            let f = &mut self.findings.list[i];
            f.oracle_calls += 1;
            state.oracle_calls = 1;
            if hit {
                info!("  it does -> 1");
                f.cases = alone.clone();
                f.accepted.push(alone.clone());
                state.current = alone;
                state.phase = Phase::Done;
            } else {
                info!("  it does not -> {}", state.current.len());
                f.rejected.push(alone);
            }
            f.minimize = Some(state.clone());
            self.findings.save()?;
        }
        loop {
            if order_fail && state.phase == Phase::DropVictim {
                state.phase = Phase::Done;
            }
            if state.is_done() {
                break;
            }
            let f = &self.findings.list[i];
            let elapsed = now_epoch().saturating_sub(state.started_epoch);
            if f.oracle_calls >= self.cfg.budget_calls || elapsed >= self.cfg.budget_wall.as_secs() {
                return self.park(i);
            }
            let Some(candidate) = minimize::next_candidate(&state) else {
                minimize::advance_without_testing(&mut state);
                continue;
            };
            // On a two-case prefix ddmin's first candidates are exactly bisection's.
            if self.findings.list[i].rejected.contains(&candidate) {
                minimize::reject(&mut state);
                continue;
            }
            let runs = self.attempts_for(i);
            info!(
                "Minimizing finding {id} ({label}): {} cases left, trying {} (up to {runs} runs)",
                state.current.len(),
                candidate.len()
            );
            let hit = self.reproduces(i, &candidate, runs)?;
            let f = &mut self.findings.list[i];
            f.oracle_calls += 1;
            if hit {
                state.current = candidate;
                minimize::accept(&mut state);
                f.cases = state.current.clone();
                f.accepted.push(f.cases.clone());
            } else {
                minimize::reject(&mut state);
                f.rejected.push(candidate);
            }
            info!(
                "  {} -> {}",
                if hit { "still reproduces" } else { "does not reproduce" },
                f.cases.len()
            );
            f.minimize = Some(state.clone());
            self.findings.save()?;
        }
        let f = &mut self.findings.list[i];
        f.cases = state.current.clone();
        f.minimize = None;
        f.rejected.clear();
        f.recheck_at = 0;
        f.status = Status::Rechecking;
        self.findings.save()?;
        Ok(())
    }

    /// Each kept case was kept because one step said "does not reproduce" without it, and
    /// one such step is wrong `miss_chance` of the time. Asking again for every case makes a
    /// wrongly kept one - which could be ahead of the trigger and get quarantined in its
    /// place - that chance squared.
    fn recheck(&mut self, i: usize) -> Result<(), Halt> {
        let (id, label, _) = self.describe(i);
        let order_fail = self.findings.list[i].kind == Kind::OrderFail;
        loop {
            let f = &self.findings.list[i];
            let cases = f.cases.clone();
            let last = if order_fail {
                cases.len().saturating_sub(1)
            } else {
                cases.len()
            };
            let at = f.recheck_at;
            if cases.len() < 2 || at >= last {
                break;
            }
            let elapsed = f
                .minimize
                .as_ref()
                .map_or(0, |m| now_epoch().saturating_sub(m.started_epoch));
            if f.oracle_calls >= self.cfg.budget_calls.saturating_mul(2) || elapsed >= self.cfg.budget_wall.as_secs() {
                break;
            }
            let mut candidate = cases.clone();
            let dropped = candidate.remove(at);
            let runs = self.attempts_for(i);
            info!(
                "Rechecking finding {id} ({label}): is {} needed? ({} cases, up to {runs} runs)",
                super::findings::short_name(&dropped),
                cases.len()
            );
            let hit = self.reproduces(i, &candidate, runs)?;
            let f = &mut self.findings.list[i];
            f.oracle_calls += 1;
            if hit {
                info!("  not needed -> {} cases", candidate.len());
                f.cases = candidate;
                f.accepted.push(f.cases.clone());
            } else {
                f.recheck_at += 1;
            }
            self.findings.save()?;
        }
        self.findings.list[i].status = Status::Verifying;
        self.findings.save()?;
        Ok(())
    }

    fn park(&mut self, i: usize) -> Result<(), Halt> {
        let (id, label, len) = self.describe(i);
        let f = &mut self.findings.list[i];
        f.status = Status::Parked;
        f.minimize = None;
        f.rejected.clear();
        warn!(
            "Finding {id} ({label}) ran out of budget at {len} cases ({} steps) - parked",
            f.oracle_calls
        );
        if f.kind.fatal().is_some() && len <= self.cfg.park_quarantine_max {
            let cases = f.cases.clone();
            let keep = if cases.len() == 1 {
                cases.clone()
            } else {
                cases[..cases.len() - 1].to_vec()
            };
            self.quarantine_cases(i, &keep, "parked minimisation, every case but the victim")?;
        }
        self.findings.finish(i)?;
        Ok(())
    }

    fn verify(&mut self, i: usize) -> Result<(), Halt> {
        let (id, label, _) = self.describe(i);
        let mut lists = self.findings.list[i].accepted.clone();
        let current = self.findings.list[i].cases.clone();
        if lists.last() != Some(&current) {
            lists.push(current.clone());
        }
        lists.dedup();
        if self.findings.list[i].fresh_hit.as_ref() == Some(&current) {
            info!(
                "Finding {id} ({label}): the {}-case list already reproduced from a fresh boot",
                current.len()
            );
            return self.settle(i, &current);
        }
        for list in lists.iter().rev() {
            info!(
                "Finding {id} ({label}): verifying the {}-case list from a fresh boot",
                list.len()
            );
            self.ensure_fresh();
            let runs = self.attempts_for(i);
            for attempt in 1..=runs {
                let (run, _) = self.run_with_driver(
                    list,
                    RunOpts {
                        dump_shaders: true,
                        ..RunOpts::default()
                    },
                )?;
                let hit = self.is_hit(i, list, &run);
                if let Some(f) = run.fatal() {
                    self.recover(f.kind)?;
                }
                if hit {
                    let f = &mut self.findings.list[i];
                    f.successes += 1;
                    f.attempts += attempt;
                    self.keep_evidence(i, &run)?;
                    if *list == current {
                        return self.settle(i, list);
                    }
                    return self.unsettled(i, list);
                }
            }
            info!(
                "Finding {id}: the {}-case list did not reproduce in {runs} runs",
                list.len()
            );
        }
        let original = lists.first().cloned().unwrap_or(current);
        self.unsettled(i, &original)
    }

    /// The minimised list did not hold up from a fresh boot, so its first case is not known
    /// to be the trigger and nothing is quarantined on its account. A case that reproduced
    /// entirely on its own at some point is still the cause of something, and goes.
    fn unsettled(&mut self, i: usize, list: &[String]) -> Result<(), Halt> {
        let (id, label, _) = self.describe(i);
        let alone: Option<String> = self.findings.list[i]
            .accepted
            .iter()
            .find(|l| l.len() == 1)
            .map(|l| l[0].clone());
        let f = &mut self.findings.list[i];
        f.status = Status::Flaky;
        f.cases = list.to_vec();
        warn!(
            "Finding {id} ({label}): the minimised list did not reproduce from a fresh boot - recorded as flaky with the {}-case list that did",
            list.len()
        );
        if f.kind.fatal().is_some()
            && let Some(case) = alone
        {
            self.quarantine_cases(i, &[case], "reproduced on its own at least once, not reliably")?;
        }
        self.findings.finish(i)?;
        Ok(())
    }

    fn keep_evidence(&mut self, i: usize, run: &Run) -> std::io::Result<()> {
        self.findings
            .write_file(i, "shaders.txt", &shaders_by_case(&run.output))?;
        self.findings.write_file(i, "verify-output.log", &run.output)?;
        self.findings.write_file(i, "verify-kernel.log", &run.kernel)
    }

    /// `list` reproduced from a fresh boot: it is the finding, and its trigger is quarantined.
    fn settle(&mut self, i: usize, list: &[String]) -> Result<(), Halt> {
        let (id, label, _) = self.describe(i);
        let f = &mut self.findings.list[i];
        f.cases = list.to_vec();
        f.status = Status::Minimal;
        if f.kind.fatal().is_some() {
            let trigger = list[0].clone();
            let why = if list.len() == 1 {
                "reproduces on its own".to_string()
            } else {
                format!(
                    "trigger of a {}-case sequence ending in {}",
                    list.len(),
                    list[list.len() - 1]
                )
            };
            self.quarantine_cases(i, &[trigger], &why)?;
        }
        self.findings.finish(i)?;
        info!(
            "Minimized finding {id} ({label}) to {} cases ({})",
            list.len(),
            self.totals()
        );
        Ok(())
    }

    fn quarantine_cases(&mut self, i: usize, cases: &[String], why: &str) -> Result<(), Halt> {
        let f = &self.findings.list[i];
        let reason = format!(
            "auto: finding {} ({}), {why}; reproduced {}/{}",
            f.id,
            f.kind.label(),
            f.successes,
            f.attempts
        );
        for case in cases {
            if self.quarantine.add(case, &reason)? {
                self.findings.list[i].quarantined.push(case.clone());
                info!("Quarantined {case}");
                self.family_hint(case);
            }
        }
        Ok(())
    }

    fn family_hint(&self, case: &str) {
        let Some((group, _)) = case.rsplit_once('.') else {
            return;
        };
        let prefix = format!("{group}.");
        let siblings = self
            .quarantine
            .entries()
            .iter()
            .filter(|e| e.case.starts_with(&prefix))
            .count();
        if siblings >= 3 {
            warn!("{siblings} quarantined cases under {group}.* - consider one glob entry in quarantine.toml");
        }
    }

    fn reproduces(&mut self, i: usize, cases: &[String], runs: u32) -> Result<bool, Halt> {
        for attempt in 1..=runs {
            if self.attempt(i, cases)? {
                let f = &mut self.findings.list[i];
                f.successes += 1;
                f.attempts += attempt;
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// One run. A reproduction from a fresh boot is remembered, with its shaders when the
    /// list is short, so verifying that same list later needs no further reboot and run.
    fn attempt(&mut self, i: usize, cases: &[String]) -> Result<bool, Halt> {
        let short = cases.len() <= 20;
        let (run, fresh) = self.run_with_driver(
            cases,
            RunOpts {
                dump_shaders: short,
                ..RunOpts::default()
            },
        )?;
        let hit = self.is_hit(i, cases, &run);
        if hit && fresh && short {
            self.findings.list[i].fresh_hit = Some(cases.to_vec());
            self.keep_evidence(i, &run)?;
        }
        if let Some(f) = run.fatal() {
            self.recover(f.kind)?;
        }
        Ok(hit)
    }

    /// A run that found no driver says nothing about the cases, so it is not an answer.
    /// Also says whether the run that did answer started on a fresh boot.
    fn run_with_driver(&mut self, cases: &[String], opts: RunOpts) -> Result<(Run, bool), Halt> {
        let mut no_driver = 0;
        loop {
            let fresh = self.board.fresh();
            let run = self.board_run(cases, opts, None)?;
            match run.stop {
                Stop::Interrupted => return Err(Halt::Interrupted),
                Stop::NoDriver => self.no_driver(&mut no_driver),
                _ => return Ok((run, fresh)),
            }
        }
    }

    fn is_hit(&self, i: usize, cases: &[String], run: &Run) -> bool {
        let f = &self.findings.list[i];
        match f.kind {
            Kind::Fatal(kind) => run.fatal().is_some_and(|x| x.kind.same_class(kind)),
            Kind::OrderFail => cases.last() == Some(&f.victim) && run.status_of(&f.victim) == Some(TestResult::Fail),
            Kind::FlakyVerdict => false,
        }
    }

    /// Runs a step needs before "does not reproduce" is believed. The rate is the lower
    /// bound of its confidence interval rather than the plain ratio: a run of lucky first-try
    /// successes says little about a bug that fires half the time, and an optimistic rate is
    /// exactly what turns a miss into a wrong answer.
    fn attempts_for(&self, i: usize) -> u32 {
        let f = &self.findings.list[i];
        let rate = wilson_lower(f.successes, f.attempts);
        if rate <= 0.0 {
            return self.cfg.max_attempts;
        }
        let needed = (self.cfg.miss_chance.ln() / (1.0 - rate).ln()).ceil();
        (needed as u32).clamp(2, self.cfg.max_attempts)
    }

    /// Nothing ran because no driver answered: twice wait for the compositor, then reboot.
    fn no_driver(&mut self, count: &mut u32) {
        *count += 1;
        warn!(
            "No driver answered ({count}/3) - {}",
            if *count >= 3 {
                "rebooting"
            } else {
                "waiting for the compositor"
            }
        );
        if *count >= 3 {
            self.board.reboot();
            *count = 0;
        } else {
            self.board.pause_for_driver();
        }
    }

    fn recover(&mut self, kind: FatalKind) -> Result<(), Halt> {
        match kind {
            FatalKind::Hang => self.board.reboot(),
            FatalKind::System => self.board.wait_until_back(),
            FatalKind::ClientHang | FatalKind::Crash => {
                if !self.board.healthy() {
                    warn!("The driver did not survive - rebooting");
                    self.board.reboot();
                }
            }
        }
        Ok(())
    }

    fn ensure_fresh(&mut self) {
        if !self.board.fresh() {
            self.board.reboot();
        }
    }

    fn board_run(&mut self, cases: &[String], opts: RunOpts, label: Option<&str>) -> Result<Run, Halt> {
        if self.cfg.max_runs.is_some_and(|max| self.runs >= max) {
            return Err(Halt::Killed);
        }
        if super::interrupted() {
            return Err(Halt::Interrupted);
        }
        self.runs += 1;
        let total = cases.len();
        let mut done = 0usize;
        let mut fails = 0usize;
        let mut last = Instant::now();
        let mut on_result = |r: &crate::report::CaseResult| {
            done += 1;
            if r.status == TestResult::Fail {
                fails += 1;
            }
            if let Some(label) = label
                && last.elapsed() >= Duration::from_secs(30)
            {
                last = Instant::now();
                info!("  {label}: {done}/{total} cases, {fails} fail");
            }
        };
        Ok(self.board.run(cases, opts, &mut on_result))
    }

    fn describe(&self, i: usize) -> (u32, &'static str, usize) {
        let f = &self.findings.list[i];
        (f.id, f.kind.label(), f.cases.len())
    }

    fn totals(&self) -> String {
        format!(
            "{} findings, {} quarantined",
            self.findings.list.len(),
            self.quarantine.len()
        )
    }

    fn save_state(&self) -> std::io::Result<()> {
        write_atomic(
            &self.dir.join("state.json"),
            &serde_json::to_string(&self.state).map_err(std::io::Error::other)?,
        )
    }
}

fn tally(run: &Run) -> String {
    let mut counts: std::collections::BTreeMap<String, usize> = Default::default();
    for r in &run.results {
        let name = match r.status {
            TestResult::Pass => "pass".to_string(),
            TestResult::Fail => "fail".to_string(),
            TestResult::NotSupported => "not supported".to_string(),
            other => format!("{other:?}"),
        };
        *counts.entry(name).or_default() += 1;
    }
    let parts: Vec<String> = counts.iter().map(|(k, v)| format!("{v} {k}")).collect();
    if parts.is_empty() {
        "nothing ran".to_string()
    } else {
        parts.join(", ")
    }
}

/// One-sided 95% lower bound of a success rate (Wilson score).
fn wilson_lower(successes: u32, trials: u32) -> f64 {
    if trials == 0 {
        return 0.0;
    }
    let n = f64::from(trials);
    let p = f64::from(successes) / n;
    let z = 1.645_f64;
    let z2 = z * z;
    ((p + z2 / (2.0 * n) - z * (p * (1.0 - p) / n + z2 / (4.0 * n * n)).sqrt()) / (1.0 + z2 / n)).max(0.0)
}

fn root_of(case: &str) -> &str {
    case.split('.').next().unwrap_or(case)
}

fn first_line(text: &str) -> &str {
    text.lines().next().unwrap_or("")
}

/// The `HODOW_CTS_DUMP_SHADERS` blocks of a verbose run, each under the case that built it.
pub fn shaders_by_case(output: &str) -> String {
    let mut out = String::new();
    let mut case = String::new();
    let mut inside = false;
    let mut announced = String::new();
    for line in output.lines() {
        if let Some(name) = line.strip_prefix("> ") {
            case = name.trim().to_string();
            continue;
        }
        if line.starts_with("=== ") && line.ends_with(" shader ===") {
            if announced != case {
                out.push_str(&format!("\n##### {case}\n"));
                announced = case.clone();
            }
            inside = true;
        }
        if inside {
            out.push_str(line);
            out.push('\n');
            if line == "=== end ===" {
                inside = false;
            }
        }
    }
    out
}
