// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Determinism, written out by hand rather than taken from a crate.
//
// A campaign stores a seed and expects that seed to name the same permutation for as
// long as the findings are worth anything - after a re-sync, after a toolchain bump,
// after `cargo update`. A generator from a dependency is free to change its stream
// between versions (`rand` has done exactly that), and the failure mode is silent: the
// replay runs a *different* group and reports that the crash did not reproduce. Ten
// lines of SplitMix64 cost nothing and cannot drift.

/// SplitMix64 - the generator `rand` itself uses to seed its own.
///
/// Chosen for being short enough to audit at a glance and having no state beyond one
/// `u64`, which is what makes an epoch's stream reconstructible from what `state.json`
/// holds.
pub struct SplitMix64(u64);

impl SplitMix64 {
    pub fn new(seed: u64) -> Self {
        Self(seed)
    }

    pub fn next_u64(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
        z ^ (z >> 31)
    }

    /// Uniform over `0..n`, rejecting the values that would bias the low end.
    ///
    /// The modulo alone is off by at most one part in 2^64/n, which for a corpus of
    /// 675k is unmeasurable - but a shuffle is the one place where "unmeasurable bias,
    /// applied 675k times" is a claim nobody should have to check.
    pub fn below(&mut self, n: u64) -> u64 {
        assert!(n > 0, "below(0) has no answer");
        let limit = u64::MAX - (u64::MAX % n) - (n - 1);
        loop {
            let v = self.next_u64();
            if v <= limit {
                return v % n;
            }
        }
    }
}

/// Fisher-Yates, in place, so an epoch is one permutation of the whole pool rather
/// than a sample drawn with replacement.
pub fn shuffle<T>(items: &mut [T], rng: &mut SplitMix64) {
    for i in (1..items.len()).rev() {
        let j = rng.below(i as u64 + 1) as usize;
        items.swap(i, j);
    }
}

/// Derives one stream from another so that a campaign seed, an API and an epoch number
/// name a stream without any of them needing to be stored separately.
///
/// The epoch seed is written into `state.json` anyway - this only has to be stable
/// within a run, and being reproducible from the campaign seed is what lets a whole
/// campaign be described by one number in a bug report.
pub fn derive(seed: u64, salt: &str, counter: u64) -> u64 {
    let mut rng = SplitMix64::new(seed ^ fnv1a(salt.as_bytes()) ^ counter.wrapping_mul(0x517C_C1B7_2722_0A95));
    rng.next_u64()
}

/// FNV-1a, for the corpus fingerprint.
///
/// Not a security property: the question it answers is "is this the same list of case
/// names the campaign started against", where the realistic change is a port landing or
/// being removed, not an adversary.
pub fn fnv1a(bytes: &[u8]) -> u64 {
    let mut hash: u64 = 0xCBF2_9CE4_8422_2325;
    for b in bytes {
        hash ^= u64::from(*b);
        hash = hash.wrapping_mul(0x0000_0100_0000_01B3);
    }
    hash
}

/// The fingerprint of a pool: how many names, and which.
///
/// Order is part of it. A permutation is built by index, so two pools holding the same
/// names in a different order turn the same epoch seed into two different groups.
pub fn fingerprint<'a>(names: impl Iterator<Item = &'a str>) -> u64 {
    let mut hash: u64 = 0xCBF2_9CE4_8422_2325;
    for name in names {
        hash ^= fnv1a(name.as_bytes());
        hash = hash.wrapping_mul(0x0000_0100_0000_01B3);
    }
    hash
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Pinned literals, not a round trip: the point of this module is that the stream
    /// never changes, and a test that recomputes the implementation cannot notice it
    /// changing. If these ever need updating, every stored campaign seed has just
    /// silently come to mean a different permutation.
    #[test]
    fn the_stream_is_pinned() {
        let mut rng = SplitMix64::new(0);
        assert_eq!(rng.next_u64(), 0xE220_A839_7B1D_CDAF);
        assert_eq!(rng.next_u64(), 0x6E78_9E6A_A1B9_65F4);
        assert_eq!(rng.next_u64(), 0x06C4_5D18_8009_454F);

        let mut rng = SplitMix64::new(0x1234_5678_9ABC_DEF0);
        assert_eq!(rng.next_u64(), 0x1619_22C6_45CE_50E8);
    }

    #[test]
    fn the_same_seed_gives_the_same_permutation() {
        let mut a: Vec<u32> = (0..1000).collect();
        let mut b = a.clone();
        shuffle(&mut a, &mut SplitMix64::new(42));
        shuffle(&mut b, &mut SplitMix64::new(42));
        assert_eq!(a, b);
        assert_ne!(a, (0..1000).collect::<Vec<u32>>());
    }

    /// An epoch has to cover every case exactly once - that is the whole reason the
    /// pool is permuted rather than sampled.
    #[test]
    fn a_permutation_keeps_every_element_exactly_once() {
        let mut items: Vec<u32> = (0..1000).collect();
        shuffle(&mut items, &mut SplitMix64::new(7));
        items.sort_unstable();
        assert_eq!(items, (0..1000).collect::<Vec<u32>>());
    }

    #[test]
    fn different_seeds_give_different_permutations() {
        let mut a: Vec<u32> = (0..1000).collect();
        let mut b = a.clone();
        shuffle(&mut a, &mut SplitMix64::new(1));
        shuffle(&mut b, &mut SplitMix64::new(2));
        assert_ne!(a, b);
    }

    #[test]
    fn shuffling_nothing_or_one_thing_is_not_a_panic() {
        shuffle::<u32>(&mut [], &mut SplitMix64::new(1));
        let mut one = [9u32];
        shuffle(&mut one, &mut SplitMix64::new(1));
        assert_eq!(one, [9]);
    }

    #[test]
    fn below_stays_in_range_and_reaches_both_ends() {
        let mut rng = SplitMix64::new(3);
        let mut seen_low = false;
        let mut seen_high = false;
        for _ in 0..10_000 {
            let v = rng.below(5);
            assert!(v < 5);
            seen_low |= v == 0;
            seen_high |= v == 4;
        }
        assert!(seen_low && seen_high);
    }

    #[test]
    fn a_fingerprint_notices_a_name_added_removed_or_reordered() {
        let base = fingerprint(["a", "b", "c"].into_iter());
        assert_eq!(base, fingerprint(["a", "b", "c"].into_iter()));
        assert_ne!(base, fingerprint(["a", "b"].into_iter()));
        assert_ne!(base, fingerprint(["a", "b", "c", "d"].into_iter()));
        assert_ne!(base, fingerprint(["c", "b", "a"].into_iter()));
    }

    #[test]
    fn derive_separates_streams_by_salt_and_counter() {
        assert_ne!(derive(1, "dEQP-GLES2", 0), derive(1, "dEQP-GLES3", 0));
        assert_ne!(derive(1, "dEQP-GLES2", 0), derive(1, "dEQP-GLES2", 1));
        assert_eq!(derive(1, "dEQP-GLES2", 0), derive(1, "dEQP-GLES2", 0));
    }
}
