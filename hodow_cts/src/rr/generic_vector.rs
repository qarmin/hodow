// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrGenericVector.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream stores the four 32-bit
// lanes in a C `union { uint32_t[4]; int32_t[4]; float[4]; }` and reads back through
// whichever member the caller names - a `get<float>()`/`get<int32_t>()`/
// `get<uint32_t>()` template pair. Rust has no safe union-of-arrays with that same
// shape, so the lanes are kept as raw bits (`u32`) and every accessor goes through
// `from_bits`/`to_bits`, which is the same "reinterpret these 32 bits" operation the
// C++ union performs, just spelled without `unsafe`.

use crate::tcu::vector::{IVec4, UVec4, Vec4};

/// `rr::GenericVecType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum GenericVecType {
    Float = 0,
    Uint32,
    Int32,
}

/// `rr::GenericVec4` - four 32-bit lanes that can be read back as `float`, `int32_t` or
/// `uint32_t`. Aliasing rules apply exactly as upstream documents: writing as one type
/// and reading as another is only meaningful if the caller knows which reinterpretation
/// it wants (e.g. a vertex shader output declared as `float` must be read back with
/// `get_float`, never `get_int`).
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct GenericVec4 {
    bits: [u32; 4],
}

impl GenericVec4 {
    /// `GenericVec4::GenericVec4(void)`
    pub const fn zero() -> Self {
        Self { bits: [0; 4] }
    }

    pub fn from_float(v: Vec4) -> Self {
        Self {
            bits: [v.x().to_bits(), v.y().to_bits(), v.z().to_bits(), v.w().to_bits()],
        }
    }

    pub fn from_int(v: IVec4) -> Self {
        Self {
            bits: [v.x() as u32, v.y() as u32, v.z() as u32, v.w() as u32],
        }
    }

    pub fn from_uint(v: UVec4) -> Self {
        Self {
            bits: [v.x(), v.y(), v.z(), v.w()],
        }
    }

    /// `GenericVec4::get<float>()`
    pub fn get_float(&self) -> Vec4 {
        Vec4::new(
            f32::from_bits(self.bits[0]),
            f32::from_bits(self.bits[1]),
            f32::from_bits(self.bits[2]),
            f32::from_bits(self.bits[3]),
        )
    }

    /// `GenericVec4::get<int32_t>()`
    pub fn get_int(&self) -> IVec4 {
        IVec4::new(
            self.bits[0] as i32,
            self.bits[1] as i32,
            self.bits[2] as i32,
            self.bits[3] as i32,
        )
    }

    /// `GenericVec4::get<uint32_t>()`
    pub fn get_uint(&self) -> UVec4 {
        UVec4::new(self.bits[0], self.bits[1], self.bits[2], self.bits[3])
    }

    /// Raw bit access, e.g. for a vertex shader output whose declared type is not
    /// known at the point outputs are copied around (`VertexPacket::outputs`).
    pub fn raw_bits(&self) -> [u32; 4] {
        self.bits
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn float_roundtrip() {
        let v = Vec4::new(1.0, -2.5, 0.0, 3.25);
        let g = GenericVec4::from_float(v);
        let back = g.get_float();
        assert_eq!(back.x(), 1.0);
        assert_eq!(back.y(), -2.5);
        assert_eq!(back.z(), 0.0);
        assert_eq!(back.w(), 3.25);
    }

    #[test]
    fn int_roundtrip() {
        let v = IVec4::new(-1, 2, -3, 4);
        let g = GenericVec4::from_int(v);
        let back = g.get_int();
        assert_eq!(back.x(), -1);
        assert_eq!(back.y(), 2);
        assert_eq!(back.z(), -3);
        assert_eq!(back.w(), 4);
    }

    #[test]
    fn uint_roundtrip() {
        let v = UVec4::new(1, 2, 3, 0xFFFF_FFFF);
        let g = GenericVec4::from_uint(v);
        let back = g.get_uint();
        assert_eq!(back.x(), 1);
        assert_eq!(back.y(), 2);
        assert_eq!(back.z(), 3);
        assert_eq!(back.w(), 0xFFFF_FFFF);
    }

    #[test]
    fn zero_is_all_bits_zero() {
        let g = GenericVec4::zero();
        assert_eq!(g.raw_bits(), [0, 0, 0, 0]);
    }
}
