// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesTestsUtil.cpp / .hpp
//   external/vulkancts/framework/vulkan/vkImageUtil.cpp (getMipmapCount, getImageSizeAlignment, getPlaneExtent, getPlaneSizeInBytes)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `tcu::TextureFormat` and `PlanarFormatDescription` overloads upstream carries
// side by side are one function here, keyed on the `vk::Format`; the device-group arguments of the submit helpers are dropped.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::format_tables::FormatInfo;
use crate::vkt::tests::ycbcr::util::format_description;

/// `NO_MATCH_FOUND`
pub const NO_MATCH_FOUND: u32 = u32::MAX;

/// `BUFFER_IMAGE_COPY_OFFSET_GRANULARITY`
pub const BUFFER_IMAGE_COPY_OFFSET_GRANULARITY: u32 = 4;

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

/// `FeatureFlagBits`
pub const FEATURE_TESSELLATION_SHADER: u32 = 1 << 0;
pub const FEATURE_GEOMETRY_SHADER: u32 = 1 << 1;
pub const FEATURE_SHADER_FLOAT_64: u32 = 1 << 2;
pub const FEATURE_VERTEX_PIPELINE_STORES_AND_ATOMICS: u32 = 1 << 3;
pub const FEATURE_FRAGMENT_STORES_AND_ATOMICS: u32 = 1 << 4;
pub const FEATURE_SHADER_TESSELLATION_AND_GEOMETRY_POINT_SIZE: u32 = 1 << 5;

/// `TestImageParameters`
pub struct TestImageParameters {
    pub image_type: ImageType,
    pub image_sizes: Vec<[u32; 3]>,
    pub formats: Vec<vk::Format>,
}

impl TestImageParameters {
    pub fn new(image_type: ImageType, image_sizes: Vec<[u32; 3]>, formats: Vec<vk::Format>) -> Self {
        Self {
            image_type,
            image_sizes,
            formats,
        }
    }
}

/// `formatIsR64`
pub fn format_is_r64(format: vk::Format) -> bool {
    matches!(format, vk::Format::R64_SINT | vk::Format::R64_UINT)
}

/// `getTestFormats`
pub fn get_test_formats(image_type: ImageType) -> Vec<vk::Format> {
    use vk::Format as F;
    let mut results = vec![
        F::R64_SINT,
        F::R32_SINT,
        F::R16_SINT,
        F::R8_SINT,
        F::R64_UINT,
        F::R32_UINT,
        F::R16_UINT,
        F::R8_UINT,
        F::R16_UNORM,
        F::R8_UNORM,
        F::R16_SNORM,
        F::R8_SNORM,
        F::R32G32_SINT,
        F::R16G16_SINT,
        F::R8G8_SINT,
        F::R32G32_UINT,
        F::R16G16_UINT,
        F::R8G8_UINT,
        F::R16G16_UNORM,
        F::R8G8_UNORM,
        F::R16G16_SNORM,
        F::R8G8_SNORM,
        F::R32G32B32A32_SINT,
        F::R16G16B16A16_SINT,
        F::R8G8B8A8_SINT,
        F::R32G32B32A32_UINT,
        F::R16G16B16A16_UINT,
        F::R8G8B8A8_UINT,
        F::R16G16B16A16_UNORM,
        F::R8G8B8A8_UNORM,
        F::R16G16B16A16_SNORM,
        F::R8G8B8A8_SNORM,
    ];

    if image_type == ImageType::TwoD || image_type == ImageType::TwoDArray {
        results.extend([
            F::G8B8G8R8_422_UNORM,
            F::B8G8R8G8_422_UNORM,
            F::G8_B8_R8_3PLANE_420_UNORM,
            F::G8_B8R8_2PLANE_420_UNORM,
            F::G8_B8_R8_3PLANE_422_UNORM,
            F::G8_B8R8_2PLANE_422_UNORM,
            F::G8_B8_R8_3PLANE_444_UNORM,
            F::R10X6_UNORM_PACK16,
            F::R10X6G10X6_UNORM_2PACK16,
            F::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
            F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16,
            F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16,
            F::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
            F::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
            F::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16,
            F::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16,
            F::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16,
            F::R12X4_UNORM_PACK16,
            F::R12X4G12X4_UNORM_2PACK16,
            F::R12X4G12X4B12X4A12X4_UNORM_4PACK16,
            F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16,
            F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16,
            F::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
            F::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
            F::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16,
            F::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16,
            F::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16,
            F::G16B16G16R16_422_UNORM,
            F::B16G16R16G16_422_UNORM,
            F::G16_B16_R16_3PLANE_420_UNORM,
            F::G16_B16R16_2PLANE_420_UNORM,
            F::G16_B16_R16_3PLANE_422_UNORM,
            F::G16_B16R16_2PLANE_422_UNORM,
            F::G16_B16_R16_3PLANE_444_UNORM,
            F::G8_B8R8_2PLANE_444_UNORM,
            F::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16,
            F::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16,
            F::G16_B16R16_2PLANE_444_UNORM,
        ]);
    }

    results
}

