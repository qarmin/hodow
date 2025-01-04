// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboTestUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Shaders and helpers shared by the ES 3.0 `fbo.*` cases that render through `sglr::Context`.
//
// Narrowing, all of it because `sglr::Context` has no entry point for it yet:
//  - `TextureCubeShader`, `Texture2DArrayShader` and `Texture3DShader` are one `TextureNdShader` here (three
//    constructors, three `set_*_uniforms` free functions); fragments sample at lod 0 per fragment, as `Texture2DShader`.
//  - `read_pixels` goes through `sglr::Context::read_pixels_rgba_f32` for float/int/uint formats (pixels come
//    back as floats rather than raw bytes); fixed-point formats use the plain RGBA8 `Surface` read and need
//    identity scale/bias.
//  - `getToSRGBConversionThreshold` is not ported.
//  - A C++ shader object stays usable after `createProgram(&shader)`; here the program is moved into
//    the context, so `setColor`/`setGradient`/`setUniforms` are free functions taking the program id,
//    and `Texture2DShader::uniforms` snapshots what `setUniforms` needs before the move.

use crate::glu::shader_util::DataType;
use crate::glw::{self, GLenum};
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_depth, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::reference_context::{ResolvedSampler, ResolvedSampler2D};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::pixel::CubeFace;
use crate::tcu::vector::{IVec4, UVec4, Vec4};
use crate::tcu::{ChannelType, RGBA, Surface, TestError, TextureFormat};

/// `mapDataTypeToGenericVecType`
fn map_data_type_to_generic_vec_type(type_: DataType) -> GenericVecType {
    match type_ {
        DataType::FloatVec4 => GenericVecType::Float,
        DataType::IntVec4 => GenericVecType::Int32,
        DataType::UintVec4 => GenericVecType::Uint32,
        other => panic!("fragment output type {other:?} is not a vec4"),
    }
}

/// `castVectorSaturate<int32_t>`
fn saturate_i32(v: f32) -> i32 {
    let d = v as f64;
    if d + 0.5 >= i32::MAX as f64 {
        i32::MAX
    } else if d - 0.5 <= i32::MIN as f64 {
        i32::MIN
    } else {
        v as i32
    }
}

/// `castVectorSaturate<uint32_t>`
fn saturate_u32(v: f32) -> u32 {
    let d = v as f64;
    if d + 0.5 >= u32::MAX as f64 {
        u32::MAX
    } else if d - 0.5 <= 0.0 {
        0
    } else {
        v as u32
    }
}

/// `rr::writeFragmentOutput(context, packetNdx, fragNdx, 0, <colour converted to the output type>)`
///
/// # Safety
/// The context must have been set up by the renderer for exactly these packets.
unsafe fn write_color(
    context: &FragmentShadingContext,
    packet_ndx: usize,
    frag_ndx: usize,
    output_type: DataType,
    c: [f32; 4],
) {
    let value = match output_type {
        DataType::FloatVec4 => GenericVec4::from_float(Vec4::new(c[0], c[1], c[2], c[3])),
        DataType::IntVec4 => GenericVec4::from_int(IVec4::new(
            saturate_i32(c[0]),
            saturate_i32(c[1]),
            saturate_i32(c[2]),
            saturate_i32(c[3]),
        )),
        DataType::UintVec4 => GenericVec4::from_uint(UVec4::new(
            saturate_u32(c[0]),
            saturate_u32(c[1]),
            saturate_u32(c[2]),
            saturate_u32(c[3]),
        )),
        other => panic!("fragment output type {other:?} is not a vec4"),
    };
    unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx as i32, 0, value) };
}

fn read_attrib(inputs: &[VertexAttrib], index: usize, packet: &VertexPacket) -> Vec4 {
    let mut v = Vec4::splat(0.0);
    // SAFETY: the attribute was bound by the case before the draw call.
    unsafe { read_vertex_attrib_float(&mut v, &inputs[index], packet.instance_ndx, packet.vertex_ndx, 0) };
    v
}

/// The vertex shader of every shader below with a position and (optionally) one coordinate attribute.
fn shade_position_and_coord(inputs: &[VertexAttrib], packets: &mut [VertexPacket], has_coord: bool) {
    for packet in packets.iter_mut() {
        packet.position = read_attrib(inputs, 0, packet);
        if has_coord {
            packet.outputs[0] = GenericVec4::from_float(read_attrib(inputs, 1, packet));
        }
    }
}

macro_rules! program_plumbing {
    ($ty:ty) => {
        impl ShaderProgram for $ty {
            fn program_base(&self) -> &ShaderProgramBase {
                &self.base
            }

            fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
                &mut self.base
            }
        }
    };
}

macro_rules! vertex_plumbing {
    () => {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }

        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
    };
}

macro_rules! fragment_plumbing {
    () => {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }

        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
    };
}

// FlatColorShader

/// `FboTestUtil::FlatColorShader`
pub struct FlatColorShader {
    base: ShaderProgramBase,
    output_type: DataType,
}

impl FlatColorShader {
    pub fn new(output_type: DataType) -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(map_data_type_to_generic_vec_type(
                output_type,
            )))
            .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
            .vertex_source(
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 }\n",
            )
            .fragment_source(format!(
                "#version 300 es\n\
                 uniform highp vec4 u_color;\n\
                 layout(location = 0) out highp {t} o_color;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   o_color = {t}(u_color);\n\
                 }}\n",
                t = output_type.name()
            ));
        Self {
            base: ShaderProgramBase::new(&decl),
            output_type,
        }
    }
}

/// `FlatColorShader::setColor`
pub fn set_flat_color(ctx: &mut dyn SglrContext, program: u32, color: [f32; 4]) {
    let location = ctx.get_uniform_location(program, "u_color");
    ctx.use_program(program);
    ctx.uniform4fv(location, 1, &color);
}

