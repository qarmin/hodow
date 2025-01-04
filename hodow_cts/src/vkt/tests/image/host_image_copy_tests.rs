// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageHostImageCopyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Google LLC.
// Copyright (c) 2022 LunarG, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders here (the per-format draw/dispatch groups and `large_images`
// are `host_image_copy_format_tests`). Ported here: `array`, `properties`, `query`, `simple` and
// `padding`; the preinitialized groups and `identical_memory_layout` are in `host_image_copy_layout_tests`. Not ported:
// `capture_replay` (VK_EXT_descriptor_heap) and `depth_stencil` (DepthStencilHostImageCopyTest).
// `properties` skips the unifiedImageLayouts block: the device this port creates never enables that feature, so
// upstream's `getUnifiedImageLayoutsFeatures().unifiedImageLayouts` is always false here. Failure logging drops the
// image logs.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtHostImageCopyExtensionDeviceCommands, InstanceV1_1};

use super::concurrent_copy_tests::fill_random_no_nan;
use super::host_image_copy_formats::{NON_PLANAR_FORMATS, YCBCR_FORMATS};
use super::host_image_copy_layout_tests::{add_preinitialized_groups, create_identical_memory_layout_group};
use crate::tcu::pixel::unpack_rgb999e5;
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::texture::{ChannelOrder, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::{get_block_height, is_astc_format, is_astc_hdr_format, is_compressed_format};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_layers, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

pub(super) fn is_depth_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| matches!(f.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS))
}

/// `getChannelSize`; only the uncompressed colour formats the array group uses reach it.
pub(super) fn get_channel_size(format: vk::Format) -> u32 {
    match format {
        vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT => 4,
        vk::Format::D16_UNORM => 2,
        vk::Format::S8_UINT => 1,
        _ => map_vk_format(format).and_then(|f| f.type_.channel_size()).unwrap_or(0),
    }
}

/// `getNumChannels`
pub(super) fn get_num_channels(format: vk::Format) -> u32 {
    match map_vk_format(format) {
        Some(f) if !matches!(f.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS) => {
            f.order.num_used_channels()
        }
        _ => 1,
    }
}

/// `generateData`
pub(super) fn generate_data(data: &mut [u8], format: vk::Format) {
    let size = data.len() as u32;
    let compressed_format = is_astc_hdr_format(format);
    if !compressed_format && is_depth_stencil_format(format) {
        let mut random_gen = Random::new(de_int32_hash(format.as_raw()) ^ de_int32_hash(size as i32));
        if format == vk::Format::D16_UNORM {
            fill_random_no_nan(&mut random_gen, data, vk::Format::R16_UNORM);
        } else {
            fill_random_no_nan(&mut random_gen, data, vk::Format::R32_SFLOAT);
        }
    } else if compressed_format || is_compressed_format(format) {
        data.fill(255);
    } else {
        let mut random_gen = Random::new(de_int32_hash(format.as_raw()) ^ de_int32_hash(size as i32));
        fill_random_no_nan(&mut random_gen, data, format);
    }
}

pub(super) struct HostImageCopyProps {
    pub(super) src_layouts: Vec<vk::ImageLayout>,
    pub(super) dst_layouts: Vec<vk::ImageLayout>,
    pub(super) identical_memory_type_requirements: bool,
    optimal_tiling_layout_uuid: [u8; vk::UUID_SIZE],
}

/// `getHostImageCopyProperties`, called twice like upstream's callers do (counts first, then the layout arrays).
pub(super) fn get_host_image_copy_properties(context: &Context<'_>) -> HostImageCopyProps {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut host_image_copy_properties = vk::PhysicalDeviceHostImageCopyProperties::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut host_image_copy_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
    }
    let mut src_layouts = vec![vk::ImageLayout::UNDEFINED; host_image_copy_properties.copy_src_layout_count as usize];
    let mut dst_layouts = vec![vk::ImageLayout::UNDEFINED; host_image_copy_properties.copy_dst_layout_count as usize];
    host_image_copy_properties.copy_src_layouts = src_layouts.as_mut_ptr();
    host_image_copy_properties.copy_dst_layouts = dst_layouts.as_mut_ptr();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut host_image_copy_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
    }

    HostImageCopyProps {
        src_layouts,
        dst_layouts,
        identical_memory_type_requirements: host_image_copy_properties.identical_memory_type_requirements == vk::TRUE,
        optimal_tiling_layout_uuid: host_image_copy_properties.optimal_tiling_layout_uuid.0,
    }
}

/// `isBlockCompressedFormat`
fn is_block_compressed_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::BC1_RGB_UNORM_BLOCK
            | vk::Format::BC1_RGB_SRGB_BLOCK
            | vk::Format::BC1_RGBA_UNORM_BLOCK
            | vk::Format::BC1_RGBA_SRGB_BLOCK
            | vk::Format::BC2_UNORM_BLOCK
            | vk::Format::BC2_SRGB_BLOCK
            | vk::Format::BC3_UNORM_BLOCK
            | vk::Format::BC3_SRGB_BLOCK
            | vk::Format::BC4_UNORM_BLOCK
            | vk::Format::BC4_SNORM_BLOCK
            | vk::Format::BC5_UNORM_BLOCK
            | vk::Format::BC5_SNORM_BLOCK
            | vk::Format::BC6H_UFLOAT_BLOCK
            | vk::Format::BC6H_SFLOAT_BLOCK
            | vk::Format::BC7_UNORM_BLOCK
            | vk::Format::BC7_SRGB_BLOCK
    )
}

/// `checkSupportedFormatFeatures`; the DRM format modifier that supports host image transfer comes back for that
/// tiling and 0 for the others.
#[allow(unused_assignments)]
pub(super) fn check_supported_format_features(
    context: &Context<'_>,
    format: vk::Format,
    tiling: vk::ImageTiling,
) -> Result<u64, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut drm_list = vk::DrmFormatModifierPropertiesList2EXT::default();
    let mut format_properties3 = vk::FormatProperties3::default();
    if tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
        format_properties3.next = std::ptr::addr_of_mut!(drm_list).cast();
    }
    let mut format_properties2 = vk::FormatProperties2::default();
    format_properties2.next = std::ptr::addr_of_mut!(format_properties3).cast();
    unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties2) };

    if tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
        if drm_list.drm_format_modifier_count == 0 {
            return Err(TestError::NotSupported(
                "Format feature host image transfer not supported for drm format modifier.".to_string(),
            ));
        }
        let mut modifiers =
            vec![vk::DrmFormatModifierProperties2EXT::default(); drm_list.drm_format_modifier_count as usize];
        drm_list.drm_format_modifier_properties = modifiers.as_mut_ptr();
        unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties2) };

        return modifiers
            .iter()
            .find(|modifier| {
                modifier
                    .drm_format_modifier_tiling_features
                    .contains(vk::FormatFeatureFlags2::HOST_IMAGE_TRANSFER)
            })
            .map(|modifier| modifier.drm_format_modifier)
            .ok_or_else(|| {
                TestError::NotSupported(
                    "Format feature host image transfer not supported for drm format modifier.".to_string(),
                )
            });
    }

    if tiling == vk::ImageTiling::LINEAR
        && !format_properties3
            .linear_tiling_features
            .contains(vk::FormatFeatureFlags2::HOST_IMAGE_TRANSFER)
    {
        return Err(TestError::NotSupported(
            "Format feature host image transfer not supported for optimal tiling.".to_string(),
        ));
    }
    if tiling == vk::ImageTiling::OPTIMAL
        && !format_properties3
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags2::HOST_IMAGE_TRANSFER)
    {
        return Err(TestError::NotSupported(
            "Format feature host image transfer not supported for optimal tiling.".to_string(),
        ));
    }
    Ok(0)
}

