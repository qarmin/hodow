// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTexture.hpp / .cpp  (tcu::TextureCube)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `tcu::TextureCube` - the cube-map counterpart of `tcu::texture_2d::Texture2D`
// (same doc comment's narrowing applies here too: no `sample`/`sampleOffset` methods,
// no copy constructor). Needed for `texture.filtering`/`texture.mipmap`/
// `texture.shadow`'s own `TEXTURETYPE_CUBE` cases - confirmed by grepping
// `es3fTextureFilteringTests.cpp`/`es3fTextureMipmapTests.cpp`/`es3fTextureShadowTests.cpp`
// directly.
//
// Upstream's own `TextureCube` stores six independent `TextureLevelPyramid`s, one per
// face. This port stores one `TextureLevel` *per mip level*, each `size x size x 6`
// (the six faces as depth slices, in `tcu::get_cube_array_face_index`'s own order -
// `PositiveX=0, NegativeX=1, PositiveY=2, NegativeY=3, PositiveZ=4, NegativeZ=5`, which
// is also GL's own contiguous `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z` enum order),
// matching exactly the layout `tcu::pixel::sample_cube_mipmap` already expects - "one `ConstPixelBufferAccess` per level, six faces as depth
// slices" is a direct quote of that function's own doc comment. This also means
// `face_level`/`face_level_mut` are the only genuinely new accessors; `level`/
// `level_mut` return the whole six-face stack for whatever needs all of it at once
// (`glu::TextureCube::upload`, one `glTexImage2D` call per face, reads through
// `face_level` instead).

use super::pixel::{ConstPixelBufferAccess, CubeFace, PixelBufferAccess, TextureLevel, get_cube_array_face_index};
use super::texture::TextureFormat;

fn mip_level_size(base: u32, level: usize) -> u32 {
    (base >> level).max(1)
}

fn compute_mip_pyramid_levels(size: u32) -> usize {
    size.ilog2() as usize + 1
}

/// `tcu::TextureCube`, narrowed per this module's top doc comment.
pub struct TextureCube {
    format: TextureFormat,
    size: u32,
    levels: Vec<Option<TextureLevel>>,
}

impl TextureCube {
    /// `TextureCube::TextureCube(format, size)` - a complete mip chain down to 1x1,
    /// every level starting empty (unallocated), each face's own slot still unwritten
    /// once a level is allocated (matching `Texture2D::new`'s own zero-initialised
    /// convention - see `TextureLevel::new`).
    pub fn new(format: TextureFormat, size: u32) -> Self {
        let num_levels = compute_mip_pyramid_levels(size);
        Self {
            format,
            size,
            levels: (0..num_levels).map(|_| None).collect(),
        }
    }

    pub fn format(&self) -> TextureFormat {
        self.format
    }

    pub fn size(&self) -> u32 {
        self.size
    }

    pub fn num_levels(&self) -> usize {
        self.levels.len()
    }

    pub fn is_level_empty(&self, level: usize) -> bool {
        self.levels[level].is_none()
    }

    /// `TextureCube::allocLevel` - allocates all six faces of this level at once (a
    /// `size x size x 6` `TextureLevel`), unlike upstream's per-face `m_data[face][level]`
    /// shape where each face could in principle be allocated independently - no ported
    /// test needs that finer granularity, and every known caller fills every face of a
    /// level it allocates anyway.
    ///
    /// # Panics
    /// If `level` is already allocated, or `level >= num_levels()`.
    pub fn alloc_level(&mut self, level: usize) {
        assert!(self.is_level_empty(level), "allocLevel on an already-allocated level");
        let s = mip_level_size(self.size, level);
        self.levels[level] = Some(
            TextureLevel::new(self.format, s, s, 6)
                .expect("TextureCube's own format must be writable - checked at construction in every real caller"),
        );
    }

