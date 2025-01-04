// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageTestsUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported on demand: the image type enum and the helpers that name or
// size one. The `Image`/`SparseImage` wrappers are `vk::ImageWithMemory` here, the format helpers already live in
// `vk::image_util`, and the GLSL type names a test needs come from the manifests.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::texture::{TextureChannelClass, map_vk_format};

/// `ImageType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ImageType {
    OneD,
    OneDArray,
    TwoD,
    TwoDArray,
    ThreeD,
    Cube,
    CubeArray,
    Buffer,
}

/// `mapImageType`
pub fn map_image_type(image_type: ImageType) -> vk::ImageType {
    match image_type {
        ImageType::OneD | ImageType::OneDArray | ImageType::Buffer => vk::ImageType::_1D,
        ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => vk::ImageType::_2D,
        ImageType::ThreeD => vk::ImageType::_3D,
    }
}

/// `mapImageViewType`. There is no view type for a buffer; upstream asserts.
pub fn map_image_view_type(image_type: ImageType) -> Option<vk::ImageViewType> {
    match image_type {
        ImageType::OneD => Some(vk::ImageViewType::_1D),
        ImageType::OneDArray => Some(vk::ImageViewType::_1D_ARRAY),
        ImageType::TwoD => Some(vk::ImageViewType::_2D),
        ImageType::TwoDArray => Some(vk::ImageViewType::_2D_ARRAY),
        ImageType::ThreeD => Some(vk::ImageViewType::_3D),
        ImageType::Cube => Some(vk::ImageViewType::CUBE),
        ImageType::CubeArray => Some(vk::ImageViewType::CUBE_ARRAY),
        ImageType::Buffer => None,
    }
}

/// `getImageTypeName`
pub fn get_image_type_name(image_type: ImageType) -> &'static str {
    match image_type {
        ImageType::OneD => "1d",
        ImageType::OneDArray => "1d_array",
        ImageType::TwoD => "2d",
        ImageType::TwoDArray => "2d_array",
        ImageType::ThreeD => "3d",
        ImageType::Cube => "cube",
        ImageType::CubeArray => "cube_array",
        ImageType::Buffer => "buffer",
    }
}

/// `getFormatPrefix`, for a format that has a texture format.
pub fn get_format_prefix(format: vk::Format) -> &'static str {
    let image64 = format == vk::Format::R64_UINT || format == vk::Format::R64_SINT;
    match map_vk_format(format).map(|f| f.channel_class()) {
        Some(TextureChannelClass::UnsignedInteger) => {
            if image64 {
                "u64"
            } else {
                "u"
            }
        }
        Some(TextureChannelClass::SignedInteger) => {
            if image64 {
                "i64"
            } else {
                "i"
            }
        }
        _ => "",
    }
}

/// `getShaderImageType` - `uimage2DArray`, `imageCube`, `iimage2DMS`, ...
pub fn get_shader_image_type(format: vk::Format, image_type: ImageType, multisample: bool) -> String {
    let format_part = get_format_prefix(format);

    let image_type_part = if multisample {
        match image_type {
            ImageType::TwoD => "2DMS",
            ImageType::TwoDArray => "2DMSArray",
            _ => "",
        }
    } else {
        match image_type {
            ImageType::OneD => "1D",
            ImageType::OneDArray => "1DArray",
            ImageType::TwoD => "2D",
            ImageType::TwoDArray => "2DArray",
            ImageType::ThreeD => "3D",
            ImageType::Cube => "Cube",
            ImageType::CubeArray => "CubeArray",
            ImageType::Buffer => "Buffer",
        }
    };

    format!("{format_part}image{image_type_part}")
}

/// `getShaderGridSize` - size used for addressing an image in a shader
pub fn get_shader_grid_size(image_type: ImageType, image_size: [u32; 3]) -> [u32; 3] {
    match image_type {
        ImageType::OneD | ImageType::Buffer => [image_size[0], 1, 1],
        ImageType::OneDArray => [image_size[0], image_size[2], 1],
        ImageType::TwoD => [image_size[0], image_size[1], 1],
        ImageType::TwoDArray | ImageType::ThreeD => image_size,
        ImageType::Cube => [image_size[0], image_size[1], 6],
        ImageType::CubeArray => [image_size[0], image_size[1], 6 * image_size[2]],
    }
}

/// `getLayerSize` - size of a single layer
pub fn get_layer_size(image_type: ImageType, image_size: [u32; 3]) -> [u32; 3] {
    match image_type {
        ImageType::OneD | ImageType::OneDArray | ImageType::Buffer => [image_size[0], 1, 1],
        ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => {
            [image_size[0], image_size[1], 1]
        }
        ImageType::ThreeD => image_size,
    }
}

/// `getNumLayers` - number of array layers (for array and cube types)
pub fn get_num_layers(image_type: ImageType, image_size: [u32; 3]) -> u32 {
    match image_type {
        ImageType::OneD | ImageType::TwoD | ImageType::ThreeD | ImageType::Buffer => 1,
        ImageType::OneDArray | ImageType::TwoDArray => image_size[2],
        ImageType::Cube => 6,
        ImageType::CubeArray => image_size[2] * 6,
    }
}

/// `getNumPixels` - number of texels in an image
pub fn get_num_pixels(image_type: ImageType, image_size: [u32; 3]) -> u32 {
    let grid_size = get_shader_grid_size(image_type, image_size);
    grid_size[0] * grid_size[1] * grid_size[2]
}

/// `getDimensions` - coordinate dimension used for addressing (e.g. 3 (x,y,z) for 2d array)
pub fn get_dimensions(image_type: ImageType) -> u32 {
    match image_type {
        ImageType::OneD | ImageType::Buffer => 1,
        ImageType::OneDArray | ImageType::TwoD => 2,
        ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray | ImageType::ThreeD => 3,
    }
}

/// `getLayerDimensions` - coordinate dimension used for addressing a single layer (e.g. 2 (x,y) for 2d array)
pub fn get_layer_dimensions(image_type: ImageType) -> u32 {
    match image_type {
        ImageType::OneD | ImageType::Buffer | ImageType::OneDArray => 1,
        ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => 2,
        ImageType::ThreeD => 3,
    }
}

/// `getImageSizeBytes`
pub fn get_image_size_bytes(image_size: [i32; 3], format: vk::Format) -> Option<vk::DeviceSize> {
    let pixel_size = map_vk_format(format)?.pixel_size()?;
    Some(
        vk::DeviceSize::from(pixel_size)
            * (image_size[0] as vk::DeviceSize)
            * (image_size[1] as vk::DeviceSize)
            * (image_size[2] as vk::DeviceSize),
    )
}
