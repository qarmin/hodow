// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderSmokeTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `monolithic`, `optimized_lib` and `fast_lib` constructions are ported (the library ones through the ambient construction type
// `create_draw_pipeline` reads); the `shared_frag_library` cases (which only the non-monolithic types register) are in `smoke_shared_frag_tests.rs`; the `shared_frag_shader` ones (`shader_objects`) are in the same file (shader objects bound inside dynamic rendering). The shaders
// are manifest GLSL with the values upstream formats in written out.
//
// Draws triangles, a gradient (optionally with a primitive shading rate), partially used mesh shader outputs and depth only
// geometry from mesh and task shaders, and checks the images against what the shaders were written to produce.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_smoke::{
    SMOKE_DEPTH_ONLY_POINTS, SMOKE_DEPTH_ONLY_POINTS_POSITION_COMPONENTS, SMOKE_DEPTH_ONLY_TRIANGLES,
    SMOKE_DEPTH_ONLY_TRIANGLES_POSITION_COMPONENTS, SMOKE_GRADIENT, SMOKE_GRADIENT_FS2X1, SMOKE_GRADIENT_FS2X2,
    SMOKE_MESH_ONLY, SMOKE_MESH_TASK, SMOKE_PARTIAL_USAGE, SMOKE_PARTIAL_USAGE_NO_COMPACTION, SMOKE_TASK_ONLY,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
use crate::vk::pipeline_construction::PipelineConstructionType;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, default_rasterization_state, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::mesh_shader::smoke_shared_frag_tests::{self as shared_frag, SharedFragLibraryParams};
use crate::vkt::tests::mesh_shader::util::{
    FragmentSize, check_task_mesh_shader_support_ext, get_shading_rate_size, mesh_shader_features,
};
use crate::vkt::tests::pipeline::pipeline_util::{make_color_depth_render_pass, read_depth_attachment};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

pub(super) const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

pub(super) fn color_bytes(color: [f32; 4]) -> [u8; 4] {
    color.map(|c| (c * 255.0 + 0.5).floor() as u8)
}

/// The state every mesh shading pipeline here shares: no vertex input, depth bias off, a viewport over the whole target.
pub(super) fn mesh_pipeline_state(width: u32, height: u32) -> DrawPipelineState {
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
    state.rasterization = default_rasterization_state();
    state.rasterization.depth_bias_enable = vk::FALSE;
    state
}

