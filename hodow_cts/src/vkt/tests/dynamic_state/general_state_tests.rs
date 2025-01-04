// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateGeneralTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `general_state`: state switching between draws, the order states are bound in, state persisting across a pipeline
// change, a static stencil write mask of zero with a dynamic one set at draw time, and a pipeline bound twice around a
// state-setting command. The `_mesh` variants are not ported.

use vulkanalia::prelude::v1_0::*;

use super::construction::create_graphics_pipeline;
use crate::generated::shaders::dynamic_state_general::{DOUBLE_BIND, STATIC_STENCIL_MASK_ZERO};
use crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout, make_render_pass,
};
use crate::vk::pipeline_construction::PipelineConstructionType;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::create_shader_module;
use crate::vkt::tests::draw::util::{ImageWithBuffer, rect_2d};
use crate::vkt::tests::dynamic_state::base_class::{
    BLUE, BaseConfig, DepthStencilDynamicState, DynamicStateBase, GREEN, HEIGHT, PositionColorVertex, StateTestCase,
    WIDTH, build_reference_frame, check_nothing, make_color_depth_stencil_render_pass,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup};

fn rect(x: i32, y: i32, width: u32, height: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x, y },
        extent: vk::Extent2D { width, height },
    }
}

/// The four green vertices of `StateSwitchTestInstance` and `BindOrderTestInstance`.
fn quad_data() -> Vec<PositionColorVertex> {
    vec![
        PositionColorVertex::new([-1.0, 1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, 1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([-1.0, -1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, -1.0, 1.0, 1.0], GREEN),
    ]
}

/// The viewport and the two scissors the first three cases switch between.
fn viewport_and_scissors() -> (vk::Viewport, vk::Rect2D, vk::Rect2D) {
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: WIDTH as f32,
        height: HEIGHT as f32,
        min_depth: 0.0,
        max_depth: 0.0,
    };
    let scissor_1 = rect(0, 0, WIDTH / 2, HEIGHT / 2);
    let scissor_2 = rect((WIDTH / 2) as i32, (HEIGHT / 2) as i32, WIDTH / 2, HEIGHT / 2);
    (viewport, scissor_1, scissor_2)
}

/// The reference frame of `state_switch` and `bind_order`: the lower left and the upper right quarter, green.
fn two_green_quarters() -> Result<TextureLevel, TestError> {
    build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if ((-1.0..=0.0).contains(&y_coord) && (-1.0..=0.0).contains(&x_coord))
            || (y_coord > 0.0 && y_coord <= 1.0 && x_coord > 0.0 && x_coord < 1.0)
        {
            Some(GREEN)
        } else {
            None
        }
    })
}

/// `StateSwitchTestInstance`
fn state_switch_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let _device = context.get_device();
    let base = DynamicStateBase::new(context, BaseConfig::vertex_fetch(quad_data()))?;

    base.begin_render_pass()?;

    // bind states here
    let (viewport, scissor_1, scissor_2) = viewport_and_scissors();

    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());

    base.bind_pipeline(0);

    base.bind_vertex_buffer();

    // bind first state
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_1]);
    base.draw(base.data.len() as u32, 0);

    // bind second state
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_2]);
    base.draw(base.data.len() as u32, 0);

    base.end_and_submit()?;

    //validation
    let reference_frame = two_green_quarters()?;
    base.verify_against(&reference_frame)
}

/// `BindOrderTestInstance`
fn bind_order_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let _device = context.get_device();
    let base = DynamicStateBase::new(context, BaseConfig::vertex_fetch(quad_data()))?;

    base.begin_render_pass()?;

    // bind states here
    let (viewport, scissor_1, scissor_2) = viewport_and_scissors();

    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_1]);

    base.bind_pipeline(0);

    base.bind_vertex_buffer();

    // rebind in different order
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());

    // bind first state
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_1]);
    base.draw(base.data.len() as u32, 0);

    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_2]);
    base.draw(base.data.len() as u32, 0);

    base.end_and_submit()?;

    //validation
    let reference_frame = two_green_quarters()?;
    base.verify_against(&reference_frame)
}