impl VertexShader for FlatColorShader {
    vertex_plumbing!();

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        shade_position_and_coord(inputs, packets, false);
    }
}

impl FragmentShader for FlatColorShader {
    fragment_plumbing!();

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let color = self.base.uniform_by_name("u_color").value.as_f32_vec4();
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4 {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe { write_color(context, packet_ndx, frag_ndx, self.output_type, color) };
            }
        }
    }
}

program_plumbing!(FlatColorShader);

// GradientShader

/// `FboTestUtil::GradientShader`
pub struct GradientShader {
    base: ShaderProgramBase,
    output_type: DataType,
}

impl GradientShader {
    pub fn new(output_type: DataType) -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(map_data_type_to_generic_vec_type(
                output_type,
            )))
            .uniform(pdec::Uniform::new("u_gradientMin", DataType::FloatVec4))
            .uniform(pdec::Uniform::new("u_gradientMax", DataType::FloatVec4))
            .vertex_source(
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec4 a_coord;\n\
                 out highp vec4 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_coord;\n\
                 }\n",
            )
            .fragment_source(format!(
                "#version 300 es\n\
                 in highp vec4 v_coord;\n\
                 uniform highp vec4 u_gradientMin;\n\
                 uniform highp vec4 u_gradientMax;\n\
                 layout(location = 0) out highp {t} o_color;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   highp float x = v_coord.x;\n\
                 \x20   highp float y = v_coord.y;\n\
                 \x20   highp float f0 = (x + y) * 0.5;\n\
                 \x20   highp float f1 = 0.5 + (x - y) * 0.5;\n\
                 \x20   highp vec4 fv = vec4(f0, f1, 1.0f-f0, 1.0f-f1);\n\
                 \x20   o_color = {t}(u_gradientMin + (u_gradientMax-u_gradientMin)*fv);\n\
                 }}\n",
                t = output_type.name()
            ));
        Self {
            base: ShaderProgramBase::new(&decl),
            output_type,
        }
    }
}

/// `GradientShader::setGradient`
pub fn set_gradient(ctx: &mut dyn SglrContext, program: u32, gradient_min: [f32; 4], gradient_max: [f32; 4]) {
    ctx.use_program(program);
    let min_loc = ctx.get_uniform_location(program, "u_gradientMin");
    ctx.uniform4fv(min_loc, 1, &gradient_min);
    let max_loc = ctx.get_uniform_location(program, "u_gradientMax");
    ctx.uniform4fv(max_loc, 1, &gradient_max);
}

impl VertexShader for GradientShader {
    vertex_plumbing!();

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        shade_position_and_coord(inputs, packets, true);
    }
}

impl FragmentShader for GradientShader {
    fragment_plumbing!();

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let gradient_min = self.base.uniform_by_name("u_gradientMin").value.as_f32_vec4();
        let gradient_max = self.base.uniform_by_name("u_gradientMax").value.as_f32_vec4();

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let x = coord.x();
                let y = coord.y();
                let f0 = (x + y) * 0.5;
                let f1 = 0.5 + (x - y) * 0.5;
                let fv = [f0, f1, 1.0 - f0, 1.0 - f1];

                let mut color = [0.0f32; 4];
                for i in 0..4 {
                    color[i] = gradient_min[i] + (gradient_max[i] - gradient_min[i]) * fv[i];
                }
                // SAFETY: as above.
                unsafe { write_color(context, packet_ndx, frag_ndx, self.output_type, color) };
            }
        }
    }
}

program_plumbing!(GradientShader);

// Texture2DShader

/// `genTexFragmentShader`
fn gen_tex_fragment_shader(sampler_types: &[DataType], output_type: DataType) -> String {
    let precision = "highp";
    let mut src = String::new();

    src.push_str("#version 300 es\n");
    src.push_str(&format!(
        "layout(location = 0) out highp {} o_color0;\n",
        output_type.name()
    ));
    src.push_str("in highp vec2 v_coord;\n");

    for (sampler_ndx, sampler_type) in sampler_types.iter().enumerate() {
        src.push_str(&format!(
            "uniform {precision} {} u_sampler{sampler_ndx};\n",
            sampler_type.name()
        ));
        src.push_str(&format!("uniform {precision} vec4 u_texScale{sampler_ndx};\n"));
        src.push_str(&format!("uniform {precision} vec4 u_texBias{sampler_ndx};\n"));
    }

    // Output scale & bias
    src.push_str(&format!("uniform {precision} vec4 u_outScale0;\n"));
    src.push_str(&format!("uniform {precision} vec4 u_outBias0;\n"));

    src.push_str("\nvoid main (void)\n{\n");
    src.push_str(&format!("    {precision} vec4 out0 = vec4(0.0);\n"));

    // Texture input fetch and combine.
    for in_ndx in 0..sampler_types.len() {
        src.push_str(&format!(
            "\tout0 += vec4(texture(u_sampler{in_ndx}, v_coord)) * u_texScale{in_ndx} + u_texBias{in_ndx};\n"
        ));
    }

    // Write output.
    src.push_str(&format!(
        "    o_color0 = {}(out0 * u_outScale0 + u_outBias0);\n",
        output_type.name()
    ));
    src.push_str("}\n");
    src
}

/// What `Texture2DShader::setUniforms` writes, snapshotted before the shader moves into the context.
#[derive(Clone)]
pub struct Texture2DUniforms {
    units: Vec<i32>,
    scales: Vec<[f32; 4]>,
    biases: Vec<[f32; 4]>,
    out_scale: [f32; 4],
    out_bias: [f32; 4],
}

