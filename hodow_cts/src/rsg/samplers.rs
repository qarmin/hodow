// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgSamplers.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `.cpp` is `DE_EMPTY_CPP_FILE`
// upstream, same as `rsgParameters` - everything is in the header.
//
// Upstream's `Sampler2D`/`SamplerCube` wrap a raw `const tcu::Texture2D*`/
// `const tcu::TextureCube*` plus an owned `tcu::Sampler`, forwarding `sample()` straight
// to `Texture2D::sample`/`TextureCube::sample` - a whole-mipmap-pyramid sample upstream's
// own texture classes implement as a method. **This port's `tcu::texture_2d::Texture2D`/
// `texture_cube::TextureCube` are storage containers only** (`level()`/`face_level()`
// accessors, no `sample()` method of their own - that logic lives in free functions in
// `tcu::pixel` instead, `sample_2d_mipmap`/`sample_cube_mipmap`, which read a
// `&[ConstPixelBufferAccess]` level slice rather than a texture object). So `Sampler2D`/
// `SamplerCube` here hold that collected slice (`Vec<ConstPixelBufferAccess<'a>>`,
// gathered once at construction) instead of a texture pointer, and forward to those free
// functions - same observable behaviour, shaped around how sampling is actually factored
// in this port.
//
// **No null/default-constructed state.** Upstream's `Sampler2D(void)`/`SamplerCube(void)`
// (`m_texture(nullptr)`) exist only so `std::map<int, Sampler2D>::operator[]` can
// default-construct a missing entry before it is ever meant to be sampled from - not a
// state this port's `HashMap`-based map types need, since nothing here relies on
// insert-via-default-then-overwrite. A `Sampler2D`/`SamplerCube` here always wraps a real
// texture.

use std::collections::HashMap;

use super::super::tcu::pixel::{ConstPixelBufferAccess, Sampler, sample_2d_mipmap, sample_cube_mipmap};
use super::super::tcu::texture_2d::Texture2D;
use super::super::tcu::texture_cube::TextureCube;
use super::super::tcu::vector::Vec4;

/// `rsg::Sampler2D`
pub struct Sampler2D<'a> {
    levels: Vec<ConstPixelBufferAccess<'a>>,
    sampler: Sampler,
}

impl<'a> Sampler2D<'a> {
    pub fn new(texture: &'a Texture2D, sampler: Sampler) -> Self {
        let levels = (0..texture.num_levels())
            .filter(|&level| !texture.is_level_empty(level))
            .map(|level| texture.level(level))
            .collect();
        Self { levels, sampler }
    }

    /// `Sampler2D::sample`
    pub fn sample(&self, s: f32, t: f32, lod: f32) -> Vec4 {
        let c = sample_2d_mipmap(&self.levels, &self.sampler, s, t, lod);
        Vec4::new(c[0], c[1], c[2], c[3])
    }
}

/// `rsg::SamplerCube`
pub struct SamplerCube<'a> {
    levels: Vec<ConstPixelBufferAccess<'a>>,
    sampler: Sampler,
}

impl<'a> SamplerCube<'a> {
    pub fn new(texture: &'a TextureCube, sampler: Sampler) -> Self {
        let levels = (0..texture.num_levels())
            .filter(|&level| !texture.is_level_empty(level))
            .map(|level| texture.level(level))
            .collect();
        Self { levels, sampler }
    }

    /// `SamplerCube::sample`
    pub fn sample(&self, s: f32, t: f32, r: f32, lod: f32) -> Vec4 {
        let c = sample_cube_mipmap(&self.levels, &self.sampler, s, t, r, lod);
        Vec4::new(c[0], c[1], c[2], c[3])
    }
}

/// `rsg::Sampler2DMap`
pub type Sampler2DMap<'a> = HashMap<i32, Sampler2D<'a>>;
/// `rsg::SamplerCubeMap`
pub type SamplerCubeMap<'a> = HashMap<i32, SamplerCube<'a>>;

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::{FilterMode, WrapMode};
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    #[test]
    fn sampler_2d_reads_through_to_the_texture_at_lod_zero() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut texture = Texture2D::new(format, 2, 2);
        // `Sampler2D::new` collects the whole mip pyramid `num_levels()` reports (a 2x2
        // texture has two: 2x2 and 1x1), matching upstream's own assumption that a
        // texture handed to a sampler is already fully mipmapped - both must be
        // allocated before `level()` can read either back.
        texture.alloc_level(0);
        texture.alloc_level(1);
        {
            let mut level = texture.level_mut(0);
            level.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);
            level.set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 0);
            level.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 1, 0);
            level.set_pixel([1.0, 1.0, 1.0, 1.0], 1, 1, 0);
        }
        texture.level_mut(1).set_pixel([0.5, 0.5, 0.5, 1.0], 0, 0, 0);

        let sampler = Sampler {
            wrap_s: WrapMode::ClampToEdge,
            wrap_t: WrapMode::ClampToEdge,
            wrap_r: WrapMode::ClampToEdge,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };
        let rsg_sampler = Sampler2D::new(&texture, sampler);

        // Nearest-sampling dead centre of the top-left texel (s=0.25, t=0.25 in a 2x2
        // normalized-coordinate texture) must read exactly that texel's own colour.
        let c = rsg_sampler.sample(0.25, 0.25, 0.0);
        assert_eq!((c.x(), c.y(), c.z(), c.w()), (1.0, 0.0, 0.0, 1.0));
    }

    #[test]
    fn sampler_2d_map_holds_several_bound_units() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut texture_a = Texture2D::new(format, 1, 1);
        texture_a.alloc_level(0);
        texture_a.level_mut(0).set_pixel([1.0, 1.0, 1.0, 1.0], 0, 0, 0);

        let sampler = Sampler {
            wrap_s: WrapMode::ClampToEdge,
            wrap_t: WrapMode::ClampToEdge,
            wrap_r: WrapMode::ClampToEdge,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };

        let mut map: Sampler2DMap<'_> = Sampler2DMap::new();
        map.insert(3, Sampler2D::new(&texture_a, sampler));
        assert!(map.contains_key(&3));
        assert!(!map.contains_key(&0));
        let c = map.get(&3).unwrap().sample(0.5, 0.5, 0.0);
        assert_eq!((c.x(), c.y(), c.z(), c.w()), (1.0, 1.0, 1.0, 1.0));
    }
}
