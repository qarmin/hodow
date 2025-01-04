// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// The gate, because "it found nothing" is not evidence.
//
// This fuzzer exists to catch a broken driver, and every driver available to develop
// against works. A fuzzer that is wired up wrong and a fuzzer that has nothing to find
// produce byte-identical output, so running it and reading the log proves only that it
// does not crash. What proves something is injecting a fault whose correct answer is
// known in advance and checking the pipeline arrives at exactly that answer.
//
// The faults model the shapes that actually happen (see fuzz/fault.rs). The one that
// matters most is `poison`: a healthy case leaves the driver broken and the case after
// it dies. The culprit is then innocent, and differs with every permutation - so a
// pipeline that reports the culprit as the cause is wrong in a way no clean run would
// ever reveal.
//
// Deliberately run against a real driver rather than a mock: the thing under test here
// is the join between the fuzzer, the isolation machinery and a process that really
// dies, and a mock of that would be a mock of the only interesting part.

use std::path::PathBuf;
use std::process::ExitCode;
use std::time::{Duration, Instant};

use super::campaign::{NewCampaign, Runner, Severity, Verdict};
use super::cli::SelftestArgs;
use super::fault::{FAULT_ENV, Fault, Kind};
use super::oracle::{self, Settings};
use super::quarantine::Quarantine;
use super::store::{Finding, Inflight, now_epoch};
use super::triage::Baseline;
use crate::runner::Api;

/// Enough cases to hold a group with room either side of the trigger, few enough that
/// the whole gate is seconds rather than minutes. Negative-API cases need no rendering
/// and no reference image, so they are the cheapest thing a driver can be asked.
const POOL_FILTER: &str = "dEQP-GLES2.functional.negative_api.buffer.*";

/// `hang` is noticed by the supervisor's no-progress timeout, so the gate waits this
/// long once. Short enough not to dominate, long enough that a slow driver bring-up is
/// not mistaken for the injected hang.
const HANG_TIMEOUT_SECS: u64 = 20;

pub fn main(args: SelftestArgs) -> ExitCode {
    let Some(api) = Api::from_case_name(&args.api) else {
        eprintln!("error: '{}' is not a case-name root", args.api);
        return ExitCode::FAILURE;
    };

    // Nothing is proved by running the checks against a driver that is not there: every
    // one of them would "fail" for a reason that has nothing to do with the fuzzer.
    match super::health::probe_here(api, args.common.device_id, args.common.validation) {
        Ok(description) => println!("driver: {description}"),
        Err(e) => {
            eprintln!("{} did not come up: {e}", api.label());
            eprintln!("selftest needs a working driver - it injects faults into the harness, not into the driver.");
            return ExitCode::from(super::EXIT_NO_DRIVER);
        }
    }

    let base = std::env::temp_dir().join(format!("hodow-cts-selftest-{}", std::process::id()));
    let mut gate = Gate::new(base.clone(), api, args.common.device_id, args.common.validation);

    gate.check_abort_names_the_case_that_died();
    gate.check_poison_names_the_case_after_the_trigger();
    gate.check_hang_is_a_timeout_not_a_crash();
    gate.check_the_reproduction_rate_is_measured();
    gate.check_something_that_stops_happening_reports_zero();
    gate.check_a_fail_that_only_happens_in_company_is_a_finding();
    gate.check_a_case_that_fails_alone_is_not_a_finding();
    gate.check_minimisation_finds_the_trigger_and_quarantines_it();
    gate.check_a_minimisation_survives_the_machine_dying_mid_step();
    gate.check_a_verdict_that_changes_between_passes_is_flaky();
    gate.check_a_parallel_crash_that_reproduces_serially_is_not_a_race();
    gate.check_a_verdict_moving_between_epochs_is_reported();
    gate.check_verdicts_arrive_while_the_group_is_still_running();
    gate.check_a_machine_that_never_came_back_becomes_a_finding();
    gate.check_last_was_fine_records_nothing();
    gate.check_a_settled_group_is_not_rerun();

    println!();
    if args.keep {
        println!("scratch campaigns kept in {}", base.display());
    } else {
        let _ = std::fs::remove_dir_all(&base);
    }

    println!("{} of {} check(s) passed", gate.passed, gate.passed + gate.failed);
    if gate.failed == 0 {
        ExitCode::SUCCESS
    } else {
        ExitCode::FAILURE
    }
}

