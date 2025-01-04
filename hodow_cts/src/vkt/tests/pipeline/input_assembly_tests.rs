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
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic construction type is ported, so the pipeline comes from
// `create_draw_pipeline` and the pipeline and render pass wrappers are plain Vulkan calls. the amber `restart_disabled_*` cases are not ported (`misc` is `input_assembly_null_state_tests`) (`primitive_restart.restart_mix` is `primitive_restart_mix_tests`), and neither is the VK_KHR_portability_subset triangle fan
// check.
//
// Draws every primitive topology from an index buffer of each index type (and, for primitive restart, with restart indices
// in the buffer, split into two draws, or split over three render passes) and compares the image with a software rendering.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_input_assembly::{
    INPUT_ASSEMBLY_DEFAULT, INPUT_ASSEMBLY_PATCH_LIST, INPUT_ASSEMBLY_POINT_LIST,
};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::RenderState;
use crate::rr::renderer::Program;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::vector::UVec4;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, create_draw_pipeline, default_depth_stencil_state, default_rasterization_state,
};
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, default_clear_value,
    make_color_depth_render_pass, map_vk_primitive_topology, read_color_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_dynamic_rendering_with_load_op, end_draw, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RESTART_INDEX_32: u32 = u32::MAX;
const RESTART_INDEX_16: u32 = 0xFFFF;
const RESTART_INDEX_8: u32 = 0xFF;

const PRIMITIVE_TOPOLOGIES: [vk::PrimitiveTopology; 10] = [
    vk::PrimitiveTopology::POINT_LIST,
    vk::PrimitiveTopology::LINE_LIST,
    vk::PrimitiveTopology::LINE_STRIP,
    vk::PrimitiveTopology::TRIANGLE_LIST,
    vk::PrimitiveTopology::TRIANGLE_STRIP,
    vk::PrimitiveTopology::TRIANGLE_FAN,
    vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
    vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
    vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
    vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum RestartType {
    Normal,
    None,
    All,
    Divide,
    SecondPass,
}

/// `InputAssemblyTest::isRestartIndex`
fn is_restart_index(index_type: vk::IndexType, index_value: u32) -> bool {
    if index_type == vk::IndexType::UINT16 {
        index_value == RESTART_INDEX_16
    } else if index_type == vk::IndexType::UINT8 {
        index_value == RESTART_INDEX_8
    } else {
        index_value == RESTART_INDEX_32
    }
}

/// `InputAssemblyTest::getRestartIndex`
fn get_restart_index(index_type: vk::IndexType) -> u32 {
    if index_type == vk::IndexType::UINT16 {
        RESTART_INDEX_16
    } else if index_type == vk::IndexType::UINT8 {
        RESTART_INDEX_8
    } else {
        RESTART_INDEX_32
    }
}

fn vertex(x: f32, y: f32, color: [f32; 4]) -> Vertex4Rgba {
    Vertex4Rgba {
        position: [x, y, 0.0, 1.0],
        color,
    }
}

const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];

