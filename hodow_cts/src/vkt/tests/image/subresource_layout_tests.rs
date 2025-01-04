// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageSubresourceLayoutTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. `formats::basicColorFormats` is written out below.
// `vkGetDeviceImageSubresourceLayout` and `vkGetImageSubresourceLayout2` are the KHR (maintenance5) entry points.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrMaintenance5ExtensionDeviceCommands;

use crate::tcu::float::{Float16, Float32};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    get_depth_copy_format, get_stencil_copy_format, make_image_memory_barrier, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::api::object_tests::format_name;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `formats::basicColorFormats`
pub const BASIC_COLOR_FORMATS: &[vk::Format] = &[
    vk::Format::R4G4_UNORM_PACK8,
    vk::Format::R4G4B4A4_UNORM_PACK16,
    vk::Format::B4G4R4A4_UNORM_PACK16,
    vk::Format::R5G6B5_UNORM_PACK16,
    vk::Format::B5G6R5_UNORM_PACK16,
    vk::Format::R5G5B5A1_UNORM_PACK16,
    vk::Format::B5G5R5A1_UNORM_PACK16,
    vk::Format::A1R5G5B5_UNORM_PACK16,
    vk::Format::A1B5G5R5_UNORM_PACK16,
    vk::Format::A8_UNORM,
    vk::Format::R8_UNORM,
    vk::Format::R8_SNORM,
    vk::Format::R8_USCALED,
    vk::Format::R8_SSCALED,
    vk::Format::R8_UINT,
    vk::Format::R8_SINT,
    vk::Format::R8_SRGB,
    vk::Format::R8G8_UNORM,
    vk::Format::R8G8_SNORM,
    vk::Format::R8G8_USCALED,
    vk::Format::R8G8_SSCALED,
    vk::Format::R8G8_UINT,
    vk::Format::R8G8_SINT,
    vk::Format::R8G8_SRGB,
    vk::Format::R8G8B8_UNORM,
    vk::Format::R8G8B8_SNORM,
    vk::Format::R8G8B8_USCALED,
    vk::Format::R8G8B8_SSCALED,
    vk::Format::R8G8B8_UINT,
    vk::Format::R8G8B8_SINT,
    vk::Format::R8G8B8_SRGB,
    vk::Format::B8G8R8_UNORM,
    vk::Format::B8G8R8_SNORM,
    vk::Format::B8G8R8_USCALED,
    vk::Format::B8G8R8_SSCALED,
    vk::Format::B8G8R8_UINT,
    vk::Format::B8G8R8_SINT,
    vk::Format::B8G8R8_SRGB,
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R8G8B8A8_SNORM,
    vk::Format::R8G8B8A8_USCALED,
    vk::Format::R8G8B8A8_SSCALED,
    vk::Format::R8G8B8A8_UINT,
    vk::Format::R8G8B8A8_SINT,
    vk::Format::R8G8B8A8_SRGB,
    vk::Format::B8G8R8A8_UNORM,
    vk::Format::B8G8R8A8_SNORM,
    vk::Format::B8G8R8A8_USCALED,
    vk::Format::B8G8R8A8_SSCALED,
    vk::Format::B8G8R8A8_UINT,
    vk::Format::B8G8R8A8_SINT,
    vk::Format::B8G8R8A8_SRGB,
    vk::Format::A8B8G8R8_UNORM_PACK32,
    vk::Format::A8B8G8R8_SNORM_PACK32,
    vk::Format::A8B8G8R8_USCALED_PACK32,
    vk::Format::A8B8G8R8_SSCALED_PACK32,
    vk::Format::A8B8G8R8_UINT_PACK32,
    vk::Format::A8B8G8R8_SINT_PACK32,
    vk::Format::A8B8G8R8_SRGB_PACK32,
    vk::Format::A2R10G10B10_UNORM_PACK32,
    vk::Format::A2R10G10B10_SNORM_PACK32,
    vk::Format::A2R10G10B10_USCALED_PACK32,
    vk::Format::A2R10G10B10_SSCALED_PACK32,
    vk::Format::A2R10G10B10_UINT_PACK32,
    vk::Format::A2R10G10B10_SINT_PACK32,
    vk::Format::A2B10G10R10_UNORM_PACK32,
    vk::Format::A2B10G10R10_SNORM_PACK32,
    vk::Format::A2B10G10R10_USCALED_PACK32,
    vk::Format::A2B10G10R10_SSCALED_PACK32,
    vk::Format::A2B10G10R10_UINT_PACK32,
    vk::Format::A2B10G10R10_SINT_PACK32,
    vk::Format::R16_UNORM,
    vk::Format::R16_SNORM,
    vk::Format::R16_USCALED,
    vk::Format::R16_SSCALED,
    vk::Format::R16_UINT,
    vk::Format::R16_SINT,
    vk::Format::R16_SFLOAT,
    vk::Format::R16G16_UNORM,
    vk::Format::R16G16_SNORM,
    vk::Format::R16G16_USCALED,
    vk::Format::R16G16_SSCALED,
    vk::Format::R16G16_UINT,
    vk::Format::R16G16_SINT,
    vk::Format::R16G16_SFLOAT,
    vk::Format::R16G16B16_UNORM,
    vk::Format::R16G16B16_SNORM,
    vk::Format::R16G16B16_USCALED,
    vk::Format::R16G16B16_SSCALED,
    vk::Format::R16G16B16_UINT,
    vk::Format::R16G16B16_SINT,
    vk::Format::R16G16B16_SFLOAT,
    vk::Format::R16G16B16A16_UNORM,
    vk::Format::R16G16B16A16_SNORM,
    vk::Format::R16G16B16A16_USCALED,
    vk::Format::R16G16B16A16_SSCALED,
    vk::Format::R16G16B16A16_UINT,
    vk::Format::R16G16B16A16_SINT,
    vk::Format::R16G16B16A16_SFLOAT,
    vk::Format::R32_UINT,
    vk::Format::R32_SINT,
    vk::Format::R32_SFLOAT,
    vk::Format::R32G32_UINT,
    vk::Format::R32G32_SINT,
    vk::Format::R32G32_SFLOAT,
    vk::Format::R32G32B32_UINT,
    vk::Format::R32G32B32_SINT,
    vk::Format::R32G32B32_SFLOAT,
    vk::Format::R32G32B32A32_UINT,
    vk::Format::R32G32B32A32_SINT,
    vk::Format::R32G32B32A32_SFLOAT,
    vk::Format::R64_UINT,
    vk::Format::R64_SINT,
    vk::Format::R64_SFLOAT,
    vk::Format::R64G64_UINT,
    vk::Format::R64G64_SINT,
    vk::Format::R64G64_SFLOAT,
    vk::Format::R64G64B64_UINT,
    vk::Format::R64G64B64_SINT,
    vk::Format::R64G64B64_SFLOAT,
    vk::Format::R64G64B64A64_UINT,
    vk::Format::R64G64B64A64_SINT,
    vk::Format::R64G64B64A64_SFLOAT,
    vk::Format::B10G11R11_UFLOAT_PACK32,
    vk::Format::E5B9G9R9_UFLOAT_PACK32,
    vk::Format::R10X6_UNORM_PACK16,
    vk::Format::R10X6G10X6_UNORM_2PACK16,
    vk::Format::R12X4_UNORM_PACK16,
    vk::Format::R12X4G12X4_UNORM_2PACK16,
    vk::Format::A4R4G4B4_UNORM_PACK16,
    vk::Format::A4B4G4R4_UNORM_PACK16,
];

