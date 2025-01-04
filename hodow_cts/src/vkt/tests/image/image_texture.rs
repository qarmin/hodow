// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageTexture.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::tests_util::ImageType;

/// `minify`
fn minify(value: i32, mipmap_level: i32) -> i32 {
    (value >> mipmap_level).max(1)
}

/// `Texture` - texture buffer/image abstraction. Helps managing size, number of layers and number of mipmap levels.
#[derive(Clone, Copy, Debug)]
pub struct Texture {
    layer_size: [i32; 3],
    type_: ImageType,
    num_layers: i32,
    num_samples: i32,
    num_mipmap_levels: i32,
}

impl Texture {
    pub fn new(image_type: ImageType, image_layer_size: [i32; 3], layers: i32, samples: i32, levels: i32) -> Self {
        let texture = Self {
            layer_size: image_layer_size,
            type_: image_type,
            num_layers: layers,
            num_samples: samples,
            num_mipmap_levels: levels,
        };
        texture.check_invariants();
        texture
    }

    /// `Texture(imageType, imageLayerSize, layers)` - one sample, one level.
    pub fn simple(image_type: ImageType, image_layer_size: [i32; 3], layers: i32) -> Self {
        Self::new(image_type, image_layer_size, layers, 1, 1)
    }

    /// `Texture(other, samples)`
    pub fn with_samples(other: &Texture, samples: i32) -> Self {
        Self::new(
            other.type_,
            other.layer_size,
            other.num_layers,
            samples,
            other.num_mipmap_levels,
        )
    }

    fn check_invariants(&self) {
        debug_assert!(matches!(self.num_samples, 1 | 2 | 4 | 8 | 16 | 32 | 64));
        debug_assert!(self.num_layers >= 1);
        debug_assert!(self.layer_size.iter().all(|&v| v >= 1));

        match self.type_ {
            ImageType::OneD | ImageType::Buffer => {
                debug_assert!(self.num_layers == 1);
                debug_assert!(self.num_samples == 1);
                debug_assert!(self.layer_size[1] == 1 && self.layer_size[2] == 1);
            }
            ImageType::OneDArray => {
                debug_assert!(self.num_samples == 1);
                debug_assert!(self.layer_size[1] == 1 && self.layer_size[2] == 1);
            }
            ImageType::TwoD => {
                debug_assert!(self.num_layers == 1);
                debug_assert!(self.layer_size[2] == 1);
            }
            ImageType::TwoDArray => {
                debug_assert!(self.layer_size[2] == 1);
            }
            ImageType::Cube => {
                debug_assert!(self.num_samples == 1);
                debug_assert!(self.num_layers == 6);
                debug_assert!(self.layer_size[2] == 1);
            }
            ImageType::CubeArray => {
                debug_assert!(self.num_samples == 1);
                debug_assert!(self.num_layers >= 6 && self.num_layers % 6 == 0);
                debug_assert!(self.layer_size[2] == 1);
            }
            ImageType::ThreeD => {
                debug_assert!(self.num_samples == 1);
                debug_assert!(self.num_layers == 1);
            }
        }
    }

    /// Texture type
    pub fn type_(&self) -> ImageType {
        self.type_
    }

    /// Size of a single layer for the mipmap level
    pub fn layer_size(&self, mipmap_level: i32) -> [i32; 3] {
        let mut size = self.layer_size;

        debug_assert!(mipmap_level < self.num_mipmap_levels);

        if mipmap_level == 0 {
            return size;
        }

        match self.type_ {
            ImageType::ThreeD => {
                size[2] = minify(size[2], mipmap_level);
                size[1] = minify(size[1], mipmap_level);
                size[0] = minify(size[0], mipmap_level);
            }
            ImageType::Cube | ImageType::CubeArray | ImageType::TwoDArray | ImageType::TwoD => {
                size[1] = minify(size[1], mipmap_level);
                size[0] = minify(size[0], mipmap_level);
            }
            ImageType::OneDArray | ImageType::OneD => {
                size[0] = minify(size[0], mipmap_level);
            }
            ImageType::Buffer => {}
        }
        size
    }

    /// Number of array layers (for array and cube types)
    pub fn num_layers(&self) -> i32 {
        self.num_layers
    }

    /// Number of samples per texel (multisampled texture)
    pub fn num_samples(&self) -> i32 {
        self.num_samples
    }

    /// Size including number of layers in additional dimension (e.g. z in 2d texture) for the mipmap level
    pub fn size(&self, mipmap_level: i32) -> [i32; 3] {
        // texture.size() includes number of layers in one component. Minify only the relevant component for the mipmap level.
        let size = self.layer_size(mipmap_level);

        match self.type_ {
            ImageType::OneD | ImageType::Buffer | ImageType::TwoD | ImageType::ThreeD => size,
            ImageType::OneDArray => [size[0], self.num_layers, 1],
            ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => [size[0], size[1], self.num_layers],
        }
    }

    /// Coordinate dimension used for addressing (e.g. 3 (x,y,z) for 2d array)
    pub fn dimension(&self) -> i32 {
        match self.type_ {
            ImageType::OneD | ImageType::Buffer => 1,
            ImageType::OneDArray | ImageType::TwoD => 2,
            ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray | ImageType::ThreeD => 3,
        }
    }

    /// Coordinate dimension used for addressing a single layer (e.g. 2 (x,y) for 2d array)
    pub fn layer_dimension(&self) -> i32 {
        match self.type_ {
            ImageType::OneD | ImageType::Buffer | ImageType::OneDArray => 1,
            ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => 2,
            ImageType::ThreeD => 3,
        }
    }

    /// Number of levels of detail (mipmap texture)
    pub fn num_mipmap_levels(&self) -> i32 {
        self.num_mipmap_levels
    }

    /// `isCube`
    pub fn is_cube(&self) -> bool {
        self.type_ == ImageType::Cube || self.type_ == ImageType::CubeArray
    }
}
