// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Which cases run next. Units are computed from the stage and an index over the full,
// unfiltered corpus, so quarantining a case never shifts what a later unit holds and the
// cursor survives a restart; the quarantine is applied only when a unit is run.
//
//   phase 1  each API in tree order, in batches
//   phase 2  each API shuffled, a new permutation per epoch, until every API has gone
//            `dry_epochs` epochs without a new finding
//   phase 3  each API whole, in one process
//   then phase 2 again, with the dry counters reset

use std::collections::BTreeMap;

use serde::{Deserialize, Serialize};

use crate::fuzz::rng::{SplitMix64, derive, shuffle};

pub struct Corpus {
    /// `(root, cases)` in `Api::ALL` order, empty roots left out.
    pub apis: Vec<(String, Vec<String>)>,
}

impl Corpus {
    pub fn from_names(names: &[String]) -> Self {
        let mut apis: Vec<(String, Vec<String>)> = Vec::new();
        for api in crate::runner::Api::ALL {
            let cases: Vec<String> = names
                .iter()
                .filter(|n| n.split('.').next() == Some(api.root()))
                .cloned()
                .collect();
            if !cases.is_empty() {
                apis.push((api.root().to_string(), cases));
            }
        }
        Self { apis }
    }

    pub fn fingerprint(&self) -> u64 {
        crate::fuzz::rng::fingerprint(self.apis.iter().flat_map(|(_, cases)| cases.iter().map(String::as_str)))
    }

    pub fn len(&self) -> usize {
        self.apis.iter().map(|(_, c)| c.len()).sum()
    }

    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }
}