/// `getShaderGridSize`
pub fn get_shader_grid_size(image_type: ImageType, image_size: [u32; 3], mip_level: u32) -> [u32; 3] {
    let mip_level_x = (image_size[0] >> mip_level).max(1);
    let mip_level_y = (image_size[1] >> mip_level).max(1);
    let mip_level_z = (image_size[2] >> mip_level).max(1);

    match image_type {
        ImageType::OneD => [mip_level_x, 1, 1],
        ImageType::Buffer => [image_size[0], 1, 1],
        ImageType::OneDArray => [mip_level_x, image_size[2], 1],
        ImageType::TwoD => [mip_level_x, mip_level_y, 1],
        ImageType::TwoDArray => [mip_level_x, mip_level_y, image_size[2]],
        ImageType::ThreeD => [mip_level_x, mip_level_y, mip_level_z],
        ImageType::Cube => [mip_level_x, mip_level_y, 6],
        ImageType::CubeArray => [mip_level_x, mip_level_y, 6 * image_size[2]],
    }
}

/// `getLayerSize`
pub fn get_layer_size(image_type: ImageType, image_size: [u32; 3]) -> [u32; 3] {
    match image_type {
        ImageType::OneD | ImageType::OneDArray | ImageType::Buffer => [image_size[0], 1, 1],
        ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => {
            [image_size[0], image_size[1], 1]
        }
        ImageType::ThreeD => [image_size[0], image_size[1], image_size[2]],
    }
}

/// `getNumLayers`
pub fn get_num_layers(image_type: ImageType, image_size: [u32; 3]) -> u32 {
    match image_type {
        ImageType::OneD | ImageType::TwoD | ImageType::ThreeD | ImageType::Buffer => 1,
        ImageType::OneDArray | ImageType::TwoDArray => image_size[2],
        ImageType::Cube => 6,
        ImageType::CubeArray => image_size[2] * 6,
    }
}

/// `getNumPixels`
pub fn get_num_pixels(image_type: ImageType, image_size: [u32; 3]) -> u32 {
    let grid_size = get_shader_grid_size(image_type, image_size, 0);
    grid_size[0] * grid_size[1] * grid_size[2]
}

/// `getDimensions`
pub fn get_dimensions(image_type: ImageType) -> u32 {
    match image_type {
        ImageType::OneD | ImageType::Buffer => 1,
        ImageType::OneDArray | ImageType::TwoD => 2,
        ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray | ImageType::ThreeD => 3,
    }
}

/// `getLayerDimensions`
pub fn get_layer_dimensions(image_type: ImageType) -> u32 {
    match image_type {
        ImageType::OneD | ImageType::Buffer | ImageType::OneDArray => 1,
        ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => 2,
        ImageType::ThreeD => 3,
    }
}

/// `isImageSizeSupported`
pub fn is_image_size_supported(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    image_type: ImageType,
    image_size: [u32; 3],
) -> bool {
    let limits = unsafe { instance.get_physical_device_properties(physical_device) }.limits;

    match image_type {
        ImageType::OneD => image_size[0] <= limits.max_image_dimension_1d,
        ImageType::OneDArray => {
            image_size[0] <= limits.max_image_dimension_1d && image_size[2] <= limits.max_image_array_layers
        }
        ImageType::TwoD => {
            image_size[0] <= limits.max_image_dimension_2d && image_size[1] <= limits.max_image_dimension_2d
        }
        ImageType::TwoDArray => {
            image_size[0] <= limits.max_image_dimension_2d
                && image_size[1] <= limits.max_image_dimension_2d
                && image_size[2] <= limits.max_image_array_layers
        }
        ImageType::Cube => {
            image_size[0] <= limits.max_image_dimension_cube && image_size[1] <= limits.max_image_dimension_cube
        }
        ImageType::CubeArray => {
            image_size[0] <= limits.max_image_dimension_cube
                && image_size[1] <= limits.max_image_dimension_cube
                && image_size[2] <= limits.max_image_array_layers
        }
        ImageType::ThreeD => {
            image_size[0] <= limits.max_image_dimension_3d
                && image_size[1] <= limits.max_image_dimension_3d
                && image_size[2] <= limits.max_image_dimension_3d
        }
        ImageType::Buffer => true,
    }
}

