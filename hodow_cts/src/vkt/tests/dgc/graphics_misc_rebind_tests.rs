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
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc.toml` (cases `rebind_es` and
// `rebind_noes`, `scripts/gen_dgc_graphics_misc_manifest.py`). The pipelines are made by `build_draw_pipeline` of the draw tests.
//
// Here: `rebind_normal_state[_with_execution_set]` of `dgc.ext.graphics.misc` (normalDGCNormalRun): a normal draw, two DGC sequences that
// rebind pipeline, push constant, vertex and index buffers, and a last normal draw using the normal pipeline and buffers again.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

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
    Construction, PipelineOptions, StageModules, build_draw_pipeline, copy_image_to_buffer, float_threshold_compare,
    make_address_buffer, push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

struct RebindCase {
    name: String,
    use_execution_set: bool,
}

impl TestCase for RebindCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `normalDGCNormalCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let bind_flags = if self.use_execution_set {
            stage_flags
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stage_flags,
            bind_flags,
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        // Required by the vertex buffer token (core in 1.3).
        if context.api_version() >= (1, 3, 0) {
            return Ok(());
        }
        context.require_device_functionality("VK_EXT_extended_dynamic_state")
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = if self.use_execution_set {
            "rebind_es"
        } else {
            "rebind_noes"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RebindInstance {
            context,
            use_execution_set: self.use_execution_set,
        })
    }
}

struct RebindInstance<'a> {
    context: &'a Context<'a>,
    use_execution_set: bool,
}