impl Texture2DUniforms {
    /// `Texture2DShader::setUniforms`
    pub fn set_uniforms(&self, ctx: &mut dyn SglrContext, program: u32) {
        ctx.use_program(program);

        for tex_ndx in 0..self.units.len() {
            let sampler_loc = ctx.get_uniform_location(program, &format!("u_sampler{tex_ndx}"));
            ctx.uniform1i(sampler_loc, self.units[tex_ndx]);
            let scale_loc = ctx.get_uniform_location(program, &format!("u_texScale{tex_ndx}"));
            ctx.uniform4fv(scale_loc, 1, &self.scales[tex_ndx]);
            let bias_loc = ctx.get_uniform_location(program, &format!("u_texBias{tex_ndx}"));
            ctx.uniform4fv(bias_loc, 1, &self.biases[tex_ndx]);
        }

        let out_scale_loc = ctx.get_uniform_location(program, "u_outScale0");
        ctx.uniform4fv(out_scale_loc, 1, &self.out_scale);
        let out_bias_loc = ctx.get_uniform_location(program, "u_outBias0");
        ctx.uniform4fv(out_bias_loc, 1, &self.out_bias);
    }
}

/// `FboTestUtil::Texture2DShader`
pub struct Texture2DShader {
    base: ShaderProgramBase,
    samplers: Vec<Option<ResolvedSampler2D>>,
    sampler_types: Vec<DataType>,
    uniforms: Texture2DUniforms,
    output_type: DataType,
}

impl Texture2DShader {
    /// `Texture2DShader(DataTypes() << TYPE_SAMPLER_2D << ..., outputType, outScale, outBias)` with `num_samplers`
    /// float samplers.
    pub fn new(num_samplers: usize, output_type: DataType, out_scale: [f32; 4], out_bias: [f32; 4]) -> Self {
        Self::with_samplers(
            &vec![DataType::Sampler2D; num_samplers],
            output_type,
            out_scale,
            out_bias,
        )
    }

    /// `Texture2DShader(samplerTypes, outputType, outScale, outBias)` - each of `sampler_types` is `Sampler2D`,
    /// `IntSampler2D` or `UintSampler2D`.
    pub fn with_samplers(
        sampler_types: &[DataType],
        output_type: DataType,
        out_scale: [f32; 4],
        out_bias: [f32; 4],
    ) -> Self {
        let num_samplers = sampler_types.len();
        let mut decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(map_data_type_to_generic_vec_type(
                output_type,
            )))
            .vertex_source(
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec2 a_coord;\n\
                 out highp vec2 v_coord;\n\
                 void main(void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_coord;\n\
                 }\n",
            )
            .fragment_source(gen_tex_fragment_shader(sampler_types, output_type))
            .uniform(pdec::Uniform::new("u_outScale0", DataType::FloatVec4))
            .uniform(pdec::Uniform::new("u_outBias0", DataType::FloatVec4));

        for (ndx, sampler_type) in sampler_types.iter().enumerate() {
            decl = decl
                .uniform(pdec::Uniform::new(format!("u_sampler{ndx}"), *sampler_type))
                .uniform(pdec::Uniform::new(format!("u_texScale{ndx}"), DataType::FloatVec4))
                .uniform(pdec::Uniform::new(format!("u_texBias{ndx}"), DataType::FloatVec4));
        }

        Self {
            base: ShaderProgramBase::new(&decl),
            samplers: vec![None; num_samplers],
            sampler_types: sampler_types.to_vec(),
            uniforms: Texture2DUniforms {
                units: (0..num_samplers as i32).collect(),
                scales: vec![[1.0; 4]; num_samplers],
                biases: vec![[0.0; 4]; num_samplers],
                out_scale,
                out_bias,
            },
            output_type,
        }
    }

    /// `Texture2DShader::setUnit`
    pub fn set_unit(&mut self, input_ndx: usize, unit_ndx: i32) {
        self.uniforms.units[input_ndx] = unit_ndx;
    }

    /// `Texture2DShader::setTexScaleBias`
    pub fn set_tex_scale_bias(&mut self, input_ndx: usize, scale: [f32; 4], bias: [f32; 4]) {
        self.uniforms.scales[input_ndx] = scale;
        self.uniforms.biases[input_ndx] = bias;
    }

    /// `Texture2DShader::setOutScaleBias`
    pub fn set_out_scale_bias(&mut self, scale: [f32; 4], bias: [f32; 4]) {
        self.uniforms.out_scale = scale;
        self.uniforms.out_bias = bias;
    }

    /// Snapshot for `Texture2DShader::setUniforms`; call it before `createProgram` moves the shader.
    pub fn uniforms(&self) -> Texture2DUniforms {
        self.uniforms.clone()
    }
}

impl VertexShader for Texture2DShader {
    vertex_plumbing!();

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        shade_position_and_coord(inputs, packets, true);
    }
}

impl FragmentShader for Texture2DShader {
    fragment_plumbing!();

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let out_scale = self.base.uniform_by_name("u_outScale0").value.as_f32_vec4();
        let out_bias = self.base.uniform_by_name("u_outBias0").value.as_f32_vec4();

        for packet_ndx in 0..packets.len() {
            let mut colors = [[0.0f32; 4]; 4];

            for ndx in 0..self.samplers.len() {
                let scale = self
                    .base
                    .uniform_by_name(&format!("u_texScale{ndx}"))
                    .value
                    .as_f32_vec4();
                let bias = self
                    .base
                    .uniform_by_name(&format!("u_texBias{ndx}"))
                    .value
                    .as_f32_vec4();

                for frag_ndx in 0..4usize {
                    // SAFETY: the context was set up by the renderer for exactly these packets.
                    let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                    let sampled = match &self.samplers[ndx] {
                        Some(sampler) => match self.sampler_types[ndx] {
                            DataType::IntSampler2D => sampler.sample_int(coord.x(), coord.y(), 0.0).map(|v| v as f32),
                            DataType::UintSampler2D => sampler.sample_uint(coord.x(), coord.y(), 0.0).map(|v| v as f32),
                            _ => sampler.sample(coord.x(), coord.y(), 0.0),
                        },
                        None => [0.0; 4],
                    };
                    for c in 0..4 {
                        colors[frag_ndx][c] += sampled[c] * scale[c] + bias[c];
                    }
                }
            }

            for frag_ndx in 0..4usize {
                let mut color = [0.0f32; 4];
                for c in 0..4 {
                    color[c] = colors[frag_ndx][c] * out_scale[c] + out_bias[c];
                }
                // SAFETY: as above.
                unsafe { write_color(context, packet_ndx, frag_ndx, self.output_type, color) };
            }
        }
    }
}

