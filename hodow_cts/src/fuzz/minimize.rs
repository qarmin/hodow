// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// From a thousand cases down to the handful that matter.
//
// Two phases, because they cost wildly different amounts:
//
//   Bisection  halve the prefix, keep whichever half still reproduces. Around ten
//              oracle calls takes 1000 down to a dozen or so, and each call is cheap
//              relative to what it removes.
//   ddmin      then, on what is left, try removing one chunk at a time and shrink the
//              chunk size when nothing can go. Expensive per element, but by now there
//              are a dozen elements, not a thousand.
//
// The casualty stays pinned at the end throughout - it is the case that died, so a list
// without it usually reproduces nothing, and every candidate has to end with it. "Usually"
// is why there is a third phase: when the trigger takes the GPU down on its own, the
// casualty never got to run and pinning it hides that the answer is one case, not two.
// Found on a board, by hand, after a minimisation had already reported two.
//
// **The oracle lies sometimes, and both algorithms assume it does not.** If a half is
// dropped because this one attempt happened not to crash, the result is a confident,
// minimal, wrong answer. So a candidate is run up to `attempts` times and counts as
// reproducing if *any* of them did - asymmetric on purpose, since "it happened" is
// strong evidence and "it did not happen once" is almost none. The early exit means a
// deterministic bug costs one attempt per step, and only a flaky one pays the full R.
//
// **Every step is resumable.** Minimising a bug that hangs the GPU means a reset every
// few steps, and a person cannot be asked to restart from scratch each time - so the
// state is written, fsynced, after every oracle call, and `fuzz continue` picks up at
// the step it was on. That is also why the state is a plain struct of indices rather
// than a recursive call stack: a call stack cannot be written to disk.

use std::time::{Duration, Instant};

use serde::{Deserialize, Serialize};

use super::health::{self, Health};
use super::oracle::{self, Settings};
use super::store::{Store, now_epoch, write_atomic};
use crate::runner::Api;

/// Which algorithm the minimisation is currently in.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Phase {
    /// Halving the prefix, taking the later half first.
    Bisect,
    /// Removing one chunk of `1/granularity` at a time.
    Ddmin,
    /// Trying the list without the casualty pinned to the end of it.
    DropVictim,
    /// Nothing more can go without losing the reproduction.
    Done,
}

/// Everything needed to carry on after the machine has been power-cycled.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinimizeState {
    pub finding: u32,
    pub api: String,
    pub phase: Phase,
    /// The shortest list still known to reproduce, casualty included as its last
    /// element. Never replaced by something unproven.
    pub current: Vec<String>,
    /// How many pieces ddmin is currently cutting the prefix into.
    pub granularity: usize,
    /// Which of those pieces to try removing next.
    pub chunk: usize,
    pub oracle_calls: u32,
    pub started_epoch: u64,
}

impl MinimizeState {
    pub fn new(finding: u32, api: &str, cases: Vec<String>) -> Self {
        Self {
            finding,
            api: api.to_string(),
            phase: Phase::Bisect,
            current: cases,
            granularity: 2,
            chunk: 0,
            oracle_calls: 0,
            started_epoch: now_epoch(),
        }
    }

    /// Everything but the case that died.
    pub fn prefix(&self) -> &[String] {
        let end = self.current.len().saturating_sub(1);
        &self.current[..end]
    }

    pub fn victim(&self) -> Option<&String> {
        self.current.last()
    }

    pub fn is_done(&self) -> bool {
        self.phase == Phase::Done
    }
}

/// How a minimisation ended, which decides what the caller prints and whether there is
/// anything left to do.
pub enum Outcome {
    /// Nothing more can be removed.
    Minimal,
    /// The budget ran out. The state is on disk; `fuzz minimize` again continues.
    BudgetSpent,
    /// The starting list did not reproduce even once, so there is nothing to shrink and
    /// any answer would be invented.
    NotReproducible,
    /// The driver stopped answering, so no later step could be believed. The state is on
    /// disk; reboot the machine and `fuzz minimize` again carries on from here.
    DriverGone(String),
}

