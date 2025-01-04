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
// Modifications: rewritten in Rust for hodow_cts. No shaders. The two `MultiQueueRunnerTestInstance` groups of
// `host_image_copy`: the preinitialized ones (`<tiling>/<image_to_image_copy|image_to_image_memcpy|preinitialized>/...`)
// and `identical_memory_layout`. `MultiQueueRunnerTestInstance::iterate` is `run_on_queues`, built from the default
// context's universal, compute and transfer queues the way the default-context branch of the upstream constructor
// picks them. The `capture_replay` group needs `VK_EXT_descriptor_heap`, which this port does not drive, and the
// descriptor-heap-only create flag with it, so it is not registered.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtHostImageCopyExtensionDeviceCommands, InstanceV1_1};

use super::host_image_copy_tests::{
    ZERO_OFFSET, check_supported_format_features, copy_image_to_image_info, copy_image_to_memory_info, generate_data,
    get_channel_size, get_host_image_copy_properties, get_num_channels, host_layout_transition, image_copy2,
    image_to_memory_copy, is_depth_stencil_format, make_extent_3d, query_max_array_layers_with_info,
};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, TextureLevel, effective_depth_stencil_level_access,
    fill_with_component_gradients2, get_texture_format_bit_depth, has_depth_component, has_stencil_component,
};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, TextureChannelClass, TextureFormat, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::{get_block_height, get_block_size_in_bytes, get_block_width, is_compressed_format};
use crate::vk::image_util::{
    ImageWithMemory, get_depth_copy_format, get_stencil_copy_format, make_buffer_image_copy, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, OffsetParams, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `MultiQueueRunnerTestInstance` for a `GRAPHICS_QUEUE` (`transfer == false`) or a `TRANSFER_QUEUE` instance.
pub fn queues_for(context: &Context<'_>, transfer: bool) -> Vec<(vk::Queue, u32)> {
    let universal_family = context.get_universal_queue_family_index();
    let mut queues = vec![(context.get_universal_queue(), universal_family)];
    if !transfer {
        return queues;
    }

    let compute = context
        .get_compute_queue()
        .filter(|&(_, family)| family != universal_family);
    if let Some(queue) = compute {
        queues.push(queue);
    }
    let compute_family = context.get_compute_queue().map(|(_, family)| family);
    if let Some((queue, family)) = context.get_transfer_queue()
        && family != universal_family
        && Some(family) != compute_family
    {
        queues.push((queue, family));
    }
    queues
}

/// `MultiQueueRunnerTestInstance::iterate`
pub fn run_on_queues(
    queues: Vec<(vk::Queue, u32)>,
    mut queue_pass: impl FnMut(vk::Queue, u32) -> TestOutcome,
) -> TestOutcome {
    if queues.is_empty() {
        return Err(TestError::NotSupported("No queues available for this test".to_string()));
    }
    if queues.len() == 1 {
        return queue_pass(queues[0].0, queues[0].1);
    }

    let mut failures = String::new();
    let mut not_supported: Option<String> = None;
    for (queue, family_index) in queues {
        match queue_pass(queue, family_index) {
            Ok(status) if status.is_fail() => failures.push_str(&format!(
                "Test failed on queue family {} with description: {}\n",
                family_index,
                status.description()
            )),
            Ok(_) => {}
            Err(TestError::NotSupported(message)) => {
                not_supported.get_or_insert(format!(
                    "Test exception (NotSupported) thrown on queue family {family_index} with description: {message}"
                ));
            }
            Err(TestError::Fail(message)) => failures.push_str(&format!(
                "Test exception (Fail) thrown on queue family {family_index} with description: {message}"
            )),
            Err(error) => return Err(error),
        }
    }

    if !failures.is_empty() {
        return Ok(TestStatus::fail(failures));
    }
    if let Some(message) = not_supported {
        return Err(TestError::NotSupported(message));
    }
    Ok(TestStatus::pass(""))
}

// ---------------------------------------------------------------------------------------------------------------------
// preinitialized
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct PreinitializedParams {
    format: vk::Format,
    src_layout: vk::ImageLayout,
    dst_layout: vk::ImageLayout,
    size: vk::Extent3D,
    array_layers: u32,
    image_to_image_copy: bool,
    memcpy: bool,
    tiling: vk::ImageTiling,
    offset: u32,
}

/// `getPreinitializedQueueCaps`; true for `TRANSFER_QUEUE`.
fn preinitialized_uses_transfer_queues(params: &PreinitializedParams) -> bool {
    params.tiling == vk::ImageTiling::OPTIMAL
        && params.offset == 0
        && params.array_layers == 1
        && params.size.width == 32
        && params.size.height == 32
        && params.size.depth == 1
        && params.format == vk::Format::R8G8B8A8_UNORM
}

/// `GetUsage`
fn get_usage(src_layout: vk::ImageLayout, dst_layout: vk::ImageLayout) -> vk::ImageUsageFlags {
    use vk::ImageLayout as L;

    let either = |layout: vk::ImageLayout| src_layout == layout || dst_layout == layout;

    let mut usage = vk::ImageUsageFlags::HOST_TRANSFER | vk::ImageUsageFlags::TRANSFER_SRC;
    if either(L::COLOR_ATTACHMENT_OPTIMAL) {
        usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
    }
    if either(L::SHADER_READ_ONLY_OPTIMAL) {
        usage |= vk::ImageUsageFlags::SAMPLED;
    }
    if either(L::TRANSFER_DST_OPTIMAL) {
        usage |= vk::ImageUsageFlags::TRANSFER_DST;
    }
    if either(L::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        || either(L::DEPTH_STENCIL_READ_ONLY_OPTIMAL)
        || either(L::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL)
        || either(L::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL)
        || either(L::DEPTH_READ_ONLY_OPTIMAL)
        || either(L::STENCIL_ATTACHMENT_OPTIMAL)
        || either(L::STENCIL_READ_ONLY_OPTIMAL)
    {
        usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
    }
    if either(L::ATTACHMENT_FEEDBACK_LOOP_OPTIMAL_EXT) {
        usage |= vk::ImageUsageFlags::ATTACHMENT_FEEDBACK_LOOP_EXT;
        usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
        usage |= vk::ImageUsageFlags::SAMPLED;
    }
    if either(L::READ_ONLY_OPTIMAL) {
        usage |= vk::ImageUsageFlags::SAMPLED;
    }
    if either(L::ATTACHMENT_OPTIMAL)
        && !usage.intersects(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
    {
        usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
    }
    usage
}

fn preinitialized_queue_pass(
    context: &Context<'_>,
    params: PreinitializedParams,
    queue: vk::Queue,
    queue_family_index: u32,
) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();

    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, params.array_layers);
    let subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, params.array_layers);

    let channel_size = get_channel_size(params.format);
    let num_channels = get_num_channels(params.format);
    let buffer_count = params.size.width * params.size.height * params.size.depth * params.array_layers * num_channels;
    let buffer_size = (buffer_count * channel_size) as usize;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let allocator_with_offset = SimpleAllocator::with_offset(
        memory_properties,
        OffsetParams {
            non_coherent_atom_size: context.get_device_properties().limits.non_coherent_atom_size,
            offset: u64::from(params.offset),
        },
    );

    let image_type = if params.size.depth > 1 {
        vk::ImageType::_3D
    } else {
        vk::ImageType::_2D
    };

    let modifier = check_supported_format_features(context, params.format, params.tiling)?;

    let drm_create_info = vk::ImageDrmFormatModifierListCreateInfoEXT {
        s_type: vk::StructureType::IMAGE_DRM_FORMAT_MODIFIER_LIST_CREATE_INFO_EXT,
        next: std::ptr::null(),
        drm_format_modifier_count: 1,
        drm_format_modifiers: &modifier,
    };

    let usage = get_usage(params.src_layout, params.dst_layout);

    let create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: if params.tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
            std::ptr::addr_of!(drm_create_info).cast()
        } else {
            std::ptr::null()
        },
        flags: vk::ImageCreateFlags::empty(),
        image_type,
        format: params.format,
        extent: params.size,
        mip_levels: 1,
        array_layers: params.array_layers,
        samples: vk::SampleCountFlags::_1,
        tiling: params.tiling,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::PREINITIALIZED,
    };

    let image = ImageWithMemory::new(vk, &allocator_with_offset, create_info, MemoryRequirement::HOST_VISIBLE)?;
    let copy_image = ImageWithMemory::new(vk, &allocator_with_offset, create_info, MemoryRequirement::ANY)?;
    let end_image = if params.image_to_image_copy {
        copy_image.get()
    } else {
        image.get()
    };
    let output_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(buffer_size as u64, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let allocation = image.get_allocation();
    let image_data = unsafe { std::slice::from_raw_parts_mut(allocation.get_host_ptr(), buffer_size) };
    generate_data(image_data, params.format);

    if get_host_image_copy_properties(context).identical_memory_type_requirements {
        // Upstream clears `createInfo.flags` of a usage bit, which changes nothing, so this second image is the first again.
        let image_without_host_copy =
            ImageWithMemory::new(vk, allocator, create_info, MemoryRequirement::HOST_VISIBLE)?;
        let host_image_memory_requirements = unsafe { vk.get_image_memory_requirements(image.get()) };
        let memory_requirements = unsafe { vk.get_image_memory_requirements(image_without_host_copy.get()) };

        if host_image_memory_requirements.memory_type_bits != memory_requirements.memory_type_bits {
            return Err(TestError::NotSupported(
                "Layout not supported for src host copy".to_string(),
            ));
        }
    }

    // map device memory and initialize
    {
        let transition = host_layout_transition(
            image.get(),
            vk::ImageLayout::PREINITIALIZED,
            params.src_layout,
            subresource_range,
        );
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
    }

    if params.image_to_image_copy {
        let mut transition = host_layout_transition(
            copy_image.get(),
            vk::ImageLayout::UNDEFINED,
            params.dst_layout,
            subresource_range,
        );
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;

        let region = image_copy2(
            subresource_layers,
            ZERO_OFFSET,
            subresource_layers,
            ZERO_OFFSET,
            params.size,
        );

        let host_image_copy_flags = if params.memcpy {
            vk::HostImageCopyFlags::MEMCPY
        } else {
            vk::HostImageCopyFlags::empty()
        };

        let mut copy_image_to_image_info = copy_image_to_image_info(
            image.get(),
            params.src_layout,
            copy_image.get(),
            params.dst_layout,
            &region,
        );
        copy_image_to_image_info.flags = host_image_copy_flags;

        unsafe { vk.copy_image_to_image_ext(&copy_image_to_image_info) }.vk_check("vkCopyImageToImageEXT")?;

        transition.old_layout = params.dst_layout;
        transition.new_layout = params.src_layout;
        unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
    }

    let mut data = vec![0u8; buffer_size];

    let region = image_to_memory_copy(data.as_mut_ptr(), 0, 0, subresource_layers, ZERO_OFFSET, params.size);
    let copy_image_to_memory_info = copy_image_to_memory_info(end_image, params.src_layout, &region);
    unsafe { vk.copy_image_to_memory_ext(&copy_image_to_memory_info) }.vk_check("vkCopyImageToMemoryEXT")?;

    begin_command_buffer(vk, cmd)?;
    {
        let image_memory_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_READ,
            params.src_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            subresource_range,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::empty(),
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_memory_barrier],
            );
        }

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: subresource_layers,
            image_offset: ZERO_OFFSET,
            image_extent: params.size,
        };
        unsafe {
            vk.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &[copy_region],
            )
        };

        let post_buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[post_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    end_command_buffer(vk, cmd)?;

    submit_commands_and_wait(vk, queue, cmd)?;

    invalidate_alloc(vk, output_buffer.get_allocation())?;

    let output =
        unsafe { std::slice::from_raw_parts(output_buffer.get_allocation().get_host_ptr().cast_const(), buffer_size) };
    let matches = data.as_slice() == output;

    if !matches {
        if let Some(i) = (0..buffer_size).find(|&i| data[i] != output[i]) {
            log::info!(
                "At byte {} data from vkCopyImageToMemoryEXT() is {}, but data from vkCmdCopyImageToBuffer() is {}",
                i,
                data[i],
                output[i]
            );
        }
        return Ok(TestStatus::fail("Copies values do not match"));
    }

    Ok(TestStatus::pass("Pass"))
}