/// The `VK_EXT_host_image_copy` requirement plus the `hostImageCopy` feature bit both array and simple cases check.
pub(super) fn require_host_image_copy_feature(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_host_image_copy")?;

    let mut host_image_copy_features = vk::PhysicalDeviceHostImageCopyFeatures::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut host_image_copy_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    if host_image_copy_features.host_image_copy != vk::TRUE {
        return Err(TestError::NotSupported("hostImageCopy not supported".to_string()));
    }
    Ok(())
}

/// The `vkGetPhysicalDeviceImageFormatProperties2` step of both checkSupports; returns `maxArrayLayers`.
pub(super) fn query_max_array_layers(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    tiling: vk::ImageTiling,
) -> Result<u32, TestError> {
    let usage =
        vk::ImageUsageFlags::HOST_TRANSFER | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
        format,
        type_: image_type,
        tiling,
        usage,
        flags: vk::ImageCreateFlags::empty(),
        ..Default::default()
    };
    query_max_array_layers_with_info(context, &image_format_info)
}

/// The same query for a caller that built the `VkPhysicalDeviceImageFormatInfo2` itself (a DRM modifier in its `pNext`).
pub(super) fn query_max_array_layers_with_info(
    context: &Context<'_>,
    image_format_info: &vk::PhysicalDeviceImageFormatInfo2,
) -> Result<u32, TestError> {
    let mut image_format_properties = vk::ImageFormatProperties2::default();

    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            image_format_info,
            &mut image_format_properties,
        )
    };
    if matches!(result, Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED)) {
        return Err(TestError::NotSupported("Image format not supported.".to_string()));
    }
    Ok(image_format_properties.image_format_properties.max_array_layers)
}

pub(super) fn memory_to_image_copy(
    host_pointer: *const u8,
    memory_row_length: u32,
    memory_image_height: u32,
    image_subresource: vk::ImageSubresourceLayers,
    image_offset: vk::Offset3D,
    image_extent: vk::Extent3D,
) -> vk::MemoryToImageCopy {
    vk::MemoryToImageCopy {
        s_type: vk::StructureType::MEMORY_TO_IMAGE_COPY,
        next: std::ptr::null(),
        host_pointer: host_pointer.cast(),
        memory_row_length,
        memory_image_height,
        image_subresource,
        image_offset,
        image_extent,
    }
}

pub(super) fn image_to_memory_copy(
    host_pointer: *mut u8,
    memory_row_length: u32,
    memory_image_height: u32,
    image_subresource: vk::ImageSubresourceLayers,
    image_offset: vk::Offset3D,
    image_extent: vk::Extent3D,
) -> vk::ImageToMemoryCopy {
    vk::ImageToMemoryCopy {
        s_type: vk::StructureType::IMAGE_TO_MEMORY_COPY,
        next: std::ptr::null(),
        host_pointer: host_pointer.cast(),
        memory_row_length,
        memory_image_height,
        image_subresource,
        image_offset,
        image_extent,
    }
}

pub(super) fn host_layout_transition(
    image: vk::Image,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    subresource_range: vk::ImageSubresourceRange,
) -> vk::HostImageLayoutTransitionInfo {
    vk::HostImageLayoutTransitionInfo {
        s_type: vk::StructureType::HOST_IMAGE_LAYOUT_TRANSITION_INFO,
        next: std::ptr::null(),
        image,
        old_layout,
        new_layout,
        subresource_range,
    }
}

pub(super) fn copy_memory_to_image_info(
    dst_image: vk::Image,
    dst_image_layout: vk::ImageLayout,
    region: &vk::MemoryToImageCopy,
) -> vk::CopyMemoryToImageInfo {
    vk::CopyMemoryToImageInfo {
        s_type: vk::StructureType::COPY_MEMORY_TO_IMAGE_INFO,
        next: std::ptr::null(),
        flags: vk::HostImageCopyFlags::empty(),
        dst_image,
        dst_image_layout,
        region_count: 1,
        regions: region,
    }
}

pub(super) fn copy_image_to_memory_info(
    src_image: vk::Image,
    src_image_layout: vk::ImageLayout,
    region: &vk::ImageToMemoryCopy,
) -> vk::CopyImageToMemoryInfo {
    vk::CopyImageToMemoryInfo {
        s_type: vk::StructureType::COPY_IMAGE_TO_MEMORY_INFO,
        next: std::ptr::null(),
        flags: vk::HostImageCopyFlags::empty(),
        src_image,
        src_image_layout,
        region_count: 1,
        regions: region,
    }
}

pub(super) fn copy_image_to_image_info(
    src_image: vk::Image,
    src_image_layout: vk::ImageLayout,
    dst_image: vk::Image,
    dst_image_layout: vk::ImageLayout,
    region: &vk::ImageCopy2,
) -> vk::CopyImageToImageInfo {
    vk::CopyImageToImageInfo {
        s_type: vk::StructureType::COPY_IMAGE_TO_IMAGE_INFO,
        next: std::ptr::null(),
        flags: vk::HostImageCopyFlags::empty(),
        src_image,
        src_image_layout,
        dst_image,
        dst_image_layout,
        region_count: 1,
        regions: region,
    }
}

pub(super) fn image_copy2(
    src: vk::ImageSubresourceLayers,
    src_offset: vk::Offset3D,
    dst: vk::ImageSubresourceLayers,
    dst_offset: vk::Offset3D,
    extent: vk::Extent3D,
) -> vk::ImageCopy2 {
    vk::ImageCopy2 {
        s_type: vk::StructureType::IMAGE_COPY_2,
        next: std::ptr::null(),
        src_subresource: src,
        src_offset,
        dst_subresource: dst,
        dst_offset,
        extent,
    }
}

pub(super) fn make_extent_3d(width: u32, height: u32, depth: u32) -> vk::Extent3D {
    vk::Extent3D { width, height, depth }
}

pub(super) const ZERO_OFFSET: vk::Offset3D = vk::Offset3D { x: 0, y: 0, z: 0 };

fn image_create_info(
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
    array_layers: u32,
    tiling: vk::ImageTiling,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type,
        format,
        extent,
        mip_levels: 1,
        array_layers,
        samples: vk::SampleCountFlags::_1,
        tiling,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

fn host_copy_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::HOST_TRANSFER | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
}

// ---------------------------------------------------------------------------------------------------------------------
// array
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct HostImageArrayCopyTestParameters {
    format: vk::Format,
    offset: vk::Offset3D,
    copy_extent: vk::Extent3D,
    array_layers: u32,
    src_layer_offset: u32,
    dst_layer_offset: u32,
    tiling: vk::ImageTiling,
    remaining_layers: bool,
    cube_compatible: bool,
}

/// `getMaxLayers`
fn get_max_layers(array_layers: u32, src_layer_offset: u32, dst_layer_offset: u32) -> u32 {
    src_layer_offset.max(dst_layer_offset) + array_layers
}

fn image_type_for(params: &HostImageArrayCopyTestParameters) -> vk::ImageType {
    if params.offset.z > 1 || params.copy_extent.depth > 1 {
        vk::ImageType::_3D
    } else {
        vk::ImageType::_2D
    }
}

