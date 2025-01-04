// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuPixelFormat.hpp  (tcu::PixelFormat)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::tcu::rgba::RGBA;

/// `tcu::PixelFormat` - the fixed-point bit depth of a render target.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct PixelFormat {
    pub red_bits: i32,
    pub green_bits: i32,
    pub blue_bits: i32,
    pub alpha_bits: i32,
}

impl PixelFormat {
    pub const fn new(red: i32, green: i32, blue: i32, alpha: i32) -> Self {
        Self {
            red_bits: red,
            green_bits: green,
            blue_bits: blue,
            alpha_bits: alpha,
        }
    }

    /// `PixelFormat::channelThreshold`
    pub fn channel_threshold(bits: i32) -> i32 {
        if bits <= 8 {
            // Threshold is 2^(8 - bits)
            1 << (8 - bits)
        } else {
            // Threshold is bound by the 8-bit buffer value
            1
        }
    }

    /// `PixelFormat::getColorThreshold` - the per-channel tolerance every comparison
    /// against this target starts from. Zero alpha bits means the alpha channel holds
    /// no information, so nothing is demanded of it.
    pub fn get_color_threshold(self) -> RGBA {
        RGBA::new(
            Self::channel_threshold(self.red_bits),
            Self::channel_threshold(self.green_bits),
            Self::channel_threshold(self.blue_bits),
            if self.alpha_bits != 0 {
                Self::channel_threshold(self.alpha_bits)
            } else {
                0
            },
        )
    }
}
