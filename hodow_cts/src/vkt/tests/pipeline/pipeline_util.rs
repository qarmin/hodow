// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineReferenceRenderer.cpp / .hpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexUtil.cpp / .hpp (the vertex types and `createOverlappingQuads`)
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineClearUtil.cpp / .hpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineImageUtil.cpp (`readColorAttachment`, `readDepthAttachment`,
//   `readStencilAttachment`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The reference renderer is single-sampled only (its `numSamples`
// parameter and the resolve buffers are not ported), only the colour/position vertex type has a `draw`, and the
// dual-source and texture-coordinate shaders are left out until a group needs them. The attachment readers take the
// default queue and allocator of the Context.
//
// Shared by the pipeline groups that compare a draw against a software rendering: the vertex data, the two shaders the
// software renderer runs, the default clear values, and the readback of a rendered image.

use vulkanalia::prelude::v1_0::*;

use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{BlendEquation, BlendFunc, RenderState, StencilOp, TestFunc, ViewportState};
use crate::rr::renderer::{DrawCommand, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{
    FragmentShadingContext, read_varying, write_fragment_depth, write_fragment_output,
    write_fragment_output_dual_source,
};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, PixelBufferAccess, TextureLevel, clear, clear_depth, clear_int,
    clear_stencil, effective_depth_stencil_level_access, get_texture_format_info, split_combined_depth_stencil_mut,
};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::vector::Vec4;
use crate::tcu::{TestError, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::ref_util::Unique;
use crate::vkt::Context;

/// `Vertex4RGBA`
#[derive(Clone, Copy)]
#[repr(C)]
pub struct Vertex4Rgba {
    pub position: [f32; 4],
    pub color: [f32; 4],
}

/// `createOverlappingQuads` - four overlapping quads along the plane Z = 0, X and Y between -1 and 1. Each quad covers one
/// quadrant of the scene and extends partly into the other three; the triangles of each quad have different winding orders.
pub fn create_overlapping_quads() -> Vec<Vertex4Rgba> {
    let translations = [[-0.25f32, -0.25], [-1.0, -0.25], [-1.0, -1.0], [-0.25, -1.0]];
    let quad_colors = [
        [1.0f32, 0.0, 0.0, 1.0],
        [0.0, 1.0, 0.0, 1.0],
        [0.0, 0.0, 1.0, 1.0],
        [1.0, 0.0, 1.0, 1.0],
    ];
    let quad_size = 1.25f32;

    let mut vertices = Vec::new();
    for quad_ndx in 0..4 {
        let [tx, ty] = translations[quad_ndx];
        let color = quad_colors[quad_ndx];

        let lower_left = Vertex4Rgba {
            position: [tx, ty, 0.0, 1.0],
            color,
        };
        let upper_left = Vertex4Rgba {
            position: [tx, ty + quad_size, 0.0, 1.0],
            color,
        };
        let lower_right = Vertex4Rgba {
            position: [tx + quad_size, ty, 0.0, 1.0],
            color,
        };
        let upper_right = Vertex4Rgba {
            position: [tx + quad_size, ty + quad_size, 0.0, 1.0],
            color,
        };

        // Triangle 1, CCW
        vertices.push(lower_left);
        vertices.push(lower_right);
        vertices.push(upper_left);

        // Triangle 2, CW
        vertices.push(lower_right);
        vertices.push(upper_left);
        vertices.push(upper_right);
    }
    vertices
}

/// `defaultClearColorUnorm`
pub fn default_clear_color_unorm() -> [f32; 4] {
    [0.39, 0.58, 0.93, 1.0]
}

/// `defaultClearColor`
pub fn default_clear_color(format: TextureFormat) -> [f32; 4] {
    if format.channel_class() == TextureChannelClass::FloatingPoint {
        return default_clear_color_unorm();
    }

    let info = get_texture_format_info(format);
    let unorm = default_clear_color_unorm();
    std::array::from_fn(|c| (unorm[c] - info.look_up_bias[c]) / info.look_up_scale[c])
}

/// `defaultClearColorInt`
pub fn default_clear_color_int(format: TextureFormat) -> [i32; 4] {
    let info = get_texture_format_info(format);
    let unorm = default_clear_color_unorm();
    std::array::from_fn(|c| ((unorm[c] - info.look_up_bias[c]) / info.look_up_scale[c]).round() as i32)
}

/// `defaultClearColorUint`
pub fn default_clear_color_uint(format: TextureFormat) -> [u32; 4] {
    let info = get_texture_format_info(format);
    let unorm = default_clear_color_unorm();
    std::array::from_fn(|c| ((unorm[c] - info.look_up_bias[c]) / info.look_up_scale[c]).round() as u32)
}

/// `defaultClearDepth`
pub fn default_clear_depth() -> f32 {
    1.0
}

/// `defaultClearStencil`
pub fn default_clear_stencil() -> u32 {
    0
}

/// `defaultClearValue`
pub fn default_clear_value(clear_format: vk::Format) -> vk::ClearValue {
    let tcu_format = map_vk_format(clear_format);
    let is_depth_stencil =
        tcu_format.is_some_and(|format| matches!(format.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS));

    if is_depth_stencil {
        return vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: default_clear_depth(),
                stencil: default_clear_stencil(),
            },
        };
    }

    let tcu_format = tcu_format.expect("a colour clear format has a texture format");
    match tcu_format.channel_class() {
        TextureChannelClass::UnsignedInteger => vk::ClearValue {
            color: vk::ClearColorValue {
                uint32: default_clear_color_uint(tcu_format),
            },
        },
        TextureChannelClass::SignedInteger => vk::ClearValue {
            color: vk::ClearColorValue {
                int32: default_clear_color_int(tcu_format),
            },
        },
        _ => vk::ClearValue {
            color: vk::ClearColorValue {
                float32: default_clear_color(tcu_format),
            },
        },
    }
}

