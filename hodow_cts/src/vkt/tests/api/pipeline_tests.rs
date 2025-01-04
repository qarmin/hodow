// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiPipelineTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `vkt::addFunctionCase*` free functions become one `PipelineCase` with a `Kind`;
// the logging of the result image in drawTriangleTest is dropped.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::api_pipeline::{DESTROY_EARLY, DRAW_TRIANGLE, INVALID_POINTERS, LAYOUT_LIFETIME};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::clear_value_color;
use crate::vkt::tests::synchronization::image_layout_transition_tests::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `getRenderTargetFormat`
fn get_render_target_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    let feature_flags = vk::FormatFeatureFlags::COLOR_ATTACHMENT;

    for format in [vk::Format::B8G8R8A8_UNORM, vk::Format::R8G8B8A8_UNORM] {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties.linear_tiling_features.intersects(feature_flags)
            || properties.optimal_tiling_features.intersects(feature_flags)
        {
            return Ok(format);
        }
    }

    Err(TestError::NotSupported(
        "Device does not support VK_FORMAT_B8G8R8A8_UNORM nor VK_FORMAT_R8G8B8A8_UNORM".to_string(),
    ))
}

fn get_image_tiling(context: &Context<'_>, format: vk::Format) -> vk::ImageTiling {
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    if properties
        .linear_tiling_features
        .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
    {
        vk::ImageTiling::LINEAR
    } else {
        vk::ImageTiling::OPTIMAL
    }
}

fn make_attachment_image_info(
    format: vk::Format,
    tiling: vk::ImageTiling,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: 256,
            height: 256,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(tiling)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `createSimpleRenderPass`
fn create_simple_render_pass(
    device: &Device,
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_description = vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(stencil_load_op)
        .stencil_store_op(stencil_store_op)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(layout)
        .build();
    let attachment_references = [vk::AttachmentReference { attachment: 0, layout }];
    let subpass_description = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&attachment_references)
        .build();

    let attachments = [attachment_description];
    let subpasses = [subpass_description];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `changeColorAttachmentImageLayout`. The queue family indices are 0 on both sides, as upstream has them: equal indices are no transfer.
fn change_color_attachment_image_layout(device: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image) {
    let image_memory_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .old_layout(vk::ImageLayout::UNDEFINED)
        .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .src_queue_family_index(0)
        .dst_queue_family_index(0)
        .image(image)
        .subresource_range(make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1))
        .build();

    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_memory_barrier],
        );
    }
}