pub struct Budget {
    pub oracle_calls: u32,
    pub wall: Duration,
}

/// Drives a minimisation from wherever its state says it is.
///
/// `save` is called after every oracle call, with the state to persist. It is the
/// caller's because only the caller knows where the campaign lives - and it must
/// actually reach the disk, or a power cut costs the whole minimisation.
pub fn run(
    state: &mut MinimizeState,
    api: Api,
    attempts: u32,
    settings: &Settings,
    budget: &Budget,
    mut save: impl FnMut(&MinimizeState) -> std::io::Result<()>,
    mut on_step: impl FnMut(&MinimizeState, usize, StepResult),
) -> std::io::Result<Outcome> {
    let started = Instant::now();
    let mut spent = 0u32;

    // Nothing below is meaningful against a list that does not reproduce: every
    // candidate would "fail to reproduce" and the result would be whatever the
    // algorithm happened to try last.
    if state.oracle_calls == 0 {
        let confirmed = reproduces(api, &state.current, attempts, settings);
        state.oracle_calls += 1;
        spent += 1;
        save(state)?;
        match confirmed {
            Answer::Reproduced => {}
            Answer::DriverGone(why) => return Ok(Outcome::DriverGone(why)),
            Answer::DidNot => {
                state.phase = Phase::Done;
                save(state)?;
                return Ok(Outcome::NotReproducible);
            }
        }
    }

    while !state.is_done() {
        if spent >= budget.oracle_calls || started.elapsed() >= budget.wall {
            return Ok(Outcome::BudgetSpent);
        }

        let Some(candidate) = next_candidate(state) else {
            advance_without_testing(state);
            save(state)?;
            continue;
        };

        let answer = reproduces(api, &candidate, attempts, settings);
        state.oracle_calls += 1;
        spent += 1;
        on_step(
            state,
            candidate.len(),
            match answer {
                Answer::Reproduced => StepResult::Reproduced,
                Answer::DidNot => StepResult::DidNot,
                Answer::DriverGone(_) => StepResult::KilledTheDriver,
            },
        );

        match answer {
            Answer::Reproduced => {
                state.current = candidate;
                accept(state);
            }
            Answer::DidNot => reject(state),
            // The step did reproduce - it is accepted, exactly as if the machine had
            // died on it - and then everything stops, because nothing after this point
            // would be an answer about the cases rather than about the dead driver.
            Answer::DriverGone(why) => {
                state.current = candidate;
                accept(state);
                save(state)?;
                return Ok(Outcome::DriverGone(why));
            }
        }
        save(state)?;
    }

    Ok(Outcome::Minimal)
}

/// The machine died while a step was in flight, which is the loudest possible "yes"
/// that step could have given.
///
/// The candidate is not stored anywhere - it does not need to be. The state is indices,
/// so the same candidate that was being tested falls straight back out of it, which is
/// the practical reason the algorithm is written this way rather than as recursion.
/// Returns the list that was accepted, or `None` if there was no step in flight.
pub fn record_death_as_reproduction(state: &mut MinimizeState) -> Option<Vec<String>> {
    let candidate = next_candidate(state)?;
    state.current = candidate.clone();
    state.oracle_calls += 1;
    accept(state);
    Some(candidate)
}

