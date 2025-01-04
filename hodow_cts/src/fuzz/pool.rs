// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// What a campaign draws from, and how a group is cut out of it.
//
// A pool is one API's share of the filtered corpus. An epoch is one permutation of a
// whole pool, cut into consecutive groups - so an epoch touches every case exactly
// once, and the next epoch is a fresh permutation and therefore an entirely new set of
// neighbours. That is the difference between systematically sweeping 17344 cases and
// drawing 1000 of them out of a hat 170 times and hoping.
//
// A group never mixes APIs, because a worker brings up exactly one driver and reads
// which from the first case name it is handed.

use super::quarantine::Quarantine;
use super::rng::{SplitMix64, fingerprint, shuffle};
use crate::runner::{Api, matches_filter};

/// One API's cases, in corpus order, after the campaign's filters.
pub struct Pool {
    pub api: Api,
    pub names: Vec<String>,
    /// Identifies the *contents and order* of `names`. A group is chosen by index into
    /// a permutation, so a pool that gained or lost a case turns a stored seed into a
    /// different group - silently, which is the only way this could go wrong.
    pub fingerprint: u64,
}

impl Pool {
    pub fn new(api: Api, names: Vec<String>) -> Self {
        let fingerprint = fingerprint(names.iter().map(String::as_str));
        Self {
            api,
            names,
            fingerprint,
        }
    }

    pub fn is_empty(&self) -> bool {
        self.names.is_empty()
    }

    /// How many groups one epoch is cut into; the last is short unless the pool
    /// divides evenly.
    pub fn groups_per_epoch(&self, size: usize) -> usize {
        self.names.len().div_ceil(size.max(1))
    }

    /// Group `index` of the epoch identified by `epoch_seed`, in execution order.
    ///
    /// The permutation is rebuilt from the seed on every call rather than cached: it is
    /// a shuffle of indices, microseconds even at 625k, and recomputing keeps the
    /// resumable state down to two integers per API instead of a stored ordering that
    /// would itself have to be kept consistent with the pool.
    ///
    /// The quarantine filters the *result*, not the pool. Filtering the pool would
    /// renumber the permutation, so every seed already recorded would start naming a
    /// different group the first time anything was excluded - and the whole point of
    /// storing seeds is that they keep meaning what they meant. A quarantined case
    /// simply leaves a slightly shorter group behind.
    pub fn group(&self, epoch_seed: u64, index: usize, size: usize, quarantine: &Quarantine) -> Vec<String> {
        let size = size.max(1);
        let mut order: Vec<u32> = (0..self.names.len() as u32).collect();
        shuffle(&mut order, &mut SplitMix64::new(epoch_seed));

        let start = (index * size).min(order.len());
        let end = (start + size).min(order.len());
        order[start..end]
            .iter()
            .map(|&i| self.names[i as usize].clone())
            .filter(|name| !quarantine.excludes(name))
            .collect()
    }
}

/// Builds one pool per API from the whole corpus, applying the campaign's filters.
///
/// An empty pool is kept out rather than carried as a root with nothing in it: the
/// round-robin between APIs would otherwise have to keep skipping it, and `status`
/// would report a root that can never produce a group.
pub fn build(case_filters: &[String], exclude_filters: &[String]) -> Vec<Pool> {
    let all_vk = crate::all_cases();
    let all_gl = crate::all_gl_cases();

    Api::ALL
        .into_iter()
        .filter_map(|api| {
            let names: Vec<String> = match api {
                Api::Vulkan => filtered(
                    all_vk.iter().map(|c| c.full_name.as_str()),
                    api,
                    case_filters,
                    exclude_filters,
                ),
                _ => filtered(
                    all_gl.iter().map(|c| c.full_name.as_str()),
                    api,
                    case_filters,
                    exclude_filters,
                ),
            };
            (!names.is_empty()).then(|| Pool::new(api, names))
        })
        .collect()
}