/// `makeBufferImageCopy`
pub fn make_buffer_image_copy(
    extent: vk::Extent3D,
    layer_count: u32,
    mipmap_level: u32,
    buffer_offset: vk::DeviceSize,
) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: mipmap_level,
            base_array_layer: 0,
            layer_count,
        },
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent,
    }
}

/// `submitCommands`, without the device group arguments.
pub fn submit_commands(
    device: &Device,
    queue: vk::Queue,
    command_buffer: vk::CommandBuffer,
    wait_semaphores: &[vk::Semaphore],
    wait_dst_stage_mask: &[vk::PipelineStageFlags],
    signal_semaphores: &[vk::Semaphore],
) -> Result<(), TestError> {
    let command_buffers = [command_buffer];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(wait_semaphores)
        .wait_dst_stage_mask(wait_dst_stage_mask)
        .command_buffers(&command_buffers)
        .signal_semaphores(signal_semaphores);
    unsafe { device.queue_submit(queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")
}

/// `submitCommandsAndWait`, without the device group arguments.
pub fn submit_commands_and_wait(
    device: &Device,
    queue: vk::Queue,
    command_buffer: vk::CommandBuffer,
    wait_semaphores: &[vk::Semaphore],
    wait_dst_stage_mask: &[vk::PipelineStageFlags],
    signal_semaphores: &[vk::Semaphore],
) -> Result<(), TestError> {
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let command_buffers = [command_buffer];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(wait_semaphores)
        .wait_dst_stage_mask(wait_dst_stage_mask)
        .command_buffers(&command_buffers)
        .signal_semaphores(signal_semaphores);
    unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

/// `mapImageType`
pub fn map_image_type(image_type: ImageType) -> vk::ImageType {
    match image_type {
        ImageType::OneD | ImageType::OneDArray | ImageType::Buffer => vk::ImageType::_1D,
        ImageType::TwoD | ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => vk::ImageType::_2D,
        ImageType::ThreeD => vk::ImageType::_3D,
    }
}

/// `mapImageViewType`; a buffer has no view type, upstream asserts.
pub fn map_image_view_type(image_type: ImageType) -> vk::ImageViewType {
    match image_type {
        ImageType::OneD => vk::ImageViewType::_1D,
        ImageType::OneDArray => vk::ImageViewType::_1D_ARRAY,
        ImageType::TwoD => vk::ImageViewType::_2D,
        ImageType::TwoDArray => vk::ImageViewType::_2D_ARRAY,
        ImageType::ThreeD => vk::ImageViewType::_3D,
        ImageType::Cube => vk::ImageViewType::CUBE,
        ImageType::CubeArray => vk::ImageViewType::CUBE_ARRAY,
        ImageType::Buffer => panic!("a buffer has no image view type"),
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

/// The channel class `getTextureChannelClass(mapVkFormat(format).type)` gives, or what `PlanarFormatDescription::channels[0].type`
/// holds for a format `mapVkFormat` has no entry for (the YCbCr ones and the 64-bit integer ones).
fn channel_class(format: vk::Format) -> TextureChannelClass {
    match format {
        vk::Format::R64_SINT | vk::Format::R64G64B64A64_SINT => TextureChannelClass::SignedInteger,
        vk::Format::R64_UINT | vk::Format::R64G64B64A64_UINT => TextureChannelClass::UnsignedInteger,
        _ => map_vk_format(format).map_or(TextureChannelClass::UnsignedFixedPoint, |f| f.channel_class()),
    }
}

/// `getShaderImageType`
pub fn get_shader_image_type(format: vk::Format, image_type: ImageType) -> String {
    let mut format_part = match channel_class(format) {
        TextureChannelClass::SignedInteger => "i".to_string(),
        TextureChannelClass::UnsignedInteger => "u".to_string(),
        _ => String::new(),
    };

    if format_is_r64(format) {
        format_part += "64";
    }

    let image_type_part = match image_type {
        ImageType::OneD => "1D",
        ImageType::OneDArray => "1DArray",
        ImageType::TwoD => "2D",
        ImageType::TwoDArray => "2DArray",
        ImageType::ThreeD => "3D",
        ImageType::Cube => "Cube",
        ImageType::CubeArray => "CubeArray",
        ImageType::Buffer => "Buffer",
    };

    format!("{format_part}image{image_type_part}")
}

/// `getShaderImageDataType`
pub fn get_shader_image_data_type(format: vk::Format) -> &'static str {
    match channel_class(format) {
        TextureChannelClass::UnsignedInteger => {
            if format_is_r64(format) {
                "u64vec4"
            } else {
                "uvec4"
            }
        }
        TextureChannelClass::SignedInteger => {
            if format_is_r64(format) {
                "i64vec4"
            } else {
                "ivec4"
            }
        }
        _ => "vec4",
    }
}

/// `getShaderImageFormatQualifier(VkFormat)`
pub fn get_shader_image_format_qualifier(format: vk::Format) -> &'static str {
    use vk::Format as F;
    match format {
        F::R8_SINT => "r8i",
        F::R16_SINT => "r16i",
        F::R32_SINT => "r32i",
        F::R64_SINT => "r64i",
        F::R8_UINT => "r8ui",
        F::R16_UINT => "r16ui",
        F::R32_UINT => "r32ui",
        F::R64_UINT => "r64ui",
        F::R8_SNORM => "r8_snorm",
        F::R16_SNORM => "r16_snorm",
        F::R8_UNORM => "r8",
        F::R16_UNORM => "r16",

        F::R8G8_SINT => "rg8i",
        F::R16G16_SINT => "rg16i",
        F::R32G32_SINT => "rg32i",
        F::R8G8_UINT => "rg8ui",
        F::R16G16_UINT => "rg16ui",
        F::R32G32_UINT => "rg32ui",
        F::R8G8_SNORM => "rg8_snorm",
        F::R16G16_SNORM => "rg16_snorm",
        F::R8G8_UNORM => "rg8",
        F::R16G16_UNORM => "rg16",

        F::R8G8B8A8_SINT => "rgba8i",
        F::R16G16B16A16_SINT => "rgba16i",
        F::R32G32B32A32_SINT => "rgba32i",
        F::R8G8B8A8_UINT => "rgba8ui",
        F::R16G16B16A16_UINT => "rgba16ui",
        F::R32G32B32A32_UINT => "rgba32ui",
        F::R8G8B8A8_SNORM => "rgba8_snorm",
        F::R16G16B16A16_SNORM => "rgba16_snorm",
        F::R8G8B8A8_UNORM => "rgba8",
        F::R16G16B16A16_UNORM => "rgba16",

        F::G8B8G8R8_422_UNORM
        | F::B8G8R8G8_422_UNORM
        | F::G8_B8_R8_3PLANE_420_UNORM
        | F::G8_B8R8_2PLANE_420_UNORM
        | F::G8_B8_R8_3PLANE_422_UNORM
        | F::G8_B8R8_2PLANE_422_UNORM
        | F::G8_B8_R8_3PLANE_444_UNORM
        | F::G8_B8R8_2PLANE_444_UNORM => "rgba8",
        F::R10X6_UNORM_PACK16 | F::R12X4_UNORM_PACK16 => "r16",
        F::R10X6G10X6_UNORM_2PACK16 | F::R12X4G12X4_UNORM_2PACK16 => "rg16",
        F::R10X6G10X6B10X6A10X6_UNORM_4PACK16
        | F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
        | F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
        | F::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16
        | F::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16
        | F::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16
        | F::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16
        | F::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16
        | F::R12X4G12X4B12X4A12X4_UNORM_4PACK16
        | F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
        | F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
        | F::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16
        | F::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16
        | F::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16
        | F::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16
        | F::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16
        | F::G16B16G16R16_422_UNORM
        | F::B16G16R16G16_422_UNORM
        | F::G16_B16_R16_3PLANE_420_UNORM
        | F::G16_B16R16_2PLANE_420_UNORM
        | F::G16_B16_R16_3PLANE_422_UNORM
        | F::G16_B16R16_2PLANE_422_UNORM
        | F::G16_B16_R16_3PLANE_444_UNORM
        | F::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16
        | F::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16
        | F::G16_B16R16_2PLANE_444_UNORM => "rgba16",

        _ => panic!("Unexpected texture format {format:?}"),
    }
}

/// `getImageFormatID`
pub fn get_image_format_id(format: vk::Format) -> String {
    use vk::Format as F;
    let short = match format {
        F::R8_SINT => "r8i",
        F::R16_SINT => "r16i",
        F::R32_SINT => "r32i",
        F::R64_SINT => "r64i",
        F::R8_UINT => "r8ui",
        F::R16_UINT => "r16ui",
        F::R32_UINT => "r32ui",
        F::R64_UINT => "r64ui",
        F::R8_SNORM => "r8_snorm",
        F::R16_SNORM => "r16_snorm",
        F::R8_UNORM => "r8",
        F::R16_UNORM => "r16",
        F::R32_SFLOAT => "r32f",

        F::R8G8_SINT => "rg8i",
        F::R16G16_SINT => "rg16i",
        F::R32G32_SINT => "rg32i",
        F::R8G8_UINT => "rg8ui",
        F::R16G16_UINT => "rg16ui",
        F::R32G32_UINT => "rg32ui",
        F::R8G8_SNORM => "rg8_snorm",
        F::R16G16_SNORM => "rg16_snorm",
        F::R8G8_UNORM => "rg8",
        F::R16G16_UNORM => "rg16",

        F::R8G8B8A8_SINT => "rgba8i",
        F::R16G16B16A16_SINT => "rgba16i",
        F::R32G32B32A32_SINT => "rgba32i",
        F::R8G8B8A8_UINT => "rgba8ui",
        F::R16G16B16A16_UINT => "rgba16ui",
        F::R32G32B32A32_UINT => "rgba32ui",
        F::R8G8B8A8_SNORM => "rgba8_snorm",
        F::R16G16B16A16_SNORM => "rgba16_snorm",
        F::R8G8B8A8_UNORM => "rgba8",
        F::R16G16B16A16_UNORM => "rgba16",
        F::R16G16B16A16_SFLOAT => "rgba16f",
        F::R32G32B32A32_SFLOAT => "rgba32f",
        F::R64G64B64A64_SINT => "rgba64i",
        F::R64G64B64A64_UINT => "rgba64ui",
        // The YCbCr, A8, BC, ETC2, EAC and ASTC formats are named after the enumerant.
        _ => return format!("{format:?}").to_lowercase(),
    };
    short.to_string()
}

/// `getShaderImageCoordinates`
pub fn get_shader_image_coordinates(image_type: ImageType, x: &str, xy: &str, xyz: &str) -> String {
    match image_type {
        ImageType::OneD | ImageType::Buffer => x.to_string(),
        ImageType::OneDArray | ImageType::TwoD => xy.to_string(),
        ImageType::TwoDArray | ImageType::ThreeD | ImageType::Cube | ImageType::CubeArray => xyz.to_string(),
    }
}

/// `mipLevelExtents`
pub fn mip_level_extents(base_extents: vk::Extent3D, mip_level: u32) -> vk::Extent3D {
    vk::Extent3D {
        width: (base_extents.width >> mip_level).max(1),
        height: (base_extents.height >> mip_level).max(1),
        depth: (base_extents.depth >> mip_level).max(1),
    }
}

/// `alignedDivide`
pub fn aligned_divide(extent: vk::Extent3D, divisor: vk::Extent3D) -> [u32; 3] {
    [
        extent.width.div_ceil(divisor.width),
        extent.height.div_ceil(divisor.height),
        extent.depth.div_ceil(divisor.depth),
    ]
}

/// `getImageSizeAlignment`
pub fn get_image_size_alignment(format: vk::Format) -> [u32; 3] {
    let info = format_description(format);
    let mut alignment = [info.block_width, info.block_height, 1];
    for plane in info.planes {
        alignment[0] = alignment[0].max(plane.width_divisor);
        alignment[1] = alignment[1].max(plane.height_divisor);
    }
    alignment
}

/// `isYCbCrFormat` for the formats the sparse tests name: every one with a plane table entry that is not a plain single-plane format.
fn is_ycbcr_format(format: vk::Format) -> bool {
    crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format(format)
}

/// `getMipmapCount`
pub fn get_mipmap_count(
    format: vk::Format,
    image_format_properties: &vk::ImageFormatProperties,
    extent: vk::Extent3D,
) -> u32 {
    if is_ycbcr_format(format) {
        return 1;
    }
    let image_alignment = get_image_size_alignment(format);
    let mut mipmap_edge = extent.width.max(extent.height).max(extent.depth);
    if image_alignment[0] > 1 {
        mipmap_edge = mipmap_edge.min(extent.width / image_alignment[0]);
    }
    if image_alignment[1] > 1 {
        mipmap_edge = mipmap_edge.min(extent.height / image_alignment[1]);
    }
    if image_alignment[2] > 1 {
        mipmap_edge = mipmap_edge.min(extent.depth / image_alignment[2]);
    }
    ((mipmap_edge as f32).log2() as u32 + 1).min(image_format_properties.max_mip_levels)
}

/// `getPlaneExtent`
pub fn get_plane_extent(
    info: &FormatInfo,
    base_extents: vk::Extent3D,
    plane_ndx: usize,
    mipmap_level: u32,
) -> vk::Extent3D {
    let plane = &info.planes[plane_ndx];
    let mip0_extents = vk::Extent3D {
        width: base_extents.width / plane.width_divisor,
        height: base_extents.height / plane.height_divisor,
        depth: base_extents.depth,
    };
    mip_level_extents(mip0_extents, mipmap_level)
}

/// `deAlign32`
fn de_align32(value: u32, align: u32) -> u32 {
    value.div_ceil(align) * align
}

/// `getPlaneSizeInBytes`
pub fn get_plane_size_in_bytes(
    info: &FormatInfo,
    base_extents: vk::Extent3D,
    plane_ndx: usize,
    mipmap_level: u32,
    mipmap_memory_alignment: u32,
) -> u32 {
    let mut image_extent = get_plane_extent(info, base_extents, plane_ndx, mipmap_level);
    image_extent.width /= info.block_width;
    image_extent.height /= info.block_height;
    de_align32(
        info.planes[plane_ndx].element_size * image_extent.width * image_extent.height * image_extent.depth,
        mipmap_memory_alignment,
    )
}

/// `getImageMipLevelSizeInBytes` for a plane of a (possibly planar) format.
pub fn get_image_mip_level_size_in_bytes(
    base_extents: vk::Extent3D,
    layers_count: u32,
    format: vk::Format,
    plane_ndx: usize,
    mipmap_level: u32,
    mipmap_memory_alignment: u32,
) -> u32 {
    layers_count
        * get_plane_size_in_bytes(
            &format_description(format),
            base_extents,
            plane_ndx,
            mipmap_level,
            mipmap_memory_alignment,
        )
}

/// `getImageSizeInBytes` for a plane of a (possibly planar) format.
pub fn get_image_size_in_bytes(
    base_extents: vk::Extent3D,
    layers_count: u32,
    format: vk::Format,
    plane_ndx: usize,
    mipmap_levels_count: u32,
    mipmap_memory_alignment: u32,
) -> u32 {
    (0..mipmap_levels_count)
        .map(|mipmap_level| {
            get_image_mip_level_size_in_bytes(
                base_extents,
                layers_count,
                format,
                plane_ndx,
                mipmap_level,
                mipmap_memory_alignment,
            )
        })
        .sum()
}

/// `getImageMipLevelSizeInBytes` for a plain format whose texel is `pixel_size` bytes (the `tcu::TextureFormat` overload).
pub fn get_image_mip_level_size_in_bytes_plain(
    base_extents: vk::Extent3D,
    layers_count: u32,
    pixel_size: u32,
    mipmap_level: u32,
    mipmap_memory_alignment: u32,
) -> u32 {
    let extents = mip_level_extents(base_extents, mipmap_level);
    de_align32(
        extents.width * extents.height * extents.depth * layers_count * pixel_size,
        mipmap_memory_alignment,
    )
}

/// `getImageSizeInBytes` for a plain format whose texel is `pixel_size` bytes (the `tcu::TextureFormat` overload).
pub fn get_image_size_in_bytes_plain(
    base_extents: vk::Extent3D,
    layers_count: u32,
    pixel_size: u32,
    mipmap_levels_count: u32,
    mipmap_memory_alignment: u32,
) -> u32 {
    (0..mipmap_levels_count)
        .map(|mipmap_level| {
            get_image_mip_level_size_in_bytes_plain(
                base_extents,
                layers_count,
                pixel_size,
                mipmap_level,
                mipmap_memory_alignment,
            )
        })
        .sum()
}

/// `makeSparseImageMemoryBind`; the memory is allocated here and owned by the caller.
pub fn make_sparse_image_memory_bind(
    device: &Device,
    allocation_size: vk::DeviceSize,
    memory_type: u32,
    subresource: vk::ImageSubresource,
    offset: vk::Offset3D,
    extent: vk::Extent3D,
) -> Result<vk::SparseImageMemoryBind, TestError> {
    let alloc_info = vk::MemoryAllocateInfo::builder()
        .allocation_size(allocation_size)
        .memory_type_index(memory_type);
    let device_memory = unsafe { device.allocate_memory(&alloc_info, None) }.vk_check("vkAllocateMemory")?;

    Ok(vk::SparseImageMemoryBind {
        subresource,
        offset,
        extent,
        memory: device_memory,
        memory_offset: 0,
        flags: vk::SparseMemoryBindFlags::empty(),
    })
}

/// `makeSparseMemoryBind`; the memory is allocated here and owned by the caller.
pub fn make_sparse_memory_bind(
    device: &Device,
    allocation_size: vk::DeviceSize,
    memory_type: u32,
    resource_offset: vk::DeviceSize,
    flags: vk::SparseMemoryBindFlags,
) -> Result<vk::SparseMemoryBind, TestError> {
    let alloc_info = vk::MemoryAllocateInfo::builder()
        .allocation_size(allocation_size)
        .memory_type_index(memory_type);
    let device_memory = unsafe { device.allocate_memory(&alloc_info, None) }.vk_check("vkAllocateMemory")?;

    Ok(vk::SparseMemoryBind {
        resource_offset,
        size: allocation_size,
        memory: device_memory,
        memory_offset: 0,
        flags,
    })
}

/// `requireFeatures`
pub fn require_features(instance: &Instance, physical_device: vk::PhysicalDevice, flags: u32) -> Result<(), TestError> {
    let features = unsafe { instance.get_physical_device_features(physical_device) };

    if flags & FEATURE_TESSELLATION_SHADER != 0 && features.tessellation_shader == vk::FALSE {
        return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
    }
    if flags & FEATURE_GEOMETRY_SHADER != 0 && features.geometry_shader == vk::FALSE {
        return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
    }
    if flags & FEATURE_SHADER_FLOAT_64 != 0 && features.shader_float64 == vk::FALSE {
        return Err(TestError::NotSupported(
            "Double-precision floats not supported".to_string(),
        ));
    }
    if flags & FEATURE_VERTEX_PIPELINE_STORES_AND_ATOMICS != 0
        && features.vertex_pipeline_stores_and_atomics == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "SSBO and image writes not supported in vertex pipeline".to_string(),
        ));
    }
    if flags & FEATURE_FRAGMENT_STORES_AND_ATOMICS != 0 && features.fragment_stores_and_atomics == vk::FALSE {
        return Err(TestError::NotSupported(
            "SSBO and image writes not supported in fragment shader".to_string(),
        ));
    }
    if flags & FEATURE_SHADER_TESSELLATION_AND_GEOMETRY_POINT_SIZE != 0
        && features.shader_tessellation_and_geometry_point_size == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "Tessellation and geometry shaders don't support PointSize built-in".to_string(),
        ));
    }
    Ok(())
}