/// `mapVkBlendFactor`
pub fn map_vk_blend_factor(blend: vk::BlendFactor) -> BlendFunc {
    match blend {
        vk::BlendFactor::ZERO => BlendFunc::Zero,
        vk::BlendFactor::ONE => BlendFunc::One,
        vk::BlendFactor::SRC_COLOR => BlendFunc::SrcColor,
        vk::BlendFactor::ONE_MINUS_SRC_COLOR => BlendFunc::OneMinusSrcColor,
        vk::BlendFactor::DST_COLOR => BlendFunc::DstColor,
        vk::BlendFactor::ONE_MINUS_DST_COLOR => BlendFunc::OneMinusDstColor,
        vk::BlendFactor::SRC_ALPHA => BlendFunc::SrcAlpha,
        vk::BlendFactor::ONE_MINUS_SRC_ALPHA => BlendFunc::OneMinusSrcAlpha,
        vk::BlendFactor::DST_ALPHA => BlendFunc::DstAlpha,
        vk::BlendFactor::ONE_MINUS_DST_ALPHA => BlendFunc::OneMinusDstAlpha,
        vk::BlendFactor::CONSTANT_COLOR => BlendFunc::ConstantColor,
        vk::BlendFactor::ONE_MINUS_CONSTANT_COLOR => BlendFunc::OneMinusConstantColor,
        vk::BlendFactor::CONSTANT_ALPHA => BlendFunc::ConstantAlpha,
        vk::BlendFactor::ONE_MINUS_CONSTANT_ALPHA => BlendFunc::OneMinusConstantAlpha,
        vk::BlendFactor::SRC_ALPHA_SATURATE => BlendFunc::SrcAlphaSaturate,
        vk::BlendFactor::SRC1_COLOR => BlendFunc::Src1Color,
        vk::BlendFactor::ONE_MINUS_SRC1_COLOR => BlendFunc::OneMinusSrc1Color,
        vk::BlendFactor::SRC1_ALPHA => BlendFunc::Src1Alpha,
        _ => BlendFunc::OneMinusSrc1Alpha,
    }
}

/// `mapVkBlendOp`
pub fn map_vk_blend_op(blend_op: vk::BlendOp) -> BlendEquation {
    match blend_op {
        vk::BlendOp::ADD => BlendEquation::Add,
        vk::BlendOp::SUBTRACT => BlendEquation::Subtract,
        vk::BlendOp::REVERSE_SUBTRACT => BlendEquation::ReverseSubtract,
        vk::BlendOp::MIN => BlendEquation::Min,
        _ => BlendEquation::Max,
    }
}

/// `mapVkColorComponentFlags`
pub fn map_vk_color_component_flags(flags: vk::ColorComponentFlags) -> [bool; 4] {
    [
        flags.contains(vk::ColorComponentFlags::R),
        flags.contains(vk::ColorComponentFlags::G),
        flags.contains(vk::ColorComponentFlags::B),
        flags.contains(vk::ColorComponentFlags::A),
    ]
}

/// `mapVkCompareOp`
pub fn map_vk_compare_op(compare_func: vk::CompareOp) -> TestFunc {
    match compare_func {
        vk::CompareOp::NEVER => TestFunc::Never,
        vk::CompareOp::LESS => TestFunc::Less,
        vk::CompareOp::EQUAL => TestFunc::Equal,
        vk::CompareOp::LESS_OR_EQUAL => TestFunc::LEqual,
        vk::CompareOp::GREATER => TestFunc::Greater,
        vk::CompareOp::NOT_EQUAL => TestFunc::NotEqual,
        vk::CompareOp::GREATER_OR_EQUAL => TestFunc::GEqual,
        _ => TestFunc::Always,
    }
}