/// `de::toLower(getFormatName(format).substr(10))` - the core formats come from the shared table, the extension ones named here.
pub fn short_format_name(format: vk::Format) -> String {
    match format {
        vk::Format::A1B5G5R5_UNORM_PACK16 => "a1b5g5r5_unorm_pack16".to_string(),
        vk::Format::A8_UNORM => "a8_unorm".to_string(),
        vk::Format::R10X6_UNORM_PACK16 => "r10x6_unorm_pack16".to_string(),
        vk::Format::R10X6G10X6_UNORM_2PACK16 => "r10x6g10x6_unorm_2pack16".to_string(),
        vk::Format::R12X4_UNORM_PACK16 => "r12x4_unorm_pack16".to_string(),
        vk::Format::R12X4G12X4_UNORM_2PACK16 => "r12x4g12x4_unorm_2pack16".to_string(),
        vk::Format::A4R4G4B4_UNORM_PACK16 => "a4r4g4b4_unorm_pack16".to_string(),
        vk::Format::A4B4G4R4_UNORM_PACK16 => "a4b4g4r4_unorm_pack16".to_string(),
        _ => format_name(format).to_string(),
    }
}

/// One mipmap level in the buffer holding the image data.
struct Level {
    /// In bytes.
    offset: vk::DeviceSize,
    /// In bytes.
    size: vk::DeviceSize,
    /// `.depth` will be the number of layers for 2D images and the depth for 3D images.
    dimensions: vk::Extent3D,
}

