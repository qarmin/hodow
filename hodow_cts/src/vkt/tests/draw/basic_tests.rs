// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktBasicDrawTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four draw commands are the variants of one enum rather than
// four specialisations of a class template. The `misc` group has the `maintenance5` case here (`DrawCaseParams::use_maintenance5`) and
// `flat_b_sat_error` in `misc_tests.rs`, where the Amber script is written out.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_basic_draw::BASIC_DRAW;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::rr::renderer::{DrawCommand, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::vector::Vec4;
use crate::tcu::{
    ChannelOrder, ChannelType, Random, TestError, TestOutcome, TestStatus, TextureFormat, UVec4, de_string_hash,
};
use crate::vk::obj_util::BufferWithMemory;
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::conditional_rendering::test_util::check_nested_render_pass_capabilities;
use crate::vkt::tests::draw::base_class::{
    DrawTestsBase, GroupParams, VertexInput, create_host_buffer, create_host_buffer_maintenance5,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SEED: u32 = 0xc2a39f;
const INDEX_LIMIT: i32 = 10000;
// To avoid too big and mostly empty structures
const OFFSET_LIMIT: i32 = 1000;
// Number of primitives to draw
const PRIMITIVE_COUNT: [u32; 4] = [1, 3, 17, 45];

const WIDTH: u32 = 256;
const HEIGHT: u32 = 256;

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCommandType {
    Draw,
    DrawIndexed,
    DrawIndirect,
    DrawIndexedIndirect,
}

const ALL_COMMANDS: [DrawCommandType; 4] = [
    DrawCommandType::Draw,
    DrawCommandType::DrawIndexed,
    DrawCommandType::DrawIndirect,
    DrawCommandType::DrawIndexedIndirect,
];

/// `getDrawCommandTypeName`
fn get_draw_command_type_name(command: DrawCommandType) -> &'static str {
    match command {
        DrawCommandType::Draw => "draw",
        DrawCommandType::DrawIndexed => "draw_indexed",
        DrawCommandType::DrawIndirect => "draw_indirect",
        DrawCommandType::DrawIndexedIndirect => "draw_indexed_indirect",
    }
}