    /// The whole six-face stack of one mip level, depth-indexed by
    /// `get_cube_array_face_index`.
    ///
    /// # Panics
    /// If `level` has never been allocated.
    pub fn level(&self, level: usize) -> ConstPixelBufferAccess<'_> {
        self.levels[level]
            .as_ref()
            .expect("level not allocated - call alloc_level first")
            .get_const_access()
    }

    /// `level`, mutable.
    pub fn level_mut(&mut self, level: usize) -> PixelBufferAccess<'_> {
        self.levels[level]
            .as_mut()
            .expect("level not allocated - call alloc_level first")
            .get_access()
    }

    /// One face's own `size x size x 1` slice of a mip level - what `glu::TextureCube::upload`
    /// reads per `glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X + faceIndex, ...)` call.
    ///
    /// Built directly from the level's own tightly-packed storage rather than through
    /// `ConstPixelBufferAccess::get_subregion` - that method's own `&self`-elided
    /// lifetime ties its result to whatever temporary it was called on, which cannot
    /// outlive this function; going straight to `TextureLevel::data()` keeps the result
    /// tied to `&self` (this `TextureCube`) instead, which is what the signature below
    /// actually promises.
    ///
    /// # Panics
    /// If `level` has never been allocated.
    pub fn face_level(&self, face: CubeFace, level: usize) -> ConstPixelBufferAccess<'_> {
        let lvl = self.levels[level]
            .as_ref()
            .expect("level not allocated - call alloc_level first");
        let [w, h, _] = lvl.size();
        let pitch = super::pixel::tight_pitch(lvl.format(), lvl.size());
        let offset = get_cube_array_face_index(face) as usize * pitch[2];
        ConstPixelBufferAccess::new_with_pitch(lvl.format(), [w, h, 1], pitch, &lvl.data()[offset..])
    }

    /// `face_level`, mutable - the accessor a test fills one face through. Same
    /// direct-construction reasoning as `face_level` above.
    ///
    /// # Panics
    /// If `level` has never been allocated.
    pub fn face_level_mut(&mut self, face: CubeFace, level: usize) -> PixelBufferAccess<'_> {
        let lvl = self.levels[level]
            .as_mut()
            .expect("level not allocated - call alloc_level first");
        let [w, h, _] = lvl.size();
        let pitch = super::pixel::tight_pitch(lvl.format(), lvl.size());
        let offset = get_cube_array_face_index(face) as usize * pitch[2];
        PixelBufferAccess::new_with_pitch(lvl.format(), [w, h, 1], pitch, &mut lvl.data_mut()[offset..])
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
    fn a_power_of_two_cube_gets_the_full_chain_down_to_one_by_one() {
        // 8 -> 8,4,2,1 = 4 levels = log2(8) + 1.
        let tex = TextureCube::new(rgba8(), 8);
        assert_eq!(tex.num_levels(), 4);
    }

    #[test]
    fn a_1x1_cube_has_exactly_one_level() {
        let tex = TextureCube::new(rgba8(), 1);
        assert_eq!(tex.num_levels(), 1);
    }

    #[test]
    fn alloc_level_allocates_all_six_faces_at_the_right_size() {
        let mut tex = TextureCube::new(rgba8(), 4);
        tex.alloc_level(1); // 2x2x6
        assert_eq!(tex.level(1).size(), [2, 2, 6]);
    }

    /// Writing through one face's own accessor must not touch any other face, and must
    /// read back through the same accessor - the whole point of storing faces as depth
    /// slices rather than overlapping planes.
    #[test]
    fn each_face_is_independently_addressable_and_does_not_bleed_into_its_neighbours() {
        let mut tex = TextureCube::new(rgba8(), 2);
        tex.alloc_level(0);
        tex.face_level_mut(CubeFace::PositiveX, 0)
            .set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);
        tex.face_level_mut(CubeFace::NegativeZ, 0)
            .set_pixel([0.0, 0.0, 1.0, 1.0], 1, 1, 0);

        assert_eq!(
            tex.face_level(CubeFace::PositiveX, 0).get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0]
        );
        // Untouched texel on the same face as the first write.
        assert_eq!(
            tex.face_level(CubeFace::PositiveX, 0).get_pixel(1, 0, 0),
            [0.0, 0.0, 0.0, 0.0]
        );
        assert_eq!(
            tex.face_level(CubeFace::NegativeZ, 0).get_pixel(1, 1, 0),
            [0.0, 0.0, 1.0, 1.0]
        );
        // Every other face is untouched.
        for face in [
            CubeFace::NegativeX,
            CubeFace::PositiveY,
            CubeFace::NegativeY,
            CubeFace::PositiveZ,
        ] {
            assert_eq!(
                tex.face_level(face, 0).get_pixel(0, 0, 0),
                [0.0, 0.0, 0.0, 0.0],
                "{face:?}"
            );
        }
    }

    #[test]
    #[should_panic(expected = "already-allocated")]
    fn alloc_level_twice_panics() {
        let mut tex = TextureCube::new(rgba8(), 2);
        tex.alloc_level(0);
        tex.alloc_level(0);
    }
}
