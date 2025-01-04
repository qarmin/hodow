// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuSurfaceAccess.hpp / .cpp  (tcu::SurfaceAccess)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `gls`/`glu` `sampleTexture`
// overloads call `SurfaceAccess::setPixel` from inside the sampling loop; the sampling
// functions in `glu::texture_test_util` write float colours into a `PixelBufferAccess`,
// so `write_with` hands them a float scratch image of the region and converts it into
// the surface afterwards through the same masked `RGBA(Vec4)` quantisation.

use crate::tcu::TestError;
use crate::tcu::pixel::PixelBufferAccess;
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::rgba::{ALPHA_MASK, BLUE_MASK, GREEN_MASK, RED_MASK, RGBA};
use crate::tcu::surface::Surface;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec4;

/// `tcu::getColorMask`
pub fn get_color_mask(format: PixelFormat) -> u32 {
    (if format.red_bits != 0 { RED_MASK } else { 0 })
        | (if format.green_bits != 0 { GREEN_MASK } else { 0 })
        | (if format.blue_bits != 0 { BLUE_MASK } else { 0 })
        | (if format.alpha_bits != 0 { ALPHA_MASK } else { 0 })
}

/// `tcu::toRGBAMasked` - alpha defaults to full saturation when the format has none.
pub fn to_rgba_masked(v: Vec4, mask: u32) -> RGBA {
    let full = RGBA::from_vec(v);
    RGBA::new(
        if mask & RED_MASK != 0 { full.get_red() } else { 0 },
        if mask & GREEN_MASK != 0 { full.get_green() } else { 0 },
        if mask & BLUE_MASK != 0 { full.get_blue() } else { 0 },
        if mask & ALPHA_MASK != 0 { full.get_alpha() } else { 0xFF },
    )
}

/// `tcu::SurfaceAccess` - a rectangle of a `Surface` that accepts float colours and
/// stores them quantised to a render target's channel layout.
pub struct SurfaceAccess<'a> {
    surface: &'a mut Surface,
    color_mask: u32,
    x: i32,
    y: i32,
    width: i32,
    height: i32,
}

impl<'a> SurfaceAccess<'a> {
    /// `SurfaceAccess(surface, colorFmt)`
    pub fn new(surface: &'a mut Surface, color_fmt: PixelFormat) -> Self {
        let (width, height) = (surface.get_width(), surface.get_height());
        Self {
            surface,
            color_mask: get_color_mask(color_fmt),
            x: 0,
            y: 0,
            width,
            height,
        }
    }

    /// `SurfaceAccess(surface, colorFmt, x, y, width, height)`
    pub fn new_region(
        surface: &'a mut Surface,
        color_fmt: PixelFormat,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) -> Self {
        Self {
            surface,
            color_mask: get_color_mask(color_fmt),
            x,
            y,
            width,
            height,
        }
    }

    /// `SurfaceAccess(parent, x, y, width, height)`
    pub fn sub_access(&mut self, x: i32, y: i32, width: i32, height: i32) -> SurfaceAccess<'_> {
        SurfaceAccess {
            surface: &mut *self.surface,
            color_mask: self.color_mask,
            x: self.x + x,
            y: self.y + y,
            width,
            height,
        }
    }

    pub fn get_width(&self) -> i32 {
        self.width
    }

    pub fn get_height(&self) -> i32 {
        self.height
    }

    /// `SurfaceAccess::setPixel`
    pub fn set_pixel(&mut self, color: Vec4, x: i32, y: i32) {
        assert!(
            (0..self.width).contains(&x) && (0..self.height).contains(&y),
            "SurfaceAccess::set_pixel out of bounds"
        );
        self.surface
            .set_pixel(self.x + x, self.y + y, to_rgba_masked(color, self.color_mask));
    }

    /// Runs `f` against a float RGBA scratch image the size of this region (so the
    /// sampling code sees the same destination dimensions it would see with a
    /// `SurfaceAccess`), then stores the result pixel by pixel through `set_pixel`.
    pub fn write_with(&mut self, f: impl FnOnce(&mut PixelBufferAccess<'_>)) -> Result<(), TestError> {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut scratch = crate::tcu::pixel::TextureLevel::new(format, self.width as u32, self.height as u32, 1)?;
        f(&mut scratch.get_access());
        let result = scratch.get_const_access();
        for y in 0..self.height {
            for x in 0..self.width {
                let c = result.get_pixel(x as u32, y as u32, 0);
                self.set_pixel(Vec4::from_array(c), x, y);
            }
        }
        Ok(())
    }
}