impl ShaderProgram for Texture2DShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            for ndx in 0..self.samplers.len() {
                if *name == format!("u_sampler{ndx}") {
                    self.samplers[ndx] = sampler.as_ref().and_then(ResolvedSampler::as_2d).cloned();
                }
            }
        }
    }
}

// TextureCubeShader / Texture2DArrayShader / Texture3DShader

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum TextureNdKind {
    Cube,
    Array,
    ThreeD,
}

/// `FboTestUtil::TextureCubeShader`, `Texture2DArrayShader` and `Texture3DShader` - they differ only in the
/// third coordinate (`u_coordMat * (a_coord, 1)`, `u_layer`, `u_depth`) and the sampler type.
pub struct TextureNdShader {
    base: ShaderProgramBase,
    kind: TextureNdKind,
    sampler: Option<ResolvedSampler>,
    sampler_type: DataType,
    output_type: DataType,
}

impl TextureNdShader {
    fn build(kind: TextureNdKind, sampler_type: DataType, output_type: DataType) -> Self {
        let (extra_uniform, vertex_source, coord_expr) = match kind {
            TextureNdKind::Cube => (
                pdec::Uniform::new("u_coordMat", DataType::FloatMat3),
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in mediump vec2 a_coord;\n\
                 uniform mat3 u_coordMat;\n\
                 out mediump vec3 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = u_coordMat * vec3(a_coord, 1.0);\n\
                 }\n",
                "v_coord",
            ),
            TextureNdKind::Array => (
                pdec::Uniform::new("u_layer", DataType::Int),
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec2 a_coord;\n\
                 out highp vec2 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_coord;\n\
                 }\n",
                "vec3(v_coord, u_layer)",
            ),
            TextureNdKind::ThreeD => (
                pdec::Uniform::new("u_depth", DataType::Float),
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec2 a_coord;\n\
                 out highp vec2 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_coord;\n\
                 }\n",
                "vec3(v_coord, u_depth)",
            ),
        };
        let (extra_decl, varying_decl) = match kind {
            TextureNdKind::Cube => (String::new(), "in mediump vec3 v_coord;\n"),
            TextureNdKind::Array => ("uniform highp int u_layer;\n".to_string(), "in highp vec2 v_coord;\n"),
            TextureNdKind::ThreeD => ("uniform highp float u_depth;\n".to_string(), "in highp vec2 v_coord;\n"),
        };

        let fragment_source = format!(
            "#version 300 es\n\
             uniform highp {sampler} u_sampler0;\n\
             uniform highp vec4 u_scale;\n\
             uniform highp vec4 u_bias;\n\
             {extra_decl}{varying_decl}\
             layout(location = 0) out highp {output} o_color;\n\
             void main (void)\n\
             {{\n\
             \x20   o_color = {output}(vec4(texture(u_sampler0, {coord_expr})) * u_scale + u_bias);\n\
             }}\n",
            sampler = sampler_type.name(),
            output = output_type.name(),
        );

        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(map_data_type_to_generic_vec_type(
                output_type,
            )))
            .uniform(extra_uniform)
            .uniform(pdec::Uniform::new("u_sampler0", sampler_type))
            .uniform(pdec::Uniform::new("u_scale", DataType::FloatVec4))
            .uniform(pdec::Uniform::new("u_bias", DataType::FloatVec4))
            .vertex_source(vertex_source)
            .fragment_source(fragment_source);

        Self {
            base: ShaderProgramBase::new(&decl),
            kind,
            sampler: None,
            sampler_type,
            output_type,
        }
    }

    /// `TextureCubeShader(samplerType, outputType)`
    pub fn cube(sampler_type: DataType, output_type: DataType) -> Self {
        Self::build(TextureNdKind::Cube, sampler_type, output_type)
    }

    /// `Texture2DArrayShader(samplerType, outputType)`
    pub fn array(sampler_type: DataType, output_type: DataType) -> Self {
        Self::build(TextureNdKind::Array, sampler_type, output_type)
    }

    /// `Texture3DShader(samplerType, outputType)`
    pub fn three_d(sampler_type: DataType, output_type: DataType) -> Self {
        Self::build(TextureNdKind::ThreeD, sampler_type, output_type)
    }

    fn sample(&self, s: f32, t: f32, r: f32) -> [f32; 4] {
        let Some(sampler) = &self.sampler else { return [0.0; 4] };
        let as_f32 = |v: [i32; 4]| [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32];
        let as_f32_u = |v: [u32; 4]| [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32];
        match self.kind {
            TextureNdKind::Cube => {
                let Some(sampler) = sampler.as_cube() else {
                    return [0.0; 4];
                };
                match self.sampler_type {
                    DataType::IntSamplerCube => as_f32(sampler.sample_int(s, t, r, 0.0)),
                    DataType::UintSamplerCube => as_f32_u(sampler.sample_uint(s, t, r, 0.0)),
                    _ => sampler.sample(s, t, r, 0.0),
                }
            }
            TextureNdKind::Array => {
                let Some(sampler) = sampler.as_2d_array() else {
                    return [0.0; 4];
                };
                match self.sampler_type {
                    DataType::IntSampler2DArray => as_f32(sampler.sample_int(s, t, r, 0.0)),
                    DataType::UintSampler2DArray => as_f32_u(sampler.sample_uint(s, t, r, 0.0)),
                    _ => sampler.sample(s, t, r, 0.0),
                }
            }
            TextureNdKind::ThreeD => {
                let Some(sampler) = sampler.as_3d() else {
                    return [0.0; 4];
                };
                match self.sampler_type {
                    DataType::IntSampler3D => as_f32(sampler.sample_int(s, t, r, 0.0)),
                    DataType::UintSampler3D => as_f32_u(sampler.sample_uint(s, t, r, 0.0)),
                    _ => sampler.sample(s, t, r, 0.0),
                }
            }
        }
    }
}

