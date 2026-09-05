// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexVerifierUtil.cpp
//   framework/common/tcuTexLookupVerifier.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A blit is not a copy: the driver picks a source texel from a coordinate it computed
// itself, at a precision the spec does not pin down. So the check is not "does the
// result equal the reference" but "could some texel the coordinate might legally have
// landed on produce this result". That is what this layer answers.
//
// Only the NEAREST filter is ported. The linear path needs the bilinear search from
// tcuTexLookupVerifier, which no ported test reaches yet.

use super::pixel::ConstPixelBufferAccess;
use super::texture::ChannelOrder;

/// `tcu::Sampler::WrapMode`, narrowed to the one mode the blit tests sample with.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum WrapMode {
    ClampToEdge,
}

/// `tcu::LookupPrecision` and `tcu::IntLookupPrecision` merged - they differ only in the
/// type of the colour threshold, and carrying both avoids duplicating the walk.
pub struct LookupPrecision {
    /// Bits per coordinate component before any transformation, treated as floating point.
    pub coord_bits: [i32; 3],
    /// Bits per component in the final per-level UVW coordinates, treated as fixed point.
    pub uvw_bits: [i32; 3],
    pub color_mask: [bool; 4],
}

impl Default for LookupPrecision {
    fn default() -> Self {
        Self {
            coord_bits: [22; 3],
            uvw_bits: [16; 3],
            color_mask: [true; 4],
        }
    }
}

/// `tcu::computeFloatingPointError`
///
/// The error of a value held to `num_accurate_bits`: the gap between the mantissa with
/// every garbage bit set and the mantissa with none, at the value's own exponent.
pub fn compute_floating_point_error(value: f32, num_accurate_bits: i32) -> f32 {
    debug_assert!((0..=23).contains(&num_accurate_bits));
    let num_garbage_bits = 23 - num_accurate_bits;
    let mask = (1u32 << num_garbage_bits) - 1;

    // `tcu::Float32(value).exponent()` - the unbiased exponent, and 1 - bias for a zero
    // or denormal, which is what `construct` below expects.
    let bits = value.to_bits();
    let raw_exp = ((bits >> 23) & 0xFF) as i32;
    let exp = if raw_exp == 0 { 1 - 127 } else { raw_exp - 127 };

    // `Float32::construct(+1, exp, mantissa)` with the implicit bit given explicitly.
    let construct = |mantissa: u32| -> f32 {
        let biased = (exp + 127) as u32;
        f32::from_bits((biased << 23) | (mantissa & 0x007F_FFFF))
    };

    construct((1 << 23) | mask) - construct(1 << 23)
}

/// `tcu::computeFixedPointError`
pub fn compute_fixed_point_error(num_accurate_bits: i32) -> f32 {
    compute_floating_point_error(1.0, num_accurate_bits)
}

/// `tcu::computeNonNormalizedCoordBounds` - the range of texel-space coordinates the
/// driver might have computed for this normalised one.
pub fn compute_non_normalized_coord_bounds(normalized: bool, dim: i32, coord: f32, coord_bits: i32, uv_bits: i32) -> (f32, f32) {
    let coord_err = compute_floating_point_error(coord, coord_bits);
    let min_n = coord - coord_err;
    let max_n = coord + coord_err;
    let (min_a, max_a) = if normalized { (min_n * dim as f32, max_n * dim as f32) } else { (min_n, max_n) };
    let fixed = compute_fixed_point_error(uv_bits);
    (min_a - fixed, max_a + fixed)
}

/// `tcu::wrap`
pub fn wrap(mode: WrapMode, c: i32, size: i32) -> i32 {
    match mode {
        WrapMode::ClampToEdge => c.clamp(0, size - 1),
    }
}

/// The colour a texel fetch yields, in the space the comparison happens in. An sRGB
/// source is converted to linear, because the verifier compares linear values.
fn lookup_float(level: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32) -> [f32; 4] {
    let c = level.get_pixel(x as u32, y as u32, z as u32);
    if level.format().order.is_srgb() { srgb_to_linear(c) } else { c }
}

/// `tcu::sRGBToLinear`
pub fn srgb_to_linear(c: [f32; 4]) -> [f32; 4] {
    let f = |v: f32| if v <= 0.04045 { v / 12.92 } else { ((v + 0.055) / 1.055).powf(2.4) };
    [f(c[0]), f(c[1]), f(c[2]), c[3]]
}

/// `tcu::isSRGB`
pub fn is_srgb(order: ChannelOrder) -> bool {
    order.is_srgb()
}

