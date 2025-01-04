// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexture.hpp / .cpp  (tcu::Texture2DArray)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `tcu::Texture2DArray` - the array counterpart of `tcu::texture_2d::Texture2D` (same
// doc comment's narrowing applies here too: no `sample`/`sampleOffset` methods, no copy
// constructor). Needed for `texture.filtering`/`texture.mipmap`/`texture.format`/
// `texture.vertex`'s own `TEXTURETYPE_2D_ARRAY` cases.
//
// A layer count is constant across the whole mip chain (unlike `Texture3D`'s own depth,
// which shrinks every level the way width/height do) - upstream's own
// `computeMipPyramidLevels(width, height)` (no `numLayers` term) and
// `allocLevel`'s `TextureLevelPyramid::allocLevel(levelNdx, width, height, m_numLayers)`
// (the layer count passed unchanged at every level) both confirm this, so each level
// here is `w x h x num_layers`, `w`/`h` shrinking per level exactly like `Texture2D`'s
// own `mip_level_size` and `num_layers` held fixed - the opposite shape from
// `Texture3D`'s own module doc comment, stated here for the same reason that one states
// its own rule.
use super::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use super::texture::TextureFormat;

fn mip_level_size(base: u32, level: usize) -> u32 {
    (base >> level).max(1)
}

/// `computeMipPyramidLevels(width, height)` - the layer count plays no part, matching
/// `tcu::texture_2d::Texture2D`'s own formula exactly (it is the same upstream function).
fn compute_mip_pyramid_levels(width: u32, height: u32) -> usize {
    (width.max(height).ilog2() + 1) as usize
}

/// `tcu::Texture2DArray`, narrowed per this module's top doc comment.
pub struct Texture2DArray {
    format: TextureFormat,
    width: u32,
    height: u32,
    num_layers: u32,
    levels: Vec<Option<TextureLevel>>,
}

impl Texture2DArray {
    /// `Texture2DArray::Texture2DArray(format, width, height, numLayers)` - a complete
    /// mip chain down to 1x1 (in width/height only - the layer count never shrinks),
    /// every level starting empty (unallocated).
    pub fn new(format: TextureFormat, width: u32, height: u32, num_layers: u32) -> Self {
        let num_levels = compute_mip_pyramid_levels(width, height);
        Self {
            format,
            width,
            height,
            num_layers,
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

    pub fn num_layers(&self) -> u32 {
        self.num_layers
    }

    /// `TextureLevelPyramid::getNumLevels`
    pub fn num_levels(&self) -> usize {
        self.levels.len()
    }

    /// `TextureLevelPyramid::isLevelEmpty`
    pub fn is_level_empty(&self, level: usize) -> bool {
        self.levels[level].is_none()
    }

    /// `Texture2DArray::allocLevel` - width/height shrink per level, the layer count
    /// (this array's own depth) stays exactly `num_layers` at every level.
    ///
    /// # Panics
    /// If `level` is already allocated, or `level >= num_levels()`, or the format
    /// cannot back a writable `TextureLevel` (see `TextureLevel::new`).
    pub fn alloc_level(&mut self, level: usize) {
        assert!(self.is_level_empty(level), "allocLevel on an already-allocated level");
        let w = mip_level_size(self.width, level);
        let h = mip_level_size(self.height, level);
        self.levels[level] = Some(
            TextureLevel::new(self.format, w, h, self.num_layers)
                .expect("Texture2DArray's own format must be writable - checked at construction in every real caller"),
        );
    }

    /// `TextureLevelPyramid::getLevel` (const) - the whole `w x h x num_layers` stack,
    /// one layer per depth slice (the same convention `glu::Texture2DArray::upload`'s
    /// single `glTexImage3D` call per level reads through).
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
        let tex = Texture2DArray::new(rgba8(), 8, 8, 5);
        assert_eq!(tex.num_levels(), 4);
    }

    #[test]
    fn the_layer_count_plays_no_part_in_the_chain_length() {
        // Same width/height as the test above, wildly different layer counts - the
        // chain length must be identical, since only width/height decide it.
        let tex_few = Texture2DArray::new(rgba8(), 8, 8, 1);
        let tex_many = Texture2DArray::new(rgba8(), 8, 8, 200);
        assert_eq!(tex_few.num_levels(), tex_many.num_levels());
    }

    #[test]
    fn alloc_level_shrinks_width_and_height_but_never_the_layer_count() {
        let mut tex = Texture2DArray::new(rgba8(), 8, 3, 5);
        let expected_wh = [(8, 3), (4, 1), (2, 1), (1, 1)];
        assert_eq!(tex.num_levels(), expected_wh.len());
        for (level, &(w, h)) in expected_wh.iter().enumerate() {
            tex.alloc_level(level);
            assert_eq!(tex.level(level).size(), [w, h, 5], "level {level}");
        }
    }

    #[test]
    #[should_panic(expected = "already-allocated")]
    fn alloc_level_twice_panics() {
        let mut tex = Texture2DArray::new(rgba8(), 2, 2, 3);
        tex.alloc_level(0);
        tex.alloc_level(0);
    }

    #[test]
    fn each_layer_is_independently_addressable() {
        let mut tex = Texture2DArray::new(rgba8(), 2, 2, 2);
        tex.alloc_level(0);
        tex.level_mut(0).set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);
        tex.level_mut(0).set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1);
        assert_eq!(tex.level(0).get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0]);
        assert_eq!(tex.level(0).get_pixel(0, 0, 1), [0.0, 0.0, 1.0, 1.0]);
    }
}