/// `StatePersistenceTestInstance`: bound states persist across a change of pipeline.
fn state_persistence_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let _device = context.get_device();

    let mut data = quad_data();
    data.extend([
        PositionColorVertex::new([-1.0, 1.0, 1.0, 1.0], BLUE),
        PositionColorVertex::new([1.0, 1.0, 1.0, 1.0], BLUE),
        PositionColorVertex::new([-1.0, -1.0, 1.0, 1.0], BLUE),
        PositionColorVertex::new([-1.0, -1.0, 1.0, 1.0], BLUE),
        PositionColorVertex::new([1.0, 1.0, 1.0, 1.0], BLUE),
        PositionColorVertex::new([1.0, -1.0, 1.0, 1.0], BLUE),
    ]);

    // initPipeline: a triangle strip pipeline, and a triangle list one that differs by nothing else
    let mut config = BaseConfig::vertex_fetch(data);
    config.extra_topologies = vec![vk::PrimitiveTopology::TRIANGLE_LIST];
    let base = DynamicStateBase::new(context, config)?;

    base.begin_render_pass()?;

    // bind states here
    let (viewport, scissor_1, scissor_2) = viewport_and_scissors();

    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());

    base.bind_pipeline(0);

    base.bind_vertex_buffer();

    // bind first state
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_1]);
    // draw quad using vk::VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP
    base.draw(4, 0);

    base.bind_pipeline(1);

    // bind second state
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor_2]);
    // draw quad using vk::VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST
    base.draw(6, 4);

    base.end_and_submit()?;

    //validation
    let reference_frame = build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (-1.0..=0.0).contains(&y_coord) && (-1.0..=0.0).contains(&x_coord) {
            Some(GREEN)
        } else if y_coord > 0.0 && y_coord <= 1.0 && x_coord > 0.0 && x_coord < 1.0 {
            Some(BLUE)
        } else {
            None
        }
    })?;
    base.verify_against(&reference_frame)
}

/// `chooseDepthStencilFormat`: the spec mandates support for one of these two formats.
fn choose_depth_stencil_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    for format in [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT] {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Ok(format);
        }
    }
    Err(TestError::Fail("No suitable depth/stencil format found".to_string()))
}

