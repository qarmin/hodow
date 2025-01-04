// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexture.hpp / .cpp  (tcu::TextureLevelPyramid, tcu::Texture2D)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `tcu::Texture2D` - the host-side mip-pyramid storage a real-driver texture wrapper
// (`glu::Texture2D`, which this exists to back) uploads from, and what the texture-half
// of `shaders.texture_functions`/`shaders.derivate`/`shaders.builtin_functions` needs:
// a mutable level 0..N-1, each independently allocated (so a test can populate only the
// levels it cares about and leave the rest "empty", matching `glu::Texture2D::upload`'s
// own `isLevelEmpty` skip).
//
// Narrowed from upstream's real class in two ways: no `sample`/`sampleOffset`/
// `gatherOffsets` methods (the per-fragment sampling math already lives in
// `tcu::pixel::sample_2d`/`sample_2d_mipmap` and `glu::texture_test_util`'s LOD/
// derivative helpers - duplicating it here as a method would just be a second call
// site for the same formula) and no copy constructor/`operator=` (nothing here needs
// to duplicate a whole mip chain; `Clone` would be mechanical to add if that changes).
// Only the two-dimensional, non-YUV, non-ES2-packed-depth constructor is ported -
// upstream's `es2` boolean parameter changes `Texture2DView`'s sampling behaviour for a
// subset of depth/stencil formats on an ES2 context, which is exactly the sampling
// surface this type deliberately does not carry.

use super::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use super::texture::TextureFormat;

/// `getMipPyramidLevelSize` - the width (or height) of mip level `level`, halved each
/// level down from `base`, floored at 1 (a mip chain never has a zero-sized level, even
/// past the point where further halving would reach it).
fn mip_level_size(base: u32, level: usize) -> u32 {
    (base >> level).max(1)
}

/// `computeMipPyramidLevels(width, height)` - `deLog2Floor32(max(width, height)) + 1`,
/// i.e. how many levels a *complete* mip chain has down to a 1x1 base. `ilog2` is
/// `deLog2Floor32` for any positive value (see e.g. `gles2::functional::negative_api::
/// texture`'s own comment making the same substitution) - `width`/`height` are always
/// positive here, a texture of size 0 having no sensible mip chain at all.
fn compute_mip_pyramid_levels(width: u32, height: u32) -> usize {
    (width.max(height).ilog2() + 1) as usize
}

/// `tcu::Texture2D`, narrowed per this module's top doc comment.
pub struct Texture2D {
    format: TextureFormat,
    width: u32,
    height: u32,
    /// `TextureLevelPyramid::m_data`/`m_access` collapsed into one - `None` is
    /// upstream's `m_data[levelNdx].empty()` (`isLevelEmpty`), `Some` is an allocated,
    /// independently-sized level.
    levels: Vec<Option<TextureLevel>>,
}

impl Texture2D {
    /// `Texture2D::Texture2D(format, width, height, es2)`, always with `es2 = false`
    /// (see this module's top doc comment) - a complete mip chain down to 1x1, with
    /// every level starting empty (unallocated).
    pub fn new(format: TextureFormat, width: u32, height: u32) -> Self {
        let num_levels = compute_mip_pyramid_levels(width, height);
        Self {
            format,
            width,
            height,
            levels: (0..num_levels).map(|_| None).collect(),
        }
    }

    pub fn format(&self) -> TextureFormat {
        self.format
    }

    pub fn width(&self) -> u32 {
        self.width
    }

    pub fn height(&self) -> u32 {
        self.height
    }

    /// `TextureLevelPyramid::getNumLevels`
    pub fn num_levels(&self) -> usize {
        self.levels.len()
    }

    /// `TextureLevelPyramid::isLevelEmpty`
    pub fn is_level_empty(&self, level: usize) -> bool {
        self.levels[level].is_none()
    }