/// `mapVkPrimitiveTopology`
pub fn map_vk_primitive_topology(primitive_topology: vk::PrimitiveTopology) -> PrimitiveType {
    match primitive_topology {
        vk::PrimitiveTopology::POINT_LIST => PrimitiveType::Points,
        vk::PrimitiveTopology::LINE_LIST => PrimitiveType::Lines,
        vk::PrimitiveTopology::LINE_STRIP => PrimitiveType::LineStrip,
        vk::PrimitiveTopology::TRIANGLE_LIST => PrimitiveType::Triangles,
        vk::PrimitiveTopology::TRIANGLE_FAN => PrimitiveType::TriangleFan,
        vk::PrimitiveTopology::TRIANGLE_STRIP => PrimitiveType::TriangleStrip,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => PrimitiveType::LinesAdjacency,
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => PrimitiveType::LineStripAdjacency,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => PrimitiveType::TrianglesAdjacency,
        _ => PrimitiveType::TriangleStripAdjacency,
    }
}

/// `mapVkStencilOp`
pub fn map_vk_stencil_op(stencil_op: vk::StencilOp) -> StencilOp {
    match stencil_op {
        vk::StencilOp::KEEP => StencilOp::Keep,
        vk::StencilOp::ZERO => StencilOp::Zero,
        vk::StencilOp::REPLACE => StencilOp::Replace,
        vk::StencilOp::INCREMENT_AND_CLAMP => StencilOp::Incr,
        vk::StencilOp::DECREMENT_AND_CLAMP => StencilOp::Decr,
        vk::StencilOp::INVERT => StencilOp::Invert,
        vk::StencilOp::INCREMENT_AND_WRAP => StencilOp::IncrWrap,
        _ => StencilOp::DecrWrap,
    }
}

/// `ColorVertexShader` - passes the position and the colour attribute through.
pub struct ColorVertexShader {
    inputs: [VertexInputInfo; 2],
    outputs: [VertexOutputInfo; 2],
}

impl ColorVertexShader {
    pub fn new() -> Self {
        let float_input = VertexInputInfo {
            type_: Some(GenericVecType::Float),
        };
        let float_output = VertexOutputInfo {
            type_: Some(GenericVecType::Float),
            flatshade: false,
        };
        Self {
            inputs: [float_input, float_input],
            outputs: [float_output, float_output],
        }
    }
}

impl Default for ColorVertexShader {
    fn default() -> Self {
        Self::new()
    }
}

impl VertexShader for ColorVertexShader {
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
            // SAFETY: both attributes point at the arrays `ReferenceRenderer::draw` keeps alive across the draw.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
            }

            packet.outputs[0] = GenericVec4::from_float(position);
            packet.outputs[1] = GenericVec4::from_float(color);
            packet.position = position;
        }
    }
}

/// `ColorFragmentShader` - outputs the interpolated colour and, for a depth/stencil target, the interpolated vertex depth.
pub struct ColorFragmentShader {
    inputs: [FragmentInputInfo; 2],
    outputs: [FragmentOutputInfo; 1],
    has_depth_stencil: bool,
    disable_vulkan_depth_range: bool,
}

impl ColorFragmentShader {
    pub fn new(
        color_format: TextureFormat,
        depth_stencil_format: Option<TextureFormat>,
        disable_vulkan_depth_range: bool,
    ) -> Self {
        let output_type = match color_format.channel_class() {
            TextureChannelClass::SignedInteger => GenericVecType::Int32,
            TextureChannelClass::UnsignedInteger => GenericVecType::Uint32,
            _ => GenericVecType::Float,
        };
        let float_input = FragmentInputInfo {
            type_: Some(GenericVecType::Float),
            flatshade: false,
        };

        Self {
            inputs: [float_input, float_input],
            outputs: [FragmentOutputInfo {
                type_: Some(output_type),
            }],
            has_depth_stencil: depth_stencil_format
                .is_some_and(|format| matches!(format.order, ChannelOrder::D | ChannelOrder::DS)),
            disable_vulkan_depth_range,
        }
    }
}