/// `staticStencilMaskZeroProgramsTest`
///
/// On some implementations, when the static state is 0, the pipeline is created such that it is unable to avoid writing to
/// stencil when a pixel is discarded.
fn static_stencil_mask_zero_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let alloc = context.get_default_allocator();
    let (fb_width, fb_height) = (1u32, 1u32);
    let vk_extent = vk::Extent3D {
        width: fb_width,
        height: fb_height,
        depth: 1,
    };
    let fb_format = vk::Format::R8G8B8A8_UNORM;
    let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let ds_format = choose_depth_stencil_format(context)?;
    let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let clear_depth = 1.0f32;
    let clear_stencil = 0u32;
    let geom_color = BLUE; // Must match frag shader discard color.
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let ds_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);

    // Color buffer with verification buffer.
    let color_buffer = ImageWithBuffer::new(context, fb_width, fb_height, fb_format, fb_usage, 4)?;

    // Depth/stencil buffer.
    let ds_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(ds_format)
        .extent(vk_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(ds_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let ds_buffer = ImageWithMemory::new(device, alloc, ds_create_info, MemoryRequirement::ANY)?;
    let ds_image_view = make_image_view(device, ds_buffer.get(), vk::ImageViewType::_2D, ds_format, ds_srr)?;

    // Verification buffers for depth and stencil. The depth copy format of both candidates is four bytes wide.
    let depth_verif_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let stencil_verif_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(1, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Vertices.
    let vertices = [
        PositionColorVertex::new([-1.0, -1.0, 0.0, 1.0], geom_color),
        PositionColorVertex::new([-1.0, 3.0, 0.0, 1.0], geom_color),
        PositionColorVertex::new([3.0, -1.0, 0.0, 1.0], geom_color),
    ];

    // Vertex buffer
    let vb_size = std::mem::size_of_val(&vertices);
    let vertex_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(vb_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr().cast::<u8>(),
            vertex_buffer.get_allocation().get_host_ptr(),
            vb_size,
        )
    };
    flush_alloc(device, vertex_buffer.get_allocation())?; // strictly speaking, not needed.

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_color_depth_stencil_render_pass(
        device,
        fb_format,
        ds_format,
        vk::AttachmentLoadOp::CLEAR,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_buffer.view, *ds_image_view],
        fb_width,
        fb_height,
        1,
    )?;

    // Modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: fb_width as f32,
        height: fb_height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [rect_2d(fb_width, fb_height)];

    let stencil_static_write_mask = 0u32; // This is key for this test and what was causing issues in some implementations.
    let stencil_dynamic_write_mask = 0xFFu32;

    let dynamic_states = [vk::DynamicState::STENCIL_WRITE_MASK];
    let dynamic_state_info = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    // The stencil op state is such that it will overwrite the stencil value for all non-discarded fragments.
    // However, the fragment shader should discard all fragments.
    let stencil_op_state = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::REPLACE)
        .pass_op(vk::StencilOp::REPLACE)
        .depth_fail_op(vk::StencilOp::REPLACE)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(0xFF)
        .write_mask(stencil_static_write_mask)
        .reference(0xFF)
        .build();

    let vtx_binding_desc = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<PositionColorVertex>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let vtx_attributes = [
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 16,
        },
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&vtx_binding_desc)
        .vertex_attribute_descriptions(&vtx_attributes);
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);

    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(true)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    // setDefaultRasterizationState, setDefaultMultisampleState and setDefaultColorBlendState
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(*vert_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(*frag_module)
            .name(b"main\0")
            .build(),
    ];
    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .dynamic_state(&dynamic_state_info)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipeline = create_graphics_pipeline(device, &pipeline_info)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_values = [
        vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        },
        vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: clear_depth,
                stencil: clear_stencil,
            },
        },
    ];

    begin_command_buffer(device, cmd)?;
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(scissors[0])
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, stencil_dynamic_write_mask); // Write every value.
        device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    {
        // Insert barriers and copy images to the different verification buffers.
        let image_barriers = [
            // Color barrier.
            make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.image.get(),
                color_srr,
            ),
            // Depth/stencil barrier.
            make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                ds_buffer.get(),
                ds_srr,
            ),
        ];
        let src_pipeline_stages = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;

        let color_region = make_buffer_image_copy(
            vk_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let depth_region = make_buffer_image_copy(
            vk_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
        );
        let stencil_region = make_buffer_image_copy(
            vk_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, 0, 1),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                src_pipeline_stages,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_buffer.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.buffer.get(),
                &[color_region],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                ds_buffer.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_verif_buffer.get(),
                &[depth_region],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                ds_buffer.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                stencil_verif_buffer.get(),
                &[stencil_region],
            );
        }
    }
    {
        // Transfer to host sync barrier.
        let transfer_to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[transfer_to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Verify color output: all fragments should have been discarded.
    let color_bytes = color_buffer.read_bytes(device)?;
    if color_bytes != [0u8, 0, 0, 255] {
        return Ok(TestStatus::fail(
            "Unexpected color in result buffer; check log for details",
        ));
    }

    // Verify depth: all fragments should have been discarded.
    invalidate_alloc(device, depth_verif_buffer.get_allocation())?;
    let depth_bytes = unsafe { std::slice::from_raw_parts(depth_verif_buffer.get_allocation().get_host_ptr(), 4) };
    let depth_word = u32::from_le_bytes([depth_bytes[0], depth_bytes[1], depth_bytes[2], depth_bytes[3]]);
    let depth_ok = if ds_format == vk::Format::D32_SFLOAT_S8_UINT {
        f32::from_bits(depth_word) == clear_depth
    } else {
        depth_word & 0x00ff_ffff == 0x00ff_ffff
    };
    if !depth_ok {
        return Ok(TestStatus::fail(
            "Unexpected depth in result buffer; check log for details",
        ));
    }

    // Verify stencil: all fragments should have been discarded.
    invalidate_alloc(device, stencil_verif_buffer.get_allocation())?;
    let stencil_byte = unsafe { *stencil_verif_buffer.get_allocation().get_host_ptr() };
    if u32::from(stencil_byte) != clear_stencil {
        return Ok(TestStatus::fail(
            "Unexpected stencil value in result buffer; check log for details",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `doubleBindTest`
///
/// The test does:
/// - bind pipeline with some static state.
/// - set state command for that static state (to a bad value).
/// - bind the same pipeline again.
/// - draw.
/// - verify the good value has been used.
///
/// In this case, the bad state and value will be the scissor, but the pipeline will also have a dynamic viewport.
fn double_bind_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let (fb_width, fb_height) = (2u32, 2u32);
    let fb_format = vk::Format::R8G8B8A8_UNORM;
    let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let bind_point = vk::PipelineBindPoint::GRAPHICS;

    // Color buffer with verification buffer.
    let color_buffer = ImageWithBuffer::new(context, fb_width, fb_height, fb_format, fb_usage, 4)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_render_pass(device, fb_format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_width, fb_height, 1)?;

    // Modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let dynamic_states = [vk::DynamicState::VIEWPORT];
    let dynamic_state_create_info = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let good_viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: fb_width as f32,
        height: fb_height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    };
    let good_scissor = rect_2d(fb_width, fb_height);
    let bad_viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: 1.0,
        height: 1.0,
        min_depth: 0.0,
        max_depth: 1.0,
    }; // Needs to be smaller than the framebuffer.
    let bad_scissor = rect_2d(1, 1); // Needs to be smaller than the framebuffer.

    let static_viewports = [bad_viewport];
    let static_scissors = [good_scissor];

    let vertex_input_state_create_info = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&static_viewports)
        .scissors(&static_scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
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
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(*vert_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(*frag_module)
            .name(b"main\0")
            .build(),
    ];
    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state_create_info)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .dynamic_state(&dynamic_state_create_info)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipeline = create_graphics_pipeline(device, &pipeline_info)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { float32: clear_color },
    }];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(good_scissor)
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
        device.cmd_set_scissor(cmd, 0, &[bad_scissor]); // This should not be taken into account.
        device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
        device.cmd_set_viewport(cmd, 0, &[good_viewport]); // The static one was bad too.
        device.cmd_draw(cmd, 3, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        fb_width,
        fb_height,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Verify color output: every pixel is the geometry colour.
    let result = color_buffer.read_bytes(device)?;
    if result.chunks_exact(4).any(|pixel| pixel != [0u8, 0, 255, 255]) {
        return Ok(TestStatus::fail(
            "Unexpected color in result buffer; check log for details",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `DynamicStateGeneralTests`
pub fn create_general_state_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("general_state");

    // Perform multiple draws with different VP states (scissor test)
    group.add_child(Box::new(StateTestCase {
        name: "state_switch",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: state_switch_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "state_switch_mesh",
            support: check_nothing,
            run: state_switch_run,
        }) as Box<dyn TestCase>,
    );
    // Check if binding order is not important for pipeline configuration
    group.add_child(Box::new(StateTestCase {
        name: "bind_order",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: bind_order_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "bind_order_mesh",
            support: check_nothing,
            run: bind_order_run,
        }) as Box<dyn TestCase>,
    );
    // Check if bound states are persistent across pipelines
    group.add_child(Box::new(StateTestCase {
        name: "state_persistence",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: state_persistence_run,
    }) as Box<dyn TestCase>);

    group.add_child(Box::new(StateTestCase {
        name: "static_stencil_mask_zero",
        programs: STATIC_STENCIL_MASK_ZERO.programs,
        support: check_nothing,
        run: static_stencil_mask_zero_run,
    }) as Box<dyn TestCase>);
    if !construction.is_shader_object() {
        group.add_child(Box::new(StateTestCase {
            name: "double_static_bind",
            programs: DOUBLE_BIND.programs,
            support: check_nothing,
            run: double_bind_run,
        }) as Box<dyn TestCase>);
    }

    group
}
