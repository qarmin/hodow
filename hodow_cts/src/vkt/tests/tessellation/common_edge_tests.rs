// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationCommonEdgeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These tests correspond to dEQP-GLES31.functional.tessellation.common_edge.*

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_common_edge::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::tessellation::util::{SpacingMode, TessPrimitiveType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseType {
    /// Order patch vertices such that when two patches share a vertex, it's at the same index for both.
    Basic,
    /// Vertex indices don't match like for `Basic`, but other measures are taken, using the 'precise' qualifier.
    Precise,
}

#[derive(Clone, Copy)]
struct CaseDefinition {
    primitive_type: TessPrimitiveType,
    #[allow(dead_code)]
    spacing_mode: SpacingMode,
    case_type: CaseType,
}

/// Check that a certain rectangle in the image contains no black pixels. Returns true if an image successfully
/// passess the verification.
fn verify_result(image: &[u8], width: u32, height: u32) -> bool {
    let start_x = (0.15f32 * width as f32) as u32;
    let end_x = (0.85f32 * width as f32) as u32;
    let start_y = (0.15f32 * height as f32) as u32;
    let end_y = (0.85f32 * height as f32) as u32;

    for y in start_y..end_y {
        for x in start_x..end_x {
            let offset = ((y * width + x) * 4) as usize;
            if image[offset] == 0 && image[offset + 1] == 0 && image[offset + 2] == 0 {
                // Failure: there seem to be cracks in the rendered result
                return false;
            }
        }
    }
    true
}

struct CommonEdgeCase {
    name: String,
    case_def: CaseDefinition,
}

impl TestCase for CommonEdgeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.name))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CommonEdgeInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct CommonEdgeInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDefinition,
}