fn run_array_copy(context: &Context<'_>, params: HostImageArrayCopyTestParameters) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();

    let max_layers = get_max_layers(params.array_layers, params.src_layer_offset, params.dst_layer_offset);
    let image_width = params.offset.x as u32 + params.copy_extent.width;
    let image_height = params.offset.y as u32 + params.copy_extent.height;
    let image_depth = params.offset.z as u32 + params.copy_extent.depth;

    let sampled_channel_size = get_channel_size(params.format);
    let sampled_num_channels = get_num_channels(params.format);
    let sampled_buffer_count =
        params.copy_extent.width * params.copy_extent.height * params.copy_extent.depth * sampled_num_channels;
    let buffer_size = (sampled_buffer_count * sampled_channel_size * params.array_layers) as usize;

    let src_subresource_range = make_image_subresource_range(
        vk::ImageAspectFlags::COLOR,
        0,
        1,
        params.src_layer_offset,
        params.array_layers,
    );
    let dst_subresource_range = make_image_subresource_range(
        vk::ImageAspectFlags::COLOR,
        0,
        1,
        params.dst_layer_offset,
        params.array_layers,
    );

    let src_remaining_layers = params.remaining_layers && (params.src_layer_offset + params.array_layers == max_layers);
    let dst_remaining_layers = params.remaining_layers && (params.dst_layer_offset + params.array_layers == max_layers);
    let src_subresource_layer_count = if src_remaining_layers {
        vk::REMAINING_ARRAY_LAYERS
    } else {
        params.array_layers
    };
    let dst_subresource_layer_count = if dst_remaining_layers {
        vk::REMAINING_ARRAY_LAYERS
    } else {
        params.array_layers
    };

    let src_subresource_layers = make_image_subresource_layers(
        vk::ImageAspectFlags::COLOR,
        0,
        params.src_layer_offset,
        src_subresource_layer_count,
    );
    let dst_subresource_layers = make_image_subresource_layers(
        vk::ImageAspectFlags::COLOR,
        0,
        params.dst_layer_offset,
        dst_subresource_layer_count,
    );

    let mut test_data = vec![0u8; buffer_size];
    let mut output_data = vec![0u8; buffer_size];
    generate_data(&mut test_data, params.format);

    let mut create_flags = vk::ImageCreateFlags::empty();
    if params.cube_compatible {
        debug_assert!(max_layers == 6);
        create_flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
    }

    let create_info = image_create_info(
        create_flags,
        image_type_for(&params),
        params.format,
        make_extent_3d(image_width, image_height, image_depth),
        max_layers,
        params.tiling,
        host_copy_usage(),
    );

    let src_image = ImageWithMemory::new(vk, allocator, create_info, MemoryRequirement::ANY)?;
    let dst_image = ImageWithMemory::new(vk, allocator, create_info, MemoryRequirement::ANY)?;

    let mut transitions = [
        host_layout_transition(
            src_image.get(),
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            src_subresource_range,
        ),
        host_layout_transition(
            dst_image.get(),
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            dst_subresource_range,
        ),
    ];
    unsafe { vk.transition_image_layout_ext(&transitions) }.vk_check("vkTransitionImageLayoutEXT")?;

    let memory_to_image_region = memory_to_image_copy(
        test_data.as_ptr(),
        0,
        0,
        src_subresource_layers,
        params.offset,
        params.copy_extent,
    );
    let copy_memory_to_image_info = copy_memory_to_image_info(
        src_image.get(),
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        &memory_to_image_region,
    );
    unsafe { vk.copy_memory_to_image_ext(&copy_memory_to_image_info) }.vk_check("vkCopyMemoryToImageEXT")?;

    transitions[0].old_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
    transitions[0].new_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    unsafe { vk.transition_image_layout_ext(&transitions[0..1]) }.vk_check("vkTransitionImageLayoutEXT")?;

    let image_copy_region = image_copy2(
        src_subresource_layers,
        params.offset,
        dst_subresource_layers,
        params.offset,
        params.copy_extent,
    );
    let copy_image_to_image_info = copy_image_to_image_info(
        src_image.get(),
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        dst_image.get(),
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        &image_copy_region,
    );
    unsafe { vk.copy_image_to_image_ext(&copy_image_to_image_info) }.vk_check("vkCopyImageToImageEXT")?;

    transitions[1].old_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
    transitions[1].new_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    unsafe { vk.transition_image_layout_ext(&transitions[1..2]) }.vk_check("vkTransitionImageLayoutEXT")?;

    let region = image_to_memory_copy(
        output_data.as_mut_ptr(),
        0,
        0,
        dst_subresource_layers,
        params.offset,
        params.copy_extent,
    );
    let copy_image_to_memory_info =
        copy_image_to_memory_info(dst_image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, &region);
    unsafe { vk.copy_image_to_memory_ext(&copy_image_to_memory_info) }.vk_check("vkCopyImageToMemoryEXT")?;

    if test_data != output_data {
        if let Some(i) = (0..buffer_size).find(|&i| test_data[i] != output_data[i]) {
            log::info!(
                "At byte {} generated data is {}, but output data is {}",
                i,
                test_data[i],
                output_data[i]
            );
        }
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

struct HostImageArrayCopyTestCase {
    name: String,
    params: HostImageArrayCopyTestParameters,
}

impl TestCase for HostImageArrayCopyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_host_image_copy_feature(context)?;

        let host_image_copy_properties = get_host_image_copy_properties(context);
        for layout in [
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        ] {
            if !host_image_copy_properties.src_layouts.contains(&layout) {
                return Err(TestError::NotSupported("Required src layout not supported".to_string()));
            }
            if !host_image_copy_properties.dst_layouts.contains(&layout) {
                return Err(TestError::NotSupported("Required dst layout not supported".to_string()));
            }
        }

        let max_array_layers = query_max_array_layers(
            context,
            self.params.format,
            image_type_for(&self.params),
            self.params.tiling,
        )?;

        let max_layers = get_max_layers(
            self.params.array_layers,
            self.params.src_layer_offset,
            self.params.dst_layer_offset,
        );
        if max_array_layers < max_layers {
            return Err(TestError::NotSupported(
                "Required image array layers not supported.".to_string(),
            ));
        }

        check_supported_format_features(context, self.params.format, self.params.tiling).map(|_| ())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(HostImageArrayCopyTestInstance {
            context,
            params: self.params,
        })
    }
}

struct HostImageArrayCopyTestInstance<'a> {
    context: &'a Context<'a>,
    params: HostImageArrayCopyTestParameters,
}

impl TestInstance for HostImageArrayCopyTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_array_copy(self.context, self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// properties
// ---------------------------------------------------------------------------------------------------------------------

struct PropertiesTestCase;

impl TestCase for PropertiesTestCase {
    fn name(&self) -> &str {
        "properties"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_host_image_copy")
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PropertiesTestInstance { context })
    }
}