impl FragmentShader for ColorFragmentShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            // The reference renderer uses the OpenGL depth range of -1..1 and does the viewport depth transform with
            // (position.z + 1) / 2. For Vulkan the depth range is 0..1 and the vertex depth is mapped as is, so the value is
            // overridden here, unless depth clip control changes the depth clipping to the OpenGL depth range.
            if !self.disable_vulkan_depth_range && self.has_depth_stencil {
                for frag_ndx in 0..4usize {
                    // SAFETY: the context was set up by the renderer for exactly these packets.
                    unsafe {
                        let vtx_position = read_varying(&packets[packet_ndx], context, 0, frag_ndx);
                        write_fragment_depth(context, packet_ndx as i32, frag_ndx as i32, 0, vtx_position.z());
                    }
                }
            }

            for frag_ndx in 0..4usize {
                // SAFETY: as above.
                unsafe {
                    let vtx_color = read_varying(&packets[packet_ndx], context, 1, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(vtx_color),
                    );
                }
            }
        }
    }
}

/// `Vertex4RGBARGBA`
#[derive(Clone, Copy)]
#[repr(C)]
pub struct Vertex4RgbaRgba {
    pub position: [f32; 4],
    pub color0: [f32; 4],
    pub color1: [f32; 4],
}

/// `createOverlappingQuadsDualSource` - the overlapping quads with a second colour for the dual-source blend factors.
pub fn create_overlapping_quads_dual_source(force_alpha_one: bool) -> Vec<Vertex4RgbaRgba> {
    let translations = [[-0.25f32, -0.25], [-1.0, -0.25], [-1.0, -1.0], [-0.25, -1.0]];
    let alpha = |value: f32| if force_alpha_one { 1.0 } else { value };
    let quad_colors = [
        [1.0f32, 0.0, 0.0, 1.0],
        [0.0, 1.0, 0.0, alpha(0.25)],
        [0.0, 0.0, 1.0, alpha(0.25)],
        [1.0, 0.0, 1.0, alpha(0.75)],
    ];
    let color1 = [0.0f32, 0.5, 0.5, alpha(0.5)];
    let quad_size = 1.25f32;

    let mut vertices = Vec::new();
    for quad_ndx in 0..4 {
        let [tx, ty] = translations[quad_ndx];
        let color0 = quad_colors[quad_ndx];

        let lower_left = Vertex4RgbaRgba {
            position: [tx, ty, 0.0, 1.0],
            color0,
            color1,
        };
        let upper_left = Vertex4RgbaRgba {
            position: [tx, ty + quad_size, 0.0, 1.0],
            color0,
            color1,
        };
        let lower_right = Vertex4RgbaRgba {
            position: [tx + quad_size, ty, 0.0, 1.0],
            color0,
            color1,
        };
        let upper_right = Vertex4RgbaRgba {
            position: [tx + quad_size, ty + quad_size, 0.0, 1.0],
            color0,
            color1,
        };

        // Triangle 1, CCW
        vertices.push(lower_left);
        vertices.push(lower_right);
        vertices.push(upper_left);

        // Triangle 2, CW
        vertices.push(lower_right);
        vertices.push(upper_left);
        vertices.push(upper_right);
    }
    vertices
}

/// The positions of `createFullscreenQuad` (its texture coordinates are not used where the quad is taken for its shape).
pub fn create_fullscreen_quad_positions() -> Vec<[f32; 4]> {
    let lower_left = [-1.0f32, -1.0, 0.0, 1.0];
    let upper_left = [-1.0f32, 1.0, 0.0, 1.0];
    let lower_right = [1.0f32, -1.0, 0.0, 1.0];
    let upper_right = [1.0f32, 1.0, 0.0, 1.0];

    vec![
        lower_left,
        lower_right,
        upper_left,
        upper_left,
        lower_right,
        upper_right,
    ]
}

/// `ColorVertexShaderDualSource` - passes the position and both colour attributes through.
pub struct ColorVertexShaderDualSource {
    inputs: [VertexInputInfo; 3],
    outputs: [VertexOutputInfo; 3],
}

impl ColorVertexShaderDualSource {
    pub fn new() -> Self {
        let float_input = VertexInputInfo {
            type_: Some(GenericVecType::Float),
        };
        let float_output = VertexOutputInfo {
            type_: Some(GenericVecType::Float),
            flatshade: false,
        };
        Self {
            inputs: [float_input; 3],
            outputs: [float_output; 3],
        }
    }
}

impl Default for ColorVertexShaderDualSource {
    fn default() -> Self {
        Self::new()
    }
}

impl VertexShader for ColorVertexShaderDualSource {
    fn inputs(&self) -> &[VertexInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        &self.outputs
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut color0 = Vec4::splat(0.0);
            let mut color1 = Vec4::splat(0.0);
            // SAFETY: the attributes point at the arrays `ReferenceRenderer::draw_attributes` keeps alive across the draw.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color0, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color1, &inputs[2], packet.instance_ndx, packet.vertex_ndx, 0);
            }