/// The topologies `createDrawTests` iterates, `VK_PRIMITIVE_TOPOLOGY_POINT_LIST` up to (excluding) `PATCH_LIST`, with
/// the group name `de::toLower(getPrimitiveTopologyName(topology)).substr(22)`.
const TOPOLOGIES: [(vk::PrimitiveTopology, &str); 10] = [
    (vk::PrimitiveTopology::POINT_LIST, "point_list"),
    (vk::PrimitiveTopology::LINE_LIST, "line_list"),
    (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
    (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
    (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
    (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
    (
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        "line_list_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        "line_strip_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        "triangle_list_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        "triangle_strip_with_adjacency",
    ),
];

/// `mapVkPrimitiveTopology`
fn map_vk_primitive_topology(topology: vk::PrimitiveTopology) -> PrimitiveType {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => PrimitiveType::Points,
        vk::PrimitiveTopology::LINE_LIST => PrimitiveType::Lines,
        vk::PrimitiveTopology::LINE_STRIP => PrimitiveType::LineStrip,
        vk::PrimitiveTopology::TRIANGLE_LIST => PrimitiveType::Triangles,
        vk::PrimitiveTopology::TRIANGLE_FAN => PrimitiveType::TriangleFan,
        vk::PrimitiveTopology::TRIANGLE_STRIP => PrimitiveType::TriangleStrip,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => PrimitiveType::LinesAdjacency,
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => PrimitiveType::LineStripAdjacency,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => PrimitiveType::TrianglesAdjacency,
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => PrimitiveType::TriangleStripAdjacency,
        _ => unreachable!("topology not used by the basic draw tests"),
    }
}

/// `isSimpleListTopology`
fn is_simple_list_topology(topology: vk::PrimitiveTopology) -> bool {
    matches!(
        topology,
        vk::PrimitiveTopology::POINT_LIST | vk::PrimitiveTopology::LINE_LIST | vk::PrimitiveTopology::TRIANGLE_LIST
    )
}

/// `verticesPerPrimitive`
fn vertices_per_primitive(topology: vk::PrimitiveTopology) -> u32 {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => 1,
        vk::PrimitiveTopology::LINE_LIST => 2,
        vk::PrimitiveTopology::TRIANGLE_LIST => 3,
        _ => unreachable!("not a simple list topology"),
    }
}

/// What differs between the four draw commands: the parameters of the command(s) themselves.
#[derive(Clone)]
enum DrawKind {
    /// `DrawParams` - `vkCmdDraw`'s parameters are like a single `VkDrawIndirectCommand`.
    Draw { params: vk::DrawIndirectCommand },
    /// `DrawIndexedParams` - `vkCmdDrawIndexed`'s parameters are like a single `VkDrawIndexedIndirectCommand`.
    DrawIndexed {
        params: vk::DrawIndexedIndirectCommand,
        multiple_draws: bool,
    },
    /// `DrawIndirectParams`
    DrawIndirect {
        commands: Vec<vk::DrawIndirectCommand>,
        multi_draw: bool,
    },
    /// `DrawIndexedIndirectParams`
    DrawIndexedIndirect {
        commands: Vec<vk::DrawIndexedIndirectCommand>,
        multi_draw: bool,
    },
}

#[derive(Clone)]
struct DrawCaseParams {
    topology: vk::PrimitiveTopology,
    group_params: GroupParams,
    kind: DrawKind,
    use_maintenance5: bool,
}

struct DrawCase {
    name: String,
    params: DrawCaseParams,
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if matches!(
            params.topology,
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY
        ) && context.get_device_features().geometry_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: geometryShader".to_string(),
            ));
        }

        if params.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if params.group_params.nested_secondary_cmd_buffer {
            check_nested_render_pass_capabilities(context)?;
        }

        // Parameter-specific support checks.
        let multi_draw_needed = match &params.kind {
            DrawKind::DrawIndirect { commands, multi_draw } => *multi_draw && commands.len() > 1,
            DrawKind::DrawIndexedIndirect { commands, multi_draw } => *multi_draw && commands.len() > 1,
            _ => false,
        };
        if multi_draw_needed && context.get_device_features().multi_draw_indirect == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: multiDrawIndirect".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BASIC_DRAW.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawTestInstance {
            context,
            params: self.params.clone(),
        })
    }
}

fn buffer<'a, T: Copy>(
    context: &'a Context<'a>,
    data: &[T],
    usage: vk::BufferUsageFlags,
    usage2: vk::BufferUsageFlags2,
    use_maintenance5: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    if use_maintenance5 {
        create_host_buffer_maintenance5(context, data, usage2)
    } else {
        create_host_buffer(context, data, usage)
    }
}

/// `PositionColorVertex`
#[derive(Clone, Copy)]
struct PositionColorVertex {
    position: [f32; 4],
    color: [f32; 4],
}

impl PositionColorVertex {
    const ZERO: Self = Self {
        position: [0.0; 4],
        color: [0.0; 4],
    };

    fn as_floats(&self) -> [f32; 8] {
        let p = self.position;
        let c = self.color;
        [p[0], p[1], p[2], p[3], c[0], c[1], c[2], c[3]]
    }
}

/// The vertex and index data `DrawTestInstance<T>::generateDrawData` builds.
struct DrawData {
    vertices: Vec<PositionColorVertex>,
    indexes: Vec<u32>,
}

/// One randomly placed vertex: `(f0, f1, 1, 1)` and `tcu::randomVec4`.
fn random_vertex(rnd: &mut Random) -> PositionColorVertex {
    let f0 = rnd.get_float_range(-1.0, 1.0);
    let f1 = rnd.get_float_range(-1.0, 1.0);
    let color = [
        rnd.get_float_range(0.0, 1.0),
        rnd.get_float_range(0.0, 1.0),
        rnd.get_float_range(0.0, 1.0),
        rnd.get_float_range(0.0, 1.0),
    ];
    PositionColorVertex {
        position: [f0, f1, 1.0, 1.0],
        color,
    }
}