/// `PrimitiveTopologyTest::createBufferData`
fn create_topology_buffer_data(topology: vk::PrimitiveTopology, primitive_count: i32) -> (Vec<u32>, Vec<Vertex4Rgba>) {
    debug_assert!(primitive_count > 0);

    let border = 0.2f32;
    let origin_x = -1.0 + border;
    let origin_y = -1.0 + border;
    let default_vertex = vertex(-1.0, -1.0, GREEN);
    let mut primitive_size_y = 2.0 - 2.0 * border;
    let primitive_size_x: f32;
    let mut indices: Vec<u32> = Vec::new();
    let mut vertices: Vec<Vertex4Rgba> = Vec::new();

    // Calculate primitive size
    match topology {
        vk::PrimitiveTopology::POINT_LIST => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count / 2 + primitive_count % 2 - 1) as f32
        }
        vk::PrimitiveTopology::LINE_LIST | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count - 1) as f32
        }
        vk::PrimitiveTopology::LINE_STRIP | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count / 2) as f32
        }
        vk::PrimitiveTopology::TRIANGLE_LIST | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            primitive_size_x =
                (2.0 - 2.0 * border) / (primitive_count + primitive_count / 2 + primitive_count % 2 - 1) as f32;
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count / 2 + primitive_count % 2) as f32
        }
        vk::PrimitiveTopology::TRIANGLE_FAN => {
            primitive_size_x = 1.0 - border;
            primitive_size_y = 1.0 - border;
        }
        _ => {
            primitive_size_x = 0.0;
            debug_assert!(false);
        }
    }

    match topology {
        vk::PrimitiveTopology::POINT_LIST => {
            for primitive_ndx in 0..primitive_count {
                vertices.push(vertex(
                    origin_x + (primitive_ndx / 2) as f32 * primitive_size_x,
                    origin_y + (primitive_ndx % 2) as f32 * primitive_size_y,
                    RED,
                ));
                indices.push(primitive_ndx as u32);
            }
        }

        vk::PrimitiveTopology::LINE_LIST => {
            for primitive_ndx in 0..primitive_count {
                for vertex_ndx in 0..2 {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx * 2 + vertex_ndx) / 2) as f32 * primitive_size_x,
                        origin_y + (vertex_ndx % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx * 2 + vertex_ndx) as u32);
                }
            }
        }

        vk::PrimitiveTopology::LINE_STRIP => {
            for primitive_ndx in 0..primitive_count {
                if primitive_ndx == 0 {
                    vertices.push(vertex(origin_x, origin_y, RED));
                    indices.push(0);

                    vertices.push(vertex(origin_x, origin_y + primitive_size_y, RED));
                    indices.push(1);
                } else {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 1) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 1) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx + 1) as u32);
                }
            }
        }

        vk::PrimitiveTopology::TRIANGLE_LIST => {
            for primitive_ndx in 0..primitive_count {
                for vertex_ndx in 0..3 {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx * 3 + vertex_ndx) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx * 3 + vertex_ndx) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx * 3 + vertex_ndx) as u32);
                }
            }
        }

        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            for primitive_ndx in 0..primitive_count {
                if primitive_ndx == 0 {
                    for vertex_ndx in 0..3 {
                        vertices.push(vertex(
                            origin_x + (vertex_ndx / 2) as f32 * primitive_size_x,
                            origin_y + (vertex_ndx % 2) as f32 * primitive_size_y,
                            RED,
                        ));
                        indices.push(vertex_ndx as u32);
                    }
                } else {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 2) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 2) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx + 2) as u32);
                }
            }
        }

        vk::PrimitiveTopology::TRIANGLE_FAN => {
            let step_angle = (std::f32::consts::PI * 0.5).min((2.0 * std::f32::consts::PI) / primitive_count as f32);

            for primitive_ndx in 0..primitive_count {
                if primitive_ndx == 0 {
                    vertices.push(vertex(0.0, 0.0, RED));
                    indices.push(0);

                    vertices.push(vertex(primitive_size_x, 0.0, RED));
                    indices.push(1);

                    vertices.push(vertex(
                        primitive_size_x * step_angle.cos(),
                        primitive_size_y * step_angle.sin(),
                        RED,
                    ));
                    indices.push(2);
                } else {
                    vertices.push(vertex(
                        primitive_size_x * (step_angle * (primitive_ndx + 1) as f32).cos(),
                        primitive_size_y * (step_angle * (primitive_ndx + 1) as f32).sin(),
                        RED,
                    ));
                    indices.push((primitive_ndx + 2) as u32);
                }
            }
        }

        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
            vertices.push(default_vertex);

            for primitive_ndx in 0..primitive_count {
                indices.push(0);

                for vertex_ndx in 0..2 {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx * 2 + vertex_ndx) / 2) as f32 * primitive_size_x,
                        origin_y + (vertex_ndx % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx * 2 + vertex_ndx + 1) as u32);
                }

                indices.push(0);
            }
        }

        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            vertices.push(default_vertex);
            indices.push(0);

            for primitive_ndx in 0..primitive_count {
                if primitive_ndx == 0 {
                    vertices.push(vertex(origin_x, origin_y, RED));
                    indices.push(1);

                    vertices.push(vertex(origin_x, origin_y + primitive_size_y, RED));
                    indices.push(2);
                } else {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 1) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 1) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx + 2) as u32);
                }
            }

            indices.push(0);
        }

        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            vertices.push(default_vertex);

            for primitive_ndx in 0..primitive_count {
                for vertex_ndx in 0..3 {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx * 3 + vertex_ndx) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx * 3 + vertex_ndx) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx * 3 + vertex_ndx + 1) as u32);
                    indices.push(0);
                }
            }
        }

        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
            vertices.push(default_vertex);

            for primitive_ndx in 0..primitive_count {
                if primitive_ndx == 0 {
                    for vertex_ndx in 0..3 {
                        vertices.push(vertex(
                            origin_x + (vertex_ndx / 2) as f32 * primitive_size_x,
                            origin_y + (vertex_ndx % 2) as f32 * primitive_size_y,
                            RED,
                        ));
                        indices.push((vertex_ndx + 1) as u32);
                        indices.push(0);
                    }
                } else {
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 2) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 2) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push((primitive_ndx + 2 + 1) as u32);
                    indices.push(0);
                }
            }
        }

        _ => debug_assert!(false),
    }

    (indices, vertices)
}