            packet.outputs[0] = GenericVec4::from_float(position);
            packet.outputs[1] = GenericVec4::from_float(color0);
            packet.outputs[2] = GenericVec4::from_float(color1);
            packet.position = position;
        }
    }
}

/// `ColorFragmentShaderDualSource` - outputs both interpolated colours as the two blend sources and, for a depth/stencil
/// target, the interpolated vertex depth.
pub struct ColorFragmentShaderDualSource {
    inputs: [FragmentInputInfo; 3],
    outputs: [FragmentOutputInfo; 1],
    has_depth_stencil: bool,
}

impl ColorFragmentShaderDualSource {
    pub fn new(color_format: TextureFormat, depth_stencil_format: Option<TextureFormat>) -> Self {
        let output_type = match color_format.channel_class() {
            TextureChannelClass::SignedInteger => GenericVecType::Int32,
            TextureChannelClass::UnsignedInteger => GenericVecType::Uint32,
            _ => GenericVecType::Float,
        };
        let float_input = FragmentInputInfo {
            type_: Some(GenericVecType::Float),
            flatshade: false,
        };

        Self {
            inputs: [float_input; 3],
            outputs: [FragmentOutputInfo {
                type_: Some(output_type),
            }],
            has_depth_stencil: depth_stencil_format
                .is_some_and(|format| matches!(format.order, ChannelOrder::D | ChannelOrder::DS)),
        }
    }
}

impl FragmentShader for ColorFragmentShaderDualSource {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            if self.has_depth_stencil {
                for frag_ndx in 0..4usize {
                    // SAFETY: the context was set up by the renderer for exactly these packets.
                    unsafe {
                        let vtx_position = read_varying(&packets[packet_ndx], context, 0, frag_ndx);
                        write_fragment_depth(context, packet_ndx as i32, frag_ndx as i32, 0, vtx_position.z());
                    }
                }
            }

            for frag_ndx in 0..4usize {
                // SAFETY: as above.
                unsafe {
                    let vtx_color0 = read_varying(&packets[packet_ndx], context, 1, frag_ndx);
                    let vtx_color1 = read_varying(&packets[packet_ndx], context, 2, frag_ndx);
                    write_fragment_output_dual_source(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(vtx_color0),
                        GenericVec4::from_float(vtx_color1),
                    );
                }
            }
        }
    }
}

/// `ReferenceRenderer` - a software render target (colour, optional depth/stencil) plus the draw of `Vertex4Rgba` data into
/// it.
pub struct ReferenceRenderer {
    surface_width: u32,
    surface_height: u32,
    depth_stencil_format: Option<TextureFormat>,
    color_buffer: TextureLevel,
    depth_stencil_buffer: Option<TextureLevel>,
}

impl ReferenceRenderer {
    pub fn new(
        surface_width: u32,
        surface_height: u32,
        color_format: TextureFormat,
        depth_stencil_format: Option<TextureFormat>,
    ) -> Result<Self, TestError> {
        let mut color_buffer = TextureLevel::new(color_format, surface_width, surface_height, 1)?;
        match color_format.channel_class() {
            TextureChannelClass::SignedInteger => {
                clear_int(&mut color_buffer.get_access(), default_clear_color_int(color_format));
            }
            TextureChannelClass::UnsignedInteger => {
                clear_int(
                    &mut color_buffer.get_access(),
                    default_clear_color_uint(color_format).map(|value| value as i32),
                );
            }
            _ => {
                let mut clear_color = default_clear_color(color_format);
                if color_format.order.is_srgb() {
                    clear_color = crate::tcu::pixel::linear_to_srgb(clear_color);
                }
                clear(&mut color_buffer.get_access(), clear_color);
            }
        }

        let depth_stencil_buffer = match depth_stencil_format {
            None => None,
            Some(format) => {
                let mut level = TextureLevel::new(format, surface_width, surface_height, 1)?;
                match format.order {
                    ChannelOrder::D => clear_depth(&mut level.get_access(), default_clear_depth()),
                    ChannelOrder::S => clear_stencil(&mut level.get_access(), default_clear_stencil()),
                    _ => {
                        clear_depth(&mut level.get_access(), default_clear_depth());
                        clear_stencil(&mut level.get_access(), default_clear_stencil());
                    }
                }
                Some(level)
            }
        };

        Ok(Self {
            surface_width,
            surface_height,
            depth_stencil_format,
            color_buffer,
            depth_stencil_buffer,
        })
    }

    /// `ReferenceRenderer::colorClear`
    pub fn color_clear(&mut self, color: [f32; 4]) {
        clear(&mut self.color_buffer.get_access(), color);
    }

