// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/delibs/debase/deRandom.c / .h
//   framework/delibs/decpp/deRandom.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

/// `de::Random` - the xorshift128 generator deqp seeds every randomised test with.
///
/// This has to reproduce upstream bit for bit: CTS tests fill their input buffers
/// from it, so a different stream means different inputs and results that cannot be
/// compared against `deqp-vk`. Do not "improve" the algorithm.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Random {
    x: u32,
    y: u32,
    z: u32,
    w: u32,
}

impl Random {
    /// `deRandom_init`
    pub fn new(seed: u32) -> Self {
        Self {
            x: (seed as i32).wrapping_neg() as u32 ^ 123456789,
            y: 362436069u32.wrapping_mul(seed),
            z: 521288629 ^ (seed >> 7),
            w: 88675123 ^ (seed << 3),
        }
    }

    /// `deRandom_getUint32`
    pub fn get_uint32(&mut self) -> u32 {
        let mut w = self.w;
        let t = self.x ^ (self.x << 11);

        self.x = self.y;
        self.y = self.z;
        self.z = w;
        w = (w ^ (w >> 19)) ^ (t ^ (t >> 8));
        self.w = w;
        w
    }

    /// `deRandom_getUint64`
    pub fn get_uint64(&mut self) -> u64 {
        let x = self.get_uint32() as u64;
        (x << 32) | self.get_uint32() as u64
    }

    /// `deRandom_getFloat`
    pub fn get_float(&mut self) -> f32 {
        (self.get_uint32() & 0xFFFFFFF) as f32 / (0xFFFFFFFu32 as f32 + 1.0)
    }

    /// `deRandom_getBool`
    pub fn get_bool(&mut self) -> bool {
        let val = self.get_uint32();
        (val & 0xFFFFFF) < 0x800000
    }

    /// `de::Random::getInt(min, max)` - inclusive on both ends.
    /// `de::Random::getUint16`
    pub fn get_uint16(&mut self) -> u16 {
        self.get_uint32() as u16
    }

    /// `de::Random::getUint8`
    pub fn get_uint8(&mut self) -> u8 {
        self.get_uint32() as u8
    }

    /// `de::Random::getFloat(min, max)`
    pub fn get_float_range(&mut self, min: f32, max: f32) -> f32 {
        debug_assert!(min <= max);
        min + (max - min) * self.get_float()
    }

    /// `deRandom_getDouble` - uniform in `[0, 1)`, built from the top 53 bits (the
    /// full `f64` mantissa) of a 64-bit draw, exactly like `get_float` does for `f32`
    /// with its own 28-bit slice.
    pub fn get_double(&mut self) -> f64 {
        let bits = self.get_uint64() & ((1u64 << 53) - 1);
        (bits as f64) * 2f64.powi(-53)
    }

    /// `de::Random::getDouble(min, max)`
    pub fn get_double_range(&mut self, min: f64, max: f64) -> f64 {
        debug_assert!(min <= max);
        min + (max - min) * self.get_double()
    }

