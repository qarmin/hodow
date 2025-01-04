// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuImageCompare.hpp / .cpp  (intThresholdCompare, pixelThresholdCompare,
//                                                floatThresholdCompare, floatUlpThresholdCompare)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream builds an error mask image
// and writes result/reference/mask into the test log; there is no image log here, so
// the comparison returns the maximum difference instead and the caller puts it in the
// verdict description - which is the part of upstream's log a person reads first.

use crate::tcu::UVec4;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;

/// The outcome of a threshold comparison: whether it passed, and the largest
/// per-channel difference seen.
pub struct ThresholdCompareResult {
    pub ok: bool,
    pub max_diff: UVec4,
}

/// `tcu::intThresholdCompare` - every channel of every pixel within `threshold`.
pub fn int_threshold_compare(
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    threshold: UVec4,
) -> ThresholdCompareResult {
    let [width, height, depth] = reference.size();
    let mut max_diff = [0u32; 4];

    assert!(
        result.size() == reference.size(),
        "image comparison against a differently sized image"
    );

    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let ref_pix = reference.get_pixel_int(x, y, z);
                let cmp_pix = result.get_pixel_int(x, y, z);
                for c in 0..4 {
                    let diff = ref_pix[c].abs_diff(cmp_pix[c]);
                    max_diff[c] = max_diff[c].max(diff);
                }
            }
        }
    }

    let ok = (0..4).all(|c| max_diff[c] <= threshold.m_data[c]);
    ThresholdCompareResult {
        ok,
        max_diff: UVec4::from_array(max_diff),
    }
}

/// `tcu::intThresholdPositionDeviationCompare` - a pixel fails if no pixel of the other image within
/// `max_position_deviation` matches it within `threshold`, in either direction; the comparison passes if none fail.
/// With `accept_out_of_bounds_as_any_value` the pixels whose search volume would leave the image are not checked.
pub fn int_threshold_position_deviation_compare(
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    threshold: UVec4,
    max_position_deviation: [i32; 3],
    accept_out_of_bounds_as_any_value: bool,
) -> bool {
    let [width, height, depth] = reference.size().map(|v| v as i32);
    assert!(
        result.size() == reference.size(),
        "image comparison against a differently sized image"
    );

    let [dev_x, dev_y, dev_z] = max_position_deviation;
    let within = |a: [i32; 4], b: [i32; 4]| (0..4).all(|c| a[c].abs_diff(b[c]) <= threshold.m_data[c]);

    // Accept pixels "sampling" over the image bounds pixels since "taps" could be anything
    let (begin_x, begin_y, begin_z) = if accept_out_of_bounds_as_any_value {
        (dev_x, dev_y, dev_z)
    } else {
        (0, 0, 0)
    };
    let (end_x, end_y, end_z) = if accept_out_of_bounds_as_any_value {
        (width - dev_x, height - dev_y, depth - dev_z)
    } else {
        (width, height, depth)
    };
    debug_assert!(end_x > 0 && end_y > 0 && end_z > 0, "most likely a bug");

    // Whether `pixel` has a counterpart in `other` within the search volume around (x, y, z).
    let found_nearby = |pixel: [i32; 4], other: &ConstPixelBufferAccess<'_>, x: i32, y: i32, z: i32| {
        for sz in (z - dev_z).max(0)..=(z + dev_z).min(depth - 1) {
            for sy in (y - dev_y).max(0)..=(y + dev_y).min(height - 1) {
                for sx in (x - dev_x).max(0)..=(x + dev_x).min(width - 1) {
                    if within(pixel, other.get_pixel_int(sx as u32, sy as u32, sz as u32)) {
                        return true;
                    }
                }
            }
        }
        false
    };

    for z in begin_z..end_z {
        for y in begin_y..end_y {
            for x in begin_x..end_x {
                let ref_pix = reference.get_pixel_int(x as u32, y as u32, z as u32);
                let cmp_pix = result.get_pixel_int(x as u32, y as u32, z as u32);

                // Exact match
                if within(ref_pix, cmp_pix) {
                    continue;
                }

                // Find matching pixels for both result and reference pixel
                if !found_nearby(ref_pix, result, x, y, z) || !found_nearby(cmp_pix, reference, x, y, z) {
                    return false;
                }
            }
        }
    }
    true
}