    /// `ReferenceRenderer::draw` for `Vertex4RGBA` vertices.
    pub fn draw(
        &mut self,
        program: &Program<'_>,
        render_state: &RenderState,
        primitive: PrimitiveType,
        vertex_buffer: &[Vertex4Rgba],
    ) {
        let positions: Vec<[f32; 4]> = vertex_buffer.iter().map(|vertex| vertex.position).collect();
        let colors: Vec<[f32; 4]> = vertex_buffer.iter().map(|vertex| vertex.color).collect();

        self.draw_attributes(program, render_state, primitive, &[positions, colors]);
    }

    /// `ReferenceRenderer::draw` for `Vertex4RGBARGBA` vertices (position and two colours).
    pub fn draw_dual_source(
        &mut self,
        program: &Program<'_>,
        render_state: &RenderState,
        primitive: PrimitiveType,
        vertex_buffer: &[Vertex4RgbaRgba],
    ) {
        let positions: Vec<[f32; 4]> = vertex_buffer.iter().map(|vertex| vertex.position).collect();
        let color0s: Vec<[f32; 4]> = vertex_buffer.iter().map(|vertex| vertex.color0).collect();
        let color1s: Vec<[f32; 4]> = vertex_buffer.iter().map(|vertex| vertex.color1).collect();

        self.draw_attributes(program, render_state, primitive, &[positions, color0s, color1s]);
    }

    /// The draw both overloads share: one tightly packed float vec4 array per attribute.
    fn draw_attributes(
        &mut self,
        program: &Program<'_>,
        render_state: &RenderState,
        primitive: PrimitiveType,
        attributes: &[Vec<[f32; 4]>],
    ) {
        let vertex_count = attributes.first().map_or(0, |attribute| attribute.len());
        let primitives = PrimitiveList::from_arrays(primitive, vertex_count, 0);

        let vertex_attribs: Vec<VertexAttrib> = attributes
            .iter()
            .map(|attribute| {
                VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, attribute.as_ptr().cast::<u8>())
            })
            .collect();

        let color_access = as_multisample_view(self.color_buffer.get_access());
        let (depth_access, stencil_access) = match (self.depth_stencil_format, self.depth_stencil_buffer.as_mut()) {
            (Some(format), Some(level)) => match format.order {
                ChannelOrder::D => (Some(as_multisample_view(level.get_access())), None),
                ChannelOrder::S => (None, Some(as_multisample_view(level.get_access()))),
                _ => {
                    // SAFETY: `level` outlives both views, which are dropped with `render_target` before this function returns,
                    // and nothing else touches the level meanwhile; the aspects never share a byte.
                    let (depth, stencil) = unsafe { split_combined_depth_stencil_mut(std::ptr::from_mut(level)) };
                    (Some(as_multisample_view(depth)), Some(as_multisample_view(stencil)))
                }
            },
            _ => (None, None),
        };

        let mut render_target = RenderTarget::new(color_access, depth_access, stencil_access);
        let command = DrawCommand {
            state: render_state,
            program,
            vertex_attribs: &vertex_attribs,
            primitives: &primitives,
        };

        Renderer::new().draw(&command, &mut render_target);
    }

    /// The writable colour buffer, for the tests that paint pixels back over the rendering.
    pub fn get_access_mut(&mut self) -> crate::tcu::pixel::PixelBufferAccess<'_> {
        self.color_buffer.get_access()
    }

    /// `ReferenceRenderer::getAccess` - the colour buffer (single-sampled, so there is nothing to resolve).
    pub fn get_access(&self) -> ConstPixelBufferAccess<'_> {
        self.color_buffer.get_const_access()
    }

    /// `ReferenceRenderer::getDepthStencilAccess`
    pub fn get_depth_stencil_access(&self) -> Option<ConstPixelBufferAccess<'_>> {
        self.depth_stencil_buffer.as_ref().map(|level| level.get_const_access())
    }

    /// The depth aspect of `get_depth_stencil_access`, as the single-aspect view of a combined format (24-bit and 16-bit
    /// normalised, or float) - what upstream's depth test converts the reference into before comparing.
    pub fn get_depth_access(&self) -> Option<ConstPixelBufferAccess<'_>> {
        self.depth_stencil_buffer
            .as_ref()
            .map(|level| effective_depth_stencil_level_access(level, DepthStencilMode::Depth))
    }

    /// The stencil aspect of `get_depth_stencil_access` (`tcu::getEffectiveDepthStencilAccess` with the stencil mode).
    pub fn get_stencil_access(&self) -> Option<ConstPixelBufferAccess<'_>> {
        self.depth_stencil_buffer
            .as_ref()
            .map(|level| effective_depth_stencil_level_access(level, DepthStencilMode::Stencil))
    }

    /// `ReferenceRenderer::getViewportState`
    pub fn get_viewport_state(&self) -> ViewportState {
        ViewportState::from_target_size(self.surface_width as i32, self.surface_height as i32)
    }
}

