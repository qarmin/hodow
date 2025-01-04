// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuRGBA.hpp / .cpp  (tcu::RGBA)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::tcu::Vec4;

pub const RED_SHIFT: u32 = 0;
pub const GREEN_SHIFT: u32 = 8;
pub const BLUE_SHIFT: u32 = 16;
pub const ALPHA_SHIFT: u32 = 24;

pub const RED_MASK: u32 = 1 << 0;
pub const GREEN_MASK: u32 = 1 << 1;
pub const BLUE_MASK: u32 = 1 << 2;
pub const ALPHA_MASK: u32 = 1 << 3;

/// `tcu::RGBA` - an RGBA8888 colour, packed exactly as upstream packs it.
///
/// The packing is load-bearing rather than an implementation detail: `tcu::Surface`
/// stores these words directly and the masked comparison functions below work on the
/// packed value.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct RGBA {
    value: u32,
}

impl RGBA {
    pub const fn new(r: i32, g: i32, b: i32, a: i32) -> Self {
        debug_assert!(r >= 0 && r <= 255 && g >= 0 && g <= 255 && b >= 0 && b <= 255 && a >= 0 && a <= 255);
        Self {
            value: ((a as u32) << ALPHA_SHIFT)
                | ((r as u32) << RED_SHIFT)
                | ((g as u32) << GREEN_SHIFT)
                | ((b as u32) << BLUE_SHIFT),
        }
    }

    /// `explicit RGBA(uint32_t val)`
    pub const fn from_packed(value: u32) -> Self {
        Self { value }
    }

    pub fn set_red(&mut self, v: i32) {
        self.value = (self.value & !(0xFFu32 << RED_SHIFT)) | ((v as u32) << RED_SHIFT);
    }

    pub fn set_green(&mut self, v: i32) {
        self.value = (self.value & !(0xFFu32 << GREEN_SHIFT)) | ((v as u32) << GREEN_SHIFT);
    }

    pub fn set_blue(&mut self, v: i32) {
        self.value = (self.value & !(0xFFu32 << BLUE_SHIFT)) | ((v as u32) << BLUE_SHIFT);
    }

    pub fn set_alpha(&mut self, v: i32) {
        self.value = (self.value & !(0xFFu32 << ALPHA_SHIFT)) | ((v as u32) << ALPHA_SHIFT);
    }

    pub fn get_red(self) -> i32 {
        ((self.value >> RED_SHIFT) & 0xFF) as i32
    }

    pub fn get_green(self) -> i32 {
        ((self.value >> GREEN_SHIFT) & 0xFF) as i32
    }

    pub fn get_blue(self) -> i32 {
        ((self.value >> BLUE_SHIFT) & 0xFF) as i32
    }

    pub fn get_alpha(self) -> i32 {
        ((self.value >> ALPHA_SHIFT) & 0xFF) as i32
    }

    pub fn get_packed(self) -> u32 {
        self.value
    }

    pub fn is_below_threshold(self, thr: RGBA) -> bool {
        self.get_red() <= thr.get_red()
            && self.get_green() <= thr.get_green()
            && self.get_blue() <= thr.get_blue()
            && self.get_alpha() <= thr.get_alpha()
    }

    /// `explicit RGBA(const Vec4&)`, which every reference colour computed as floats
    /// goes through before being compared against a read-back pixel.
    pub fn from_vec(v: Vec4) -> Self {
        Self::new(
            float_to_u8(v.x()) as i32,
            float_to_u8(v.y()) as i32,
            float_to_u8(v.z()) as i32,
            float_to_u8(v.w()) as i32,
        )
    }

    pub fn to_vec(self) -> Vec4 {
        Vec4::new(
            self.get_red() as f32 / 255.0,
            self.get_green() as f32 / 255.0,
            self.get_blue() as f32 / 255.0,
            self.get_alpha() as f32 / 255.0,
        )
    }

    pub const fn red() -> Self {
        Self::new(0xFF, 0x0, 0x0, 0xFF)
    }