impl VertexShader for TextureNdShader {
    vertex_plumbing!();

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        if self.kind != TextureNdKind::Cube {
            shade_position_and_coord(inputs, packets, true);
            return;
        }

        let m = match self.base.uniform_by_name("u_coordMat").value {
            crate::sglr::shader_program::UniformValue::Mat3(m) => m,
            ref other => panic!("u_coordMat is not a mat3: {other:?}"),
        };
        for packet in packets.iter_mut() {
            let a_coord = read_attrib(inputs, 1, packet);
            let (cx, cy) = (a_coord.x(), a_coord.y());
            let v_coord = [
                m[0] * cx + m[1] * cy + m[2],
                m[3] * cx + m[4] * cy + m[5],
                m[6] * cx + m[7] * cy + m[8],
            ];

            packet.position = read_attrib(inputs, 0, packet);
            packet.outputs[0] = GenericVec4::from_float(Vec4::new(v_coord[0], v_coord[1], v_coord[2], 0.0));
        }
    }
}

impl FragmentShader for TextureNdShader {
    fragment_plumbing!();

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let tex_scale = self.base.uniform_by_name("u_scale").value.as_f32_vec4();
        let tex_bias = self.base.uniform_by_name("u_bias").value.as_f32_vec4();
        let layer = if self.kind == TextureNdKind::Array {
            self.base.uniform_by_name("u_layer").value.as_i32()
        } else {
            0
        };
        let depth = if self.kind == TextureNdKind::ThreeD {
            self.base.uniform_by_name("u_depth").value.as_f32()
        } else {
            0.0
        };

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let sampled = match self.kind {
                    TextureNdKind::Cube => self.sample(coord.x(), coord.y(), coord.z()),
                    TextureNdKind::Array => self.sample(coord.x(), coord.y(), layer as f32),
                    TextureNdKind::ThreeD => self.sample(coord.x(), coord.y(), depth),
                };
                let mut color = [0.0f32; 4];
                for c in 0..4 {
                    color[c] = sampled[c] * tex_scale[c] + tex_bias[c];
                }
                // SAFETY: as above.
                unsafe { write_color(context, packet_ndx, frag_ndx, self.output_type, color) };
            }
        }
    }
}

impl ShaderProgram for TextureNdShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler = sampler.clone();
            }
        }
    }
}

fn set_scale_bias(ctx: &mut dyn SglrContext, program: u32, scale: [f32; 4], bias: [f32; 4]) {
    let scale_loc = ctx.get_uniform_location(program, "u_scale");
    ctx.uniform4fv(scale_loc, 1, &scale);
    let bias_loc = ctx.get_uniform_location(program, "u_bias");
    ctx.uniform4fv(bias_loc, 1, &bias);
}

/// `TextureCubeShader::setFace` + `setTexScaleBias` + `setUniforms`.
pub fn set_cube_uniforms(ctx: &mut dyn SglrContext, program: u32, face: CubeFace, scale: [f32; 4], bias: [f32; 4]) {
    // Row-major, indexed by `CubeFace` (-X, +X, -Y, +Y, -Z, +Z).
    const CUBE_TRANSFORMS: [[f32; 9]; 6] = [
        // Face -X: (x, y, 1) -> (-1, -(2*y-1), +(2*x-1))
        [0.0, 0.0, -1.0, 0.0, -2.0, 1.0, 2.0, 0.0, -1.0],
        // Face +X: (x, y, 1) -> (+1, -(2*y-1), -(2*x-1))
        [0.0, 0.0, 1.0, 0.0, -2.0, 1.0, -2.0, 0.0, 1.0],
        // Face -Y: (x, y, 1) -> (+(2*x-1), -1, -(2*y-1))
        [2.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, -2.0, 1.0],
        // Face +Y: (x, y, 1) -> (+(2*x-1), +1, +(2*y-1))
        [2.0, 0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 2.0, -1.0],
        // Face -Z: (x, y, 1) -> (-(2*x-1), -(2*y-1), -1)
        [-2.0, 0.0, 1.0, 0.0, -2.0, 1.0, 0.0, 0.0, -1.0],
        // Face +Z: (x, y, 1) -> (+(2*x-1), -(2*y-1), +1)
        [2.0, 0.0, -1.0, 0.0, -2.0, 1.0, 0.0, 0.0, 1.0],
    ];

    let row_major = CUBE_TRANSFORMS[face as usize];
    let mut column_major = [0.0f32; 9];
    for row in 0..3 {
        for col in 0..3 {
            column_major[col * 3 + row] = row_major[row * 3 + col];
        }
    }

    ctx.use_program(program);
    let sampler_loc = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(sampler_loc, 0);
    let mat_loc = ctx.get_uniform_location(program, "u_coordMat");
    ctx.uniform_matrix3fv(mat_loc, 1, false, &column_major);
    set_scale_bias(ctx, program, scale, bias);
}

/// `Texture2DArrayShader::setLayer` + `setTexScaleBias` + `setUniforms`.
pub fn set_array_uniforms(ctx: &mut dyn SglrContext, program: u32, layer: i32, scale: [f32; 4], bias: [f32; 4]) {
    ctx.use_program(program);
    let sampler_loc = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(sampler_loc, 0);
    let layer_loc = ctx.get_uniform_location(program, "u_layer");
    ctx.uniform1i(layer_loc, layer);
    set_scale_bias(ctx, program, scale, bias);
}