struct PropertiesTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for PropertiesTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let host_image_copy_properties = get_host_image_copy_properties(self.context);

        if host_image_copy_properties.src_layouts.is_empty() {
            return Ok(TestStatus::fail("copySrcLayoutCount is 0"));
        }
        if host_image_copy_properties.dst_layouts.is_empty() {
            return Ok(TestStatus::fail("copyDstLayoutCount is 0"));
        }

        if !host_image_copy_properties
            .src_layouts
            .contains(&vk::ImageLayout::GENERAL)
        {
            return Ok(TestStatus::fail(
                "VK_IMAGE_LAYOUT_GENERAL not supported for src host copy",
            ));
        }
        if !host_image_copy_properties
            .dst_layouts
            .contains(&vk::ImageLayout::GENERAL)
        {
            return Ok(TestStatus::fail(
                "VK_IMAGE_LAYOUT_GENERAL not supported for dst host copy",
            ));
        }

        if host_image_copy_properties
            .optimal_tiling_layout_uuid
            .iter()
            .all(|&byte| byte == 0)
        {
            return Ok(TestStatus::fail("All bytes of optimalTilingLayoutUUID are 0"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// query
// ---------------------------------------------------------------------------------------------------------------------

struct QueryTestCase {
    name: String,
    format: vk::Format,
    tiling: vk::ImageTiling,
}

impl TestCase for QueryTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_host_image_copy")?;

        let mut format_properties3 = vk::FormatProperties3::default();
        {
            let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
            unsafe {
                context.get_instance().get_physical_device_format_properties2(
                    context.get_physical_device(),
                    self.format,
                    &mut format_properties2,
                )
            };
        }
        if self.tiling == vk::ImageTiling::OPTIMAL
            && !format_properties3
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags2::SAMPLED_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Format feature sampled image bit not supported for optimal tiling.".to_string(),
            ));
        }
        if self.tiling == vk::ImageTiling::LINEAR
            && !format_properties3
                .linear_tiling_features
                .contains(vk::FormatFeatureFlags2::SAMPLED_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Format feature sampled image bit not supported for linear tiling.".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(QueryTestInstance {
            context,
            format: self.format,
            tiling: self.tiling,
        })
    }
}

struct QueryTestInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    tiling: vk::ImageTiling,
}