/// `DrawTestInstance<T>::generateDrawData`
fn generate_draw_data(kind: &DrawKind) -> DrawData {
    match kind {
        DrawKind::Draw { params } => {
            let mut rnd = Random::new(SEED ^ params.first_vertex ^ params.vertex_count);

            let vector_size = (params.first_vertex + params.vertex_count) as usize;

            // Initialize the vector
            let mut vertices = vec![PositionColorVertex::ZERO; vector_size];

            // Fill only the used indexes
            for vertex in &mut vertices[params.first_vertex as usize..] {
                *vertex = random_vertex(&mut rnd);
            }
            DrawData {
                vertices,
                indexes: Vec::new(),
            }
        }
        DrawKind::DrawIndexed { params, .. } => {
            let mut rnd = Random::new(SEED ^ params.first_index ^ params.index_count);
            let index_size = (params.first_index + params.index_count) as usize;

            let mut indexes = vec![0u32; index_size];

            let mut highest_index = 0u32; // Store to highest index to calculate the vertices size
            for idx in 0..params.index_count {
                let vertex_idx = rnd.get_int(params.vertex_offset, INDEX_LIMIT) as u32;
                highest_index = highest_index.max(vertex_idx);

                indexes[(params.first_index + idx) as usize] = vertex_idx;
            }

            let mut vertices =
                vec![PositionColorVertex::ZERO; params.vertex_offset as usize + highest_index as usize + 1];

            for &index in &indexes[params.first_index as usize..] {
                vertices[params.vertex_offset as usize + index as usize] = random_vertex(&mut rnd);
            }
            DrawData { vertices, indexes }
        }
        DrawKind::DrawIndirect { commands, .. } => {
            let mut rnd = Random::new(SEED ^ commands[0].vertex_count ^ commands[0].first_vertex);

            let last_index = commands
                .iter()
                .map(|command| command.first_vertex + command.vertex_count)
                .max()
                .unwrap_or(0);

            let mut vertices = vec![PositionColorVertex::ZERO; last_index as usize];

            for command in commands {
                for idx in 0..command.vertex_count {
                    vertices[(command.first_vertex + idx) as usize] = random_vertex(&mut rnd);
                }
            }
            DrawData {
                vertices,
                indexes: Vec::new(),
            }
        }
        DrawKind::DrawIndexedIndirect { commands, .. } => {
            let mut rnd = Random::new(SEED ^ commands[0].first_index ^ commands[0].index_count);

            // Get the maximum range of indexes
            let last_index = commands
                .iter()
                .map(|command| command.first_index + command.index_count)
                .max()
                .unwrap_or(0);

            // Initialize the vector with zeros
            let mut indexes = vec![0u32; last_index as usize];

            let mut highest_index = 0u32;

            // Generate random indexes for the ranges
            for command in commands {
                for idx in 0..command.index_count {
                    let vertex_idx = rnd.get_int(command.vertex_offset, INDEX_LIMIT) as u32;
                    let max_index = vertex_idx.wrapping_add(command.vertex_offset as u32);

                    highest_index = highest_index.max(max_index);
                    indexes[(command.first_index + idx) as usize] = vertex_idx;
                }
            }

            // Initialize the vertex vector
            let mut vertices = vec![PositionColorVertex::ZERO; highest_index as usize + 1];

            // Generate random vertices in the used locations
            for command in commands {
                for idx in command.first_index..command.first_index + command.index_count {
                    vertices[(command.vertex_offset as u32 + indexes[idx as usize]) as usize] = random_vertex(&mut rnd);
                }
            }
            DrawData { vertices, indexes }
        }
    }
}

/// `PassthruVertShader`
struct PassthruVertShader {
    inputs: [VertexInputInfo; 2],
    outputs: [VertexOutputInfo; 1],
}

impl PassthruVertShader {
    fn new() -> Self {
        Self {
            inputs: [
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
            ],
            outputs: [VertexOutputInfo {
                type_: Some(GenericVecType::Float),
                flatshade: false,
            }],
        }
    }
}

impl VertexShader for PassthruVertShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        &self.outputs
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: both attributes point at the vectors `generate_ref_image` keeps alive across the draw.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
            }
            packet.position = position;
            packet.outputs[0] = GenericVec4::from_float(color);
        }
    }
}