fn make_main_stage(stage: vk::ShaderStageFlags, module: vk::ShaderModule) -> vk::PipelineShaderStageCreateInfo {
    vk::PipelineShaderStageCreateInfo::builder()
        .stage(stage)
        .module(module)
        .name(b"main\0")
        .build()
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    stage: vk::PipelineShaderStageCreateInfo,
    layout: vk::PipelineLayout,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(0)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawTriangleMode {
    DestroyRenderPassAfterCreatingPipeline,
    DestroyPipelineLayoutAfterCreatingPipeline,
}

/// `drawTriangleTest`
fn draw_triangle_test(context: &Context<'_>, mode: DrawTriangleMode) -> TestOutcome {
    let device = context.get_device();
    let format = get_render_target_format(context)?;
    let image_tiling = get_image_tiling(context, format);

    let attachment_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        make_attachment_image_info(
            format,
            image_tiling,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::ANY,
    )?;

    let result_format = map_vk_format(format)
        .ok_or_else(|| TestError::InternalError("render target format has no tcu mapping".to_string()))?;
    let image_size_bytes = result_format.pixel_size().unwrap_or(4) as vk::DeviceSize * 256 * 256;
    let read_image_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(image_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = command_buffer.get();

    begin_command_buffer(device, cmd_buffer)?;

    // When testing renderpass lifetime - create two compatible renderpasses, otherwise use just renderPassB
    let mut render_pass_a = if mode == DrawTriangleMode::DestroyRenderPassAfterCreatingPipeline {
        Some(create_simple_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?)
    } else {
        None
    };

    let render_pass_b = create_simple_render_pass(
        device,
        format,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentStoreOp::DONT_CARE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;

    let attachment_image_view = make_image_view(
        device,
        attachment_image.get(),
        vk::ImageViewType::_2D,
        format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let frame_buffer = make_framebuffer(device, *render_pass_b, &[*attachment_image_view], 256, 256, 1)?;

    let binaries = context.get_binary_collection();
    let vertex_shader_module = create_shader_module(device, binaries.get("vertex")?)?;
    let fragment_shader_module = create_shader_module(device, binaries.get("fragment")?)?;

    let mut pipeline_layout = Some(make_pipeline_layout(device, &[])?);

    let render_pass_used_for_pipeline = match &render_pass_a {
        Some(render_pass) => **render_pass,
        None => *render_pass_b,
    };

    let graphics_pipeline = {
        let stages = [
            make_main_stage(vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
            make_main_stage(vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 64.0,
            height: 64.0,
            min_depth: 0.0,
            max_depth: 0.0,
        }];
        let scissors = [make_rect_2d(0, 0, 64, 64)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&color_blend_attachments)
            .blend_constants([1.0, 1.0, 1.0, 1.0]);

        let layout = **pipeline_layout
            .as_ref()
            .ok_or_else(|| TestError::InternalError("pipeline layout missing".to_string()))?;
        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(layout)
            .render_pass(render_pass_used_for_pipeline)
            .subpass(0)
            .base_pipeline_index(-1);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Unique::new(device, pipelines.0[0])
    };

    if mode == DrawTriangleMode::DestroyPipelineLayoutAfterCreatingPipeline {
        pipeline_layout = None;
    }

    begin_render_pass(
        device,
        cmd_buffer,
        *render_pass_b,
        *frame_buffer,
        make_rect_2d(0, 0, 256, 256),
        clear_value_color([0.25, 0.25, 0.25, 0.0]),
    );

    unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline) };

    // Destroy the renderpass that was used to create the graphics pipeline
    if mode == DrawTriangleMode::DestroyRenderPassAfterCreatingPipeline {
        render_pass_a = None;
    }

    unsafe {
        device.cmd_draw(cmd_buffer, 3, 1, 0, 0);
        device.cmd_end_render_pass(cmd_buffer);
    }

    // Copy image to buffer
    copy_image_to_buffer(
        device,
        cmd_buffer,
        attachment_image.get(),
        read_image_buffer.get(),
        (256, 256),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    );

    end_command_buffer(device, cmd_buffer)?;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;
    unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

    let read_alloc = read_image_buffer.get_allocation();
    invalidate_alloc(device, read_alloc)?;
    let data = unsafe { std::slice::from_raw_parts(read_alloc.get_host_ptr(), image_size_bytes as usize) };
    let result_access = ConstPixelBufferAccess::new(result_format, [256, 256, 1], data);

    // check just one pixel
    let pixel = result_access.get_pixel(1, 1, 0);
    drop((pipeline_layout, render_pass_a));
    if pixel[0] < 0.9 || pixel[1] > 0.1 || pixel[2] > 0.1 || pixel[3] < 0.9 {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `framebufferCompatibleRenderPassTest`, which has the same functionality as VkLayerTest.RenderPassInUseDestroyedSignaled
fn framebuffer_compatible_render_pass_test(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = command_buffer.get();

    begin_command_buffer(device, cmd_buffer)?;

    let format = get_render_target_format(context)?;
    let image_tiling = get_image_tiling(context, format);

    let attachment_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        make_attachment_image_info(format, image_tiling, vk::ImageUsageFlags::COLOR_ATTACHMENT),
        MemoryRequirement::ANY,
    )?;

    change_color_attachment_image_layout(device, cmd_buffer, attachment_image.get());

    let attachment_image_view = make_image_view(
        device,
        attachment_image.get(),
        vk::ImageViewType::_2D,
        format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;

    let render_pass_a = create_simple_render_pass(
        device,
        format,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentStoreOp::DONT_CARE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;

    // Create framebuffer using the first render pass
    let frame_buffer = make_framebuffer(device, *render_pass_a, &[*attachment_image_view], 256, 256, 1)?;

    let render_pass_b = create_simple_render_pass(
        device,
        format,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentLoadOp::LOAD,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::GENERAL,
    )?;

    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass_b)
        .framebuffer(*frame_buffer)
        .render_area(make_rect_2d(0, 0, 1, 1));
    unsafe {
        device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_end_render_pass(cmd_buffer);
    }

    end_command_buffer(device, cmd_buffer)?;

    let cmd_buffers = [cmd_buffer];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
    unsafe {
        device
            .queue_submit(queue, &[submit_info], vk::Fence::null())
            .vk_check("vkQueueSubmit")?;
        device.queue_wait_idle(queue).vk_check("vkQueueWaitIdle")?;
    }

    // Test should always pass
    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LifetimeBindPoint {
    Graphics,
    Compute,
}

/// `pipelineLayoutLifetimeTest`, which has the same functionality as VkLayerTest.DescriptorSetCompatibility
fn pipeline_layout_lifetime_test(context: &Context<'_>, bind_point: LifetimeBindPoint) -> TestOutcome {
    let device = context.get_device();
    let is_graphics = bind_point == LifetimeBindPoint::Graphics;
    let vk_bind_point = if is_graphics {
        vk::PipelineBindPoint::GRAPHICS
    } else {
        vk::PipelineBindPoint::COMPUTE
    };

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = command_buffer.get();

    begin_command_buffer(device, cmd_buffer)?;

    // These will only be used for graphics pipelines.
    let mut attachment_image: Option<ImageWithMemory<'_>> = None;
    let mut attachment_image_view = None;
    let mut render_pass = None;
    let mut frame_buffer = None;

    if is_graphics {
        // Create image, render pass and framebuffer.
        let format = get_render_target_format(context)?;
        let image_tiling = get_image_tiling(context, format);

        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            make_attachment_image_info(format, image_tiling, vk::ImageUsageFlags::COLOR_ATTACHMENT),
            MemoryRequirement::ANY,
        )?;

        change_color_attachment_image_layout(device, cmd_buffer, image.get());

        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let pass = create_simple_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *pass, &[*view], 256, 256, 1)?;

        attachment_image = Some(image);
        attachment_image_view = Some(view);
        render_pass = Some(pass);
        frame_buffer = Some(framebuffer);
    }

    let max_sets = if is_graphics { 3 } else { 5 };
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 10)
        .add_type(vk::DescriptorType::SAMPLED_IMAGE, 2)
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
        .build(device, vk::DescriptorPoolCreateFlags::empty(), max_sets)?;

    let shader_stage = if is_graphics {
        vk::ShaderStageFlags::FRAGMENT
    } else {
        vk::ShaderStageFlags::COMPUTE
    };

    let descriptor_set_layouts = [
        DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL, 0, 5)
            .build(device)?,
        DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER, shader_stage, 0, 5)
            .build(device)?,
        DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::SAMPLED_IMAGE, vk::ShaderStageFlags::ALL, 0, 2)
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::ALL, 1, 2)
            .build(device)?,
    ];

    let set_layout_handles_ac = [*descriptor_set_layouts[0], *descriptor_set_layouts[2]];
    let set_layout_handles_b = [*descriptor_set_layouts[1]];
    let set_layout_handles_bc = [*descriptor_set_layouts[1], *descriptor_set_layouts[2]];

    // The sets are never freed individually: the pool was created without FREE_DESCRIPTOR_SET.
    let mut descriptor_sets = [vk::DescriptorSet::null(); 3];
    for (set, layout) in descriptor_sets.iter_mut().zip(descriptor_set_layouts.iter()) {
        let layouts = [**layout];
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*descriptor_pool)
            .set_layouts(&layouts);
        *set = unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?[0];
    }

    let set_handles_ac = [descriptor_sets[0], descriptor_sets[2]];
    let set_handles_c = [descriptor_sets[2]];

    let pipeline_layout_ac = make_pipeline_layout(device, &set_layout_handles_ac)?;
    let pipeline_layout_bc = make_pipeline_layout(device, &set_layout_handles_bc)?;
    let mut pipeline_layout_b = Some(make_pipeline_layout(device, &set_layout_handles_b)?);
    let layout_b = **pipeline_layout_b
        .as_ref()
        .ok_or_else(|| TestError::InternalError("pipeline layout missing".to_string()))?;

    let binaries = context.get_binary_collection();
    let pipeline = if is_graphics {
        let vertex_module = create_shader_module(device, binaries.get("vertex")?)?;
        let fragment_module = create_shader_module(device, binaries.get("fragment")?)?;
        let stages = [
            make_main_stage(vk::ShaderStageFlags::VERTEX, *vertex_module),
            make_main_stage(vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
        // One viewport and one scissor whose pointers are null: both are dynamic.
        let mut viewport_state = vk::PipelineViewportStateCreateInfo::default();
        viewport_state.viewport_count = 1;
        viewport_state.scissor_count = 1;
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::BACK)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .min_sample_shading(0.0)
            .alpha_to_coverage_enable(false)
            .alpha_to_one_enable(false);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&color_blend_attachments)
            .blend_constants([1.0, 1.0, 1.0, 1.0]);
        let dynamic_states = [vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let render_pass_handle = render_pass
            .as_ref()
            .map(|r: &Unique<'_, vk::RenderPass>| **r)
            .ok_or_else(|| TestError::InternalError("render pass missing".to_string()))?;
        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .color_blend_state(&color_blend_state)
            .dynamic_state(&dynamic_state)
            .layout(layout_b)
            .render_pass(render_pass_handle)
            .subpass(0)
            .base_pipeline_index(0);

        let cache_info = vk::PipelineCacheCreateInfo::builder();
        let pipeline_cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&cache_info, None) }.vk_check("vkCreatePipelineCache")?,
        );
        let pipelines = unsafe { device.create_graphics_pipelines(*pipeline_cache, &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Unique::new(device, pipelines.0[0])
    } else {
        let compute_module = create_shader_module(device, binaries.get("compute")?)?;
        create_compute_pipeline(
            device,
            make_main_stage(vk::ShaderStageFlags::COMPUTE, *compute_module),
            layout_b,
        )?
    };

    if is_graphics {
        let (Some(pass), Some(framebuffer)) = (render_pass.as_ref(), frame_buffer.as_ref()) else {
            return Err(TestError::InternalError(
                "render pass or framebuffer missing".to_string(),
            ));
        };
        begin_render_pass(
            device,
            cmd_buffer,
            **pass,
            **framebuffer,
            make_rect_2d(0, 0, 256, 256),
            clear_value_color([0.25, 0.25, 0.25, 0.0]),
        );
    }
    unsafe { device.cmd_bind_pipeline(cmd_buffer, vk_bind_point, *pipeline) };

    // Destroy the pipeline layout that was used to create the pipeline
    pipeline_layout_b = None;

    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk_bind_point,
            *pipeline_layout_ac,
            0,
            &set_handles_ac,
            &[] as &[u32],
        );
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk_bind_point,
            *pipeline_layout_bc,
            1,
            &set_handles_c,
            &[] as &[u32],
        );
    }

    if is_graphics {
        let viewport = vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 16.0,
            height: 16.0,
            min_depth: 0.0,
            max_depth: 1.0,
        };
        let scissor = make_rect_2d(0, 0, 16, 16);
        unsafe {
            device.cmd_set_viewport(cmd_buffer, 0, &[viewport]);
            device.cmd_set_scissor(cmd_buffer, 0, &[scissor]);
        }
    }

    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk_bind_point,
            *pipeline_layout_ac,
            0,
            &set_handles_ac,
            &[] as &[u32],
        )
    };

    let _ = (&pipeline_layout_b, &attachment_image, &attachment_image_view);

    // Test should always pass
    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DestroyPipelineLayoutMode {
    AfterEndCommandBuffer,
    AfterCreateComputePipelines,
}