struct PreinitializedTestCase {
    name: String,
    params: PreinitializedParams,
}

impl TestCase for PreinitializedTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        use vk::ImageLayout as L;

        let params = self.params;
        let either = |layout: vk::ImageLayout| params.src_layout == layout || params.dst_layout == layout;

        context.require_device_functionality("VK_EXT_host_image_copy")?;

        if params.tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
            context.require_device_functionality("VK_EXT_image_drm_format_modifier")?;
        }

        if either(L::PRESENT_SRC_KHR) {
            context.require_device_functionality("VK_KHR_swapchain")?;
        }

        if either(L::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL)
            || either(L::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL)
        {
            context.require_device_functionality("VK_KHR_maintenance2")?;
        }

        if either(L::DEPTH_READ_ONLY_OPTIMAL)
            || either(L::STENCIL_ATTACHMENT_OPTIMAL)
            || either(L::STENCIL_READ_ONLY_OPTIMAL)
        {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }

        if either(L::READ_ONLY_OPTIMAL) || either(L::ATTACHMENT_OPTIMAL) {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }

        if either(L::ATTACHMENT_FEEDBACK_LOOP_OPTIMAL_EXT) {
            context.require_device_functionality("VK_EXT_attachment_feedback_loop_layout")?;
        }

        let mut host_image_copy_features = vk::PhysicalDeviceHostImageCopyFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut host_image_copy_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

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

        if host_image_copy_features.host_image_copy != vk::TRUE {
            return Err(TestError::NotSupported("hostImageCopy not supported".to_string()));
        }

        let modifier = check_supported_format_features(context, params.format, params.tiling)?;

        let image_type = if params.size.depth > 1 {
            vk::ImageType::_3D
        } else {
            vk::ImageType::_2D
        };
        let modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT {
            s_type: vk::StructureType::PHYSICAL_DEVICE_IMAGE_DRM_FORMAT_MODIFIER_INFO_EXT,
            next: std::ptr::null(),
            drm_format_modifier: modifier,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
        };

        let usage = get_usage(params.src_layout, params.dst_layout);

        let image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
            s_type: vk::StructureType::PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2,
            next: if params.tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
                std::ptr::addr_of!(modifier_info).cast()
            } else {
                std::ptr::null()
            },
            format: params.format,
            type_: image_type,
            tiling: params.tiling,
            usage,
            flags: vk::ImageCreateFlags::empty(),
        };
        let max_array_layers = query_max_array_layers_with_info(context, &image_format_info)?;
        if max_array_layers < params.array_layers {
            return Err(TestError::NotSupported(
                "Required image array layers not supported.".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PreinitializedTestInstance {
            context,
            params: self.params,
        })
    }
}