    /// `Random::getInt` - `min + (int)(getUint32() % ((uint32_t)max - (uint32_t)min +
    /// 1u))`. The addition and the subtraction both happen in `uint32_t` and are
    /// allowed to wrap in C++ (two's-complement `int` addition overflow is
    /// undefined-but-silent there, and always lands back in `[min, max]`, which fits
    /// `i32` by construction) - `wrapping_sub`/`wrapping_add` here for the same reason,
    /// found by a real panic: a plain `i32` `min + ...` overflows-checks in a debug
    /// build for a range spanning most of `i32` (`(-2147483647, 2147483647)`, `common.
    /// abs.int_highp_*`'s own range), which upstream's wrap-around C++ arithmetic never
    /// raises.
    pub fn get_int(&mut self, min: i32, max: i32) -> i32 {
        if min == i32::MIN && max == i32::MAX {
            self.get_uint32() as i32
        } else {
            debug_assert!(min <= max);
            let range = (max as u32).wrapping_sub(min as u32).wrapping_add(1);
            (min as u32).wrapping_add(self.get_uint32() % range) as i32
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    // Reference streams captured by compiling the vendored upstream
    // `framework/delibs/debase/deRandom.c` and dumping its output.
    // Regenerate with `hodow_cts/scripts/capture_de_random.sh`.
    //
    // 0x124fef and 0x111223f are the seeds BufferToBufferInvertTest uses for its
    // SSBO and UBO variants respectively, so these are the streams that actually
    // decide whether that test's input data matches upstream.
    const UPSTREAM_U32: &[(u32, [u32; 8])] = &[
        (
            0x124fef,
            [
                0x4ece6fa9, 0x15fa8a38, 0x9a9e2ce2, 0x44f9b2ce, 0x79772edf, 0xb81dc083, 0xd38f125e, 0x5a69a523,
            ],
        ),
        (
            0x111223f,
            [
                0x5ca28017, 0xf1fd2c8d, 0x6ebd7cd2, 0x6366fd94, 0x2b8c6bd7, 0x330db36f, 0xb6d30230, 0xe20dc323,
            ],
        ),
        (
            0,
            [
                0xdca345ea, 0xdca35e7e, 0x52e219cc, 0x1f7f4828, 0xd935d238, 0x1fa337ce, 0x5dcd618f, 0xb8165c16,
            ],
        ),
        (
            1,
            [
                0xdca3421a, 0x1b511116, 0x95104e5a, 0xd88d4708, 0x1ef87d91, 0x8db206f9, 0x9ac7eb8b, 0x28c04adc,
            ],
        ),
    ];

    // The digits are exactly what upstream's `%.9g` printed; trimming them to what an
    // f32 can hold would lose the provenance of the captured values.
    #[allow(clippy::excessive_precision)]
    const UPSTREAM_F32: &[(u32, [f32; 4])] = &[
        (0x124fef, [0.925399482, 0.373666972, 0.663617015, 0.310961545]),
        (0x111223f, [0.789672911, 0.124310061, 0.921261609, 0.212644175]),
        (0, [0.789861619, 0.789885044, 0.180200383, 0.968574643]),
        (1, [0.789857984, 0.707291663, 0.316480964, 0.534491539]),
    ];

    #[test]
    fn get_uint32_matches_upstream() {
        for &(seed, ref expected) in UPSTREAM_U32 {
            let mut rnd = Random::new(seed);
            let got: Vec<u32> = (0..8).map(|_| rnd.get_uint32()).collect();
            assert_eq!(&got[..], &expected[..], "stream diverged for seed {seed:#x}");
        }
    }

    /// `deRandom_getDouble` is `ldexp((getUint64() & ((1<<53)-1)) as f64, -53)` -
    /// verified without a second capture run by applying that exact formula to seed
    /// `0`'s *already-captured* `get_uint32` stream above (`0xdca345ea, 0xdca35e7e` ->
    /// `get_uint64() == 0xdca345eadca35e7e`), rather than trusting `get_double`'s own
    /// implementation to agree with itself.
    #[test]
    fn get_double_matches_the_formula_applied_to_the_captured_uint64_stream() {
        let mut rnd = Random::new(0);
        let got = rnd.get_double();
        assert!((got - 0.102_284_842_428_119_08).abs() < 1e-12, "got {got}");
    }

    #[test]
    fn get_double_range_stays_within_bounds() {
        let mut rnd = Random::new(0xabcdef);
        for _ in 0..1000 {
            let v = rnd.get_double_range(-2.5, 3.5);
            assert!((-2.5..3.5).contains(&v), "{v} out of range");
        }
    }

    #[test]
    fn get_float_matches_upstream() {
        for &(seed, ref expected) in UPSTREAM_F32 {
            let mut rnd = Random::new(seed);
            for (i, &want) in expected.iter().enumerate() {
                let got = rnd.get_float();
                assert!(
                    (got - want).abs() < 1e-9,
                    "seed {seed:#x} value {i}: got {got}, want {want}"
                );
            }
        }
    }

    /// A range spanning nearly all of `i32` (`gles3::functional::
    /// shader_common_function_tests`'s own `common.abs.int_highp_*`, `(-2147483647,
    /// 2147483647)`) used to panic on overflow in a debug build - the naive `min +
    /// (u32 remainder) as i32` computed a genuinely out-of-`i32`-range intermediate
    /// even though the final result always lands back in `[min, max]`.
    #[test]
    fn get_int_never_panics_on_a_near_full_range() {
        let mut rnd = Random::new(0x1234);
        for _ in 0..10_000 {
            let v = rnd.get_int(-2_147_483_647, 2_147_483_647);
            assert!((-2_147_483_647..=2_147_483_647).contains(&v), "{v} out of range");
        }
    }

    /// Bit-for-bit against upstream's own `min + (int)(getUint32() % ((uint32_t)max -
    /// (uint32_t)min + 1u))`, computed directly from the already-captured `get_uint32`
    /// stream above rather than a second capture run.
    #[test]
    fn get_int_matches_the_formula_applied_to_the_captured_uint32_stream() {
        let (min, max) = (-10i32, 20i32);
        let range = (max as u32).wrapping_sub(min as u32).wrapping_add(1);
        for &(seed, ref stream) in UPSTREAM_U32 {
            let mut rnd = Random::new(seed);
            for &word in stream {
                let want = (min as u32).wrapping_add(word % range) as i32;
                let got = rnd.get_int(min, max);
                assert_eq!(got, want, "seed {seed:#x}");
            }
        }
    }
}

/// `deInt32Hash` - Thomas Wang's 32-bit integer hash, which upstream uses to turn a
/// small enum value into a usable seed.
impl Random {
    /// `de::Random::choose<T>(first, last)` - one item, by reservoir sampling.
    ///
    /// Not `get_int(0, n - 1)`: the reservoir draws once per element past the first,
    /// so choosing from an n-element list consumes n-1 numbers. Everything drawn after
    /// it depends on that.
    pub fn choose<'a, T>(&mut self, items: &'a [T]) -> &'a T {
        let mut chosen = &items[0];
        for (ndx, item) in items.iter().enumerate().skip(1) {
            if self.get_int(0, ndx as i32) < 1 {
                chosen = item;
            }
        }
        chosen
    }

