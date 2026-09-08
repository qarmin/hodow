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

    pub fn get_int(&mut self, min: i32, max: i32) -> i32 {
        if min == i32::MIN && max == i32::MAX {
            self.get_uint32() as i32
        } else {
            debug_assert!(min <= max);
            let range = (max - min) as u32 + 1;
            min + (self.get_uint32() % range) as i32
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
        (0x124fef, [0x4ece6fa9, 0x15fa8a38, 0x9a9e2ce2, 0x44f9b2ce, 0x79772edf, 0xb81dc083, 0xd38f125e, 0x5a69a523]),
        (0x111223f, [0x5ca28017, 0xf1fd2c8d, 0x6ebd7cd2, 0x6366fd94, 0x2b8c6bd7, 0x330db36f, 0xb6d30230, 0xe20dc323]),
        (0, [0xdca345ea, 0xdca35e7e, 0x52e219cc, 0x1f7f4828, 0xd935d238, 0x1fa337ce, 0x5dcd618f, 0xb8165c16]),
        (1, [0xdca3421a, 0x1b511116, 0x95104e5a, 0xd88d4708, 0x1ef87d91, 0x8db206f9, 0x9ac7eb8b, 0x28c04adc]),
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

    #[test]
    fn get_float_matches_upstream() {
        for &(seed, ref expected) in UPSTREAM_F32 {
            let mut rnd = Random::new(seed);
            for (i, &want) in expected.iter().enumerate() {
                let got = rnd.get_float();
                assert!((got - want).abs() < 1e-9, "seed {seed:#x} value {i}: got {got}, want {want}");
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

    /// `de::Random::shuffle` - Fisher-Yates, walking down so the rng is consumed in
    /// the same order as upstream.
    pub fn shuffle<T>(&mut self, items: &mut [T]) {
        for i in (1..items.len()).rev() {
            let j = self.get_int(0, i as i32) as usize;
            items.swap(i, j);
        }
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