/// `vk::copyImageToBuffer` (first overload) in a command buffer of its own, followed by the host read of `buffer_size`
/// bytes: the image goes from `old_layout` to a transfer source layout, one aspect is copied, and the bytes come back.
#[allow(clippy::too_many_arguments)]
fn read_image_aspect(
    context: &Context<'_>,
    image: vk::Image,
    render_size: (u32, u32),
    buffer_size: vk::DeviceSize,
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    barrier_aspect: vk::ImageAspectFlags,
    copy_aspect: vk::ImageAspectFlags,
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let transfer_layout = if old_layout == vk::ImageLayout::GENERAL {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };

    begin_command_buffer(device, cmd)?;
    let image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        transfer_layout,
        image,
        make_image_subresource_range(barrier_aspect, 0, 1, 0, 1),
    );
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: copy_aspect,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        },
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: render_size.0,
            height: render_size.1,
            depth: 1,
        },
    };
    let buffer_barrier = vk::BufferMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .buffer(buffer.get())
        .offset(0)
        .size(vk::WHOLE_SIZE)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
        device.cmd_copy_image_to_buffer(cmd, image, transfer_layout, buffer.get(), &[region]);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, buffer.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), buffer_size as usize) }.to_vec())
}

/// `readColorAttachment` with the default `oldAccess` (colour attachment write).
pub fn read_color_attachment(
    context: &Context<'_>,
    image: vk::Image,
    format: vk::Format,
    render_size: (u32, u32),
    old_layout: vk::ImageLayout,
) -> Result<TextureLevel, TestError> {
    read_color_attachment_with_access(
        context,
        image,
        format,
        render_size,
        old_layout,
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
    )
}

/// `readColorAttachment`
pub fn read_color_attachment_with_access(
    context: &Context<'_>,
    image: vk::Image,
    format: vk::Format,
    render_size: (u32, u32),
    old_layout: vk::ImageLayout,
    old_access: vk::AccessFlags,
) -> Result<TextureLevel, TestError> {
    let tcu_format = map_vk_format(format)
        .ok_or_else(|| TestError::NotPorted("colour attachment format without a texture format".to_string()))?;
    let pixel_size = tcu_format
        .pixel_size()
        .ok_or_else(|| TestError::NotPorted("colour attachment format without a pixel size".to_string()))?;
    let buffer_size = vk::DeviceSize::from(render_size.0 * render_size.1 * pixel_size);

    let bytes = read_image_aspect(
        context,
        image,
        render_size,
        buffer_size,
        old_access,
        old_layout,
        vk::ImageAspectFlags::COLOR,
        vk::ImageAspectFlags::COLOR,
    )?;

    let mut result = TextureLevel::new(tcu_format, render_size.0, render_size.1, 1)?;
    result.data_mut().copy_from_slice(&bytes);
    Ok(result)
}

/// `readDepthAttachment`
pub fn read_depth_attachment(
    context: &Context<'_>,
    image: vk::Image,
    format: vk::Format,
    render_size: (u32, u32),
    current_layout: vk::ImageLayout,
) -> Result<TextureLevel, TestError> {
    let (ret_type, buffer_type) = match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => (ChannelType::UNORM_INT16, ChannelType::UNORM_INT16),
        // vkCmdCopyBufferToImage copies D24 data to 32-bit pixels.
        vk::Format::D24_UNORM_S8_UINT | vk::Format::X8_D24_UNORM_PACK32 => {
            (ChannelType::UNORM_INT24, ChannelType::UNSIGNED_INT_24_8_REV)
        }
        vk::Format::D32_SFLOAT | vk::Format::D32_SFLOAT_S8_UINT => (ChannelType::FLOAT, ChannelType::FLOAT),
        _ => return Err(TestError::Fail("unrecognized format".to_string())),
    };
    let ret_format = TextureFormat::new(ChannelOrder::D, ret_type);
    let buffer_format = TextureFormat::new(ChannelOrder::D, buffer_type);
    let barrier_aspect = vk::ImageAspectFlags::DEPTH
        | if map_vk_format(format).is_some_and(|tcu_format| tcu_format.order == ChannelOrder::DS) {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::empty()
        };

    let pixel_size = buffer_format
        .pixel_size()
        .ok_or_else(|| TestError::NotPorted("depth buffer pixel size".to_string()))?;
    let buffer_size = vk::DeviceSize::from(render_size.0 * render_size.1 * pixel_size);

    let bytes = read_image_aspect(
        context,
        image,
        render_size,
        buffer_size,
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        current_layout,
        barrier_aspect,
        vk::ImageAspectFlags::DEPTH,
    )?;

    let mut result = TextureLevel::new(ret_format, render_size.0, render_size.1, 1)?;
    let source = ConstPixelBufferAccess::new(buffer_format, [render_size.0, render_size.1, 1], &bytes);
    {
        let mut destination = result.get_access();
        for y in 0..render_size.1 {
            for x in 0..render_size.0 {
                destination.set_pix_depth(source.get_pix_depth(x, y, 0), x, y, 0);
            }
        }
    }
    Ok(result)
}

