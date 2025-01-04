// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboTestUtil.cpp (Texture2DShader, TextureCubeShader)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders `es3fTextureSpecificationTests.cpp`
// renders its textures through: one sampler (`sampler2D`/`isampler2D`/`usampler2D` or the cube
// counterparts), `u_scale`/`u_bias` applied to the fetched value, float vec4 output.
//
// `Texture2DArrayShader`/`Texture3DShader` are `SpecTexVolumeShader`, one struct for both: the layer / depth lives in the
// shader as a plain field as well as in the `u_layer` / `u_depth` uniform the driver side reads.
//
// Differences from upstream, all narrowing:
//  - `TextureCubeShader` there carries a `u_coordMat` mat3 uniform (`setFace`); `sglr::Context` has no
//    `uniformMatrix3fv`, so the face is baked in at construction like the ES 2.0 port's `TexCubeShader`
//    (the same (x, y) -> direction swizzle, computed per fragment instead of in the vertex stage).
//  - The shader is not reusable after `createProgram`; `render_tex_2d`/`render_tex_cube` build one per call.
//  - `lod` for the integer samplers is the derivative formula of `ResolvedSampler2D::sample_2d_quad`, which
//    needs the base level size, so it is passed in (the case knows it).

use crate::glu::shader_util::DataType;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{
    FragmentShadingContext, dfdx_varying, dfdy_varying, read_varying, write_fragment_output,
};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::sglr::reference_context::{
    ResolvedSampler, ResolvedSampler2D, ResolvedSampler2DArray, ResolvedSampler3D, ResolvedSamplerCube,
};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::surface::Surface;
use crate::tcu::vector::{Vec3, Vec4};
use crate::tcu::{ChannelType, TextureFormat};

/// `glu::getSampler2DType` / `glu::getSamplerCubeType` of a texture format.
pub(crate) fn sampler_types(format: TextureFormat) -> (DataType, DataType) {
    use ChannelType::*;

    match format.type_ {
        SIGNED_INT8 | SIGNED_INT16 | SIGNED_INT32 | SIGNED_INT64 | SIGNED_INT_1010102_REV => {
            (DataType::IntSampler2D, DataType::IntSamplerCube)
        }
        UNSIGNED_INT8
        | UNSIGNED_INT16
        | UNSIGNED_INT24
        | UNSIGNED_INT32
        | UNSIGNED_INT64
        | UNSIGNED_INT_1010102_REV => (DataType::UintSampler2D, DataType::UintSamplerCube),
        _ => (DataType::Sampler2D, DataType::SamplerCube),
    }
}

const VERTEX_SOURCE: &str = "#version 300 es\n\
     in highp vec4 a_position;\n\
     in mediump vec2 a_coord;\n\
     out mediump vec2 v_coord;\n\
     void main (void)\n\
     {\n\
     \x20   gl_Position = a_position;\n\
     \x20   v_coord = a_coord;\n\
     }\n";