fn make_destroy_early_layout<'a>(
    device: &'a Device,
    set_layout: vk::DescriptorSetLayout,
    range: vk::PushConstantRange,
) -> Result<Unique<'a, vk::PipelineLayout>, TestError> {
    let set_layouts = [set_layout];
    let ranges = [range];
    let info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&ranges);
    let layout = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
    Ok(Unique::new(device, layout))
}

/// `destroyEarlyTest`
fn destroy_early_test(context: &Context<'_>, mode: DestroyPipelineLayoutMode) -> TestOutcome {
    let device = context.get_device();
    let alloc = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let q_index = context.get_universal_queue_family_index();

    const BUFFER_ELEMENTS: u32 = 100;
    const BUFFER_SIZE: u32 = BUFFER_ELEMENTS * std::mem::size_of::<u32>() as u32;
    const INITIAL_VALUE: u32 = 50;
    const FLAG_VALUE: u32 = 1;
    const BASE_VALUE: u32 = 75;
    let buffer_size_ds = BUFFER_SIZE as vk::DeviceSize;

    // Allocate and prepare buffer.
    let buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(buffer_size_ds, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let buffer_alloc = buffer.get_allocation();
    {
        let buffer_values = vec![INITIAL_VALUE; BUFFER_ELEMENTS as usize];
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_values.as_ptr(),
                buffer_alloc.get_host_ptr().cast::<u32>(),
                buffer_values.len(),
            )
        };
        flush_alloc(device, buffer_alloc)?;
    }

    // Descriptor set layout.
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;

    // Pipeline layout.
    let push_constant_range = vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::COMPUTE,
        offset: 0,
        size: std::mem::size_of::<u32>() as u32,
    };
    let mut pipeline_layout = Some(make_destroy_early_layout(
        device,
        *descriptor_set_layout,
        push_constant_range,
    )?);

    // Shader module.
    let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;

    // Pipeline, with shader and specialization info.
    let spec_constant_size = std::mem::size_of::<u32>();
    let map_entries = [vk::SpecializationMapEntry {
        constant_id: 0,
        offset: 0,
        size: spec_constant_size,
    }];
    let flag_bytes = FLAG_VALUE.to_ne_bytes();
    let specialization_info = vk::SpecializationInfo {
        map_entry_count: 1,
        map_entries: map_entries.as_ptr(),
        data_size: spec_constant_size,
        data: flag_bytes.as_ptr().cast(),
    };

    let mut shader_info = make_main_stage(vk::ShaderStageFlags::COMPUTE, *shader_module);
    shader_info.specialization_info = &specialization_info;

    let layout_handle = **pipeline_layout
        .as_ref()
        .ok_or_else(|| TestError::InternalError("pipeline layout missing".to_string()))?;
    let pipeline = create_compute_pipeline(device, shader_info, layout_handle)?;

    // Delete pipeline layout just after creating pipeline - this is what the test is for
    if mode == DestroyPipelineLayoutMode::AfterCreateComputePipelines {
        pipeline_layout = None;
    }

    // Descriptor set.
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    // Update descriptor set with buffer.
    let descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size_ds);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &descriptor_info,
        )
        .update(device);

    // Prepare command buffer.
    let cmd_pool = make_command_pool(device, q_index)?;
    let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer_ptr.get();
    let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);

    // Create new pipeline layout that will be used during dispatch
    if mode == DestroyPipelineLayoutMode::AfterCreateComputePipelines {
        pipeline_layout = Some(make_destroy_early_layout(
            device,
            *descriptor_set_layout,
            push_constant_range,
        )?);
    }
    let layout_handle = **pipeline_layout
        .as_ref()
        .ok_or_else(|| TestError::InternalError("pipeline layout missing".to_string()))?;

    begin_command_buffer(device, cmd_buffer)?;
    unsafe {
        device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk::PipelineBindPoint::COMPUTE,
            layout_handle,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_push_constants(
            cmd_buffer,
            layout_handle,
            vk::ShaderStageFlags::COMPUTE,
            0,
            &BASE_VALUE.to_ne_bytes(),
        );
        device.cmd_dispatch(cmd_buffer, BUFFER_ELEMENTS, 1, 1);
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd_buffer)?;

    // Delete pipeline layout just after recording command buffer - this is what the test is for
    if mode == DestroyPipelineLayoutMode::AfterEndCommandBuffer {
        pipeline_layout = None;
    }

    // Submit commands.
    submit_commands_and_wait(device, queue, cmd_buffer)?;

    // Check buffer.
    invalidate_alloc(device, buffer_alloc)?;
    let output_data =
        unsafe { std::slice::from_raw_parts(buffer_alloc.get_host_ptr().cast::<u32>(), BUFFER_ELEMENTS as usize) };

    for (i, &value) in output_data.iter().enumerate() {
        // This matches what the shader should calculate.
        let expected_value = INITIAL_VALUE + BASE_VALUE + i as u32;
        if value != expected_value {
            return Ok(TestStatus::fail(format!(
                "Unexpected value at buffer position {i}: expected {expected_value} but found {value}"
            )));
        }
    }

    drop(pipeline_layout);
    Ok(TestStatus::pass("Pass"))
}