/// `readStencilAttachment`
pub fn read_stencil_attachment(
    context: &Context<'_>,
    image: vk::Image,
    format: vk::Format,
    render_size: (u32, u32),
    current_layout: vk::ImageLayout,
) -> Result<TextureLevel, TestError> {
    let ret_format = TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8);
    let barrier_aspect = vk::ImageAspectFlags::STENCIL
        | if map_vk_format(format).is_some_and(|tcu_format| tcu_format.order == ChannelOrder::DS) {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::empty()
        };
    let buffer_size = vk::DeviceSize::from(render_size.0 * render_size.1);

    let bytes = read_image_aspect(
        context,
        image,
        render_size,
        buffer_size,
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        current_layout,
        barrier_aspect,
        vk::ImageAspectFlags::STENCIL,
    )?;

    let mut result = TextureLevel::new(ret_format, render_size.0, render_size.1, 1)?;
    result.data_mut().copy_from_slice(&bytes);
    Ok(result)
}

/// `UniqueRandomIterator`'s index sequence: `num_items` distinct values below `num_values` in an order scrambled by the seed
/// (every value, in sequence, when all of them are wanted).
pub fn unique_random_indices(num_items: u32, num_values: u32, seed: u32) -> Vec<u32> {
    debug_assert!(num_items <= num_values);
    let mut rnd = Random::new(seed);

    let mut indices: Vec<u32> = if num_items == num_values {
        (0..num_items).collect()
    } else {
        let mut unique_indices = std::collections::BTreeSet::new();

        // Populate set with "numItems" unique values between 0 and numValues - 1
        while unique_indices.len() < num_items as usize {
            unique_indices.insert(rnd.get_uint32() % num_values);
        }

        unique_indices.into_iter().collect()
    };

    // Scramble the indices
    rnd.shuffle(&mut indices);
    indices
}

/// `tcu::copy` between two float-class accesses of one size: each texel is read as a vec4 and written converted.
pub fn copy_float_pixels(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) {
    let [width, height, depth] = src.size();
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                dst.set_pixel(src.get_pixel(x, y, z), x, y, z);
            }
        }
    }
}

/// `vk::makeRenderPass` with a colour and a depth/stencil attachment (either may be `VK_FORMAT_UNDEFINED`, meaning absent),
/// one subpass, a load operation for both, and chosen final and subpass layouts.
#[allow(clippy::too_many_arguments)]
pub fn make_color_depth_render_pass(
    device: &Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    load_operation: vk::AttachmentLoadOp,
    final_layout_color: vk::ImageLayout,
    final_layout_depth_stencil: vk::ImageLayout,
    subpass_layout_color: vk::ImageLayout,
    subpass_layout_depth_stencil: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let has_color = color_format != vk::Format::UNDEFINED;
    let has_depth_stencil = depth_stencil_format != vk::Format::UNDEFINED;
    let (initial_layout_color, initial_layout_depth_stencil) = if load_operation == vk::AttachmentLoadOp::LOAD {
        (
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )
    } else {
        (vk::ImageLayout::UNDEFINED, vk::ImageLayout::UNDEFINED)
    };

    let mut attachment_descriptions = Vec::new();
    if has_color {
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(color_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(load_operation)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(initial_layout_color)
                .final_layout(final_layout_color)
                .build(),
        );
    }
    if has_depth_stencil {
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(depth_stencil_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(load_operation)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(load_operation)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(initial_layout_depth_stencil)
                .final_layout(final_layout_depth_stencil)
                .build(),
        );
    }

    let color_attachment_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: subpass_layout_color,
    }];
    let depth_stencil_attachment_ref = vk::AttachmentReference {
        attachment: u32::from(has_color),
        layout: subpass_layout_depth_stencil,
    };

    let mut subpass = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
    if has_color {
        subpass = subpass.color_attachments(&color_attachment_ref);
    }
    if has_depth_stencil {
        subpass = subpass.depth_stencil_attachment(&depth_stencil_attachment_ref);
    }
    let subpasses = [subpass.build()];

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}