fn vertex_shade(inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
    for packet in packets.iter_mut() {
        let mut position = Vec4::splat(0.0);
        let mut coord = Vec4::splat(0.0);
        // SAFETY: the attributes were bound by `draw_quad` before the draw call.
        unsafe {
            read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
            read_vertex_attrib_float(&mut coord, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
        }
        packet.position = position;
        packet.outputs[0] = GenericVec4::from_float(coord);
    }
}

fn declaration(sampler: DataType, fragment_source: String) -> pdec::ShaderProgramDeclaration {
    pdec::ShaderProgramDeclaration::new()
        .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
        .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
        .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
        .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
        .uniform(pdec::Uniform::new("u_sampler0", sampler))
        .uniform(pdec::Uniform::new("u_scale", DataType::FloatVec4))
        .uniform(pdec::Uniform::new("u_bias", DataType::FloatVec4))
        .vertex_source(VERTEX_SOURCE.to_string())
        .fragment_source(fragment_source)
}

fn scale_bias(color: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> Vec4 {
    Vec4::new(
        color[0] * scale[0] + bias[0],
        color[1] * scale[1] + bias[1],
        color[2] * scale[2] + bias[2],
        color[3] * scale[3] + bias[3],
    )
}

fn int_color(v: [i32; 4]) -> [f32; 4] {
    v.map(|c| c as f32)
}

fn uint_color(v: [u32; 4]) -> [f32; 4] {
    v.map(|c| c as f32)
}

/// `FboTestUtil::Texture2DShader` with one sampler, float output.
struct SpecTex2DShader {
    base: ShaderProgramBase,
    sampler: Option<ResolvedSampler2D>,
    sampler_type: DataType,
    base_width: f32,
    base_height: f32,
}

impl SpecTex2DShader {
    fn new(sampler_type: DataType, base_width: i32, base_height: i32) -> Self {
        let source = format!(
            "#version 300 es\n\
             uniform highp {} u_sampler0;\n\
             uniform highp vec4 u_scale;\n\
             uniform highp vec4 u_bias;\n\
             in mediump vec2 v_coord;\n\
             layout(location = 0) out highp vec4 o_color;\n\
             void main (void)\n\
             {{\n\
             \x20   o_color = vec4(texture(u_sampler0, v_coord)) * u_scale + u_bias;\n\
             }}\n",
            sampler_type.name()
        );
        Self {
            base: ShaderProgramBase::new(&declaration(sampler_type, source)),
            sampler: None,
            sampler_type,
            base_width: base_width as f32,
            base_height: base_height as f32,
        }
    }
}

impl VertexShader for SpecTex2DShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        vertex_shade(inputs, packets);
    }
}

impl FragmentShader for SpecTex2DShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let scale = self.base.uniform_by_name("u_scale").value.as_f32_vec4();
        let bias = self.base.uniform_by_name("u_bias").value.as_f32_vec4();

        for packet_ndx in 0..packets.len() {
            // SAFETY: the context was set up by the renderer for exactly these packets.
            let (dfdx, dfdy) = unsafe {
                (
                    dfdx_varying(&packets[packet_ndx], context, 0),
                    dfdy_varying(&packets[packet_ndx], context, 0),
                )
            };

            for frag_ndx in 0..4usize {
                // SAFETY: as above.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let color = match &self.sampler {
                    Some(sampler) => {
                        let (dx, dy) = (
                            (dfdx[frag_ndx].x(), dfdx[frag_ndx].y()),
                            (dfdy[frag_ndx].x(), dfdy[frag_ndx].y()),
                        );
                        match self.sampler_type {
                            DataType::IntSampler2D | DataType::UintSampler2D => {
                                let mu = dx.0.abs().max(dy.0.abs());
                                let mv = dx.1.abs().max(dy.1.abs());
                                let lod = (mu * self.base_width).max(mv * self.base_height).log2();
                                if self.sampler_type == DataType::IntSampler2D {
                                    int_color(sampler.sample_int(coord.x(), coord.y(), lod))
                                } else {
                                    uint_color(sampler.sample_uint(coord.x(), coord.y(), lod))
                                }
                            }
                            _ => sampler.sample_2d_quad(coord.x(), coord.y(), dx, dy),
                        }
                    }
                    None => [0.0; 4],
                };
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(scale_bias(color, scale, bias)),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for SpecTex2DShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler = sampler.as_ref().and_then(ResolvedSampler::as_2d).cloned();
            }
        }
    }
}

/// The (x, y) -> direction swizzles of `es2fTextureSpecificationTests.cpp`'s `TexCubeShader`, in `tcu::CubeFace` order.
const CUBE_SWIZZLES: [&str; 6] = [
    "vec3(-1, -y, +x)",
    "vec3(+1, -y, -x)",
    "vec3(+x, -1, -y)",
    "vec3(+x, +1, +y)",
    "vec3(-x, -y, -1)",
    "vec3(+x, -y, +1)",
];

/// `FboTestUtil::TextureCubeShader`, one face baked in.
struct SpecTexCubeShader {
    base: ShaderProgramBase,
    sampler: Option<ResolvedSamplerCube>,
    sampler_type: DataType,
    face: usize,
}

