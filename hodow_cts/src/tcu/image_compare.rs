// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuImageCompare.hpp / .cpp  (intThresholdCompare, pixelThresholdCompare)
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
pub fn int_threshold_compare(reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, threshold: UVec4) -> ThresholdCompareResult {
    let [width, height, depth] = reference.size();
    let mut max_diff = [0u32; 4];

    assert!(result.size() == reference.size(), "image comparison against a differently sized image");

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
