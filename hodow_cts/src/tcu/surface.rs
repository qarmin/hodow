// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuSurface.hpp / .cpp  (tcu::Surface)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream stores one `uint32_t` per
// pixel and reads it as a packed `RGBA` on a little-endian host; this stores the bytes
// and assembles the word, which is what upstream's own big-endian branch does and is
// the same layout `glReadPixels(GL_RGBA, GL_UNSIGNED_BYTE)` fills.

use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess};
use crate::tcu::rgba::RGBA;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

/// The one format `tcu::Surface` has.
const FORMAT: TextureFormat = TextureFormat {
    order: ChannelOrder::RGBA,
    type_: ChannelType::UNORM_INT8,
};

/// `tcu::Surface` - an RGBA8888 image, the convenience form of a `PixelBufferAccess`
/// that most GL tests read their framebuffer into.
#[derive(Clone)]
pub struct Surface {
    width: i32,
    height: i32,
    pixels: Vec<u8>,
}

impl Surface {
    pub fn new(width: i32, height: i32) -> Self {
        Self {
            width,
            height,
            pixels: vec![0u8; (width as usize) * (height as usize) * 4],
        }
    }

    /// `Surface::setSize` - reallocates; the contents are undefined afterwards, exactly
    /// as upstream's `de::ArrayBuffer::setStorage` leaves them.
    pub fn set_size(&mut self, width: i32, height: i32) {
        self.width = width;
        self.height = height;
        self.pixels.clear();
        self.pixels.resize((width as usize) * (height as usize) * 4, 0);
    }

    pub fn get_width(&self) -> i32 {
        self.width
    }

    pub fn get_height(&self) -> i32 {
        self.height
    }

    pub fn set_pixel(&mut self, x: i32, y: i32, col: RGBA) {
        let offset = (y as usize * self.width as usize + x as usize) * 4;
        self.pixels[offset] = col.get_red() as u8;
        self.pixels[offset + 1] = col.get_green() as u8;
        self.pixels[offset + 2] = col.get_blue() as u8;
        self.pixels[offset + 3] = col.get_alpha() as u8;
    }

    pub fn get_pixel(&self, x: i32, y: i32) -> RGBA {
        let offset = (y as usize * self.width as usize + x as usize) * 4;
        RGBA::new(
            self.pixels[offset] as i32,
            self.pixels[offset + 1] as i32,
            self.pixels[offset + 2] as i32,
            self.pixels[offset + 3] as i32,
        )
    }

    /// `Surface::getAccess`
    pub fn get_access(&mut self) -> PixelBufferAccess<'_> {
        PixelBufferAccess::new(FORMAT, [self.width as u32, self.height as u32, 1], &mut self.pixels)
    }

    /// Raw RGBA8 bytes, row 0 first.
    pub fn bytes(&self) -> &[u8] {
        &self.pixels
    }

    /// `Surface::getAccess` on a const surface.
    pub fn get_const_access(&self) -> ConstPixelBufferAccess<'_> {
        ConstPixelBufferAccess::new(FORMAT, [self.width as u32, self.height as u32, 1], &self.pixels)
    }
}
