// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// A board made of rules, so the tester can be checked against faults whose right answer
// is known. A tester wired up wrong and a tester with nothing to find print the same thing.

use std::collections::HashSet;

use super::target::{Board, Fatal, FatalKind, Run, RunOpts, Stop};
use crate::fuzz::rng::SplitMix64;
use crate::report::CaseResult;
use crate::tcu::TestResult;

#[derive(Clone)]
pub struct Rule {
    /// The case that has to have run earlier in the same process, if any.
    pub after: Option<String>,
    pub case: String,
    pub kind: FatalKind,
    pub chance: f64,
    /// Fires the first time only.
    pub once: bool,
    /// Lets this many chances go by before it can fire at all.
    pub skip: u32,
}

impl Rule {
    pub fn alone(case: &str, kind: FatalKind) -> Self {
        Self {
            after: None,
            case: case.to_string(),
            kind,
            chance: 1.0,
            once: false,
            skip: 0,
        }
    }

    pub fn after(after: &str, case: &str, kind: FatalKind, chance: f64) -> Self {
        Self {
            after: Some(after.to_string()),
            case: case.to_string(),
            kind,
            chance,
            once: false,
            skip: 0,
        }
    }
}

pub struct SimBoard {
    pub rules: Vec<Rule>,
    pub fails_alone: Vec<String>,
    /// `(after, victim)`: the victim fails if `after` ran before it in the same process.
    pub order_fails: Vec<(String, String)>,
    /// Runs after each reboot that find no driver, like a compositor still coming up.
    pub no_driver_after_boot: u32,
    no_driver_left: u32,
    rng: SplitMix64,
    hung: bool,
    down: bool,
    fresh: bool,
    fired: HashSet<usize>,
    chances: Vec<u32>,
    pub runs: u64,
    pub reboots: u64,
    /// Things a correct tester never does, e.g. running on a hung GPU.
    pub violations: Vec<String>,
}

impl SimBoard {
    pub fn new(seed: u64) -> Self {
        Self {
            rules: Vec::new(),
            fails_alone: Vec::new(),
            order_fails: Vec::new(),
            no_driver_after_boot: 0,
            no_driver_left: 0,
            rng: SplitMix64::new(seed),
            hung: false,
            down: false,
            fresh: true,
            fired: HashSet::new(),
            chances: Vec::new(),
            runs: 0,
            reboots: 0,
            violations: Vec::new(),
        }
    }

    fn roll(&mut self, chance: f64) -> bool {
        chance >= 1.0 || (self.rng.next_u64() as f64 / u64::MAX as f64) < chance
    }

    fn fatal_for(&mut self, case: &str, seen: &HashSet<String>) -> Option<FatalKind> {
        for i in 0..self.rules.len() {
            let rule = self.rules[i].clone();
            if rule.case != case || rule.after.as_ref().is_some_and(|a| !seen.contains(a)) {
                continue;
            }
            if rule.once && self.fired.contains(&i) {
                continue;
            }
            self.chances.resize(self.rules.len(), 0);
            self.chances[i] += 1;
            if self.chances[i] <= rule.skip {
                continue;
            }
            if self.roll(rule.chance) {
                self.fired.insert(i);
                return Some(rule.kind);
            }
        }
        None
    }

    fn verdict(&self, case: &str, seen: &HashSet<String>) -> TestResult {
        if self.fails_alone.iter().any(|c| c == case)
            || self
                .order_fails
                .iter()
                .any(|(after, victim)| victim == case && seen.contains(after))
        {
            TestResult::Fail
        } else {
            TestResult::Pass
        }
    }
}

impl Board for SimBoard {
    fn run(&mut self, cases: &[String], opts: RunOpts, on_result: &mut dyn FnMut(&CaseResult)) -> Run {
        self.runs += 1;
        if self.no_driver_left > 0 {
            self.no_driver_left -= 1;
            return Run {
                results: Vec::new(),
                stop: Stop::NoDriver,
                output: String::new(),
                kernel: String::new(),
            };
        }
        self.fresh = false;
        if self.hung || self.down {
            self.violations.push(format!(
                "ran {} cases on a board that was {}",
                cases.len(),
                if self.down { "down" } else { "hung" }
            ));
        }
        let mut results = Vec::new();
        let mut output = String::new();
        let mut seen = HashSet::new();
        for case in cases {
            if opts.isolate_each {
                seen.clear();
            }
            if opts.dump_shaders {
                output.push_str(&format!(
                    "> {case}\n=== Compute shader ===\nvoid main() {{}}\n=== end ===\n"
                ));
            }
            if let Some(kind) = self.fatal_for(case, &seen) {
                match kind {
                    FatalKind::Hang => self.hung = true,
                    FatalKind::System => self.down = true,
                    FatalKind::ClientHang | FatalKind::Crash => {}
                }
                let status = if kind == FatalKind::Crash {
                    TestResult::Crash
                } else {
                    TestResult::Timeout
                };
                let result = CaseResult {
                    name: case.clone(),
                    status,
                    message: format!("simulated {}", kind.label()),
                    duration_us: 0,
                };
                on_result(&result);
                results.push(result);
                return Run {
                    results,
                    stop: Stop::Fatal(Fatal {
                        case: case.clone(),
                        kind,
                        message: format!("simulated {}", kind.label()),
                    }),
                    output,
                    kernel: String::new(),
                };
            }
            let result = CaseResult {
                name: case.clone(),
                status: self.verdict(case, &seen),
                message: String::new(),
                duration_us: 0,
            };
            on_result(&result);
            results.push(result);
            seen.insert(case.clone());
        }
        Run {
            results,
            stop: Stop::Finished,
            output,
            kernel: String::new(),
        }
    }

    fn healthy(&mut self) -> bool {
        !self.hung && !self.down
    }

    fn reboot(&mut self) {
        if self.down {
            self.violations
                .push("rebooted a board that does not answer".to_string());
        }
        self.reboots += 1;
        self.hung = false;
        self.down = false;
        self.fresh = true;
        self.no_driver_left = self.no_driver_after_boot;
    }

    fn wait_until_back(&mut self) {
        self.hung = false;
        self.down = false;
        self.fresh = true;
    }

    fn fresh(&self) -> bool {
        self.fresh
    }

    fn diag(&mut self) -> String {
        String::new()
    }

    fn pause_for_driver(&mut self) {}
}