/// One scratch campaign's settings. A struct rather than four positional arguments,
/// because `("hang", 20, 1, 0)` says nothing at a call site.
struct Scratch {
    label: &'static str,
    timeout_secs: u64,
    repro_attempts: u32,
    minimize_budget: u32,
    repeats: u32,
    jobs: usize,
}

impl Default for Scratch {
    fn default() -> Self {
        Self {
            label: "scratch",
            timeout_secs: 60,
            repro_attempts: 1,
            minimize_budget: 400,
            repeats: 1,
            jobs: 1,
        }
    }
}

struct Gate {
    base: PathBuf,
    api: Api,
    device_id: usize,
    validation: bool,
    n: usize,
    passed: usize,
    failed: usize,
}

impl Gate {
    fn new(base: PathBuf, api: Api, device_id: usize, validation: bool) -> Self {
        Self {
            base,
            api,
            device_id,
            validation,
            n: 0,
            passed: 0,
            failed: 0,
        }
    }

    /// The easy shape: the case that aborts really is the cause, so the culprit the
    /// isolation machinery names is also the answer.
    fn check_abort_names_the_case_that_died(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "abort",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Abort,
            case: victim.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect("a case that aborts is named as the culprit", || {
            outcome.as_ref().map_err(|e| e.to_string())?;
            let finding = read_finding(&runner, 1)?;
            same("kind", &finding.kind, "crash")?;
            same("culprit", finding.culprit.as_deref().unwrap_or(""), &victim)?;
            if !finding.completed_exact {
                return Err("the supervisor watched this happen, so the count must be exact".to_string());
            }
            Ok(())
        });
    }