/// `Texture3DShader::setDepth` + `setTexScaleBias` + `setUniforms`.
pub fn set_3d_uniforms(ctx: &mut dyn SglrContext, program: u32, depth: f32, scale: [f32; 4], bias: [f32; 4]) {
    ctx.use_program(program);
    let sampler_loc = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(sampler_loc, 0);
    let depth_loc = ctx.get_uniform_location(program, "u_depth");
    ctx.uniform1f(depth_loc, depth);
    set_scale_bias(ctx, program, scale, bias);
}

/// `glu::getSamplerCubeType`
pub fn get_sampler_cube_type(format: TextureFormat) -> DataType {
    match channel_class(format.type_) {
        ChannelClass::Float | ChannelClass::Fixed => DataType::SamplerCube,
        ChannelClass::Uint => DataType::UintSamplerCube,
        ChannelClass::Int => DataType::IntSamplerCube,
    }
}

/// `glu::getSampler2DArrayType`
pub fn get_sampler_2d_array_type(format: TextureFormat) -> DataType {
    match channel_class(format.type_) {
        ChannelClass::Float | ChannelClass::Fixed => DataType::Sampler2DArray,
        ChannelClass::Uint => DataType::UintSampler2DArray,
        ChannelClass::Int => DataType::IntSampler2DArray,
    }
}

/// `glu::getSampler3DType`
pub fn get_sampler_3d_type(format: TextureFormat) -> DataType {
    match channel_class(format.type_) {
        ChannelClass::Float | ChannelClass::Fixed => DataType::Sampler3D,
        ChannelClass::Uint => DataType::UintSampler3D,
        ChannelClass::Int => DataType::IntSampler3D,
    }
}

// DepthGradientShader

/// `FboTestUtil::DepthGradientShader`
pub struct DepthGradientShader {
    base: ShaderProgramBase,
    output_type: DataType,
}

impl DepthGradientShader {
    pub fn new(output_type: DataType) -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(map_data_type_to_generic_vec_type(
                output_type,
            )))
            .uniform(pdec::Uniform::new("u_maxGradient", DataType::Float))
            .uniform(pdec::Uniform::new("u_minGradient", DataType::Float))
            .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
            .vertex_source(
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec4 a_coord;\n\
                 out highp vec4 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_coord;\n\
                 }\n",
            )
            .fragment_source(format!(
                "#version 300 es\n\
                 in highp vec4 v_coord;\n\
                 uniform highp float u_minGradient;\n\
                 uniform highp float u_maxGradient;\n\
                 uniform highp vec4 u_color;\n\
                 layout(location = 0) out highp {t} o_color;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   highp float x = v_coord.x;\n\
                 \x20   highp float y = v_coord.y;\n\
                 \x20   highp float f0 = (x + y) * 0.5;\n\
                 \x20   gl_FragDepth = u_minGradient + (u_maxGradient-u_minGradient)*f0;\n\
                 \x20   o_color = {t}(u_color);\n\
                 }}\n",
                t = output_type.name()
            ));
        Self {
            base: ShaderProgramBase::new(&decl),
            output_type,
        }
    }
}

/// `DepthGradientShader::setUniforms`
pub fn set_depth_gradient_uniforms(
    ctx: &mut dyn SglrContext,
    program: u32,
    gradient_min: f32,
    gradient_max: f32,
    color: [f32; 4],
) {
    ctx.use_program(program);
    let min_loc = ctx.get_uniform_location(program, "u_minGradient");
    ctx.uniform1fv(min_loc, 1, &[gradient_min]);
    let max_loc = ctx.get_uniform_location(program, "u_maxGradient");
    ctx.uniform1fv(max_loc, 1, &[gradient_max]);
    let color_loc = ctx.get_uniform_location(program, "u_color");
    ctx.uniform4fv(color_loc, 1, &color);
}

impl VertexShader for DepthGradientShader {
    vertex_plumbing!();

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        shade_position_and_coord(inputs, packets, true);
    }
}

impl FragmentShader for DepthGradientShader {
    fragment_plumbing!();

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let gradient_min = self.base.uniform_by_name("u_minGradient").value.as_f32();
        let gradient_max = self.base.uniform_by_name("u_maxGradient").value.as_f32();
        let color = self.base.uniform_by_name("u_color").value.as_f32_vec4();

        // Running this shader without a depth buffer does not make any sense.
        debug_assert!(!context.fragment_depths.is_null());

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let f0 = (coord.x() + coord.y()) * 0.5;

                if !context.fragment_depths.is_null() {
                    // SAFETY: as above, and the depth array was checked to exist.
                    unsafe {
                        write_fragment_depth(
                            context,
                            packet_ndx as i32,
                            frag_ndx as i32,
                            0,
                            gradient_min + (gradient_max - gradient_min) * f0,
                        )
                    };
                }
                // SAFETY: as above.
                unsafe { write_color(context, packet_ndx, frag_ndx, self.output_type, color) };
            }
        }
    }
}

program_plumbing!(DepthGradientShader);

// Utility functions

/// `getFboIncompleteReasonName`
fn fbo_incomplete_reason_name(reason: GLenum) -> &'static str {
    match reason {
        glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT",
        glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT",
        glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS => "GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS",
        glw::GL_FRAMEBUFFER_UNSUPPORTED => "GL_FRAMEBUFFER_UNSUPPORTED",
        glw::GL_FRAMEBUFFER_COMPLETE => "GL_FRAMEBUFFER_COMPLETE",
        _ => "UNKNOWN",
    }
}