struct PreinitializedTestInstance<'a> {
    context: &'a Context<'a>,
    params: PreinitializedParams,
}

impl TestInstance for PreinitializedTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let queues = queues_for(self.context, preinitialized_uses_transfer_queues(&self.params));
        run_on_queues(queues, |queue, family_index| {
            preinitialized_queue_pass(self.context, self.params, queue, family_index)
        })
    }
}

/// The preinitialized part of `testGenerator`: one group per tiling.
pub(super) fn add_preinitialized_groups(test_group: &mut TestCaseGroup) {
    let preinitialized_formats = [
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
        (vk::Format::R16_UNORM, "r16_unorm"),
        (vk::Format::R16G16_UINT, "r16g16_uint"),
        (vk::Format::B8G8R8A8_SINT, "b8g8r8a8_sint"),
        (vk::Format::R16_SFLOAT, "r16_sfloat"),
    ];

    let preinitialized_tiling_tests = [
        (vk::ImageTiling::LINEAR, "linear"),
        (vk::ImageTiling::OPTIMAL, "optimal"),
        (vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT, "drm_format_modifier"),
    ];

    let preinitialized_image_layout_tests = [
        (vk::ImageLayout::GENERAL, "general"),
        (vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, "color_attachment_optimal"),
        (
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            "depth_stencil_attachment_optimal",
        ),
        (
            vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
            "depth_stencil_read_only_optimal",
        ),
        (vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL, "shader_read_only_optimal"),
        (vk::ImageLayout::TRANSFER_SRC_OPTIMAL, "transfer_src_optimal"),
        (vk::ImageLayout::TRANSFER_DST_OPTIMAL, "transfer_dst_optimal"),
        (vk::ImageLayout::PREINITIALIZED, "preinitialized"),
        (vk::ImageLayout::PRESENT_SRC_KHR, "present_src"),
        (
            vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL,
            "depth_read_only_stencil_attachment_optimal",
        ),
        (
            vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL,
            "depth_attachment_stencil_read_only_optimal",
        ),
        (vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL, "depth_read_only_optimal"),
        (
            vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL,
            "stencil_attachment_optimal",
        ),
        (vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL, "stencil_read_only_optimal"),
        (vk::ImageLayout::READ_ONLY_OPTIMAL, "read_only_optimal"),
        (vk::ImageLayout::ATTACHMENT_OPTIMAL, "attachment_optimal"),
        (
            vk::ImageLayout::ATTACHMENT_FEEDBACK_LOOP_OPTIMAL_EXT,
            "attachment_feedback_loop_optimal",
        ),
    ];
    let always_tested_layouts = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
    ];

    let image_to_image_copy_tests = [
        (true, false, "image_to_image_copy"),
        (true, true, "image_to_image_memcpy"),
        (false, false, "preinitialized"),
    ];

    let image_size_tests = [
        (make_extent_3d(32, 32, 1), 1u32, "32x32x1_1"),
        (make_extent_3d(32, 32, 1), 2, "32x32x1_2"),
        (make_extent_3d(51, 63, 1), 1, "51x63x1_1"),
        (make_extent_3d(24, 24, 4), 1, "24x24x4_4"),
    ];

    let offset_tests = [(0u32, "0"), (64, "64")];

    for (tiling, tiling_name) in preinitialized_tiling_tests {
        let mut tiling_group = TestCaseGroup::new(tiling_name);
        for (image_to_image_copy, memcpy, image_to_image_name) in image_to_image_copy_tests {
            let mut image_to_image_copy_group = TestCaseGroup::new(image_to_image_name);
            for (src_layout, src_layout_name) in preinitialized_image_layout_tests {
                let mut src_layout_group = TestCaseGroup::new(src_layout_name);
                for (dst_layout, dst_layout_name) in preinitialized_image_layout_tests {
                    // It is not necessary to test all possible src and dst layout combinations, but make sure the
                    // most common ones are tested and also test each layout where src and dst layouts match
                    if src_layout != dst_layout
                        && !always_tested_layouts.contains(&src_layout)
                        && !always_tested_layouts.contains(&dst_layout)
                    {
                        continue;
                    }
                    let mut dst_layout_group = TestCaseGroup::new(dst_layout_name);
                    for (size, layer_count, size_name) in image_size_tests {
                        let mut size_group = TestCaseGroup::new(size_name);
                        for (offset, offset_name) in offset_tests {
                            let mut offset_group = TestCaseGroup::new(offset_name);
                            for (format, format_name) in preinitialized_formats {
                                let params = PreinitializedParams {
                                    format,
                                    src_layout,
                                    dst_layout,
                                    size,
                                    array_layers: layer_count,
                                    image_to_image_copy,
                                    memcpy,
                                    tiling,
                                    offset,
                                };
                                offset_group.add_child(Box::new(PreinitializedTestCase {
                                    name: format_name.to_string(),
                                    params,
                                }) as Box<dyn TestCase>);
                            }
                            size_group.add_child(offset_group);
                        }
                        dst_layout_group.add_child(size_group);
                    }
                    src_layout_group.add_child(dst_layout_group);
                }
                image_to_image_copy_group.add_child(src_layout_group);
            }
            tiling_group.add_child(image_to_image_copy_group);
        }
        test_group.add_child(tiling_group);
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// identical_memory_layout
// ---------------------------------------------------------------------------------------------------------------------

/// `generateImageData`
fn generate_image_data(
    context: &Context<'_>,
    queue_family_index: u32,
    queue: vk::Queue,
    image: vk::Image,
    format: vk::Format,
    extent: [u32; 3],
) -> Result<(), TestError> {
    let tcu_format =
        map_vk_format(format).ok_or_else(|| TestError::InternalError(format!("no texture format for {format:?}")))?;
    let vk_extent = make_extent_3d(extent[0], extent[1], extent[2]);
    let mut level = TextureLevel::new(tcu_format, extent[0], extent[1], 1)?;
    let channel_class = tcu_format.channel_class();
    let min_value = [0.0f32; 4];
    let mut max_value = [1.0f32; 4];

    //
    // Generate image data on host memory.
    //

    if tcu_format.order == ChannelOrder::S {
        // Stencil-only is stored in the first component. Stencil is always 8 bits.
        max_value[0] = (1 << 8) as f32;
    } else if tcu_format.order == ChannelOrder::DS {
        // In a combined format, fillWithComponentGradients expects stencil in the fourth component.
        max_value[3] = (1 << 8) as f32;
    } else if matches!(
        channel_class,
        TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger
    ) {
        // The tcu::Vectors we use as pixels are 32-bit, so clamp to that.
        let bits = get_texture_format_bit_depth(tcu_format);
        let sign_bit = i32::from(channel_class == TextureChannelClass::SignedInteger);

        for i in 0..4 {
            let component_bits = bits[i].min(32);
            if component_bits != 0 {
                max_value[i] = ((1u64 << (component_bits - sign_bit)) - 1) as f32;
            }
        }
    }

    fill_with_component_gradients2(&mut level.get_access(), min_value, max_value);

    //
    // Upload generated data to the image.
    //

    if is_depth_stencil_format(format) {
        // Iteration index: 0 is depth, 1 is stencil
        for i in 0..2 {
            let has_component = if i == 0 {
                has_depth_component(tcu_format.order)
            } else {
                has_stencil_component(tcu_format.order)
            };
            let orig_mode = if i == 0 {
                DepthStencilMode::Depth
            } else {
                DepthStencilMode::Stencil
            };
            let layer_aspect = if i == 0 {
                vk::ImageAspectFlags::DEPTH
            } else {
                vk::ImageAspectFlags::STENCIL
            };

            if has_component {
                let xfer_format = if i == 0 {
                    get_depth_copy_format(format)
                } else {
                    get_stencil_copy_format(format)
                }
                .ok_or_else(|| TestError::InternalError("no copy format for this aspect".to_string()))?;
                let orig_access = effective_depth_stencil_level_access(&level, orig_mode);
                let mut copy_level = TextureLevel::new(xfer_format, extent[0], extent[1], 1)?;
                let pixel_size = xfer_format
                    .pixel_size()
                    .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?;
                let buffer_size = (pixel_size * extent[0] * extent[1]) as usize;

                // Get a copy of the aspect.
                copy_aspect(&mut copy_level, &orig_access, i == 0);

                // Upload that copy to a buffer and then the image.
                upload_buffer_to_image(
                    context,
                    queue_family_index,
                    queue,
                    image,
                    &copy_level.data()[..buffer_size],
                    vk_extent,
                    layer_aspect,
                    true,
                )?;
            }
        }
    } else {
        // Simplest case.
        let pixel_size = tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?;
        let buffer_size = (pixel_size * extent[0] * extent[1]) as usize;

        upload_buffer_to_image(
            context,
            queue_family_index,
            queue,
            image,
            &level.data()[..buffer_size],
            vk_extent,
            vk::ImageAspectFlags::COLOR,
            false,
        )?;
    }

    Ok(())
}

/// The `tcu::copy` of one depth or stencil aspect of a level into a level of its copy format.
fn copy_aspect(dst: &mut TextureLevel, src: &ConstPixelBufferAccess<'_>, depth: bool) {
    let [width, height, _] = dst.size();
    let mut access = dst.get_access();
    for y in 0..height {
        for x in 0..width {
            if depth {
                access.set_pix_depth(src.get_pix_depth(x, y, 0), x, y, 0);
            } else {
                access.set_pix_stencil(src.get_pix_stencil(x, y, 0), x, y, 0);
            }
        }
    }
}

/// The buffer half of `generateImageData`/`generateCompressedImageData`: a host-visible buffer, one buffer to image
/// copy in `VK_IMAGE_LAYOUT_GENERAL`, and for depth/stencil aspects the leading transfer write barrier.
#[allow(clippy::too_many_arguments)]
fn upload_buffer_to_image(
    context: &Context<'_>,
    queue_family_index: u32,
    queue: vk::Queue,
    image: vk::Image,
    data: &[u8],
    vk_extent: vk::Extent3D,
    aspect: vk::ImageAspectFlags,
    leading_barrier: bool,
) -> Result<(), TestError> {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();

    let src_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(data.len() as u64, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let src_buffer_alloc = src_buffer.get_allocation();
    unsafe { std::ptr::copy_nonoverlapping(data.as_ptr(), src_buffer_alloc.get_host_ptr(), data.len()) };
    flush_alloc(vk, src_buffer_alloc)?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(vk, cmd)?;

    if leading_barrier {
        let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_WRITE);
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    let copy_srl = make_image_subresource_layers(aspect, 0, 0, 1);
    let copy_region = make_buffer_image_copy(vk_extent, copy_srl);
    unsafe { vk.cmd_copy_buffer_to_image(cmd, src_buffer.get(), image, vk::ImageLayout::GENERAL, &[copy_region]) };

    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)
}

/// `generateCompressedImageData`
fn generate_compressed_image_data(
    context: &Context<'_>,
    queue_family_index: u32,
    queue: vk::Queue,
    image: vk::Image,
    format: vk::Format,
    extent: [u32; 3],
) -> Result<(), TestError> {
    let vk_extent = make_extent_3d(extent[0], extent[1], extent[2]);

    let blocks_x = extent[0].div_ceil(get_block_width(format));
    let blocks_y = extent[1].div_ceil(get_block_height(format));
    let data_size = (get_block_size_in_bytes(format) * blocks_x * blocks_y) as usize;

    // This is supposed to be safe for the compressed formats we're using (no ASTC, no ETC, no SFLOAT formats).
    let mut rnd = Random::new(format.as_raw() as u32);
    let data: Vec<u8> = (0..data_size).map(|_| rnd.get_uint8()).collect();

    upload_buffer_to_image(
        context,
        queue_family_index,
        queue,
        image,
        &data,
        vk_extent,
        vk::ImageAspectFlags::COLOR,
        false,
    )
}

fn identical_memory_layout_queue_pass(
    context: &Context<'_>,
    format: vk::Format,
    tiling: vk::ImageTiling,
    queue: vk::Queue,
    queue_family_index: u32,
) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let memory_properties = allocator.memory_properties();
    let extent = [32u32, 32, 1];
    let vk_extent = make_extent_3d(extent[0], extent[1], extent[2]);
    let base_usage_flags = vk::ImageUsageFlags::TRANSFER_DST;
    let extended_usage_flags = base_usage_flags | vk::ImageUsageFlags::HOST_TRANSFER;

    // Create two images, one with the host transfer usage bit and another one without it, to check identicalMemoryLayout.
    let mut image_create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk_extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling,
        usage: base_usage_flags,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let base_image = Unique::new(
        vk,
        unsafe { vk.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
    );
    image_create_info.usage = extended_usage_flags;
    let host_xfer_image = Unique::new(
        vk,
        unsafe { vk.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
    );

    // Check memory requirements for both (size must match).
    let base_mem_reqs = unsafe { vk.get_image_memory_requirements(*base_image) };
    let host_xfer_reqs = unsafe { vk.get_image_memory_requirements(*host_xfer_image) };

    if base_mem_reqs.size != host_xfer_reqs.size {
        return Err(TestError::Fail(
            "Different memory sizes for normal and host-transfer image".to_string(),
        ));
    }

    let image_mem_size = base_mem_reqs.size;
    let image_mem_size_sz = image_mem_size as usize;

    // Create two buffers that will share memory with the previous images.
    let buffer_create_info = make_buffer_create_info(
        image_mem_size,
        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
    );
    let base_buffer = Unique::new(
        vk,
        unsafe { vk.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
    );
    let host_xfer_buffer = Unique::new(
        vk,
        unsafe { vk.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
    );

    // Find common memory types for images and buffers and allocate memory.
    let select_memory_type = |common_memory_types: u32| -> Option<u32> {
        (0..memory_properties.memory_type_count).find(|&index| {
            (common_memory_types & (1 << index)) != 0
                && MemoryRequirement::ANY.matches_heap(memory_properties.memory_types[index as usize].property_flags)
        })
    };

    let base_buffer_mem_reqs = unsafe { vk.get_buffer_memory_requirements(*base_buffer) };
    let base_common_memory_types = base_mem_reqs.memory_type_bits & base_buffer_mem_reqs.memory_type_bits;

    // Very unlikely.
    if base_common_memory_types == 0 {
        return Err(TestError::NotSupported(
            "Base buffer and image do not have any memory types in common".to_string(),
        ));
    }

    let base_selected_mem_type = select_memory_type(base_common_memory_types)
        .ok_or_else(|| TestError::NotSupported("No compatible memory type found".to_string()))?;

    let host_xfer_buffer_mem_reqs = unsafe { vk.get_buffer_memory_requirements(*host_xfer_buffer) };
    let host_xfer_common_memory_types = host_xfer_reqs.memory_type_bits & host_xfer_buffer_mem_reqs.memory_type_bits;

    // Very unlikely.
    if host_xfer_common_memory_types == 0 {
        return Err(TestError::NotSupported(
            "Host transfer buffer and image do not have any memory types in common".to_string(),
        ));
    }

    let host_xfer_selected_mem_type = select_memory_type(host_xfer_common_memory_types)
        .ok_or_else(|| TestError::NotSupported("No compatible memory type found".to_string()))?;

    let mut memory_allocate_info = vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next: std::ptr::null(),
        allocation_size: image_mem_size,
        memory_type_index: base_selected_mem_type,
    };
    let base_memory = Unique::new(
        vk,
        unsafe { vk.allocate_memory(&memory_allocate_info, None) }.vk_check("vkAllocateMemory")?,
    );
    memory_allocate_info.memory_type_index = host_xfer_selected_mem_type;
    let host_xfer_memory = Unique::new(
        vk,
        unsafe { vk.allocate_memory(&memory_allocate_info, None) }.vk_check("vkAllocateMemory")?,
    );

    // Map allocations to images and buffers.
    unsafe {
        vk.bind_image_memory(*base_image, *base_memory, 0)
            .vk_check("vkBindImageMemory")?;
        vk.bind_buffer_memory(*base_buffer, *base_memory, 0)
            .vk_check("vkBindBufferMemory")?;

        vk.bind_image_memory(*host_xfer_image, *host_xfer_memory, 0)
            .vk_check("vkBindImageMemory")?;
        vk.bind_buffer_memory(*host_xfer_buffer, *host_xfer_memory, 0)
            .vk_check("vkBindBufferMemory")?;
    }

    // Clear both image memories to zero (via the memory-sharing buffers above) before filling images with data.
    {
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Transition both images to the general layout for subsequent operations.
        let is_depth_stencil = is_depth_stencil_format(format);
        let tcu_format = if is_compressed_format(format) {
            None
        } else {
            map_vk_format(format)
        };
        let has_depth = is_depth_stencil && tcu_format.is_some_and(|f: TextureFormat| has_depth_component(f.order));
        let has_stencil = is_depth_stencil && tcu_format.is_some_and(|f: TextureFormat| has_stencil_component(f.order));
        let aspect_mask = if is_depth_stencil {
            (if has_depth {
                vk::ImageAspectFlags::DEPTH
            } else {
                vk::ImageAspectFlags::empty()
            }) | (if has_stencil {
                vk::ImageAspectFlags::STENCIL
            } else {
                vk::ImageAspectFlags::empty()
            })
        } else {
            vk::ImageAspectFlags::COLOR
        };
        let image_srr = make_image_subresource_range(aspect_mask, 0, 1, 0, 1);

        begin_command_buffer(vk, cmd)?;
        unsafe { vk.cmd_fill_buffer(cmd, *base_buffer, 0, vk::WHOLE_SIZE, 0) };
        unsafe { vk.cmd_fill_buffer(cmd, *host_xfer_buffer, 0, vk::WHOLE_SIZE, 0) };
        let transition_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                *base_image,
                image_srr,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                *host_xfer_image,
                image_srr,
            ),
        ];
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &transition_barriers,
            );
        }
        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;
    }

    // Generate data for both images.
    if is_compressed_format(format) {
        generate_compressed_image_data(context, queue_family_index, queue, *base_image, format, extent)?;
        generate_compressed_image_data(context, queue_family_index, queue, *host_xfer_image, format, extent)?;
    } else {
        generate_image_data(context, queue_family_index, queue, *base_image, format, extent)?;
        generate_image_data(context, queue_family_index, queue, *host_xfer_image, format, extent)?;
    }

    // Create a couple of host-visible buffers for verification.
    let verif_buffer_create_info = make_buffer_create_info(image_mem_size, vk::BufferUsageFlags::TRANSFER_DST);
    let base_verif_buffer =
        BufferWithMemory::new(vk, allocator, verif_buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;
    let host_xfer_verif_buffer =
        BufferWithMemory::new(vk, allocator, verif_buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;

    // Copy data from shared-memory buffers to verification buffers.
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    let copy_region = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: image_mem_size,
    };
    let pre_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);
    let post_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

    begin_command_buffer(vk, cmd)?;
    unsafe {
        vk.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[pre_copy_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        vk.cmd_copy_buffer(cmd, *base_buffer, base_verif_buffer.get(), &[copy_region]);
        vk.cmd_copy_buffer(cmd, *host_xfer_buffer, host_xfer_verif_buffer.get(), &[copy_region]);
        vk.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[post_copy_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)?;

    invalidate_alloc(vk, base_verif_buffer.get_allocation())?;
    invalidate_alloc(vk, host_xfer_verif_buffer.get_allocation())?;

    let base_verif_data = unsafe {
        std::slice::from_raw_parts(
            base_verif_buffer.get_allocation().get_host_ptr().cast_const(),
            image_mem_size_sz,
        )
    };
    let host_xfer_verif_data = unsafe {
        std::slice::from_raw_parts(
            host_xfer_verif_buffer.get_allocation().get_host_ptr().cast_const(),
            image_mem_size_sz,
        )
    };

    for i in 0..image_mem_size_sz {
        if base_verif_data[i] != host_xfer_verif_data[i] {
            return Err(TestError::Fail(format!(
                "Base image and host copy image data differs at byte {}: 0x{:02x} vs 0x{:02x}",
                i, base_verif_data[i], host_xfer_verif_data[i]
            )));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `checkDepthStencilCopyQueueSupport`
fn check_depth_stencil_copy_queue_support(
    context: &Context<'_>,
    copies_depth_stencil_aspect: bool,
) -> Result<(), TestError> {
    if !copies_depth_stencil_aspect {
        return Ok(());
    }

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
    Ok(())
}

struct IdenticalMemoryLayoutTestCase {
    name: String,
    format: vk::Format,
    tiling: vk::ImageTiling,
}

impl TestCase for IdenticalMemoryLayoutTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_host_image_copy")?;

        // generateImageData() uploads each depth and stencil aspect with its own buffer to image copy.
        check_depth_stencil_copy_queue_support(context, is_depth_stencil_format(self.format))?;

        let instance = context.get_instance();
        let mut format_properties3 = vk::FormatProperties3::default();
        {
            let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
            unsafe {
                instance.get_physical_device_format_properties2(
                    context.get_physical_device(),
                    self.format,
                    &mut format_properties2,
                )
            };
        }
        let required_features = vk::FormatFeatureFlags2::HOST_IMAGE_TRANSFER | vk::FormatFeatureFlags2::TRANSFER_DST;
        let image_usage = vk::ImageUsageFlags::HOST_TRANSFER | vk::ImageUsageFlags::TRANSFER_DST;

        if self.tiling == vk::ImageTiling::OPTIMAL
            && !format_properties3.optimal_tiling_features.contains(required_features)
        {
            return Err(TestError::NotSupported(
                "Required format feature not supported for optimal tiling.".to_string(),
            ));
        }

        if self.tiling == vk::ImageTiling::LINEAR
            && !format_properties3.linear_tiling_features.contains(required_features)
        {
            return Err(TestError::NotSupported(
                "Required format feature not supported for linear tiling.".to_string(),
            ));
        }

        let image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
            format: self.format,
            type_: vk::ImageType::_2D,
            tiling: self.tiling,
            usage: image_usage,
            flags: vk::ImageCreateFlags::empty(),
            ..Default::default()
        };

        let mut host_image_copy_device_performance_query = vk::HostImageCopyDevicePerformanceQuery::default();
        let res = {
            let mut image_format_properties =
                vk::ImageFormatProperties2::builder().push_next(&mut host_image_copy_device_performance_query);
            unsafe {
                instance.get_physical_device_image_format_properties2(
                    context.get_physical_device(),
                    &image_format_info,
                    &mut image_format_properties,
                )
            }
        };

        if matches!(res, Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED)) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        if host_image_copy_device_performance_query.identical_memory_layout == vk::FALSE {
            return Err(TestError::NotSupported(
                "identicalMemoryLayout not supported for this format".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IdenticalMemoryLayoutTestInstance {
            context,
            format: self.format,
            tiling: self.tiling,
        })
    }
}

struct IdenticalMemoryLayoutTestInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    tiling: vk::ImageTiling,
}

impl TestInstance for IdenticalMemoryLayoutTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // The device-side upload is a buffer to image copy, which stays graphics-only for depth/stencil aspects
        let queues = queues_for(self.context, !is_depth_stencil_format(self.format));
        run_on_queues(queues, |queue, family_index| {
            identical_memory_layout_queue_pass(self.context, self.format, self.tiling, queue, family_index)
        })
    }
}

/// The `identical_memory_layout` group of `testGenerator`.
pub(super) fn create_identical_memory_layout_group(
    tilings: &[(vk::ImageTiling, &'static str)],
    query_formats: &[(vk::Format, &'static str)],
) -> TestCaseGroup {
    let mut identical_memory_layout_group = TestCaseGroup::new("identical_memory_layout");

    for &(tiling, tiling_name) in tilings {
        let mut tiling_group = TestCaseGroup::new(tiling_name);
        for &(format, format_name) in query_formats {
            tiling_group.add_child(Box::new(IdenticalMemoryLayoutTestCase {
                name: format_name.to_string(),
                format,
                tiling,
            }) as Box<dyn TestCase>);
        }
        identical_memory_layout_group.add_child(tiling_group);
    }

    identical_memory_layout_group
}