/// `tcu::pixelThresholdCompare`
pub fn pixel_threshold_compare(reference: &Surface, result: &Surface, threshold: RGBA) -> ThresholdCompareResult {
    let threshold = UVec4::new(
        threshold.get_red() as u32,
        threshold.get_green() as u32,
        threshold.get_blue() as u32,
        threshold.get_alpha() as u32,
    );
    int_threshold_compare(&reference.get_const_access(), &result.get_const_access(), threshold)
}

/// The float flavour of `ThresholdCompareResult`.
pub struct FloatThresholdCompareResult {
    pub ok: bool,
    pub max_diff: [f32; 4],
}

/// `tcu::floatThresholdCompare` - the same shape as `int_threshold_compare`, on the
/// float view of each pixel.
pub fn float_threshold_compare(
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    threshold: [f32; 4],
) -> FloatThresholdCompareResult {
    let [width, height, depth] = reference.size();
    let mut max_diff = [0.0f32; 4];

    assert!(
        result.size() == reference.size(),
        "image comparison against a differently sized image"
    );

    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let ref_pix = reference.get_pixel(x, y, z);
                let cmp_pix = result.get_pixel(x, y, z);
                for c in 0..4 {
                    max_diff[c] = max_diff[c].max((ref_pix[c] - cmp_pix[c]).abs());
                }
            }
        }
    }

    let ok = (0..4).all(|c| max_diff[c] <= threshold[c]);
    FloatThresholdCompareResult { ok, max_diff }
}

/// `getPositionOfIEEEFloatWithoutDenormals` - where `x` sits in the enumeration of
/// IEEE-754 single-precision values once the denormals have been collapsed onto zero.
///
/// Flushing them is what lets a driver that does not implement denormals still be
/// compared at a one-ULP threshold.
fn position_of_ieee_float_without_denormals(x: f32) -> i32 {
    debug_assert!(!x.is_nan(), "a NaN has no position in the enumeration");

    if x == 0.0 {
        0
    } else if x < 0.0 {
        -position_of_ieee_float_without_denormals(-x)
    } else if x.is_subnormal() {
        // Denorms are flushed to zero.
        0
    } else {
        // The sign is 0 and this is a normal number, so its natural position is its bit
        // pattern - but the collapsed denormals leave a gap that has to come out too, so
        // that the enumeration stays continuous. They occupy one exponent pattern;
        // subtracting it and adding one back for the single value that range did
        // represent (0) is exactly that.
        (x.to_bits() - (1u32 << 23) + 1) as i32
    }
}

/// `computeFloatFlushRelaxedULPDiff`
fn float_flush_relaxed_ulp_diff(a: f32, b: f32) -> u32 {
    if a.is_nan() && b.is_nan() {
        0
    } else if a.is_nan() || b.is_nan() {
        u32::MAX
    } else {
        // "Definition 5" in Muller, Jean-Michel, "On the definition of ulp (x)" (2005),
        // over an IEEE single-precision space without denormals or signed zeros.
        position_of_ieee_float_without_denormals(a).abs_diff(position_of_ieee_float_without_denormals(b))
    }
}

/// `tcu::floatUlpThresholdCompare` - for a floating-point render target, where an
/// absolute threshold would have to be picked per magnitude.
pub fn float_ulp_threshold_compare(
    reference: &ConstPixelBufferAccess<'_>,
    result: &ConstPixelBufferAccess<'_>,
    threshold: UVec4,
) -> ThresholdCompareResult {
    let [width, height, depth] = reference.size();
    let mut max_diff = [0u32; 4];

    assert!(
        result.size() == reference.size(),
        "image comparison against a differently sized image"
    );

    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let ref_pix = reference.get_pixel(x, y, z);
                let cmp_pix = result.get_pixel(x, y, z);
                for c in 0..4 {
                    max_diff[c] = max_diff[c].max(float_flush_relaxed_ulp_diff(ref_pix[c], cmp_pix[c]));
                }
            }
        }
    }

    let ok = (0..4).all(|c| max_diff[c] <= threshold.m_data[c]);
    ThresholdCompareResult {
        ok,
        max_diff: UVec4::from_array(max_diff),
    }
}