    /// `de::Random::choose<T>(first, last, resultOut, numItems)` - the same reservoir,
    /// keeping `num_items` of them. The draw order is what decides which, so this
    /// cannot be shortened to `num_items` independent picks.
    pub fn choose_n<T: Clone>(&mut self, items: &[T], num_items: usize) -> Vec<T> {
        let mut result: Vec<T> = Vec::with_capacity(num_items);
        for (ndx, item) in items.iter().enumerate() {
            if ndx < num_items {
                result.push(item.clone());
            } else {
                let r = self.get_int(0, ndx as i32) as usize;
                if r < num_items {
                    result[r] = item.clone();
                }
            }
        }
        result
    }

    /// `de::Random::shuffle` - Fisher-Yates, walking down so the rng is consumed in
    /// the same order as upstream.
    pub fn shuffle<T>(&mut self, items: &mut [T]) {
        for i in (1..items.len()).rev() {
            let j = self.get_int(0, i as i32) as usize;
            items.swap(i, j);
        }
    }

    /// `de::Random::chooseWeighted<T>(first, last, weight)` - a single draw
    /// (`get_float_range(0, weightSum)`) placed on the cumulative-weight number line,
    /// returning whichever item's slice it lands in. Ported for `rsg::expression`'s
    /// `VariableRead`/`VariableWrite`/`AssignOp` (not yet all ported), which use it to
    /// pick among variables/storage classes by a dynamically-computed weight rather
    /// than uniformly.
    ///
    /// Falls back to the last item with a strictly positive weight if floating-point
    /// rounding ever leaves `p` at or past the running sum on every iteration (matches
    /// upstream's own `lastNonZero` fallback, which exists for exactly that reason -
    /// not an error case, a real possible outcome of summing floats).
    pub fn choose_weighted<'a, T>(&mut self, items: &'a [T], weights: &[f32]) -> &'a T {
        debug_assert_eq!(items.len(), weights.len());
        debug_assert!(!items.is_empty());

        let weight_sum: f32 = weights.iter().sum();
        let p = self.get_float_range(0.0, weight_sum);

        let mut last_non_zero: Option<&'a T> = None;
        let mut cur_weight = 0.0f32;
        for (item, &w) in items.iter().zip(weights.iter()) {
            cur_weight += w;
            if p < cur_weight {
                return item;
            } else if w > 0.0 {
                last_non_zero = Some(item);
            }
        }

        last_non_zero.expect("Random::choose_weighted: no item had a strictly positive weight")
    }
}

