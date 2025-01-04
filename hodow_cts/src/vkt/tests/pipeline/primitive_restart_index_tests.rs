// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelinePrimitiveRestartIndexTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Copyright (c) 2026 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. vulkanalia has no VK_EXT_primitive_restart_index, so
// `vkCmdSetPrimitiveRestartIndexEXT` is looked up through `vkGetDeviceProcAddr` and the feature struct lives in `vkt::context`.
// Like upstream, the INDIRECT_2 and INDIRECT_COUNT_2 draw calls (VK_KHR_device_address_commands) are not instantiated.
//
// Draws a 4x8 image one pixel row at a time from an index buffer where every row ends in a restart index (a custom one set with
// the extension for even blocks, the default one for odd blocks) and the last pixel of each row is cut out by turning one index
// into a restart, for every topology and index type.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, DeviceV1_3, ExtConditionalRenderingExtensionDeviceCommands,
    ExtExtendedDynamicState2ExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::pipeline_primitive_restart_index::{RESTART_INDEX_DEFAULT, RESTART_INDEX_PATCH_LIST};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::make_shader_objects_stages;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const EXTENT: (u32, u32) = (4, 8);
const BLOCK_COUNT: u32 = 4;
const PAD_VERTEX_COUNT: u32 = 2;
const VEC4_SIZE: u32 = 16;

type Vec4 = [f32; 4];

/// `RestartIndex`
#[derive(Clone, Copy, PartialEq, Eq)]
enum RestartIndex {
    Zero,
    One,
    Penultimate,
    Max,
}

/// `DrawCall`, without the two device address variants upstream leaves commented out.
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCall {
    Direct,
    Indirect,
    IndirectCount,
}

/// `Params`
#[derive(Clone, Copy)]
struct Params {
    topology: vk::PrimitiveTopology,
    index_type: vk::IndexType,
    restart_index: RestartIndex,
    draw_call: DrawCall,
    dynamic_primitive_restart_enable: bool,
    conditional_rendering: bool,
    secondary_cmd: bool,
}

impl Params {
    fn needs_primitive_topology_list_restart(&self) -> bool {
        matches!(
            self.topology,
            vk::PrimitiveTopology::POINT_LIST
                | vk::PrimitiveTopology::LINE_LIST
                | vk::PrimitiveTopology::TRIANGLE_LIST
                | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
        )
    }

    fn needs_primitive_topology_patch_list_restart(&self) -> bool {
        self.topology == vk::PrimitiveTopology::PATCH_LIST
    }

    fn needs_geometry_shader(&self) -> bool {
        matches!(
            self.topology,
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY
        )
    }