/// `PrimitiveRestartTest::createListPrimitives`
#[allow(clippy::too_many_arguments)]
fn create_list_primitives(
    restart_primitives: &[u32],
    primitive_count: i32,
    origin_x: f32,
    origin_y: f32,
    primitive_size_x: f32,
    primitive_size_y: f32,
    vertices_per_primitive: i32,
    index_type: vk::IndexType,
    index_data: &mut Vec<u32>,
    vertex_data: &mut Vec<Vertex4Rgba>,
    adjacencies: &[i32],
) {
    // Tells which vertex of a primitive is used as a restart index. This is decreased each time a restart primitive is used.
    let mut restart_vertex_index = vertices_per_primitive - 1;

    for primitive_ndx in 0..primitive_count {
        let mut non_adjacent_vertex_ndx = 0u32;

        for vertex_ndx in 0..vertices_per_primitive {
            if restart_primitives.contains(&(primitive_ndx as u32)) && vertex_ndx == restart_vertex_index {
                index_data.push(get_restart_index(index_type));

                restart_vertex_index -= 1;
                if restart_vertex_index < 0 {
                    restart_vertex_index = vertices_per_primitive - 1;
                }

                break;
            }

            if adjacencies.contains(&vertex_ndx) {
                // This is an adjacency vertex index. Add a green vertex that should never end up to the framebuffer.
                vertex_data.push(vertex(0.0, 0.0, GREEN));
                index_data.push(vertex_data.len() as u32 - 1);
                continue;
            }

            let position_ndx = primitive_ndx as u32 + non_adjacent_vertex_ndx;
            vertex_data.push(vertex(
                origin_x + (position_ndx / 2) as f32 * primitive_size_x,
                origin_y + (position_ndx % 2) as f32 * primitive_size_y,
                RED,
            ));
            index_data.push(vertex_data.len() as u32 - 1);
            non_adjacent_vertex_ndx += 1;
        }
    }
}

/// `PrimitiveRestartTest::createBufferData`
fn create_restart_buffer_data(
    topology: vk::PrimitiveTopology,
    primitive_count: i32,
    index_type: vk::IndexType,
    restart_type: RestartType,
    restart_primitives: &[u32],
) -> (Vec<u32>, Vec<Vertex4Rgba>) {
    debug_assert!(primitive_count > 0);

    let border = 0.2f32;
    let origin_x = -1.0 + border;
    let origin_y = -1.0 + border;
    let default_vertex = vertex(-1.0, -1.0, GREEN);
    let mut primitive_size_y = 2.0 - 2.0 * border;
    let primitive_size_x: f32;
    let mut primitive_start = true;
    let mut indices: Vec<u32> = Vec::new();
    let mut vertices: Vec<Vertex4Rgba> = Vec::new();
    let is_restart_primitive = |primitive_index: i32| restart_primitives.contains(&(primitive_index as u32));

    // Calculate primitive size
    match topology {
        vk::PrimitiveTopology::POINT_LIST => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count / 2 + primitive_count % 2 - 1) as f32
        }
        vk::PrimitiveTopology::LINE_LIST
        | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
        | vk::PrimitiveTopology::LINE_STRIP
        | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count / 2) as f32;
        }
        vk::PrimitiveTopology::TRIANGLE_LIST
        | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
        | vk::PrimitiveTopology::TRIANGLE_STRIP
        | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY
        | vk::PrimitiveTopology::PATCH_LIST => {
            primitive_size_x = (2.0 - 2.0 * border) / (primitive_count / 2 + primitive_count % 2) as f32
        }
        vk::PrimitiveTopology::TRIANGLE_FAN => {
            primitive_size_x = 1.0 - border;
            primitive_size_y = 1.0 - border;
        }
        _ => {
            primitive_size_x = 0.0;
            debug_assert!(false);
        }
    }

    match topology {
        vk::PrimitiveTopology::LINE_STRIP => {
            for primitive_ndx in 0..primitive_count {
                if is_restart_primitive(primitive_ndx) {
                    indices.push(get_restart_index(index_type));
                    primitive_start = true;
                } else {
                    if primitive_start && restart_type != RestartType::All {
                        vertices.push(vertex(
                            origin_x + (primitive_ndx / 2) as f32 * primitive_size_x,
                            origin_y + (primitive_ndx % 2) as f32 * primitive_size_y,
                            RED,
                        ));
                        indices.push(vertices.len() as u32 - 1);

                        primitive_start = false;
                    }

                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 1) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 1) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push(vertices.len() as u32 - 1);
                }
            }
        }

        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            for primitive_ndx in 0..primitive_count {
                if is_restart_primitive(primitive_ndx) {
                    indices.push(get_restart_index(index_type));
                    primitive_start = true;
                } else {
                    if primitive_start && restart_type != RestartType::All {
                        for vertex_ndx in 0..2 {
                            vertices.push(vertex(
                                origin_x + ((primitive_ndx + vertex_ndx) / 2) as f32 * primitive_size_x,
                                origin_y + ((primitive_ndx + vertex_ndx) % 2) as f32 * primitive_size_y,
                                RED,
                            ));
                            indices.push(vertices.len() as u32 - 1);
                        }

                        primitive_start = false;
                    }
                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 2) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 2) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push(vertices.len() as u32 - 1);
                }
            }
        }

        vk::PrimitiveTopology::TRIANGLE_FAN => {
            let step_angle = (std::f32::consts::PI * 0.5).min((2.0 * std::f32::consts::PI) / primitive_count as f32);

            for primitive_ndx in 0..primitive_count {
                if is_restart_primitive(primitive_ndx) {
                    indices.push(get_restart_index(index_type));
                    primitive_start = true;
                } else {
                    if primitive_start && restart_type != RestartType::All {
                        vertices.push(vertex(0.0, 0.0, RED));
                        indices.push(vertices.len() as u32 - 1);

                        vertices.push(vertex(
                            primitive_size_x * (step_angle * primitive_ndx as f32).cos(),
                            primitive_size_y * (step_angle * primitive_ndx as f32).sin(),
                            RED,
                        ));
                        indices.push(vertices.len() as u32 - 1);

                        primitive_start = false;
                    }

                    vertices.push(vertex(
                        primitive_size_x * (step_angle * (primitive_ndx + 1) as f32).cos(),
                        primitive_size_y * (step_angle * (primitive_ndx + 1) as f32).sin(),
                        RED,
                    ));
                    indices.push(vertices.len() as u32 - 1);
                }
            }
        }

        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            vertices.push(default_vertex);

            for primitive_ndx in 0..primitive_count {
                if is_restart_primitive(primitive_ndx) {
                    indices.push(0);
                    indices.push(get_restart_index(index_type));
                    primitive_start = true;
                } else {
                    if primitive_start && restart_type != RestartType::All {
                        indices.push(0);

                        vertices.push(vertex(
                            origin_x + (primitive_ndx / 2) as f32 * primitive_size_x,
                            origin_y + (primitive_ndx % 2) as f32 * primitive_size_y,
                            RED,
                        ));
                        indices.push(vertices.len() as u32 - 1);

                        primitive_start = false;
                    }

                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 1) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 1) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push(vertices.len() as u32 - 1);
                }
            }

            indices.push(0);
        }

        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
            vertices.push(default_vertex);

            for primitive_ndx in 0..primitive_count {
                if is_restart_primitive(primitive_ndx) {
                    indices.push(get_restart_index(index_type));
                    primitive_start = true;
                } else {
                    if primitive_start && restart_type != RestartType::All {
                        for vertex_ndx in 0..2 {
                            vertices.push(vertex(
                                origin_x + ((primitive_ndx + vertex_ndx) / 2) as f32 * primitive_size_x,
                                origin_y + ((primitive_ndx + vertex_ndx) % 2) as f32 * primitive_size_y,
                                RED,
                            ));
                            indices.push(vertices.len() as u32 - 1);
                            indices.push(0);
                        }

                        primitive_start = false;
                    }

                    vertices.push(vertex(
                        origin_x + ((primitive_ndx + 2) / 2) as f32 * primitive_size_x,
                        origin_y + ((primitive_ndx + 2) % 2) as f32 * primitive_size_y,
                        RED,
                    ));
                    indices.push(vertices.len() as u32 - 1);
                    indices.push(0);
                }
            }
        }

        vk::PrimitiveTopology::POINT_LIST => {
            create_list_primitives(
                restart_primitives,
                primitive_count,
                origin_x,
                origin_y,
                primitive_size_x,
                primitive_size_y,
                1,
                index_type,
                &mut indices,
                &mut vertices,
                &[],
            );
        }

        vk::PrimitiveTopology::LINE_LIST => {
            create_list_primitives(
                restart_primitives,
                primitive_count,
                origin_x,
                origin_y,
                primitive_size_x,
                primitive_size_y,
                2,
                index_type,
                &mut indices,
                &mut vertices,
                &[],
            );
        }

        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
            create_list_primitives(
                restart_primitives,
                primitive_count,
                origin_x,
                origin_y,
                primitive_size_x,
                primitive_size_y,
                4,
                index_type,
                &mut indices,
                &mut vertices,
                &[0, 3],
            );
        }

        vk::PrimitiveTopology::TRIANGLE_LIST | vk::PrimitiveTopology::PATCH_LIST => {
            create_list_primitives(
                restart_primitives,
                primitive_count,
                origin_x,
                origin_y,
                primitive_size_x,
                primitive_size_y,
                3,
                index_type,
                &mut indices,
                &mut vertices,
                &[],
            );
        }

        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            create_list_primitives(
                restart_primitives,
                primitive_count,
                origin_x,
                origin_y,
                primitive_size_x,
                primitive_size_y,
                6,
                index_type,
                &mut indices,
                &mut vertices,
                &[1, 3, 5],
            );
        }

        _ => debug_assert!(false),
    }

    (indices, vertices)
}