    /// The shape this whole tool exists for: the case that dies is innocent, and the
    /// one that has to be found is the one before it.
    fn check_poison_names_the_case_after_the_trigger(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "poison",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let trigger = group[2].clone();
        let expected_victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Poison,
            case: trigger.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "poisoning after one case kills the next one, and that is what is recorded",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let finding = read_finding(&runner, 1)?;
                same("culprit", finding.culprit.as_deref().unwrap_or(""), &expected_victim)?;
                // Three reported before it - the trigger itself is healthy and passes.
                if finding.completed != 3 {
                    return Err(format!(
                        "expected 3 cases to have reported before the victim, got {}",
                        finding.completed
                    ));
                }
                // The prefix is what a replay runs, so it has to contain the trigger; the
                // trigger being in there is the entire reason a replay reproduces at all.
                let prefix = read_lines(&runner, 1, "prefix.txt")?;
                if !prefix.contains(&trigger) {
                    return Err("the saved prefix does not contain the case that caused it".to_string());
                }
                if prefix.last() != Some(&expected_victim) {
                    return Err("the saved prefix does not end at the case that died".to_string());
                }
                Ok(())
            },
        );
    }

    fn check_hang_is_a_timeout_not_a_crash(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "hang",
            timeout_secs: HANG_TIMEOUT_SECS,
            minimize_budget: 0,
            ..Scratch::default()
        }) else {
            return;
        };
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Hang,
            case: victim.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect("a case that never returns is a timeout, distinct from a crash", || {
            outcome.as_ref().map_err(|e| e.to_string())?;
            let finding = read_finding(&runner, 1)?;
            same("kind", &finding.kind, "timeout")?;
            same("culprit", finding.culprit.as_deref().unwrap_or(""), &victim)?;
            Ok(())
        });
    }

    /// No process died here that this code could observe - the record on disk is
    /// everything, which is exactly the situation after a power cut.
    /// What `fabricate_hard_death` below cannot check, because it writes the progress
    /// file itself: that anything ever writes it for real.
    ///
    /// The campaign records a group's progress from `run_group`'s per-case callback, and
    /// that file is the only thing left to say how far a group got when the machine
    /// never came back. It was empty every time: results were handed over once the batch
    /// ended, and a group is one batch, so the callback fired exactly when its answer had
    /// stopped being worth anything. Every finding from a dead machine then named the
    /// group's *first* case, which is a default dressed as evidence.
    fn check_verdicts_arrive_while_the_group_is_still_running(&mut self) {
        let Some((_runner, group)) = self.campaign(Scratch {
            label: "stream",
            timeout_secs: HANG_TIMEOUT_SECS,
            ..Scratch::default()
        }) else {
            return;
        };
        let settings = Settings {
            device_id: self.device_id,
            validation: self.validation,
            timeout: Duration::from_secs(HANG_TIMEOUT_SECS),
        };

        // A hang a few cases in holds the worker open for the whole no-progress timeout,
        // which is what turns "did this arrive before the group ended" into a question
        // with an unambiguous answer rather than a race.
        set_fault(Some(&Fault {
            kind: Kind::Hang,
            case: group[3].clone(),
            percent: 100,
        }));
        let started = Instant::now();
        let mut first = None;
        let outcome = oracle::run_group(self.api, &group, &settings, |_| {
            first.get_or_insert(started.elapsed());
        });
        let total = started.elapsed();
        set_fault(None);

        self.expect(
            "a verdict reaches the supervisor while the group is still running",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let Some(first) = first else {
                    return Err("no verdict arrived at all".to_string());
                };
                if total < first + Duration::from_secs(5) {
                    return Err(format!(
                        "the first verdict arrived at {first:?} and the group ended at {total:?} - they came together, \
                     so nothing was recorded while it ran"
                    ));
                }
                Ok(())
            },
        );
    }

    fn check_a_machine_that_never_came_back_becomes_a_finding(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "died",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        self.fabricate_hard_death(&mut runner, &group, 5);

        let settled = runner.settle(Verdict::Reproduced(Severity::GpuHang));

        self.expect(
            "an in-flight group left by a dead machine becomes a finding a person tagged",
            || {
                settled.as_ref().map_err(|e| e.to_string())?;
                let finding = read_finding(&runner, 1)?;
                same("kind", &finding.kind, "machine-died")?;
                same("severity", finding.severity.as_deref().unwrap_or(""), "gpu-hang")?;
                if finding.completed != 5 {
                    return Err(format!(
                        "expected the progress file's 5 to be believed, got {}",
                        finding.completed
                    ));
                }
                if finding.completed_exact {
                    return Err("a count recovered from a hard death is a lower bound and must say so".to_string());
                }
                same("culprit", finding.culprit.as_deref().unwrap_or(""), &group[5])?;
                // The case list has to be rebuilt from the seed, since the record held none.
                let cases = read_lines(&runner, 1, "cases.txt")?;
                if cases != group {
                    return Err(
                        "the group rebuilt from the in-flight record is not the one that was running".to_string(),
                    );
                }
                if runner.store().read_inflight().is_some() {
                    return Err("the in-flight record was not cleared".to_string());
                }
                Ok(())
            },
        );
    }

    fn check_last_was_fine_records_nothing(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "fine",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        self.fabricate_hard_death(&mut runner, &group, 5);

        let settled = runner.settle(Verdict::Fine);

        self.expect(
            "`continue --last-was-fine` discards the in-flight group instead of blaming it",
            || {
                settled.as_ref().map_err(|e| e.to_string())?;
                if runner.store().findings_dir().join("0001-machine-died").exists() {
                    return Err("a finding was recorded for a group the user said was not at fault".to_string());
                }
                if runner.state().findings != 0 {
                    return Err(format!("the finding count moved to {}", runner.state().findings));
                }
                if runner.store().read_inflight().is_some() {
                    return Err("the in-flight record was not cleared".to_string());
                }
                Ok(())
            },
        );
    }

    /// The rate is what later decides whether minimising is worth anything at all, so
    /// it has to be measured rather than assumed from the fact that something happened.
    fn check_the_reproduction_rate_is_measured(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "rate",
            timeout_secs: 60,
            repro_attempts: 3,
            ..Scratch::default()
        }) else {
            return;
        };
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Abort,
            case: victim,
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "a crash that always happens is recorded as reproducing every time",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let finding = read_finding(&runner, 1)?;
                if finding.repro.attempts != 3 || finding.repro.reproduced != 3 {
                    return Err(format!("expected 3/3, got {}", finding.repro.summary()));
                }
                if !finding.repro.is_reproducible() {
                    return Err("3/3 is not being read as reproducible".to_string());
                }
                Ok(())
            },
        );
    }

    /// The other half of the same claim, and the one that matters: something that does
    /// not happen again has to come out as 0/N. Without this, "reproducible" could be a
    /// constant and every check above would still pass.
    fn check_something_that_stops_happening_reports_zero(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "norepro",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Abort,
            case: victim,
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        // Disarmed before the replay: the list is the same, the fault is gone, so the
        // honest answer is that it no longer reproduces.
        set_fault(None);

        self.expect(
            "a list that no longer misbehaves replays as 0/N, and is folded in",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let campaign = runner.store().read_campaign().map_err(|e| e.to_string())?;
                let report = super::triage::replay_finding(runner.store(), &campaign, 1, 4, false, |_| {})
                    .map_err(|e| e.to_string())?;
                if report.reproduced != 0 || report.attempts != 4 {
                    return Err(format!("expected 0/4 from the replay, got {}", report.summary()));
                }
                // 1/1 from the original detection plus 0/4 now: history is added to, not
                // replaced, or a stale replay would erase a real reproduction.
                let finding = read_finding(&runner, 1)?;
                if finding.repro.attempts != 5 || finding.repro.reproduced != 1 {
                    return Err(format!(
                        "expected the finding to hold 1/5 overall, got {}",
                        finding.repro.summary()
                    ));
                }
                Ok(())
            },
        );
    }

    /// The order-dependent shape: a case that is perfectly healthy alone and fails only
    /// because of what ran before it. In a thousand-case run this is invisible - the
    /// Fail looks like any other Fail.
    fn check_a_fail_that_only_happens_in_company_is_a_finding(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "orderdep",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let trigger = group[2].clone();
        let expected_victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::FailAfter,
            case: trigger,
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "a case that fails in company but passes alone is recorded as order-dependent",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let finding = read_finding(&runner, 1)?;
                same("kind", &finding.kind, super::triage::ORDER_DEPENDENT_FAIL)?;
                same("culprit", finding.culprit.as_deref().unwrap_or(""), &expected_victim)?;
                // The fault is still armed while the single-case verification runs, but a
                // `failafter` needs its trigger to have run first - and alone, it has not.
                // So the victim passes, which is exactly the claim being made about it.
                let baseline = read_baseline(&runner)?;
                match baseline.get(&expected_victim) {
                    Some(alone) if alone.passes() => Ok(()),
                    Some(alone) => Err(format!(
                        "the baseline recorded it as {} rather than passing alone",
                        alone.status
                    )),
                    None => Err("the victim never got verified on its own".to_string()),
                }
            },
        );
    }

    /// The negative control for the check above. A case that is simply broken fails in
    /// company *and* alone, and must not be dressed up as an order-dependent finding -
    /// otherwise every broken case on an unfamiliar driver becomes one.
    fn check_a_case_that_fails_alone_is_not_a_finding(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "plainfail",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Fail,
            case: victim.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "a case that fails on its own too is not reported as order-dependent",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                if runner
                    .store()
                    .findings()
                    .iter()
                    .any(|f| f.kind == super::triage::ORDER_DEPENDENT_FAIL)
                {
                    return Err("a plainly broken case was recorded as an order-dependent finding".to_string());
                }
                // It still has to have been *checked*, or this check would pass simply
                // because nothing ever looks at failures.
                let baseline = read_baseline(&runner)?;
                match baseline.get(&victim) {
                    Some(alone) if !alone.passes() => Ok(()),
                    Some(alone) => Err(format!(
                        "the baseline recorded it as {}, so it was not the injected fault that ran",
                        alone.status
                    )),
                    None => Err("the failing case was never verified on its own".to_string()),
                }
            },
        );
    }

    /// The claim the whole design rests on: from a group of nineteen, the two cases that
    /// matter, and the one excluded afterwards is the *trigger* rather than the casualty.
    ///
    /// Getting this backwards is not a cosmetic error. It would remove a healthy case,
    /// leave the real cause in the pool, and bring the bug straight back with a new
    /// victim - and nothing in a clean run would ever show it.
    fn check_minimisation_finds_the_trigger_and_quarantines_it(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "minimise",
            ..Scratch::default()
        }) else {
            return;
        };
        let trigger = group[2].clone();
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Poison,
            case: trigger.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "nineteen cases shrink to the trigger and its casualty, and the trigger is what gets excluded",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let repro = read_lines(&runner, 1, "repro.txt")?;
                if repro != vec![trigger.clone(), victim.clone()] {
                    return Err(format!("expected exactly [trigger, victim], got {repro:?}"));
                }

                let quarantine = read_quarantine(&runner)?;
                if !quarantine.excludes(&trigger) {
                    return Err("the trigger was not excluded".to_string());
                }
                if quarantine.excludes(&victim) {
                    return Err(
                        "the casualty was excluded - that removes a healthy case and leaves the cause in the pool"
                            .to_string(),
                    );
                }
                Ok(())
            },
        );
    }

    /// Minimising a bug that hangs a GPU means a reset every few steps, so the state has
    /// to survive one - and the step that was running when the machine died is not a
    /// lost step, it is that candidate answering yes.
    fn check_a_minimisation_survives_the_machine_dying_mid_step(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "minresume",
            // One call in and then parked, so there is a half-finished minimisation to
            // interrupt rather than a finished one.
            minimize_budget: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let trigger = group[2].clone();
        let victim = group[3].clone();

        set_fault(Some(&Fault {
            kind: Kind::Poison,
            case: trigger.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});

        // What a power cut leaves behind: the in-flight note for the step that was
        // running, and a state file from just before it.
        let before = super::minimize::load_state(runner.store(), 1).map(|s| s.current.len());
        let _ = runner.store().begin_inflight(&Inflight {
            phase: super::campaign::PHASE_MINIMIZE.to_string(),
            started_epoch: now_epoch().saturating_sub(300),
            api: "dEQP-GLES2".to_string(),
            epoch: 0,
            epoch_seed: 0,
            group: 0,
            size: 0,
            pool_fingerprint: 0,
            finding: Some(1),
        });
        let settled = runner.settle(Verdict::Reproduced(Severity::GpuHang));
        let after_death = super::minimize::load_state(runner.store(), 1).map(|s| s.current.len());
        let inflight_cleared = runner.store().read_inflight().is_none();

        // Carrying on happens with the fault still armed - the bug it is chasing has to
        // still be there, or every candidate "fails to reproduce" and the minimisation
        // stops wherever it happens to be.
        let resumed = runner.minimize_finding(1, false);
        set_fault(None);

        self.expect(
            "a minimisation step that kills the machine counts as a reproduction, and the rest resumes",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                settled.as_ref().map_err(|e| e.to_string())?;
                resumed.as_ref().map_err(|e| e.to_string())?;

                let before = before.ok_or("the minimisation never wrote a state to resume from")?;
                let after = after_death.ok_or("the state went missing")?;
                if after >= before {
                    return Err(format!(
                        "the dead step was not credited: {before} cases before, {after} after"
                    ));
                }
                if !inflight_cleared {
                    return Err("the in-flight record was not cleared".to_string());
                }

                let repro = read_lines(&runner, 1, "repro.txt")?;
                if repro != vec![trigger.clone(), victim.clone()] {
                    return Err(format!("resuming did not reach [trigger, victim], got {repro:?}"));
                }
                Ok(())
            },
        );
    }

    /// `--repeats` and the flakiness detector in one, with no dice involved.
    ///
    /// A `failafter` arms on its trigger and stays armed for the life of the process, so
    /// with the group run twice over, the cases *before* the trigger pass on the first
    /// pass and fail on the second. That is the "passed three times, failed the fourth"
    /// shape exactly, and it is deterministic - a percentage-based fault would make this
    /// gate fail one run in a hundred, which is worse than not having it.
    fn check_a_verdict_that_changes_between_passes_is_flaky(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "repeats",
            repeats: 2,
            ..Scratch::default()
        }) else {
            return;
        };
        let trigger = group[2].clone();
        let early = group[0].clone();

        set_fault(Some(&Fault {
            kind: Kind::FailAfter,
            case: trigger,
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "a case that passes on the first pass and fails on the second is recorded as flaky",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let flaky: Vec<Finding> = runner
                    .store()
                    .findings()
                    .into_iter()
                    .filter(|f| f.kind == "flaky-verdict")
                    .collect();
                if flaky.is_empty() {
                    return Err("nothing was recorded as flaky, so the two passes were not compared".to_string());
                }
                let found = flaky.iter().find(|f| f.culprit.as_deref() == Some(early.as_str()));
                let found =
                    found.ok_or_else(|| format!("{early} passed then failed but was not among the flaky findings"))?;
                if !found.message.contains("Pass") || !found.message.contains("Fail") {
                    return Err(format!("the finding does not name both verdicts: {}", found.message));
                }
                Ok(())
            },
        );
    }

    /// A crash found with other workers alive is not automatically a race. If it
    /// reproduces on its own, contention only brought it forward, and treating it as a
    /// race would park a perfectly ordinary bug as unreproducible.
    fn check_a_parallel_crash_that_reproduces_serially_is_not_a_race(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "jobs",
            jobs: 2,
            ..Scratch::default()
        }) else {
            return;
        };
        // In the first worker's half, so that half alone still reproduces it.
        let trigger = group[1].clone();

        set_fault(Some(&Fault {
            kind: Kind::Poison,
            case: trigger.clone(),
            percent: 100,
        }));
        let outcome = runner.run_loop(Some(1), |_| {});
        set_fault(None);

        self.expect(
            "a crash under contention that reproduces on its own stays an ordinary finding",
            || {
                outcome.as_ref().map_err(|e| e.to_string())?;
                let finding = read_finding(&runner, 1)?;
                if finding.severity.as_deref() == Some("race") {
                    return Err(
                        "it reproduces serially, so calling it a race parks a bug that is perfectly tractable"
                            .to_string(),
                    );
                }
                if !finding.repro.is_reproducible() {
                    return Err(format!("it should reproduce serially, got {}", finding.repro.summary()));
                }
                // Only the dying worker's half, not the whole group - the other worker was
                // somewhere else entirely and replaying it would prove nothing.
                let cases = read_lines(&runner, 1, "cases.txt")?;
                if cases.len() >= group.len() {
                    return Err(format!(
                        "the finding kept all {} cases instead of the dying worker's share",
                        cases.len()
                    ));
                }
                if !cases.contains(&trigger) {
                    return Err("the finding did not keep the half that actually contained the trigger".to_string());
                }
                Ok(())
            },
        );
    }

    /// Two sweeps of the same pool on the same driver, and a verdict that moved between
    /// them. Neither run on its own can say anything about it.
    fn check_a_verdict_moving_between_epochs_is_reported(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "drift",
            ..Scratch::default()
        }) else {
            return;
        };
        let victim = group[4].clone();

        // Epoch 1 clean, then the case starts failing, then far enough for the
        // comparison of epochs 1 and 2 to happen at the start of epoch 3.
        let first = runner.run_loop(Some(1), |_| {});
        set_fault(Some(&Fault {
            kind: Kind::Fail,
            case: victim.clone(),
            percent: 100,
        }));
        let rest = runner.run_loop(Some(2), |_| {});
        set_fault(None);

        self.expect(
            "a case whose verdict moved between two sweeps is reported as drift",
            || {
                first.as_ref().map_err(|e| e.to_string())?;
                rest.as_ref().map_err(|e| e.to_string())?;

                let journal = std::fs::read_to_string(runner.store().journal_path()).map_err(|e| e.to_string())?;
                if !journal.contains("\"event\":\"drift\"") {
                    return Err("no drift was reported after the second sweep finished".to_string());
                }
                if !journal.contains("Pass -> Fail") {
                    return Err("the drift report does not name the transition that happened".to_string());
                }
                if !journal.contains(&victim) {
                    return Err(format!("{victim} moved from Pass to Fail but is not named"));
                }
                Ok(())
            },
        );
    }

    /// A settled group must not come round again: replaying it unasked would rerun
    /// whatever just killed the machine, immediately, without being told to.
    fn check_a_settled_group_is_not_rerun(&mut self) {
        let Some((mut runner, group)) = self.campaign(Scratch {
            label: "advance",
            timeout_secs: 60,
            repro_attempts: 1,
            ..Scratch::default()
        }) else {
            return;
        };
        let before = runner.state().apis[0].group;
        self.fabricate_hard_death(&mut runner, &group, 2);
        let settled = runner.settle(Verdict::Reproduced(Severity::Unspecified));

        self.expect("settling moves past the group that was in flight", || {
            settled.as_ref().map_err(|e| e.to_string())?;
            let after = runner.state().apis[0].group;
            if after <= before {
                return Err(format!("the cursor stayed at {after} - the same group would run again"));
            }
            Ok(())
        });
    }

    /// A scratch campaign whose single group is the whole pool, so the ordering the
    /// checks reason about is one permutation and there is no second group to confuse
    /// the accounting. `repro_attempts` is 1 unless the check is about the rate itself,
    /// since every extra attempt is another whole group run.
    fn campaign(&mut self, scratch: Scratch) -> Option<(Runner, Vec<String>)> {
        let Scratch {
            label,
            timeout_secs,
            repro_attempts,
            minimize_budget,
            repeats,
            jobs,
        } = scratch;
        let pool_size = super::pool::build(&[POOL_FILTER.to_string()], &[])
            .first()
            .map(|p| p.names.len())
            .unwrap_or(0);
        if pool_size < 8 {
            self.n += 1;
            self.failed += 1;
            println!(
                "  {:<2} FAIL  {POOL_FILTER} has only {pool_size} cases - too few to inject into",
                self.n
            );
            return None;
        }

        // A base directory per check: `baseline.json` lives beside the campaigns and is
        // shared by design, which between checks would mean one check's answer about a
        // case silently deciding the next one's.
        let runner = Runner::create(
            self.base.join(label),
            "campaign".to_string(),
            NewCampaign {
                seed: 0x5EED_5EED,
                group_size: pool_size,
                case_filters: vec![POOL_FILTER.to_string()],
                exclude_filters: vec![],
                device_id: self.device_id,
                validation: self.validation,
                timeout_secs,
                // Off: these campaigns crash on purpose and must not stop themselves.
                wedge_threshold: 0,
                repro_attempts,
                use_quarantine: true,
                minimize_budget,
                repeats,
                replicas: 1,
                jobs,
            },
        );

        match runner {
            Ok(mut runner) => {
                let group = runner.peek_next_group().unwrap_or_default();
                Some((runner, group))
            }
            Err(e) => {
                self.n += 1;
                self.failed += 1;
                println!("  {:<2} FAIL  could not create a scratch campaign: {e}", self.n);
                None
            }
        }
    }

    /// Leaves exactly what a power cut leaves: an in-flight record, a partial progress
    /// file, and no process.
    fn fabricate_hard_death(&self, runner: &mut Runner, group: &[String], completed: usize) {
        let state = &runner.state().apis[0];
        let inflight = Inflight {
            phase: "group".to_string(),
            started_epoch: now_epoch().saturating_sub(2820),
            api: state.root.clone(),
            epoch: state.epoch,
            epoch_seed: state.epoch_seed,
            group: state.group,
            size: group.len(),
            pool_fingerprint: runner.campaign().pools[0].fingerprint,
            finding: None,
        };
        let _ = runner.store().begin_inflight(&inflight);
        let progress: String = group.iter().take(completed).map(|n| format!("{n}\n")).collect();
        let _ = std::fs::write(runner.store().progress_path(), progress);
    }

    fn expect(&mut self, what: &str, check: impl FnOnce() -> Result<(), String>) {
        self.n += 1;
        match check() {
            Ok(()) => {
                self.passed += 1;
                println!("  {:<2} ok    {what}", self.n);
            }
            Err(why) => {
                self.failed += 1;
                println!("  {:<2} FAIL  {what}", self.n);
                println!("           {why}");
            }
        }
    }
}