impl TestInstance for QueryTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let instance = self.context.get_instance();
        let physical_device = self.context.get_physical_device();

        let image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
            format: self.format,
            type_: vk::ImageType::_2D,
            tiling: self.tiling,
            usage: vk::ImageUsageFlags::HOST_TRANSFER,
            flags: vk::ImageCreateFlags::empty(),
            ..Default::default()
        };

        let mut host_image_copy_device_performance_query = vk::HostImageCopyDevicePerformanceQuery::default();
        let res = {
            let mut image_format_properties =
                vk::ImageFormatProperties2::builder().push_next(&mut host_image_copy_device_performance_query);
            unsafe {
                instance.get_physical_device_image_format_properties2(
                    physical_device,
                    &image_format_info,
                    &mut image_format_properties,
                )
            }
        };

        if host_image_copy_device_performance_query.identical_memory_layout == vk::TRUE
            && host_image_copy_device_performance_query.optimal_device_access != vk::TRUE
        {
            log::info!(
                "VkHostImageCopyDevicePerformanceQueryEXT::identicalMemoryLayout is VK_TRUE, but VkHostImageCopyDevicePerformanceQueryEXT::optimalDeviceAccess is VK_FALSE"
            );
            return Ok(TestStatus::fail("Fail"));
        }

        if is_block_compressed_format(self.format)
            && res.is_ok()
            && host_image_copy_device_performance_query.optimal_device_access != vk::TRUE
        {
            log::info!(
                "Format is a block compressed format and vkGetPhysicalDeviceImageFormatProperties2 returned VK_SUCCESS, but VkHostImageCopyDevicePerformanceQueryEXT::optimalDeviceAccess is VK_FALSE"
            );
            return Ok(TestStatus::fail("Fail"));
        }

        if !is_depth_stencil_format(self.format) {
            let mut format_properties3 = vk::FormatProperties3::default();
            {
                let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
                unsafe {
                    instance.get_physical_device_format_properties2(
                        physical_device,
                        self.format,
                        &mut format_properties2,
                    )
                };
            }

            let features = if self.tiling == vk::ImageTiling::OPTIMAL {
                Some(("optimalTilingFeatures", format_properties3.optimal_tiling_features))
            } else if self.tiling == vk::ImageTiling::LINEAR {
                Some(("linearTilingFeatures", format_properties3.linear_tiling_features))
            } else {
                None
            };
            if let Some((features_name, features)) = features
                && !features.contains(vk::FormatFeatureFlags2::HOST_IMAGE_TRANSFER)
            {
                log::info!(
                    "VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT is supported in {} for format {:?}, but VK_FORMAT_FEATURE_2_HOST_IMAGE_TRANSFER_BIT_EXT is not",
                    features_name,
                    self.format
                );
                return Ok(TestStatus::fail(
                    "VK_FORMAT_FEATURE_2_HOST_IMAGE_TRANSFER_BIT_EXT not supported",
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// simple and padding
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct SimpleHostImageCopyTestParameters {
    format: vk::Format,
    tiling: vk::ImageTiling,
    src_layout: vk::ImageLayout,
    dst_layout: vk::ImageLayout,
    depth: u32,
    array_layers: u32,
    row_padding: u32,
    height_padding: u32,
}

/// `SimpleHostImageCopyTestInstance::getBufferSize`
fn get_buffer_size(format: vk::Format, array_layers: u32, extent: vk::Extent3D) -> u32 {
    use vk::Format as F;

    let mut buffer_size = extent.width * extent.height * extent.depth * array_layers;

    if is_astc_format(format) || is_astc_hdr_format(format) {
        return buffer_size * 16 / crate::vk::compressed_formats::get_block_width(format) / get_block_height(format);
    }

    match format {
        F::R4G4B4A4_UNORM_PACK16
        | F::B4G4R4A4_UNORM_PACK16
        | F::R5G6B5_UNORM_PACK16
        | F::B5G6R5_UNORM_PACK16
        | F::R5G5B5A1_UNORM_PACK16
        | F::B5G5R5A1_UNORM_PACK16
        | F::A1R5G5B5_UNORM_PACK16
        | F::R8G8_UNORM
        | F::R8G8_SNORM
        | F::R8G8_USCALED
        | F::R8G8_SSCALED
        | F::R8G8_UINT
        | F::R8G8_SINT
        | F::R8G8_SRGB
        | F::R16_UNORM
        | F::R16_SNORM
        | F::R16_USCALED
        | F::R16_SSCALED
        | F::R16_UINT
        | F::R16_SINT
        | F::R16_SFLOAT
        | F::D16_UNORM
        | F::R10X6_UNORM_PACK16
        | F::R12X4_UNORM_PACK16
        | F::A4R4G4B4_UNORM_PACK16
        | F::A4B4G4R4_UNORM_PACK16
        | F::A1B5G5R5_UNORM_PACK16 => buffer_size *= 2,
        F::R8G8B8_UNORM
        | F::R8G8B8_SNORM
        | F::R8G8B8_USCALED
        | F::R8G8B8_SSCALED
        | F::R8G8B8_UINT
        | F::R8G8B8_SINT
        | F::R8G8B8_SRGB
        | F::B8G8R8_UNORM
        | F::B8G8R8_SNORM
        | F::B8G8R8_USCALED
        | F::B8G8R8_SSCALED
        | F::B8G8R8_UINT
        | F::B8G8R8_SINT
        | F::B8G8R8_SRGB
        | F::D16_UNORM_S8_UINT => buffer_size *= 3,
        F::R8G8B8A8_UNORM
        | F::R8G8B8A8_SNORM
        | F::R8G8B8A8_USCALED
        | F::R8G8B8A8_SSCALED
        | F::R8G8B8A8_UINT
        | F::R8G8B8A8_SINT
        | F::R8G8B8A8_SRGB
        | F::B8G8R8A8_UNORM
        | F::B8G8R8A8_SNORM
        | F::B8G8R8A8_USCALED
        | F::B8G8R8A8_SSCALED
        | F::B8G8R8A8_UINT
        | F::B8G8R8A8_SINT
        | F::B8G8R8A8_SRGB
        | F::A8B8G8R8_UNORM_PACK32
        | F::A8B8G8R8_SNORM_PACK32
        | F::A8B8G8R8_USCALED_PACK32
        | F::A8B8G8R8_SSCALED_PACK32
        | F::A8B8G8R8_UINT_PACK32
        | F::A8B8G8R8_SINT_PACK32
        | F::A8B8G8R8_SRGB_PACK32
        | F::A2R10G10B10_UNORM_PACK32
        | F::A2R10G10B10_SNORM_PACK32
        | F::A2R10G10B10_USCALED_PACK32
        | F::A2R10G10B10_SSCALED_PACK32
        | F::A2R10G10B10_UINT_PACK32
        | F::A2R10G10B10_SINT_PACK32
        | F::A2B10G10R10_UNORM_PACK32
        | F::A2B10G10R10_SNORM_PACK32
        | F::A2B10G10R10_USCALED_PACK32
        | F::A2B10G10R10_SSCALED_PACK32
        | F::A2B10G10R10_UINT_PACK32
        | F::A2B10G10R10_SINT_PACK32
        | F::R16G16_UNORM
        | F::R16G16_SNORM
        | F::R16G16_USCALED
        | F::R16G16_SSCALED
        | F::R16G16_UINT
        | F::R16G16_SINT
        | F::R16G16_SFLOAT
        | F::R32_UINT
        | F::R32_SINT
        | F::R32_SFLOAT
        | F::B10G11R11_UFLOAT_PACK32
        | F::E5B9G9R9_UFLOAT_PACK32
        | F::X8_D24_UNORM_PACK32
        | F::D32_SFLOAT
        | F::D24_UNORM_S8_UINT
        | F::R10X6G10X6_UNORM_2PACK16
        | F::R12X4G12X4_UNORM_2PACK16 => buffer_size *= 4,
        F::R16G16B16_UNORM
        | F::R16G16B16_SNORM
        | F::R16G16B16_USCALED
        | F::R16G16B16_SSCALED
        | F::R16G16B16_UINT
        | F::R16G16B16_SINT
        | F::R16G16B16_SFLOAT => buffer_size *= 6,
        F::R16G16B16A16_UNORM
        | F::R16G16B16A16_SNORM
        | F::R16G16B16A16_USCALED
        | F::R16G16B16A16_SSCALED
        | F::R16G16B16A16_UINT
        | F::R16G16B16A16_SINT
        | F::R16G16B16A16_SFLOAT
        | F::R32G32_UINT
        | F::R32G32_SINT
        | F::R32G32_SFLOAT
        | F::R64_UINT
        | F::R64_SINT
        | F::R64_SFLOAT
        | F::R10X6G10X6B10X6A10X6_UNORM_4PACK16
        | F::R12X4G12X4B12X4A12X4_UNORM_4PACK16 => buffer_size *= 8,
        F::R32G32B32_UINT | F::R32G32B32_SINT | F::R32G32B32_SFLOAT => buffer_size *= 12,
        F::R32G32B32A32_UINT
        | F::R32G32B32A32_SINT
        | F::R32G32B32A32_SFLOAT
        | F::R64G64_UINT
        | F::R64G64_SINT
        | F::R64G64_SFLOAT => buffer_size *= 16,
        F::R64G64B64_UINT | F::R64G64B64_SINT | F::R64G64B64_SFLOAT => buffer_size *= 24,
        F::R64G64B64A64_UINT | F::R64G64B64A64_SINT | F::R64G64B64A64_SFLOAT => buffer_size *= 32,
        F::D32_SFLOAT_S8_UINT => buffer_size *= 5,
        F::BC1_RGB_UNORM_BLOCK
        | F::BC1_RGB_SRGB_BLOCK
        | F::BC1_RGBA_UNORM_BLOCK
        | F::BC1_RGBA_SRGB_BLOCK
        | F::BC4_UNORM_BLOCK
        | F::BC4_SNORM_BLOCK
        | F::ETC2_R8G8B8_UNORM_BLOCK
        | F::ETC2_R8G8B8_SRGB_BLOCK
        | F::ETC2_R8G8B8A1_UNORM_BLOCK
        | F::ETC2_R8G8B8A1_SRGB_BLOCK
        | F::EAC_R11_UNORM_BLOCK
        | F::EAC_R11_SNORM_BLOCK => buffer_size /= 2,
        F::G8B8G8R8_422_UNORM | F::B8G8R8G8_422_UNORM => buffer_size = buffer_size * 4 / 2,
        F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
        | F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
        | F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
        | F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
        | F::G16B16G16R16_422_UNORM
        | F::B16G16R16G16_422_UNORM => buffer_size = buffer_size * 8 / 2,
        _ => {}
    }
    buffer_size
}

/// `SimpleHostImageCopyTestInstance::getAspect`
fn get_aspect(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::D16_UNORM | vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D32_SFLOAT => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        }
        _ => vk::ImageAspectFlags::COLOR,
    }
}

fn read_u32(data: &[u8], index: usize) -> u32 {
    u32::from_ne_bytes(data[index * 4..index * 4 + 4].try_into().unwrap())
}

fn read_u16(data: &[u8], index: usize) -> u16 {
    u16::from_ne_bytes(data[index * 2..index * 2 + 2].try_into().unwrap())
}

/// `SimpleHostImageCopyTestInstance::verifyData`
fn verify_data(format: vk::Format, test_data: &[u8], result_data: &[u8], buffer_size: usize) -> bool {
    use vk::Format as F;

    if format == F::X8_D24_UNORM_PACK32 {
        for i in 0..buffer_size / 4 {
            if (read_u32(test_data, i) & 0x00ff_ffff) != (read_u32(result_data, i) & 0x00ff_ffff) {
                return false;
            }
        }
    } else if matches!(
        format,
        F::R10X6_UNORM_PACK16
            | F::R10X6G10X6_UNORM_2PACK16
            | F::R10X6G10X6B10X6A10X6_UNORM_4PACK16
            | F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
            | F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
    ) {
        for i in 0..buffer_size / 2 {
            if (read_u16(test_data, i) & 0xffc0) != (read_u16(result_data, i) & 0xffc0) {
                return false;
            }
        }
    } else if matches!(
        format,
        F::R12X4_UNORM_PACK16
            | F::R12X4G12X4_UNORM_2PACK16
            | F::R12X4G12X4B12X4A12X4_UNORM_4PACK16
            | F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
            | F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
    ) {
        for i in 0..buffer_size / 2 {
            if (read_u16(test_data, i) & 0xfff0) != (read_u16(result_data, i) & 0xfff0) {
                return false;
            }
        }
    } else if test_data[..buffer_size] != result_data[..buffer_size] {
        return false;
    }
    true
}

fn run_simple_copy(context: &Context<'_>, params: SimpleHostImageCopyTestParameters) -> TestOutcome {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let image_size = make_extent_3d(240, 240, params.depth);
    let image_type = if params.depth > 1 {
        vk::ImageType::_3D
    } else {
        vk::ImageType::_2D
    };
    let aspect = get_aspect(params.format);
    let depth_and_stencil = aspect.contains(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL);

    let subresource_range = make_image_subresource_range(aspect, 0, 1, 0, params.array_layers);
    let subresource_layers = make_image_subresource_layers(aspect, 0, 0, params.array_layers);
    let mut buffer_size = get_buffer_size(params.format, params.array_layers, image_size);
    let mut memory_row_length = 0u32;
    let mut memory_image_height = 0u32;

    if params.row_padding > 0 || params.height_padding > 0 {
        memory_row_length = image_size.width + params.row_padding;
        memory_image_height = image_size.height + params.height_padding;
        let memory_size = make_extent_3d(memory_row_length, memory_image_height, image_size.depth);
        buffer_size = get_buffer_size(params.format, params.array_layers, memory_size);
    }

    let buffer_len = buffer_size as usize;
    let mut test_data = vec![0u8; buffer_len];
    let mut result_data = vec![0u8; buffer_len];
    let mut result_data_stencil = vec![0u8; buffer_len];
    let mut result_data2 = vec![0u8; buffer_len];
    let mut result_data2_stencil = vec![0u8; buffer_len];
    generate_data(&mut test_data, params.format);

    if params.row_padding > 0 || params.height_padding > 0 {
        debug_assert!(params.depth == 1);
        debug_assert!(params.array_layers == 1);
        let block_height = if is_compressed_format(params.format) {
            get_block_height(params.format)
        } else {
            1
        };
        let row_extent = get_buffer_size(params.format, 1, make_extent_3d(memory_row_length, block_height, 1)) as usize;
        let image_row_extent =
            get_buffer_size(params.format, 1, make_extent_3d(image_size.width, block_height, 1)) as usize;
        let slice_extent = get_buffer_size(
            params.format,
            1,
            make_extent_3d(memory_row_length, memory_image_height, 1),
        ) as usize;
        let row_count = (image_size.height / block_height) as usize;

        for row in 0..row_count {
            let start = row * row_extent + image_row_extent;
            test_data[start..start + (row_extent - image_row_extent)].fill(0);
        }
        let start = row_count * row_extent;
        test_data[start..start + (slice_extent - row_count * row_extent)].fill(0);
    }

    let create_info = image_create_info(
        vk::ImageCreateFlags::empty(),
        image_type,
        params.format,
        image_size,
        params.array_layers,
        params.tiling,
        host_copy_usage(),
    );

    let image = ImageWithMemory::new(vk, allocator, create_info, MemoryRequirement::ANY)?;
    let image2 = ImageWithMemory::new(vk, allocator, create_info, MemoryRequirement::ANY)?;
    let image3 = ImageWithMemory::new(vk, allocator, create_info, MemoryRequirement::ANY)?;

    let src_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(u64::from(buffer_size), vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let src_buffer_alloc = src_buffer.get_allocation();
    unsafe { std::ptr::copy_nonoverlapping(test_data.as_ptr(), src_buffer_alloc.get_host_ptr(), buffer_len) };
    flush_alloc(vk, src_buffer_alloc)?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    {
        let mut transition = host_layout_transition(
            image.get(),
            vk::ImageLayout::UNDEFINED,
            params.dst_layout,
            subresource_range,
        );
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
        transition.image = image2.get();
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
        transition.image = image3.get();
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
    }
    {
        let mut region = memory_to_image_copy(
            test_data.as_ptr(),
            memory_row_length,
            memory_image_height,
            subresource_layers,
            ZERO_OFFSET,
            image_size,
        );

        if !depth_and_stencil {
            let info = copy_memory_to_image_info(image.get(), params.dst_layout, &region);
            unsafe { vk.copy_memory_to_image_ext(&info) }.vk_check("vkCopyMemoryToImageEXT")?;
        } else {
            region.image_subresource.aspect_mask = vk::ImageAspectFlags::DEPTH;
            let info = copy_memory_to_image_info(image.get(), params.dst_layout, &region);
            unsafe { vk.copy_memory_to_image_ext(&info) }.vk_check("vkCopyMemoryToImageEXT")?;
            region.image_subresource.aspect_mask = vk::ImageAspectFlags::STENCIL;
            let info = copy_memory_to_image_info(image.get(), params.dst_layout, &region);
            unsafe { vk.copy_memory_to_image_ext(&info) }.vk_check("vkCopyMemoryToImageEXT")?;
        }

        if !depth_and_stencil {
            let pre_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                src_buffer.get(),
                0,
                u64::from(buffer_size),
            );
            let buffer_image_copy = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: memory_row_length,
                buffer_image_height: memory_image_height,
                image_subresource: subresource_layers,
                image_offset: ZERO_OFFSET,
                image_extent: image_size,
            };
            begin_command_buffer(vk, cmd)?;
            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[pre_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                vk.cmd_copy_buffer_to_image(
                    cmd,
                    src_buffer.get(),
                    image2.get(),
                    params.dst_layout,
                    &[buffer_image_copy],
                );
            }
            end_command_buffer(vk, cmd)?;
            submit_commands_and_wait(vk, queue, cmd)?;
        }
    }
    if params.dst_layout != params.src_layout {
        let mut transition =
            host_layout_transition(image.get(), params.dst_layout, params.src_layout, subresource_range);
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
        transition.image = image2.get();
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
    }
    {
        let region = image_copy2(
            subresource_layers,
            ZERO_OFFSET,
            subresource_layers,
            ZERO_OFFSET,
            image_size,
        );

        let src_image = if depth_and_stencil { image.get() } else { image2.get() };

        let image_to_image_copy =
            copy_image_to_image_info(src_image, params.src_layout, image3.get(), params.dst_layout, &region);
        unsafe { vk.copy_image_to_image_ext(&image_to_image_copy) }.vk_check("vkCopyImageToImageEXT")?;
    }
    if params.dst_layout != params.src_layout {
        let transition = host_layout_transition(image3.get(), params.dst_layout, params.src_layout, subresource_range);
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
    }
    {
        let mut region = image_to_memory_copy(
            result_data.as_mut_ptr(),
            memory_row_length,
            memory_image_height,
            subresource_layers,
            ZERO_OFFSET,
            image_size,
        );

        if !depth_and_stencil {
            let info = copy_image_to_memory_info(image.get(), params.src_layout, &region);
            unsafe { vk.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
        } else {
            region.image_subresource.aspect_mask = vk::ImageAspectFlags::DEPTH;
            let info = copy_image_to_memory_info(image.get(), params.src_layout, &region);
            unsafe { vk.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
            region.host_pointer = result_data_stencil.as_mut_ptr().cast();
            region.image_subresource.aspect_mask = vk::ImageAspectFlags::STENCIL;
            let info = copy_image_to_memory_info(image.get(), params.src_layout, &region);
            unsafe { vk.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
        }

        region.host_pointer = result_data2.as_mut_ptr().cast();
        if !depth_and_stencil {
            let info = copy_image_to_memory_info(image3.get(), params.src_layout, &region);
            unsafe { vk.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
        } else {
            region.image_subresource.aspect_mask = vk::ImageAspectFlags::DEPTH;
            let info = copy_image_to_memory_info(image3.get(), params.src_layout, &region);
            unsafe { vk.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
            region.host_pointer = result_data2_stencil.as_mut_ptr().cast();
            region.image_subresource.aspect_mask = vk::ImageAspectFlags::STENCIL;
            let info = copy_image_to_memory_info(image3.get(), params.src_layout, &region);
            unsafe { vk.copy_image_to_memory_ext(&info) }.vk_check("vkCopyImageToMemoryEXT")?;
        }
    }

    if depth_and_stencil {
        let texel_count = (image_size.width * image_size.height * image_size.depth * params.array_layers) as usize;
        if params.format == vk::Format::D16_UNORM_S8_UINT {
            let depth_buffer_size = texel_count * 2;
            let depth1 = verify_data(params.format, &test_data, &result_data, depth_buffer_size);
            let depth2 = verify_data(params.format, &test_data, &result_data2, depth_buffer_size);
            if !depth1 || !depth2 {
                return Ok(TestStatus::fail("Depth copy failed"));
            }
        } else if params.format == vk::Format::D24_UNORM_S8_UINT {
            for i in 0..buffer_len / 4 {
                let src = read_u32(&test_data, i);
                let res1 = read_u32(&result_data, i);
                let res2 = read_u32(&result_data2, i);
                if (src & 0x00ff_ffff) != (res1 & 0x00ff_ffff) || (src & 0x00ff_ffff) != (res2 & 0x00ff_ffff) {
                    return Ok(TestStatus::fail("Depth copy failed"));
                }
            }
        } else if params.format == vk::Format::D32_SFLOAT_S8_UINT {
            let depth_buffer_size = texel_count * 4;
            let depth1 = verify_data(params.format, &test_data, &result_data, depth_buffer_size);
            let depth2 = verify_data(params.format, &test_data, &result_data2, depth_buffer_size);
            if !depth1 || !depth2 {
                return Ok(TestStatus::fail("Depth copy failed"));
            }
        }
        let stencil_buffer_size = texel_count;
        let stencil1 = verify_data(params.format, &test_data, &result_data_stencil, stencil_buffer_size);
        let stencil2 = verify_data(params.format, &test_data, &result_data2_stencil, stencil_buffer_size);
        if !stencil1 || !stencil2 {
            return Ok(TestStatus::fail("Stencil copy failed"));
        }
    } else if params.format == vk::Format::E5B9G9R9_UFLOAT_PACK32 {
        for i in 0..buffer_len / 4 {
            let src = read_u32(&test_data, i);
            let res1 = read_u32(&result_data, i);
            let res2 = read_u32(&result_data2, i);
            let result1 = unpack_rgb999e5(src) == unpack_rgb999e5(res1);
            let result2 = unpack_rgb999e5(src) == unpack_rgb999e5(res2);
            if !result1 || !result2 {
                return Ok(TestStatus::fail("Fail"));
            }
        }
    } else {
        let result1 = verify_data(params.format, &test_data, &result_data, buffer_len);
        let result2 = verify_data(params.format, &test_data, &result_data2, buffer_len);
        if !result1 || !result2 {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct SimpleHostImageCopyTestCase {
    name: String,
    params: SimpleHostImageCopyTestParameters,
}

impl TestCase for SimpleHostImageCopyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;

        context.require_device_functionality("VK_EXT_host_image_copy")?;

        // Only a lone aspect reaches vkCmdCopyBufferToImage; combined formats take the host path and record nothing.
        let copies_depth_stencil_aspect = is_depth_stencil_format(params.format)
            && map_vk_format(params.format).is_some_and(|f| f.order != ChannelOrder::DS);
        if copies_depth_stencil_aspect {
            let queue_props = unsafe {
                context
                    .get_instance()
                    .get_physical_device_queue_family_properties(context.get_physical_device())
            };
            if !queue_props[context.get_universal_queue_family_index() as usize]
                .queue_flags
                .contains(vk::QueueFlags::GRAPHICS)
            {
                return Err(TestError::NotSupported(
                    "Depth/stencil buffer to image copy requires a graphics queue".to_string(),
                ));
            }
        }

        require_host_image_copy_feature(context)?;

        let raw = params.format.as_raw();
        if raw >= vk::Format::G8B8G8R8_422_UNORM.as_raw() && raw <= vk::Format::G16_B16_R16_3PLANE_444_UNORM.as_raw() {
            context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;
        }
        if raw >= vk::Format::G8_B8R8_2PLANE_444_UNORM.as_raw()
            && raw <= vk::Format::G16_B16R16_2PLANE_444_UNORM.as_raw()
        {
            context.require_device_functionality("VK_EXT_ycbcr_2plane_444_formats")?;
        }
        if params.format == vk::Format::G8_B8R8_2PLANE_444_UNORM
            || params.format == vk::Format::G16_B16R16_2PLANE_444_UNORM
        {
            context.require_device_functionality("VK_EXT_4444_formats")?;
        }
        if raw >= vk::Format::ASTC_4X4_SFLOAT_BLOCK.as_raw() && raw <= vk::Format::ASTC_12X12_SFLOAT_BLOCK.as_raw() {
            context.require_device_functionality("VK_EXT_texture_compression_astc_hdr")?;
        }
        if params.format == vk::Format::A1B5G5R5_UNORM_PACK16 || params.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        let image_type = if params.depth > 1 {
            vk::ImageType::_3D
        } else {
            vk::ImageType::_2D
        };
        let max_array_layers = query_max_array_layers(context, params.format, image_type, params.tiling)?;

        if max_array_layers < params.array_layers {
            return Err(TestError::NotSupported(
                "Required image array layers not supported.".to_string(),
            ));
        }

        check_supported_format_features(context, params.format, params.tiling)?;

        let host_image_copy_properties = get_host_image_copy_properties(context);
        if !host_image_copy_properties.src_layouts.contains(&params.src_layout) {
            return Err(TestError::NotSupported(
                "Layout not supported for src host copy".to_string(),
            ));
        }
        if !host_image_copy_properties.dst_layouts.contains(&params.dst_layout) {
            return Err(TestError::NotSupported(
                "Layout not supported for dst host copy".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SimpleHostImageCopyTestInstance {
            context,
            params: self.params,
        })
    }
}

struct SimpleHostImageCopyTestInstance<'a> {
    context: &'a Context<'a>,
    params: SimpleHostImageCopyTestParameters,
}

impl TestInstance for SimpleHostImageCopyTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_simple_copy(self.context, self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// test tree
// ---------------------------------------------------------------------------------------------------------------------

/// `testGenerator`, restricted to the groups listed in the file header.
fn add_array_group(test_group: &mut TestCaseGroup) {
    let format_array_tests = [
        (vk::Format::R8_UNORM, "r8_unorm"),
        (vk::Format::R16_UNORM, "r16_unorm"),
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::R8G8_UNORM, "r8g8_unorm"),
        (vk::Format::R32_SFLOAT, "r32_sfloat"),
    ];
    let tiling_array_tests = [
        (vk::ImageTiling::LINEAR, "linear"),
        (vk::ImageTiling::OPTIMAL, "optimal"),
    ];
    let size_array_tests = [
        (vk::Offset3D { x: 0, y: 0, z: 0 }, make_extent_3d(16, 16, 1), "16x16x1"),
        (
            vk::Offset3D { x: 32, y: 32, z: 0 },
            make_extent_3d(16, 16, 1),
            "32x32_16x16x1",
        ),
        (vk::Offset3D { x: 0, y: 0, z: 0 }, make_extent_3d(53, 61, 1), "53x61x1"),
        (
            vk::Offset3D { x: 17, y: 13, z: 0 },
            make_extent_3d(53, 61, 1),
            "17x19_53x61x1",
        ),
        (vk::Offset3D { x: 0, y: 0, z: 0 }, make_extent_3d(14, 14, 3), "14x14x3"),
    ];
    let array_layers_tests = [
        (1u32, 0u32, 0u32, "1_0_0"),
        (2, 0, 0, "2_0_0"),
        (6, 0, 0, "6_0_0"),
        (4, 1, 3, "4_1_3"),
        (4, 3, 1, "4_3_1"),
        (1, 6, 2, "1_6_2"),
    ];

    let mut array_group = TestCaseGroup::new("array");
    for (format, format_name) in format_array_tests {
        let mut formats_group = TestCaseGroup::new(format_name);

        for (tiling, tiling_name) in tiling_array_tests {
            let mut tiling_group = TestCaseGroup::new(tiling_name);

            for (array_layers, src_layer_offset, dst_layer_offset, array_layers_name) in array_layers_tests {
                let mut array_layers_group = TestCaseGroup::new(array_layers_name);

                for (offset, size, size_name) in size_array_tests {
                    for remaining_layers in [false, true] {
                        // VUID-VkCopyMemoryToImageInfoEXT-dstImage-07983.
                        if remaining_layers && size.depth > 1 {
                            continue;
                        }

                        for cube_compatible in [false, true] {
                            let max_layers = get_max_layers(array_layers, src_layer_offset, dst_layer_offset);
                            if cube_compatible && (max_layers != 6 || size.width != size.height) {
                                continue;
                            }

                            let params = HostImageArrayCopyTestParameters {
                                format,
                                offset,
                                copy_extent: size,
                                array_layers,
                                src_layer_offset,
                                dst_layer_offset,
                                tiling,
                                remaining_layers,
                                cube_compatible,
                            };

                            let test_name = format!(
                                "{}{}{}",
                                size_name,
                                if cube_compatible { "_cube" } else { "" },
                                if remaining_layers { "_remaining_layers" } else { "" }
                            );

                            array_layers_group.add_child(Box::new(HostImageArrayCopyTestCase {
                                name: test_name,
                                params,
                            }) as Box<dyn TestCase>);
                        }
                    }
                }
                tiling_group.add_child(array_layers_group);
            }
            formats_group.add_child(tiling_group);
        }
        array_group.add_child(formats_group);
    }
    test_group.add_child(array_group);
}

/// `createImageHostImageCopyTests`
pub fn create_image_host_image_copy_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("host_image_copy");

    let tiling_tests = [
        (vk::ImageTiling::LINEAR, "linear"),
        (vk::ImageTiling::OPTIMAL, "optimal"),
    ];
    let image_layout_tests = [
        (vk::ImageLayout::GENERAL, vk::ImageLayout::GENERAL, "general_general"),
        (
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            "transfer_src_transfer_dst",
        ),
    ];

    add_array_group(&mut test_group);
    add_preinitialized_groups(&mut test_group);

    let mut properties_group = TestCaseGroup::new("properties");
    properties_group.add_child(Box::new(PropertiesTestCase) as Box<dyn TestCase>);

    let query_formats = [
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
        (vk::Format::R16_UNORM, "r16_unorm"),
        (vk::Format::R16G16_UINT, "r16g16_uint"),
        (vk::Format::B8G8R8A8_SINT, "b8g8r8a8_sint"),
        (vk::Format::R16_SFLOAT, "r16_sfloat"),
        (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
        (vk::Format::D32_SFLOAT, "d32_sfloat"),
        (vk::Format::BC7_UNORM_BLOCK, "bc7_unorm_block"),
        (vk::Format::BC5_SNORM_BLOCK, "bc5_snorm_block"),
    ];

    test_group.add_child(properties_group);

    let mut query_group = TestCaseGroup::new("query");
    for (tiling, tiling_name) in tiling_tests {
        let mut tiling_group = TestCaseGroup::new(tiling_name);
        for (format, format_name) in query_formats {
            tiling_group.add_child(Box::new(QueryTestCase {
                name: format_name.to_string(),
                format,
                tiling,
            }) as Box<dyn TestCase>);
        }
        query_group.add_child(tiling_group);
    }
    test_group.add_child(query_group);

    test_group.add_child(create_identical_memory_layout_group(&tiling_tests, &query_formats));

    let image_params_tests = [(1u32, 1u32, "1_1"), (4, 1, "4_1"), (1, 4, "1_4")];

    let mut simple_group = TestCaseGroup::new("simple");
    for &(format, format_name) in NON_PLANAR_FORMATS {
        let mut format_group = TestCaseGroup::new(format_name);
        for (tiling, tiling_name) in tiling_tests {
            let mut tiling_group = TestCaseGroup::new(tiling_name);
            for (src_layout, dst_layout, layout_name) in image_layout_tests {
                let mut layout_group = TestCaseGroup::new(layout_name);
                for (depth, array_layers, image_params_name) in image_params_tests {
                    // Formats that require ycbcr conversion can not be 3d
                    if depth > 1 && YCBCR_FORMATS.contains(&format) {
                        continue;
                    }

                    let params = SimpleHostImageCopyTestParameters {
                        format,
                        tiling,
                        src_layout,
                        dst_layout,
                        depth,
                        array_layers,
                        row_padding: 0,
                        height_padding: 0,
                    };
                    layout_group.add_child(Box::new(SimpleHostImageCopyTestCase {
                        name: image_params_name.to_string(),
                        params,
                    }) as Box<dyn TestCase>);
                }
                tiling_group.add_child(layout_group);
            }
            format_group.add_child(tiling_group);
        }
        simple_group.add_child(format_group);
    }
    test_group.add_child(simple_group);

    let padding_tests = [(4u32, 4u32, "4_4"), (64, 32, "64_32")];
    let padding_formats = [
        (vk::Format::BC3_SRGB_BLOCK, "bc3_srgb_block"),
        (vk::Format::BC5_SNORM_BLOCK, "bc5_snorm_block"),
        (vk::Format::BC7_UNORM_BLOCK, "bc7_unorm_block"),
    ];

    let mut padding_group = TestCaseGroup::new("padding");
    for (row_padding, height_padding, padding_name) in padding_tests {
        let mut format_group = TestCaseGroup::new(padding_name);
        for (format, format_name) in padding_formats {
            let params = SimpleHostImageCopyTestParameters {
                format,
                tiling: vk::ImageTiling::OPTIMAL,
                src_layout: vk::ImageLayout::GENERAL,
                dst_layout: vk::ImageLayout::GENERAL,
                depth: 1,
                array_layers: 1,
                row_padding,
                height_padding,
            };
            format_group.add_child(Box::new(SimpleHostImageCopyTestCase {
                name: format_name.to_string(),
                params,
            }) as Box<dyn TestCase>);
        }
        padding_group.add_child(format_group);
    }
    test_group.add_child(padding_group);

    super::host_image_copy_format_tests::add_host_image_copy_format_groups(&mut test_group);

    // `capture_replay`: needs VK_EXT_descriptor_heap, which this port does not drive.
    for group in crate::vkt::gated::build_gated_groups(
        "capture_replay.heap\n",
        &["VK_EXT_host_image_copy", "VK_EXT_descriptor_heap"],
        "the descriptor heap capture replay of host image copy",
    ) {
        test_group.add_child(group);
    }

    test_group
}