/// `InputAssemblyInstance::getVerticesPerPrimitive`
fn get_vertices_per_primitive(topology: vk::PrimitiveTopology) -> u32 {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => 1,
        vk::PrimitiveTopology::LINE_LIST => 2,
        vk::PrimitiveTopology::TRIANGLE_LIST => 3,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => 4,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => 6,
        vk::PrimitiveTopology::PATCH_LIST => 3,
        // Dynamic vertices per primitive are not supported
        _ => 0,
    }
}

/// `PrimitiveTopologyTest` and `PrimitiveRestartTest`
struct InputAssemblyTest {
    name: String,
    primitive_topology: vk::PrimitiveTopology,
    primitive_count: i32,
    test_primitive_restart: bool,
    test_divide_draw: bool,
    test_second_pass: bool,
    index_type: vk::IndexType,
    /// `None` for a plain primitive topology test.
    restart_type: Option<RestartType>,
    restart_primitives: Vec<u32>,
}

impl InputAssemblyTest {
    fn topology(name: String, primitive_topology: vk::PrimitiveTopology, index_type: vk::IndexType) -> Self {
        Self {
            name,
            primitive_topology,
            primitive_count: 10,
            test_primitive_restart: false,
            test_divide_draw: false,
            test_second_pass: false,
            index_type,
            restart_type: None,
            restart_primitives: Vec::new(),
        }
    }