/// `PassthruFragShader`
struct PassthruFragShader {
    inputs: [FragmentInputInfo; 1],
    outputs: [FragmentOutputInfo; 1],
}

impl PassthruFragShader {
    fn new() -> Self {
        Self {
            inputs: [FragmentInputInfo {
                type_: Some(GenericVecType::Float),
                flatshade: false,
            }],
            outputs: [FragmentOutputInfo {
                type_: Some(GenericVecType::Float),
            }],
        }
    }
}

impl FragmentShader for PassthruFragShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    let color = read_varying(&packets[packet_ndx], context, 0, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(color),
                    );
                }
            }
        }
    }
}

/// `DrawTestInstanceBase::generateRefImage`
fn generate_ref_image(
    ref_image: &mut TextureLevel,
    vertices: &[[f32; 4]],
    colors: &[[f32; 4]],
    topology: vk::PrimitiveTopology,
    sub_pixel_bits: u32,
) {
    let vert_shader = PassthruVertShader::new();
    let frag_shader = PassthruFragShader::new();
    let program = Program {
        vertex_shader: &vert_shader,
        fragment_shader: &frag_shader,
        geometry_shader: None,
    };
    let mut render_target = RenderTarget::new(as_multisample_view(ref_image.get_access()), None, None);
    let render_state = RenderState::new(
        ViewportState::from_target_size(WIDTH as i32, HEIGHT as i32),
        sub_pixel_bits as i32,
    );
    let renderer = Renderer::new();

    let vertex_attribs = [
        VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, vertices.as_ptr().cast::<u8>()),
        VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, colors.as_ptr().cast::<u8>()),
    ];

    let primitives = PrimitiveList::from_arrays(map_vk_primitive_topology(topology), vertices.len(), 0);
    let command = DrawCommand {
        state: &render_state,
        program: &program,
        vertex_attribs: &vertex_attribs,
        primitives: &primitives,
    };
    renderer.draw(&command, &mut render_target);
}

/// `imageCompare`
fn image_compare(
    reference: &TextureLevel,
    result: &TextureLevel,
    topology: vk::PrimitiveTopology,
) -> Result<bool, TestError> {
    if topology == vk::PrimitiveTopology::POINT_LIST {
        Ok(int_threshold_position_deviation_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            UVec4::new(4, 4, 4, 4), // color threshold
            [1, 1, 0],              // position deviation tolerance
            true,                   // don't check the pixels at the boundary
        ))
    } else {
        fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.053)
            .ok_or_else(|| TestError::NotPorted("fuzzy comparison of this format".to_string()))
    }
}

/// `DrawTestInstance<T>`
struct DrawTestInstance<'a> {
    context: &'a Context<'a>,
    params: DrawCaseParams,
}