/// `FboIncompleteException`, as `FboTestCase::iterate` ends up treating it: `GL_FRAMEBUFFER_UNSUPPORTED`
/// is NotSupported and any other status is rethrown as a failure.
pub fn fbo_incomplete_error(reason: GLenum) -> TestError {
    let message = format!("Framebuffer is not complete: {}", fbo_incomplete_reason_name(reason));
    if reason == glw::GL_FRAMEBUFFER_UNSUPPORTED {
        TestError::NotSupported(message)
    } else {
        TestError::Fail(message)
    }
}

/// `getFormatName`
pub fn get_format_name(format: GLenum) -> &'static str {
    match format {
        glw::GL_RGB565 => "rgb565",
        glw::GL_RGB5_A1 => "rgb5_a1",
        glw::GL_RGBA4 => "rgba4",
        glw::GL_DEPTH_COMPONENT16 => "depth_component16",
        glw::GL_STENCIL_INDEX8 => "stencil_index8",
        glw::GL_RGBA32F => "rgba32f",
        glw::GL_RGBA32I => "rgba32i",
        glw::GL_RGBA32UI => "rgba32ui",
        glw::GL_RGBA16F => "rgba16f",
        glw::GL_RGBA16I => "rgba16i",
        glw::GL_RGBA16UI => "rgba16ui",
        glw::GL_RGBA8 => "rgba8",
        glw::GL_RGBA8I => "rgba8i",
        glw::GL_RGBA8UI => "rgba8ui",
        glw::GL_SRGB8_ALPHA8 => "srgb8_alpha8",
        glw::GL_RGB10_A2 => "rgb10_a2",
        glw::GL_RGB10_A2UI => "rgb10_a2ui",
        glw::GL_RGBA8_SNORM => "rgba8_snorm",
        glw::GL_RGB8 => "rgb8",
        glw::GL_R11F_G11F_B10F => "r11f_g11f_b10f",
        glw::GL_RGB32F => "rgb32f",
        glw::GL_RGB32I => "rgb32i",
        glw::GL_RGB32UI => "rgb32ui",
        glw::GL_RGB16F => "rgb16f",
        glw::GL_RGB16I => "rgb16i",
        glw::GL_RGB16UI => "rgb16ui",
        glw::GL_RGB8_SNORM => "rgb8_snorm",
        glw::GL_RGB8I => "rgb8i",
        glw::GL_RGB8UI => "rgb8ui",
        glw::GL_SRGB8 => "srgb8",
        glw::GL_RGB9_E5 => "rgb9_e5",
        glw::GL_RG32F => "rg32f",
        glw::GL_RG32I => "rg32i",
        glw::GL_RG32UI => "rg32ui",
        glw::GL_RG16F => "rg16f",
        glw::GL_RG16I => "rg16i",
        glw::GL_RG16UI => "rg16ui",
        glw::GL_RG8 => "rg8",
        glw::GL_RG8I => "rg8i",
        glw::GL_RG8UI => "rg8ui",
        glw::GL_RG8_SNORM => "rg8_snorm",
        glw::GL_R32F => "r32f",
        glw::GL_R32I => "r32i",
        glw::GL_R32UI => "r32ui",
        glw::GL_R16F => "r16f",
        glw::GL_R16I => "r16i",
        glw::GL_R16UI => "r16ui",
        glw::GL_R8 => "r8",
        glw::GL_R8I => "r8i",
        glw::GL_R8UI => "r8ui",
        glw::GL_R8_SNORM => "r8_snorm",
        glw::GL_DEPTH_COMPONENT32F => "depth_component32f",
        glw::GL_DEPTH_COMPONENT24 => "depth_component24",
        glw::GL_DEPTH32F_STENCIL8 => "depth32f_stencil8",
        glw::GL_DEPTH24_STENCIL8 => "depth24_stencil8",
        other => panic!("Unknown format {other:#x}"),
    }
}

/// `clearColorBuffer`
pub fn clear_color_buffer(ctx: &mut dyn SglrContext, format: TextureFormat, value: [f32; 4]) {
    use ChannelType::*;

    match format.type_ {
        SIGNED_INT8 | SIGNED_INT16 | SIGNED_INT32 => {
            let v = [
                saturate_i32(value[0]),
                saturate_i32(value[1]),
                saturate_i32(value[2]),
                saturate_i32(value[3]),
            ];
            ctx.clear_buffer_iv(glw::GL_COLOR, 0, &v);
        }
        UNSIGNED_INT8 | UNSIGNED_INT16 | UNSIGNED_INT32 | UNSIGNED_INT_1010102_REV => {
            let v = [
                saturate_u32(value[0]),
                saturate_u32(value[1]),
                saturate_u32(value[2]),
                saturate_u32(value[3]),
            ];
            ctx.clear_buffer_uiv(glw::GL_COLOR, 0, &v);
        }
        _ => ctx.clear_buffer_fv(glw::GL_COLOR, 0, &value),
    }
}