    fn block_colors() -> [Vec4; 4] {
        [
            [0.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
        ]
    }

    fn clear_color() -> Vec4 {
        [0.0, 0.0, 0.0, 1.0]
    }

    /// `getRowVertices`
    fn get_row_vertices(&self, row_index: u32) -> Vec<Vec4> {
        let (extent_x, extent_y) = EXTENT;
        debug_assert!(row_index < extent_y);

        let normalize = |v: u32, total: u32| (v as f32 / total as f32) * 2.0 - 1.0;

        let y_top = normalize(row_index, extent_y);
        let y_bot = normalize(row_index + 1, extent_y);
        let y_mid = (y_top + y_bot) / 2.0;

        let topology = self.topology;
        let adj: Vec4 = [0.0, 0.0, 0.0, 1.0];
        let mut vertices: Vec<Vec4> = Vec::with_capacity(6 * extent_x as usize);

        if topology == vk::PrimitiveTopology::LINE_STRIP {
            vertices.push([-1.0, y_top, 0.0, 1.0]);
        } else if topology == vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY {
            vertices.push(adj);
            vertices.push([-1.0, y_top, 0.0, 1.0]);
        } else if topology == vk::PrimitiveTopology::TRIANGLE_STRIP {
            vertices.push([-1.0, y_top, 0.0, 1.0]);
            vertices.push([-1.0, y_bot, 0.0, 1.0]);
        } else if topology == vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY {
            vertices.push([-1.0, y_top, 0.0, 1.0]);
            vertices.push(adj);
            vertices.push([-1.0, y_bot, 0.0, 1.0]);
            vertices.push(adj);
        } else if topology == vk::PrimitiveTopology::TRIANGLE_FAN {
            vertices.push([0.0, y_bot, 0.0, 1.0]);
            vertices.push([-1.0, y_bot, 0.0, 1.0]);
            vertices.push([-1.0, y_top, 0.0, 1.0]);
        }

        for i in 0..extent_x {
            let x_left = normalize(i, extent_x);
            let x_right = normalize(i + 1, extent_x);
            let x_mid = (x_left + x_right) / 2.0;

            match topology {
                vk::PrimitiveTopology::POINT_LIST => vertices.push([x_mid, y_mid, 0.0, 1.0]),
                vk::PrimitiveTopology::LINE_LIST => {
                    vertices.push([x_left, y_bot, 0.0, 1.0]);
                    vertices.push([x_right, y_top, 0.0, 1.0]);
                }
                vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
                    vertices.push(adj);
                    vertices.push([x_left, y_bot, 0.0, 1.0]);
                    vertices.push([x_right, y_top, 0.0, 1.0]);
                    vertices.push(adj);
                }
                vk::PrimitiveTopology::LINE_STRIP | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
                    vertices.push([x_right, if i % 2 != 0 { y_top } else { y_bot }, 0.0, 1.0]);
                }
                vk::PrimitiveTopology::TRIANGLE_LIST | vk::PrimitiveTopology::PATCH_LIST => {
                    vertices.push([x_left, y_bot, 0.0, 1.0]);
                    vertices.push([x_right, y_bot, 0.0, 1.0]);
                    vertices.push([x_mid, y_top, 0.0, 1.0]);
                }
                vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
                    vertices.push([x_left, y_bot, 0.0, 1.0]);
                    vertices.push(adj);
                    vertices.push([x_right, y_bot, 0.0, 1.0]);
                    vertices.push(adj);
                    vertices.push([x_mid, y_top, 0.0, 1.0]);
                    vertices.push(adj);
                }
                vk::PrimitiveTopology::TRIANGLE_STRIP => {
                    vertices.push([x_right, y_top, 0.0, 1.0]);
                    vertices.push([x_right, y_bot, 0.0, 1.0]);
                }
                vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
                    vertices.push([x_right, y_top, 0.0, 1.0]);
                    vertices.push(adj);
                    vertices.push([x_right, y_bot, 0.0, 1.0]);
                    vertices.push(adj);
                }
                vk::PrimitiveTopology::TRIANGLE_FAN => vertices.push([x_right, y_top, 0.0, 1.0]),
                _ => debug_assert!(false),
            }
        }

        if topology == vk::PrimitiveTopology::TRIANGLE_FAN {
            vertices.push([1.0, y_bot, 0.0, 1.0]);
        } else if topology == vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY {
            vertices.push(adj);
        }

        vertices
    }

    fn get_default_restart_index(&self) -> u32 {
        if self.index_type == vk::IndexType::UINT32 {
            0xFFFF_FFFF
        } else if self.index_type == vk::IndexType::UINT16 {
            0xFFFF
        } else {
            debug_assert!(self.index_type == vk::IndexType::UINT8);
            0xFF
        }
    }

    fn get_custom_restart_index(&self) -> u32 {
        let max_index = self.get_default_restart_index();
        match self.restart_index {
            RestartIndex::Zero => 0,
            RestartIndex::One => 1,
            RestartIndex::Penultimate => max_index - 1,
            RestartIndex::Max => max_index,
        }
    }

    /// `getRowIndices`: the geometry indices do not depend on the row, contrary to the vertex values.
    fn get_row_indices(&self) -> Vec<u32> {
        let extent_x = EXTENT.0;
        let topology = self.topology;
        let mut indices: Vec<u32> = Vec::with_capacity(7 * extent_x as usize);

        let append_index = |indices: &mut Vec<u32>, count: u32| {
            for _ in 0..count {
                let next = indices.len() as u32;
                indices.push(next);
            }
        };

        if topology == vk::PrimitiveTopology::LINE_STRIP {
            append_index(&mut indices, 1);
        } else if topology == vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
            || topology == vk::PrimitiveTopology::TRIANGLE_STRIP
        {
            append_index(&mut indices, 2);
        } else if topology == vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY {
            append_index(&mut indices, 4);
        } else if topology == vk::PrimitiveTopology::TRIANGLE_FAN {
            append_index(&mut indices, 3);
        }

        for _ in 0..extent_x {
            match topology {
                vk::PrimitiveTopology::POINT_LIST
                | vk::PrimitiveTopology::LINE_STRIP
                | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_FAN => append_index(&mut indices, 1),
                vk::PrimitiveTopology::LINE_LIST | vk::PrimitiveTopology::TRIANGLE_STRIP => {
                    append_index(&mut indices, 2)
                }
                vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => append_index(&mut indices, 4),
                vk::PrimitiveTopology::TRIANGLE_LIST | vk::PrimitiveTopology::PATCH_LIST => {
                    append_index(&mut indices, 3)
                }
                vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => append_index(&mut indices, 6),
                _ => debug_assert!(false),
            }
        }

        if topology == vk::PrimitiveTopology::TRIANGLE_FAN
            || topology == vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
        {
            append_index(&mut indices, 1);
        }

        indices
    }

    fn get_restart_index_for_block(&self, block_index: u32) -> u32 {
        if block_index.is_multiple_of(2) {
            self.get_custom_restart_index()
        } else {
            self.get_default_restart_index()
        }
    }

    fn get_restart_index_for_row(&self, row_index: u32) -> u32 {
        let block_rows = EXTENT.1 / BLOCK_COUNT;
        self.get_restart_index_for_block(row_index / block_rows)
    }
}