/// The list to try next, or `None` when this phase has nothing left to offer and the
/// bookkeeping has to move on without spending an oracle call.
pub(crate) fn next_candidate(state: &MinimizeState) -> Option<Vec<String>> {
    let prefix = state.prefix();
    let victim = state.victim()?.clone();

    match state.phase {
        Phase::Done => None,
        // Without the casualty at all. `victim()` above is the last element of the
        // current list, so this is simply everything before it.
        Phase::DropVictim => (state.current.len() >= 2).then(|| state.current[..state.current.len() - 1].to_vec()),
        Phase::Bisect => {
            if prefix.len() < 2 {
                return None;
            }
            // The later half first: whatever poisoned the driver is more often near the
            // casualty than at the far end of a thousand cases, so this is the half more
            // likely to keep reproducing and therefore to halve the list again.
            let half = prefix.len() / 2;
            let taken = if state.chunk == 0 {
                &prefix[half..]
            } else {
                &prefix[..half]
            };
            Some(taken.iter().cloned().chain(std::iter::once(victim)).collect())
        }
        Phase::Ddmin => {
            if prefix.is_empty() {
                return None;
            }
            let granularity = state.granularity.min(prefix.len()).max(1);
            if state.chunk >= granularity {
                return None;
            }
            let (start, end) = chunk_bounds(prefix.len(), granularity, state.chunk);
            let kept: Vec<String> = prefix[..start].iter().chain(&prefix[end..]).cloned().collect();
            if kept.len() == prefix.len() {
                return None;
            }
            Some(kept.into_iter().chain(std::iter::once(victim)).collect())
        }
    }
}

/// The candidate reproduced, so it is the new current list.
pub(crate) fn accept(state: &mut MinimizeState) {
    match state.phase {
        Phase::Bisect => state.chunk = 0,
        Phase::Ddmin => {
            // Classic ddmin: removing a chunk succeeded, so try again at a coarser
            // granularity on the smaller list.
            state.granularity = state.granularity.saturating_sub(1).max(2);
            state.chunk = 0;
        }
        // The casualty was not needed. What is left has a new last element, which is now
        // what everything gets tested against, so ddmin starts over on it.
        Phase::DropVictim => {
            state.phase = Phase::Ddmin;
            state.granularity = 2;
            state.chunk = 0;
        }
        Phase::Done => {}
    }
}

/// The candidate did not reproduce, so the current list stands and the next thing gets
/// tried.
pub(crate) fn reject(state: &mut MinimizeState) {
    match state.phase {
        Phase::Bisect => {
            if state.chunk == 0 {
                // The later half alone was not enough; try the earlier one.
                state.chunk = 1;
            } else {
                // Neither half on its own reproduces, which means what matters is spread
                // across the middle. Halving cannot see that; ddmin can.
                state.phase = Phase::Ddmin;
                state.granularity = 2;
                state.chunk = 0;
            }
        }
        Phase::Ddmin => state.chunk += 1,
        // The casualty is needed after all, which is the ordinary case: nothing left to try.
        Phase::DropVictim => state.phase = Phase::Done,
        Phase::Done => {}
    }
}

/// Moves the phase on when there is no candidate to test - the list is too short to
/// halve, or every chunk at this granularity has been tried.
pub(crate) fn advance_without_testing(state: &mut MinimizeState) {
    let prefix_len = state.prefix().len();
    match state.phase {
        Phase::Bisect => {
            state.phase = Phase::Ddmin;
            state.granularity = 2;
            state.chunk = 0;
            if prefix_len == 0 {
                state.phase = Phase::Done;
            }
        }
        Phase::Ddmin => {
            if prefix_len == 0 || state.granularity >= prefix_len {
                // Every element has been tried on its own and none could go. One thing
                // left that ddmin structurally cannot ask, because it pins the casualty
                // to every candidate: whether the casualty is needed at all.
                state.phase = Phase::DropVictim;
            } else {
                state.granularity = (state.granularity * 2).min(prefix_len);
                state.chunk = 0;
            }
        }
        Phase::DropVictim => state.phase = Phase::Done,
        Phase::Done => {}
    }
}

/// Where chunk `index` of `granularity` falls in a prefix of `len`.
fn chunk_bounds(len: usize, granularity: usize, index: usize) -> (usize, usize) {
    let start = len * index / granularity;
    let end = len * (index + 1) / granularity;
    (start, end.max(start + 1).min(len))
}

/// What a step answered, for the caller's log line. A step that took the driver down is
/// not a step that said no, and reporting it as one reads as the opposite of what
/// happened - the candidate is *kept*, since killing the driver is the loudest yes there
/// is.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum StepResult {
    Reproduced,
    DidNot,
    KilledTheDriver,
}