/// `findMatchingMemoryType`
pub fn find_matching_memory_type(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    object_memory_requirements: &vk::MemoryRequirements,
    memory_requirement: MemoryRequirement,
) -> u32 {
    let device_memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };

    for memory_type_ndx in 0..device_memory_properties.memory_type_count {
        if object_memory_requirements.memory_type_bits & (1 << memory_type_ndx) != 0
            && memory_requirement
                .matches_heap(device_memory_properties.memory_types[memory_type_ndx as usize].property_flags)
        {
            return memory_type_ndx;
        }
    }

    NO_MATCH_FOUND
}

/// `getHeapIndexForMemoryType`
pub fn get_heap_index_for_memory_type(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    memory_type: u32,
) -> u32 {
    let device_memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
    assert!(memory_type < device_memory_properties.memory_type_count);
    device_memory_properties.memory_types[memory_type as usize].heap_index
}

/// `checkSparseSupportForImageType`
pub fn check_sparse_support_for_image_type(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    image_type: ImageType,
) -> bool {
    let device_features = unsafe { instance.get_physical_device_features(physical_device) };

    if device_features.sparse_binding == vk::FALSE {
        return false;
    }

    match map_image_type(image_type) {
        vk::ImageType::_2D => device_features.sparse_residency_image_2d == vk::TRUE,
        vk::ImageType::_3D => device_features.sparse_residency_image_3d == vk::TRUE,
        other => panic!("Unexpected image type {other:?}"),
    }
}

