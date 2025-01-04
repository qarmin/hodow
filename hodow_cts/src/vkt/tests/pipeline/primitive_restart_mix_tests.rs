// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineInputAssemblyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `input_assembly.primitive_restart.restart_mix`: one frame drawn in quadrants, some with
// indices and primitive restart enabled and one without indices (the restart must not apply there). Monolithic pipelines only.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtExtendedDynamicStateExtensionDeviceCommands;

use crate::generated::shaders::pipeline_primitive_restart_mix::RESTART_MIX;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::pipeline_util::Vertex4Rgba;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FB_SIZE: i32 = 32;
const RESTART_INDEX: u16 = u16::MAX;

/// `PrimitiveRestartMixParams`
#[derive(Clone, Copy)]
struct PrimitiveRestartMixParams {
    /// Draw using indices after the first draw without them; otherwise, skip those quadrants.
    extra_indexed_draws: bool,
    /// true == triangle list, false == triangle strip
    triangle_list: bool,
    dynamic_topology: bool,
    /// For the non-indexed draw, use a separate large vertex buffer.
    large_non_indexed_draw: bool,
}

struct PrimitiveRestartMixCase {
    name: String,
    params: PrimitiveRestartMixParams,
}

impl TestCase for PrimitiveRestartMixCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `PrimitiveRestartMixCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.dynamic_topology {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }
        if self.params.triangle_list {
            context.require_device_functionality("VK_EXT_primitive_topology_list_restart")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        RESTART_MIX.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PrimitiveRestartMixInstance {
            context,
            params: self.params,
        })
    }
}

struct PrimitiveRestartMixInstance<'a> {
    context: &'a Context<'a>,
    params: PrimitiveRestartMixParams,
}

fn normalize_coords(c: i32, len: i32) -> f32 {
    c as f32 / len as f32 * 2.0 - 1.0
}

struct Quadrant {
    offset_x: i32,
    offset_y: i32,
    width: i32,
    height: i32,
    /// Insert restart indices for this quadrant so no geometry is drawn.
    skip_geometry: bool,
    /// Draw this quadrant with/without indices.
    indexed_draw: bool,
}

impl TestInstance for PrimitiveRestartMixInstance<'_> {
    /// The idea is drawing once with indices and primitive restart enabled and then drawing again without indices and without disabling
    /// primitive restart. For this, a framebuffer is drawn over quadrant by quadrant in each step.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = self.params;
        let extent = FB_SIZE as u32;

        let quadrant_extent = FB_SIZE / 2;
        let vertices_per_pixel: u32 = if params.triangle_list { 6 } else { 4 };
        let total_vertices = vertices_per_pixel * extent * extent;
        let vertices_per_quadrant = vertices_per_pixel * (quadrant_extent * quadrant_extent) as u32;

        let color_buffer = ImageWithBuffer::new(
            context,
            extent,
            extent,
            FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        let quadrant_colors: [[f32; 4]; 4] = [
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
        ];

        let mut vertices: Vec<Vertex4Rgba> = Vec::new();
        let mut extra_vertices: Vec<Vertex4Rgba> = Vec::new();
        let mut indices: Vec<u16> = Vec::new();
        debug_assert!(total_vertices < u32::from(RESTART_INDEX)); // Or else we would run into the restart value.

        let quadrants = [
            Quadrant {
                offset_x: 0,
                offset_y: 0,
                width: quadrant_extent,
                height: quadrant_extent,
                skip_geometry: false,
                indexed_draw: true,
            }, // Top left.
            Quadrant {
                offset_x: quadrant_extent,
                offset_y: quadrant_extent,
                width: quadrant_extent,
                height: quadrant_extent,
                skip_geometry: true,
                indexed_draw: true,
            }, // Bottom right.
            Quadrant {
                offset_x: quadrant_extent,
                offset_y: 0,
                width: quadrant_extent,
                height: quadrant_extent,
                skip_geometry: false,
                indexed_draw: false,
            }, // Top right.
            Quadrant {
                offset_x: 0,
                offset_y: quadrant_extent,
                width: quadrant_extent,
                height: quadrant_extent,
                skip_geometry: false,
                indexed_draw: true,
            }, // Bottom left.
        ];

        let mut vertex_count = 0u32;
        let vertex_count_with_appendix = u32::from(RESTART_INDEX) + 1;
        vertices.reserve(vertex_count_with_appendix as usize);
        indices.reserve(total_vertices as usize);

        for (quadrant, &color) in quadrants.iter().zip(&quadrant_colors) {
            for y in 0..quadrant.height {
                for x in 0..quadrant.width {
                    // Append the vertices for this pixel.
                    let (pix_x, pix_y) = (x + quadrant.offset_x, y + quadrant.offset_y);
                    let x_left = normalize_coords(pix_x, FB_SIZE);
                    let x_right = normalize_coords(pix_x + 1, FB_SIZE);
                    let y_top = normalize_coords(pix_y, FB_SIZE);
                    let y_bottom = normalize_coords(pix_y + 1, FB_SIZE);
                    let pixel_corners = [
                        [x_left, y_top, 0.0, 1.0],
                        [x_left, y_bottom, 0.0, 1.0],
                        [x_right, y_top, 0.0, 1.0],
                        [x_right, y_bottom, 0.0, 1.0],
                    ];
                    if params.triangle_list {
                        for corner in [0usize, 1, 2, 2, 1, 3] {
                            vertices.push(Vertex4Rgba {
                                position: pixel_corners[corner],
                                color,
                            });
                        }
                    } else {
                        for position in pixel_corners {
                            vertices.push(Vertex4Rgba { position, color });
                        }
                    }

                    // Append the vertex indices for this pixel.
                    for j in 0..vertices_per_pixel {
                        indices.push((vertex_count + j) as u16);
                    }

                    // Make sure indices for quadrants without geometry are set up in ways that restart the primitive.
                    if quadrant.skip_geometry {
                        let len = indices.len();
                        if params.triangle_list {
                            // Use the primitive restart index for both added triangles.
                            indices[len - 1] = RESTART_INDEX;
                            indices[len - 4] = RESTART_INDEX;
                        } else {
                            // Similar for the strip, but the indices of the last two vertices in the quad are overwritten.
                            indices[len - 1] = RESTART_INDEX;
                            indices[len - 2] = RESTART_INDEX;
                        }
                    }
                    vertex_count += vertices_per_pixel;
                }
            }

            // Maybe use an alternative large vertex buffer for quadrants that do not use indexed draws.
            if params.large_non_indexed_draw && !quadrant.indexed_draw {
                // This should only happen with one quadrant.
                debug_assert!(extra_vertices.is_empty() && params.triangle_list);

                // A large list of out-of-screen vertices, and after that a couple of triangles that cover the whole quadrant, to make sure
                // they are used correctly.
                extra_vertices.reserve(vertex_count_with_appendix as usize * 2);
                while extra_vertices.len() <= vertex_count_with_appendix as usize {
                    extra_vertices.push(Vertex4Rgba {
                        position: [100.0, 100.0, 0.0, 1.0],
                        color,
                    });
                    extra_vertices.push(Vertex4Rgba {
                        position: [100.0, 110.0, 0.0, 1.0],
                        color,
                    });
                    extra_vertices.push(Vertex4Rgba {
                        position: [110.0, 100.0, 0.0, 1.0],
                        color,
                    });
                }

                // Final meaningful triangles.
                let x_left = normalize_coords(quadrant.offset_x, FB_SIZE);
                let x_right = normalize_coords(quadrant.offset_x + quadrant.width, FB_SIZE);
                let y_top = normalize_coords(quadrant.offset_y, FB_SIZE);
                let y_bottom = normalize_coords(quadrant.offset_y + quadrant.height, FB_SIZE);
                for position in [
                    [x_left, y_top],
                    [x_left, y_bottom],
                    [x_right, y_top],
                    [x_right, y_top],
                    [x_left, y_bottom],
                    [x_right, y_bottom],
                ] {
                    extra_vertices.push(Vertex4Rgba {
                        position: [position[0], position[1], 0.0, 1.0],
                        color,
                    });
                }
            }
        }

        // Make sure the restart index is valid and contains coordinates that will trigger a problem by creating valid triangles that provide
        // coverage to one or more pixels in the framebuffer. As the restart indices will be used for the bottom right quadrant, the middle of
        // the right edge of the framebuffer is the invalid coordinate. If it's used, it should provide some coverage.
        while (vertices.len() as u32) < vertex_count_with_appendix {
            vertices.push(Vertex4Rgba {
                position: [1.0, 0.0, 0.0, 1.0],
                color: quadrant_colors[1],
            });
        }

        let vtx_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let idx_buffer = create_host_buffer(context, &indices, vk::BufferUsageFlags::INDEX_BUFFER)?;
        let extra_vtx_buffer = if extra_vertices.is_empty() {
            None
        } else {
            Some(create_host_buffer(
                context,
                &extra_vertices,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?)
        };

        let good_topology = if params.triangle_list {
            vk::PrimitiveTopology::TRIANGLE_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_STRIP
        };
        let bad_topology = if params.triangle_list {
            vk::PrimitiveTopology::TRIANGLE_STRIP
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let static_topology = if params.dynamic_topology {
            bad_topology
        } else {
            good_topology
        };

        let mut state = DrawPipelineState::new(static_topology).with_full_viewport(extent, extent);
        state.primitive_restart_enable = true;
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex4Rgba>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
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
        if params.dynamic_topology {
            state.dynamic_states.push(vk::DynamicState::PRIMITIVE_TOPOLOGY);
        }

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_color_render_pass(
            device,
            FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], extent, extent, 1)?;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let clear_values = [clear_value_color(clear_color)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(extent, extent))
            .clear_values(&clear_values);

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            if params.dynamic_topology {
                device.cmd_set_primitive_topology_ext(cmd, good_topology);
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vtx_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd, idx_buffer.get(), 0, vk::IndexType::UINT16);

            // Draw loop.
            let mut vertex_draw_offset = 0u32;
            let mut drew_without_indices = false;

            for quadrant in &quadrants {
                // If we've already drawn without indices and this quadrant would be drawn with them, but we do not want extra indexed
                // draws, skip the quadrant.
                if drew_without_indices && quadrant.indexed_draw && !params.extra_indexed_draws {
                    continue;
                }

                let mut break_loop = false; // Helper to break out of both loops.
                for y in 0..quadrant_extent {
                    for x in 0..quadrant_extent {
                        let first_vertex = (y * quadrant_extent + x) as u32 * vertices_per_pixel + vertex_draw_offset;

                        if quadrant.indexed_draw {
                            device.cmd_draw_indexed(cmd, vertices_per_pixel, 1, first_vertex, 0, 0);
                        } else {
                            drew_without_indices = true;

                            if params.large_non_indexed_draw {
                                // Single draw for the whole quadrant, as a large triangle list.
                                if x == 0 && y == 0 {
                                    let extra = extra_vtx_buffer
                                        .as_ref()
                                        .expect("a large non indexed draw has its own vertex buffer");
                                    device.cmd_bind_vertex_buffers(cmd, 0, &[extra.get()], &[0]);
                                    device.cmd_draw(cmd, extra_vertices.len() as u32, 1, 0, 0);
                                    device.cmd_bind_vertex_buffers(cmd, 0, &[vtx_buffer.get()], &[0]);

                                    break_loop = true;
                                    break;
                                }
                            } else {
                                device.cmd_draw(cmd, vertices_per_pixel, 1, first_vertex, 0);
                            }
                        }
                    }

                    if break_loop {
                        break;
                    }
                }

                vertex_draw_offset += vertices_per_quadrant;
            }

            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            extent,
            extent,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // The reference: the clear color, with the top left and top right quadrants, and the bottom left one when the extra draws exist.
        let to_bytes = |color: [f32; 4]| color.map(|channel| (channel * 255.0).round() as u8);
        let mut reference = vec![to_bytes(clear_color); (extent * extent) as usize];
        let mut fill = |offset_x: i32, offset_y: i32, color: [f32; 4]| {
            for y in offset_y..offset_y + quadrant_extent {
                for x in offset_x..offset_x + quadrant_extent {
                    reference[(y * FB_SIZE + x) as usize] = to_bytes(color);
                }
            }
        };
        fill(0, 0, quadrant_colors[0]);
        fill(quadrant_extent, 0, quadrant_colors[2]);
        if params.extra_indexed_draws {
            fill(0, quadrant_extent, quadrant_colors[3]);
        }

        let result = color_buffer.read_bytes(device)?;
        let matches = result
            .chunks_exact(4)
            .zip(&reference)
            .all(|(pixel, expected)| pixel == expected);
        if !matches {
            return Ok(TestStatus::fail(
                "Unexpected colors found in color buffer; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `restart_mix` group of `createPrimitiveRestartTests`.
pub fn create_restart_mix_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("restart_mix");
    for extra_draw in [false, true] {
        for triangle_list in [false, true] {
            for dynamic_topology in [false, true] {
                for large_non_indexed_draw in [false, true] {
                    if large_non_indexed_draw && !triangle_list {
                        continue;
                    }

                    let name = format!(
                        "restart_mix{}{}{}{}",
                        if extra_draw { "_extra_draw" } else { "" },
                        if triangle_list { "_triangle_list" } else { "" },
                        if dynamic_topology { "_dynamic_topo" } else { "" },
                        if large_non_indexed_draw {
                            "_large_non_indexed_draw"
                        } else {
                            ""
                        }
                    );
                    let params = PrimitiveRestartMixParams {
                        extra_indexed_draws: extra_draw,
                        triangle_list,
                        dynamic_topology,
                        large_non_indexed_draw,
                    };
                    group.add_child(Box::new(PrimitiveRestartMixCase { name, params }) as Box<dyn TestCase>);
                }
            }
        }
    }
    group
}