/// `createSimpleGraphicsPipelineInvalidPointers` and `pipelineInvalidPointersUnusedStructsTest`
fn pipeline_invalid_pointers_unused_structs_test(context: &Context<'_>, bind_point: LifetimeBindPoint) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let is_graphics = bind_point == LifetimeBindPoint::Graphics;
    let vk_bind_point = if is_graphics {
        vk::PipelineBindPoint::GRAPHICS
    } else {
        vk::PipelineBindPoint::COMPUTE
    };
    let invalid_pointer = usize::MAX;

    let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = command_buffer.get();

    begin_command_buffer(device, cmd_buffer)?;

    let mut subpass_description = vk::SubpassDescription::default();
    subpass_description.pipeline_bind_point = vk::PipelineBindPoint::GRAPHICS;
    subpass_description.input_attachment_count = 0;
    subpass_description.input_attachments = invalid_pointer as *const vk::AttachmentReference;
    subpass_description.color_attachment_count = 0;
    subpass_description.color_attachments = invalid_pointer as *const vk::AttachmentReference;
    subpass_description.preserve_attachment_count = 0;
    subpass_description.preserve_attachments = invalid_pointer as *const u32;

    let mut render_pass_create_info = vk::RenderPassCreateInfo::default();
    render_pass_create_info.attachment_count = 0;
    render_pass_create_info.attachments = invalid_pointer as *const vk::AttachmentDescription;
    render_pass_create_info.subpass_count = 1;
    render_pass_create_info.subpasses = &subpass_description;
    render_pass_create_info.dependency_count = 0;
    render_pass_create_info.dependencies = invalid_pointer as *const vk::SubpassDependency;
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_create_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let mut framebuffer_create_info = vk::FramebufferCreateInfo::default();
    framebuffer_create_info.render_pass = *render_pass;
    framebuffer_create_info.attachment_count = 0;
    framebuffer_create_info.attachments = invalid_pointer as *const vk::ImageView;
    framebuffer_create_info.width = 256;
    framebuffer_create_info.height = 256;
    framebuffer_create_info.layers = 1;
    let frame_buffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_create_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    let mut pipeline_layout_create_info = vk::PipelineLayoutCreateInfo::default();
    pipeline_layout_create_info.set_layout_count = 0;
    pipeline_layout_create_info.set_layouts = invalid_pointer as *const vk::DescriptorSetLayout;
    pipeline_layout_create_info.push_constant_range_count = 0;
    pipeline_layout_create_info.push_constant_ranges = invalid_pointer as *const vk::PushConstantRange;
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_create_info, None) }
            .vk_check("vkCreatePipelineLayout")?,
    );

    let binaries = context.get_binary_collection();
    let pipeline = if is_graphics {
        let vertex_module = create_shader_module(device, binaries.get("vertex")?)?;
        let stages = [make_main_stage(vk::ShaderStageFlags::VERTEX, *vertex_module)];

        let mut vertex_input_state = vk::PipelineVertexInputStateCreateInfo::default();
        vertex_input_state.vertex_binding_description_count = 0;
        vertex_input_state.vertex_attribute_description_count = 0;
        vertex_input_state.vertex_attribute_descriptions =
            invalid_pointer as *const vk::VertexInputAttributeDescription;

        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);

        // Disable rasterization to test unused structs
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(true)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::BACK)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);

        let mut info = vk::GraphicsPipelineCreateInfo::default();
        info.stage_count = 1;
        info.stages = stages.as_ptr();
        info.vertex_input_state = &vertex_input_state;
        info.input_assembly_state = &*input_assembly_state;
        info.viewport_state = invalid_pointer as *const vk::PipelineViewportStateCreateInfo;
        info.rasterization_state = &*rasterization_state;
        info.multisample_state = invalid_pointer as *const vk::PipelineMultisampleStateCreateInfo;
        info.depth_stencil_state = invalid_pointer as *const vk::PipelineDepthStencilStateCreateInfo;
        info.color_blend_state = invalid_pointer as *const vk::PipelineColorBlendStateCreateInfo;
        info.layout = *pipeline_layout;
        info.render_pass = *render_pass;
        info.subpass = 0;
        info.base_pipeline_index = 0;

        let cache_info = vk::PipelineCacheCreateInfo::builder();
        let pipeline_cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&cache_info, None) }.vk_check("vkCreatePipelineCache")?,
        );
        let pipelines = unsafe { device.create_graphics_pipelines(*pipeline_cache, &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Unique::new(device, pipelines.0[0])
    } else {
        let compute_module = create_shader_module(device, binaries.get("compute")?)?;
        create_compute_pipeline(
            device,
            make_main_stage(vk::ShaderStageFlags::COMPUTE, *compute_module),
            *pipeline_layout,
        )?
    };

    if is_graphics {
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *frame_buffer,
            make_rect_2d(0, 0, 256, 256),
            clear_value_color([0.25, 0.25, 0.25, 0.0]),
        );
    }
    unsafe { device.cmd_bind_pipeline(cmd_buffer, vk_bind_point, *pipeline) };

    if is_graphics {
        unsafe {
            device.cmd_draw(cmd_buffer, 1, 1, 0, 0);
            device.cmd_end_render_pass(cmd_buffer);
        }
    } else {
        unsafe { device.cmd_dispatch(cmd_buffer, 1, 1, 1) };
    }
    end_command_buffer(device, cmd_buffer)?;

    let cmd_buffers = [cmd_buffer];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
    unsafe {
        device
            .queue_submit(queue, &[submit_info], vk::Fence::null())
            .vk_check("vkQueueSubmit")?;
        device.queue_wait_idle(queue).vk_check("vkQueueWaitIdle")?;
    }

    // Test should always pass
    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy)]