/// The candidate texel range a coordinate could have landed on, per axis.
fn candidate_range(normalized: bool, dim: i32, coord: f32, coord_bits: i32, uv_bits: i32) -> (i32, i32) {
    let (lo, hi) = compute_non_normalized_coord_bounds(normalized, dim, coord, coord_bits, uv_bits);
    (lo.floor() as i32, hi.floor() as i32)
}

/// `tcu::isNearestSampleResultValid` for a 3D level, float colours.
///
/// True when *some* texel in the coordinate's uncertainty window matches the result.
/// That is deliberately permissive: the driver is allowed to have computed the
/// coordinate slightly differently, and the test is not about which texel it picked.
pub fn is_nearest_sample_result_valid_float(level: &ConstPixelBufferAccess<'_>, prec: &LookupPrecision, threshold: [f32; 4], coord: [f32; 3], result: [f32; 4]) -> bool {
    let [w, h, d] = level.size();
    let (min_i, max_i) = candidate_range(true, w as i32, coord[0], prec.coord_bits[0], prec.uvw_bits[0]);
    let (min_j, max_j) = candidate_range(true, h as i32, coord[1], prec.coord_bits[1], prec.uvw_bits[1]);
    let (min_k, max_k) = candidate_range(true, d as i32, coord[2], prec.coord_bits[2], prec.uvw_bits[2]);

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(WrapMode::ClampToEdge, i, w as i32);
                let y = wrap(WrapMode::ClampToEdge, j, h as i32);
                let z = wrap(WrapMode::ClampToEdge, k, d as i32);
                let color = lookup_float(level, x, y, z);
                if (0..4).all(|c| !prec.color_mask[c] || (color[c] - result[c]).abs() <= threshold[c]) {
                    return true;
                }
            }
        }
    }
    false
}

/// `tcu::isNearestSampleResultValid` for a 3D level, integer colours.
pub fn is_nearest_sample_result_valid_int(level: &ConstPixelBufferAccess<'_>, prec: &LookupPrecision, threshold: [u32; 4], coord: [f32; 3], result: [i64; 4]) -> bool {
    let [w, h, d] = level.size();
    let (min_i, max_i) = candidate_range(true, w as i32, coord[0], prec.coord_bits[0], prec.uvw_bits[0]);
    let (min_j, max_j) = candidate_range(true, h as i32, coord[1], prec.coord_bits[1], prec.uvw_bits[1]);
    let (min_k, max_k) = candidate_range(true, d as i32, coord[2], prec.coord_bits[2], prec.uvw_bits[2]);

    for k in min_k..=max_k {
        for j in min_j..=max_j {
            for i in min_i..=max_i {
                let x = wrap(WrapMode::ClampToEdge, i, w as i32);
                let y = wrap(WrapMode::ClampToEdge, j, h as i32);
                let z = wrap(WrapMode::ClampToEdge, k, d as i32);
                let color = level.get_pixel_int64(x as u32, y as u32, z as u32);
                if (0..4).all(|c| !prec.color_mask[c] || color[c].abs_diff(result[c]) <= u64::from(threshold[c])) {
                    return true;
                }
            }
        }
    }
    false
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The error at 22 accurate bits is one part in two million or so, and it grows with
    /// the value's exponent - both of which the bounds computation depends on.
    #[test]
    fn floating_point_error_scales_with_exponent() {
        let at_one = compute_floating_point_error(1.0, 22);
        let at_two = compute_floating_point_error(2.0, 22);
        assert!(at_one > 0.0, "{at_one}");
        assert!((at_two / at_one - 2.0).abs() < 1e-3, "{at_one} vs {at_two}");

        // Full precision leaves no garbage bits, so no error at all.
        assert_eq!(compute_floating_point_error(1.0, 23), 0.0);
    }

    /// A coordinate in the middle of a texel must not reach its neighbours, while the
    /// window around a texel boundary must include both sides.
    #[test]
    fn coord_bounds_bracket_the_texel() {
        // Texel 4 of 8: normalised centre is 4.5/8.
        let (lo, hi) = compute_non_normalized_coord_bounds(true, 8, 4.5 / 8.0, 22, 16);
        assert_eq!((lo.floor() as i32, hi.floor() as i32), (4, 4));

        // Exactly on the boundary between texel 3 and 4.
        let (lo, hi) = compute_non_normalized_coord_bounds(true, 8, 4.0 / 8.0, 22, 16);
        assert!(lo.floor() as i32 <= 3 && hi.floor() as i32 >= 4, "{lo}..{hi}");
    }

    #[test]
    fn clamp_to_edge_wraps() {
        assert_eq!(wrap(WrapMode::ClampToEdge, -1, 8), 0);
        assert_eq!(wrap(WrapMode::ClampToEdge, 8, 8), 7);
        assert_eq!(wrap(WrapMode::ClampToEdge, 3, 8), 3);
    }
}