/// `BufferLevels` - helper class to calculate buffer sizes and offsets for image mipmap levels.
struct BufferLevels {
    /// In bytes.
    pixel_size: vk::DeviceSize,
    levels: Vec<Level>,
}

impl BufferLevels {
    fn new(
        image_type: vk::ImageType,
        format: vk::Format,
        level_zero: vk::Extent3D,
        max_levels: u32,
        aspects: vk::ImageAspectFlags,
    ) -> Result<Self, TestError> {
        debug_assert!(image_type == vk::ImageType::_2D || image_type == vk::ImageType::_3D);
        debug_assert!(max_levels >= 1);

        let no_format = |what: &str| TestError::NotPorted(format!("{what} of {format:?}"));
        let pixel_size = if aspects.is_empty() || aspects.contains(vk::ImageAspectFlags::COLOR) {
            map_vk_format(format)
                .and_then(|f| f.pixel_size())
                .ok_or_else(|| no_format("pixel size"))?
        } else if aspects.contains(vk::ImageAspectFlags::DEPTH) {
            get_depth_copy_format(format)
                .and_then(|f| f.pixel_size())
                .ok_or_else(|| no_format("depth copy format"))?
        } else {
            get_stencil_copy_format(format)
                .and_then(|f| f.pixel_size())
                .ok_or_else(|| no_format("stencil copy format"))?
        };
        let pixel_size = vk::DeviceSize::from(pixel_size);

        let mut levels: Vec<Level> = Vec::new();
        let mut current_offset = 0u64;
        let mut next_extent = level_zero;

        while levels.len() < max_levels as usize {
            let level = Level {
                offset: current_offset,
                size: pixel_size
                    * u64::from(next_extent.width)
                    * u64::from(next_extent.height)
                    * u64::from(next_extent.depth),
                dimensions: next_extent,
            };
            let level_size = level.size;

            levels.push(level);

            // This was the last available level
            if next_extent.width == 1
                && next_extent.height == 1
                && (image_type == vk::ImageType::_2D || next_extent.depth == 1)
            {
                break;
            }

            next_extent.width = 1.max(next_extent.width / 2);
            next_extent.height = 1.max(next_extent.height / 2);

            // 2D arrays all have the same array size
            if image_type == vk::ImageType::_3D {
                next_extent.depth = 1.max(next_extent.depth / 2);
            }

            current_offset += level_size;
        }

        Ok(Self { pixel_size, levels })
    }

    fn total_size(&self) -> vk::DeviceSize {
        self.levels.iter().map(|l| l.size).sum()
    }

    fn num_levels(&self) -> u32 {
        self.levels.len() as u32
    }
}

/// `getDefaultDimensions` - default image dimensions. For 2D images, `.depth` indicates the number of layers.
fn get_default_dimensions(image_type: vk::ImageType, array: bool) -> vk::Extent3D {
    debug_assert!(image_type == vk::ImageType::_2D || image_type == vk::ImageType::_3D);
    debug_assert!(!array || image_type == vk::ImageType::_2D);

    let default_3d = vk::Extent3D {
        width: 32,
        height: 48,
        depth: 56,
    };
    let default_2d_array = default_3d;
    let default_2d = vk::Extent3D {
        width: 240,
        height: 320,
        depth: 1,
    };

    if image_type == vk::ImageType::_3D {
        return default_3d;
    }
    if array {
        return default_2d_array;
    }
    default_2d
}

#[derive(Clone, Copy)]
struct TestParams {
    image_type: vk::ImageType,
    image_format: vk::Format,
    /// `.depth` will be the number of layers for 2D images and the depth for 3D images.
    dimensions: vk::Extent3D,
    mip_levels: u32,
    /// Add an offset when a region of memory is bound to an image.
    image_offset: bool,
}

fn required_features() -> vk::FormatFeatureFlags {
    vk::FormatFeatureFlags::TRANSFER_DST | vk::FormatFeatureFlags::TRANSFER_SRC
}

fn image_usage_flags() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC
}