enum Kind {
    DestroyPipelineRenderPass,
    FramebufferCompatibleRenderPass,
    LayoutLifetime(LifetimeBindPoint),
    DestroyAfterEnd,
    DestroyAfterComputePipelineConstruction,
    DestroyAfterGraphicsPipelineConstruction,
    InvalidPointersUnusedStructs(LifetimeBindPoint),
}

struct PipelineCase {
    name: &'static str,
    kind: Kind,
    programs: BinaryCollection,
}

impl TestCase for PipelineCase {
    fn name(&self) -> &str {
        self.name
    }

    /// Both `checkSupport` and `checkMaintenance4Support` from upstream, selected by case.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::DestroyAfterEnd => Ok(()),
            Kind::DestroyAfterComputePipelineConstruction | Kind::DestroyAfterGraphicsPipelineConstruction => {
                context.require_device_functionality("VK_KHR_maintenance4")
            }
            _ => get_render_target_format(context).map(|_| ()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PipelineInstance {
            context,
            kind: self.kind,
        })
    }
}

struct PipelineInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for PipelineInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        match self.kind {
            Kind::DestroyPipelineRenderPass => {
                draw_triangle_test(context, DrawTriangleMode::DestroyRenderPassAfterCreatingPipeline)
            }
            Kind::FramebufferCompatibleRenderPass => framebuffer_compatible_render_pass_test(context),
            Kind::LayoutLifetime(bind_point) => pipeline_layout_lifetime_test(context, bind_point),
            Kind::DestroyAfterEnd => destroy_early_test(context, DestroyPipelineLayoutMode::AfterEndCommandBuffer),
            Kind::DestroyAfterComputePipelineConstruction => {
                destroy_early_test(context, DestroyPipelineLayoutMode::AfterCreateComputePipelines)
            }
            Kind::DestroyAfterGraphicsPipelineConstruction => {
                draw_triangle_test(context, DrawTriangleMode::DestroyPipelineLayoutAfterCreatingPipeline)
            }
            Kind::InvalidPointersUnusedStructs(bind_point) => {
                pipeline_invalid_pointers_unused_structs_test(context, bind_point)
            }
        }
    }
}