struct RestartIndexCase {
    name: String,
    params: Params,
}

/// A feature struct of the physical device, read through `vkGetPhysicalDeviceFeatures2`.
fn query_features<T: vk::ExtendsPhysicalDeviceFeatures2 + vk::Cast<Target = T> + Default>(context: &Context<'_>) -> T {
    let mut features = T::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

impl TestCase for RestartIndexCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `RestartIndexCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        context.require_device_functionality("VK_EXT_primitive_restart_index")?;

        if params.index_type == vk::IndexType::UINT8 {
            let features: vk::PhysicalDeviceIndexTypeUint8Features = query_features(context);
            if features.index_type_uint8 == vk::FALSE {
                return Err(TestError::NotSupported("indexTypeUint8 not supported".to_string()));
            }
        }

        if params.dynamic_primitive_restart_enable {
            let features: vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT = query_features(context);
            if features.extended_dynamic_state2 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState2 not supported".to_string(),
                ));
            }
        }

        let needs_list_restart = params.needs_primitive_topology_list_restart();
        let needs_patch_restart = params.needs_primitive_topology_patch_list_restart();

        if needs_list_restart || needs_patch_restart {
            let restart_features: vk::PhysicalDevicePrimitiveTopologyListRestartFeaturesEXT = query_features(context);

            if needs_list_restart && restart_features.primitive_topology_list_restart == vk::FALSE {
                return Err(TestError::NotSupported(
                    "primitiveTopologyListRestart not supported".to_string(),
                ));
            }

            if needs_patch_restart && restart_features.primitive_topology_patch_list_restart == vk::FALSE {
                return Err(TestError::NotSupported(
                    "primitiveTopologyPatchListRestart not supported".to_string(),
                ));
            }
        }

        let features = context.get_device_features();
        if needs_patch_restart && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: tessellationShader".to_string(),
            ));
        }

        if params.needs_geometry_shader() && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: geometryShader".to_string(),
            ));
        }

        if params.draw_call == DrawCall::IndirectCount {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if params.conditional_rendering {
            context.require_device_functionality("VK_EXT_conditional_rendering")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.needs_primitive_topology_patch_list_restart() {
            RESTART_INDEX_PATCH_LIST.programs
        } else {
            RESTART_INDEX_DEFAULT.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RestartIndexInstance {
            context,
            params: self.params,
        })
    }
}

struct RestartIndexInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// `makeIndexBuffer`'s element conversion: the indices narrowed to the width of `index_type`.
fn index_bytes(indices: &[u32], index_type: vk::IndexType) -> Vec<u8> {
    if index_type == vk::IndexType::UINT32 {
        indices.iter().flat_map(|&index| index.to_ne_bytes()).collect()
    } else if index_type == vk::IndexType::UINT16 {
        indices.iter().flat_map(|&index| (index as u16).to_ne_bytes()).collect()
    } else {
        debug_assert!(index_type == vk::IndexType::UINT8);
        indices.iter().map(|&index| index as u8).collect()
    }
}

fn vec4_bytes(vertices: &[Vec4]) -> Vec<u8> {
    vertices
        .iter()
        .flat_map(|vertex| vertex.iter().flat_map(|c| c.to_ne_bytes()))
        .collect()
}

fn color_bytes(color: Vec4) -> [u8; 4] {
    color.map(|c| (c * 255.0).round() as u8)
}

/// `makeIndirectBuffer`: `total` commands where `cmd` sits at `position` and the rest are no-ops.
fn make_indirect_commands(
    cmd: vk::DrawIndexedIndirectCommand,
    position: u32,
    total: u32,
) -> Vec<vk::DrawIndexedIndirectCommand> {
    debug_assert!(position < total);
    let no_op_cmd = vk::DrawIndexedIndirectCommand {
        index_count: 0,
        instance_count: 0,
        first_index: 0,
        vertex_offset: 0,
        first_instance: 0,
    };
    let mut cmds = vec![no_op_cmd; total as usize];
    cmds[position as usize] = cmd;
    cmds
}

type SetPrimitiveRestartIndex = unsafe extern "system" fn(vk::CommandBuffer, u32);

impl TestInstance for RestartIndexInstance<'_> {
    /// `RestartIndexInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let (width, height) = EXTENT;
        let topology = params.topology;
        let block_colors = Params::block_colors();

        // See upstream's comment: 0 can be a restart index, so with a custom restart index of 0 or 1 part of the 2-vertex
        // padding is added to the indices by hand instead of through vertexOffset.
        let mut vertex_offset = 2u32;
        let mut manual_offset = 0u32;
        if params.restart_index == RestartIndex::Zero {
            vertex_offset = 1;
            manual_offset = 1;
        } else if params.restart_index == RestartIndex::One {
            std::mem::swap(&mut vertex_offset, &mut manual_offset);
        }
        debug_assert!(vertex_offset + manual_offset == PAD_VERTEX_COUNT);

        let color_buffer = ImageWithBuffer::new(
            context,
            width,
            height,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
            4,
        )?;

        let cr_buffer = if params.conditional_rendering {
            // Zero disables rendering.
            Some(create_host_buffer(
                context,
                &[0u32],
                vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
            )?)
        } else {
            None
        };

        #[allow(unused_assignments)]
        let mut vertices_per_row = 0u32;
        let mut all_vertices: Vec<Vec4> = Vec::new();
        let mut padding_vertex: Vec4 = [0.0; 4];

        let mut all_indices: Vec<u32> = Vec::new();
        let mut replaced_index = usize::MAX;
        let mut row_index_count = 0u32;
        let base_row_indices = params.get_row_indices();

        for i in 0..height {
            // Each block of rows will have alternating restart indices.
            let restart_index = params.get_restart_index_for_row(i);
            let row_vertices = params.get_row_vertices(i);
            let mut row_indices = base_row_indices.clone();

            if i == 0 {
                vertices_per_row = row_vertices.len() as u32;
                all_vertices.reserve((vertices_per_row * height) as usize);
                all_indices.reserve((height * (vertices_per_row + 1)) as usize);

                // The padding vertices and the index replaced by a restart so that the last pixel is not covered.
                if matches!(
                    topology,
                    vk::PrimitiveTopology::POINT_LIST
                        | vk::PrimitiveTopology::LINE_LIST
                        | vk::PrimitiveTopology::LINE_STRIP
                        | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
                        | vk::PrimitiveTopology::TRIANGLE_LIST
                        | vk::PrimitiveTopology::PATCH_LIST
                        | vk::PrimitiveTopology::TRIANGLE_FAN
                ) {
                    padding_vertex = *row_vertices.last().expect("a row has vertices");
                    replaced_index = row_indices.len() - 1;
                } else if matches!(
                    topology,
                    vk::PrimitiveTopology::TRIANGLE_STRIP
                        | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                        | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
                ) {
                    debug_assert!(row_vertices.len() > 1);
                    replaced_index = row_vertices.len() - 2;
                    padding_vertex = row_vertices[replaced_index];
                } else if topology == vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY {
                    debug_assert!(row_vertices.len() > 3);
                    replaced_index = row_vertices.len() - 4;
                    padding_vertex = row_vertices[replaced_index];
                } else {
                    debug_assert!(false);
                }
            }

            for v in row_indices.iter_mut() {
                *v += manual_offset;
            }

            // Make sure the last pixel is not covered.
            row_indices[replaced_index] = restart_index;

            // getRowIndices always gives 0-based indices, so shift them past the vertices of the previous rows.
            let prev_vertex_count = all_vertices.len() as u32;
            for v in row_indices.iter_mut() {
                if *v != restart_index {
                    *v += prev_vertex_count;
                }
            }

            // Append a primitive restart after each row, in any case.
            row_indices.push(restart_index);

            if row_index_count == 0 {
                row_index_count = row_indices.len() as u32;
            }

            all_vertices.extend_from_slice(&row_vertices);
            all_indices.extend_from_slice(&row_indices);
        }

        // Vertex buffer, with the extra vertices in front.
        let mut vertex_data = vec4_bytes(&vec![padding_vertex; PAD_VERTEX_COUNT as usize]);
        vertex_data.extend_from_slice(&vec4_bytes(&all_vertices));
        let vertex_buffer = create_host_buffer(context, &vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Index buffer with allIndices, but with the right bit width.
        let index_buffer = create_host_buffer(
            context,
            &index_bytes(&all_indices, params.index_type),
            vk::BufferUsageFlags::INDEX_BUFFER,
        )?;

        let needs_tess = params.needs_primitive_topology_patch_list_restart();
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let tess_modules = if needs_tess {
            Some((
                create_shader_module(device, binaries.get("tesc")?)?,
                create_shader_module(device, binaries.get("tese")?)?,
            ))
        } else {
            None
        };

        let pc_stages = vk::ShaderStageFlags::FRAGMENT;
        let pc_size = VEC4_SIZE;
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

        let render_pass = make_color_render_pass(
            device,
            COLOR_FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], width, height, 1)?;

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some((tesc, tese)) = &tess_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

        let mut state = DrawPipelineState::new(topology).with_full_viewport(width, height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: VEC4_SIZE,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        state.primitive_restart_enable = !params.dynamic_primitive_restart_enable;
        if params.dynamic_primitive_restart_enable {
            state.dynamic_states = vec![vk::DynamicState::PRIMITIVE_RESTART_ENABLE];
        }
        if needs_tess {
            state.patch_control_points = Some(3);
        }
        let mut eso_stages = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
        if needs_tess {
            eso_stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
            eso_stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
        }
        eso_stages.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
        let shader_objects = make_shader_objects_stages(context, &eso_stages, &[], &pc_ranges)?;
        let pipeline = if shader_objects.is_none() {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        } else {
            None
        };

        let set_primitive_restart_index: SetPrimitiveRestartIndex = {
            let name = c"vkCmdSetPrimitiveRestartIndexEXT";
            let function = unsafe { context.get_instance().get_device_proc_addr(device.handle(), name) }
                .ok_or_else(|| TestError::Fail("vkCmdSetPrimitiveRestartIndexEXT is not exposed by a device with VK_EXT_primitive_restart_index".to_string()))?;
            unsafe { std::mem::transmute::<unsafe extern "system" fn(), SetPrimitiveRestartIndex>(function) }
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        assert!(height % BLOCK_COUNT == 0);
        let block_rows = height / BLOCK_COUNT;
        let clear_color = Params::clear_color();
        let indices_per_draw = block_rows * row_index_count;
        let default_restart_index = params.get_default_restart_index();

        // The default index is restored in two ways: rebinding the index buffer, and an explicit reset.
        let mut reset_by_rebind = false;

        let draw_cmds: Vec<vk::DrawIndexedIndirectCommand> = (0..BLOCK_COUNT)
            .map(|i| vk::DrawIndexedIndirectCommand {
                index_count: indices_per_draw,
                instance_count: 1,
                first_index: indices_per_draw * i,
                vertex_offset: vertex_offset as i32,
                first_instance: 0,
            })
            .collect();

        // Each indirect buffer holds more than one command, and only the i-th one of block i draws: that makes the draw count
        // and stride of the indirect cases mean something.
        let indirect_stride = std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32;
        let max_count = BLOCK_COUNT * 2;
        let mut indirect_buffers = Vec::new();
        if params.draw_call != DrawCall::Direct {
            let total_items = if params.draw_call == DrawCall::IndirectCount {
                max_count
            } else {
                BLOCK_COUNT
            };
            for i in 0..BLOCK_COUNT {
                let cmds = make_indirect_commands(draw_cmds[i as usize], i, total_items);
                indirect_buffers.push(create_host_buffer(
                    context,
                    &cmds,
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
            }
        }

        let count_buffer = if params.draw_call == DrawCall::IndirectCount {
            Some(create_host_buffer(
                context,
                &[BLOCK_COUNT],
                vk::BufferUsageFlags::INDIRECT_BUFFER,
            )?)
        } else {
            None
        };

        // The render pass contents go in a primary or a secondary command buffer.
        let mut record_rp_contents = |command_buffer: vk::CommandBuffer| unsafe {
            if let Some(shader_objects) = &shader_objects {
                shader_objects.bind(command_buffer, &state);
            } else if let Some(pipeline) = &pipeline {
                device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            }
            device.cmd_bind_vertex_buffers(command_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(command_buffer, index_buffer.get(), 0, params.index_type);
            if params.dynamic_primitive_restart_enable {
                device.cmd_set_primitive_restart_enable_ext(command_buffer, true);
            }
            for i in 0..BLOCK_COUNT {
                let color_bytes: Vec<u8> = block_colors[i as usize].iter().flat_map(|c| c.to_ne_bytes()).collect();
                device.cmd_push_constants(command_buffer, pipeline_layout.get(), pc_stages, 0, &color_bytes);

                if let Some(cr_buffer) = &cr_buffer {
                    // Disabling rendering with conditional rendering must not affect setting the index.
                    let cr_begin_info = vk::ConditionalRenderingBeginInfoEXT::builder().buffer(cr_buffer.get());
                    device.cmd_begin_conditional_rendering_ext(command_buffer, &cr_begin_info);
                }

                let restart_index = params.get_restart_index_for_block(i);
                if restart_index == default_restart_index && !reset_by_rebind {
                    device.cmd_bind_index_buffer(command_buffer, index_buffer.get(), 0, params.index_type);
                    reset_by_rebind = true;
                } else {
                    set_primitive_restart_index(command_buffer, restart_index);
                }

                // With conditional rendering the first block's draw is inside the section and the later ones are outside it.
                if params.conditional_rendering && i > 0 {
                    device.cmd_end_conditional_rendering_ext(command_buffer);
                }

                let draw_cmd = draw_cmds[i as usize];
                match params.draw_call {
                    DrawCall::Direct => device.cmd_draw_indexed(
                        command_buffer,
                        draw_cmd.index_count,
                        draw_cmd.instance_count,
                        draw_cmd.first_index,
                        draw_cmd.vertex_offset,
                        draw_cmd.first_instance,
                    ),
                    DrawCall::Indirect => device.cmd_draw_indexed_indirect(
                        command_buffer,
                        indirect_buffers[i as usize].get(),
                        0,
                        BLOCK_COUNT,
                        indirect_stride,
                    ),
                    DrawCall::IndirectCount => device.cmd_draw_indexed_indirect_count(
                        command_buffer,
                        indirect_buffers[i as usize].get(),
                        0,
                        count_buffer
                            .as_ref()
                            .expect("the count buffer exists for indirect count draws")
                            .get(),
                        0,
                        max_count,
                        indirect_stride,
                    ),
                }

                if params.conditional_rendering && i == 0 {
                    device.cmd_end_conditional_rendering_ext(command_buffer);
                }
            }
        };

        let secondary_cmd_buffer = if params.secondary_cmd {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };
        if let Some(secondary) = &secondary_cmd_buffer {
            let sec_cmd = **secondary;
            let color_formats = [COLOR_FORMAT];
            let mut inheritance_rendering = vk::CommandBufferInheritanceRenderingInfo::builder()
                .color_attachment_formats(&color_formats)
                .rasterization_samples(vk::SampleCountFlags::_1);
            let mut inheritance = vk::CommandBufferInheritanceInfo::builder().occlusion_query_enable(false);
            if shader_objects.is_some() {
                inheritance = inheritance.push_next(&mut inheritance_rendering);
            } else {
                inheritance = inheritance
                    .render_pass(*render_pass)
                    .subpass(0)
                    .framebuffer(*framebuffer);
            }
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance);
            unsafe { device.begin_command_buffer(sec_cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
            record_rp_contents(sec_cmd);
            end_command_buffer(device, sec_cmd)?;
        }

        begin_command_buffer(device, cmd)?;
        let subpass_contents = if params.secondary_cmd {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };
        let clear_values = [clear_value_color(clear_color)];
        let render_pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(width, height))
            .clear_values(&clear_values);
        if shader_objects.is_some() {
            let barrier = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(color_buffer.image.get())
                .subresource_range(vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                })
                .build();
            let color_attachments = [vk::RenderingAttachmentInfo::builder()
                .image_view(*color_buffer.view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_values[0])
                .build()];
            let rendering_info = vk::RenderingInfo::builder()
                .flags(if params.secondary_cmd {
                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                } else {
                    vk::RenderingFlags::empty()
                })
                .render_area(rect_2d(width, height))
                .layer_count(1)
                .color_attachments(&color_attachments);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
                device.cmd_begin_rendering(cmd, &rendering_info);
            }
        } else {
            unsafe { device.cmd_begin_render_pass(cmd, &render_pass_begin, subpass_contents) };
        }
        if let Some(secondary) = &secondary_cmd_buffer {
            unsafe { device.cmd_execute_commands(cmd, &[**secondary]) };
        } else {
            record_rp_contents(cmd);
        }
        if shader_objects.is_some() {
            unsafe { device.cmd_end_rendering(cmd) };
        } else {
            unsafe { device.cmd_end_render_pass(cmd) };
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            width,
            height,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = color_buffer.read_bytes(device)?;

        let mut reference = vec![0u8; (width * height * 4) as usize];
        for b in 0..BLOCK_COUNT {
            let color = block_colors[b as usize];
            for r in 0..block_rows {
                let y = b * block_rows + r;
                for x in 0..width {
                    // The draws of the first block are disabled when using conditional rendering.
                    let expected = if x < width - 1 && (!params.conditional_rendering || b > 0) {
                        color
                    } else {
                        clear_color
                    };
                    let offset = ((y * width + x) * 4) as usize;
                    reference[offset..offset + 4].copy_from_slice(&color_bytes(expected));
                }
            }
        }

        if result != reference.as_slice() {
            return Ok(TestStatus::fail(
                "Unexpected results found in color buffer; check log for details --",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn topology_simple_name(topology: vk::PrimitiveTopology) -> &'static str {
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

fn index_type_simple_name(index_type: vk::IndexType) -> &'static str {
    if index_type == vk::IndexType::UINT32 {
        "uint32_index"
    } else if index_type == vk::IndexType::UINT16 {
        "uint16_index"
    } else {
        "uint8_index"
    }
}

fn restart_index_name(restart_index: RestartIndex) -> &'static str {
    match restart_index {
        RestartIndex::Zero => "zero",
        RestartIndex::One => "one",
        RestartIndex::Penultimate => "max_minus_one",
        RestartIndex::Max => "max",
    }
}

fn draw_call_name(draw_call: DrawCall) -> &'static str {
    match draw_call {
        DrawCall::Direct => "draw_indexed",
        DrawCall::Indirect => "draw_indexed_indirect",
        DrawCall::IndirectCount => "draw_indexed_indirect_count",
    }
}

const TOPOLOGIES: [vk::PrimitiveTopology; 11] = [
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
    vk::PrimitiveTopology::PATCH_LIST,
];

const INDEX_TYPES: [vk::IndexType; 3] = [vk::IndexType::UINT32, vk::IndexType::UINT16, vk::IndexType::UINT8];

const RESTART_INDICES: [RestartIndex; 4] = [
    RestartIndex::Zero,
    RestartIndex::One,
    RestartIndex::Penultimate,
    RestartIndex::Max,
];

const DRAW_CALLS: [DrawCall; 3] = [DrawCall::Direct, DrawCall::Indirect, DrawCall::IndirectCount];

fn dyn_suffix(dynamic_primitive_restart_enable: bool) -> &'static str {
    if dynamic_primitive_restart_enable {
        "_dyn_prim_restart"
    } else {
        ""
    }
}

/// `createPrimitiveRestartIndexTests` for `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`.
pub fn create_primitive_restart_index_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("primitive_restart_index");

    for topology in TOPOLOGIES {
        let mut topology_group = TestCaseGroup::new(topology_simple_name(topology));
        for index_type in INDEX_TYPES {
            let mut index_type_group = TestCaseGroup::new(index_type_simple_name(index_type));
            for restart_index in RESTART_INDICES {
                for draw_call in DRAW_CALLS {
                    for dynamic_primitive_restart_enable in [false, true] {
                        let params = Params {
                            topology,
                            index_type,
                            restart_index,
                            draw_call,
                            dynamic_primitive_restart_enable,
                            conditional_rendering: false,
                            secondary_cmd: false,
                        };
                        let name = format!(
                            "custom_index_{}_{}{}",
                            restart_index_name(restart_index),
                            draw_call_name(draw_call),
                            dyn_suffix(dynamic_primitive_restart_enable)
                        );
                        index_type_group.add_child(Box::new(RestartIndexCase { name, params }) as Box<dyn TestCase>);
                    }
                }
            }
            topology_group.add_child(index_type_group);
        }
        main_group.add_child(topology_group);
    }

    let mut secondaries_group = TestCaseGroup::new("secondary_cmd");
    for draw_call in DRAW_CALLS {
        for dynamic_primitive_restart_enable in [false, true] {
            let params = Params {
                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                index_type: vk::IndexType::UINT16,
                restart_index: RestartIndex::One,
                draw_call,
                dynamic_primitive_restart_enable,
                conditional_rendering: false,
                secondary_cmd: true,
            };
            let name = format!(
                "{}{}",
                draw_call_name(draw_call),
                dyn_suffix(dynamic_primitive_restart_enable)
            );
            secondaries_group.add_child(Box::new(RestartIndexCase { name, params }) as Box<dyn TestCase>);
        }
    }
    main_group.add_child(secondaries_group);

    let mut cr_group = TestCaseGroup::new("conditional_rendering");
    for draw_call in DRAW_CALLS {
        for dynamic_primitive_restart_enable in [false, true] {
            // Some of these also run in secondary command buffers.
            for use_secondaries in [false, true] {
                let params = Params {
                    topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                    index_type: vk::IndexType::UINT32,
                    restart_index: RestartIndex::Zero,
                    draw_call,
                    dynamic_primitive_restart_enable,
                    conditional_rendering: true,
                    secondary_cmd: use_secondaries,
                };
                let name = format!(
                    "{}{}{}",
                    draw_call_name(draw_call),
                    dyn_suffix(dynamic_primitive_restart_enable),
                    if use_secondaries { "_secondary_cmd" } else { "" }
                );
                cr_group.add_child(Box::new(RestartIndexCase { name, params }) as Box<dyn TestCase>);
            }
        }
    }
    main_group.add_child(cr_group);

    main_group
}