impl SpecTexCubeShader {
    fn new(sampler_type: DataType, face: usize) -> Self {
        let source = format!(
            "#version 300 es\n\
             uniform highp {} u_sampler0;\n\
             uniform highp vec4 u_scale;\n\
             uniform highp vec4 u_bias;\n\
             in mediump vec2 v_coord;\n\
             layout(location = 0) out highp vec4 o_color;\n\
             void main (void)\n\
             {{\n\
             \x20   highp float x = v_coord.x*2.0 - 1.0;\n\
             \x20   highp float y = v_coord.y*2.0 - 1.0;\n\
             \x20   o_color = vec4(texture(u_sampler0, {})) * u_scale + u_bias;\n\
             }}\n",
            sampler_type.name(),
            CUBE_SWIZZLES[face]
        );
        Self {
            base: ShaderProgramBase::new(&declaration(sampler_type, source)),
            sampler: None,
            sampler_type,
            face,
        }
    }

    fn direction(&self, x: f32, y: f32) -> [f32; 3] {
        match self.face {
            0 => [-1.0, -y, x],
            1 => [1.0, -y, -x],
            2 => [x, -1.0, -y],
            3 => [x, 1.0, y],
            4 => [-x, -y, -1.0],
            _ => [x, -y, 1.0],
        }
    }
}

impl VertexShader for SpecTexCubeShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        vertex_shade(inputs, packets);
    }
}

impl FragmentShader for SpecTexCubeShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let scale = self.base.uniform_by_name("u_scale").value.as_f32_vec4();
        let bias = self.base.uniform_by_name("u_bias").value.as_f32_vec4();

        for packet_ndx in 0..packets.len() {
            let mut dirs = [[0.0f32; 3]; 4];
            for (frag_ndx, dir) in dirs.iter_mut().enumerate() {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                *dir = self.direction(coord.x() * 2.0 - 1.0, coord.y() * 2.0 - 1.0);
            }

            for frag_ndx in 0..4usize {
                let [s, t, r] = dirs[frag_ndx];
                let color = match &self.sampler {
                    Some(sampler) => match self.sampler_type {
                        DataType::IntSamplerCube | DataType::UintSamplerCube => {
                            let lod = sampler.cube_packet_lod(frag_ndx, &dirs);
                            if self.sampler_type == DataType::IntSamplerCube {
                                int_color(sampler.sample_int(s, t, r, lod))
                            } else {
                                uint_color(sampler.sample_uint(s, t, r, lod))
                            }
                        }
                        _ => sampler.sample_cube_packet(frag_ndx, &dirs),
                    },
                    None => [0.0; 4],
                };
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(scale_bias(color, scale, bias)),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for SpecTexCubeShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler = sampler.as_ref().and_then(ResolvedSampler::as_cube).cloned();
            }
        }
    }
}

/// `Texture2DShader::setUniforms` / `TextureCubeShader::setUniforms`
fn set_uniforms(ctx: &mut dyn SglrContext, program: u32, scale: [f32; 4], bias: [f32; 4]) {
    ctx.use_program(program);
    let sampler_loc = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(sampler_loc, 0);
    let scale_loc = ctx.get_uniform_location(program, "u_scale");
    ctx.uniform4fv(scale_loc, 1, &scale);
    let bias_loc = ctx.get_uniform_location(program, "u_bias");
    ctx.uniform4fv(bias_loc, 1, &bias);
}

fn draw_and_read(
    ctx: &mut dyn SglrContext,
    shader_id: u32,
    width: i32,
    height: i32,
    target_w: i32,
    target_h: i32,
) -> Surface {
    let w = width as f32 / target_w as f32;
    let h = height as f32 / target_h as f32;

    draw_quad(
        ctx,
        shader_id,
        Vec3::new(-1.0, -1.0, 0.0),
        Vec3::new(-1.0 + w * 2.0, -1.0 + h * 2.0, 0.0),
    );

    let mut dst = Surface::new(width, height);
    ctx.read_pixels(&mut dst, 0, 0, width, height);
    dst
}

