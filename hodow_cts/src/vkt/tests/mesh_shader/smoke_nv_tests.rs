// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderSmokeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/mesh_shader_nv_smoke.toml: the GLSL of
// `initPrograms` written out, and for the two gradient cases with a fragment size upstream's precomputed assembly with the image
// size and the shading rate substituted. As upstream, those cases check only for VK_NV_mesh_shader, not for the primitive shading rate.
//
// The VK_NV_mesh_shader form of smoke_tests.rs: triangles from mesh and task shaders, and a fullscreen gradient (optionally with a
// primitive shading rate), checked against what the shaders were written to produce.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::NvMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_nv_smoke::{
    NV_SMOKE_GRADIENT, NV_SMOKE_GRADIENT_FS2X1, NV_SMOKE_GRADIENT_FS2X2, NV_SMOKE_MESH_ONLY, NV_SMOKE_MESH_TASK,
    NV_SMOKE_TASK_ONLY,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::mesh_shader::smoke_tests::{CLEAR_COLOR, color_bytes, mesh_pipeline_state};
use crate::vkt::tests::mesh_shader::util::{FragmentSize, check_task_mesh_shader_support_nv, get_shading_rate_size};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TriangleKind {
    MeshOnly,
    MeshTask,
    /// Not actually task only: the task shader will not emit mesh shader work groups.
    TaskOnly,
}

struct MeshTriangleCase {
    name: String,
    kind: TriangleKind,
}

