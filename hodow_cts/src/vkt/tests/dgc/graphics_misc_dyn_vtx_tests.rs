// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc.toml` (case `dyn_vtx_input`,
// `scripts/gen_dgc_graphics_misc_manifest.py`). Only the monolithic `dynamic_vertex_input_monolithic[_execution_set]` cases are here (the
// library and shader object constructions stay gated stubs); the pipelines come from `make_mix_pipeline` of the mix tests with the vertex input
// and the binding strides as dynamic state. Vertex input binding divisors are 1 (the spec requires it for per-vertex rates; upstream uses 0).
//
// Check dynamic vertex input combined with DGC: 2x2 framebuffer, two executes with different vertex input states (one binding with two
// attributes for the top row, two bindings with separate attributes for the bottom row). With an execution set the frag shader of the second
// column reverses the colour components.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands};

use crate::generated::shaders::dgc_graphics_misc::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout_with_push_constants,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::graphics_draw_tests::{
    copy_image_to_buffer, float_threshold_compare, make_address_buffer, push_back_element,
};
use crate::vkt::tests::dgc::graphics_misc_mix_tests::make_mix_pipeline;
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const FRAG_SHADER_COUNT: u32 = 2;

struct DynVtxCase {
    name: String,
    use_execution_set: bool,
}

