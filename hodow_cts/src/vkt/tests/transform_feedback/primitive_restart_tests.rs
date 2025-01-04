// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackPrimitiveRestartTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtExtendedDynamicState2ExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands,
    ExtTransformFeedbackExtensionDeviceCommands,
};

use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `kRestartMarker` - the 16-bit primitive restart index.
const RESTART_MARKER: u16 = u16::MAX;

const VEC4_SIZE: usize = 16;

#[derive(Clone, Copy)]
struct Params {
    dynamic_primitive_restart: bool,
    dynamic_primitive_topology: bool,
}

struct PrimitiveRestartCase {
    name: String,
    params: Params,
    programs: BinaryCollection,
}

impl TestCase for PrimitiveRestartCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        if self.params.dynamic_primitive_restart {
            context.require_device_functionality("VK_EXT_extended_dynamic_state2")?;
        }

        if self.params.dynamic_primitive_topology {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PrimitiveRestartInstance {
            context,
            params: self.params,
        })
    }
}

struct PrimitiveRestartInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for PrimitiveRestartInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let vkd = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let qf_index = self.context.get_universal_queue_family_index();

        let fb_extent = (1u32, 1u32);
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let xfb_stage = vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT;

        // Index buffer.
        let indices: Vec<u16> = vec![
            0,
            1,
            RESTART_MARKER, // No triangle formed when using primitive restarts.
            9,
            RESTART_MARKER,
            RESTART_MARKER, // Same here.
            2000,
            3000,
            4000, // Only valid triangle with primitive restart.
        ];
        let index_buffer_size = (indices.len() * std::mem::size_of::<u16>()) as vk::DeviceSize;
        let index_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(index_buffer_size, vk::BufferUsageFlags::INDEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = index_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    index_buffer_size as usize,
                )
            };
            flush_alloc(vkd, alloc)?;
        }

        // Render pass and framebuffer.
        let has_pipeline_b = !(params.dynamic_primitive_restart && params.dynamic_primitive_topology);

        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(bind_point)
            .build();

        let mut subpass_dependencies: Vec<vk::SubpassDependency> = Vec::new();
        if has_pipeline_b {
            subpass_dependencies.push(vk::SubpassDependency {
                src_subpass: 0,
                dst_subpass: 0,
                src_stage_mask: xfb_stage,
                dst_stage_mask: xfb_stage,
                src_access_mask: vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
                dst_access_mask: vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
                dependency_flags: vk::DependencyFlags::empty(),
            });
        }

        let subpasses = [subpass];
        let render_pass_create_info = vk::RenderPassCreateInfo::builder()
            .subpasses(&subpasses)
            .dependencies(&subpass_dependencies);
        let render_pass = Unique::new(
            vkd,
            unsafe { vkd.create_render_pass(&render_pass_create_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(vkd, *render_pass, &[], fb_extent.0, fb_extent.1, 1)?;

        // Pipelines.
        let vert_module = create_shader_module(vkd, self.context.get_binary_collection().get("vert")?)?;
        let pipeline_layout = make_pipeline_layout(vkd, &[])?;

        // Pipeline A will draw with primitive restart enabled (triangle strip).
        // Pipeline B will draw with primitive restart disabled (triangle list).
        // However, if both states are dynamic, only pipeline A will be used.
        let mut topology_a = vk::PrimitiveTopology::TRIANGLE_STRIP;
        let mut topology_b = vk::PrimitiveTopology::TRIANGLE_LIST;
        if params.dynamic_primitive_topology {
            topology_a = vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY;
            topology_b = vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY;
        }

        let mut restart_a = true;
        let mut restart_b = false;
        if params.dynamic_primitive_restart {
            std::mem::swap(&mut restart_a, &mut restart_b);
        }

        let mut dynamic_states: Vec<vk::DynamicState> = Vec::new();
        if params.dynamic_primitive_restart {
            dynamic_states.push(vk::DynamicState::PRIMITIVE_RESTART_ENABLE);
        }
        if params.dynamic_primitive_topology {
            dynamic_states.push(vk::DynamicState::PRIMITIVE_TOPOLOGY);
        }

        let entry = c"main";
        let stages = [vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(*vert_module)
            .name(entry.to_bytes_with_nul())
            .build()];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: fb_extent.0 as f32,
            height: fb_extent.1 as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, fb_extent.0, fb_extent.1)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let make_pipeline = |topology: vk::PrimitiveTopology, restart: bool| {
            let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(topology)
                .primitive_restart_enable(restart);
            let info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .vertex_input_state(&vertex_input)
                .input_assembly_state(&input_assembly)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization)
                .multisample_state(&multisample)
                .dynamic_state(&dynamic_state)
                .layout(*pipeline_layout)
                .render_pass(*render_pass)
                .subpass(0);
            let pipelines = unsafe { vkd.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateGraphicsPipelines")?;
            Ok::<_, TestError>(Unique::new(vkd, pipelines.0[0]))
        };

        let pipeline_a = make_pipeline(topology_a, restart_a)?;
        let pipeline_b = if has_pipeline_b {
            Some(make_pipeline(topology_b, restart_b)?)
        } else {
            None
        };

        #[rustfmt::skip]
        let expected_results: Vec<[f32; 4]> = vec![
            // First draw: only the last strip forms a triangle.
            [2000.0; 4],
            [3000.0; 4],
            [4000.0; 4],

            // Second draw: everything is drawn, using -1.0 for some vertex positions (see shader), using triangle lists.
            [0.0; 4],
            [1.0; 4],
            [-1.0; 4],
            [9.0; 4],
            [-1.0; 4],
            [-1.0; 4],
            [2000.0; 4],
            [3000.0; 4],
            [4000.0; 4],

            // Third draw: same as the first one.
            [2000.0; 4],
            [3000.0; 4],
            [4000.0; 4],
        ];

        // Transform feedback buffer. Include some padding in case primitives are not restarted properly
        let xfb_buffer_size = expected_results.len() * VEC4_SIZE + 12 * VEC4_SIZE;
        let xfb_buffer_offset: vk::DeviceSize = 0;
        let xfb_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(
                xfb_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = xfb_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, xfb_buffer_size) };
            flush_alloc(vkd, alloc)?;
        }

        // Transform feedback counter buffer.
        let xfb_counter_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(
                std::mem::size_of::<u32>() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFORM_FEEDBACK_COUNTER_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = xfb_counter_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, std::mem::size_of::<u32>()) };
            flush_alloc(vkd, alloc)?;
        }

        let cmd_pool = make_command_pool(vkd, qf_index)?;
        let cmd_buffer = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let index_count = indices.len() as u32;
        let xfb_buffers = [xfb_buffer.get()];
        let xfb_counter_buffers = [xfb_counter_buffer.get()];

        let xfb_resume_barrier = || {
            let resume_barrier = make_memory_barrier(
                vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
                vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
            );
            unsafe {
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    xfb_stage,
                    xfb_stage,
                    vk::DependencyFlags::empty(),
                    &[resume_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        };

        begin_command_buffer(vkd, cmd_buffer)?;
        begin_render_pass(
            vkd,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            scissors[0],
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );

        unsafe {
            vkd.cmd_bind_transform_feedback_buffers_ext(
                cmd_buffer,
                0,
                &xfb_buffers,
                &[xfb_buffer_offset],
                &[vk::WHOLE_SIZE],
            );
            vkd.cmd_bind_index_buffer(cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT16);

            // First draw.
            vkd.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline_a);
            // XFB begins after binding the pipeline due to VUID-vkCmdBindPipeline-None-02323.
            vkd.cmd_begin_transform_feedback_ext(cmd_buffer, 0, &xfb_counter_buffers, &[xfb_buffer_offset]);
            if params.dynamic_primitive_topology {
                vkd.cmd_set_primitive_topology_ext(cmd_buffer, vk::PrimitiveTopology::TRIANGLE_STRIP);
            }
            if params.dynamic_primitive_restart {
                vkd.cmd_set_primitive_restart_enable_ext(cmd_buffer, true);
            }
            vkd.cmd_draw_indexed(cmd_buffer, index_count, 1, 0, 0, 0);

            // Second draw.
            if let Some(pipeline_b) = pipeline_b.as_ref() {
                // We need to stop and resume due to VUID-vkCmdBindPipeline-None-02323.
                vkd.cmd_end_transform_feedback_ext(cmd_buffer, 0, &xfb_counter_buffers, &[xfb_buffer_offset]);
                vkd.cmd_bind_pipeline(cmd_buffer, bind_point, **pipeline_b);
                xfb_resume_barrier();
                vkd.cmd_begin_transform_feedback_ext(cmd_buffer, 0, &xfb_counter_buffers, &[xfb_buffer_offset]);
            }
            if params.dynamic_primitive_topology {
                vkd.cmd_set_primitive_topology_ext(cmd_buffer, vk::PrimitiveTopology::TRIANGLE_LIST);
            }
            if params.dynamic_primitive_restart {
                vkd.cmd_set_primitive_restart_enable_ext(cmd_buffer, false);
            }
            vkd.cmd_draw_indexed(cmd_buffer, index_count, 1, 0, 0, 0);

            // Third draw.
            if has_pipeline_b {
                vkd.cmd_end_transform_feedback_ext(cmd_buffer, 0, &xfb_counter_buffers, &[xfb_buffer_offset]);
                vkd.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline_a); // Back to pipeline A if needed.
                xfb_resume_barrier();
                vkd.cmd_begin_transform_feedback_ext(cmd_buffer, 0, &xfb_counter_buffers, &[xfb_buffer_offset]);
            }
            if params.dynamic_primitive_topology {
                vkd.cmd_set_primitive_topology_ext(cmd_buffer, vk::PrimitiveTopology::TRIANGLE_STRIP);
            }
            if params.dynamic_primitive_restart {
                vkd.cmd_set_primitive_restart_enable_ext(cmd_buffer, true);
            }
            vkd.cmd_draw_indexed(cmd_buffer, index_count, 1, 0, 0, 0);

            vkd.cmd_end_transform_feedback_ext(cmd_buffer, 0, &xfb_counter_buffers, &[xfb_buffer_offset]);
        }

        end_render_pass(vkd, cmd_buffer);
        {
            let write_access =
                vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT | vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT;
            let read_access = vk::AccessFlags::HOST_READ;
            let barrier = make_memory_barrier(write_access, read_access);
            unsafe {
                vkd.cmd_pipeline_barrier(
                    cmd_buffer,
                    xfb_stage,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vkd, cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, cmd_buffer)?;

        invalidate_alloc(vkd, xfb_counter_buffer.get_allocation())?;
        invalidate_alloc(vkd, xfb_buffer.get_allocation())?;

        let expected_positions = expected_results.len();
        let expected_counter = expected_positions * VEC4_SIZE;

        let mut counter = 0u32;
        unsafe {
            std::ptr::copy_nonoverlapping(
                xfb_counter_buffer.get_allocation().get_host_ptr().cast_const(),
                (&mut counter as *mut u32).cast::<u8>(),
                4,
            )
        };

        // Degenerate triangles may not be written out, so a lower counter could be valid. This will
        // be checked below, but check the upper bound here so that we can copy data safely.
        if counter as usize > expected_counter {
            return Err(TestError::Fail(format!(
                "Unexpected value in XFB counter buffer: got {counter} and expected {expected_counter}"
            )));
        }

        let mut actual_results: Vec<[f32; 4]> = vec![[0.0; 4]; expected_results.len()];
        unsafe {
            std::ptr::copy_nonoverlapping(
                xfb_buffer.get_allocation().get_host_ptr().cast_const(),
                actual_results.as_mut_ptr().cast::<u8>(),
                expected_results.len() * VEC4_SIZE,
            )
        };

        let mut fail = false;

        // Should be a whole number of triangles in the result.
        debug_assert!(expected_positions.is_multiple_of(3));

        let mut degen_skip = 0usize;
        for i in 0..expected_positions / 3 {
            let reference = &expected_results[3 * i..3 * i + 3];
            let res = &actual_results[3 * (i - degen_skip)..3 * (i - degen_skip) + 3];

            if reference[0] != res[0] || reference[1] != res[1] || reference[2] != res[2] {
                // Check for degeneracy. If the triangle is degenerate then assume that it
                // was skipped in the output and skip it here.
                if reference[0] == reference[1] || reference[0] == reference[2] || reference[1] == reference[2] {
                    degen_skip += 1;
                    continue;
                }

                log::info!(
                    "Unexpected gl_Position value at index {i}: expected {:?} and got {:?}",
                    reference[0],
                    res[0]
                );
                fail = true;
            }
        }

        if counter as usize != expected_counter - degen_skip * 3 * VEC4_SIZE {
            return Err(TestError::Fail(format!(
                "Unexpected value in XFB counter buffer: got {counter} and expected {expected_counter}"
            )));
        }

        if fail {
            return Err(TestError::Fail(
                "Unexpected results in XFB buffer; check log for details --".to_string(),
            ));
        }

        if degen_skip != 0 {
            return Ok(TestStatus::new(
                TestResult::QualityWarning,
                "Some degenerate primitives were skipped in the output buffer",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `testNamePrefix`
fn test_name_prefix(dynamic: bool) -> &'static str {
    if dynamic { "dynamic_" } else { "static_" }
}

/// `createTransformFeedbackPrimitiveRestartTests`
pub fn create_transform_feedback_primitive_restart_tests() -> TestCaseGroup {
    use crate::generated::shaders::transform_feedback_primitive_restart as g;

    let mut main_group = TestCaseGroup::new("primitive_restart");

    for dynamic_primitive_restart in [false, true] {
        for dynamic_primitive_topology in [false, true] {
            let params = Params {
                dynamic_primitive_restart,
                dynamic_primitive_topology,
            };
            let test_name = format!(
                "{}primitive_restart_{}primitive_topology",
                test_name_prefix(dynamic_primitive_restart),
                test_name_prefix(dynamic_primitive_topology)
            );
            main_group.add_child(Box::new(PrimitiveRestartCase {
                name: test_name,
                params,
                programs: g::PRIMITIVE_RESTART_PROGRAMS.programs,
            }) as Box<dyn TestCase>);
        }
    }

    main_group
}
