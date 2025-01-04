// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Deliberate faults, so the fuzzer can be tested against a known answer.
//
// The thing this fuzzer exists to catch is a broken driver, and the drivers available
// to develop against are not broken. A fuzzer that finds nothing and a fuzzer that is
// wired up wrong produce the same output, so "it ran and reported no findings" is not
// evidence of anything. `selftest` injects a fault whose correct minimal repro is known
// in advance and then checks that the pipeline arrived at exactly it.
//
// This is read from the environment and nothing sets it but `selftest`, so the hook in
// `run_case_loop` is a single `OnceLock` read on a path that already spawns a process
// and brings a driver up. The alternative - a cfg - would mean the gate could not run
// against a release build, which is the build that actually gets deployed.
//
// Format, in the worker's environment:
//
//   HODOW_CTS_FUZZ_FAULT=poison:<trigger-case>
//       once <trigger-case> has run in this process, the NEXT case aborts. This is the
//       state-poisoning shape: the case that dies is innocent and differs every run,
//       and the trigger is what a minimisation has to end up naming.
//   HODOW_CTS_FUZZ_FAULT=hang:<case>
//       <case> never returns, so the supervisor's timeout is what notices.
//   HODOW_CTS_FUZZ_FAULT=abort:<case>
//       <case> aborts outright - the easy shape, where the culprit really is the cause.
//   HODOW_CTS_FUZZ_FAULT=fail:<case>
//       <case> reports Fail. On its own this is a case that is simply broken.
//   HODOW_CTS_FUZZ_FAULT=failafter:<trigger>
//       the case after <trigger> reports Fail, and passes when run on its own. The
//       order-dependent shape, which is invisible in a large run because a Fail there
//       looks like any other Fail.
//
// A trailing `@<percent>` makes the fault fire only that often, which is how the flaky
// oracle is exercised: `poison:dEQP-GLES2.x@30`.

use std::sync::OnceLock;
use std::sync::atomic::{AtomicBool, Ordering};

use crate::tcu::TestStatus;

pub const FAULT_ENV: &str = "HODOW_CTS_FUZZ_FAULT";

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Kind {
    /// Arm on this case; abort on the one after it.
    Poison,
    Hang,
    Abort,
    Fail,
    /// Arm on this case; fail on the one after it.
    FailAfter,
}

/// What actually happens once a fault fires, as distinct from when it fires.
enum Effect {
    Abort,
    Hang,
    Fail,
}

impl Kind {
    /// Whether the named case is the trigger rather than the casualty. This is the
    /// distinction the whole fuzzer turns on: for these two the case that misbehaves is
    /// innocent, and the one that has to be found is the one before it.
    fn delayed(self) -> bool {
        matches!(self, Self::Poison | Self::FailAfter)
    }

    fn effect(self) -> Effect {
        match self {
            Self::Poison | Self::Abort => Effect::Abort,
            Self::Hang => Effect::Hang,
            Self::Fail | Self::FailAfter => Effect::Fail,
        }
    }

    fn name(self) -> &'static str {
        match self {
            Self::Poison => "poison",
            Self::Hang => "hang",
            Self::Abort => "abort",
            Self::Fail => "fail",
            Self::FailAfter => "failafter",
        }
    }
}

#[derive(Debug, Clone)]
pub struct Fault {
    pub kind: Kind,
    pub case: String,
    /// 1..=100. Anything else is rejected at parse time rather than clamped, because a
    /// silently clamped percentage would make a selftest assert the wrong thing.
    pub percent: u32,
}

impl Fault {
    pub fn parse(spec: &str) -> Result<Self, String> {
        let (head, percent) = match spec.rsplit_once('@') {
            Some((head, pct)) => {
                let pct: u32 = pct.parse().map_err(|_| format!("'{pct}' is not a percentage"))?;
                if !(1..=100).contains(&pct) {
                    return Err(format!("percentage must be 1..=100, got {pct}"));
                }
                (head, pct)
            }
            None => (spec, 100),
        };

        let (kind, case) = head
            .split_once(':')
            .ok_or_else(|| format!("expected '<kind>:<case>', got '{head}'"))?;
        let kind = match kind {
            "poison" => Kind::Poison,
            "hang" => Kind::Hang,
            "abort" => Kind::Abort,
            "fail" => Kind::Fail,
            "failafter" => Kind::FailAfter,
            other => {
                return Err(format!(
                    "unknown fault kind '{other}' (poison, hang, abort, fail, failafter)"
                ));
            }
        };
        if case.is_empty() {
            return Err("a fault needs a case name".to_string());
        }
        Ok(Self {
            kind,
            case: case.to_string(),
            percent,
        })
    }