fn as_bytes<T: Copy>(values: &[T]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

impl TestInstance for CommonEdgeInstance<'_> {
    /// Generic test code used by all test cases.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let case_def = self.case_def;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        debug_assert!(
            case_def.primitive_type == TessPrimitiveType::Triangles
                || case_def.primitive_type == TessPrimitiveType::Quads
        );

        // Prepare test data
        let mut grid_pos_comps: Vec<f32> = Vec::new();
        let mut grid_tess_params: Vec<f32> = Vec::new();
        let mut grid_indices: Vec<u16> = Vec::new();
        {
            let grid_width = 4i32;
            let grid_height = 4i32;
            let num_vertices = (grid_width + 1) * (grid_height + 1);

            for i in 0..grid_height + 1 {
                for j in 0..grid_width + 1 {
                    grid_pos_comps.push(-1.0 + 2.0 * (j as f32 + 0.5) / (grid_width + 1) as f32);
                    grid_pos_comps.push(-1.0 + 2.0 * (i as f32 + 0.5) / (grid_height + 1) as f32);
                    grid_tess_params.push((i * (grid_width + 1) + j) as f32 / (num_vertices - 1) as f32);
                }
            }

            // Generate patch vertex indices.
            // \note If Basic, the vertices are ordered such that when multiple triangles/quads share a vertex, it's at the same index for everyone.
            if case_def.primitive_type == TessPrimitiveType::Triangles {
                for i in 0..grid_height {
                    for j in 0..grid_width {
                        let corners = [
                            (i * (grid_width + 1) + j) as u16,
                            (i * (grid_width + 1) + j + 1) as u16,
                            ((i + 1) * (grid_width + 1) + j) as u16,
                            ((i + 1) * (grid_width + 1) + j + 1) as u16,
                        ];

                        let second_triangle_vertex_index_offset =
                            if case_def.case_type == CaseType::Basic { 0 } else { 1 };

                        for k in 0..3 {
                            grid_indices.push(corners[((k + i + (2 - j % 3)) % 3) as usize]);
                        }
                        for k in 0..3 {
                            grid_indices.push(
                                corners[((k + 2 + i + (2 - j % 3) + second_triangle_vertex_index_offset) % 3 + 1)
                                    as usize],
                            );
                        }
                    }
                }
            } else {
                for i in 0..grid_height {
                    for j in 0..grid_width {
                        for m in 0..2 {
                            for n in 0..2 {
                                grid_indices.push(((i + (i + m) % 2) * (grid_width + 1) + j + (j + n) % 2) as u16);
                            }
                        }

                        if case_def.case_type == CaseType::Precise && (i + j) % 2 == 0 {
                            let len = grid_indices.len();
                            grid_indices[len - 4..].reverse();
                        }
                    }
                }
            }
        }

        // Vertex input buffer: we put both attributes and indices in here.
        let vertex_positions_offset = 0usize;
        let vertex_tess_params_offset = std::mem::size_of_val(grid_pos_comps.as_slice());
        let vertex_indices_offset = vertex_tess_params_offset + std::mem::size_of_val(grid_tess_params.as_slice());
        let mut vertex_data = Vec::new();
        vertex_data.extend_from_slice(as_bytes(&grid_pos_comps));
        vertex_data.extend_from_slice(as_bytes(&grid_tess_params));
        vertex_data.extend_from_slice(as_bytes(&grid_indices));
        let vertex_buffer = create_host_buffer(
            context,
            &vertex_data,
            vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::INDEX_BUFFER,
        )?;

        // Color attachment, and the buffer its image is copied to for verification
        const RENDER_SIZE: u32 = 256;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_buffer = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Pipeline
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let in_patch_size = if case_def.primitive_type == TessPrimitiveType::Triangles {
            3
        } else {
            4
        };
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(device, binaries.get("tese")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.patch_control_points = Some(in_patch_size);
        state.bindings = vec![
            vk::VertexInputBindingDescription {
                binding: 0,
                stride: 8,
                input_rate: vk::VertexInputRate::VERTEX,
            },
            vk::VertexInputBindingDescription {
                binding: 1,
                stride: 4,
                input_rate: vk::VertexInputRate::VERTEX,
            },
        ];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 1,
                format: vk::Format::R32_SFLOAT,
                offset: 0,
            },
        ];
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Draw commands
        begin_command_buffer(device, *cmd_buffer)?;

        // Change color attachment image layout
        {
            let color_attachment_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_attachment_layout_barrier],
                );
            }
        }

        // Begin render pass
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(
                *cmd_buffer,
                0,
                &[vertex_buffer.get(), vertex_buffer.get()],
                &[
                    vertex_positions_offset as vk::DeviceSize,
                    vertex_tess_params_offset as vk::DeviceSize,
                ],
            );
            device.cmd_bind_index_buffer(
                *cmd_buffer,
                vertex_buffer.get(),
                vertex_indices_offset as vk::DeviceSize,
                vk::IndexType::UINT16,
            );
            device.cmd_draw_indexed(*cmd_buffer, grid_indices.len() as u32, 1, 0, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }

        // Copy render result to a host-visible buffer
        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify the result.
        let ok = verify_result(color_buffer.read_bytes(device)?, RENDER_SIZE, RENDER_SIZE);
        Ok(if ok {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Failure")
        })
    }
}

/// `getCaseName`
fn get_case_name(primitive_type: TessPrimitiveType, spacing_mode: SpacingMode, case_type: CaseType) -> String {
    format!(
        "{}_{}{}",
        primitive_type.shader_name(),
        spacing_mode.shader_name(),
        if case_type == CaseType::Precise { "_precise" } else { "" }
    )
}

/// `createCommonEdgeTests`
pub fn create_common_edge_tests() -> TestCaseGroup {
    // Draw multiple adjacent shapes and check that no cracks appear between them
    let mut group = TestCaseGroup::new("common_edge");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for case_type in [CaseType::Basic, CaseType::Precise] {
            for spacing_mode in SpacingMode::ALL {
                let case_def = CaseDefinition {
                    primitive_type,
                    spacing_mode,
                    case_type,
                };
                group.add_child(Box::new(CommonEdgeCase {
                    name: get_case_name(primitive_type, spacing_mode, case_type),
                    case_def,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}