fn filtered<'a>(
    all: impl Iterator<Item = &'a str>,
    api: Api,
    case_filters: &[String],
    exclude_filters: &[String],
) -> Vec<String> {
    all.filter(|name| name.split('.').next() == Some(api.root()))
        .filter(|name| case_filters.is_empty() || case_filters.iter().any(|p| matches_filter(name, p)))
        .filter(|name| !exclude_filters.iter().any(|p| matches_filter(name, p)))
        .map(str::to_string)
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    /// An empty quarantine, for the cases that are not about filtering.
    fn open() -> Quarantine {
        Quarantine::load(&std::env::temp_dir().join("hodow-pool-tests-no-such-dir"))
    }

    fn pool(n: usize) -> Pool {
        Pool::new(Api::Gles2, (0..n).map(|i| format!("dEQP-GLES2.case{i:04}")).collect())
    }

    /// The property the epoch model exists for: one epoch covers the pool exactly once.
    #[test]
    fn an_epoch_covers_every_case_exactly_once() {
        let pool = pool(2500);
        let mut seen: Vec<String> = Vec::new();
        for index in 0..pool.groups_per_epoch(1000) {
            seen.extend(pool.group(0xDEAD, index, 1000, &open()));
        }
        assert_eq!(seen.len(), 2500);
        seen.sort();
        seen.dedup();
        assert_eq!(seen.len(), 2500);
    }

    #[test]
    fn the_last_group_of_an_epoch_is_the_short_one() {
        let pool = pool(2500);
        assert_eq!(pool.groups_per_epoch(1000), 3);
        assert_eq!(pool.group(1, 0, 1000, &open()).len(), 1000);
        assert_eq!(pool.group(1, 2, 1000, &open()).len(), 500);
        // Past the end is empty, not a panic - a resumed campaign can land there.
        assert!(pool.group(1, 3, 1000, &open()).is_empty());
    }

    #[test]
    fn a_group_is_reproducible_from_its_seed_and_index() {
        let pool = pool(500);
        assert_eq!(pool.group(42, 1, 100, &open()), pool.group(42, 1, 100, &open()));
        assert_ne!(pool.group(42, 1, 100, &open()), pool.group(43, 1, 100, &open()));
        assert_ne!(pool.group(42, 1, 100, &open()), pool.group(42, 2, 100, &open()));
    }

    /// Two epochs must put different cases next to each other, or a second sweep buys
    /// nothing over the first.
    #[test]
    fn a_new_epoch_is_a_new_set_of_neighbours() {
        let pool = pool(500);
        assert_ne!(pool.group(1, 0, 100, &open()), pool.group(2, 0, 100, &open()));
    }

    #[test]
    fn the_fingerprint_moves_when_the_pool_does() {
        let a = pool(100);
        let b = pool(100);
        assert_eq!(a.fingerprint, b.fingerprint);
        assert_ne!(a.fingerprint, pool(101).fingerprint);
    }

    #[test]
    fn a_group_size_of_zero_does_not_divide_by_zero() {
        let pool = pool(10);
        assert_eq!(pool.groups_per_epoch(0), 10);
        assert_eq!(pool.group(1, 0, 0, &open()).len(), 1);
    }

    /// The quarantine takes cases out of the group without renumbering the permutation,
    /// so the rest of the group is exactly what it would have been.
    #[test]
    fn a_quarantined_case_leaves_the_group_without_shifting_the_others() {
        let dir = std::env::temp_dir().join(format!("hodow-pool-quarantine-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let pool = pool(100);

        let before = pool.group(11, 0, 20, &open());
        let mut quarantine = Quarantine::load(&dir);
        quarantine.add(&before[5], "auto: a test").unwrap();

        let after = pool.group(11, 0, 20, &quarantine);
        assert_eq!(after.len(), before.len() - 1);
        let expected: Vec<&String> = before.iter().filter(|n| **n != before[5]).collect();
        assert_eq!(after.iter().collect::<Vec<&String>>(), expected);

        // And turning it off puts the case straight back.
        assert_eq!(pool.group(11, 0, 20, &Quarantine::load(&dir).disabled()), before);
        let _ = std::fs::remove_dir_all(&dir);
    }

    #[test]
    fn filters_select_and_exclude_within_one_root() {
        let all = [
            "dEQP-GLES2.a.one",
            "dEQP-GLES2.a.two",
            "dEQP-GLES2.b.one",
            "dEQP-GLES3.a.one",
        ];
        let selected = filtered(all.into_iter(), Api::Gles2, &["dEQP-GLES2.a.*".to_string()], &[]);
        assert_eq!(selected, vec!["dEQP-GLES2.a.one", "dEQP-GLES2.a.two"]);

        let excluded = filtered(all.into_iter(), Api::Gles2, &[], &["*.two".to_string()]);
        assert_eq!(excluded, vec!["dEQP-GLES2.a.one", "dEQP-GLES2.b.one"]);
    }
}