    /// `PrimitiveRestartTest`'s constructor
    fn restart(
        name: String,
        primitive_topology: vk::PrimitiveTopology,
        index_type: vk::IndexType,
        restart_type: RestartType,
    ) -> Self {
        let primitive_count = 10i32;

        let restart_primitives: Vec<u32> = match restart_type {
            RestartType::Normal => vec![1, 5],
            RestartType::None => Vec::new(),
            // Single restart on the last primitive in the list
            RestartType::Divide | RestartType::SecondPass => vec![primitive_count as u32 - 1],
            RestartType::All => {
                let count = match primitive_topology {
                    vk::PrimitiveTopology::LINE_LIST
                    | vk::PrimitiveTopology::LINE_STRIP
                    | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                    | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => 2,
                    vk::PrimitiveTopology::TRIANGLE_LIST
                    | vk::PrimitiveTopology::TRIANGLE_STRIP
                    | vk::PrimitiveTopology::TRIANGLE_FAN
                    | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
                    | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => 3,
                    _ => 1,
                };
                (0..primitive_count as u32).filter(|i| i % count == count - 1).collect()
            }
        };

        Self {
            name,
            primitive_topology,
            primitive_count,
            test_primitive_restart: true,
            test_divide_draw: restart_type == RestartType::Divide,
            test_second_pass: restart_type == RestartType::SecondPass,
            index_type,
            restart_type: Some(restart_type),
            restart_primitives,
        }
    }
}