/// `ImageSubresourceLayoutCase::checkSupport`
fn check_layout_support(context: &Context<'_>, params: &TestParams) -> Result<(), TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    if params.image_format == vk::Format::A8_UNORM || params.image_format == vk::Format::A1B5G5R5_UNORM_PACK16 {
        context.require_device_functionality("VK_KHR_maintenance5")?;
    }

    let format_properties =
        unsafe { instance.get_physical_device_format_properties(physical_device, params.image_format) };
    if !format_properties.linear_tiling_features.contains(required_features()) {
        return Err(TestError::NotSupported(
            "Required format features not supported".to_string(),
        ));
    }

    let img_format_properties = match unsafe {
        instance.get_physical_device_image_format_properties(
            physical_device,
            params.image_format,
            params.image_type,
            vk::ImageTiling::LINEAR,
            image_usage_flags(),
            vk::ImageCreateFlags::empty(),
        )
    } {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
            return Err(TestError::NotSupported(
                "Linear tiling not supported for format".to_string(),
            ));
        }
        result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?,
    };

    {
        let levels = BufferLevels::new(
            params.image_type,
            params.image_format,
            params.dimensions,
            params.mip_levels,
            vk::ImageAspectFlags::empty(),
        )?;
        if img_format_properties.max_mip_levels < levels.num_levels() {
            return Err(TestError::NotSupported(
                "Required number of mip levels not supported for format".to_string(),
            ));
        }
    }

    if params.image_type == vk::ImageType::_2D && img_format_properties.max_array_layers < params.dimensions.depth {
        return Err(TestError::NotSupported(
            "Required number of layers not supported for format".to_string(),
        ));
    }

    Ok(())
}

/// `fillWithRandomBytes` - fills `data` with pseudorandom data, eight bytes at a time as far as it goes.
fn fill_with_random_bytes(rnd: &mut Random, data: &mut [u8]) {
    let mut pos = 0usize;

    while pos < data.len() {
        let remaining = data.len() - pos;

        if remaining >= 8 {
            data[pos..pos + 8].copy_from_slice(&rnd.get_uint64().to_ne_bytes());
            pos += 8;
        } else if remaining >= 4 {
            data[pos..pos + 4].copy_from_slice(&rnd.get_uint32().to_ne_bytes());
            pos += 4;
        } else if remaining >= 2 {
            data[pos..pos + 2].copy_from_slice(&rnd.get_uint16().to_ne_bytes());
            pos += 2;
        } else {
            data[pos] = rnd.get_uint8();
            pos += 1;
        }
    }
}

/// `fillWithRandomData24In32` - fills data in blocks of 32 bits, discarding the higher 8 bits of each block.
fn fill_with_random_data_24_in_32(rnd: &mut Random, data: &mut [u8]) {
    const BLOCK_SIZE: usize = 4;
    debug_assert!(data.len().is_multiple_of(BLOCK_SIZE));

    for block in data.chunks_exact_mut(BLOCK_SIZE) {
        let value = rnd.get_uint32() & 0xFF_FFFF; // Remove the higher 8 bits
        block.copy_from_slice(&value.to_ne_bytes());
    }
}

/// `getNormalFPValue` + `fillWithRandomFloatingPoint` - normal numbers in the range [0, 1).
fn fill_with_random_floating_point(rnd: &mut Random, data: &mut [u8], element_size: usize) {
    debug_assert!(data.len().is_multiple_of(element_size));

    for element in data.chunks_exact_mut(element_size) {
        match element_size {
            4 => {
                let value = loop {
                    let value = rnd.get_float();
                    if !Float32::new(value).is_denorm() {
                        break value;
                    }
                };
                element.copy_from_slice(&value.to_ne_bytes());
            }
            8 => {
                let value = loop {
                    let value = rnd.get_double();
                    if !value.is_subnormal() {
                        break value;
                    }
                };
                element.copy_from_slice(&value.to_ne_bytes());
            }
            _ => {
                let value = loop {
                    let value = Float16::new(rnd.get_float());
                    if !value.is_denorm() {
                        break value;
                    }
                };
                element.copy_from_slice(&value.bits().to_ne_bytes());
            }
        }
    }
}

/// `getImageAspectFlags(tcuFormat)`
fn get_image_aspect_flags(format: TextureFormat) -> vk::ImageAspectFlags {
    match format.order {
        ChannelOrder::D => vk::ImageAspectFlags::DEPTH,
        ChannelOrder::S => vk::ImageAspectFlags::STENCIL,
        ChannelOrder::DS => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::COLOR,
    }
}

fn layout_image_info(params: &TestParams) -> vk::ImageCreateInfo {
    // Reinterpret the depth dimension parameter as the number of layers if needed
    let num_layers = if params.image_type == vk::ImageType::_3D {
        1
    } else {
        params.dimensions.depth
    };
    let mut image_extent = params.dimensions;
    if params.image_type == vk::ImageType::_2D {
        image_extent.depth = 1;
    }

    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: params.image_type,
        format: params.image_format,
        extent: image_extent,
        mip_levels: params.mip_levels,
        array_layers: num_layers,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::LINEAR,
        usage: image_usage_flags(),
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

struct ImageSubresourceLayoutCase {
    name: String,
    params: TestParams,
    invariance: bool,
}

impl TestCase for ImageSubresourceLayoutCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_layout_support(context, &self.params)?;
        if self.invariance {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSubresourceLayoutInstance {
            context,
            params: self.params,
            invariance: self.invariance,
        })
    }
}

struct ImageSubresourceLayoutInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    invariance: bool,
}

impl TestInstance for ImageSubresourceLayoutInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.invariance {
            return self.iterate_invariance();
        }

        // Test every aspect supported by the image format
        let tcu_format = map_vk_format(self.params.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", self.params.image_format)))?;
        let aspect_flags = get_image_aspect_flags(tcu_format);

        for bit in [
            vk::ImageAspectFlags::COLOR,
            vk::ImageAspectFlags::DEPTH,
            vk::ImageAspectFlags::STENCIL,
        ] {
            if aspect_flags.contains(bit) {
                let aspect_result = self.iterate_aspect(bit)?;
                if !matches!(aspect_result.code(), crate::tcu::TestResult::Pass) {
                    return Ok(aspect_result); // Early return for failures
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl ImageSubresourceLayoutInstance<'_> {
    /// `ImageSubresourceLayoutInstance::iterateAspect`
    fn iterate_aspect(&self, image_aspect: vk::ImageAspectFlags) -> TestOutcome {
        // * Create linear image with several mipmaps
        // * Fill its levels with unique appropriate data (avoiding invalid sfloat values, for example).
        // * Ask for the subresource layout parameters.
        // * Verify they make sense.
        // * Check accessing data with the given parameters gives back the original data.

        let params = &self.params;
        let vkd = self.context.get_device();
        let alloc = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        log::info!("Testing aspect {image_aspect:?}");

        // Get an idea of the buffer size and parameters to prepare image data
        let buffer_levels = BufferLevels::new(
            params.image_type,
            params.image_format,
            params.dimensions,
            params.mip_levels,
            image_aspect,
        )?;
        let pixel_size = buffer_levels.pixel_size;
        let pixel_size_sz = pixel_size as usize;
        let num_levels = buffer_levels.num_levels();

        // Create source buffer
        let buffer_size = buffer_levels.total_size();
        let buffer = BufferWithMemory::new(
            vkd,
            alloc,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer_alloc = buffer.get_allocation();
        let buffer_ptr = buffer_alloc.get_host_ptr();

        // Fill buffer with random appropriate data
        let random_seed = 1594055758u32
            .wrapping_add(params.image_format.as_raw() as u32)
            .wrapping_add(image_aspect.bits());
        let mut rnd = Random::new(random_seed);
        let tcu_format = map_vk_format(params.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", params.image_format)))?;
        // For some formats, the copy block is 32 bits wide but the 8 MSB need to be ignored, so we zero them out
        let use_24_lsb = (params.image_format == vk::Format::X8_D24_UNORM_PACK32
            || params.image_format == vk::Format::D24_UNORM_S8_UINT)
            && image_aspect == vk::ImageAspectFlags::DEPTH;

        {
            let data = unsafe { std::slice::from_raw_parts_mut(buffer_ptr, buffer_size as usize) };
            if tcu_format.type_ == ChannelType::FLOAT
                || (params.image_format == vk::Format::D32_SFLOAT_S8_UINT
                    && image_aspect == vk::ImageAspectFlags::DEPTH)
            {
                fill_with_random_floating_point(&mut rnd, data, 4);
            } else if tcu_format.type_ == ChannelType::FLOAT64 {
                fill_with_random_floating_point(&mut rnd, data, 8);
            } else if tcu_format.type_ == ChannelType::HALF_FLOAT {
                fill_with_random_floating_point(&mut rnd, data, 2);
            } else if use_24_lsb {
                fill_with_random_data_24_in_32(&mut rnd, data);
            } else {
                fill_with_random_bytes(&mut rnd, data);
            }
        }

        flush_alloc(vkd, buffer_alloc)?;

        // Reinterpret the depth dimension parameter as the number of layers if needed
        let num_layers = if params.image_type == vk::ImageType::_3D {
            1
        } else {
            params.dimensions.depth
        };

        // Create image
        let mut image_info = layout_image_info(params);
        image_info.mip_levels = num_levels;
        let image = Unique::new(
            vkd,
            unsafe { vkd.create_image(&image_info, None) }.vk_check("vkCreateImage")?,
        );
        let mut req = unsafe { vkd.get_image_memory_requirements(*image) };
        if params.image_offset {
            req.size += req.alignment;
        }

        let image_alloc = alloc.allocate(vkd, req, MemoryRequirement::HOST_VISIBLE)?;
        let bind_extra = if params.image_offset { req.alignment } else { 0 };

        unsafe { vkd.bind_image_memory(*image, image_alloc.get_memory(), image_alloc.get_offset() + bind_extra) }
            .vk_check("vkBindImageMemory")?;
        let image_ptr = image_alloc.get_host_ptr();

        // Copy regions
        let mut copy_regions: Vec<vk::BufferImageCopy> = Vec::with_capacity(num_levels as usize);

        for level_ndx in 0..num_levels {
            let level = &buffer_levels.levels[level_ndx as usize];
            let mut level_extent = level.dimensions;

            if params.image_type == vk::ImageType::_2D {
                level_extent.depth = 1; // For 2D images, .depth indicates the number of layers
            }

            copy_regions.push(vk::BufferImageCopy {
                buffer_offset: level.offset,
                buffer_row_length: 0,   // Tightly packed data
                buffer_image_height: 0, // Ditto
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: image_aspect,
                    mip_level: level_ndx,
                    base_array_layer: 0,
                    layer_count: num_layers,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: level_extent,
            });
        }

        // Image layout transitions
        let image_subresource_range = make_image_subresource_range(image_aspect, 0, num_levels, 0, num_layers);
        let initial_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *image,
            image_subresource_range,
        );
        let final_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            *image,
            image_subresource_range,
        );

        // Command buffer
        let cmd_pool = make_command_pool(vkd, queue_family_index)?;
        let cmd_buffer_ptr = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        // Transition layout, copy, transition layout
        begin_command_buffer(vkd, cmd_buffer)?;
        unsafe {
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[initial_layout_barrier],
            );
            vkd.cmd_copy_buffer_to_image(
                cmd_buffer,
                buffer.get(),
                *image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &copy_regions,
            );
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[final_layout_barrier],
            );
        }
        end_command_buffer(vkd, cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, cmd_buffer)?;

        // Sync image memory for host access
        invalidate_alloc(vkd, &image_alloc)?;

        let fail = |msg: String| -> TestOutcome { Ok(TestStatus::fail(msg)) };

        for level_ndx in 0..num_levels {
            // Get base level subresource
            let level_subresource = vk::ImageSubresource {
                aspect_mask: image_aspect,
                mip_level: level_ndx,
                array_layer: 0,
            };
            let level_subresource_layout = unsafe { vkd.get_image_subresource_layout(*image, &level_subresource) };

            let level = &buffer_levels.levels[level_ndx as usize];
            for layer_ndx in 0..num_layers {
                let image_subresource = vk::ImageSubresource {
                    aspect_mask: image_aspect,
                    mip_level: level_ndx,
                    array_layer: layer_ndx,
                };
                let subresource_layout = unsafe { vkd.get_image_subresource_layout(*image, &image_subresource) };

                // Verify returned values
                let subresource_width = level.dimensions.width;
                let subresource_height = level.dimensions.height;
                let subresource_depth = if params.image_type == vk::ImageType::_2D {
                    1
                } else {
                    level.dimensions.depth
                };
                let num_pixels = subresource_width * subresource_height * subresource_depth;

                if num_layers > 1 && level_subresource_layout.array_pitch != subresource_layout.array_pitch {
                    // Inconsistent arrayPitch
                    return fail(format!(
                        "Image level {level_ndx} layer {layer_ndx} reports array pitch of {} bytes in size with base layer reporting array pitch of {} bytes in size",
                        subresource_layout.array_pitch, level_subresource_layout.array_pitch
                    ));
                }

                if subresource_layout.offset.wrapping_sub(level_subresource_layout.offset)
                    != u64::from(layer_ndx) * subresource_layout.array_pitch
                {
                    // Inconsistent offset
                    return fail(format!(
                        "Image level {level_ndx} layer {layer_ndx} has offset inconsistent with array pitch: base offset {}, layer offset {}, array pitch {}",
                        level_subresource_layout.offset, subresource_layout.offset, subresource_layout.array_pitch
                    ));
                }

                if subresource_layout.size < pixel_size * u64::from(num_pixels) {
                    // Subresource size too small
                    return fail(format!(
                        "Image level {level_ndx} layer {layer_ndx} reports {} bytes in size with pixel size {pixel_size} and dimensions {subresource_width}x{subresource_height}x{subresource_depth}",
                        subresource_layout.size
                    ));
                }

                // Note: if subresourceHeight is <= 1u, rowPitch can be zero
                if subresource_height > 1 && subresource_layout.row_pitch < pixel_size * u64::from(subresource_width) {
                    // Row pitch too small
                    return fail(format!(
                        "Image level {level_ndx} layer {layer_ndx} reports row pitch of {} bytes with {pixel_size} bytes in pixel size and width {subresource_width}",
                        subresource_layout.row_pitch
                    ));
                }

                if num_layers > 1 && subresource_layout.array_pitch < pixel_size * u64::from(num_pixels) {
                    // Array pitch too small
                    return fail(format!(
                        "Image level {level_ndx} layer {layer_ndx} reports array pitch of {} bytes with {pixel_size} bytes in pixel size and layer dimensions {subresource_width}x{subresource_height}",
                        subresource_layout.array_pitch
                    ));
                }

                // If subresourceDepth is <= 1u, depthPitch can be zero
                if subresource_depth > 1
                    && params.image_type == vk::ImageType::_3D
                    && subresource_layout.depth_pitch
                        < pixel_size * u64::from(subresource_width) * u64::from(subresource_height)
                {
                    // Depth pitch too small
                    return fail(format!(
                        "Image level {level_ndx} layer {layer_ndx} reports depth pitch of {} bytes with pixel size {pixel_size} and dimensions {subresource_width}x{subresource_height}x{subresource_depth}",
                        subresource_layout.depth_pitch
                    ));
                }

                // Verify image data
                let layer_buffer_offset = level.offset + u64::from(layer_ndx) * u64::from(num_pixels) * pixel_size;
                let layer_image_offset = subresource_layout.offset;
                let layer_buffer_ptr = unsafe { buffer_ptr.add(layer_buffer_offset as usize) };
                let layer_image_ptr = unsafe { image_ptr.add((layer_image_offset + bind_extra) as usize) };

                // This could be done row by row to be faster, but in the use24LSB case pixels need to be manipulated independently
                for x in 0..subresource_width {
                    for y in 0..subresource_height {
                        for z in 0..subresource_depth {
                            let buffer_pixel_offset =
                                (u64::from(z) * u64::from(subresource_width) * u64::from(subresource_height)
                                    + u64::from(y) * u64::from(subresource_width)
                                    + u64::from(x))
                                    * pixel_size;
                            let image_pixel_offset = u64::from(z) * subresource_layout.depth_pitch
                                + u64::from(y) * subresource_layout.row_pitch
                                + u64::from(x) * pixel_size;
                            let buffer_pixel = unsafe {
                                std::slice::from_raw_parts(
                                    layer_buffer_ptr.add(buffer_pixel_offset as usize).cast_const(),
                                    pixel_size_sz,
                                )
                            };
                            let image_pixel = unsafe {
                                std::slice::from_raw_parts(
                                    layer_image_ptr.add(image_pixel_offset as usize).cast_const(),
                                    pixel_size_sz,
                                )
                            };

                            let pixel_match = if use_24_lsb {
                                debug_assert!(pixel_size_sz == std::mem::size_of::<u32>());
                                let mut pixel_value = u32::from_ne_bytes([
                                    image_pixel[0],
                                    image_pixel[1],
                                    image_pixel[2],
                                    image_pixel[3],
                                ]);
                                pixel_value &= 0xFF_FFFF; // Discard the 8 MSB
                                buffer_pixel == pixel_value.to_ne_bytes()
                            } else {
                                buffer_pixel == image_pixel
                            };

                            if !pixel_match {
                                return fail(format!(
                                    "Found difference from image pixel to buffer pixel at coordinates level={level_ndx} layer={layer_ndx} x={x} y={y} z={z}"
                                ));
                            }
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `ImageSubresourceLayoutInvarianceInstance::iterate`
    fn iterate_invariance(&self) -> TestOutcome {
        let params = &self.params;
        let device = self.context.get_device();

        let image_create_info = layout_image_info(params);

        let image = Unique::new(
            device,
            unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );
        let tcu_format = map_vk_format(params.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", params.image_format)))?;
        let supported_aspect_flags = get_image_aspect_flags(tcu_format);

        // Test every aspect supported by the image format
        for aspect_bit in [
            vk::ImageAspectFlags::COLOR,
            vk::ImageAspectFlags::DEPTH,
            vk::ImageAspectFlags::STENCIL,
        ] {
            if !supported_aspect_flags.contains(aspect_bit) {
                continue;
            }

            // Get base level subresource using the image handle
            let image_subresource1 = vk::ImageSubresource {
                aspect_mask: aspect_bit,
                mip_level: 0,
                array_layer: 0,
            };
            let subresource_layout1 = unsafe { device.get_image_subresource_layout(*image, &image_subresource1) };

            // Get level subresource without using the image handle
            let image_subresource2 = vk::ImageSubresource2 {
                s_type: vk::StructureType::IMAGE_SUBRESOURCE_2,
                next: std::ptr::null_mut(),
                image_subresource: image_subresource1,
            };
            let mut subresource_layout2 = vk::SubresourceLayout2::default();
            let image_subresource_info = vk::DeviceImageSubresourceInfo {
                s_type: vk::StructureType::DEVICE_IMAGE_SUBRESOURCE_INFO,
                next: std::ptr::null(),
                create_info: &image_create_info,
                subresource: &image_subresource2,
            };
            unsafe {
                device.get_device_image_subresource_layout_khr(&image_subresource_info, &mut subresource_layout2)
            };

            let same = |a: &vk::SubresourceLayout, b: &vk::SubresourceLayout| {
                a.offset == b.offset
                    && a.size == b.size
                    && a.row_pitch == b.row_pitch
                    && a.array_pitch == b.array_pitch
                    && a.depth_pitch == b.depth_pitch
            };

            if !same(&subresource_layout1, &subresource_layout2.subresource_layout) {
                return Ok(TestStatus::fail("Fail (vkGetDeviceImageSubresourceLayoutKHR)"));
            }

            if self
                .context
                .is_device_functionality_supported("VK_EXT_image_compression_control")
            {
                let mut subresource_layout3 = vk::SubresourceLayout2::default();
                unsafe {
                    device.get_image_subresource_layout2_khr(*image, &image_subresource2, &mut subresource_layout3)
                };

                if !same(&subresource_layout1, &subresource_layout3.subresource_layout) {
                    return Ok(TestStatus::fail("Fail (vkGetImageSubresourceLayout2KHR)"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageSubresourceLayoutTests`
pub fn create_image_subresource_layout_tests() -> TestCaseGroup {
    let mut layout_test_group = TestCaseGroup::new("subresource_layout");

    // (type, array, name)
    let image_class = [
        (vk::ImageType::_2D, false, "2d"),
        (vk::ImageType::_2D, true, "2d_array"),
        (vk::ImageType::_3D, false, "3d"),
    ];

    let mip_levels = [
        (1u32, "1_level"),
        (2, "2_levels"),
        (4, "4_levels"),
        (u32::MAX, "all_levels"),
    ];

    for (image_type, array, class_name) in image_class {
        let mut class_group = TestCaseGroup::new(class_name);

        for (max_levels, mip_name) in mip_levels {
            let mut mip_group = TestCaseGroup::new(mip_name);

            // Leaving out depth/stencil formats due to this part of the spec: "Depth/stencil formats are considered opaque and
            // need not be stored in the exact number of bits per texel or component ordering indicated by the format enum."
            for &format in BASIC_COLOR_FORMATS {
                let name = short_format_name(format);

                let mut params = TestParams {
                    image_format: format,
                    image_type,
                    mip_levels: max_levels,
                    dimensions: get_default_dimensions(image_type, array),
                    image_offset: false,
                };

                mip_group.add_child(Box::new(ImageSubresourceLayoutCase {
                    name: name.clone(),
                    params,
                    invariance: false,
                }) as Box<dyn TestCase>);

                params.image_offset = true;

                mip_group.add_child(Box::new(ImageSubresourceLayoutCase {
                    name: format!("{name}_offset"),
                    params,
                    invariance: false,
                }) as Box<dyn TestCase>);
            }

            class_group.add_child(mip_group);
        }

        layout_test_group.add_child(class_group);
    }

    // Tests for vkGetDeviceImageSubresourceLayoutKHR
    let mut invariance_group = TestCaseGroup::new("invariance");

    for (format_idx, &format) in BASIC_COLOR_FORMATS.iter().enumerate() {
        for (image_type, array, class_name) in image_class {
            let mut dimensions = get_default_dimensions(image_type, array);
            dimensions.width += format_idx as u32;
            let params = TestParams {
                image_format: format,
                image_type,
                mip_levels: 1,
                dimensions,
                image_offset: false,
            };

            let name = format!("{}_{}", short_format_name(format), class_name);

            invariance_group.add_child(Box::new(ImageSubresourceLayoutCase {
                name,
                params,
                invariance: true,
            }) as Box<dyn TestCase>);
        }
    }
    layout_test_group.add_child(invariance_group);

    layout_test_group
}