/// What this check's scratch campaign has excluded, as it stands on disk.
fn read_quarantine(runner: &Runner) -> Result<Quarantine, String> {
    let base = runner
        .store()
        .dir
        .parent()
        .ok_or("the campaign has no base directory")?;
    Ok(Quarantine::load(base))
}

/// The per-machine table of how cases behave alone, as it stands on disk.
fn read_baseline(runner: &Runner) -> Result<Baseline, String> {
    let base = runner
        .store()
        .dir
        .parent()
        .ok_or("the campaign has no base directory")?;
    Ok(Baseline::load(base))
}

fn read_finding(runner: &Runner, id: u32) -> Result<Finding, String> {
    let dir = find_finding_dir(runner, id)?;
    let text = std::fs::read_to_string(dir.join("finding.json")).map_err(|e| format!("no finding {id}: {e}"))?;
    serde_json::from_str(&text).map_err(|e| format!("finding {id} is not readable: {e}"))
}

fn read_lines(runner: &Runner, id: u32, file: &str) -> Result<Vec<String>, String> {
    let dir = find_finding_dir(runner, id)?;
    let text = std::fs::read_to_string(dir.join(file)).map_err(|e| format!("no {file} for finding {id}: {e}"))?;
    Ok(text.lines().map(str::to_string).collect())
}

fn find_finding_dir(runner: &Runner, id: u32) -> Result<PathBuf, String> {
    let prefix = format!("{id:04}-");
    std::fs::read_dir(runner.store().findings_dir())
        .map_err(|e| format!("no findings directory: {e}"))?
        .filter_map(Result::ok)
        .map(|e| e.path())
        .find(|p| {
            p.file_name()
                .and_then(|n| n.to_str())
                .is_some_and(|n| n.starts_with(&prefix))
        })
        .ok_or_else(|| format!("nothing was recorded as finding {id}"))
}

fn same(what: &str, got: &str, want: &str) -> Result<(), String> {
    if got == want {
        Ok(())
    } else {
        Err(format!("{what}: expected {want}, got {got}"))
    }
}

/// Arms a fault for the workers this process is about to spawn.
///
/// The variable is read once per worker, and a worker is a fresh process, so setting it
/// here is what reaches them. Safe at this point for the reason `main`'s `NO_COLOR` is:
/// nothing else in this process is running yet.
fn set_fault(fault: Option<&Fault>) {
    match fault {
        Some(fault) => unsafe { std::env::set_var(FAULT_ENV, fault.to_spec()) },
        None => unsafe { std::env::remove_var(FAULT_ENV) },
    }
}
