// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderProvokingVertexTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The mesh shaders are two manifest GLSL files (lines and triangles) in place of
// the ones upstream formats at run time.
//
// Draws one line or triangle with per-vertex flat colours from a mesh shader into a 1x1 image layer per provoking vertex mode,
// and checks each layer holds the colour of the first or last vertex as its mode says.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::mesh_shader_provoking_vertex::{PROVOKING_VERTEX_LINES, PROVOKING_VERTEX_TRIANGLES};
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
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, clear_value_color, create_draw_pipeline, default_rasterization_state,
};
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_ext;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Geometry {
    Lines,
    Triangles,
}

fn line_colors() -> [[u32; 4]; 2] {
    [[1, 1, 0, 1], [1, 0, 1, 1]]
}

fn triangle_colors() -> [[u32; 4]; 3] {
    [[1, 1, 0, 1], [0, 1, 1, 1], [1, 0, 1, 1]]
}

fn case_name_for_modes(modes: &[vk::ProvokingVertexModeEXT]) -> String {
    modes
        .iter()
        .map(|&mode| match mode {
            vk::ProvokingVertexModeEXT::FIRST_VERTEX => "first",
            _ => "last",
        })
        .collect::<Vec<_>>()
        .join("_")
}

#[derive(Clone)]
struct TestParams {
    /// In the same render pass. In practice 1 or 2 elements.
    provoking_vertices: Vec<vk::ProvokingVertexModeEXT>,
    geometry_type: Geometry,
}

struct ProvokingVertexCase {
    name: String,
    params: TestParams,
}

impl TestCase for ProvokingVertexCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ProvokingVertexCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)?;

        context.require_device_functionality("VK_EXT_provoking_vertex")?;

        if self.params.provoking_vertices.len() > 1 {
            let mut pv_properties = vk::PhysicalDeviceProvokingVertexPropertiesEXT::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut pv_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if pv_properties.provoking_vertex_mode_per_pipeline == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Switching provoking vertex modes in the same render pass not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.geometry_type {
            Geometry::Lines => PROVOKING_VERTEX_LINES.programs,
            Geometry::Triangles => PROVOKING_VERTEX_TRIANGLES.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ProvokingVertexInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct ProvokingVertexInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ProvokingVertexInstance<'_> {
    /// `ProvokingVertexInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let color_layers = self.params.provoking_vertices.len() as u32;
        let color_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let pixel_size = 4u32;
        let view_type = if color_layers > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];

        // Color attachment.
        let color_buffer_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(color_extent)
            .mip_levels(1)
            .array_layers(color_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_buffer = ImageWithMemory::new(device, alloc, color_buffer_info, MemoryRequirement::ANY)?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, color_layers);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, color_layers);
        let color_view = make_image_view(device, color_buffer.get(), view_type, color_format, color_srr)?;

        // Verification buffer.
        let verification_buffer_size =
            (pixel_size * color_extent.width * color_extent.height * color_layers) as vk::DeviceSize;
        let verification_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Push constant range.
        let pc_size = std::mem::size_of::<i32>() as u32;
        let pc_stages = vk::ShaderStageFlags::MESH_EXT;
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Modules.
        let binaries = self.context.get_binary_collection();
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Render pass and framebuffer.
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view],
            color_extent.width,
            color_extent.height,
            color_layers,
        )?;

        // Pipelines with different provoking vertex modes.
        let mut pipelines = Vec::new();
        for &pv_mode in &self.params.provoking_vertices {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(color_extent.width, color_extent.height);
            state.rasterization = default_rasterization_state();
            state.rasterization.cull_mode = vk::CullModeFlags::BACK;
            state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
            state.rasterization.depth_bias_enable = vk::FALSE;
            state.provoking_vertex_mode = Some(pv_mode);
            pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::MESH_EXT, *mesh_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?);
        }

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, color_extent.width, color_extent.height),
            clear_value_color(clear_color),
        );
        for (layer, pipeline) in pipelines.iter().enumerate() {
            let layer = layer as i32;
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
                device.cmd_push_constants(cmd, pipeline_layout.get(), pc_stages, 0, &layer.to_ne_bytes());
                device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            }
        }
        end_render_pass(device, cmd);
        {
            // Copy data to verification buffer.
            let pre_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                color_srr,
            );
            let copy_region = make_buffer_image_copy(color_extent, color_srl);
            let post_transfer_barrier =
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_transfer_barrier],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    color_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    verification_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[post_transfer_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify colors.
        let verification_alloc = verification_buffer.get_allocation();
        invalidate_alloc(device, verification_alloc)?;
        let result = unsafe {
            std::slice::from_raw_parts(
                verification_alloc.get_host_ptr().cast_const(),
                verification_buffer_size as usize,
            )
        };

        let colors: Vec<[u32; 4]> = if self.params.geometry_type == Geometry::Lines {
            line_colors().to_vec()
        } else {
            triangle_colors().to_vec()
        };

        let mut fail = false;
        for z in 0..color_layers as usize {
            let expected_int_color = if self.params.provoking_vertices[z] == vk::ProvokingVertexModeEXT::FIRST_VERTEX {
                colors[0]
            } else {
                colors[colors.len() - 1]
            };
            // The values are 0 and 1, so the unorm bytes are 0 and 255.
            let expected_color = expected_int_color.map(|c| if c != 0 { 255u8 } else { 0u8 });

            for y in 0..color_extent.height as usize {
                for x in 0..color_extent.width as usize {
                    let offset = ((z * color_extent.height as usize + y) * color_extent.width as usize + x)
                        * pixel_size as usize;
                    let result_color = &result[offset..offset + 4];
                    if result_color != expected_color {
                        fail = true;
                        log::info!(
                            "Unexpected color found at layer {z} coordinates ({x}, {y}): expected {expected_color:?} found {result_color:?}"
                        );
                    }
                }
            }
        }

        if fail {
            return Ok(TestStatus::fail("Failed -- check log for details"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderProvokingVertexTestsEXT`
pub fn create_mesh_shader_provoking_vertex_tests_ext() -> TestCaseGroup {
    let test_mode_cases: [Vec<vk::ProvokingVertexModeEXT>; 4] = [
        vec![vk::ProvokingVertexModeEXT::FIRST_VERTEX],
        vec![vk::ProvokingVertexModeEXT::LAST_VERTEX],
        vec![
            vk::ProvokingVertexModeEXT::FIRST_VERTEX,
            vk::ProvokingVertexModeEXT::LAST_VERTEX,
        ],
        vec![
            vk::ProvokingVertexModeEXT::LAST_VERTEX,
            vk::ProvokingVertexModeEXT::FIRST_VERTEX,
        ],
    ];

    let mut provoking_vertex_group = TestCaseGroup::new("provoking_vertex");

    for (geometry, geometry_name) in [(Geometry::Lines, "lines"), (Geometry::Triangles, "triangles")] {
        let mut geometry_group = TestCaseGroup::new(geometry_name);

        for test_modes in &test_mode_cases {
            let params = TestParams {
                provoking_vertices: test_modes.clone(),
                geometry_type: geometry,
            };
            geometry_group.add_child(Box::new(ProvokingVertexCase {
                name: case_name_for_modes(test_modes),
                params,
            }) as Box<dyn TestCase>);
        }

        provoking_vertex_group.add_child(geometry_group);
    }

    provoking_vertex_group
}