/// `checkSparseSupportForImageFormat`
pub fn check_sparse_support_for_image_format(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    image_info: &vk::ImageCreateInfo,
) -> bool {
    crate::vk::sparse_util::check_sparse_image_format_support(instance, physical_device, image_info)
}

/// `checkImageFormatFeatureSupport`
pub fn check_image_format_feature_support(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    format: vk::Format,
    feature_flags: vk::FormatFeatureFlags,
) -> bool {
    let format_properties = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
    format_properties.optimal_tiling_features.contains(feature_flags)
}

/// `getSparseAspectRequirementsIndex`
pub fn get_sparse_aspect_requirements_index(
    requirements: &[vk::SparseImageMemoryRequirements],
    aspect_flags: vk::ImageAspectFlags,
) -> u32 {
    requirements
        .iter()
        .position(|requirement| requirement.format_properties.aspect_mask.intersects(aspect_flags))
        .map_or(NO_MATCH_FOUND, |index| index as u32)
}

/// `getPlaneCompatibleFormatForWriting`
pub fn get_plane_compatible_format_for_writing(format: vk::Format, plane_ndx: usize) -> vk::Format {
    let info = format_description(format);
    assert!(plane_ndx < info.planes.len());
    let result = info.planes[plane_ndx].compatible_format;

    // redirect result for some of the YCbCr image formats
    use vk::Format as F;
    const YCBCR_FORMATS: [(vk::Format, vk::Format); 8] = [
        (F::G8B8G8R8_422_UNORM, F::R8G8B8A8_UNORM),
        (F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16, F::R16G16B16A16_UNORM),
        (F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16, F::R16G16B16A16_UNORM),
        (F::G16B16G16R16_422_UNORM, F::R16G16B16A16_UNORM),
        (F::B8G8R8G8_422_UNORM, F::R8G8B8A8_UNORM),
        (F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16, F::R16G16B16A16_UNORM),
        (F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16, F::R16G16B16A16_UNORM),
        (F::B16G16R16G16_422_UNORM, F::R16G16B16A16_UNORM),
    ];
    YCBCR_FORMATS
        .iter()
        .find(|(from, _)| *from == result)
        .map_or(result, |(_, to)| *to)
}

