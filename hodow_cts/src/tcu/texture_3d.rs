// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexture.hpp / .cpp  (tcu::Texture3D)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `tcu::Texture3D` - the 3D counterpart of `tcu::texture_2d::Texture2D` (same doc
// comment's narrowing applies here too: no `sample`/`sampleOffset` methods, no copy
// constructor). Needed for `texture.filtering`/`texture.mipmap`/`texture.format`/
// `texture.vertex`'s own `TEXTURETYPE_3D` cases - confirmed by grepping
// `es3fTextureFilteringTests.cpp` directly (`glu::Texture3D m_gradientTex`/`m_gridTex`,
// `ReferenceParams refParams(TEXTURETYPE_3D)`).
//
// Unlike `Texture2D`'s rows-of-texels or `TextureCube`'s "six faces as depth slices of
// one `TextureLevel` per level" shape, a 3D texture's own depth genuinely shrinks per
// mip level along with its width/height - `tcu::pixel::sample_3d_mipmap`'s own doc
// comment already states this ("each `levels[n]` is already sized to that level's own
// depth"), so each level here is a plain, independently-sized `TextureLevel` exactly
// the way `Texture2D`'s levels are, just with a real (not always-1) depth.
use super::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use super::texture::TextureFormat;

/// `getMipPyramidLevelSize` - halved each level down from `base`, floored at 1.
fn mip_level_size(base: u32, level: usize) -> u32 {
    (base >> level).max(1)
}

/// `computeMipPyramidLevels(width, height, depth)` - `deLog2Floor32(max(width,
/// max(height, depth))) + 1`, i.e. how many levels a *complete* mip chain has down to
/// a 1x1x1 base.
fn compute_mip_pyramid_levels(width: u32, height: u32, depth: u32) -> usize {
    (width.max(height).max(depth).ilog2() + 1) as usize
}

/// `tcu::Texture3D`, narrowed per this module's top doc comment.
pub struct Texture3D {
    format: TextureFormat,
    width: u32,
    height: u32,
    depth: u32,
    levels: Vec<Option<TextureLevel>>,
}

impl Texture3D {
    /// `Texture3D::Texture3D(format, width, height, depth)` - a complete mip chain
    /// down to 1x1x1, every level starting empty (unallocated).
    pub fn new(format: TextureFormat, width: u32, height: u32, depth: u32) -> Self {
        let num_levels = compute_mip_pyramid_levels(width, height, depth);
        Self {
            format,
            width,
            height,
            depth,
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

    pub fn depth(&self) -> u32 {
        self.depth
    }

    /// `TextureLevelPyramid::getNumLevels`
    pub fn num_levels(&self) -> usize {
        self.levels.len()
    }

    /// `TextureLevelPyramid::isLevelEmpty`
    pub fn is_level_empty(&self, level: usize) -> bool {
        self.levels[level].is_none()
    }

    /// `Texture3D::allocLevel` - the per-level width/height/depth is derived from
    /// level 0's own size, exactly like upstream's own three `getMipPyramidLevelSize`
    /// calls.
    ///
    /// # Panics
    /// If `level` is already allocated, or `level >= num_levels()`, or the format
    /// cannot back a writable `TextureLevel` (see `TextureLevel::new`).
    pub fn alloc_level(&mut self, level: usize) {
        assert!(self.is_level_empty(level), "allocLevel on an already-allocated level");
        let w = mip_level_size(self.width, level);
        let h = mip_level_size(self.height, level);
        let d = mip_level_size(self.depth, level);
        self.levels[level] = Some(
            TextureLevel::new(self.format, w, h, d)
                .expect("Texture3D's own format must be writable - checked at construction in every real caller"),
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
    fn a_cube_power_of_two_texture_gets_the_full_chain_down_to_one_by_one() {
        // 8x8x8 -> 8,4,2,1 = 4 levels = log2(8)+1.
        let tex = Texture3D::new(rgba8(), 8, 8, 8);
        assert_eq!(tex.num_levels(), 4);
    }

    #[test]
    fn the_largest_dimension_decides_the_chain_length_even_when_its_not_width() {
        // max(2, 2, 6) = 6, ilog2(6) = 2 (since 4 <= 6 < 8), so 3 levels.
        let tex = Texture3D::new(rgba8(), 2, 2, 6);
        assert_eq!(tex.num_levels(), 3);
    }

    #[test]
    fn a_1x1x1_texture_has_exactly_one_level() {
        let tex = Texture3D::new(rgba8(), 1, 1, 1);
        assert_eq!(tex.num_levels(), 1);
    }

    #[test]
    fn alloc_level_sizes_follow_the_halve_and_floor_rule_on_all_three_axes() {
        let mut tex = Texture3D::new(rgba8(), 8, 3, 1);
        // level 0: 8x3x1, level 1: 4x1x1 (3>>1==1, 1>>1==0 floored to 1), level 2:
        // 2x1x1, level 3: 1x1x1.
        let expected = [(8, 3, 1), (4, 1, 1), (2, 1, 1), (1, 1, 1)];
        assert_eq!(tex.num_levels(), expected.len());
        for (level, &(w, h, d)) in expected.iter().enumerate() {
            tex.alloc_level(level);
            assert!(!tex.is_level_empty(level));
            assert_eq!(tex.level(level).size(), [w, h, d], "level {level}");
        }
    }

    #[test]
    #[should_panic(expected = "already-allocated")]
    fn alloc_level_twice_panics() {
        let mut tex = Texture3D::new(rgba8(), 2, 2, 2);
        tex.alloc_level(0);
        tex.alloc_level(0);
    }

    #[test]
    fn written_pixels_round_trip_through_level_and_level_mut() {
        let mut tex = Texture3D::new(rgba8(), 2, 2, 2);
        tex.alloc_level(0);
        tex.level_mut(0).set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 1);
        assert_eq!(tex.level(0).get_pixel(1, 0, 1), [0.0, 1.0, 0.0, 1.0]);
        // An untouched texel on a different depth slice keeps the zero default.
        assert_eq!(tex.level(0).get_pixel(1, 0, 0), [0.0, 0.0, 0.0, 0.0]);
    }
}