/// `TextureSpecCase::renderTex` with a `Texture2DShader` of `sampler_type`.
#[allow(clippy::too_many_arguments)]
pub(crate) fn render_tex_2d(
    ctx: &mut dyn SglrContext,
    width: i32,
    height: i32,
    target_w: i32,
    target_h: i32,
    base_size: (i32, i32),
    sampler_type: DataType,
    scale: [f32; 4],
    bias: [f32; 4],
) -> Surface {
    let shader_id = ctx.create_program(Box::new(SpecTex2DShader::new(sampler_type, base_size.0, base_size.1)));
    set_uniforms(ctx, shader_id, scale, bias);
    draw_and_read(ctx, shader_id, width, height, target_w, target_h)
}

/// `TextureSpecCase::renderTex` with a `TextureCubeShader` of `sampler_type` set to `face`.
#[allow(clippy::too_many_arguments)]
pub(crate) fn render_tex_cube(
    ctx: &mut dyn SglrContext,
    width: i32,
    height: i32,
    target_w: i32,
    target_h: i32,
    face: usize,
    _base_size: i32,
    sampler_type: DataType,
    scale: [f32; 4],
    bias: [f32; 4],
) -> Surface {
    let shader_id = ctx.create_program(Box::new(SpecTexCubeShader::new(sampler_type, face)));
    set_uniforms(ctx, shader_id, scale, bias);
    draw_and_read(ctx, shader_id, width, height, target_w, target_h)
}

/// `glu::getSampler2DArrayType` / `glu::getSampler3DType` of a texture format.
pub(crate) fn volume_sampler_types(format: TextureFormat) -> (DataType, DataType) {
    match sampler_types(format).0 {
        DataType::IntSampler2D => (DataType::IntSampler2DArray, DataType::IntSampler3D),
        DataType::UintSampler2D => (DataType::UintSampler2DArray, DataType::UintSampler3D),
        _ => (DataType::Sampler2DArray, DataType::Sampler3D),
    }
}

/// `FboTestUtil::Texture2DArrayShader` (`is_array`, layer in `third`) and `Texture3DShader` (depth in `third`).
struct SpecTexVolumeShader {
    base: ShaderProgramBase,
    sampler_array: Option<ResolvedSampler2DArray>,
    sampler_3d: Option<ResolvedSampler3D>,
    sampler_type: DataType,
    is_array: bool,
    third: f32,
    base_width: f32,
    base_height: f32,
}

impl SpecTexVolumeShader {
    fn new(sampler_type: DataType, is_array: bool, third: f32, base_width: i32, base_height: i32) -> Self {
        let (third_uniform, third_type, third_coord) = if is_array {
            ("u_layer", DataType::Int, "u_layer")
        } else {
            ("u_depth", DataType::Float, "u_depth")
        };
        let source = format!(
            "#version 300 es\n\
             uniform highp {} u_sampler0;\n\
             uniform highp vec4 u_scale;\n\
             uniform highp vec4 u_bias;\n\
             uniform highp {} {third_uniform};\n\
             in mediump vec2 v_coord;\n\
             layout(location = 0) out highp vec4 o_color;\n\
             void main (void)\n\
             {{\n\
             \x20   o_color = vec4(texture(u_sampler0, vec3(v_coord, {third_coord}))) * u_scale + u_bias;\n\
             }}\n",
            sampler_type.name(),
            if is_array { "int" } else { "float" }
        );
        let decl = declaration(sampler_type, source).uniform(pdec::Uniform::new(third_uniform, third_type));
        Self {
            base: ShaderProgramBase::new(&decl),
            sampler_array: None,
            sampler_3d: None,
            sampler_type,
            is_array,
            third,
            base_width: base_width as f32,
            base_height: base_height as f32,
        }
    }
}

impl VertexShader for SpecTexVolumeShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        vertex_shade(inputs, packets);
    }
}