    pub const fn green() -> Self {
        Self::new(0x0, 0xFF, 0x0, 0xFF)
    }

    pub const fn blue() -> Self {
        Self::new(0x0, 0x0, 0xFF, 0xFF)
    }

    pub const fn gray() -> Self {
        Self::new(0x80, 0x80, 0x80, 0xFF)
    }

    pub const fn white() -> Self {
        Self::new(0xFF, 0xFF, 0xFF, 0xFF)
    }

    pub const fn black() -> Self {
        Self::new(0x0, 0x0, 0x0, 0xFF)
    }
}

/// `operator+` - saturating, as upstream documents.
impl std::ops::Add for RGBA {
    type Output = RGBA;

    fn add(self, b: RGBA) -> RGBA {
        RGBA::new(
            (self.get_red() + b.get_red()).clamp(0, 255),
            (self.get_green() + b.get_green()).clamp(0, 255),
            (self.get_blue() + b.get_blue()).clamp(0, 255),
            (self.get_alpha() + b.get_alpha()).clamp(0, 255),
        )
    }
}

impl std::fmt::Display for RGBA {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "RGBA({}, {}, {}, {})",
            self.get_red(),
            self.get_green(),
            self.get_blue(),
            self.get_alpha()
        )
    }
}

/// `tcu::computeAbsDiff`
pub fn compute_abs_diff(a: RGBA, b: RGBA) -> RGBA {
    RGBA::new(
        (a.get_red() - b.get_red()).abs(),
        (a.get_green() - b.get_green()).abs(),
        (a.get_blue() - b.get_blue()).abs(),
        (a.get_alpha() - b.get_alpha()).abs(),
    )
}

/// `tcu::computeAbsDiffMasked` - the difference on the masked channels only, the rest
/// reported as zero so a comparison against any threshold accepts them.
pub fn compute_abs_diff_masked(a: RGBA, b: RGBA, cmp_mask: u32) -> RGBA {
    let channel = |mask: u32, shift: u32| {
        if cmp_mask & mask != 0 {
            let ca = ((a.get_packed() >> shift) & 0xFF) as i32;
            let cb = ((b.get_packed() >> shift) & 0xFF) as i32;
            (ca - cb).abs()
        } else {
            0
        }
    };
    RGBA::new(
        channel(RED_MASK, RED_SHIFT),
        channel(GREEN_MASK, GREEN_SHIFT),
        channel(BLUE_MASK, BLUE_SHIFT),
        channel(ALPHA_MASK, ALPHA_SHIFT),
    )
}

/// `tcu::compareThreshold`
pub fn compare_threshold(a: RGBA, b: RGBA, threshold: RGBA) -> bool {
    if a == b {
        return true; // Quick-accept
    }
    compute_abs_diff(a, b).is_below_threshold(threshold)
}

/// `tcu::max`
pub fn max(a: RGBA, b: RGBA) -> RGBA {
    RGBA::new(
        a.get_red().max(b.get_red()),
        a.get_green().max(b.get_green()),
        a.get_blue().max(b.get_blue()),
        a.get_alpha().max(b.get_alpha()),
    )
}

/// `tcu::floatToU8` (tcuTextureUtil.hpp) - the exponent-shift rounding upstream uses to
/// quantise a float to 8 bits. `RGBA::from_vec` is its only caller here, so it lives
/// next to it rather than in a texture-utility module of its own.
///
/// The bit math is upstream's verbatim: anything at or below 0 lands on 0 and anything
/// at or above 1 on 255, so no explicit clamp is needed.
fn float_to_u8(fv: f32) -> u8 {
    let uv = fv.to_bits();
    let iv = uv as i32;

    let e = (126 - (iv >> 23)) as u32;
    let mut m = uv;

    m &= 0x00ff_ffff;
    m |= 0x0080_0000;
    m = (m << 8).wrapping_sub(m);
    m = if e > 8 { e } else { 0x0080_0000 + (m >> e) };

    (m >> 24) as u8
}