/// `getStorageCompatibleFormat` - packed formats without storage support map to block-compatible ones that have it.
pub fn get_storage_compatible_format(plane_format: vk::Format) -> vk::Format {
    use vk::Format as F;
    match plane_format {
        F::R10X6_UNORM_PACK16 | F::R12X4_UNORM_PACK16 => F::R16_UNORM,
        F::R10X6G10X6_UNORM_2PACK16 | F::R12X4G12X4_UNORM_2PACK16 => F::R16G16_UNORM,
        F::R10X6G10X6B10X6A10X6_UNORM_4PACK16 | F::R12X4G12X4B12X4A12X4_UNORM_4PACK16 => F::R16G16B16A16_UNORM,
        F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
        | F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
        | F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
        | F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16 => F::R16G16B16A16_UNORM,
        other => other,
    }
}

/// `areLsb6BitsDontCare`
pub fn are_lsb6_bits_dont_care(format: vk::Format) -> bool {
    use vk::Format as F;
    matches!(
        format,
        F::R10X6_UNORM_PACK16
            | F::R10X6G10X6_UNORM_2PACK16
            | F::R10X6G10X6B10X6A10X6_UNORM_4PACK16
            | F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
            | F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
            | F::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16
            | F::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16
            | F::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16
            | F::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16
            | F::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16
    )
}

/// `areLsb4BitsDontCare`
pub fn are_lsb4_bits_dont_care(format: vk::Format) -> bool {
    use vk::Format as F;
    matches!(
        format,
        F::R12X4_UNORM_PACK16
            | F::R12X4G12X4_UNORM_2PACK16
            | F::R12X4G12X4B12X4A12X4_UNORM_4PACK16
            | F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
            | F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
            | F::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16
            | F::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16
            | F::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16
            | F::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16
            | F::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16
    )
}