    pub fn to_spec(&self) -> String {
        let kind = self.kind.name();
        if self.percent == 100 {
            format!("{kind}:{}", self.case)
        } else {
            format!("{kind}:{}@{}", self.case, self.percent)
        }
    }
}

fn configured() -> Option<&'static Fault> {
    static FAULT: OnceLock<Option<Fault>> = OnceLock::new();
    FAULT
        .get_or_init(|| {
            let spec = std::env::var(FAULT_ENV).ok()?;
            match Fault::parse(&spec) {
                Ok(fault) => Some(fault),
                Err(e) => {
                    // Not a panic: this is a test hook, and a malformed one must not be
                    // able to take down a run that had nothing to do with it.
                    log::error!("{FAULT_ENV}: {e} - no fault injected");
                    None
                }
            }
        })
        .as_ref()
}

/// Whether anything is armed at all, so the hot path is one atomic load.
pub fn enabled() -> bool {
    configured().is_some()
}

/// Called by `run_case_loop` immediately before a case runs.
///
/// `None` lets the case run normally. `Some(status)` replaces its verdict without
/// running it at all - and the two faults that take the process down never return.
pub fn before_case(name: &str) -> Option<TestStatus> {
    let fault = configured()?;
    static ARMED: AtomicBool = AtomicBool::new(false);

    let fire = if fault.kind.delayed() {
        if fault.case == name {
            // The trigger itself is healthy; that is the whole point of these two.
            ARMED.store(true, Ordering::Relaxed);
            return None;
        }
        ARMED.load(Ordering::Relaxed)
    } else {
        fault.case == name
    };

    if !fire || !rolls(fault.percent, name) {
        return None;
    }

    match fault.kind.effect() {
        Effect::Hang => {
            log::error!("injected fault: hanging in {name}");
            loop {
                std::thread::sleep(std::time::Duration::from_secs(3600));
            }
        }
        Effect::Abort => {
            log::error!("injected fault: aborting in {name}");
            // Not `panic!`: a panic is caught and reported as a verdict, and what is
            // being modelled here is a driver taking the process with it.
            std::process::abort();
        }
        Effect::Fail => {
            log::error!("injected fault: failing {name}");
            Some(TestStatus::fail("injected fault"))
        }
    }
}

/// Whether a partial-probability fault fires this time.
///
/// Seeded from the case name and the process id, so a given worker is deterministic
/// while successive workers differ - which is what makes the oracle flaky *between*
/// attempts rather than within one, the way a real intermittent bug behaves.
fn rolls(percent: u32, name: &str) -> bool {
    if percent >= 100 {
        return true;
    }
    let seed = super::rng::fnv1a(name.as_bytes()) ^ u64::from(std::process::id()).wrapping_mul(0x9E37_79B9_7F4A_7C15);
    super::rng::SplitMix64::new(seed).below(100) < u64::from(percent)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_spec_round_trips() {
        for spec in [
            "poison:dEQP-GLES2.a",
            "hang:dEQP-VK.b",
            "abort:dEQP-GLES31.c",
            "fail:dEQP-GLES2.d",
            "failafter:dEQP-GLES2.e",
            "poison:dEQP-GLES2.a@30",
        ] {
            assert_eq!(Fault::parse(spec).unwrap().to_spec(), spec);
        }
    }

    #[test]
    fn a_spec_without_a_percentage_always_fires() {
        assert_eq!(Fault::parse("abort:x").unwrap().percent, 100);
    }

    #[test]
    fn a_malformed_spec_is_rejected_with_a_reason() {
        for bad in ["", "x", "poison:", "wat:x", "abort:x@0", "abort:x@101", "abort:x@nope"] {
            assert!(Fault::parse(bad).is_err(), "'{bad}' should not parse");
        }
    }

    /// The percentage has to actually vary, or the flaky-oracle part of the gate is
    /// testing a deterministic fault and proving nothing.
    #[test]
    fn a_partial_percentage_fires_for_some_names_and_not_others() {
        let names: Vec<String> = (0..500).map(|i| format!("case{i}")).collect();
        let fired = names.iter().filter(|n| rolls(30, n)).count();
        assert!(
            fired > 50 && fired < 250,
            "30% of 500 should land well inside 50..250, got {fired}"
        );
    }

    /// The two delayed kinds are the interesting ones, and confusing them with the
    /// direct kinds would make the selftest assert the wrong case entirely.
    #[test]
    fn only_the_delayed_kinds_arm_on_a_trigger() {
        assert!(Kind::Poison.delayed());
        assert!(Kind::FailAfter.delayed());
        assert!(!Kind::Abort.delayed());
        assert!(!Kind::Hang.delayed());
        assert!(!Kind::Fail.delayed());
    }

    #[test]
    fn a_hundred_percent_always_rolls() {
        assert!((0..100).all(|i| rolls(100, &format!("case{i}"))));
    }
}