impl TestInstance for RebindInstance<'_> {
    /// `normalDGCNormalRun`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let use_execution_set = self.use_execution_set;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let dgc_frag_shader_count: u32 = if use_execution_set { 2 } else { 1 };

        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        // Shaders.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_normal_module = create_shader_module(device, binaries.get("fragNormal")?)?;
        let mut frag_dgc_modules = Vec::new();
        for i in 0..dgc_frag_shader_count {
            frag_dgc_modules.push(create_shader_module(device, binaries.get(&format!("fragDGC{i}"))?)?);
        }

        // Push constants.
        let pc_stages = vk::ShaderStageFlags::FRAGMENT;
        let pc_size = std::mem::size_of::<u32>() as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;

        let make_pipeline = |frag: vk::ShaderModule, dynamic_stride: bool, indirect_bindable: bool| {
            build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_module,
                    tesc: None,
                    tese: None,
                    geom: None,
                    frag,
                },
                &PipelineOptions {
                    extent: (fb_extent, fb_extent),
                    topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                    patch_control_points: 0,
                    dynamic_stride,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable,
                    construction: Construction::Monolithic,
                    depth_test: false,
                    rendering: None,
                },
            )
        };

        // Normal pipeline.
        let normal_pipeline = make_pipeline(*frag_normal_module, false, false)?;

        // Pipelines to be used with DGC, which may be non-indirect pipelines as well, but they can be indirect ones.
        let mut dgc_pipelines = Vec::new();
        for frag_module in &frag_dgc_modules {
            dgc_pipelines.push(make_pipeline(**frag_module, true, use_execution_set)?);
        }

        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if use_execution_set {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *dgc_pipelines[0], dgc_frag_shader_count)?;
            // Overwrite all pipelines in the set.
            for (i, pipeline) in dgc_pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager.update();
            ies_manager = Some(manager);
        }
        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // The framebuffer is 2x2.
        // The first normal draw handles the NW quadrant.
        // The DGC draws handle the NE and SW quadrants.
        // The second normal draw handles the SE quadrant.
        //
        // 4 vertices per pixel forming a quad: 16 vertices. Both vertex and index buffers vary between normal and DGC draws.
        // Normal draws: the first 8 vertices are bad values, the last ones handle NW and SE; the indices are 8..15.
        // DGC draws: the first 8 vertices hold the NE and SW quadrants; the last 8 are bad values; the indices are 0..7.
        let bad_vertex: Vec4 = [10.0, 10.0, 0.0, 1.0];

        let mut normal_vertices: Vec<Vec4> = vec![bad_vertex; 8];
        normal_vertices.extend_from_slice(&[
            // NW
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 0.0, 0.0, 1.0],
            [0.0, -1.0, 0.0, 1.0],
            [0.0, 0.0, 0.0, 1.0],
            // SE
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ]);
        let (normal_vertex_buffer, _) =
            make_address_buffer(context, &normal_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let normal_indices: Vec<u32> = vec![8, 9, 10, 11, 12, 13, 14, 15];
        let (normal_index_buffer, _) =
            make_address_buffer(context, &normal_indices, vk::BufferUsageFlags::INDEX_BUFFER)?;

        let mut dgc_vertices: Vec<Vec4> = vec![
            // NE
            [0.0, -1.0, 0.0, 1.0],
            [0.0, 0.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            // SW
            [-1.0, 0.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
        ];
        dgc_vertices.extend_from_slice(&[bad_vertex; 8]); // Others.
        let (_dgc_vertex_buffer, dgc_vertex_address) =
            make_address_buffer(context, &dgc_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let dgc_indices: Vec<u32> = vec![0, 1, 2, 3, 4, 5, 6, 7];
        let (_dgc_index_buffer, dgc_index_address) =
            make_address_buffer(context, &dgc_indices, vk::BufferUsageFlags::INDEX_BUFFER)?;

        // Indirect commands layout.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        if use_execution_set {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_execution_set_token(
                offset,
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
                stage_flags,
            );
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_sequence_index_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_vertex_buffer_token(offset, 0);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_index_buffer_token(offset, vk::IndirectCommandsInputModeFlagsEXT::VULKAN_INDEX_BUFFER);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_indexed_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC buffer.
        const SEQUENCE_COUNT: u32 = 2;
        let mut dgc_data: Vec<u32> = Vec::new();

        // DGC vertex and index buffers stay constant.
        let vertex_buffer_bind_cmd = vk::BindVertexBufferIndirectCommandEXT {
            buffer_address: dgc_vertex_address,
            size: std::mem::size_of_val(dgc_vertices.as_slice()) as u32,
            stride: std::mem::size_of::<Vec4>() as u32,
        };
        let index_buffer_bind_cmd = vk::BindIndexBufferIndirectCommandEXT {
            buffer_address: dgc_index_address,
            size: std::mem::size_of_val(dgc_indices.as_slice()) as u32,
            index_type: vk::IndexType::UINT32,
        };
        let dgc_vertices_per_seq = dgc_indices.len() as u32 / SEQUENCE_COUNT;

        for i in 0..SEQUENCE_COUNT {
            if use_execution_set {
                dgc_data.push(i); // Pipeline index.
            }
            dgc_data.push(u32::MAX); // Placeholder for the sequence item.
            push_back_element(&mut dgc_data, &vertex_buffer_bind_cmd);
            push_back_element(&mut dgc_data, &index_buffer_bind_cmd);
            let draw_cmd = vk::DrawIndexedIndirectCommand {
                index_count: dgc_vertices_per_seq,
                instance_count: 1,
                first_index: dgc_vertices_per_seq * i,
                vertex_offset: 0,
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_pipeline = if use_execution_set {
            vk::Pipeline::null()
        } else {
            *dgc_pipelines[0]
        };
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_handle,
            cmds_layout.get(),
            SEQUENCE_COUNT,
            0,
            preprocess_pipeline,
            0,
        )?;

        // Commands.
        let per_quadrant_vertices = 4u32;
        let clear_color: Vec4 = [0.0; 4];
        let normal_seq_index: u32 = if use_execution_set { 0 } else { 1 }; // Make it different from the last DGC one.

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
                color: vk::ClearColorValue { float32: clear_color },
            },
        );

        let normal_draw = |first_index: u32| unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[normal_vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd_buffer, normal_index_buffer.get(), 0, vk::IndexType::UINT32);
            device.cmd_push_constants(
                cmd_buffer,
                *pipeline_layout,
                pc_stages,
                0,
                &normal_seq_index.to_ne_bytes(),
            );
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *normal_pipeline);
            device.cmd_draw_indexed(cmd_buffer, per_quadrant_vertices, 1, first_index, 0, 0);
        };

        // First normal draw: NW
        normal_draw(0);

        // DGC draw: NE and SW.
        {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *dgc_pipelines[0]) };
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                ies_handle,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                SEQUENCE_COUNT,
                0,
                0,
                preprocess_pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }

        // Last normal draw: SE
        normal_draw(per_quadrant_vertices);

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

        // Pixel order: (0,0), (1,0), (0,1), (1,1).
        let normal_color: Vec4 = [1.0, 1.0, normal_seq_index as f32, 1.0];
        let red = 1.0f32;
        let red_alt = if use_execution_set { 0.0f32 } else { 1.0 };
        let reference: [Vec4; 4] = [
            normal_color,
            [red, 0.0, 0.0, 1.0],
            [red_alt, 0.0, 1.0, 1.0],
            normal_color,
        ];

        let result = color_buffer.read_bytes(device)?;
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `rebind_normal_state*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_rebind_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    [false, true]
        .into_iter()
        .map(|use_execution_set| {
            let name = format!(
                "rebind_normal_state{}",
                if use_execution_set { "_with_execution_set" } else { "" }
            );
            (
                format!("ext.graphics.misc.{name}"),
                Box::new(RebindCase {
                    name,
                    use_execution_set,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