impl FragmentShader for SpecTexVolumeShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let scale = self.base.uniform_by_name("u_scale").value.as_f32_vec4();
        let bias = self.base.uniform_by_name("u_bias").value.as_f32_vec4();
        let is_int = matches!(self.sampler_type, DataType::IntSampler2DArray | DataType::IntSampler3D);
        let is_uint = matches!(
            self.sampler_type,
            DataType::UintSampler2DArray | DataType::UintSampler3D
        );

        for packet_ndx in 0..packets.len() {
            // SAFETY: the context was set up by the renderer for exactly these packets.
            let (dfdx, dfdy) = unsafe {
                (
                    dfdx_varying(&packets[packet_ndx], context, 0),
                    dfdy_varying(&packets[packet_ndx], context, 0),
                )
            };

            for frag_ndx in 0..4usize {
                // SAFETY: as above.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let (s, t, r) = (coord.x(), coord.y(), self.third);
                let (dx, dy) = (
                    (dfdx[frag_ndx].x(), dfdx[frag_ndx].y()),
                    (dfdy[frag_ndx].x(), dfdy[frag_ndx].y()),
                );
                let lod = || {
                    let mu = dx.0.abs().max(dy.0.abs());
                    let mv = dx.1.abs().max(dy.1.abs());
                    (mu * self.base_width).max(mv * self.base_height).log2()
                };

                let color = if self.is_array {
                    match &self.sampler_array {
                        Some(sampler) if is_int => int_color(sampler.sample_int(s, t, r, lod())),
                        Some(sampler) if is_uint => uint_color(sampler.sample_uint(s, t, r, lod())),
                        Some(sampler) => sampler.sample_2d_array_quad(s, t, r, dx, dy),
                        None => [0.0; 4],
                    }
                } else {
                    match &self.sampler_3d {
                        Some(sampler) if is_int => int_color(sampler.sample_int(s, t, r, lod())),
                        Some(sampler) if is_uint => uint_color(sampler.sample_uint(s, t, r, lod())),
                        Some(sampler) => sampler.sample_3d_quad(s, t, r, (dx.0, dx.1, 0.0), (dy.0, dy.1, 0.0)),
                        None => [0.0; 4],
                    }
                };
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(scale_bias(color, scale, bias)),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for SpecTexVolumeShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler_array = sampler.as_ref().and_then(ResolvedSampler::as_2d_array).cloned();
                self.sampler_3d = sampler.as_ref().and_then(ResolvedSampler::as_3d).cloned();
            }
        }
    }
}

/// `TextureSpecCase::renderTex` with a `Texture2DArrayShader` set to `layer`.
#[allow(clippy::too_many_arguments)]
pub(crate) fn render_tex_array(
    ctx: &mut dyn SglrContext,
    width: i32,
    height: i32,
    target_w: i32,
    target_h: i32,
    base_size: (i32, i32),
    layer: i32,
    sampler_type: DataType,
    scale: [f32; 4],
    bias: [f32; 4],
) -> Surface {
    let shader_id = ctx.create_program(Box::new(SpecTexVolumeShader::new(
        sampler_type,
        true,
        layer as f32,
        base_size.0,
        base_size.1,
    )));
    set_uniforms(ctx, shader_id, scale, bias);
    let layer_loc = ctx.get_uniform_location(shader_id, "u_layer");
    ctx.uniform1i(layer_loc, layer);
    draw_and_read(ctx, shader_id, width, height, target_w, target_h)
}

/// `TextureSpecCase::renderTex` with a `Texture3DShader` set to `depth` (a normalised coordinate).
#[allow(clippy::too_many_arguments)]
pub(crate) fn render_tex_3d(
    ctx: &mut dyn SglrContext,
    width: i32,
    height: i32,
    target_w: i32,
    target_h: i32,
    base_size: (i32, i32),
    depth: f32,
    sampler_type: DataType,
    scale: [f32; 4],
    bias: [f32; 4],
) -> Surface {
    let shader_id = ctx.create_program(Box::new(SpecTexVolumeShader::new(
        sampler_type,
        false,
        depth,
        base_size.0,
        base_size.1,
    )));
    set_uniforms(ctx, shader_id, scale, bias);
    let depth_loc = ctx.get_uniform_location(shader_id, "u_depth");
    ctx.uniform1f(depth_loc, depth);
    draw_and_read(ctx, shader_id, width, height, target_w, target_h)
}