fn create_image_2d<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    extent: vk::Extent3D,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Triangle cases: `MeshOnlyTriangleCase`, `MeshTaskTriangleCase` and `TaskOnlyTriangleCase` share `MeshTriangleRenderer`.
// ---------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum TriangleKind {
    MeshOnly,
    MeshOnlyRasterizationDisabled,
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
        check_task_mesh_shader_support_ext(
            context,
            self.kind == TriangleKind::MeshTask || self.kind == TriangleKind::TaskOnly,
            true,
        )
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            TriangleKind::MeshOnly | TriangleKind::MeshOnlyRasterizationDisabled => SMOKE_MESH_ONLY.programs,
            TriangleKind::MeshTask => SMOKE_MESH_TASK.programs,
            TriangleKind::TaskOnly => SMOKE_TASK_ONLY.programs,
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
                rasterization_disabled: false,
            },
            TriangleKind::MeshOnlyRasterizationDisabled => MeshTriangleRendererParams {
                vertex_coords: big_triangle,
                vertex_indices: vec![0, 1, 2],
                task_count: 1,
                expected_color: CLEAR_COLOR,
                rasterization_disabled: true,
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
                rasterization_disabled: false,
            },
            // Note the clear colour is expected.
            TriangleKind::TaskOnly => MeshTriangleRendererParams {
                vertex_coords: big_triangle,
                vertex_indices: vec![0, 1, 2],
                task_count: 1,
                expected_color: CLEAR_COLOR,
                rasterization_disabled: false,
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
    rasterization_disabled: bool,
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
        let frag_module = if !params.rasterization_disabled {
            Some(create_shader_module(device, binaries.get("frag")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;

        // Graphics pipeline.
        let mut stages = Vec::new();
        if let Some(task) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
        if let Some(frag) = &frag_module {
            stages.push((vk::ShaderStageFlags::FRAGMENT, **frag));
        }
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
            device.cmd_draw_mesh_tasks_ext(cmd, params.task_count, 1, 1);
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

// ---------------------------------------------------------------------------------------------------------------------------------
// Fullscreen gradient
// ---------------------------------------------------------------------------------------------------------------------------------

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
        check_task_mesh_shader_support_ext(context, false, true)?;

        if self.fragment_size.is_some()
            && mesh_shader_features(context).primitive_fragment_shading_rate_mesh_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Primitive fragment shading rate not supported in mesh shaders".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.fragment_size {
            None => SMOKE_GRADIENT.programs,
            Some(FragmentSize::Size2x2) => SMOKE_GRADIENT_FS2X2.programs,
            Some(FragmentSize::Size2x1) => SMOKE_GRADIENT_FS2X1.programs,
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
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
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
        let diagonal_edge = (size + size) / 2 - 1;

        for y in 0..size / block_height {
            for x in 0..size / block_width {
                let mut block_fail = false;
                let mut candidates: Vec<[u8; 4]> = Vec::with_capacity((rate_size.width * rate_size.height) as usize);

                let corner_y = y * block_height;
                let corner_x = x * block_width;
                let corner_color = pixel(corner_x, corner_y);
                let mut edge_block = false;

                for block_y in 0..block_height {
                    for block_x in 0..block_width {
                        let abs_y = corner_y + block_y;
                        let abs_x = corner_x + block_x;
                        let res_color = pixel(abs_x, abs_y);

                        candidates.push(reference(abs_x, abs_y));

                        if abs_y + abs_x == diagonal_edge {
                            // Block uniformity is not guaranteed if the VRS block spans across multiple primitives.
                            edge_block = block_height > 1 || block_width > 1;
                        }

                        if corner_color != res_color && !edge_block {
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

// ---------------------------------------------------------------------------------------------------------------------------------
// Partial usage
// ---------------------------------------------------------------------------------------------------------------------------------

const PARTIAL_WIDTH: u32 = 16;
const PARTIAL_HEIGHT: u32 = 16;
const PARTIAL_LOCAL_INVOCATIONS: u32 = 64;
const PARTIAL_NUM_WORK_GROUPS: u32 = 2;
const PARTIAL_TOTAL_PRIMITIVES: u32 = PARTIAL_NUM_WORK_GROUPS * PARTIAL_LOCAL_INVOCATIONS;

/// `PartialUsageCase::IndexAndColor`
#[repr(C)]
#[derive(Clone, Copy)]
struct IndexAndColor {
    index: u32,
    color: f32,
}

/// `PartialUsageCase::PushConstants`
#[repr(C)]
#[derive(Clone, Copy)]
struct PartialUsagePushConstants {
    total_triangles: u32,
    depth: f32,
    red: f32,
}

impl PartialUsagePushConstants {
    fn bytes(&self) -> Vec<u8> {
        let mut bytes = Vec::with_capacity(12);
        bytes.extend_from_slice(&self.total_triangles.to_ne_bytes());
        bytes.extend_from_slice(&self.depth.to_ne_bytes());
        bytes.extend_from_slice(&self.red.to_ne_bytes());
        bytes
    }
}

/// Smoke test that emits one triangle per pixel plus one more global background triangle, but doesn't use every triangle. It only
/// draws half the front triangles. It gets information from a mix of vertex buffers, per primitive buffers and push constants.
struct PartialUsageCase {
    name: String,
    compact_vertices: bool,
}

impl TestCase for PartialUsageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, true, true)
    }

    fn programs(&self) -> BinaryCollection {
        if self.compact_vertices {
            SMOKE_PARTIAL_USAGE.programs
        } else {
            SMOKE_PARTIAL_USAGE_NO_COMPACTION.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PartialUsageInstance { context })
    }
}

struct PartialUsageInstance<'a> {
    context: &'a Context<'a>,
}

fn pixel_to_fb_coords(pixel_id: u32, total_pixels: u32) -> f32 {
    (pixel_id as f32 + 0.5) / total_pixels as f32 * 2.0 - 1.0
}

impl TestInstance for PartialUsageInstance<'_> {
    /// `PartialUsageInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER;
        let buffer_desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let buffer_desc_stages = vk::ShaderStageFlags::MESH_EXT;
        let pc_size = std::mem::size_of::<PartialUsagePushConstants>() as u32;
        let pc_stages = buffer_desc_stages;
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        }];
        let fb_extent = vk::Extent3D {
            width: PARTIAL_WIDTH,
            height: PARTIAL_HEIGHT,
            depth: 1,
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let ds_format = vk::Format::D16_UNORM;
        let vertices_per_triangle = 3u32;
        let pixel_count = fb_extent.width * fb_extent.height * fb_extent.depth;
        let vertex_count = pixel_count * vertices_per_triangle;
        let fg_red = 0.0f32;
        let bg_red = 1.0f32;
        let bg_blue = 1.0f32;

        // Quarter of the pixel width and height in framebuffer coordinates.
        let pixel_width4 = 2.0 / (fb_extent.width as f32 * 4.0);
        let pixel_height4 = 2.0 / (fb_extent.height as f32 * 4.0);

        // Offsets for each triangle vertex from the pixel center.
        //    +-------------------+
        //    |         2         |
        //    |         x         |
        //    |        x x        |
        //    |       x   x       |
        //    |      x  x  x      |
        //    |     x       x     |
        //    |    xxxxxxxxxxx    |
        //    |   0           1   |
        //    +-------------------+
        let offsets: [[f32; 2]; 3] = [
            [-pixel_width4, pixel_height4],
            [pixel_width4, pixel_height4],
            [0.0, -pixel_height4],
        ];

        // Two draw calls: triangles on the front and a triangle that sets the background color, so two vertex buffers and two
        // primitive data buffers.
        let mut triangle_per_pixel: Vec<[f32; 2]> = Vec::with_capacity(vertex_count as usize);

        // Fill front vertex buffer.
        for y in 0..PARTIAL_HEIGHT {
            for x in 0..PARTIAL_WIDTH {
                for offset in &offsets {
                    let x_coord = pixel_to_fb_coords(x, PARTIAL_WIDTH) + offset[0];
                    let y_coord = pixel_to_fb_coords(y, PARTIAL_HEIGHT) + offset[1];
                    triangle_per_pixel.push([x_coord, y_coord]);
                }
            }
        }
        let vertex_buffer_front = create_host_buffer(context, &triangle_per_pixel, buffer_usage)?;
        let vertex_buffer_front_size = std::mem::size_of_val(triangle_per_pixel.as_slice()) as vk::DeviceSize;

        // For the front triangles we will select some pixels randomly.
        let mut selected_pixels = std::collections::BTreeSet::new();
        let mut indices_and_colors: Vec<IndexAndColor> = Vec::new();
        let mut rnd = Random::new(1_646_058_327);
        let max_id = pixel_count as i32 - 1;
        let f_total_triangles = PARTIAL_TOTAL_PRIMITIVES as f32;

        while selected_pixels.len() < PARTIAL_TOTAL_PRIMITIVES as usize {
            let pixel_id = rnd.get_int(0, max_id) as u32;
            if selected_pixels.insert(pixel_id) {
                let color_val = selected_pixels.len() as f32 / f_total_triangles;
                indices_and_colors.push(IndexAndColor {
                    index: pixel_id,
                    color: color_val,
                });
            }
        }

        let prim_data_buffer_front = create_host_buffer(context, &indices_and_colors, buffer_usage)?;
        let prim_data_buffer_front_size = std::mem::size_of_val(indices_and_colors.as_slice()) as vk::DeviceSize;

        // Generate reference image based on the previous data.
        let bg_color = color_bytes([bg_red, 0.0, bg_blue, 1.0]);
        let mut reference: Vec<[u8; 4]> = vec![bg_color; pixel_count as usize];
        for index_and_color in &indices_and_colors {
            reference[index_and_color.index as usize] = color_bytes([fg_red, 0.0, index_and_color.color, 1.0]);
        }

        // Background buffers. These will only contain one triangle.
        let background_triangle: [[f32; 2]; 3] = [[-1.0, -1.0], [-1.0, 3.0], [3.0, -1.0]];
        let background_triangle_data = IndexAndColor {
            index: 0,
            color: bg_blue,
        };

        let vertex_buffer_back = create_host_buffer(context, &background_triangle, buffer_usage)?;
        let vertex_buffer_back_size = std::mem::size_of_val(&background_triangle) as vk::DeviceSize;
        let prim_data_buffer_back = create_host_buffer(context, &[background_triangle_data], buffer_usage)?;
        let prim_data_buffer_back_size = std::mem::size_of::<IndexAndColor>() as vk::DeviceSize;

        // Descriptor pool and descriptor sets.
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(buffer_desc_type, 4).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            2,
        )?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(buffer_desc_type, buffer_desc_stages)
            .add_single_binding(buffer_desc_type, buffer_desc_stages)
            .build(device)?;
        let set_front = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;
        let set_back = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        // Update descriptor sets.
        let vertex_front_info = make_descriptor_buffer_info(vertex_buffer_front.get(), 0, vertex_buffer_front_size);
        let prim_front_info = make_descriptor_buffer_info(prim_data_buffer_front.get(), 0, prim_data_buffer_front_size);
        let vertex_back_info = make_descriptor_buffer_info(vertex_buffer_back.get(), 0, vertex_buffer_back_size);
        let prim_back_info = make_descriptor_buffer_info(prim_data_buffer_back.get(), 0, prim_data_buffer_back_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                set_front.get(),
                Location::binding(0),
                buffer_desc_type,
                &vertex_front_info,
            )
            .write_single(
                set_front.get(),
                Location::binding(1),
                buffer_desc_type,
                &prim_front_info,
            )
            .write_single(
                set_back.get(),
                Location::binding(0),
                buffer_desc_type,
                &vertex_back_info,
            )
            .write_single(set_back.get(), Location::binding(1), buffer_desc_type, &prim_back_info)
            .update(device);

        // Pipeline layout.
        let set_layouts = [set_layout.get()];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Shader modules.
        let binaries = context.get_binary_collection();
        let task_shader = create_shader_module(device, binaries.get("task")?)?;
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        // Render pass.
        let render_pass = make_color_depth_render_pass(
            device,
            color_format,
            ds_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;

        // Color and depth/stencil buffers.
        let color_attachment = create_image_2d(
            context,
            color_format,
            fb_extent,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let ds_attachment = create_image_2d(
            context,
            ds_format,
            fb_extent,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        )?;

        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let ds_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

        let color_view = make_image_view(
            device,
            color_attachment.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_srr,
        )?;
        let ds_view = make_image_view(device, ds_attachment.get(), vk::ImageViewType::_2D, ds_format, ds_srr)?;

        // Create verification buffer.
        let verification_buffer_size = (4 * fb_extent.width * fb_extent.height * fb_extent.depth) as vk::DeviceSize;
        let verification_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Framebuffer.
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *ds_view],
            fb_extent.width,
            fb_extent.height,
            1,
        )?;

        // Pipeline.
        let mut state = mesh_pipeline_state(fb_extent.width, fb_extent.height);
        let stencil_op_state = vk::StencilOpState::default();
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::TASK_EXT, *task_shader),
                (vk::ShaderStageFlags::MESH_EXT, *mesh_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Draw the triangles in the front, then the triangle in the back.
        let pc_front = PartialUsagePushConstants {
            total_triangles: PARTIAL_TOTAL_PRIMITIVES,
            depth: 0.0,
            red: fg_red,
        };
        let pc_back = PartialUsagePushConstants {
            total_triangles: 1,
            depth: 0.5,
            red: bg_red,
        };

        begin_command_buffer(device, cmd)?;
        let clear_values = [
            clear_value_color(CLEAR_COLOR),
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(fb_extent.width, fb_extent.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());

            // Front triangles.
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[set_front.get()],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, &pc_front.bytes());
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);

            // Back triangles.
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[set_back.get()],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, &pc_back.bytes());
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);

            device.cmd_end_render_pass(cmd);
        }

        // Copy color attachment to verification buffer.
        let color_to_transfer_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_attachment.get(),
            color_srr,
        );
        let transfer_to_host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        let copy_region = make_buffer_image_copy(fb_extent, color_srl);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_to_transfer_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_attachment.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                verification_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[transfer_to_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify color attachment. The red and blue channels get the 0.005 threshold (1/255 < 0.005 < 2/255), which is one step.
        let verification_alloc = verification_buffer.get_allocation();
        invalidate_alloc(device, verification_alloc)?;
        let result = unsafe {
            std::slice::from_raw_parts(
                verification_alloc.get_host_ptr().cast_const(),
                verification_buffer_size as usize,
            )
        };

        for (pixel, expected) in result.chunks_exact(4).zip(&reference) {
            let matches = (pixel[0] as i32 - expected[0] as i32).abs() <= 1
                && pixel[1] == expected[1]
                && (pixel[2] as i32 - expected[2] as i32).abs() <= 1
                && pixel[3] == expected[3];
            if !matches {
                log::info!("Result {pixel:?} does not match reference {expected:?}");
                return Err(TestError::Fail(
                    "Result does not match reference -- check log for details".to_string(),
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Depth only
// ---------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum DepthGeometry {
    Points,
    Triangles,
}

#[derive(Clone, Copy)]
struct DepthOnlyParams {
    geometry: DepthGeometry,
    step_by_step_position: bool,
}

const DEPTH_ONLY_EXTENT: (u32, u32) = (64, 32);
const DEPTH_ONLY_XY_OFFSET: [f32; 2] = [1000.0, 2000.0];

struct DepthOnlyCase {
    name: String,
    params: DepthOnlyParams,
}

impl TestCase for DepthOnlyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `depthOnlySupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.geometry, self.params.step_by_step_position) {
            (DepthGeometry::Points, false) => SMOKE_DEPTH_ONLY_POINTS.programs,
            (DepthGeometry::Points, true) => SMOKE_DEPTH_ONLY_POINTS_POSITION_COMPONENTS.programs,
            (DepthGeometry::Triangles, false) => SMOKE_DEPTH_ONLY_TRIANGLES.programs,
            (DepthGeometry::Triangles, true) => SMOKE_DEPTH_ONLY_TRIANGLES_POSITION_COMPONENTS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthOnlyInstance {
            context,
            params: self.params,
        })
    }
}

struct DepthOnlyInstance<'a> {
    context: &'a Context<'a>,
    params: DepthOnlyParams,
}

impl TestInstance for DepthOnlyInstance<'_> {
    /// `depthOnlyRun`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let xy_offset = DEPTH_ONLY_XY_OFFSET;
        let (width, height) = DEPTH_ONLY_EXTENT;
        let api_extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };
        let depth_format = vk::Format::D16_UNORM;
        let primitive_vertices: u32 = if params.geometry == DepthGeometry::Points { 1 } else { 3 };
        let pixel_count = width * height;
        let vertex_count = pixel_count * primitive_vertices;

        // Depth buffer.
        let depth_image = create_image_2d(
            context,
            depth_format,
            api_extent,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            depth_format,
            depth_srr,
        )?;

        let pixel_width = 2.0 / width as f32;
        let pixel_height = 2.0 / height as f32;
        let hor_margin = pixel_width * 0.25;
        let vert_margin = pixel_height * 0.25;

        let mut positions: Vec<[f32; 4]> = Vec::with_capacity(vertex_count as usize);
        let mut pixel_depths: Vec<f32> = Vec::with_capacity(pixel_count as usize);

        let position_margins: [[f32; 2]; 3] = [
            [0.0, -vert_margin],
            [-hor_margin, vert_margin],
            [hor_margin, vert_margin],
        ];

        // The construction type of the monolithic pipelines is zero.
        let mut rnd = Random::new(1_738_233_594);
        for _ in 0..pixel_count {
            pixel_depths.push(rnd.get_float());
        }

        for y in 0..height {
            for x in 0..width {
                let pixel_id = y * width + x;
                let depth = pixel_depths[pixel_id as usize];

                let x_center = (x as f32 + 0.5) / width as f32 * 2.0 - 1.0;
                let y_center = (y as f32 + 0.5) / height as f32 * 2.0 - 1.0;

                for margin in position_margins.iter().take(primitive_vertices as usize) {
                    positions.push([
                        x_center + margin[0] + xy_offset[0],
                        y_center + margin[1] + xy_offset[1],
                        depth,
                        1.0,
                    ]);
                }
            }
        }

        // "Vertex" buffer.
        let vert_buffer = create_host_buffer(context, &positions, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Descriptor set stuff.
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::MESH_EXT;

        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        let buffer_desc_info = make_descriptor_buffer_info(vert_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(descriptor_set.get(), Location::binding(0), desc_type, &buffer_desc_info)
            .update(device);

        // Pipeline.
        let binaries = context.get_binary_collection();
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;

        let render_pass = make_color_depth_render_pass(
            device,
            vk::Format::UNDEFINED,
            depth_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*depth_view], width, height, 1)?;

        // Stencil not used so we provide some default values.
        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();

        let mut state = mesh_pipeline_state(width, height);
        state.color_attachment_count = 0;
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(0.0)
            .build();
        // The fragment shader is omitted on purpose.
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[(vk::ShaderStageFlags::MESH_EXT, *mesh_shader)],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, width, height))
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
            device.cmd_draw_mesh_tasks_ext(cmd, api_extent.height, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_depth_attachment(
            context,
            depth_image.get(),
            depth_format,
            (width, height),
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let result_access = result.get_const_access();

        // The threshold is 1/65535 < this value < 2/65535, over the reference quantized to 16 bits.
        let threshold = 0.000025f32;
        for y in 0..height {
            for x in 0..width {
                let depth = pixel_depths[(y * width + x) as usize];
                let reference = (depth * 65535.0 + 0.5).floor() / 65535.0;
                let value = result_access.get_pix_depth(x, y, 0);
                if (value - reference).abs() > threshold {
                    log::info!("Depth mismatch at ({x}, {y}): expected {reference}, found {value}");
                    return Err(TestError::Fail(
                        "Unexpected results found in depth buffer; check log for details --".to_string(),
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The cases `createMeshShaderSmokeTestsEXT` registers for every construction type, in a group of the type's name.
fn smoke_construction_group(name: &str, construction: PipelineConstructionType) -> TestCaseGroup {
    let mut construction_group = TestCaseGroup::new(name);

    if !construction.is_shader_object() {
        add_non_eso_cases(&mut construction_group);
    }

    if construction != PipelineConstructionType::Monolithic {
        let is_eso_case = construction.is_shader_object();
        for use_primitive_id in [false, true] {
            for mesh_first in [false, true] {
                for extra_input in [false, true] {
                    let test_name = format!(
                        "{}{}{}{}",
                        if is_eso_case {
                            "shared_frag_shader"
                        } else {
                            "shared_frag_library"
                        },
                        if use_primitive_id { "_primid" } else { "" },
                        if mesh_first { "_mesh_first" } else { "" },
                        if extra_input { "_extra_input" } else { "" }
                    );
                    construction_group.add_child(Box::new(SharedFragLibraryCase {
                        name: test_name,
                        params: SharedFragLibraryParams {
                            construction,
                            primitive_id: use_primitive_id,
                            mesh_first,
                            extra_input,
                        },
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }

    for geometry in [DepthGeometry::Points, DepthGeometry::Triangles] {
        for step_by_step_position in [false, true] {
            let name = format!(
                "depth_only{}{}",
                if geometry == DepthGeometry::Points {
                    "_points"
                } else {
                    "_triangles"
                },
                if step_by_step_position {
                    "_position_components"
                } else {
                    ""
                }
            );
            construction_group.add_child(Box::new(DepthOnlyCase {
                name,
                params: DepthOnlyParams {
                    geometry,
                    step_by_step_position,
                },
            }) as Box<dyn TestCase>);
        }
    }

    construction_group
}

/// The cases of `createMeshShaderSmokeTestsEXT` that no shader object group registers.
fn add_non_eso_cases(construction_group: &mut TestCaseGroup) {
    construction_group.add_child(Box::new(MeshTriangleCase {
        name: "mesh_shader_triangle".to_string(),
        kind: TriangleKind::MeshOnly,
    }) as Box<dyn TestCase>);
    construction_group.add_child(Box::new(MeshTriangleCase {
        name: "mesh_shader_triangle_rasterization_disabled".to_string(),
        kind: TriangleKind::MeshOnlyRasterizationDisabled,
    }) as Box<dyn TestCase>);
    construction_group.add_child(Box::new(MeshTriangleCase {
        name: "mesh_task_shader_triangle".to_string(),
        kind: TriangleKind::MeshTask,
    }) as Box<dyn TestCase>);
    construction_group.add_child(Box::new(MeshTriangleCase {
        name: "task_only_shader_triangle".to_string(),
        kind: TriangleKind::TaskOnly,
    }) as Box<dyn TestCase>);

    for compaction in [true, false] {
        let name_suffix = if compaction { "" } else { "_without_compaction" };
        construction_group.add_child(Box::new(PartialUsageCase {
            name: format!("partial_usage{name_suffix}"),
            compact_vertices: compaction,
        }) as Box<dyn TestCase>);
    }

    construction_group.add_child(Box::new(GradientCase {
        name: "fullscreen_gradient".to_string(),
        fragment_size: None,
    }) as Box<dyn TestCase>);
    construction_group.add_child(Box::new(GradientCase {
        name: "fullscreen_gradient_fs2x2".to_string(),
        fragment_size: Some(FragmentSize::Size2x2),
    }) as Box<dyn TestCase>);
    construction_group.add_child(Box::new(GradientCase {
        name: "fullscreen_gradient_fs2x1".to_string(),
        fragment_size: Some(FragmentSize::Size2x1),
    }) as Box<dyn TestCase>);
}

/// `SharedFragLibraryCase`: the library and shader object construction types.
struct SharedFragLibraryCase {
    name: String,
    params: SharedFragLibraryParams,
}

impl TestCase for SharedFragLibraryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        shared_frag::check_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        shared_frag::programs(&self.params)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(shared_frag::SharedFragLibraryInstance {
            context,
            params: self.params,
        })
    }
}

/// `createMeshShaderSmokeTestsEXT`
pub fn create_mesh_shader_smoke_tests_ext() -> TestCaseGroup {
    use crate::vk::pipeline_construction::with_construction_type;

    let mut smoke_tests = TestCaseGroup::new("smoke");
    smoke_tests.add_child(smoke_construction_group(
        "monolithic",
        PipelineConstructionType::Monolithic,
    ));
    for (name, construction) in [
        ("optimized_lib", PipelineConstructionType::LinkTimeOptimizedLibrary),
        ("fast_lib", PipelineConstructionType::FastLinkedLibrary),
        ("shader_objects", PipelineConstructionType::ShaderObjectUnlinkedSpirv),
    ] {
        smoke_tests.add_child(with_construction_type(
            smoke_construction_group(name, construction),
            construction,
        ));
    }
    smoke_tests
}
