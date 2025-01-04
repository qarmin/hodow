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
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc.toml` (cases `reuse_es` and
// `reuse_noes`, `scripts/gen_dgc_graphics_misc_manifest.py`). The pipelines are made by `build_draw_pipeline` of the draw tests, so only the
// monolithic, fast linked and link time optimized constructions exist (`reuse_dgc_for_normal_unlinked_spirv_*` need shader objects and stay
// gated stubs).
//
// Here: `reuse_dgc_for_normal_*` of `dgc.ext.graphics.misc` (NormalDGCDrawReuseInstance): normal draws and DGC draws sharing a pipeline
// (or the pipelines of an execution set) in both orders.

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
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
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

#[derive(Clone, Copy, PartialEq, Eq)]
enum Order {
    NormalDgc,
    DgcNormal,
}

#[derive(Clone, Copy)]
struct Params {
    construction: Construction,
    order: Order,
    use_execution_set: bool,
}

impl Params {
    /// This will also determine the number of frag shaders in use.
    fn frag_colors(&self) -> Vec<Vec4> {
        if self.use_execution_set {
            vec![[1.0, 0.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0]]
        } else {
            vec![[1.0, 0.0, 1.0, 1.0]]
        }
    }

    fn construction_type(&self) -> PipelineConstructionType {
        match self.construction {
            Construction::Monolithic => PipelineConstructionType::Monolithic,
            Construction::FastLinked => PipelineConstructionType::FastLinkedLibrary,
            Construction::LinkTimeOptimized => PipelineConstructionType::LinkTimeOptimizedLibrary,
        }
    }
}

struct ReuseCase {
    name: String,
    params: Params,
}

impl TestCase for ReuseCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NormalDGCDrawReuseCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let bind_stages = if self.params.use_execution_set {
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
        if self.params.construction != Construction::Monolithic {
            context.require_device_functionality("VK_EXT_graphics_pipeline_library")?;
            check_pipeline_construction_requirements(context, self.params.construction_type())?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = if self.params.use_execution_set {
            "reuse_es"
        } else {
            "reuse_noes"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ReuseInstance {
            context,
            params: self.params,
        })
    }
}

struct ReuseInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for ReuseInstance<'_> {
    /// `NormalDGCDrawReuseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let frag_colors = params.frag_colors();
        let pipeline_count = frag_colors.len() as u32;

        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        // Shaders.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let mut frag_modules = Vec::new();
        for i in 0..pipeline_count {
            frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
        }

        // Push constants.
        let pc_stages = vk::ShaderStageFlags::VERTEX;
        let pc_size = std::mem::size_of::<Vec4>() as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;

        // Pipelines.
        let mut pipelines = Vec::new();
        for frag_module in &frag_modules {
            pipelines.push(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_module,
                    tesc: None,
                    tese: None,
                    geom: None,
                    frag: **frag_module,
                },
                &PipelineOptions {
                    extent: (fb_extent, fb_extent),
                    topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                    patch_control_points: 0,
                    dynamic_stride: false,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: params.use_execution_set,
                    construction: params.construction,
                    depth_test: false,
                    rendering: None,
                },
            )?);
        }

        // Indirect execution set.
        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.use_execution_set {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], pipeline_count)?;
            // Overwrite all pipelines in the set.
            for (i, pipeline) in pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager.update();
            ies_manager = Some(manager);
        }
        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // Vertex data and vertex buffers. A triangle strip from 0..1 will be offset in each quadrant with push constants.
        let vtx_positions: Vec<Vec4> = vec![
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let (vtx_buffer, _) = make_address_buffer(context, &vtx_positions, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Offsets for push constants. This will determine the quadrant order: which quadrant gets which color.
        // Proceed one row at a time from top to bottom, and in each row from left to right.
        let offsets: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ];

        // Indirect commands layout.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        if params.use_execution_set {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_execution_set_token(
                offset,
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
                stage_flags,
            );
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC buffer.
        let vertex_count = vtx_positions.len() as u32;
        let draw_cmd = vk::DrawIndirectCommand {
            vertex_count,
            instance_count: 1,
            first_vertex: 0,
            first_instance: 0,
        };
        let sequence_count = if params.use_execution_set {
            pipeline_count
        } else {
            pipeline_count + 1
        };

        // As explained upstream, we have 4 different cases:
        // - If not using IES: 2 normal draws and 2 DGC draws, in the order given, each using 2 of the 4 PC offsets.
        // - If using IES: 3 DGC draws and 1 normal draw, in the order given.
        let dgc_first = params.order == Order::DgcNormal;
        let first_dgc_pc_index = match (params.use_execution_set, dgc_first) {
            (true, true) => 0,
            (true, false) => 1,
            (false, true) => 0,
            (false, false) => 2,
        };
        let first_normal_pc_index = match (params.use_execution_set, dgc_first) {
            (true, true) => 3,
            (true, false) => 0,
            (false, true) => 2,
            (false, false) => 0,
        };
        let normal_draw_count = if params.use_execution_set { 1u32 } else { 2 };

        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..sequence_count {
            if params.use_execution_set {
                dgc_data.push(i); // Pipeline index.
            }
            let pc_index = (first_dgc_pc_index + i) as usize;
            push_back_element(&mut dgc_data, &offsets[pc_index]); // Push constants.
            push_back_element(&mut dgc_data, &draw_cmd); // Draw command.
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
        let preprocess_pipeline = if params.use_execution_set {
            vk::Pipeline::null()
        } else {
            *pipelines[0]
        };
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_handle,
            cmds_layout.get(),
            sequence_count,
            0,
            preprocess_pipeline,
            0,
        )?;

        // Submit commands.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        begin_command_buffer(device, cmd_buffer)?;

        let clear_color: Vec4 = [0.0, 0.0, 0.0, 1.0]; // Different from other colors due to the red value.
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

        let normal_draws = |device: &Device| {
            for i in 0..normal_draw_count {
                let offset = offsets[(first_normal_pc_index + i) as usize];
                let bytes: Vec<u8> = offset.iter().flat_map(|value| value.to_ne_bytes()).collect();
                unsafe {
                    device.cmd_push_constants(cmd_buffer, *pipeline_layout, pc_stages, 0, &bytes);
                    device.cmd_draw(cmd_buffer, vertex_count, 1, 0, 0);
                }
            }
        };

        unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vtx_buffer.get()], &[0]);
            // Initial shader state. Note we bind the last pipeline to make things more interesting.
            device.cmd_bind_pipeline(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                **pipelines.last().expect("at least one pipeline"),
            );
        }

        if !dgc_first {
            normal_draws(device);
        }

        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                ies_handle,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                0,
                preprocess_pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }

        if dgc_first {
            if params.use_execution_set {
                // We bind the first pipeline to make things more interesting.
                unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]) };
            }
            normal_draws(device);
        }

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

        let reference: Vec<Vec4> = if params.use_execution_set {
            // Pixel order must match the order of the push constant offsets.
            let mut reference = vec![[0.0f32; 4]; 4];
            let mut itr = 0usize;
            if !dgc_first {
                reference[itr] = *frag_colors.last().expect("colors");
                itr += 1;
            }
            for color in &frag_colors {
                reference[itr] = *color;
                itr += 1;
            }
            if dgc_first {
                reference[itr] = frag_colors[0];
            }
            reference
        } else {
            vec![frag_colors[0]; 4]
        };

        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `reuse_dgc_for_normal_*` cases that do not need shader objects, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_reuse_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction, suffix) in [
        (Construction::Monolithic, "monolithic"),
        (Construction::FastLinked, "fast_lib"),
        (Construction::LinkTimeOptimized, "optimized_lib"),
    ] {
        for (order, order_suffix) in [
            (Order::NormalDgc, "_order_normal_dgc"),
            (Order::DgcNormal, "_order_dgc_normal"),
        ] {
            for use_execution_set in [false, true] {
                let name = format!(
                    "reuse_dgc_for_normal_{suffix}{order_suffix}{}",
                    if use_execution_set { "_execution_set" } else { "" }
                );
                cases.push((
                    format!("ext.graphics.misc.{name}"),
                    Box::new(ReuseCase {
                        name,
                        params: Params {
                            construction,
                            order,
                            use_execution_set,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}