#[cfg(test)]
mod choose_weighted_tests {
    use super::Random;

    #[test]
    fn a_zero_weighted_item_is_never_chosen() {
        let items = ["zero", "all"];
        let weights = [0.0, 1.0];
        let mut rnd = Random::new(0xf00d);
        for _ in 0..200 {
            assert_eq!(*rnd.choose_weighted(&items, &weights), "all");
        }
    }

    #[test]
    fn a_single_item_is_always_chosen_regardless_of_its_own_weight() {
        let items = [42];
        let weights = [3.5];
        let mut rnd = Random::new(1);
        for _ in 0..20 {
            assert_eq!(*rnd.choose_weighted(&items, &weights), 42);
        }
    }

    /// Hand-computed against the exact formula (`p = get_float_range(0, weightSum)`,
    /// first cumulative bucket with `p < curWeight` wins): weights `[1.0, 3.0]` sum to
    /// 4.0, so item 0 wins for `p < 1.0` and item 1 for `p >= 1.0` - over many draws
    /// item 1 should be picked roughly 3x as often as item 0, not merely "sometimes".
    #[test]
    fn distribution_is_proportional_to_weight_not_uniform() {
        let items = [0, 1];
        let weights = [1.0, 3.0];
        let mut rnd = Random::new(0xabc);
        let mut counts = [0u32; 2];
        const DRAWS: u32 = 20_000;
        for _ in 0..DRAWS {
            counts[*rnd.choose_weighted(&items, &weights) as usize] += 1;
        }
        let ratio = counts[1] as f64 / counts[0] as f64;
        assert!((ratio - 3.0).abs() < 0.2, "expected ~3.0, got {ratio} ({counts:?})");
    }

    /// Bit-exact against the formula for the first draw of a fixed seed: `p =
    /// get_float_range(0, 10.0)`, weights `[2.0, 3.0, 5.0]` have cumulative sums
    /// `[2.0, 5.0, 10.0]`, so the item index is whichever bucket `p` falls into.
    #[test]
    fn first_draw_matches_the_formula_applied_by_hand() {
        let items = ["a", "b", "c"];
        let weights = [2.0, 3.0, 5.0];
        let mut rnd_for_formula = Random::new(777);
        let p = rnd_for_formula.get_float_range(0.0, 10.0);
        let expected = if p < 2.0 {
            "a"
        } else if p < 5.0 {
            "b"
        } else {
            "c"
        };

        let mut rnd = Random::new(777);
        assert_eq!(*rnd.choose_weighted(&items, &weights), expected);
    }
}

/// `deStringHash` (`framework/delibs/debase/deString.c`) - djb2, which several GL
/// cases mix with the iteration index to seed themselves, so the exact arithmetic
/// decides what data the test generates.
pub fn de_string_hash(s: &str) -> u32 {
    let mut hash = 5381u32;
    for c in s.bytes() {
        hash = (hash << 5).wrapping_add(hash).wrapping_add(u32::from(c));
    }
    hash
}

pub fn de_int32_hash(a: i32) -> u32 {
    let mut key = a as u32;
    key = (key ^ 61) ^ (key >> 16);
    key = key.wrapping_add(key << 3);
    key ^= key >> 4;
    key = key.wrapping_mul(0x27d4_eb2d);
    key ^= key >> 15;
    key
}

#[cfg(test)]
mod hash_tests {
    use super::de_int32_hash;

    /// Captured by compiling upstream's deInt32.h and running it, not derived by hand.
    #[test]
    fn matches_upstream() {
        assert_eq!(de_int32_hash(0), 0xC0A9_496A);
        assert_eq!(de_int32_hash(1), 0x2792_2C9D);
        assert_eq!(de_int32_hash(2), 0xC679_3575);
        assert_eq!(de_int32_hash(3), 0x87D0_6FBE);
    }
}