pub fn short_api(root: &str) -> &str {
    root.strip_prefix("dEQP-").unwrap_or(root)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Stage {
    Sweep { api: usize },
    Shuffle { api: usize },
    Full { api: usize },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Unit {
    pub label: String,
    pub api: String,
    pub cases: Vec<String>,
    /// The first case not yet run.
    pub from: usize,
    /// Cases that already died once in this unit; a second time they are stepped over.
    #[serde(default)]
    pub died: Vec<String>,
    #[serde(default)]
    pub shuffled: bool,
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct ApiStats {
    /// Shuffled epochs completed, ever. Also what seeds the next permutation.
    pub epochs: u64,
    /// Consecutive epochs without a new finding.
    pub dry: u32,
    pub new_this_epoch: bool,
    /// One byte per corpus case: `P`, `F`, or `.` for no verdict.
    #[serde(default)]
    pub verdicts: String,
    #[serde(default)]
    pub last_verdicts: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct State {
    pub fingerprint: u64,
    pub seed: u64,
    pub stage: Stage,
    /// Next unit of the stage to hand out.
    pub unit: usize,
    pub cycle: u32,
    pub active: Option<Unit>,
    /// Halves of units split after a minimisation ran out of budget, run before anything else.
    #[serde(default)]
    pub queue: Vec<Unit>,
    #[serde(default)]
    pub apis: BTreeMap<String, ApiStats>,
}

impl State {
    pub fn new(fingerprint: u64, seed: u64) -> Self {
        Self {
            fingerprint,
            seed,
            stage: Stage::Sweep { api: 0 },
            unit: 0,
            cycle: 0,
            active: None,
            queue: Vec::new(),
            apis: BTreeMap::new(),
        }
    }
}

pub struct Settings {
    pub batch: usize,
    pub dry_epochs: u32,
}

/// What happened between two units, for the log.
pub enum Event {
    PhaseStarted(String),
    EpochDone {
        api: String,
        epoch: u64,
        new: bool,
        flips: Vec<(String, char, char)>,
    },
    CycleDone,
}

/// The next unit to run, moving through stages as each runs out.
pub fn next_unit(state: &mut State, corpus: &Corpus, settings: &Settings, events: &mut Vec<Event>) -> Unit {
    if !state.queue.is_empty() {
        return state.queue.remove(0);
    }
    let n_apis = corpus.apis.len();
    loop {
        match state.stage {
            Stage::Sweep { api } => {
                if api >= n_apis {
                    start_shuffle(state, corpus, settings, events);
                    continue;
                }
                let (root, cases) = &corpus.apis[api];
                let count = cases.len().div_ceil(settings.batch);
                if state.unit >= count {
                    state.stage = Stage::Sweep { api: api + 1 };
                    state.unit = 0;
                    continue;
                }
                let start = state.unit * settings.batch;
                let end = (start + settings.batch).min(cases.len());
                state.unit += 1;
                return Unit {
                    label: format!(
                        "phase 1: {} batch {}/{count} (cases {}-{end})",
                        short_api(root),
                        state.unit,
                        start + 1
                    ),
                    api: root.clone(),
                    cases: cases[start..end].to_vec(),
                    from: 0,
                    died: Vec::new(),
                    shuffled: false,
                };
            }
            Stage::Shuffle { api } => {
                let (root, cases) = &corpus.apis[api];
                let count = cases.len().div_ceil(settings.batch);
                if state.unit >= count {
                    finish_epoch(state, root, cases, events);
                    match next_shuffled_api(state, corpus, settings, api) {
                        Some(next) => {
                            state.stage = Stage::Shuffle { api: next };
                            state.unit = 0;
                        }
                        None => {
                            state.stage = Stage::Full { api: 0 };
                            state.unit = 0;
                            events.push(Event::PhaseStarted(
                                "phase 3: every API whole, in one process".to_string(),
                            ));
                        }
                    }
                    continue;
                }
                let stats = state.apis.entry(root.clone()).or_default();
                if stats.verdicts.len() != cases.len() {
                    stats.verdicts = ".".repeat(cases.len());
                }
                let mut order: Vec<usize> = (0..cases.len()).collect();
                let mut rng = SplitMix64::new(derive(state.seed, root, stats.epochs));
                shuffle(&mut order, &mut rng);
                let start = state.unit * settings.batch;
                let end = (start + settings.batch).min(cases.len());
                state.unit += 1;
                return Unit {
                    label: format!(
                        "phase 2: {} epoch {} group {}/{count} (dry {}/{})",
                        short_api(root),
                        stats.epochs + 1,
                        state.unit,
                        stats.dry,
                        settings.dry_epochs
                    ),
                    api: root.clone(),
                    cases: order[start..end].iter().map(|&i| cases[i].clone()).collect(),
                    from: 0,
                    died: Vec::new(),
                    shuffled: true,
                };
            }
            Stage::Full { api } => {
                if api >= n_apis {
                    state.cycle += 1;
                    events.push(Event::CycleDone);
                    start_shuffle(state, corpus, settings, events);
                    continue;
                }
                let (root, cases) = &corpus.apis[api];
                state.stage = Stage::Full { api: api + 1 };
                state.unit = 0;
                return Unit {
                    label: format!("phase 3: {} whole ({} cases)", short_api(root), cases.len()),
                    api: root.clone(),
                    cases: cases.clone(),
                    from: 0,
                    died: Vec::new(),
                    shuffled: false,
                };
            }
        }
    }
}

fn start_shuffle(state: &mut State, corpus: &Corpus, settings: &Settings, events: &mut Vec<Event>) {
    for (root, _) in &corpus.apis {
        let stats = state.apis.entry(root.clone()).or_default();
        stats.dry = 0;
        stats.new_this_epoch = false;
    }
    state.stage = Stage::Shuffle { api: 0 };
    state.unit = 0;
    events.push(Event::PhaseStarted(format!(
        "phase 2: shuffled groups of {} per API, until each goes {} epochs without a new finding",
        settings.batch, settings.dry_epochs
    )));
}

fn finish_epoch(state: &mut State, root: &str, cases: &[String], events: &mut Vec<Event>) {
    let stats = state.apis.entry(root.to_string()).or_default();
    let flips = verdict_flips(&stats.last_verdicts, &stats.verdicts, cases);
    stats.epochs += 1;
    stats.dry = if stats.new_this_epoch { 0 } else { stats.dry + 1 };
    events.push(Event::EpochDone {
        api: root.to_string(),
        epoch: stats.epochs,
        new: stats.new_this_epoch,
        flips,
    });
    stats.new_this_epoch = false;
    stats.last_verdicts = std::mem::take(&mut stats.verdicts);
}

fn next_shuffled_api(state: &State, corpus: &Corpus, settings: &Settings, current: usize) -> Option<usize> {
    let n = corpus.apis.len();
    (1..=n).map(|step| (current + step) % n).find(|&i| {
        state
            .apis
            .get(&corpus.apis[i].0)
            .is_none_or(|s| s.dry < settings.dry_epochs)
    })
}

/// `(case, before, now)` for every case whose verdict flipped between Pass and Fail.
pub fn verdict_flips(before: &str, now: &str, cases: &[String]) -> Vec<(String, char, char)> {
    let (before, now) = (before.as_bytes(), now.as_bytes());
    if before.len() != cases.len() || now.len() != cases.len() {
        return Vec::new();
    }
    cases
        .iter()
        .enumerate()
        .filter(|&(i, _)| matches!((before[i], now[i]), (b'P', b'F') | (b'F', b'P')))
        .map(|(i, c)| (c.clone(), before[i] as char, now[i] as char))
        .collect()
}
