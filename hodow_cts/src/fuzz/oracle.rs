// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The one question everything else asks: run this list, in this order, in one process -
// what happened?
//
// "In one process" is the whole of it. A group's value is the state it accumulates, so
// the supervisor hands the entire list to a single worker as one batch and stops the
// moment that worker dies, rather than stepping over the casualty and finishing the
// list against a freshly started driver. Attribution is the existing one: the culprit
// is the first case that never reported.

use std::time::Duration;

use crate::report::{CaseResult, Summary};
use crate::runner::Api;
use crate::runner::isolate::{DriverUnavailable, IsolateOptions, run_isolated};
use crate::tcu::TestResult;

/// How a group ended.
#[derive(Default)]
pub struct GroupOutcome {
    pub results: Vec<CaseResult>,
    pub summary: Summary,
    /// The case that took the worker down, hung it, or lost the device - whichever came
    /// first. `None` means the group ran to the end.
    pub culprit: Option<CaseResult>,
    /// How many cases returned a verdict of their own before things went wrong. The
    /// culprit is not counted: it never reported.
    pub completed: usize,
}

/// What the campaign needs to know about how to run a group.
#[derive(Debug, Clone, Copy)]
pub struct Settings {
    pub device_id: usize,
    pub validation: bool,
    pub timeout: Duration,
}

/// Runs one group and classifies the result.
///
/// `on_case` is called as each verdict arrives, not at the end: it is what keeps the
/// progress file current, and the progress file is all that is left to say how far a
/// group got when the machine does not come back.
pub fn run_group(
    api: Api,
    cases: &[String],
    settings: &Settings,
    mut on_case: impl FnMut(&CaseResult),
) -> Result<GroupOutcome, Box<dyn std::error::Error>> {
    let options = IsolateOptions {
        api,
        // One batch, so the group is one process and one driver bring-up.
        batch_size: cases.len().max(1),
        case_timeout: settings.timeout,
        device_id: settings.device_id,
        validation: settings.validation,
        jobs: 1,
        verbose: false,
        stop_on_crash: true,
    };

    let (results, summary) = run_isolated(cases, &options, |r| on_case(r))?;

    // Everything before the culprit reported a verdict of its own; the culprit's record
    // was synthesised by the supervisor precisely because it never did.
    let fatal_at = results.iter().position(|r| is_fatal(r.status));
    let culprit = fatal_at.map(|i| results[i].clone());
    let completed = fatal_at.unwrap_or(results.len());

    Ok(GroupOutcome {
        results,
        summary,
        culprit,
        completed,
    })
}

/// Runs several lists at once, one worker each, and keeps their outcomes apart.
///
/// Apart is the whole point. The existing `--jobs` path merges everything into one
/// result stream, which is right for a conformance run and useless here: to reproduce
/// anything afterwards you have to know *which worker's list* died, and a merged stream
/// cannot say. Each list is therefore its own single-worker group, and the answers come
/// back in the order the lists were given.
///
/// What this buys is contention - two contexts on one driver at the same time, which on
/// an embedded driver is fertile ground. What it costs is reproducibility: the
/// interleaving is never the same twice, which is why a finding from here is checked
/// serially first (see `Runner::reproduce`).
pub fn run_parallel(api: Api, lists: &[Vec<String>], settings: &Settings) -> Vec<Result<GroupOutcome, String>> {
    if lists.len() < 2 {
        return lists
            .iter()
            .map(|list| run_group(api, list, settings, |_| {}).map_err(|e| e.to_string()))
            .collect();
    }

    std::thread::scope(|scope| {
        let handles: Vec<_> = lists
            .iter()
            .map(|list| scope.spawn(move || run_group(api, list, settings, |_| {}).map_err(|e| e.to_string())))
            .collect();
        handles
            .into_iter()
            .map(|handle| {
                handle
                    .join()
                    .unwrap_or_else(|_| Err("a worker supervisor thread panicked".to_string()))
            })
            .collect()
    })
}