impl TestInstance for DrawTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = &self.params;

        let data = generate_draw_data(&params.kind);

        // `DrawTestInstanceBase::initialize`
        let base = DrawTestsBase::new_with_maintenance5(
            context,
            "vert",
            "frag",
            params.group_params,
            params.topology,
            1,
            WIDTH,
            HEIGHT,
            VertexInput::Custom {
                bindings: vec![vk::VertexInputBindingDescription {
                    binding: 0,
                    stride: 32,
                    input_rate: vk::VertexInputRate::VERTEX,
                }],
                attributes: vec![
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
                ],
            },
            &[],
            params.use_maintenance5,
        )?;

        let vertex_floats: Vec<[f32; 8]> = data.vertices.iter().map(PositionColorVertex::as_floats).collect();
        let vertex_buffer = buffer(
            context,
            &vertex_floats,
            vk::BufferUsageFlags::VERTEX_BUFFER,
            vk::BufferUsageFlags2::VERTEX_BUFFER,
            params.use_maintenance5,
        )?;
        let index_buffer = match &params.kind {
            DrawKind::DrawIndexed { .. } | DrawKind::DrawIndexedIndirect { .. } => Some(buffer(
                context,
                &data.indexes,
                vk::BufferUsageFlags::INDEX_BUFFER,
                vk::BufferUsageFlags2::INDEX_BUFFER,
                params.use_maintenance5,
            )?),
            _ => None,
        };
        let indirect_buffer = match &params.kind {
            DrawKind::DrawIndirect { commands, .. } => Some(buffer(
                context,
                commands,
                vk::BufferUsageFlags::INDIRECT_BUFFER,
                vk::BufferUsageFlags2::INDIRECT_BUFFER,
                params.use_maintenance5,
            )?),
            DrawKind::DrawIndexedIndirect { commands, .. } => Some(buffer(
                context,
                commands,
                vk::BufferUsageFlags::INDIRECT_BUFFER,
                vk::BufferUsageFlags2::INDIRECT_BUFFER,
                params.use_maintenance5,
            )?),
            _ => None,
        };

        base.record_and_submit(queue, |cmd| {
            unsafe {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                if let Some(index_buffer) = &index_buffer {
                    device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT32);
                }

                match &params.kind {
                    DrawKind::Draw { params } => device.cmd_draw(
                        cmd,
                        params.vertex_count,
                        params.instance_count,
                        params.first_vertex,
                        params.first_instance,
                    ),
                    DrawKind::DrawIndexed {
                        params: draw,
                        multiple_draws,
                    } => {
                        let count_per_draw = if *multiple_draws {
                            vertices_per_primitive(self.params.topology)
                        } else {
                            draw.index_count
                        };
                        let mut index_count = 0;
                        while index_count < draw.index_count {
                            device.cmd_draw_indexed(
                                cmd,
                                count_per_draw,
                                draw.instance_count,
                                draw.first_index + index_count,
                                draw.vertex_offset,
                                draw.first_instance,
                            );
                            index_count += count_per_draw;
                        }
                    }
                    DrawKind::DrawIndirect { commands, multi_draw } => {
                        let indirect = indirect_buffer.as_ref().expect("indirect buffer").get();
                        let stride = std::mem::size_of::<vk::DrawIndirectCommand>() as u32;
                        if *multi_draw {
                            device.cmd_draw_indirect(cmd, indirect, 0, commands.len() as u32, stride);
                        } else {
                            // Use multiple single draws.
                            for cmd_idx in 0..commands.len() {
                                device.cmd_draw_indirect(
                                    cmd,
                                    indirect,
                                    (cmd_idx * stride as usize) as vk::DeviceSize,
                                    1,
                                    stride,
                                );
                            }
                        }
                    }
                    DrawKind::DrawIndexedIndirect { commands, multi_draw } => {
                        let indirect = indirect_buffer.as_ref().expect("indirect buffer").get();
                        let stride = std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32;
                        if *multi_draw {
                            device.cmd_draw_indexed_indirect(cmd, indirect, 0, commands.len() as u32, stride);
                        } else {
                            // Use multiple single draws.
                            for cmd_idx in 0..commands.len() {
                                device.cmd_draw_indexed_indirect(
                                    cmd,
                                    indirect,
                                    (cmd_idx * stride as usize) as vk::DeviceSize,
                                    1,
                                    stride,
                                );
                            }
                        }
                    }
                }
            }
            Ok(())
        })?;

        // Reference image
        let sub_pixel_bits = context.get_device_properties().limits.sub_pixel_precision_bits;
        let mut ref_image = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            WIDTH,
            HEIGHT,
            1,
        )?;
        {
            let mut access = ref_image.get_access();
            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }

        let positions_and_colors =
            |vertices: &mut dyn Iterator<Item = &PositionColorVertex>| -> (Vec<[f32; 4]>, Vec<[f32; 4]>) {
                let mut positions = Vec::new();
                let mut colors = Vec::new();
                for vertex in vertices {
                    positions.push(vertex.position);
                    colors.push(vertex.color);
                }
                (positions, colors)
            };

        match &params.kind {
            DrawKind::Draw { params: draw } => {
                let (vertices, colors) = positions_and_colors(&mut data.vertices[draw.first_vertex as usize..].iter());
                generate_ref_image(&mut ref_image, &vertices, &colors, params.topology, sub_pixel_bits);
            }
            DrawKind::DrawIndexed { params: draw, .. } => {
                let mut selected = Vec::new();
                for &index in &data.indexes[draw.first_index as usize..] {
                    selected.push(data.vertices[(draw.vertex_offset as u32 + index) as usize]);
                }
                let (vertices, colors) = positions_and_colors(&mut selected.iter());
                generate_ref_image(&mut ref_image, &vertices, &colors, params.topology, sub_pixel_bits);
            }
            DrawKind::DrawIndirect { commands, .. } => {
                for command in commands {
                    let first = command.first_vertex as usize;
                    let (vertices, colors) =
                        positions_and_colors(&mut data.vertices[first..first + command.vertex_count as usize].iter());
                    generate_ref_image(&mut ref_image, &vertices, &colors, params.topology, sub_pixel_bits);
                }
            }
            DrawKind::DrawIndexedIndirect { commands, .. } => {
                for command in commands {
                    let mut selected = Vec::new();
                    for idx in 0..command.index_count {
                        let vertex_index =
                            command.vertex_offset as u32 + data.indexes[(command.first_index + idx) as usize];
                        selected.push(data.vertices[vertex_index as usize]);
                    }
                    let (vertices, colors) = positions_and_colors(&mut selected.iter());
                    generate_ref_image(&mut ref_image, &vertices, &colors, params.topology, sub_pixel_bits);
                }
            }
        }

        let rendered_frame = base.read_color_surface(queue, vk::ImageLayout::GENERAL)?;

        if !image_compare(&ref_image, &rendered_frame, params.topology)? {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `populateSubGroup`
fn populate_sub_group(
    group_name: &str,
    command: DrawCommandType,
    topology: vk::PrimitiveTopology,
    group_params: GroupParams,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(group_name);
    let mut rnd = Random::new(SEED ^ de_string_hash(group_name));
    let primitive_count_arr_length = PRIMITIVE_COUNT.len();

    for (primitive_count_idx, &primitives) in PRIMITIVE_COUNT.iter().enumerate() {
        // when testing VK_KHR_dynamic_rendering there is no need to duplicate tests for all primitive counts; use just 1 and 45
        if group_params.use_dynamic_rendering
            && primitive_count_idx != 0
            && primitive_count_idx != primitive_count_arr_length - 1
        {
            continue;
        }

        let mut multiplier = 1;
        let mut offset = 0;
        // Calculated by Vulkan 23.1
        match topology {
            vk::PrimitiveTopology::POINT_LIST => {}
            vk::PrimitiveTopology::LINE_LIST => multiplier = 2,
            vk::PrimitiveTopology::LINE_STRIP => {}
            vk::PrimitiveTopology::TRIANGLE_LIST => multiplier = 3,
            vk::PrimitiveTopology::TRIANGLE_STRIP => {}
            vk::PrimitiveTopology::TRIANGLE_FAN => offset = 1,
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
                multiplier = 4;
                offset = 1;
            }
            vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => offset = 1,
            vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => multiplier = 6,
            vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => multiplier = 2,
            _ => unreachable!("Unsupported topology."),
        }

        let vertex_count = multiplier * primitives + offset;
        let name = primitives.to_string();

        let mut add = |name: String, kind: DrawKind| {
            group.add_child(Box::new(DrawCase {
                name,
                params: DrawCaseParams {
                    topology,
                    group_params,
                    kind,
                    use_maintenance5: false,
                },
            }) as Box<dyn TestCase>);
        };

        match command {
            DrawCommandType::Draw => {
                let first_primitive = rnd.get_int(0, primitives as i32) as u32;
                let first_vertex = multiplier * first_primitive;
                add(
                    name,
                    DrawKind::Draw {
                        params: vk::DrawIndirectCommand {
                            vertex_count,
                            instance_count: 1,
                            first_vertex,
                            first_instance: 0,
                        },
                    },
                );
            }
            DrawCommandType::DrawIndexed => {
                let first_index = rnd.get_int(0, OFFSET_LIMIT) as u32;
                let vertex_offset = rnd.get_int(0, OFFSET_LIMIT);

                let draw = vk::DrawIndexedIndirectCommand {
                    index_count: vertex_count,
                    instance_count: 1,
                    first_index,
                    vertex_offset,
                    first_instance: 0,
                };
                add(
                    name.clone(),
                    DrawKind::DrawIndexed {
                        params: draw,
                        multiple_draws: false,
                    },
                );

                if is_simple_list_topology(topology) && primitives > 1 {
                    add(
                        format!("{name}_multi_command"),
                        DrawKind::DrawIndexed {
                            params: draw,
                            multiple_draws: true,
                        },
                    );
                }
            }
            DrawCommandType::DrawIndirect => {
                let first_vertex = rnd.get_int(0, OFFSET_LIMIT) as u32;

                let mut commands = vec![vk::DrawIndirectCommand {
                    vertex_count,
                    instance_count: 1,
                    first_vertex: 0,
                    first_instance: 0,
                }];
                add(
                    format!("{name}_single_command"),
                    DrawKind::DrawIndirect {
                        commands: commands.clone(),
                        multi_draw: false,
                    },
                );

                commands.push(vk::DrawIndirectCommand {
                    vertex_count,
                    instance_count: 1,
                    first_vertex,
                    first_instance: 0,
                });
                add(
                    format!("{name}_multi_command"),
                    DrawKind::DrawIndirect {
                        commands: commands.clone(),
                        multi_draw: false,
                    },
                );

                add(
                    format!("{name}_multi_command_multi_draw"),
                    DrawKind::DrawIndirect {
                        commands,
                        multi_draw: true,
                    },
                );
            }
            DrawCommandType::DrawIndexedIndirect => {
                let first_index = rnd.get_int(vertex_count as i32, OFFSET_LIMIT) as u32;
                let vertex_offset = rnd.get_int(vertex_count as i32, OFFSET_LIMIT);

                let mut commands = vec![vk::DrawIndexedIndirectCommand {
                    index_count: vertex_count,
                    instance_count: 1,
                    first_index: 0,
                    vertex_offset: 0,
                    first_instance: 0,
                }];
                add(
                    format!("{name}_single_command"),
                    DrawKind::DrawIndexedIndirect {
                        commands: commands.clone(),
                        multi_draw: false,
                    },
                );

                commands.push(vk::DrawIndexedIndirectCommand {
                    index_count: vertex_count,
                    instance_count: 1,
                    first_index,
                    vertex_offset,
                    first_instance: 0,
                });
                add(
                    format!("{name}_multi_command"),
                    DrawKind::DrawIndexedIndirect {
                        commands: commands.clone(),
                        multi_draw: false,
                    },
                );

                add(
                    format!("{name}_multi_command_multi_draw"),
                    DrawKind::DrawIndexedIndirect {
                        commands,
                        multi_draw: true,
                    },
                );
            }
        }
    }
    group
}