impl TestCase for MeshTriangleCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MeshOnlyTriangleCase::checkSupport` and its two siblings
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_nv(context, self.kind != TriangleKind::MeshOnly, true)
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            TriangleKind::MeshOnly => NV_SMOKE_MESH_ONLY.programs,
            TriangleKind::MeshTask => NV_SMOKE_MESH_TASK.programs,
            TriangleKind::TaskOnly => NV_SMOKE_TASK_ONLY.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let big_triangle = vec![[-1.0, -1.0, 0.0, 1.0], [-1.0, 3.0, 0.0, 1.0], [3.0, -1.0, 0.0, 1.0]];
        let params = match self.kind {
            TriangleKind::MeshOnly => MeshTriangleRendererParams {
                vertex_coords: big_triangle,
                vertex_indices: vec![0, 1, 2],
                task_count: 1,
                expected_color: [0.0, 0.0, 1.0, 1.0],
            },
            TriangleKind::MeshTask => MeshTriangleRendererParams {
                vertex_coords: vec![
                    [-1.0, -1.0, 0.0, 1.0],
                    [-1.0, 1.0, 0.0, 1.0],
                    [1.0, -1.0, 0.0, 1.0],
                    [1.0, 1.0, 0.0, 1.0],
                ],
                vertex_indices: vec![2, 0, 1, 1, 3, 2],
                task_count: 2,
                expected_color: [0.0, 0.0, 1.0, 1.0],
            },
            // Note the clear colour is expected.
            TriangleKind::TaskOnly => MeshTriangleRendererParams {
                vertex_coords: big_triangle,
                vertex_indices: vec![0, 1, 2],
                task_count: 1,
                expected_color: CLEAR_COLOR,
            },
        };
        Box::new(MeshTriangleRenderer { context, params })
    }
}

struct MeshTriangleRendererParams {
    vertex_coords: Vec<[f32; 4]>,
    vertex_indices: Vec<u32>,
    task_count: u32,
    expected_color: [f32; 4],
}

struct MeshTriangleRenderer<'a> {
    context: &'a Context<'a>,
    params: MeshTriangleRendererParams,
}

impl TestInstance for MeshTriangleRenderer<'_> {
    /// `MeshTriangleRenderer::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();

        let vertex_buffer_stages = vk::ShaderStageFlags::MESH_EXT;
        let vertex_buffer_type = vk::DescriptorType::UNIFORM_BUFFER;
        let index_buffer_stages = vk::ShaderStageFlags::MESH_EXT;
        let index_buffer_type = vk::DescriptorType::STORAGE_BUFFER;

        // Vertex buffer and index buffer.
        let vertex_buffer = create_host_buffer(context, &params.vertex_coords, vk::BufferUsageFlags::UNIFORM_BUFFER)?;
        let vertex_buffer_size = std::mem::size_of_val(params.vertex_coords.as_slice()) as vk::DeviceSize;
        let index_buffer = create_host_buffer(context, &params.vertex_indices, vk::BufferUsageFlags::STORAGE_BUFFER)?;
        let index_buffer_size = std::mem::size_of_val(params.vertex_indices.as_slice()) as vk::DeviceSize;

        // Color buffer.
        let color_buffer_format = vk::Format::R8G8B8A8_UNORM;
        let color_buffer_extent = (8u32, 8u32);
        let color_buffer = ImageWithBuffer::new(
            context,
            color_buffer_extent.0,
            color_buffer_extent.1,
            color_buffer_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        let render_pass = make_render_pass(device, color_buffer_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer.view],
            color_buffer_extent.0,
            color_buffer_extent.1,
            1,
        )?;

        // Set layout, descriptor pool and set.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vertex_buffer_type, vertex_buffer_stages)
            .add_single_binding(index_buffer_type, index_buffer_stages)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vertex_buffer_type, 1)
            .add_type(index_buffer_type, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        let vertex_buffer_desc_info = make_descriptor_buffer_info(vertex_buffer.get(), 0, vertex_buffer_size);
        let index_buffer_desc_info = make_descriptor_buffer_info(index_buffer.get(), 0, index_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vertex_buffer_type,
                &vertex_buffer_desc_info,
            )
            .write_single(
                descriptor_set.get(),
                Location::binding(1),
                index_buffer_type,
                &index_buffer_desc_info,
            )
            .update(device);

        let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let task_module = if binaries.contains("task") {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Graphics pipeline.
        let mut stages = Vec::new();
        if let Some(task) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        let state = mesh_pipeline_state(color_buffer_extent.0, color_buffer_extent.1);
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Draw triangle.
        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color(CLEAR_COLOR)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(color_buffer_extent.0, color_buffer_extent.1))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw_mesh_tasks_nv(cmd, params.task_count, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            color_buffer_extent.0,
            color_buffer_extent.1,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // The colour can be represented exactly, so the threshold is zero.
        let result = color_buffer.read_bytes(device)?;
        let expected = color_bytes(params.expected_color);
        if !result.chunks_exact(4).all(|pixel| pixel == expected) {
            return Ok(TestStatus::fail("Failed; check log for details"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct GradientCase {
    name: String,
    fragment_size: Option<FragmentSize>,
}

impl TestCase for GradientCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkMeshSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_nv(context, false, true)
    }

    fn programs(&self) -> BinaryCollection {
        match self.fragment_size {
            None => NV_SMOKE_GRADIENT.programs,
            Some(FragmentSize::Size2x2) => NV_SMOKE_GRADIENT_FS2X2.programs,
            Some(FragmentSize::Size2x1) => NV_SMOKE_GRADIENT_FS2X1.programs,
            Some(FragmentSize::Size1x1) => {
                unreachable!("1x1 is not used as the primitive rate in tests with fragment size")
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GradientInstance {
            context,
            fragment_size: self.fragment_size,
        })
    }
}

struct GradientInstance<'a> {
    context: &'a Context<'a>,
    fragment_size: Option<FragmentSize>,
}

impl TestInstance for GradientInstance<'_> {
    /// `testFullscreenGradient`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let use_fragment_size = self.fragment_size.is_some();
        let default_fragment_size = FragmentSize::Size1x1;
        let rate_size = get_shading_rate_size(self.fragment_size.unwrap_or(default_fragment_size));

        // Big enough for a detailed gradient, small enough to get unique colors.
        let color_buffer_format = vk::Format::R8G8B8A8_UNORM;
        let size = 256u32;
        let color_buffer = ImageWithBuffer::new(
            context,
            size,
            size,
            color_buffer_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        let render_pass = make_render_pass(device, color_buffer_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], size, size, 1)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state = mesh_pipeline_state(size, size);
        if use_fragment_size {
            // 1x1 will not be used as the primitive rate in tests with fragment size.
            state.fragment_shading_rate_state = Some(
                vk::PipelineFragmentShadingRateStateCreateInfoKHR::builder()
                    .fragment_size(get_shading_rate_size(FragmentSize::Size1x1))
                    .combiner_ops([
                        vk::FragmentShadingRateCombinerOpKHR::REPLACE,
                        vk::FragmentShadingRateCombinerOpKHR::KEEP,
                    ])
                    .build(),
            );
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::MESH_EXT, *mesh_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Draw triangles.
        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color(CLEAR_COLOR)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(size, size))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw_mesh_tasks_nv(cmd, 1, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            size,
            size,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let out_pixels = color_buffer.read_bytes(device)?;
        let pixel = |x: u32, y: u32| -> [u8; 4] {
            let offset = ((y * size + x) * 4) as usize;
            [
                out_pixels[offset],
                out_pixels[offset + 1],
                out_pixels[offset + 2],
                out_pixels[offset + 3],
            ]
        };
        // The reference image: (0, x, y, 255).
        let reference = |x: u32, y: u32| -> [u8; 4] { [0, x as u8, y as u8, 255] };

        // Each block needs to have the same color and be equal to one of the pixel colors of that block in the reference image.
        let block_width = rate_size.width;
        let block_height = rate_size.height;

        let mut global_fail = false;

        for y in 0..size / block_height {
            for x in 0..size / block_width {
                let mut block_fail = false;
                let mut candidates: Vec<[u8; 4]> = Vec::with_capacity((rate_size.width * rate_size.height) as usize);

                let corner_y = y * block_height;
                let corner_x = x * block_width;
                let corner_color = pixel(corner_x, corner_y);

                for block_y in 0..block_height {
                    for block_x in 0..block_width {
                        let abs_y = corner_y + block_y;
                        let abs_x = corner_x + block_x;
                        let res_color = pixel(abs_x, abs_y);

                        candidates.push(reference(abs_x, abs_y));

                        if corner_color != res_color {
                            log::info!(
                                "Block not uniform: [{corner_x}, {corner_y}]={corner_color:?} vs [{abs_x}, {abs_y}]={res_color:?}"
                            );
                            block_fail = true;
                        }
                    }
                }

                if !candidates.contains(&corner_color) {
                    log::info!("Block color does not match any reference color at [{corner_x}, {corner_y}]");
                    block_fail = true;
                }

                if block_fail {
                    global_fail = true;
                }
            }
        }

        if global_fail {
            return Err(TestError::Fail(
                "Color mismatch; check log for more details".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderSmokeTests`
pub fn create_mesh_shader_smoke_tests() -> TestCaseGroup {
    let mut smoke_tests = TestCaseGroup::new("smoke");

    smoke_tests.add_child(Box::new(MeshTriangleCase {
        name: "mesh_shader_triangle".to_string(),
        kind: TriangleKind::MeshOnly,
    }) as Box<dyn TestCase>);
    smoke_tests.add_child(Box::new(MeshTriangleCase {
        name: "mesh_task_shader_triangle".to_string(),
        kind: TriangleKind::MeshTask,
    }) as Box<dyn TestCase>);
    smoke_tests.add_child(Box::new(MeshTriangleCase {
        name: "task_only_shader_triangle".to_string(),
        kind: TriangleKind::TaskOnly,
    }) as Box<dyn TestCase>);

    smoke_tests.add_child(Box::new(GradientCase {
        name: "fullscreen_gradient".to_string(),
        fragment_size: None,
    }) as Box<dyn TestCase>);
    smoke_tests.add_child(Box::new(GradientCase {
        name: "fullscreen_gradient_fs2x2".to_string(),
        fragment_size: Some(FragmentSize::Size2x2),
    }) as Box<dyn TestCase>);
    smoke_tests.add_child(Box::new(GradientCase {
        name: "fullscreen_gradient_fs2x1".to_string(),
        fragment_size: Some(FragmentSize::Size2x1),
    }) as Box<dyn TestCase>);

    smoke_tests
}