/// `readPixels` - reads through `getFramebufferReadFormat` (RGBA8 for fixed point, RGBA float/int32/uint32
/// otherwise) and converts every pixel to `value * scale + bias` in the 8-bit `Surface`.
#[allow(clippy::too_many_arguments)]
pub fn read_pixels(
    ctx: &mut dyn SglrContext,
    dst: &mut Surface,
    x: i32,
    y: i32,
    width: i32,
    height: i32,
    format: TextureFormat,
    scale: [f32; 4],
    bias: [f32; 4],
) -> Result<(), TestError> {
    let type_ = match channel_class(format.type_) {
        ChannelClass::Fixed => {
            // RGBA8 read: the 8-bit values are already what the Surface stores. A non-identity scale/bias on a
            // fixed-point format never happens in the ported cases.
            if scale != [1.0; 4] || bias != [0.0; 4] {
                return Err(TestError::NotSupported(
                    "FboTestUtil::readPixels: scale/bias on a fixed-point read is not ported".to_string(),
                ));
            }
            dst.set_size(width, height);
            ctx.read_pixels(dst, x, y, width, height);
            return Ok(());
        }
        ChannelClass::Float => glw::GL_FLOAT,
        ChannelClass::Int => glw::GL_INT,
        ChannelClass::Uint => glw::GL_UNSIGNED_INT,
    };

    let pixels = ctx.read_pixels_rgba_f32(x, y, width, height, type_);
    dst.set_size(width, height);
    if pixels.len() != (width * height) as usize {
        return Err(TestError::Fail("glReadPixels failed".to_string()));
    }

    for yo in 0..height {
        for xo in 0..width {
            let p = pixels[(yo * width + xo) as usize];
            let v = Vec4::new(
                p[0] * scale[0] + bias[0],
                p[1] * scale[1] + bias[1],
                p[2] * scale[2] + bias[2],
                p[3] * scale[3] + bias[3],
            );
            dst.set_pixel(xo, yo, RGBA::from_vec(v));
        }
    }
    Ok(())
}

/// `tcu::TextureChannelClass`, collapsed to the four cases `FboTestUtil` distinguishes.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ChannelClass {
    Float,
    Fixed,
    Int,
    Uint,
}

/// `tcu::getTextureChannelClass`
pub fn channel_class(type_: ChannelType) -> ChannelClass {
    use ChannelType::*;

    match type_ {
        HALF_FLOAT
        | FLOAT
        | FLOAT64
        | UNSIGNED_INT_11F_11F_10F_REV
        | UNSIGNED_INT_999_E5_REV
        | FLOAT_UNSIGNED_INT_24_8_REV => ChannelClass::Float,
        SIGNED_INT8 | SIGNED_INT16 | SIGNED_INT32 | SIGNED_INT64 | SIGNED_INT_1010102_REV => ChannelClass::Int,
        UNSIGNED_INT8
        | UNSIGNED_INT16
        | UNSIGNED_INT24
        | UNSIGNED_INT32
        | UNSIGNED_INT64
        | UNSIGNED_INT_1010102_REV => ChannelClass::Uint,
        _ => ChannelClass::Fixed,
    }
}

/// `glu::getSampler2DType`
pub fn get_sampler_2d_type(format: TextureFormat) -> DataType {
    match channel_class(format.type_) {
        ChannelClass::Float | ChannelClass::Fixed => DataType::Sampler2D,
        ChannelClass::Uint => DataType::UintSampler2D,
        ChannelClass::Int => DataType::IntSampler2D,
    }
}

/// `getFragmentOutputType`
pub fn get_fragment_output_type(format: TextureFormat) -> DataType {
    match channel_class(format.type_) {
        ChannelClass::Float | ChannelClass::Fixed => DataType::FloatVec4,
        ChannelClass::Uint => DataType::UintVec4,
        ChannelClass::Int => DataType::IntVec4,
    }
}

/// `calculateU8ConversionError`
fn calculate_u8_conversion_error(src_bits: i32) -> i32 {
    if src_bits > 0 {
        let clamped_bits = src_bits.clamp(0, 8);
        let src_max_value = ((1 << clamped_bits) - 1).max(1);
        let error = (255.0f32 * 2.0 / src_max_value as f32).ceil() as i32;
        error.clamp(0, 255)
    } else {
        1
    }
}

/// `getFormatThreshold(const tcu::TextureFormat&)`
pub fn get_format_threshold(format: TextureFormat) -> [u8; 4] {
    let bits = crate::tcu::pixel::get_texture_format_mantissa_bit_depth(format);
    [
        calculate_u8_conversion_error(bits[0]) as u8,
        calculate_u8_conversion_error(bits[1]) as u8,
        calculate_u8_conversion_error(bits[2]) as u8,
        calculate_u8_conversion_error(bits[3]) as u8,
    ]
}

/// `getFormatThreshold(uint32_t glFormat)`
pub fn get_format_threshold_gl(gl_format: GLenum) -> Result<[u8; 4], TestError> {
    let format = crate::glu::texture_util::map_gl_internal_format(gl_format)
        .ok_or_else(|| TestError::Fail(format!("unknown internal format {gl_format:#x}")))?;
    Ok(get_format_threshold(format))
}

/// `getToSRGB8ConversionError`
fn get_to_srgb8_conversion_error(src_bits: i32) -> i32 {
    // These are pre-computed based on simulation results.
    const ERRORS: [i32; 13] = [
        1,   // 0 bits - rounding
        255, // 1 bits
        157, // 2 bits
        106, // 3 bits
        74,  // 4 bits
        51,  // 5 bits
        34,  // 6 bits
        22,  // 7 bits
        13,  // 8 bits
        7,   // 9 bits
        4,   // 10 bits
        3,   // 11 bits
        2,   // 12 bits
    ];

    debug_assert!(src_bits >= 0);
    if (src_bits as usize) < ERRORS.len() {
        ERRORS[src_bits as usize]
    } else {
        1
    }
}

/// `getToSRGBConversionThreshold` - only `SRGB8` and `SRGB8_ALPHA8` destinations are supported.
pub fn get_to_srgb_conversion_threshold(src: TextureFormat, dst: TextureFormat) -> [u8; 4] {
    debug_assert!(dst.type_ == ChannelType::UNORM_INT8 && dst.order.is_srgb());

    let bits = crate::tcu::pixel::get_texture_format_mantissa_bit_depth(src);
    let dst_has_alpha = dst.order == crate::tcu::ChannelOrder::sRGBA;

    [
        get_to_srgb8_conversion_error(bits[0]) as u8,
        get_to_srgb8_conversion_error(bits[1]) as u8,
        get_to_srgb8_conversion_error(bits[2]) as u8,
        if dst_has_alpha {
            calculate_u8_conversion_error(bits[3]) as u8
        } else {
            0
        },
    ]
}