/// Splits a group into `jobs` contiguous slices.
///
/// Contiguous rather than round-robin, so each worker's list is a run of the
/// permutation and the neighbourhoods a group was built to explore survive the split.
pub fn split(cases: &[String], jobs: usize) -> Vec<Vec<String>> {
    if cases.is_empty() {
        return Vec::new();
    }
    let jobs = jobs.clamp(1, cases.len());
    cases
        .chunks(cases.len().div_ceil(jobs))
        .map(<[String]>::to_vec)
        .collect()
}

/// One process runs the whole list `repeats` times over.
///
/// The cheapest way to accumulate state: descriptors, GPU allocations and handles that
/// one pass never pushes past a threshold. Attribution still works because the worker
/// runs the names it is handed in order, repeats included - which is exactly what the
/// `--case-list` ordering fix made true at both ends.
pub fn repeated(cases: &[String], repeats: u32) -> Vec<String> {
    match repeats.max(1) {
        1 => cases.to_vec(),
        n => cases.iter().cycle().take(cases.len() * n as usize).cloned().collect(),
    }
}

/// The three verdicts that mean the group did not finish on its own terms.
///
/// `DeviceLost` belongs here even though the case reported it: `run_case_loop` abandons
/// the rest of the batch after one, so everything behind it never ran either.
pub fn is_fatal(status: TestResult) -> bool {
    matches!(status, TestResult::Crash | TestResult::Timeout | TestResult::DeviceLost)
}

/// Whether an error from `run_group` means there is no driver rather than a bug.
///
/// A campaign has to stop on this rather than record 675k crashes: nothing was tested.
pub fn is_driver_unavailable(error: &(dyn std::error::Error + 'static)) -> bool {
    error.is::<DriverUnavailable>()
        || error.is::<crate::eglw::LoadError>()
        || error
            .downcast_ref::<crate::vk::platform::PlatformError>()
            .is_some_and(|p| matches!(p, crate::vk::platform::PlatformError::Unavailable(_)))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn names(n: usize) -> Vec<String> {
        (0..n).map(|i| format!("c{i}")).collect()
    }

    #[test]
    fn repeating_a_group_runs_the_whole_thing_over_in_order() {
        let cases = names(3);
        assert_eq!(repeated(&cases, 1), cases);
        assert_eq!(
            repeated(&cases, 3),
            ["c0", "c1", "c2", "c0", "c1", "c2", "c0", "c1", "c2"]
        );
        // Zero would mean "run nothing", which is never what anyone means by it.
        assert_eq!(repeated(&cases, 0), cases);
    }

    #[test]
    fn splitting_covers_every_case_once_in_contiguous_runs() {
        let cases = names(10);
        let parts = split(&cases, 3);
        assert_eq!(parts.len(), 3);
        assert_eq!(parts.concat(), cases, "order and contents have to survive the split");
        assert!(parts.iter().all(|p| !p.is_empty()));
    }

    /// More workers than cases, and no workers at all, both have to land somewhere
    /// sensible rather than producing empty lists a worker would reject.
    #[test]
    fn splitting_degenerate_counts_does_not_produce_empty_lists() {
        let cases = names(2);
        assert_eq!(split(&cases, 9).len(), 2);
        assert_eq!(split(&cases, 0).len(), 1);
        assert!(split(&[], 4).is_empty());
    }

    #[test]
    fn only_the_three_non_finishing_verdicts_are_fatal() {
        assert!(is_fatal(TestResult::Crash));
        assert!(is_fatal(TestResult::Timeout));
        assert!(is_fatal(TestResult::DeviceLost));
        assert!(!is_fatal(TestResult::Fail));
        assert!(!is_fatal(TestResult::Pass));
        assert!(!is_fatal(TestResult::NotSupported));
        assert!(!is_fatal(TestResult::QualityWarning));
    }
}