impl TestCase for InputAssemblyTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `InputAssemblyTest::checkSupport` and `PrimitiveRestartTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.restart_type.is_some() {
            match self.primitive_topology {
                vk::PrimitiveTopology::PATCH_LIST
                | vk::PrimitiveTopology::POINT_LIST
                | vk::PrimitiveTopology::LINE_LIST
                | vk::PrimitiveTopology::TRIANGLE_LIST
                | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
                    context.require_device_functionality("VK_EXT_primitive_topology_list_restart")?;

                    let mut features = vk::PhysicalDevicePrimitiveTopologyListRestartFeaturesEXT::default();
                    {
                        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
                        unsafe {
                            context
                                .get_instance()
                                .get_physical_device_features2(context.get_physical_device(), &mut features2)
                        };
                    }
                    if features.primitive_topology_list_restart == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "Primitive topology list restart feature not supported".to_string(),
                        ));
                    }
                    if self.primitive_topology == vk::PrimitiveTopology::PATCH_LIST
                        && features.primitive_topology_patch_list_restart == vk::FALSE
                    {
                        return Err(TestError::NotSupported(
                            "Primitive topology patch list restart feature not supported".to_string(),
                        ));
                    }
                }
                _ => {}
            }
        }

        if self.index_type == vk::IndexType::UINT8
            && !context.is_device_functionality_supported("VK_KHR_index_type_uint8")
            && !context.is_device_functionality_supported("VK_EXT_index_type_uint8")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_index_type_uint8 and VK_EXT_index_type_uint8 is not supported".to_string(),
            ));
        }

        let features = context.get_device_features();
        match self.primitive_topology {
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
            | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
            | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
            | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
                if features.geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Requested core feature is not supported: geometryShader".to_string(),
                    ));
                }
            }
            vk::PrimitiveTopology::PATCH_LIST if features.tessellation_shader == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: tessellationShader".to_string(),
                ));
            }
            _ => {}
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.primitive_topology {
            vk::PrimitiveTopology::POINT_LIST => INPUT_ASSEMBLY_POINT_LIST.programs,
            vk::PrimitiveTopology::PATCH_LIST => INPUT_ASSEMBLY_PATCH_LIST.programs,
            _ => INPUT_ASSEMBLY_DEFAULT.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let (index_buffer_data, vertex_buffer_data) = match self.restart_type {
            Some(restart_type) => create_restart_buffer_data(
                self.primitive_topology,
                self.primitive_count,
                self.index_type,
                restart_type,
                &self.restart_primitives,
            ),
            None => create_topology_buffer_data(self.primitive_topology, self.primitive_count),
        };

        Box::new(InputAssemblyInstance {
            context,
            test: self,
            indices: index_buffer_data,
            vertices: vertex_buffer_data,
        })
    }
}

struct InputAssemblyInstance<'a> {
    context: &'a Context<'a>,
    test: &'a InputAssemblyTest,
    indices: Vec<u32>,
    vertices: Vec<Vertex4Rgba>,
}

impl InputAssemblyInstance<'_> {
    /// `uploadIndexBufferData8`, `uploadIndexBufferData16` and the plain copy of the 32-bit data.
    fn index_bytes(&self) -> Vec<u8> {
        if self.test.index_type == vk::IndexType::UINT32 {
            self.indices.iter().flat_map(|index| index.to_ne_bytes()).collect()
        } else if self.test.index_type == vk::IndexType::UINT8 {
            self.indices
                .iter()
                .map(|&index| {
                    debug_assert!(index <= 0xFF);
                    index as u8
                })
                .collect()
        } else {
            self.indices
                .iter()
                .flat_map(|&index| {
                    debug_assert!(index <= 0xFFFF);
                    (index as u16).to_ne_bytes()
                })
                .collect()
        }
    }
}

impl TestInstance for InputAssemblyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let test = self.test;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let primitive_topology = test.primitive_topology;
        let primitive_restart_enable = test.test_primitive_restart;
        let divide_draw_enable = test.test_divide_draw;
        let multi_pass_enable = test.test_second_pass;
        let index_type = test.index_type;
        let render_size: (u32, u32) = if primitive_topology == vk::PrimitiveTopology::TRIANGLE_FAN {
            (32, 32)
        } else {
            (64, 16)
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let patch_list = primitive_topology == vk::PrimitiveTopology::PATCH_LIST;

        // Create color image
        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, alloc, color_image_info, MemoryRequirement::ANY)?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_attachment_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_srr,
        )?;

        // Render passes: three when the draw is split over passes (clear, then two loading ones), one otherwise
        let mut render_passes: Vec<Unique<'_, vk::RenderPass>> = Vec::new();
        if multi_pass_enable {
            for load_op in [
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentLoadOp::LOAD,
                vk::AttachmentLoadOp::LOAD,
            ] {
                render_passes.push(make_color_depth_render_pass(
                    device,
                    color_format,
                    vk::Format::UNDEFINED,
                    load_op,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::UNDEFINED,
                )?);
            }
        } else {
            render_passes.push(make_render_pass(device, color_format)?);
        }

        let mut framebuffers = Vec::new();
        for render_pass in &render_passes {
            framebuffers.push(make_framebuffer(
                device,
                **render_pass,
                &[*color_attachment_view],
                render_size.0,
                render_size.1,
                1,
            )?);
        }

        // Create pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("color_frag")?)?;
        let tessellation_modules = if patch_list {
            Some((
                create_shader_module(device, binaries.get("color_tcs")?)?,
                create_shader_module(device, binaries.get("color_tes")?)?,
            ))
        } else {
            None
        };

        // Create pipeline
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vertex_shader_module)];
        if let Some((tcs, tes)) = &tessellation_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tcs));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tes));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module));

        let mut state = DrawPipelineState::new(primitive_topology).with_full_viewport(render_size.0, render_size.1);
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
                offset: std::mem::offset_of!(Vertex4Rgba, color) as u32,
            },
        ];
        state.rasterization = default_rasterization_state();
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.depth_stencil = default_depth_stencil_state();
        state.depth_stencil.depth_compare_op = vk::CompareOp::LESS;
        state.primitive_restart_enable = primitive_restart_enable;
        if patch_list {
            state.patch_control_points = Some(3);
        }
        let mut stage_names = vec![(vk::ShaderStageFlags::VERTEX, "color_vert")];
        if patch_list {
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "color_tcs"));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "color_tes"));
        }
        stage_names.push((vk::ShaderStageFlags::FRAGMENT, "color_frag"));
        let shader_objects = make_shader_objects_stages(context, &stage_names, &[], &[])?;
        let graphics_pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_passes[0],
                &stages,
                &state,
            )?)
        };

        // Create the index and vertex buffers
        let index_buffer = create_host_buffer(context, &self.index_bytes(), vk::BufferUsageFlags::INDEX_BUFFER)?;
        let vertex_buffer = create_host_buffer(context, &self.vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command pool and command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let attachment_clear_value = default_clear_value(color_format);

        let initial_barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(color_image.get())
            .subresource_range(color_srr)
            .build();
        let pass_barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(color_image.get())
            .subresource_range(color_srr)
            .build();

        let (width, height) = render_size;
        let full_screen = make_rect_2d(0, 0, width, height);
        let left_half = make_rect_2d(0, 0, width / 2, height);
        let right_half = make_rect_2d(width as i32 / 2, 0, width / 2, height);

        let total_indices = self.indices.len() as u32;
        let vertices_per_primitive = get_vertices_per_primitive(primitive_topology);
        let pipeline_barrier =
            |src: vk::PipelineStageFlags, dst: vk::PipelineStageFlags, barrier: vk::ImageMemoryBarrier| unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    src,
                    dst,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            };

        begin_command_buffer(device, cmd)?;

        pipeline_barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            initial_barrier,
        );

        let bind_geometry = || unsafe {
            if let Some(pipeline) = &graphics_pipeline {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, index_type);
        };

        // Dynamic rendering has no render pass objects: the passes after the first load what the first one drew.
        let begin_pass = |render_pass_ndx: usize, area: vk::Rect2D| {
            if let Some(objects) = shader_objects.as_ref() {
                begin_dynamic_rendering_with_load_op(
                    device,
                    cmd,
                    area,
                    &[RenderingAttachment {
                        view: *color_attachment_view,
                        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        clear_value: attachment_clear_value,
                    }],
                    None,
                    None,
                    if render_pass_ndx == 0 {
                        vk::AttachmentLoadOp::CLEAR
                    } else {
                        vk::AttachmentLoadOp::LOAD
                    },
                );
                objects.bind(cmd, &state);
            } else {
                begin_render_pass(
                    device,
                    cmd,
                    *render_passes[render_pass_ndx],
                    *framebuffers[render_pass_ndx],
                    area,
                    attachment_clear_value,
                );
            }
        };
        let end_pass = || end_draw(device, cmd, shader_objects.is_some());

        if divide_draw_enable {
            debug_assert!(vertices_per_primitive > 0);

            let max_primitives_first = (total_indices / vertices_per_primitive) / 2;
            let first_half_count = max_primitives_first * vertices_per_primitive;
            let second_half_count = total_indices - first_half_count;

            begin_pass(0, full_screen);

            bind_geometry();

            unsafe {
                device.cmd_draw_indexed(cmd, first_half_count, 1, 0, 0, 0);
                device.cmd_draw_indexed(cmd, second_half_count, 1, first_half_count, 0, 0);
            }

            end_pass();
        } else if multi_pass_enable {
            debug_assert!(vertices_per_primitive > 0);

            let max_primitives_first = (total_indices / vertices_per_primitive) / 2;
            let first_half_count = max_primitives_first * vertices_per_primitive;
            let second_half_count = total_indices - first_half_count;

            begin_pass(0, full_screen);
            end_pass();

            pipeline_barrier(
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                pass_barrier,
            );

            begin_pass(1, left_half);
            bind_geometry();
            unsafe { device.cmd_draw_indexed(cmd, first_half_count + vertices_per_primitive, 1, 0, 0, 0) };
            end_pass();

            pipeline_barrier(
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                pass_barrier,
            );

            // The pipeline and the buffers stay bound across the render passes, as upstream relies on.
            begin_pass(2, right_half);
            unsafe {
                device.cmd_draw_indexed(
                    cmd,
                    second_half_count + vertices_per_primitive,
                    1,
                    first_half_count - vertices_per_primitive,
                    0,
                    0,
                )
            };
            end_pass();
        } else {
            begin_pass(0, full_screen);

            bind_geometry();
            unsafe { device.cmd_draw_indexed(cmd, self.indices.len() as u32, 1, 0, 0, 0) };

            end_pass();
        }

        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the image
        let tcu_color_format = map_vk_format(color_format).expect("RGBA8 has a texture format");
        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(tcu_color_format, None, false);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut ref_renderer = ReferenceRenderer::new(width, height, tcu_color_format, None)?;

        {
            // The reference for tessellated patches are drawn using ordinary triangles.
            let topology = if patch_list {
                PrimitiveType::Triangles
            } else {
                map_vk_primitive_topology(primitive_topology)
            };
            let mut render_state = RenderState::new(
                ref_renderer.get_viewport_state(),
                context.get_device_properties().limits.sub_pixel_precision_bits as i32,
            );

            if primitive_topology == vk::PrimitiveTopology::POINT_LIST {
                render_state.point.point_size = 3.0;
            }

            if primitive_restart_enable {
                let mut indices_range: Vec<u32> = Vec::new();

                for (index_ndx, &index) in self.indices.iter().enumerate() {
                    let is_restart = is_restart_index(index_type, index);

                    if !is_restart {
                        indices_range.push(index);
                    }

                    if is_restart || index_ndx == self.indices.len() - 1 {
                        let non_indexed_vertices: Vec<Vertex4Rgba> = indices_range
                            .iter()
                            .map(|&range_index| self.vertices[range_index as usize])
                            .collect();

                        ref_renderer.draw(&program, &render_state, topology, &non_indexed_vertices);
                        indices_range.clear();
                    }
                }
            } else {
                let non_indexed_vertices: Vec<Vertex4Rgba> = self
                    .indices
                    .iter()
                    .map(|&index| self.vertices[index as usize])
                    .collect();

                ref_renderer.draw(&program, &render_state, topology, &non_indexed_vertices);
            }
        }

        let result = read_color_attachment(
            context,
            color_image.get(),
            color_format,
            render_size,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let compare_ok = int_threshold_position_deviation_compare(
            &ref_renderer.get_access(),
            &result.get_const_access(),
            UVec4::new(2, 2, 2, 2),
            [1, 1, 0],
            true,
        );

        if compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

fn primitive_topology_case_name(topology: vk::PrimitiveTopology) -> &'static str {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => "point_list",
        vk::PrimitiveTopology::LINE_LIST => "line_list",
        vk::PrimitiveTopology::LINE_STRIP => "line_strip",
        vk::PrimitiveTopology::TRIANGLE_LIST => "triangle_list",
        vk::PrimitiveTopology::TRIANGLE_STRIP => "triangle_strip",
        vk::PrimitiveTopology::TRIANGLE_FAN => "triangle_fan",
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => "line_list_with_adjacency",
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => "line_strip_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => "triangle_list_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => "triangle_strip_with_adjacency",
        _ => "patch_list",
    }
}

/// `createPrimitiveTopologyTests`
fn create_primitive_topology_tests() -> TestCaseGroup {
    let mut primitive_topology_tests = TestCaseGroup::new("primitive_topology");

    let mut index_uint16_tests = TestCaseGroup::new("index_type_uint16");
    let mut index_uint32_tests = TestCaseGroup::new("index_type_uint32");
    let mut index_uint8_tests = TestCaseGroup::new("index_type_uint8");

    for topology in PRIMITIVE_TOPOLOGIES {
        let name = primitive_topology_case_name(topology);

        index_uint16_tests.add_child(Box::new(InputAssemblyTest::topology(
            name.to_string(),
            topology,
            vk::IndexType::UINT16,
        )) as Box<dyn TestCase>);
        index_uint32_tests.add_child(Box::new(InputAssemblyTest::topology(
            name.to_string(),
            topology,
            vk::IndexType::UINT32,
        )) as Box<dyn TestCase>);
        index_uint8_tests.add_child(Box::new(InputAssemblyTest::topology(
            name.to_string(),
            topology,
            vk::IndexType::UINT8,
        )) as Box<dyn TestCase>);
    }

    primitive_topology_tests.add_child(index_uint16_tests);
    primitive_topology_tests.add_child(index_uint32_tests);
    primitive_topology_tests.add_child(index_uint8_tests);

    primitive_topology_tests
}

/// `createPrimitiveRestartTests`, without the amber `restart_disabled_*` cases, plus `restart_mix`.
fn create_primitive_restart_tests(shader_object: bool) -> TestCaseGroup {
    let primitive_restart_topologies = [
        vk::PrimitiveTopology::LINE_STRIP,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        vk::PrimitiveTopology::TRIANGLE_FAN,
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        // Supported with VK_EXT_primitive_topology_list_restart
        vk::PrimitiveTopology::POINT_LIST,
        vk::PrimitiveTopology::LINE_LIST,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        vk::PrimitiveTopology::TRIANGLE_LIST,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        vk::PrimitiveTopology::PATCH_LIST,
    ];

    // Topologies types capable to perform clear vertex division (list types with fixed vertices per primitive)
    let mixed_primitive_restart_topologies = [
        vk::PrimitiveTopology::POINT_LIST,
        vk::PrimitiveTopology::LINE_LIST,
        vk::PrimitiveTopology::TRIANGLE_LIST,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        vk::PrimitiveTopology::PATCH_LIST,
    ];

    let mut primitive_restart_tests = TestCaseGroup::new("primitive_restart");

    let mut index_uint16_tests = TestCaseGroup::new("index_type_uint16");
    let mut index_uint32_tests = TestCaseGroup::new("index_type_uint32");
    let mut index_uint8_tests = TestCaseGroup::new("index_type_uint8");

    let restart_types = [
        (RestartType::Normal, ""),
        (RestartType::None, "no_restart_"),
        (RestartType::All, "restart_all_"),
        (RestartType::Divide, "divide_draw_"),
        (RestartType::SecondPass, "second_pass_"),
    ];

    for (restart_type, restart_name) in restart_types {
        let is_split_test = matches!(restart_type, RestartType::Divide | RestartType::SecondPass);

        // Select appropriate topology array based on test type
        let topologies: &[vk::PrimitiveTopology] = if is_split_test {
            &mixed_primitive_restart_topologies
        } else {
            &primitive_restart_topologies
        };

        for &topology in topologies {
            if topology == vk::PrimitiveTopology::POINT_LIST && restart_type == RestartType::All {
                continue;
            }

            let name = format!("{restart_name}{}", primitive_topology_case_name(topology));

            index_uint16_tests.add_child(Box::new(InputAssemblyTest::restart(
                name.clone(),
                topology,
                vk::IndexType::UINT16,
                restart_type,
            )) as Box<dyn TestCase>);
            index_uint32_tests.add_child(Box::new(InputAssemblyTest::restart(
                name.clone(),
                topology,
                vk::IndexType::UINT32,
                restart_type,
            )) as Box<dyn TestCase>);
            index_uint8_tests.add_child(Box::new(InputAssemblyTest::restart(
                name,
                topology,
                vk::IndexType::UINT8,
                restart_type,
            )) as Box<dyn TestCase>);
        }
    }

    primitive_restart_tests.add_child(index_uint16_tests);
    primitive_restart_tests.add_child(index_uint32_tests);
    primitive_restart_tests.add_child(index_uint8_tests);
    if !shader_object {
        primitive_restart_tests.add_child(super::primitive_restart_mix_tests::create_restart_mix_tests());
    }

    primitive_restart_tests
}

/// `createInputAssemblyTests` for `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`.
pub fn create_input_assembly_tests() -> TestCaseGroup {
    create_input_assembly_tests_for(false, true)
}

/// `createInputAssemblyTests` for a shader object type: `restart_mix` is left out, and `misc` is only in the unlinked SPIR-V one.
pub fn create_input_assembly_tests_for(shader_object: bool, with_misc: bool) -> TestCaseGroup {
    let mut input_assembly_tests = TestCaseGroup::new("input_assembly");

    input_assembly_tests.add_child(create_primitive_topology_tests());
    input_assembly_tests.add_child(create_primitive_restart_tests(shader_object));
    if with_misc {
        input_assembly_tests.add_child(super::input_assembly_null_state_tests::create_input_assembly_misc_tests());
    }

    input_assembly_tests
}