/// `createBasicDrawTests`
pub fn create_basic_draw_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("basic_draw");

    for (draw_type_index, command) in ALL_COMMANDS.into_iter().enumerate() {
        let mut topology_group = TestCaseGroup::new(get_draw_command_type_name(command));

        for (topology_idx, (topology, group_name)) in TOPOLOGIES.into_iter().enumerate() {
            // reduce number of tests for dynamic rendering cases where secondary command buffer is used
            if group_params.use_secondary_cmd_buffer && topology_idx % 2 != 0 {
                continue;
            }

            if group_params.nested_secondary_cmd_buffer && draw_type_index != 0 {
                continue;
            }

            // Testcases with a specific topology.
            topology_group.add_child(populate_sub_group(group_name, command, topology, group_params));
        }

        group.add_child(topology_group);
    }

    let mut misc = TestCaseGroup::new("misc");
    if !group_params.use_dynamic_rendering {
        let commands = vec![vk::DrawIndexedIndirectCommand {
            index_count: 4,
            instance_count: 1,
            first_index: 0,
            vertex_offset: 0,
            first_instance: 0,
        }];
        let params = DrawCaseParams {
            topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
            group_params,
            kind: DrawKind::DrawIndexedIndirect {
                commands,
                multi_draw: false,
            },
            use_maintenance5: true,
        };
        misc.add_child(Box::new(DrawCase {
            name: "maintenance5".to_string(),
            params,
        }) as Box<dyn TestCase>);
        misc.add_child(super::misc_tests::create_flat_b_sat_error_case());
    }
    group.add_child(misc);
    group
}
