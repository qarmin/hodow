// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationSmokeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `TestLog::Image` has no counterpart, so `fences`/`*_semaphores` do not log the rendered
// image; their verdicts never depended on it. `testSemaphores` runs on the Context's
// `multi_queue_device()` (every extension and feature on, two queues per family) instead of
// building its own device with just timeline_semaphore / synchronization2 enabled.
//
// The family-type loop and the legacy/synchronization2 split are in the Rust; the one
// shader pair the image cases share is in shaders/manifest/synchronization_smoke.toml.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrSynchronization2ExtensionDeviceCommands};

use super::image_layout_transition_tests::make_load_render_pass;
use super::operation::{SyncType, make_buffer_memory_barrier2, make_image_memory_barrier2};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entry holding the shader pair `initQueueFamilyTypePrograms` builds.
#[derive(Clone, Copy)]
pub struct QueueTypePrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `FamilyType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum FamilyType {
    Ignored,
    External,
    Foreign,
    Arbitrary,
}

/// `getQueueFamilyIndex`
fn get_queue_family_index(family_type: FamilyType) -> u32 {
    match family_type {
        FamilyType::Ignored => vk::QUEUE_FAMILY_IGNORED,
        // VK_QUEUE_FAMILY_EXTERNAL
        FamilyType::External => !1u32,
        // VK_QUEUE_FAMILY_FOREIGN_EXT
        FamilyType::Foreign => !2u32,
        FamilyType::Arbitrary => 0xDEADBEEF,
    }
}

/// `IgnoreQueueFamilyBufferParams` / `IgnoreQueueFamilyImageParams`
#[derive(Clone, Copy)]
struct IgnoreQueueFamilyParams {
    family_type: FamilyType,
    sync2: bool,
}

/// Which of the three upstream test functions a case runs.
#[derive(Clone, Copy)]
enum Kind {
    /// `ignoreQueueFamilyTypeBuffer`
    Buffer,
    /// `ignoreQueueFamilyTypeImage`
    Image,
    /// `externalQueueFamilyImageBarrier`
    ExternalImageBarrier,
}

/// Same promotion caveat as everywhere a 1.1-promoted extension is required: the Context's
/// table has no entry for `VK_KHR_external_memory`.
fn require_external_memory(context: &Context<'_>) -> Result<(), TestError> {
    if context.api_version() >= (1, 1, 0) {
        return Ok(());
    }
    context.require_device_functionality("VK_KHR_external_memory")
}

/// `checkQueueFamilyTypeSupport`
fn check_queue_family_type_support(context: &Context<'_>, family_type: FamilyType) -> Result<(), TestError> {
    if family_type == FamilyType::External {
        require_external_memory(context)?;
    } else if family_type == FamilyType::Foreign {
        context.require_device_functionality("VK_EXT_queue_family_foreign")?;
    }
    Ok(())
}

/// `checkQueueFamilyTypeBufferSupport` (and `checkQueueFamilyTypeImageSupport`, which forwards to it)
fn check_queue_family_type_buffer_support(
    context: &Context<'_>,
    params: IgnoreQueueFamilyParams,
) -> Result<(), TestError> {
    check_queue_family_type_support(context, params.family_type)?;
    if params.sync2 {
        context.require_device_functionality("VK_KHR_synchronization2")?;
    }
    Ok(())
}

/// `getQueueFamilyTypeClearColor`
fn get_queue_family_type_clear_color() -> [f32; 4] {
    [0.0, 0.0, 0.0, 1.0]
}

/// `getQueueFamilyTypeGeomColor`
fn get_queue_family_type_geom_color() -> [f32; 4] {
    [0.0, 0.0, 1.0, 1.0]
}

/// `vkCmdPipelineBarrier2` with `dependencyFlags` 0 and a single barrier of one kind; the
/// shared recorder in operation.rs always adds BY_REGION, which these cases do not pass.
fn cmd_pipeline_barrier2_one(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    buffer_barrier: Option<&vk::BufferMemoryBarrier2>,
    image_barrier: Option<&vk::ImageMemoryBarrier2>,
) {
    let dependency_info = vk::DependencyInfo {
        s_type: vk::StructureType::DEPENDENCY_INFO,
        next: std::ptr::null(),
        dependency_flags: vk::DependencyFlags::empty(),
        memory_barrier_count: 0,
        memory_barriers: std::ptr::null(),
        buffer_memory_barrier_count: u32::from(buffer_barrier.is_some()),
        buffer_memory_barriers: buffer_barrier.map_or(std::ptr::null(), |b| b as *const _),
        image_memory_barrier_count: u32::from(image_barrier.is_some()),
        image_memory_barriers: image_barrier.map_or(std::ptr::null(), |b| b as *const _),
    };
    unsafe { device.cmd_pipeline_barrier2_khr(cmd_buffer, &dependency_info) };
}

/// `ignoreQueueFamilyTypeBuffer`
fn ignore_queue_family_type_buffer(context: &Context<'_>, params: IgnoreQueueFamilyParams) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let qf_index = context.get_universal_queue_family_index();

    let buffer_item_count = 64usize;
    let mut buffer_data = vec![0u32; buffer_item_count];

    let buffer_size = std::mem::size_of_val(buffer_data.as_slice()) as vk::DeviceSize;
    let buffer_usage = vk::BufferUsageFlags::TRANSFER_DST;
    let buffer_create_info = make_buffer_create_info(buffer_size, buffer_usage);
    let buffer = BufferWithMemory::new(vk, allocator, buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;
    {
        let alloc = buffer.get_allocation();
        unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, std::mem::size_of_val(buffer_data.as_slice())) };
        flush_alloc(vk, alloc)?;
    }

    let cmd_pool = make_command_pool(vk, qf_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let buffer_value: u32 = 0xAABBCCDD;
    let barrier_family_index = get_queue_family_index(params.family_type);

    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe { vk.cmd_fill_buffer(*cmd_buffer, buffer.get(), 0, vk::WHOLE_SIZE, buffer_value) };
    if params.sync2 {
        let mut barrier = make_buffer_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::PipelineStageFlags2::HOST,
            vk::AccessFlags2::HOST_READ,
            buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        barrier.src_queue_family_index = barrier_family_index;
        barrier.dst_queue_family_index = barrier_family_index;
        cmd_pipeline_barrier2_one(vk, *cmd_buffer, Some(&barrier), None);
    } else {
        let mut barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        barrier.src_queue_family_index = barrier_family_index;
        barrier.dst_queue_family_index = barrier_family_index;
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    // Verify buffer.
    let reference_values = vec![buffer_value; buffer_data.len()];
    {
        let alloc = buffer.get_allocation();
        invalidate_alloc(vk, alloc)?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                alloc.get_host_ptr().cast_const(),
                buffer_data.as_mut_ptr().cast::<u8>(),
                std::mem::size_of_val(buffer_data.as_slice()),
            )
        };
    }

    let mut fail = false;

    for (i, (&res, &reference)) in buffer_data.iter().zip(reference_values.iter()).enumerate() {
        if res != reference {
            log::info!("Unexpected value found at position {i}: expected {reference} but found {res}");
            fail = true;
        }
    }

    if fail {
        return Ok(TestStatus::fail(
            "Unexpected values found in output buffer; check log for details --",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The graphics pipeline `ignoreQueueFamilyTypeImage` builds through `GraphicsPipelineWrapper`
/// with its default states and an empty vertex input state.
fn make_queue_type_pipeline(
    device: &Device,
    pipeline_layout: vk::PipelineLayout,
    vert_module: vk::ShaderModule,
    frag_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
    extent: vk::Extent3D,
) -> Result<Unique<'_, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vert_module)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(frag_module)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];

    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent.width as f32,
        height: extent.height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, extent.width, extent.height)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);

    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);

    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::ZERO)
        .dst_color_blend_factor(vk::BlendFactor::ZERO)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ZERO)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// One of `ignoreQueueFamilyTypeImage`'s three image barriers, in either flavour.
#[allow(clippy::too_many_arguments)]
fn record_image_barrier(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    sync2: bool,
    barrier_family_index: u32,
    image: vk::Image,
    image_srr: vk::ImageSubresourceRange,
    (src_stage2, src_access2, dst_stage2, dst_access2): (
        vk::PipelineStageFlags2,
        vk::AccessFlags2,
        vk::PipelineStageFlags2,
        vk::AccessFlags2,
    ),
    (src_stage, src_access, dst_stage, dst_access): (
        vk::PipelineStageFlags,
        vk::AccessFlags,
        vk::PipelineStageFlags,
        vk::AccessFlags,
    ),
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) {
    if sync2 {
        let mut barrier = make_image_memory_barrier2(
            src_stage2,
            src_access2,
            dst_stage2,
            dst_access2,
            old_layout,
            new_layout,
            image,
            image_srr,
        );
        barrier.src_queue_family_index = barrier_family_index;
        barrier.dst_queue_family_index = barrier_family_index;
        cmd_pipeline_barrier2_one(vk, cmd_buffer, None, Some(&barrier));
    } else {
        let mut barrier = make_image_memory_barrier(src_access, dst_access, old_layout, new_layout, image, image_srr);
        barrier.src_queue_family_index = barrier_family_index;
        barrier.dst_queue_family_index = barrier_family_index;
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }
}

/// `ignoreQueueFamilyTypeImage`
fn ignore_queue_family_type_image(context: &Context<'_>, params: IgnoreQueueFamilyParams) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let qf_index = context.get_universal_queue_family_index();

    let extent_vk = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    };
    let format = vk::Format::R8G8B8A8_UNORM;
    let image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let vertex_count = 3u32; // See frag shader.
    let barrier_family_index = get_queue_family_index(params.family_type);

    // ImageWithBuffer
    let image_create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: extent_vk,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: image_usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;
    let image_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let image_view = make_image_view(vk, image.get(), vk::ImageViewType::_2D, format, image_srr)?;
    let pixel_size = 4u64; // R8G8B8A8_UNORM
    let image_buffer_size =
        u64::from(extent_vk.width) * u64::from(extent_vk.height) * u64::from(extent_vk.depth) * pixel_size;
    let image_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            image_buffer_size,
            vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let pipeline_layout = make_pipeline_layout(vk, &[])?;
    let render_pass = make_load_render_pass(vk)?;
    let framebuffer = make_framebuffer(vk, *render_pass, &[*image_view], extent_vk.width, extent_vk.height, 1)?;

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(vk, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(vk, binaries.get("frag")?)?;

    let pipeline = make_queue_type_pipeline(
        vk,
        *pipeline_layout,
        *vert_shader,
        *frag_shader,
        *render_pass,
        extent_vk,
    )?;

    let cmd_pool = make_command_pool(vk, qf_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let scissor = make_rect_2d(0, 0, extent_vk.width, extent_vk.height);

    begin_command_buffer(vk, *cmd_buffer)?;

    // Transition image from undefined to color attachment optimal after clearing it.
    record_image_barrier(
        vk,
        *cmd_buffer,
        params.sync2,
        barrier_family_index,
        image.get(),
        image_srr,
        (
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
        ),
        (
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::AccessFlags::empty(),
            vk::PipelineStageFlags::TRANSFER,
            vk::AccessFlags::TRANSFER_WRITE,
        ),
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
    );

    let clear_color = vk::ClearColorValue {
        float32: get_queue_family_type_clear_color(),
    };
    unsafe {
        vk.cmd_clear_color_image(
            *cmd_buffer,
            image.get(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_color,
            &[image_srr],
        )
    };

    record_image_barrier(
        vk,
        *cmd_buffer,
        params.sync2,
        barrier_family_index,
        image.get(),
        image_srr,
        (
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_READ | vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
        ),
        (
            vk::PipelineStageFlags::TRANSFER,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        ),
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    );

    // The LOAD attachment has no clear value to supply.
    let unused_clear_value = vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    };
    begin_render_pass(vk, *cmd_buffer, *render_pass, *framebuffer, scissor, unused_clear_value);
    unsafe {
        vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        vk.cmd_draw(*cmd_buffer, vertex_count, 1, 0, 0);
    }
    end_render_pass(vk, *cmd_buffer);

    // Transition image to the transfer src optimal layout and copy it out.
    record_image_barrier(
        vk,
        *cmd_buffer,
        params.sync2,
        barrier_family_index,
        image.get(),
        image_srr,
        (
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_READ,
        ),
        (
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::TRANSFER,
            vk::AccessFlags::TRANSFER_READ,
        ),
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
    );

    let copy_region = make_buffer_image_copy(extent_vk, image_srl);
    unsafe {
        vk.cmd_copy_image_to_buffer(
            *cmd_buffer,
            image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image_buffer.get(),
            &[copy_region],
        )
    };

    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    let buffer_alloc = image_buffer.get_allocation();
    invalidate_alloc(vk, buffer_alloc)?;

    // Reference and result, compared with a zero threshold.
    let tcu_format = map_vk_format(format)
        .ok_or_else(|| TestError::InternalError("no texture format for R8G8B8A8_UNORM".to_string()))?;
    let result_data =
        unsafe { std::slice::from_raw_parts(buffer_alloc.get_host_ptr().cast_const(), image_buffer_size as usize) };
    let result = ConstPixelBufferAccess::new(
        tcu_format,
        [extent_vk.width, extent_vk.height, extent_vk.depth],
        result_data,
    );
    let reference = get_queue_family_type_geom_color();

    let pixel = result.get_pixel(0, 0, 0);
    if (0..4).any(|c| (pixel[c] - reference[c]).abs() > 0.0) {
        log::info!("Result comparison failed: expected {reference:?}, got {pixel:?}");
        return Ok(TestStatus::fail(
            "Unexpected result in color buffer; check log for details",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `externalQueueFamilyImageBarrier`
fn external_queue_family_image_barrier(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let qf_index = context.get_universal_queue_family_index();

    let extent_vk = vk::Extent3D {
        width: 16,
        height: 16,
        depth: 1,
    };
    let format = vk::Format::R8G8B8A8_UNORM;
    let image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    let image_create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: extent_vk,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: image_usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;

    let cmd_pool = make_command_pool(vk, qf_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(vk, *cmd_buffer)?;

    let mut image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::SHADER_READ,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        image.get(),
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );

    unsafe {
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::BY_REGION,
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
    }

    image_barrier.src_access_mask = vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE;
    image_barrier.dst_access_mask = vk::AccessFlags::empty();
    image_barrier.old_layout = vk::ImageLayout::GENERAL;
    image_barrier.new_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
    image_barrier.src_queue_family_index = qf_index;
    // VK_QUEUE_FAMILY_EXTERNAL
    image_barrier.dst_queue_family_index = !1u32;
    unsafe {
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
    }

    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    Ok(TestStatus::pass("Pass"))
}

/// The `rust_type` of the manifest entry holding `initShaders`' pair.
#[derive(Clone, Copy)]
pub struct SmokeWorkPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `DEFAULT_TIMEOUT` - 2 seconds in nanoseconds
const DEFAULT_TIMEOUT: u64 = 2 * 1000 * 1000 * 1000;

/// What `generateWork` leaves in a `TestContext`: the recorded command buffer and everything it uses.
///
/// Field order is drop order: the command buffer goes back to its pool before the pool is
/// destroyed, and views/framebuffer go before the image and render pass they name.
#[allow(dead_code)] // most fields are only held for their drop order
struct Work<'a> {
    framebuffer: Unique<'a, vk::Framebuffer>,
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_cache: Unique<'a, vk::PipelineCache>,
    layout: Unique<'a, vk::PipelineLayout>,
    render_pass: Unique<'a, vk::RenderPass>,
    image_view: Unique<'a, vk::ImageView>,
    image: ImageWithMemory<'a>,
    render_read_buffer: BufferWithMemory<'a>,
    vertex_buffer: BufferWithMemory<'a>,
    cmd_buffer: UniqueCommandBuffer<'a>,
    command_pool: Unique<'a, vk::CommandPool>,
    fences: [Unique<'a, vk::Fence>; 2],
}

/// `createFences(vkd, device, false, 2, fences)`
fn create_work_fences(device: &Device) -> Result<[Unique<'_, vk::Fence>; 2], TestError> {
    let make = || -> Result<Unique<'_, vk::Fence>, TestError> {
        let info = vk::FenceCreateInfo::builder();
        let fence = unsafe { device.create_fence(&info, None) }.vk_check("vkCreateFence")?;
        Ok(Unique::new(device, fence))
    };
    Ok([make()?, make()?])
}

/// `createCommandBuffer` followed by `generateWork`, in the `TestContext` the caller would have built.
fn generate_work<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    queue_family_index: u32,
    binaries: &BinaryCollection,
    vertices: &[[f32; 4]],
    render_dimension: (u32, u32),
) -> Result<Work<'a>, TestError> {
    let render_size =
        (std::mem::size_of::<u32>() as u64) * u64::from(render_dimension.0) * u64::from(render_dimension.1);
    let fences = create_work_fences(device)?;

    // createCommandBuffer
    let command_pool = {
        let info = vk::CommandPoolCreateInfo::builder().queue_family_index(queue_family_index);
        let pool = unsafe { device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?;
        Unique::new(device, pool)
    };
    let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

    // \note VkShaderModule is consumed by vkCreate*Pipelines() so it can be deleted
    //       as pipeline has been constructed.
    let vert_shader_module = create_shader_module(device, binaries.get("glslvert")?)?;
    let frag_shader_module = create_shader_module(device, binaries.get("glslfrag")?)?;
    let entry = c"main";
    let shader_stage_params = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(*vert_shader_module)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(*frag_shader_module)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];

    // vertex buffer, with its host-write -> vertex-attribute-read barrier recorded but unused
    let vertex_bytes = std::mem::size_of_val(vertices) as vk::DeviceSize;
    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(vertex_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = vertex_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                alloc.get_host_ptr(),
                vertex_bytes as usize,
            )
        };
        flush_alloc(device, alloc)?;
    }

    let render_read_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(render_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let extent = vk::Extent3D {
        width: render_dimension.0,
        height: render_dimension.1,
        depth: 1,
    };

    // createVulkanImage
    let image_create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format: vk::Format::R8G8B8A8_UNORM,
        extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 1,
        queue_family_indices: &queue_family_index,
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let image = ImageWithMemory::new(device, allocator, image_create_info, MemoryRequirement::ANY)?;
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        vk::Format::R8G8B8A8_UNORM,
        subresource_range,
    )?;

    // createVulkanImage's barrier: UNDEFINED -> COLOR_ATTACHMENT_OPTIMAL
    let mut image_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        image.get(),
        subresource_range,
    );
    image_barrier.src_queue_family_index = queue_family_index;
    image_barrier.dst_queue_family_index = queue_family_index;

    // createColorOnlyRenderPass
    let render_pass = {
        let attachments = [vk::AttachmentDescription::builder()
            .format(vk::Format::R8G8B8A8_UNORM)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_attachment_ref = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let stencil_attachment_ref = vk::AttachmentReference::builder()
            .attachment(vk::ATTACHMENT_UNUSED)
            .layout(vk::ImageLayout::UNDEFINED)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_ref)
            .depth_stencil_attachment(&stencil_attachment_ref)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Unique::new(device, render_pass)
    };

    // createVertexInfo
    let binding_list = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(std::mem::size_of::<[f32; 4]>() as u32)
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let attr_list = [vk::VertexInputAttributeDescription::builder()
        .location(0)
        .binding(0)
        .format(vk::Format::R32G32B32A32_SFLOAT)
        .offset(0)
        .build()];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&binding_list)
        .vertex_attribute_descriptions(&attr_list);

    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_dimension.0 as f32,
        height: render_dimension.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, render_dimension.0, render_dimension.1)];
    let viewport_info = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);

    let raster_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .alpha_to_coverage_enable(false)
        .alpha_to_one_enable(false);

    let stencil_front = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(0)
        .write_mask(0)
        .reference(0)
        .build();
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_front)
        .back(stencil_front);

    let blend_attachment = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::ZERO)
        .src_alpha_blend_factor(vk::BlendFactor::ZERO)
        .dst_color_blend_factor(vk::BlendFactor::ZERO)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .color_blend_op(vk::BlendOp::ADD)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build()];
    let blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::COPY)
        .attachments(&blend_attachment);

    let layout = make_pipeline_layout(device, &[])?;

    let pipeline_state = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&shader_stage_params)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_info)
        .rasterization_state(&raster_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&blend_state)
        .layout(*layout)
        .render_pass(*render_pass)
        .subpass(0);

    let pipeline_cache = {
        let info = vk::PipelineCacheCreateInfo::builder();
        let cache = unsafe { device.create_pipeline_cache(&info, None) }.vk_check("vkCreatePipelineCache")?;
        Unique::new(device, cache)
    };
    let pipelines = unsafe { device.create_graphics_pipelines(*pipeline_cache, &[pipeline_state], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    let pipeline = Unique::new(device, pipelines.0[0]);

    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*image_view],
        render_dimension.0,
        render_dimension.1,
        1,
    )?;

    // The command buffer
    begin_command_buffer(device, *cmd_buffer)?;

    unsafe {
        device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
    }

    // recordRenderPass
    let binding_offset: vk::DeviceSize = 0;
    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 1.0, 1.0],
        },
    };
    begin_render_pass(
        device,
        *cmd_buffer,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, render_dimension.0, render_dimension.1),
        clear_value,
    );
    unsafe {
        device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[binding_offset]);
        device.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0);
    }
    end_render_pass(device, *cmd_buffer);

    let mut render_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image.get(),
        subresource_range,
    );
    render_barrier.src_queue_family_index = queue_family_index;
    render_barrier.dst_queue_family_index = queue_family_index;

    unsafe {
        device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[render_barrier],
        );
    }

    // copyToCPU
    let copy_state = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: render_dimension.0,
        buffer_image_height: render_dimension.1,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent,
    };
    unsafe {
        device.cmd_copy_image_to_buffer(
            *cmd_buffer,
            image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            render_read_buffer.get(),
            &[copy_state],
        )
    };

    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        render_read_buffer.get(),
        0,
        render_size,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(device, *cmd_buffer)?;

    Ok(Work {
        framebuffer,
        pipeline,
        pipeline_cache,
        layout,
        render_pass,
        image_view,
        image,
        render_read_buffer,
        vertex_buffer,
        cmd_buffer,
        command_pool,
        fences,
    })
}

/// `vkWaitForFences`' status without treating `VK_TIMEOUT` as an error - several of these checks are asking for it.
fn wait_for_fences(
    device: &Device,
    fences: &[vk::Fence],
    wait_all: bool,
    timeout: u64,
) -> Result<vk::SuccessCode, TestError> {
    match unsafe { device.wait_for_fences(fences, wait_all, timeout) } {
        Ok(code) => Ok(code),
        Err(e) => Err(TestError::ResourceError(format!("vkWaitForFences failed: {e}"))),
    }
}

fn get_fence_status(device: &Device, fence: vk::Fence) -> Result<vk::SuccessCode, TestError> {
    match unsafe { device.get_fence_status(fence) } {
        Ok(code) => Ok(code),
        Err(e) => Err(TestError::ResourceError(format!("vkGetFenceStatus failed: {e}"))),
    }
}

/// `testFences`
fn test_fences(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_idx = context.get_universal_queue_family_index();

    let vertices = [[0.5f32, 0.5, 0.0, 1.0], [-0.5, 0.5, 0.0, 1.0], [0.0, -0.5, 0.0, 1.0]];

    let test_context = generate_work(
        device,
        context.get_default_allocator(),
        queue_family_idx,
        &context.get_binary_collection(),
        &vertices,
        (256, 256),
    )?;

    // Default status is unsignaled
    let fence_status = get_fence_status(device, *test_context.fences[0])?;
    if fence_status != vk::SuccessCode::NOT_READY {
        log::info!("testSynchronizationPrimitives fence 0 should be reset but status is {fence_status:?}");
        return Ok(TestStatus::fail("Fence in incorrect state"));
    }
    let fence_status = get_fence_status(device, *test_context.fences[1])?;
    if fence_status != vk::SuccessCode::NOT_READY {
        log::info!("testSynchronizationPrimitives fence 1 should be reset but status is {fence_status:?}");
        return Ok(TestStatus::fail("Fence in incorrect state"));
    }

    let command_buffers = [test_context.cmd_buffer.get()];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], *test_context.fences[0]) }.vk_check("vkQueueSubmit")?;

    // Wait with timeout = 0
    let wait_status = wait_for_fences(device, &[*test_context.fences[0]], true, 0)?;
    if wait_status != vk::SuccessCode::SUCCESS && wait_status != vk::SuccessCode::TIMEOUT {
        // Will most likely end with VK_TIMEOUT
        log::info!("testSynchPrimitives failed to wait for a single fence");
        return Ok(TestStatus::fail("Failed to wait for a single fence"));
    }

    // Wait with a reasonable timeout
    let wait_status = wait_for_fences(device, &[*test_context.fences[0]], true, DEFAULT_TIMEOUT)?;
    if wait_status != vk::SuccessCode::SUCCESS && wait_status != vk::SuccessCode::TIMEOUT {
        // \note Wait can end with a timeout if DEFAULT_TIMEOUT is not sufficient
        log::info!("testSynchPrimitives failed to wait for a single fence");
        return Ok(TestStatus::fail("Failed to wait for a single fence"));
    }

    // Wait for work on fences[0] to actually complete
    let wait_status = wait_for_fences(device, &[*test_context.fences[0]], true, u64::MAX)?;
    if wait_status != vk::SuccessCode::SUCCESS {
        log::info!("testSynchPrimitives failed to wait for a fence");
        return Ok(TestStatus::fail("failed to wait for a fence"));
    }

    // Wait until timeout on a fence that has not been submitted
    let wait_status = wait_for_fences(device, &[*test_context.fences[1]], true, 1)?;
    if wait_status != vk::SuccessCode::TIMEOUT {
        log::info!("testSyncPrimitives failed to timeout on wait for single fence");
        return Ok(TestStatus::fail("failed to timeout on wait for single fence"));
    }

    // Check that the fence is signaled after the wait
    let fence_status = get_fence_status(device, *test_context.fences[0])?;
    if fence_status != vk::SuccessCode::SUCCESS {
        log::info!("testSynchronizationPrimitives fence should be signaled but status is {fence_status:?}");
        return Ok(TestStatus::fail("Fence in incorrect state"));
    }

    invalidate_alloc(device, test_context.render_read_buffer.get_allocation())?;

    Ok(TestStatus::pass("synchronization-fences passed"))
}

/// `SemaphoreTestConfig`
#[derive(Clone, Copy)]
struct SemaphoreTestConfig {
    sync2: bool,
    timeline: bool,
}

/// `Context::getTimelineSemaphoreFeatures().timelineSemaphore`, false when the device cannot say.
fn timeline_semaphore_feature(context: &Context<'_>) -> bool {
    if !(context.api_version() >= (1, 2, 0) || context.is_device_functionality_supported("VK_KHR_timeline_semaphore")) {
        return false;
    }
    let mut timeline_features = vk::PhysicalDeviceTimelineSemaphoreFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut timeline_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    timeline_features.timeline_semaphore != vk::FALSE
}

/// `checkSupport(Context&, SemaphoreTestConfig)`
fn check_semaphore_support(context: &Context<'_>, config: SemaphoreTestConfig) -> Result<(), TestError> {
    if config.timeline && context.api_version() < (1, 2, 0) {
        context.require_device_functionality("VK_KHR_timeline_semaphore")?;
    }
    if !timeline_semaphore_feature(context) {
        return Err(TestError::NotSupported("Timeline semaphore not supported".to_string()));
    }
    if config.sync2 {
        context.require_device_functionality("VK_KHR_synchronization2")?;
    }
    Ok(())
}

#[allow(clippy::too_many_arguments)]
/// One `SynchronizationWrapper::addSubmitInfo` + `queueSubmit` for a single command buffer,
/// with at most one wait and at most one signal on `semaphore` (value 1 either way).
fn submit_with_semaphore(
    device: &Device,
    config: SemaphoreTestConfig,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
    semaphore: vk::Semaphore,
    wait: bool,
    signal: bool,
    fence: vk::Fence,
) -> Result<(), TestError> {
    let value = 1u64;
    if config.sync2 {
        let wait_info = [vk::SemaphoreSubmitInfo {
            s_type: vk::StructureType::SEMAPHORE_SUBMIT_INFO,
            next: std::ptr::null(),
            semaphore,
            value,
            stage_mask: vk::PipelineStageFlags2::TOP_OF_PIPE,
            device_index: 0,
        }];
        let signal_info = [vk::SemaphoreSubmitInfo {
            s_type: vk::StructureType::SEMAPHORE_SUBMIT_INFO,
            next: std::ptr::null(),
            semaphore,
            value,
            stage_mask: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
            device_index: 0,
        }];
        let command_buffer_info = [vk::CommandBufferSubmitInfo {
            s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
            next: std::ptr::null(),
            command_buffer: cmd_buffer,
            device_mask: 0,
        }];
        let submit = vk::SubmitInfo2 {
            s_type: vk::StructureType::SUBMIT_INFO_2,
            next: std::ptr::null(),
            flags: vk::SubmitFlags::empty(),
            wait_semaphore_info_count: u32::from(wait),
            wait_semaphore_infos: if wait { wait_info.as_ptr() } else { std::ptr::null() },
            command_buffer_info_count: 1,
            command_buffer_infos: command_buffer_info.as_ptr(),
            signal_semaphore_info_count: u32::from(signal),
            signal_semaphore_infos: if signal { signal_info.as_ptr() } else { std::ptr::null() },
        };
        return unsafe { device.queue_submit2_khr(queue, &[submit], fence) }.vk_check("vkQueueSubmit2KHR");
    }

    let semaphores = [semaphore];
    let wait_stages = [vk::PipelineStageFlags::TOP_OF_PIPE];
    let values = [value];
    let command_buffers = [cmd_buffer];
    let timeline_info = vk::TimelineSemaphoreSubmitInfo {
        s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
        next: std::ptr::null(),
        wait_semaphore_value_count: u32::from(wait),
        wait_semaphore_values: values.as_ptr(),
        signal_semaphore_value_count: u32::from(signal),
        signal_semaphore_values: values.as_ptr(),
    };
    let submit = vk::SubmitInfo {
        s_type: vk::StructureType::SUBMIT_INFO,
        next: if config.timeline {
            std::ptr::from_ref(&timeline_info).cast()
        } else {
            std::ptr::null()
        },
        wait_semaphore_count: u32::from(wait),
        wait_semaphores: if wait { semaphores.as_ptr() } else { std::ptr::null() },
        wait_dst_stage_mask: if wait { wait_stages.as_ptr() } else { std::ptr::null() },
        command_buffer_count: 1,
        command_buffers: command_buffers.as_ptr(),
        signal_semaphore_count: u32::from(signal),
        signal_semaphores: if signal { semaphores.as_ptr() } else { std::ptr::null() },
    };
    unsafe { device.queue_submit(queue, &[submit], fence) }.vk_check("vkQueueSubmit")
}

/// `testSemaphores`
fn test_semaphores(context: &Context<'_>, config: SemaphoreTestConfig) -> TestOutcome {
    let multi_queue_device = context.multi_queue_device()?;
    let device = multi_queue_device.device();
    let allocator = multi_queue_device.allocator();

    // The family `createTestDevice` would have picked: the first graphics one with two queues.
    let Some(family) = multi_queue_device
        .families()
        .iter()
        .find(|f| f.flags.contains(vk::QueueFlags::GRAPHICS) && f.queues.len() >= 2)
    else {
        return Err(TestError::NotSupported(
            "Cannot create device with 2 graphics queues".to_string(),
        ));
    };
    let queue_family_idx = family.family_index;
    let queue = [family.queues[0], family.queues[1]];

    let binaries = context.get_binary_collection();

    let semaphore = {
        let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
            .semaphore_type(vk::SemaphoreType::TIMELINE)
            .initial_value(0);
        let info = if config.timeline {
            vk::SemaphoreCreateInfo::builder().push_next(&mut type_info)
        } else {
            vk::SemaphoreCreateInfo::builder()
        };
        let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
        Unique::new(device, semaphore)
    };

    let vertices1 = [[0.5f32, 0.5, 0.0, 1.0], [-0.5, 0.5, 0.0, 1.0], [0.0, -0.5, 0.0, 1.0]];
    let vertices2 = [[-0.5f32, -0.5, 0.0, 1.0], [0.5, -0.5, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0]];

    let test_context1 = generate_work(device, allocator, queue_family_idx, &binaries, &vertices1, (256, 256))?;
    let test_context2 = generate_work(device, allocator, queue_family_idx, &binaries, &vertices2, (256, 256))?;

    submit_with_semaphore(
        device,
        config,
        queue[0],
        test_context1.cmd_buffer.get(),
        *semaphore,
        false,
        true,
        *test_context1.fences[0],
    )?;

    let test_status = wait_for_fences(device, &[*test_context1.fences[0]], true, u64::MAX)?;
    if test_status != vk::SuccessCode::SUCCESS {
        log::info!("testSynchPrimitives failed to wait for a set fence");
        return Ok(TestStatus::fail("failed to wait for a set fence"));
    }

    invalidate_alloc(device, test_context1.render_read_buffer.get_allocation())?;

    // The difference between the second submit info is that it will use a unique cmd buffer.
    // First submit signals a semaphore but not wait on a semaphore, the other waits on the
    // semaphore but not signal it.
    submit_with_semaphore(
        device,
        config,
        queue[1],
        test_context2.cmd_buffer.get(),
        *semaphore,
        true,
        false,
        *test_context2.fences[0],
    )?;

    let test_status = wait_for_fences(device, &[*test_context2.fences[0]], true, u64::MAX)?;
    if test_status != vk::SuccessCode::SUCCESS {
        log::info!("testSynchPrimitives failed to wait for a set fence");
        return Ok(TestStatus::fail("failed to wait for a set fence"));
    }

    invalidate_alloc(device, test_context2.render_read_buffer.get_allocation())?;

    Ok(TestStatus::pass("synchronization-semaphores passed"))
}

/// The three `generateWork` cases, as one case type.
#[derive(Clone, Copy)]
enum WorkKind {
    Fences,
    Semaphores(SemaphoreTestConfig),
}

struct WorkCase {
    name: &'static str,
    kind: WorkKind,
    programs: BinaryCollection,
}

impl TestCase for WorkCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            WorkKind::Fences => Ok(()),
            WorkKind::Semaphores(config) => check_semaphore_support(context, config),
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WorkInstance {
            context,
            kind: self.kind,
        })
    }
}

struct WorkInstance<'a> {
    context: &'a Context<'a>,
    kind: WorkKind,
}

impl TestInstance for WorkInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            WorkKind::Fences => test_fences(self.context),
            WorkKind::Semaphores(config) => test_semaphores(self.context, config),
        }
    }
}

struct QueueTypeCase {
    name: String,
    kind: Kind,
    params: IgnoreQueueFamilyParams,
    programs: BinaryCollection,
}

impl TestCase for QueueTypeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_queue_family_type_buffer_support(context, self.params)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(QueueTypeInstance {
            context,
            kind: self.kind,
            params: self.params,
        })
    }
}

struct QueueTypeInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    params: IgnoreQueueFamilyParams,
}

impl TestInstance for QueueTypeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::Buffer => ignore_queue_family_type_buffer(self.context, self.params),
            Kind::Image => ignore_queue_family_type_image(self.context, self.params),
            Kind::ExternalImageBarrier => external_queue_family_image_barrier(self.context),
        }
    }
}

/// `kFamilyTypeCases`
const FAMILY_TYPE_CASES: [(FamilyType, &str); 4] = [
    (FamilyType::Ignored, "ignored"),
    (FamilyType::External, "external"),
    (FamilyType::Foreign, "foreign"),
    (FamilyType::Arbitrary, "arbitrary"),
];

/// `createSmokeTests` (legacy) / `createSynchronization2SmokeTests`, minus the `fences` and
/// semaphore cases.
pub fn create_smoke_tests(sync_type: SyncType) -> TestCaseGroup {
    use crate::generated::shaders::synchronization_smoke as g;

    let sync2 = sync_type == SyncType::Synchronization2;
    let mut smoke_tests = TestCaseGroup::new("smoke");
    let work_programs = g::SMOKE_WORK_PROGRAMS.programs;

    if !sync2 {
        smoke_tests.add_child(Box::new(WorkCase {
            name: "fences",
            kind: WorkKind::Fences,
            programs: work_programs,
        }) as Box<dyn TestCase>);
    }
    smoke_tests.add_child(Box::new(WorkCase {
        name: "binary_semaphores",
        kind: WorkKind::Semaphores(SemaphoreTestConfig { sync2, timeline: false }),
        programs: work_programs,
    }) as Box<dyn TestCase>);
    smoke_tests.add_child(Box::new(WorkCase {
        name: "timeline_semaphores",
        kind: WorkKind::Semaphores(SemaphoreTestConfig { sync2, timeline: true }),
        programs: work_programs,
    }) as Box<dyn TestCase>);

    for (family_type, name) in FAMILY_TYPE_CASES {
        let test_name = format!("queue_type_ignore_buffer_{name}");
        smoke_tests.add_child(Box::new(QueueTypeCase {
            name: test_name,
            kind: Kind::Buffer,
            params: IgnoreQueueFamilyParams { family_type, sync2 },
            programs: BinaryCollection::new(&[]),
        }) as Box<dyn TestCase>);
    }

    for (family_type, name) in FAMILY_TYPE_CASES {
        let test_name = format!("queue_type_ignore_image_{name}");
        smoke_tests.add_child(Box::new(QueueTypeCase {
            name: test_name,
            kind: Kind::Image,
            params: IgnoreQueueFamilyParams { family_type, sync2 },
            programs: g::QUEUE_TYPE_PROGRAMS.programs,
        }) as Box<dyn TestCase>);
    }

    if !sync2 {
        smoke_tests.add_child(Box::new(QueueTypeCase {
            name: "queue_type_image_barrier_external".to_string(),
            kind: Kind::ExternalImageBarrier,
            params: IgnoreQueueFamilyParams {
                family_type: FamilyType::External,
                sync2: false,
            },
            programs: BinaryCollection::new(&[]),
        }) as Box<dyn TestCase>);
    }

    smoke_tests
}