impl TestCase for DynVtxCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DynVtxInputCase::checkSupport` (pipelines)
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let bind_stages = if self.use_execution_set {
            stage_flags
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stage_flags,
            bind_stages,
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "dyn_vtx_input")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynVtxInstance {
            context,
            use_execution_set: self.use_execution_set,
        })
    }
}

struct DynVtxInstance<'a> {
    context: &'a Context<'a>,
    use_execution_set: bool,
}

/// A vertex of `PositionColor`: padding, position, padding, colour (16 bytes each).
fn position_color(position: Vec4, color: Vec4) -> [f32; 16] {
    let mut data = [0.0f32; 16];
    data[4..8].copy_from_slice(&position);
    data[12..16].copy_from_slice(&color);
    data
}

/// `SeparateColor`: padding, padding, colour.
fn separate_color(color: Vec4) -> [f32; 12] {
    let mut data = [0.0f32; 12];
    data[8..12].copy_from_slice(&color);
    data
}

/// `SeparatePosition`: four paddings, position.
fn separate_position(position: Vec4) -> [f32; 20] {
    let mut data = [0.0f32; 20];
    data[16..20].copy_from_slice(&position);
    data
}

impl TestInstance for DynVtxInstance<'_> {
    /// `DynVtxInputInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let use_execution_set = self.use_execution_set;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        // Create data for the 4 quadrants. Each pixel is covered by 4 vertices forming a triangle strip.
        let vertices_per_pixel = 4u32;
        let red: Vec4 = [1.0, 0.0, 0.0, 1.0];
        let yellow: Vec4 = [1.0, 1.0, 0.0, 1.0];
        let magenta: Vec4 = [1.0, 0.0, 1.0, 1.0];
        let white: Vec4 = [1.0, 1.0, 1.0, 1.0];

        // This will be used for the top row.
        let top_row_data: Vec<[f32; 16]> = vec![
            position_color([-1.0, -1.0, 0.0, 1.0], red),
            position_color([-1.0, 0.0, 0.0, 1.0], red),
            position_color([0.0, -1.0, 0.0, 1.0], red),
            position_color([0.0, 0.0, 0.0, 1.0], red),
            position_color([0.0, -1.0, 0.0, 1.0], yellow),
            position_color([0.0, 0.0, 0.0, 1.0], yellow),
            position_color([1.0, -1.0, 0.0, 1.0], yellow),
            position_color([1.0, 0.0, 0.0, 1.0], yellow),
        ];

        // The bottom row uses two bindings, one with the colors and another one with the positions.
        let bottom_row_color: Vec<[f32; 12]> = vec![
            separate_color(magenta),
            separate_color(magenta),
            separate_color(magenta),
            separate_color(magenta),
            separate_color(white),
            separate_color(white),
            separate_color(white),
            separate_color(white),
        ];
        let bottom_row_position: Vec<[f32; 20]> = vec![
            separate_position([-1.0, 0.0, 0.0, 1.0]),
            separate_position([-1.0, 1.0, 0.0, 1.0]),
            separate_position([0.0, 0.0, 0.0, 1.0]),
            separate_position([0.0, 1.0, 0.0, 1.0]),
            separate_position([0.0, 0.0, 0.0, 1.0]),
            separate_position([0.0, 1.0, 0.0, 1.0]),
            separate_position([1.0, 0.0, 0.0, 1.0]),
            separate_position([1.0, 1.0, 0.0, 1.0]),
        ];

        let (_top_row_buffer, top_row_address) =
            make_address_buffer(context, &top_row_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let (_bottom_row_color_buffer, bottom_row_color_address) =
            make_address_buffer(context, &bottom_row_color, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let (_bottom_row_position_buffer, bottom_row_position_address) =
            make_address_buffer(context, &bottom_row_position, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;

        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            *pipeline_layout,
        );
        if use_execution_set {
            cmds_layout_builder.add_execution_set_token(
                0,
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
                shader_stages,
            );
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_vertex_buffer_token(offset, 0);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_vertex_buffer_token(offset, 1);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let pipeline_count = if use_execution_set { 2u32 } else { 1 };
        debug_assert!(pipeline_count <= FRAG_SHADER_COUNT);

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let mut frag_modules = Vec::new();
        for i in 0..pipeline_count {
            frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
        }

        let mut pipelines = Vec::new();
        for frag_module in &frag_modules {
            pipelines.push(make_mix_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                *vert_module,
                **frag_module,
                fb_extent,
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                vk::CullModeFlags::NONE,
                false,
                vk::CompareOp::LESS_OR_EQUAL,
                true,
                use_execution_set,
                true,
            )?);
        }

        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if use_execution_set {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], pipeline_count)?;
            for (i, pipeline) in pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager.update();
            ies_manager = Some(manager);
        }
        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        let sequence_count = fb_extent; // One draw per pixel in each row.

        let top_row_bindings = [
            vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: top_row_address,
                size: std::mem::size_of_val(top_row_data.as_slice()) as u32,
                stride: std::mem::size_of::<[f32; 16]>() as u32,
            },
            vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: 0,
                size: 0,
                stride: 0,
            },
        ];
        let bottom_row_bindings = [
            vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: bottom_row_color_address,
                size: std::mem::size_of_val(bottom_row_color.as_slice()) as u32,
                stride: std::mem::size_of::<[f32; 12]>() as u32,
            },
            vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: bottom_row_position_address,
                size: std::mem::size_of_val(bottom_row_position.as_slice()) as u32,
                stride: std::mem::size_of::<[f32; 20]>() as u32,
            },
        ];

        let mut row_data: Vec<Vec<u32>> = vec![Vec::new(), Vec::new()];
        for (data, bindings) in row_data.iter_mut().zip([&top_row_bindings, &bottom_row_bindings]) {
            for i in 0..sequence_count {
                if use_execution_set {
                    data.push(i);
                }
                for binding_cmd in bindings {
                    push_back_element(data, binding_cmd);
                }
                let draw_cmd = vk::DrawIndirectCommand {
                    vertex_count: vertices_per_pixel,
                    instance_count: 1,
                    first_vertex: vertices_per_pixel * i,
                    first_instance: 0,
                };
                push_back_element(data, &draw_cmd);
            }
        }

        let mut dgc_buffers = Vec::new();
        for data in &row_data {
            let size = std::mem::size_of_val(data.as_slice()) as vk::DeviceSize;
            let buffer = DgcBuffer::new(
                context,
                size,
                vk::BufferUsageFlags::empty(),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            {
                let alloc = buffer.get_allocation();
                // SAFETY: the buffer was created with the size of the data.
                unsafe {
                    std::ptr::copy_nonoverlapping(data.as_ptr().cast::<u8>(), alloc.get_host_ptr(), size as usize)
                };
                flush_alloc(device, alloc)?;
            }
            dgc_buffers.push(buffer);
        }

        let preprocess_pipeline = if !use_execution_set {
            *pipelines[0]
        } else {
            vk::Pipeline::null()
        };
        let mut preprocess_buffers = Vec::new();
        for _ in 0..2 {
            preprocess_buffers.push(PreprocessBufferExt::new(
                context,
                ies_handle,
                cmds_layout.get(),
                sequence_count,
                0,
                preprocess_pipeline,
                0,
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent, fb_extent),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );

        let binding_descriptions = [
            vk::VertexInputBindingDescription2EXT {
                binding: 0,
                stride: 0,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            },
            vk::VertexInputBindingDescription2EXT {
                binding: 1,
                stride: 0,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            },
        ];
        let attribute = |location: u32, binding: u32, offset: u32| vk::VertexInputAttributeDescription2EXT {
            location,
            binding,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset,
            ..Default::default()
        };

        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let execute_row = |row: usize, attributes: &[vk::VertexInputAttributeDescription2EXT]| {
            unsafe { device.cmd_set_vertex_input_ext(cmd_buffer, &binding_descriptions, attributes) };
            let cmds_info = DgcGenCmdsInfo::new(
                shader_stages,
                ies_handle,
                cmds_layout.get(),
                dgc_buffers[row].get_device_address(),
                dgc_buffers[row].get_size(),
                preprocess_buffers[row].get_device_address(),
                preprocess_buffers[row].get_size(),
                sequence_count,
                0,
                0,
                preprocess_pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        };

        unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipelines[0]) };
        execute_row(0, &[attribute(0, 0, 16), attribute(1, 0, 48)]);

        unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, **pipelines.last().expect("pipelines")) };
        execute_row(1, &[attribute(0, 1, 64), attribute(1, 0, 32)]);

        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let result = color_buffer.read_bytes(device)?;
        let mut reference: Vec<Vec4> = Vec::new();
        for y in 0..fb_extent {
            for x in 0..fb_extent {
                let mut color: Vec4 = [1.0, x as f32, y as f32, 1.0];
                if use_execution_set && x > 0 {
                    // The frag shader used in col 1 reverses component order (frag1).
                    color = [color[3], color[2], color[1], color[0]];
                }
                reference.push(color);
            }
        }
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The monolithic `dynamic_vertex_input_*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_dyn_vtx_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    [false, true]
        .into_iter()
        .map(|use_execution_set| {
            let name = format!(
                "dynamic_vertex_input_monolithic{}",
                if use_execution_set { "_execution_set" } else { "" }
            );
            (
                format!("ext.graphics.misc.{name}"),
                Box::new(DynVtxCase {
                    name,
                    use_execution_set,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