impl StepResult {
    pub fn label(self) -> &'static str {
        match self {
            Self::Reproduced => "still reproduce",
            Self::DidNot => "do not",
            Self::KilledTheDriver => "took the driver down",
        }
    }
}

/// What a candidate answered.
enum Answer {
    Reproduced,
    DidNot,
    /// The driver is not there any more, so this answer and every later one is noise.
    DriverGone(String),
}

/// Whether the list reproduces, allowing for an oracle that does not answer the same
/// way every time.
///
/// Stops at the first reproduction: a deterministic bug then costs one run per step
/// rather than `attempts`, and only a flaky one pays the full price.
///
/// A reproduction is followed by asking whether the driver is still there, and this is
/// not defensive tidiness - on a driver configured not to reset a hung GPU (Vivante's
/// `galcore.recovery=0`, which stops serving and keeps the scene instead) the first step
/// that reproduces leaves every later one facing a dead driver. Those steps then either
/// all "reproduce" or all "do not", and either way bisection converges on a list chosen
/// by the order the algorithm happened to try things in. The result looks minimal, is
/// confident, and is wrong - and it is the trigger of that list which gets quarantined.
fn reproduces(api: Api, cases: &[String], attempts: u32, settings: &Settings) -> Answer {
    for _ in 0..attempts.max(1) {
        match oracle::run_group(api, cases, settings, |_| {}) {
            Ok(outcome) if outcome.culprit.is_some() => {
                return match health::check(api, settings.device_id, settings.validation, settings.timeout) {
                    Health::Alive(_) => Answer::Reproduced,
                    Health::Dead(why) => Answer::DriverGone(why),
                };
            }
            Ok(_) => {}
            // A step that could not run at all is not evidence that the list is
            // innocent, and on a stopped driver it is what *every* step does - so the
            // same question gets asked here as after a reproduction. Treating it as "did
            // not reproduce" is how a dead driver rejects candidate after candidate and
            // walks the bisection somewhere arbitrary.
            Err(e) => {
                log::warn!("a minimisation step could not run: {e}");
                if let Health::Dead(why) = health::check(api, settings.device_id, settings.validation, settings.timeout)
                {
                    return Answer::DriverGone(why);
                }
            }
        }
    }
    Answer::DidNot
}

/// Where a finding's minimisation state lives - beside the finding, so it travels with
/// it when the directory is copied off a board.
pub fn state_path(store: &Store, id: u32) -> std::io::Result<std::path::PathBuf> {
    Ok(store.finding_dir(id)?.join("minimize.json"))
}

pub fn load_state(store: &Store, id: u32) -> Option<MinimizeState> {
    let text = std::fs::read_to_string(state_path(store, id).ok()?).ok()?;
    serde_json::from_str(&text).ok()
}

pub fn save_state(store: &Store, state: &MinimizeState) -> std::io::Result<()> {
    let path = state_path(store, state.finding)?;
    write_atomic(&path, &serde_json::to_string(state).map_err(std::io::Error::other)?)
}

/// Writes the minimised list out where a person, or `--case-list`, can pick it up.
pub fn write_repro(store: &Store, state: &MinimizeState) -> std::io::Result<std::path::PathBuf> {
    let path = store.finding_dir(state.finding)?.join("repro.txt");
    let mut text = String::new();
    for case in &state.current {
        text.push_str(case);
        text.push('\n');
    }
    write_atomic(&path, &text)?;
    Ok(path)
}

/// The case to keep out of future groups: the first of the minimised list.
///
/// Not the casualty of a *sequence*. See fuzz/quarantine.rs - excluding the case that
/// died removes a healthy one and leaves the cause in the pool.
///
/// A list of one is the exception, and it is not the same thing: minimisation only
/// leaves a single case standing when running that case by itself reproduced, so it is
/// the cause rather than a victim of one. Leaving it in is what the argument for
/// sparing a casualty would say, and on a board where it hangs the GPU that costs a
/// reboot every epoch, forever - the exact stall the quarantine exists to prevent.
pub fn trigger(state: &MinimizeState) -> Option<&String> {
    state.current.first()
}