fn case(name: &'static str, kind: Kind, programs: BinaryCollection) -> Box<dyn TestCase> {
    Box::new(PipelineCase { name, kind, programs })
}

fn create_render_pass_tests() -> TestCaseGroup {
    let mut render_pass_tests = TestCaseGroup::new("renderpass");

    // Draw after destroying the renderpass used to create a pipeline
    render_pass_tests.add_child(case(
        "destroy_pipeline_renderpass",
        Kind::DestroyPipelineRenderPass,
        DRAW_TRIANGLE.programs,
    ));
    // Use a render pass with a framebuffer that was created using another compatible render pass
    render_pass_tests.add_child(case(
        "framebuffer_compatible_renderpass",
        Kind::FramebufferCompatibleRenderPass,
        NO_PROGRAMS,
    ));

    render_pass_tests
}

fn create_pipeline_layout_lifetime_tests() -> TestCaseGroup {
    let mut lifetime_tests = TestCaseGroup::new("lifetime");

    lifetime_tests.add_child(case(
        "graphics",
        Kind::LayoutLifetime(LifetimeBindPoint::Graphics),
        LAYOUT_LIFETIME.programs,
    ));
    lifetime_tests.add_child(case(
        "compute",
        Kind::LayoutLifetime(LifetimeBindPoint::Compute),
        LAYOUT_LIFETIME.programs,
    ));
    lifetime_tests.add_child(case("destroy_after_end", Kind::DestroyAfterEnd, DESTROY_EARLY.programs));
    lifetime_tests.add_child(case(
        "destroy_after_compute_pipeline_construction",
        Kind::DestroyAfterComputePipelineConstruction,
        DESTROY_EARLY.programs,
    ));
    lifetime_tests.add_child(case(
        "destroy_after_graphics_pipeline_construction",
        Kind::DestroyAfterGraphicsPipelineConstruction,
        DRAW_TRIANGLE.programs,
    ));

    lifetime_tests
}

fn create_pipeline_layout_tests() -> TestCaseGroup {
    let mut pipeline_layout_tests = TestCaseGroup::new("pipeline_layout");
    pipeline_layout_tests.add_child(create_pipeline_layout_lifetime_tests());
    pipeline_layout_tests
}

fn create_pipeline_invalid_pointers_unused_structs_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("pipeline_invalid_pointers_unused_structs");

    tests.add_child(case(
        "graphics",
        Kind::InvalidPointersUnusedStructs(LifetimeBindPoint::Graphics),
        INVALID_POINTERS.programs,
    ));
    tests.add_child(case(
        "compute",
        Kind::InvalidPointersUnusedStructs(LifetimeBindPoint::Compute),
        INVALID_POINTERS.programs,
    ));

    tests
}

/// `createPipelineTests` - the `dEQP-VK.api.pipeline` group.
pub fn create_pipeline_tests() -> TestCaseGroup {
    let mut pipeline_tests = TestCaseGroup::new("pipeline");

    pipeline_tests.add_child(create_render_pass_tests());
    pipeline_tests.add_child(create_pipeline_layout_tests());
    pipeline_tests.add_child(create_pipeline_invalid_pointers_unused_structs_tests());

    pipeline_tests
}