    /// `Texture2D::allocLevel` - the per-level width/height is derived from level 0's
    /// own size, not read back from anywhere else, exactly like upstream's own
    /// `getMipPyramidLevelSize(m_width, levelNdx)` call.
    ///
    /// # Panics
    /// If `level` is already allocated (`debug_assert!(isLevelEmpty(levelNdx))`
    /// upstream) or `level >= num_levels()`, or the format cannot back a writable
    /// `TextureLevel` (see `TextureLevel::new`).
    pub fn alloc_level(&mut self, level: usize) {
        assert!(self.is_level_empty(level), "allocLevel on an already-allocated level");
        let w = mip_level_size(self.width, level);
        let h = mip_level_size(self.height, level);
        self.levels[level] = Some(
            TextureLevel::new(self.format, w, h, 1)
                .expect("Texture2D's own format must be writable - checked at construction in every real caller"),
        );
    }

    /// `TextureLevelPyramid::getLevel` (const)
    ///
    /// # Panics
    /// If `level` has never been allocated.
    pub fn level(&self, level: usize) -> ConstPixelBufferAccess<'_> {
        self.levels[level]
            .as_ref()
            .expect("level not allocated - call alloc_level first")
            .get_const_access()
    }

    /// `TextureLevelPyramid::getLevel`, mutable.
    ///
    /// # Panics
    /// If `level` has never been allocated.
    pub fn level_mut(&mut self, level: usize) -> PixelBufferAccess<'_> {
        self.levels[level]
            .as_mut()
            .expect("level not allocated - call alloc_level first")
            .get_access()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::texture::{ChannelOrder, ChannelType};

    fn rgba8() -> TextureFormat {
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)
    }

    #[test]
    fn a_square_power_of_two_texture_gets_the_full_chain_down_to_one_by_one() {
        // 8x8 -> 8,4,2,1 = 4 levels = log2(8)+1.
        let tex = Texture2D::new(rgba8(), 8, 8);
        assert_eq!(tex.num_levels(), 4);
    }

    #[test]
    fn a_non_power_of_two_texture_uses_the_larger_dimension_and_floors() {
        // max(6, 3) = 6, ilog2(6) = 2 (since 4 <= 6 < 8), so 3 levels: 6x3, 3x1, 1x1.
        let tex = Texture2D::new(rgba8(), 6, 3);
        assert_eq!(tex.num_levels(), 3);
    }

    #[test]
    fn a_1x1_texture_has_exactly_one_level() {
        let tex = Texture2D::new(rgba8(), 1, 1);
        assert_eq!(tex.num_levels(), 1);
    }

    #[test]
    fn every_level_starts_empty() {
        let tex = Texture2D::new(rgba8(), 4, 4);
        for level in 0..tex.num_levels() {
            assert!(tex.is_level_empty(level), "level {level} should start unallocated");
        }
    }

    #[test]
    fn alloc_level_sizes_follow_the_halve_and_floor_rule() {
        let mut tex = Texture2D::new(rgba8(), 8, 3);
        // level 0: 8x3, level 1: 4x1 (3>>1 == 1), level 2: 2x1, level 3: 1x1.
        let expected = [(8, 3), (4, 1), (2, 1), (1, 1)];
        assert_eq!(tex.num_levels(), expected.len());
        for (level, &(w, h)) in expected.iter().enumerate() {
            tex.alloc_level(level);
            assert!(!tex.is_level_empty(level));
            assert_eq!(tex.level(level).size()[..2], [w, h], "level {level}");
        }
    }

    #[test]
    #[should_panic(expected = "already-allocated")]
    fn alloc_level_twice_panics() {
        let mut tex = Texture2D::new(rgba8(), 2, 2);
        tex.alloc_level(0);
        tex.alloc_level(0);
    }

    #[test]
    #[should_panic(expected = "not allocated")]
    fn reading_an_unallocated_level_panics() {
        let tex = Texture2D::new(rgba8(), 2, 2);
        let _ = tex.level(0);
    }

    #[test]
    fn written_pixels_round_trip_through_level_and_level_mut() {
        let mut tex = Texture2D::new(rgba8(), 2, 2);
        tex.alloc_level(0);
        tex.level_mut(0).set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 0);
        assert_eq!(tex.level(0).get_pixel(1, 0, 0), [0.0, 1.0, 0.0, 1.0]);
        // an untouched texel keeps the format's zero-initialised default.
        assert_eq!(tex.level(0).get_pixel(0, 0, 0), [0.0, 0.0, 0.0, 0.0]);
    }
}