/// The reason line an automatic quarantine entry carries.
pub fn quarantine_reason(state: &MinimizeState, finding: &super::store::Finding) -> String {
    let what = match state.victim() {
        Some(victim) if state.current.len() > 1 => {
            format!("trigger of a {}-case sequence ending in {victim}", state.current.len())
        }
        _ => "reproduces on its own".to_string(),
    };
    format!(
        "auto: finding {} ({}), {what}; reproduced {}",
        state.finding,
        finding.kind,
        finding.repro.summary()
    )
}

/// Applies the same shrinking to a list in memory, for tests and for reasoning about
/// the algorithm without a driver.
#[cfg(test)]
fn drive_with(state: &mut MinimizeState, max_calls: usize, mut oracle: impl FnMut(&[String]) -> bool) -> usize {
    let mut calls = 0;
    if state.oracle_calls == 0 {
        state.oracle_calls += 1;
        calls += 1;
        if !oracle(&state.current) {
            state.phase = Phase::Done;
            return calls;
        }
    }
    while !state.is_done() {
        assert!(calls < 10_000, "the algorithm is not terminating");
        if calls >= max_calls {
            return calls;
        }
        let Some(candidate) = next_candidate(state) else {
            advance_without_testing(state);
            continue;
        };
        calls += 1;
        state.oracle_calls += 1;
        if oracle(&candidate) {
            state.current = candidate;
            accept(state);
        } else {
            reject(state);
        }
    }
    calls
}

#[cfg(test)]
mod tests {
    use super::*;

    fn cases(n: usize) -> Vec<String> {
        (0..n).map(|i| format!("c{i:03}")).collect()
    }

    fn from_cases(list: Vec<String>) -> MinimizeState {
        MinimizeState::new(1, "dEQP-GLES2", list)
    }

    /// The shape the whole tool is about: one trigger somewhere in the list, and the
    /// casualty at the end. The answer is exactly those two.
    #[test]
    fn a_single_trigger_is_found_and_everything_else_goes() {
        let mut list = cases(200);
        let trigger = list[137].clone();
        list.push("victim".to_string());

        let mut state = from_cases(list);
        // Both, because that is what poisoning is: the trigger leaves the driver broken
        // and the next case is what dies in it. An oracle that reproduces on the trigger
        // alone is a different shape, and has its own test below.
        let calls = drive_with(&mut state, usize::MAX, |candidate| {
            candidate.contains(&trigger) && candidate.contains(&"victim".to_string())
        });

        assert_eq!(state.current, vec![trigger, "victim".to_string()]);
        assert!(calls < 60, "200 cases should not take {calls} oracle calls");
    }

    /// Two cases that only matter together - halving cannot separate them, which is
    /// exactly the case ddmin is there for.
    #[test]
    fn a_pair_that_only_matters_together_survives_both_phases() {
        let mut list = cases(64);
        let (a, b) = (list[3].clone(), list[60].clone());
        list.push("victim".to_string());

        let mut state = from_cases(list);
        drive_with(&mut state, usize::MAX, |candidate| {
            candidate.contains(&a) && candidate.contains(&b) && candidate.contains(&"victim".to_string())
        });

        assert_eq!(state.current, vec![a, b, "victim".to_string()]);
    }

    /// Nothing but the casualty is needed, so everything else must go.
    #[test]
    fn a_list_where_only_the_casualty_matters_shrinks_to_it_alone() {
        let mut list = cases(100);
        list.push("victim".to_string());
        let mut state = from_cases(list);
        drive_with(&mut state, usize::MAX, |candidate| {
            candidate.contains(&"victim".to_string())
        });
        assert_eq!(state.current, vec!["victim".to_string()]);
    }

    /// The shape a board actually produced: the trigger takes the GPU down on its own,
    /// so the casualty never ran and is not part of the answer. Pinning it to every
    /// candidate - which is right for poisoning - is what hid this, and the minimisation
    /// reported two cases where one was the truth.
    #[test]
    fn a_trigger_that_does_not_need_the_casualty_drops_it() {
        let mut list = cases(64);
        let trigger = list[40].clone();
        list.push("victim".to_string());

        let mut state = from_cases(list);
        drive_with(&mut state, usize::MAX, |candidate| candidate.contains(&trigger));

        assert_eq!(
            state.current,
            vec![trigger],
            "the casualty is not needed, so it must not be in the answer"
        );
    }

    /// A list that never reproduces must not be shrunk into a confident answer.
    #[test]
    fn a_list_that_does_not_reproduce_is_left_alone() {
        let mut list = cases(20);
        list.push("victim".to_string());
        let original = list.clone();
        let mut state = from_cases(list);
        let calls = drive_with(&mut state, usize::MAX, |_| false);
        assert_eq!(calls, 1, "it should stop after the first, failed confirmation");
        assert_eq!(state.current, original);
    }

    /// Every element matters, so the answer is the whole list - and it has to terminate
    /// rather than keep subdividing forever.
    #[test]
    fn a_list_where_everything_matters_comes_back_whole() {
        let mut list = cases(8);
        list.push("victim".to_string());
        let needed = list.clone();
        let mut state = from_cases(list.clone());
        drive_with(&mut state, usize::MAX, |candidate| {
            needed.iter().all(|c| candidate.contains(c))
        });
        assert_eq!(state.current, list);
    }

    /// Serialising after every call is what makes a reset survivable, so the state has
    /// to round-trip and carry on from exactly where it was.
    #[test]
    fn a_minimisation_resumes_from_its_serialised_state() {
        let mut list = cases(64);
        let trigger = list[9].clone();
        list.push("victim".to_string());

        let mut state = from_cases(list);
        // Stopped part-way, the way a board being power-cycled stops it.
        let oracle = |candidate: &[String]| candidate.contains(&trigger) && candidate.contains(&"victim".to_string());
        let partial = drive_with(&mut state, 4, oracle);
        assert_eq!(partial, 4);
        assert!(!state.is_done(), "the point of this test is that it was interrupted");

        // Nothing but the file survives a reset, so that is all the resume may use.
        let text = serde_json::to_string(&state).unwrap();
        let mut resumed: MinimizeState = serde_json::from_str(&text).unwrap();
        drive_with(&mut resumed, usize::MAX, oracle);
        assert_eq!(resumed.current, vec![trigger, "victim".to_string()]);
    }

    #[test]
    fn the_trigger_is_the_first_element_of_a_sequence() {
        let state = from_cases(vec!["a".to_string(), "victim".to_string()]);
        assert_eq!(trigger(&state), Some(&"a".to_string()));
        assert_eq!(trigger(&from_cases(Vec::new())), None);
    }

    /// One case left standing means it reproduced by itself, which makes it the cause
    /// and not a victim of one - so it is what a later group must not draw again.
    #[test]
    fn a_case_that_reproduces_alone_is_its_own_trigger() {
        let alone = from_cases(vec!["boom".to_string()]);
        assert_eq!(trigger(&alone), Some(&"boom".to_string()));
    }

    #[test]
    fn chunks_cover_the_whole_range_without_gaps_or_overlaps() {
        for len in 1..40usize {
            for granularity in 1..=len {
                let mut covered = vec![0usize; len];
                for index in 0..granularity {
                    let (start, end) = chunk_bounds(len, granularity, index);
                    assert!(
                        start < end,
                        "len {len} granularity {granularity} index {index} is empty"
                    );
                    for slot in covered.iter_mut().take(end).skip(start) {
                        *slot += 1;
                    }
                }
                assert!(
                    covered.iter().all(|&n| n == 1),
                    "len {len} granularity {granularity} did not tile"
                );
            }
        }
    }
}
