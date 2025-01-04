// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureSpecificationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `TextureSpecCase` derives from
// `sglr::ContextWrapper` and calls the virtual `createTexture()` once against the real
// driver (`sglr::GLContext`) and once against `sglr::ReferenceContext`; here the twelve
// subclasses are one `TextureSpecCase` with a `Spec` enum and `create_texture` takes the
// context to run against. The per-context shaders (`Tex2DShader`, six `TexCubeShader`s,
// `GradientShader`) are rebuilt for every render because `create_program` moves them into
// the context.
//
// `basic_copyteximage2d` and `basic_copytexsubimage2d` go through sglr's `copy_tex_image_2d`/`copy_tex_sub_image_2d`; the ES 2.0
// cases use `Es2GradientShader`, the ES 3.0 ones `fbo_test_util`'s `GradientShader`.
//
// The `es3` flag, `internal_format` field and `Spec::TexImageParams` are for the ES 3.0 module's 2D/cube
// subset (`gles3::functional::texture::specification`), which builds its cases through `make_es3_case`.

use crate::gles3::functional::fbo::fbo_test_util::{GradientShader, set_gradient};
use crate::gles3::functional::texture::spec_shaders;
use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::shader_util::DataType;
use crate::glu::texture_test_util_surface::fill_with_component_gradients_old;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glu::{Context, RenderTarget, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
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
use crate::sglr::gl_context::GLContext;
use crate::sglr::reference_context::{ResolvedSampler, ResolvedSampler2D, ResolvedSamplerCube};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    DepthStencilMode, PixelBufferAccess, TextureLevel, fill_with_component_gradients2, fill_with_grid,
    get_effective_depth_stencil_texture_format, get_texture_format_bit_depth, get_texture_format_info,
};
use crate::tcu::surface::Surface;
use crate::tcu::texture::{ChannelOrder, TextureFormat};
use crate::tcu::vector::{UVec4, Vec3, Vec4};
use crate::tcu::{PixelFormat, Random, TestError, TestOutcome, TestStatus, de_string_hash};

const ALL_BUFFER_BITS: u32 = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;

const CUBE_MAP_FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

fn log2_floor(value: i32) -> i32 {
    31 - (value as u32).leading_zeros() as i32
}

/// `getPixelFormatCompareDepth`
fn get_pixel_format_compare_depth(pixel_format: PixelFormat, texture_format: TextureFormat) -> [i32; 4] {
    match texture_format.order {
        ChannelOrder::L | ChannelOrder::LA => [
            pixel_format.red_bits,
            pixel_format.red_bits,
            pixel_format.red_bits,
            pixel_format.alpha_bits,
        ],
        _ => [
            pixel_format.red_bits,
            pixel_format.green_bits,
            pixel_format.blue_bits,
            pixel_format.alpha_bits,
        ],
    }
}

/// `computeCompareThreshold`
fn compute_compare_threshold(pixel_format: PixelFormat, texture_format: TextureFormat) -> UVec4 {
    // When sampling a depth-stencil texture, just the depth component is sampled.
    let effective_format = if texture_format.order == ChannelOrder::DS {
        get_effective_depth_stencil_texture_format(texture_format, DepthStencilMode::Depth)
    } else {
        texture_format
    };
    let tex_format_bits = get_texture_format_bit_depth(effective_format);
    let pixel_format_bits = get_pixel_format_compare_depth(pixel_format, texture_format);
    let threshold: [u32; 4] = std::array::from_fn(|c| {
        let accurate_fmt_bits = pixel_format_bits[c].min(tex_format_bits[c]);
        let compare_bits = (if accurate_fmt_bits > 0 { accurate_fmt_bits } else { 8 }) - 1;
        1u32 << (8 - compare_bits)
    });
    UVec4::from_array(threshold)
}

// Shaders.

const TEXTURE_VERTEX_SOURCE: &str = "attribute highp vec4 a_position;\n\
     attribute mediump vec2 a_coord;\n\
     varying mediump vec2 v_coord;\n\
     void main (void)\n\
     {\n\
     \x20   gl_Position = a_position;\n\
     \x20   v_coord = a_coord;\n\
     }\n";

fn texture_vertex_shade(inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
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

fn texture_declaration(sampler: DataType, fragment_source: String) -> pdec::ShaderProgramDeclaration {
    pdec::ShaderProgramDeclaration::new()
        .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
        .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
        .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
        .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
        .uniform(pdec::Uniform::new("u_sampler0", sampler))
        .vertex_source(TEXTURE_VERTEX_SOURCE.to_string())
        .fragment_source(fragment_source)
}

/// `GradientShader` (ES 2.0 flavour: GLSL ES 1.00, gradient fixed to [0, 1]).
struct Es2GradientShader {
    base: ShaderProgramBase,
}

impl Es2GradientShader {
    fn new() -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source(TEXTURE_VERTEX_SOURCE.to_string())
            .fragment_source(
                "varying mediump vec2 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   mediump float x = v_coord.x;\n\
                 \x20   mediump float y = v_coord.y;\n\
                 \x20   mediump float f0 = (x + y) * 0.5;\n\
                 \x20   mediump float f1 = 0.5 + (x - y) * 0.5;\n\
                 \x20   gl_FragColor = vec4(f0, f1, 1.0-f0, 1.0-f1);\n\
                 }\n"
                .to_string(),
            );
        Self {
            base: ShaderProgramBase::new(&decl),
        }
    }
}

impl VertexShader for Es2GradientShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        texture_vertex_shade(inputs, packets);
    }
}

impl FragmentShader for Es2GradientShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let (x, y) = (coord.x(), coord.y());
                let f0 = (x + y) * 0.5;
                let f1 = 0.5 + (x - y) * 0.5;
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(Vec4::new(f0, f1, 1.0 - f0, 1.0 - f1)),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for Es2GradientShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

/// `Tex2DShader`
struct Tex2DShader {
    base: ShaderProgramBase,
    sampler0: Option<ResolvedSampler2D>,
}

impl Tex2DShader {
    fn new() -> Self {
        let decl = texture_declaration(
            DataType::Sampler2D,
            "uniform sampler2D u_sampler0;\n\
             varying mediump vec2 v_coord;\n\
             void main (void)\n\
             {\n\
             \x20   gl_FragColor = texture2D(u_sampler0, v_coord);\n\
             }\n"
            .to_string(),
        );
        Self {
            base: ShaderProgramBase::new(&decl),
            sampler0: None,
        }
    }
}

impl VertexShader for Tex2DShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        texture_vertex_shade(inputs, packets);
    }
}

impl FragmentShader for Tex2DShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
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
                let color = match &self.sampler0 {
                    Some(sampler) => sampler.sample_2d_quad(
                        coord.x(),
                        coord.y(),
                        (dfdx[frag_ndx].x(), dfdx[frag_ndx].y()),
                        (dfdy[frag_ndx].x(), dfdy[frag_ndx].y()),
                    ),
                    None => [0.0; 4],
                };
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(Vec4::new(color[0], color[1], color[2], color[3])),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for Tex2DShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler0 = sampler.as_ref().and_then(ResolvedSampler::as_2d).cloned();
            }
        }
    }
}

const CUBE_SWIZZLES: [&str; 6] = [
    "vec3(-1, -y, +x)",
    "vec3(+1, -y, -x)",
    "vec3(+x, -1, -y)",
    "vec3(+x, +1, +y)",
    "vec3(-x, -y, -1)",
    "vec3(+x, -y, +1)",
];

/// `TexCubeShader`
struct TexCubeShader {
    base: ShaderProgramBase,
    sampler0: Option<ResolvedSamplerCube>,
    face: usize,
}

impl TexCubeShader {
    fn new(face: usize) -> Self {
        let decl = texture_declaration(
            DataType::SamplerCube,
            format!(
                "uniform samplerCube u_sampler0;\n\
                 varying mediump vec2 v_coord;\n\
                 void main (void)\n\
                 {{\n\
                 \x20   mediump float x = v_coord.x*2.0 - 1.0;\n\
                 \x20   mediump float y = v_coord.y*2.0 - 1.0;\n\
                 \x20   gl_FragColor = textureCube(u_sampler0, {});\n\
                 }}\n",
                CUBE_SWIZZLES[face]
            ),
        );
        Self {
            base: ShaderProgramBase::new(&decl),
            sampler0: None,
            face,
        }
    }

    /// The face's own `(x, y)` -> direction swizzle; faces are in `tcu::CubeFace` order.
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

impl VertexShader for TexCubeShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        texture_vertex_shade(inputs, packets);
    }
}

impl FragmentShader for TexCubeShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            // Swizzled direction of each fragment of the quad.
            let mut dirs = [[0.0f32; 3]; 4];
            for (frag_ndx, dir) in dirs.iter_mut().enumerate() {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                *dir = self.direction(coord.x() * 2.0 - 1.0, coord.y() * 2.0 - 1.0);
            }

            for frag_ndx in 0..4usize {
                let color = match &self.sampler0 {
                    Some(sampler) => sampler.sample_cube_packet(frag_ndx, &dirs),
                    None => [0.0; 4],
                };
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(Vec4::new(color[0], color[1], color[2], color[3])),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for TexCubeShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler0 = sampler.as_ref().and_then(ResolvedSampler::as_cube).cloned();
            }
        }
    }
}

/// `Tex2DShader::setUniforms` / `TexCubeShader::setUniforms`
fn set_uniforms(ctx: &mut dyn SglrContext, program: u32) {
    ctx.use_program(program);
    let location = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(location, 0);
}

// Cases.

#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum TextureType {
    Tex2D,
    Cube,
    /// `GL_TEXTURE_2D_ARRAY`; `TextureSpecCase::depth` is the layer count.
    Array,
    /// `GL_TEXTURE_3D`; `TextureSpecCase::depth` is the depth.
    ThreeD,
}

/// One entry per upstream `TextureSpecCase` subclass that is ported.
#[derive(Clone, Copy)]
pub(crate) enum Spec {
    BasicTexImage,
    RandomOrderTexImage,
    TexImageAlign {
        alignment: i32,
    },
    BasicTexSubImage,
    TexSubImageEmptyTex,
    TexSubImageAlign {
        sub_x: i32,
        sub_y: i32,
        sub_w: i32,
        sub_h: i32,
        alignment: i32,
    },
    /// `es3fTextureSpecificationTests.cpp`'s `TexImage2DParamsCase`.
    TexImageParams {
        row_length: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
    },
    /// `BasicTexImage2DArrayCase` / `BasicTexImage3DCase`, by `tex_type`.
    BasicTexImage3d,
    /// `es3fTextureSpecificationTests.cpp`'s `TexImage3DParamsCase`.
    TexImage3dParams {
        image_height: i32,
        row_length: i32,
        skip_images: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
    },
    /// `TexImage2DArrayDepthCase`.
    ArrayDepth,
    /// `BasicTexStorage2DCase` / `BasicTexStorageCubeCase` / `BasicTexStorage2DArrayCase` / `BasicTexStorage3DCase`, by
    /// `tex_type`; `levels` is the explicit level count upstream passes.
    TexStorage {
        levels: i32,
    },
    /// `TexImage2DBufferCase` / `TexImageCubeBufferCase`: upload from a pixel unpack buffer at `offset`.
    PboTexImage {
        row_length: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
        offset: i32,
    },
    /// `TexSubImage2DBufferCase` / `TexSubImageCubeBufferCase`.
    PboTexSubImage {
        sub_x: i32,
        sub_y: i32,
        sub_w: i32,
        sub_h: i32,
        row_length: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
        offset: i32,
    },
    /// `TexImage2DArrayBufferCase` / `TexImage3DBufferCase`, by `tex_type`.
    PboTexImage3d {
        image_height: i32,
        row_length: i32,
        skip_images: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
        offset: i32,
    },
    /// `TexSubImage2DArrayBufferCase` / `TexSubImage3DBufferCase`, by `tex_type`.
    PboTexSubImage3d {
        sub_x: i32,
        sub_y: i32,
        sub_z: i32,
        sub_w: i32,
        sub_h: i32,
        sub_d: i32,
        image_height: i32,
        row_length: i32,
        skip_images: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
        offset: i32,
    },
    /// `TexImage2DDepthBufferCase`.
    PboDepth,
    /// `TexImage2DArrayDepthBufferCase`.
    PboArrayDepth,
    /// `CopyTexFromPBOCase` (the explicit read-back comparison is left to the shared GL-vs-reference comparison).
    CopyFromPbo,
    /// `BasicCopyTexImage2DCase` / `BasicCopyTexImageCubeCase`, by `tex_type`.
    CopyTexImage,
    /// `BasicCopyTexSubImage2DCase` / `BasicCopyTexSubImageCubeCase`, by `tex_type`.
    CopyTexSubImage,
    /// `BasicTexSubImage3DCase` (3D only; upstream has no array twin).
    BasicTexSubImage3d,
    /// `TexSubImage2DArrayDepthCase`.
    SubArrayDepth,
    /// `es3fTextureSpecificationTests.cpp`'s `TexSubImage3DParamsCase`.
    TexSubImage3dParams {
        sub_x: i32,
        sub_y: i32,
        sub_z: i32,
        sub_w: i32,
        sub_h: i32,
        sub_d: i32,
        image_height: i32,
        row_length: i32,
        skip_images: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
    },
    /// `es3fTextureSpecificationTests.cpp`'s `TexImage2DDepthCase`.
    Depth,
    /// `es3fTextureSpecificationTests.cpp`'s `TexSubImage2DDepthCase`.
    SubDepth,
    /// `es3fTextureSpecificationTests.cpp`'s `TexSubImage2DParamsCase`.
    TexSubImageParams {
        sub_x: i32,
        sub_y: i32,
        sub_w: i32,
        sub_h: i32,
        row_length: i32,
        skip_rows: i32,
        skip_pixels: i32,
        alignment: i32,
    },
}

pub(crate) struct TextureSpecCase {
    pub(crate) name: String,
    pub(crate) tex_type: TextureType,
    /// The internal format passed to `glTexImage2D`; the ES 2.0 cases pass the unsized `format` itself.
    pub(crate) internal_format: u32,
    pub(crate) format: u32,
    pub(crate) data_type: u32,
    pub(crate) mipmaps: bool,
    pub(crate) width: i32,
    pub(crate) height: i32,
    /// Layers of an array, depth of a 3D texture; 1 otherwise.
    pub(crate) depth: i32,
    pub(crate) spec: Spec,
    /// The ES 3.0 module's verification (`es3fTextureSpecificationTests.cpp`): `GL_TEXTURE_MAX_LEVEL`,
    /// no small-level skip for 2D, cropped float compare for cube maps.
    pub(crate) es3: bool,
}

/// `getRowPitch`
fn get_row_pitch(transfer_format: TextureFormat, row_len: i32, alignment: i32) -> i32 {
    let base_pitch = transfer_format.pixel_size().unwrap_or(0) as i32 * row_len;
    alignment * (base_pitch / alignment + if base_pitch % alignment != 0 { 1 } else { 0 })
}

/// A `(format, size)` access over `data` with an explicit row pitch, as upstream's
/// `tcu::PixelBufferAccess(fmt, w, h, 1, rowPitch, 0, ptr)`.
fn pitched_access(
    format: TextureFormat,
    width: i32,
    height: i32,
    row_pitch: i32,
    data: &mut [u8],
) -> PixelBufferAccess<'_> {
    let pixel_size = format.pixel_size().unwrap_or(0) as usize;
    PixelBufferAccess::new_with_pitch(
        format,
        [width as u32, height as u32, 1],
        [pixel_size, row_pitch as usize, row_pitch as usize * height as usize],
        data,
    )
}

impl TextureSpecCase {
    fn num_levels(&self) -> i32 {
        if let Spec::TexStorage { levels } = self.spec {
            return levels;
        }
        let depth_levels = if self.tex_type == TextureType::ThreeD {
            log2_floor(self.depth)
        } else {
            0
        };
        if self.mipmaps {
            log2_floor(self.width).max(log2_floor(self.height)).max(depth_levels) + 1
        } else {
            1
        }
    }

    fn spec_is_array_depth(&self) -> bool {
        matches!(
            self.spec,
            Spec::ArrayDepth | Spec::SubArrayDepth | Spec::PboDepth | Spec::PboArrayDepth
        )
    }

    fn target(&self) -> GLenum {
        match self.tex_type {
            TextureType::Tex2D => glw::GL_TEXTURE_2D,
            TextureType::Cube => glw::GL_TEXTURE_CUBE_MAP,
            TextureType::Array => glw::GL_TEXTURE_2D_ARRAY,
            TextureType::ThreeD => glw::GL_TEXTURE_3D,
        }
    }

    /// The `TextureLevel` `levelData.setSize(w, h)` + `fillWithComponentGradients(...)` build.
    fn gradient_level(
        fmt: TextureFormat,
        width: i32,
        height: i32,
        g_min: [f32; 4],
        g_max: [f32; 4],
    ) -> Result<TextureLevel, TestError> {
        let mut level = TextureLevel::new(fmt, width as u32, height as u32, 1)?;
        fill_with_component_gradients2(&mut level.get_access(), g_min, g_max);
        Ok(level)
    }

    fn grid_level(
        fmt: TextureFormat,
        width: i32,
        height: i32,
        cell_size: i32,
        color_a: [f32; 4],
        color_b: [f32; 4],
    ) -> Result<TextureLevel, TestError> {
        let mut level = TextureLevel::new(fmt, width as u32, height as u32, 1)?;
        fill_with_grid(&mut level.get_access(), cell_size as u32, color_a, color_b);
        Ok(level)
    }

    /// `glGenBuffers` + `glBindBuffer(GL_PIXEL_UNPACK_BUFFER)` + `glBufferData` of the whole of `data`.
    fn upload_pbo(ctx: &mut dyn SglrContext, data: &[u8]) {
        let mut buf = [0u32; 1];
        ctx.gen_buffers(&mut buf);
        ctx.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf[0]);
        ctx.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, data.len() as isize, Some(data));
    }

    /// The `NotSupportedError` checks every copy case opens with.
    fn check_copy_support(render_target: RenderTarget, tex_format: TextureFormat, es3: bool) -> Result<(), TestError> {
        let target_has_rgb = render_target.red_bits > 0 && render_target.green_bits > 0 && render_target.blue_bits > 0;
        let target_has_alpha = render_target.alpha_bits > 0;
        let tex_has_rgb = tex_format.order != ChannelOrder::A;
        let tex_has_alpha = matches!(
            tex_format.order,
            ChannelOrder::RGBA | ChannelOrder::LA | ChannelOrder::A
        );

        if (tex_has_rgb && !target_has_rgb) || (tex_has_alpha && !target_has_alpha) {
            return Err(TestError::NotSupported(
                "Copying from current framebuffer is not supported".to_string(),
            ));
        }
        if es3
            && render_target.red_bits == 10
            && render_target.green_bits == 10
            && render_target.blue_bits == 10
            && (render_target.alpha_bits == 2 || render_target.alpha_bits == 0)
        {
            return Err(TestError::NotSupported(
                "Copy from 1010102 in GLES not supported, skipping ".to_string(),
            ));
        }
        Ok(())
    }

    /// `createTexture` of the matching upstream subclass, against `ctx`.
    fn create_texture(
        &self,
        ctx: &mut dyn SglrContext,
        tex_format: TextureFormat,
        half_float_oes: bool,
        render_target: RenderTarget,
        ctx_size: (i32, i32),
    ) -> Result<(), TestError> {
        let (format, data_type) = (self.format, self.data_type);
        let internal_format = self.internal_format;
        let num_levels = self.num_levels();
        let cube = self.tex_type == TextureType::Cube;
        let mut rnd = Random::new(de_string_hash(&self.name));
        let mut tex = [0u32; 1];
        // The ES 3.0 cases draw gradients from the format's own value range, the ES 2.0 ones from [0, 1].
        let (v_min, v_max) = if self.es3 {
            let info = get_texture_format_info(tex_format);
            (info.value_min, info.value_max)
        } else {
            ([0.0f32; 4], [1.0f32; 4])
        };
        let rv = |rnd: &mut Random| -> [f32; 4] { std::array::from_fn(|c| rnd.get_float_range(v_min[c], v_max[c])) };
        let scaled = |c: [f32; 4]| -> [f32; 4] {
            if self.es3 {
                std::array::from_fn(|i| c[i] * (v_max[i] - v_min[i]) + v_min[i])
            } else {
                c
            }
        };
        // `BasicTexImage*`/`RandomOrderTexImage*` build their data in the transfer format, the others in the mapped internal one.
        let data_format = map_gl_transfer_format(format, data_type).unwrap_or(tex_format);

        if data_type == glw::GL_HALF_FLOAT_OES && !half_float_oes {
            return Err(TestError::NotSupported(
                "GL_OES_texture_half_float is not supported".to_string(),
            ));
        }
        if cube {
            assert!(
                self.width == self.height,
                "Non-square cubemaps are not supported by GLES2."
            );
        }

        let level_size = |ndx: i32| ((self.width >> ndx).max(1), (self.height >> ndx).max(1));
        let upload = |ctx: &mut dyn SglrContext, target: GLenum, ndx: i32, w: i32, h: i32, level: &TextureLevel| {
            ctx.tex_image_2d(
                target,
                ndx,
                internal_format,
                w,
                h,
                0,
                format,
                data_type,
                Some(level.data()),
            );
        };

        ctx.gen_textures(&mut tex);
        ctx.bind_texture(self.target(), tex[0]);

        match self.spec {
            Spec::BasicTexImage => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    if cube {
                        for &face in &CUBE_MAP_FACES {
                            let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                            let level = Self::gradient_level(data_format, level_w, level_h, g_min, g_max)?;
                            upload(ctx, face, ndx, level_w, level_h, &level);
                        }
                    } else {
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        let level = Self::gradient_level(data_format, level_w, level_h, g_min, g_max)?;
                        upload(ctx, glw::GL_TEXTURE_2D, ndx, level_w, level_h, &level);
                    }
                }
            }
            Spec::RandomOrderTexImage => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                if cube {
                    // Level-face pairs.
                    let mut images: Vec<(i32, usize)> = (0..num_levels)
                        .flat_map(|ndx| (0..6).map(move |face| (ndx, face)))
                        .collect();
                    rnd.shuffle(&mut images);
                    for &(level_ndx, face) in &images {
                        let (level_w, level_h) = level_size(level_ndx);
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        let level = Self::gradient_level(data_format, level_w, level_h, g_min, g_max)?;
                        upload(ctx, CUBE_MAP_FACES[face], level_ndx, level_w, level_h, &level);
                    }
                } else {
                    let mut levels: Vec<i32> = (0..num_levels).collect();
                    rnd.shuffle(&mut levels);
                    for &level_ndx in &levels {
                        let (level_w, level_h) = level_size(level_ndx);
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        let level = Self::gradient_level(data_format, level_w, level_h, g_min, g_max)?;
                        upload(ctx, glw::GL_TEXTURE_2D, level_ndx, level_w, level_h, &level);
                    }
                }
            }
            Spec::TexImageAlign { alignment } => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let color_a = scaled([1.0, 0.0, 0.0, 1.0]);
                    let color_b = scaled([0.0, 1.0, 0.0, 1.0]);
                    let row_pitch = get_row_pitch(tex_format, level_w, alignment);
                    let cell_size = 1.max((level_w >> 2).min(level_h >> 2));
                    let mut data = vec![0u8; (row_pitch * level_h) as usize];
                    fill_with_grid(
                        &mut pitched_access(tex_format, level_w, level_h, row_pitch, &mut data),
                        cell_size as u32,
                        color_a,
                        color_b,
                    );
                    if cube {
                        for &face in &CUBE_MAP_FACES {
                            ctx.tex_image_2d(
                                face,
                                ndx,
                                internal_format,
                                level_w,
                                level_h,
                                0,
                                format,
                                data_type,
                                Some(&data),
                            );
                        }
                    } else {
                        ctx.tex_image_2d(
                            glw::GL_TEXTURE_2D,
                            ndx,
                            internal_format,
                            level_w,
                            level_h,
                            0,
                            format,
                            data_type,
                            Some(&data),
                        );
                    }
                }
            }
            Spec::BasicTexSubImage => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                // First specify full texture.
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    if cube {
                        for &face in &CUBE_MAP_FACES {
                            let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                            let level = Self::gradient_level(tex_format, level_w, level_h, g_min, g_max)?;
                            upload(ctx, face, ndx, level_w, level_h, &level);
                        }
                    } else {
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        let level = Self::gradient_level(tex_format, level_w, level_h, g_min, g_max)?;
                        upload(ctx, glw::GL_TEXTURE_2D, ndx, level_w, level_h, &level);
                    }
                }

                // Re-specify parts of each level (and face).
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                    for &target in targets {
                        let w = rnd.get_int(1, level_w);
                        let h = rnd.get_int(1, level_h);
                        let x = rnd.get_int(0, level_w - w);
                        let y = rnd.get_int(0, level_h - h);
                        let color_a = rv(&mut rnd);
                        let color_b = rv(&mut rnd);
                        let cell_size = rnd.get_int(2, 16);
                        let level = Self::grid_level(tex_format, w, h, cell_size, color_a, color_b)?;
                        ctx.tex_sub_image_2d(target, ndx, x, y, w, h, format, data_type, level.data());
                    }
                }
            }
            Spec::TexSubImageEmptyTex => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                // First allocate storage for each level.
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                    for &target in targets {
                        ctx.tex_image_2d(
                            target,
                            ndx,
                            internal_format,
                            level_w,
                            level_h,
                            0,
                            format,
                            data_type,
                            None,
                        );
                    }
                }

                // Specify pixel data to all levels using glTexSubImage2D()
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                    for &target in targets {
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        let level = Self::gradient_level(tex_format, level_w, level_h, g_min, g_max)?;
                        ctx.tex_sub_image_2d(target, ndx, 0, 0, level_w, level_h, format, data_type, level.data());
                    }
                }
            }
            Spec::TexImageParams {
                row_length,
                skip_rows,
                skip_pixels,
                alignment,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;
                let row_len = if row_length > 0 { row_length } else { self.width };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let info = get_texture_format_info(tex_format);
                let c_scale: [f32; 4] = std::array::from_fn(|i| info.value_max[i] - info.value_min[i]);
                let color_a: [f32; 4] =
                    std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * c_scale[i] + info.value_min[i]);
                let color_b: [f32; 4] =
                    std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * c_scale[i] + info.value_min[i]);

                // Fill data with grid.
                let offset = (skip_rows * row_pitch + skip_pixels * pixel_size) as usize;
                let mut data = vec![0u8; (pixel_size * skip_pixels + row_pitch * (self.height + skip_rows)) as usize];
                fill_with_grid(
                    &mut pitched_access(tex_format, self.width, self.height, row_pitch, &mut data[offset..]),
                    4,
                    color_a,
                    color_b,
                );

                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);

                ctx.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    internal_format,
                    self.width,
                    self.height,
                    0,
                    format,
                    data_type,
                    Some(&data),
                );
            }
            Spec::BasicTexImage3d | Spec::ArrayDepth => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let level_d = if self.tex_type == TextureType::ThreeD {
                        (self.depth >> ndx).max(1)
                    } else {
                        self.depth
                    };
                    let (g_min, g_max) = if self.spec_is_array_depth() {
                        // We are interested in the behavior near [-2, 2]; the lookup scale/bias map it to the visible range.
                        ([-1.5, -2.0, 1.7, -1.5], [2.0, 1.5, -1.0, 2.0])
                    } else {
                        (rv(&mut rnd), rv(&mut rnd))
                    };

                    let mut level = TextureLevel::new(data_format, level_w as u32, level_h as u32, level_d as u32)?;
                    fill_with_component_gradients_old(&mut level.get_access(), g_min, g_max);
                    ctx.tex_image_3d(
                        self.target(),
                        ndx,
                        internal_format,
                        level_w,
                        level_h,
                        level_d,
                        0,
                        format,
                        data_type,
                        Some(level.data()),
                    );
                }
            }
            Spec::TexImage3dParams {
                image_height,
                row_length,
                skip_images,
                skip_rows,
                skip_pixels,
                alignment,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;
                let row_len = if row_length > 0 { row_length } else { self.width };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let image_h = if image_height > 0 { image_height } else { self.height };
                let slice_pitch = image_h * row_pitch;
                let c_scale: [f32; 4] = std::array::from_fn(|i| v_max[i] - v_min[i]);
                let color_a: [f32; 4] = std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * c_scale[i] + v_min[i]);
                let color_b: [f32; 4] = std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * c_scale[i] + v_min[i]);

                // Fill data with grid.
                let offset = (skip_images * slice_pitch + skip_rows * row_pitch + skip_pixels * pixel_size) as usize;
                let mut data = vec![
                    0u8;
                    (pixel_size * skip_pixels + row_pitch * skip_rows + slice_pitch * (skip_images + self.depth))
                        as usize
                ];
                fill_with_grid(
                    &mut PixelBufferAccess::new_with_pitch(
                        tex_format,
                        [self.width as u32, self.height as u32, self.depth as u32],
                        [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                        &mut data[offset..],
                    ),
                    4,
                    color_a,
                    color_b,
                );

                ctx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, image_height);
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, skip_images);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);

                ctx.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    internal_format,
                    self.width,
                    self.height,
                    self.depth,
                    0,
                    format,
                    data_type,
                    Some(&data),
                );
            }
            Spec::PboTexImage {
                row_length,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;
                let size = self.width;
                let row_len = if row_length > 0 { row_length } else { size + skip_pixels };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let rows = self.height + skip_rows;

                if cube {
                    ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                    for &face in &CUBE_MAP_FACES {
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        let start = (skip_rows * row_pitch + skip_pixels * pixel_size + offset) as usize;
                        let mut data = vec![0u8; (row_pitch * rows + offset) as usize];
                        fill_with_component_gradients2(
                            &mut pitched_access(tex_format, size, size, row_pitch, &mut data[start..]),
                            g_min,
                            g_max,
                        );

                        Self::upload_pbo(ctx, &data);
                        ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                        ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                        ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                        ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                        ctx.tex_image_2d_pbo(
                            face,
                            0,
                            internal_format,
                            size,
                            size,
                            0,
                            format,
                            data_type,
                            offset as isize,
                        );
                    }
                } else {
                    // Fill data with grid.
                    let color_a: [f32; 4] =
                        std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                    let color_b: [f32; 4] =
                        std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                    let start = (skip_rows * row_pitch + skip_pixels * pixel_size + offset) as usize;
                    let mut data = vec![0u8; (row_pitch * rows + offset) as usize];
                    fill_with_grid(
                        &mut pitched_access(tex_format, self.width, self.height, row_pitch, &mut data[start..]),
                        4,
                        color_a,
                        color_b,
                    );

                    Self::upload_pbo(ctx, &data);
                    ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                    ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                    ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                    ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                    ctx.tex_image_2d_pbo(
                        glw::GL_TEXTURE_2D,
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        0,
                        format,
                        data_type,
                        offset as isize,
                    );
                }
            }
            Spec::PboTexSubImage {
                sub_x,
                sub_y,
                sub_w,
                sub_h,
                row_length,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;

                // First fill the texture (every face with its own gradient for a cube map).
                let base_pitch = (self.width * pixel_size + 3) / 4 * 4;
                let mut data = vec![0u8; (base_pitch * self.height) as usize];
                if cube {
                    ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                    for &face in &CUBE_MAP_FACES {
                        let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                        fill_with_component_gradients2(
                            &mut pitched_access(tex_format, self.width, self.height, base_pitch, &mut data),
                            g_min,
                            g_max,
                        );
                        ctx.tex_image_2d(
                            face,
                            0,
                            internal_format,
                            self.width,
                            self.height,
                            0,
                            format,
                            data_type,
                            Some(&data),
                        );
                    }
                } else {
                    fill_with_component_gradients2(
                        &mut pitched_access(tex_format, self.width, self.height, base_pitch, &mut data),
                        v_min,
                        v_max,
                    );
                    ctx.tex_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        0,
                        format,
                        data_type,
                        Some(&data),
                    );
                }

                // Fill data with grid.
                let row_len = if row_length > 0 { row_length } else { sub_w };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let rows = sub_h + skip_rows;
                let color_a: [f32; 4] =
                    std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                let color_b: [f32; 4] =
                    std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                let start = (skip_rows * row_pitch + skip_pixels * pixel_size + offset) as usize;
                let mut data = vec![0u8; (row_pitch * rows + offset + pixel_size * skip_pixels) as usize];
                fill_with_grid(
                    &mut pitched_access(tex_format, sub_w, sub_h, row_pitch, &mut data[start..]),
                    4,
                    color_a,
                    color_b,
                );

                Self::upload_pbo(ctx, &data);
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                for &target in targets {
                    ctx.tex_sub_image_2d_pbo(
                        target,
                        0,
                        sub_x,
                        sub_y,
                        sub_w,
                        sub_h,
                        format,
                        data_type,
                        offset as isize,
                    );
                }
            }
            Spec::PboTexImage3d {
                image_height,
                row_length,
                skip_images,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;
                let row_len = if row_length > 0 { row_length } else { self.width };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let image_h = if image_height > 0 { image_height } else { self.height };
                let slice_pitch = image_h * row_pitch;
                let color_a: [f32; 4] =
                    std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                let color_b: [f32; 4] =
                    std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);

                // Fill data with grid.
                let start =
                    (skip_images * slice_pitch + skip_rows * row_pitch + skip_pixels * pixel_size + offset) as usize;
                let mut data = vec![
                    0u8;
                    (slice_pitch * (self.depth + skip_images)
                        + offset
                        + row_pitch * skip_rows
                        + pixel_size * skip_pixels) as usize
                ];
                fill_with_grid(
                    &mut PixelBufferAccess::new_with_pitch(
                        tex_format,
                        [self.width as u32, self.height as u32, self.depth as u32],
                        [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                        &mut data[start..],
                    ),
                    4,
                    color_a,
                    color_b,
                );

                Self::upload_pbo(ctx, &data);
                ctx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, image_height);
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, skip_images);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                ctx.tex_image_3d_pbo(
                    self.target(),
                    0,
                    internal_format,
                    self.width,
                    self.height,
                    self.depth,
                    0,
                    format,
                    data_type,
                    offset as isize,
                );
            }
            Spec::PboTexSubImage3d {
                sub_x,
                sub_y,
                sub_z,
                sub_w,
                sub_h,
                sub_d,
                image_height,
                row_length,
                skip_images,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;

                // Fill with gradient.
                {
                    let row_pitch = (pixel_size * self.width + 3) / 4 * 4;
                    let slice_pitch = row_pitch * self.height;
                    let mut data = vec![0u8; (slice_pitch * self.depth) as usize];
                    fill_with_component_gradients_old(
                        &mut PixelBufferAccess::new_with_pitch(
                            tex_format,
                            [self.width as u32, self.height as u32, self.depth as u32],
                            [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                            &mut data,
                        ),
                        v_min,
                        v_max,
                    );
                    ctx.tex_image_3d(
                        self.target(),
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        self.depth,
                        0,
                        format,
                        data_type,
                        Some(&data),
                    );
                }

                // Fill data with grid.
                let row_len = if row_length > 0 { row_length } else { sub_w };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let image_h = if image_height > 0 { image_height } else { sub_h };
                let slice_pitch = image_h * row_pitch;
                let color_a: [f32; 4] =
                    std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                let color_b: [f32; 4] =
                    std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * (v_max[i] - v_min[i]) + v_min[i]);
                let start =
                    (skip_images * slice_pitch + skip_rows * row_pitch + skip_pixels * pixel_size + offset) as usize;
                let mut data = vec![
                    0u8;
                    (slice_pitch * (self.depth + skip_images)
                        + offset
                        + row_pitch * skip_rows
                        + pixel_size * skip_pixels) as usize
                ];
                fill_with_grid(
                    &mut PixelBufferAccess::new_with_pitch(
                        tex_format,
                        [sub_w as u32, sub_h as u32, sub_d as u32],
                        [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                        &mut data[start..],
                    ),
                    4,
                    color_a,
                    color_b,
                );

                Self::upload_pbo(ctx, &data);
                ctx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, image_height);
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, skip_images);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                ctx.tex_sub_image_3d_pbo(
                    self.target(),
                    0,
                    sub_x,
                    sub_y,
                    sub_z,
                    sub_w,
                    sub_h,
                    sub_d,
                    format,
                    data_type,
                    offset as isize,
                );
            }
            Spec::PboDepth | Spec::PboArrayDepth => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;
                let alignment = 4;
                let row_length = self.width;
                let row_pitch = (row_length * pixel_size + alignment - 1) / alignment * alignment;
                let is_array = matches!(self.spec, Spec::PboArrayDepth);
                let layers = if is_array { self.depth } else { 1 };
                let slice_pitch = self.height * row_pitch;
                let (g_min, g_max) = ([-1.5, -2.0, 1.7, -1.5], [2.0, 1.5, -1.0, 2.0]);

                let mut data = vec![0u8; (slice_pitch * layers) as usize];
                if is_array {
                    fill_with_component_gradients_old(
                        &mut PixelBufferAccess::new_with_pitch(
                            tex_format,
                            [self.width as u32, self.height as u32, layers as u32],
                            [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                            &mut data,
                        ),
                        g_min,
                        g_max,
                    );
                } else {
                    fill_with_component_gradients2(
                        &mut pitched_access(tex_format, self.width, self.height, row_pitch, &mut data),
                        g_min,
                        g_max,
                    );
                }

                Self::upload_pbo(ctx, &data);
                if is_array {
                    ctx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, self.height);
                }
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                if is_array {
                    ctx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, 0);
                }
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, 0);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, 0);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                if is_array {
                    ctx.tex_image_3d_pbo(
                        glw::GL_TEXTURE_2D_ARRAY,
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        layers,
                        0,
                        format,
                        data_type,
                        0,
                    );
                } else {
                    ctx.tex_image_2d_pbo(
                        glw::GL_TEXTURE_2D,
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        0,
                        format,
                        data_type,
                        0,
                    );
                }
            }
            Spec::CopyFromPbo => {
                const RED: u32 = 0xff0000ff; // alpha, blue, green, red
                const GREEN: u32 = 0xff00ff00;
                const BLUE: u32 = 0xffff0000;
                const TEX_SIZE: usize = 4;
                const PBO_ROW_LENGTH: i32 = 4;
                const PBO_OFFSET: isize = 2 * 4; // two GLuint pixels
                const SUB_W: i32 = 2;
                const SUB_H: i32 = 4;
                const SUB_X: i32 = 2;
                const SUB_Y: i32 = 0;

                let tex_data: Vec<u8> = (0..TEX_SIZE * TEX_SIZE).flat_map(|_| RED.to_le_bytes()).collect();
                let pixel_data: Vec<u8> = (0..TEX_SIZE * TEX_SIZE)
                    .flat_map(|i| (if i % TEX_SIZE < TEX_SIZE / 2 { BLUE } else { GREEN }).to_le_bytes())
                    .collect();

                // Create main texture.
                ctx.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    format,
                    TEX_SIZE as i32,
                    TEX_SIZE as i32,
                    0,
                    format,
                    data_type,
                    Some(&tex_data),
                );

                // Create pixel buffer object.
                Self::upload_pbo(ctx, &pixel_data);
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, PBO_ROW_LENGTH);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);

                // The very last pixel of the PBO should be available for TexSubImage.
                ctx.tex_sub_image_2d_pbo(
                    glw::GL_TEXTURE_2D,
                    0,
                    SUB_X,
                    SUB_Y,
                    SUB_W,
                    SUB_H,
                    format,
                    data_type,
                    PBO_OFFSET,
                );
            }
            Spec::CopyTexImage | Spec::CopyTexSubImage => {
                Self::check_copy_support(render_target, data_format, self.es3)?;
                let (ctx_w, ctx_h) = ctx_size;
                let rnd_01 = |rnd: &mut Random| -> [f32; 4] { std::array::from_fn(|_| rnd.get_float_range(0.0, 1.0)) };
                let draw_gradient = |ctx: &mut dyn SglrContext| {
                    let shader_id = if self.es3 {
                        let id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));
                        set_gradient(ctx, id, [0.0; 4], [1.0; 4]);
                        id
                    } else {
                        ctx.create_program(Box::new(Es2GradientShader::new()))
                    };
                    draw_quad(ctx, shader_id, Vec3::new(-1.0, -1.0, 0.0), Vec3::new(1.0, 1.0, 0.0));
                };
                let copy_sub = matches!(self.spec, Spec::CopyTexSubImage);

                if copy_sub {
                    ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                    // First specify full texture.
                    for ndx in 0..num_levels {
                        let (level_w, level_h) = level_size(ndx);
                        let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                        for &target in targets {
                            let (color_a, color_b) = (rnd_01(&mut rnd), rnd_01(&mut rnd));
                            let cell_size = rnd.get_int(2, 16);
                            let level = Self::grid_level(data_format, level_w, level_h, cell_size, color_a, color_b)?;
                            upload(ctx, target, ndx, level_w, level_h, &level);
                        }
                    }
                }

                // Fill render target with gradient.
                draw_gradient(ctx);

                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                    for &target in targets {
                        if copy_sub {
                            // Re-specify parts of each level (and face).
                            let w = rnd.get_int(1, level_w);
                            let h = rnd.get_int(1, level_h);
                            let xo = rnd.get_int(0, level_w - w);
                            let yo = rnd.get_int(0, level_h - h);
                            let x = rnd.get_int(0, ctx_w - w);
                            let y = rnd.get_int(0, ctx_h - h);
                            ctx.copy_tex_sub_image_2d(target, ndx, xo, yo, x, y, w, h);
                        } else {
                            let x = rnd.get_int(0, ctx_w - level_w);
                            let y = rnd.get_int(0, ctx_h - level_h);
                            ctx.copy_tex_image_2d(target, ndx, internal_format, x, y, level_w, level_h, 0);
                        }
                    }
                }
            }
            Spec::TexStorage { levels } => {
                match self.tex_type {
                    TextureType::Tex2D => {
                        ctx.tex_storage_2d(glw::GL_TEXTURE_2D, levels, internal_format, self.width, self.height)
                    }
                    TextureType::Cube => ctx.tex_storage_2d(
                        glw::GL_TEXTURE_CUBE_MAP,
                        levels,
                        internal_format,
                        self.width,
                        self.height,
                    ),
                    TextureType::Array => ctx.tex_storage_3d(
                        glw::GL_TEXTURE_2D_ARRAY,
                        levels,
                        internal_format,
                        self.width,
                        self.height,
                        self.depth,
                    ),
                    TextureType::ThreeD => ctx.tex_storage_3d(
                        glw::GL_TEXTURE_3D,
                        levels,
                        internal_format,
                        self.width,
                        self.height,
                        self.depth,
                    ),
                }
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);

                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    match self.tex_type {
                        TextureType::Tex2D => {
                            let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                            let level = Self::gradient_level(data_format, level_w, level_h, g_min, g_max)?;
                            ctx.tex_sub_image_2d(
                                glw::GL_TEXTURE_2D,
                                ndx,
                                0,
                                0,
                                level_w,
                                level_h,
                                format,
                                data_type,
                                level.data(),
                            );
                        }
                        TextureType::Cube => {
                            for &face in &CUBE_MAP_FACES {
                                let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                                let level = Self::gradient_level(data_format, level_w, level_h, g_min, g_max)?;
                                ctx.tex_sub_image_2d(
                                    face,
                                    ndx,
                                    0,
                                    0,
                                    level_w,
                                    level_h,
                                    format,
                                    data_type,
                                    level.data(),
                                );
                            }
                        }
                        TextureType::Array | TextureType::ThreeD => {
                            let level_d = if self.tex_type == TextureType::ThreeD {
                                (self.depth >> ndx).max(1)
                            } else {
                                self.depth
                            };
                            let (g_min, g_max) = (rv(&mut rnd), rv(&mut rnd));
                            let mut level =
                                TextureLevel::new(data_format, level_w as u32, level_h as u32, level_d as u32)?;
                            fill_with_component_gradients_old(&mut level.get_access(), g_min, g_max);
                            ctx.tex_sub_image_3d(
                                self.target(),
                                ndx,
                                0,
                                0,
                                0,
                                level_w,
                                level_h,
                                level_d,
                                format,
                                data_type,
                                level.data(),
                            );
                        }
                    }
                }
            }
            Spec::BasicTexSubImage3d | Spec::SubArrayDepth => {
                let is_array = self.tex_type == TextureType::Array;
                let level_depth = |ndx: i32| {
                    if is_array {
                        self.depth
                    } else {
                        (self.depth >> ndx).max(1)
                    }
                };
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);

                // First specify full texture.
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let level_d = level_depth(ndx);
                    let (g_min, g_max) = if self.spec_is_array_depth() {
                        ([-1.5, -2.0, 1.7, -1.5], [2.0, 1.5, -1.0, 2.0])
                    } else {
                        (rv(&mut rnd), rv(&mut rnd))
                    };

                    let mut level = TextureLevel::new(data_format, level_w as u32, level_h as u32, level_d as u32)?;
                    fill_with_component_gradients_old(&mut level.get_access(), g_min, g_max);
                    ctx.tex_image_3d(
                        self.target(),
                        ndx,
                        internal_format,
                        level_w,
                        level_h,
                        level_d,
                        0,
                        format,
                        data_type,
                        Some(level.data()),
                    );
                }

                // Re-specify parts of each level.
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let level_d = level_depth(ndx);

                    let w = rnd.get_int(1, level_w);
                    let h = rnd.get_int(1, level_h);
                    let d = rnd.get_int(1, level_d);
                    let x = rnd.get_int(0, level_w - w);
                    let y = rnd.get_int(0, level_h - h);
                    let z = rnd.get_int(0, level_d - d);

                    let (color_a, color_b) = if self.spec_is_array_depth() {
                        ([2.0, 1.5, -1.0, 2.0], [-1.5, -2.0, 1.7, -1.5])
                    } else {
                        (rv(&mut rnd), rv(&mut rnd))
                    };
                    let cell_size = rnd.get_int(2, 16);

                    let mut level = TextureLevel::new(data_format, w as u32, h as u32, d as u32)?;
                    fill_with_grid(&mut level.get_access(), cell_size as u32, color_a, color_b);
                    ctx.tex_sub_image_3d(self.target(), ndx, x, y, z, w, h, d, format, data_type, level.data());
                }
            }
            Spec::TexSubImage3dParams {
                sub_x,
                sub_y,
                sub_z,
                sub_w,
                sub_h,
                sub_d,
                image_height,
                row_length,
                skip_images,
                skip_rows,
                skip_pixels,
                alignment,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;

                // Fill with gradient.
                {
                    let row_pitch = (pixel_size * self.width + 3) / 4 * 4;
                    let slice_pitch = row_pitch * self.height;
                    let mut data = vec![0u8; (slice_pitch * self.depth) as usize];
                    fill_with_component_gradients_old(
                        &mut PixelBufferAccess::new_with_pitch(
                            tex_format,
                            [self.width as u32, self.height as u32, self.depth as u32],
                            [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                            &mut data,
                        ),
                        v_min,
                        v_max,
                    );
                    ctx.tex_image_3d(
                        glw::GL_TEXTURE_3D,
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        self.depth,
                        0,
                        format,
                        data_type,
                        Some(&data),
                    );
                }

                // Fill data with grid.
                let row_len = if row_length > 0 { row_length } else { sub_w };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let image_h = if image_height > 0 { image_height } else { sub_h };
                let slice_pitch = image_h * row_pitch;
                let c_scale: [f32; 4] = std::array::from_fn(|i| v_max[i] - v_min[i]);
                let color_a: [f32; 4] = std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * c_scale[i] + v_min[i]);
                let color_b: [f32; 4] = std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * c_scale[i] + v_min[i]);

                let offset = (skip_images * slice_pitch + skip_rows * row_pitch + skip_pixels * pixel_size) as usize;
                let mut data = vec![
                    0u8;
                    (pixel_size * skip_pixels + row_pitch * skip_rows + slice_pitch * (skip_images + self.depth))
                        as usize
                ];
                fill_with_grid(
                    &mut PixelBufferAccess::new_with_pitch(
                        tex_format,
                        [sub_w as u32, sub_h as u32, sub_d as u32],
                        [pixel_size as usize, row_pitch as usize, slice_pitch as usize],
                        &mut data[offset..],
                    ),
                    4,
                    color_a,
                    color_b,
                );

                ctx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, image_height);
                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, skip_images);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                ctx.tex_sub_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    sub_x,
                    sub_y,
                    sub_z,
                    sub_w,
                    sub_h,
                    sub_d,
                    format,
                    data_type,
                    &data,
                );
            }
            Spec::Depth => {
                // We are interested in the behavior near [-2, 2]; the lookup scale/bias map it to the visible range.
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let level = Self::gradient_level(
                        data_format,
                        level_w,
                        level_h,
                        [-1.5, -2.0, 1.7, -1.5],
                        [2.0, 1.5, -1.0, 2.0],
                    )?;
                    upload(ctx, glw::GL_TEXTURE_2D, ndx, level_w, level_h, &level);
                }
            }
            Spec::SubDepth => {
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                // First specify full texture.
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let level = Self::gradient_level(
                        data_format,
                        level_w,
                        level_h,
                        [-1.5, -2.0, 1.7, -1.5],
                        [2.0, 1.5, -1.0, 2.0],
                    )?;
                    upload(ctx, glw::GL_TEXTURE_2D, ndx, level_w, level_h, &level);
                }

                // Re-specify parts of each level.
                for ndx in 0..num_levels {
                    let (level_w, level_h) = level_size(ndx);
                    let w = rnd.get_int(1, level_w);
                    let h = rnd.get_int(1, level_h);
                    let x = rnd.get_int(0, level_w - w);
                    let y = rnd.get_int(0, level_h - h);
                    let cell_size = rnd.get_int(2, 16);
                    let level = Self::grid_level(
                        data_format,
                        w,
                        h,
                        cell_size,
                        [2.0, 1.5, -1.0, 2.0],
                        [-1.5, -2.0, 1.7, -1.5],
                    )?;
                    ctx.tex_sub_image_2d(glw::GL_TEXTURE_2D, ndx, x, y, w, h, format, data_type, level.data());
                }
            }
            Spec::TexSubImageParams {
                sub_x,
                sub_y,
                sub_w,
                sub_h,
                row_length,
                skip_rows,
                skip_pixels,
                alignment,
            } => {
                let pixel_size = tex_format.pixel_size().unwrap_or(0) as i32;

                // First fill texture with gradient.
                let base_pitch = (self.width * pixel_size + 3) / 4 * 4;
                let mut data = vec![0u8; (base_pitch * self.height) as usize];
                fill_with_component_gradients2(
                    &mut pitched_access(tex_format, self.width, self.height, base_pitch, &mut data),
                    v_min,
                    v_max,
                );
                ctx.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    internal_format,
                    self.width,
                    self.height,
                    0,
                    format,
                    data_type,
                    Some(&data),
                );

                // Fill data with grid.
                let row_len = if row_length > 0 { row_length } else { sub_w };
                let row_pitch = (row_len * pixel_size + alignment - 1) / alignment * alignment;
                let rows = sub_h + skip_rows;
                let c_scale: [f32; 4] = std::array::from_fn(|i| v_max[i] - v_min[i]);
                let color_a: [f32; 4] = std::array::from_fn(|i| [1.0, 0.0, 0.0, 1.0][i] * c_scale[i] + v_min[i]);
                let color_b: [f32; 4] = std::array::from_fn(|i| [0.0, 1.0, 0.0, 1.0][i] * c_scale[i] + v_min[i]);

                let offset = (skip_rows * row_pitch + skip_pixels * pixel_size) as usize;
                let mut data = vec![0u8; (row_pitch * rows + pixel_size * skip_pixels) as usize];
                fill_with_grid(
                    &mut pitched_access(tex_format, sub_w, sub_h, row_pitch, &mut data[offset..]),
                    4,
                    color_a,
                    color_b,
                );

                ctx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, row_length);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, skip_rows);
                ctx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, skip_pixels);
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                ctx.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    sub_x,
                    sub_y,
                    sub_w,
                    sub_h,
                    format,
                    data_type,
                    &data,
                );
            }
            Spec::TexSubImageAlign {
                sub_x,
                sub_y,
                sub_w,
                sub_h,
                alignment,
            } => {
                // Specify base level.
                let mut data =
                    vec![0u8; tex_format.pixel_size().unwrap_or(0) as usize * (self.width * self.height) as usize];
                let row_pitch = tex_format.pixel_size().unwrap_or(0) as i32 * self.width;
                fill_with_component_gradients2(
                    &mut pitched_access(tex_format, self.width, self.height, row_pitch, &mut data),
                    [0.0; 4],
                    [1.0; 4],
                );
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                let targets: &[GLenum] = if cube { &CUBE_MAP_FACES } else { &[glw::GL_TEXTURE_2D] };
                for &target in targets {
                    ctx.tex_image_2d(
                        target,
                        0,
                        internal_format,
                        self.width,
                        self.height,
                        0,
                        format,
                        data_type,
                        Some(&data),
                    );
                }

                // Re-specify subrectangle.
                let row_pitch = get_row_pitch(tex_format, sub_w, alignment);
                let mut data = vec![0u8; (row_pitch * sub_h) as usize];
                fill_with_grid(
                    &mut pitched_access(tex_format, sub_w, sub_h, row_pitch, &mut data),
                    4,
                    [1.0, 0.0, 0.0, 1.0],
                    [0.0, 1.0, 0.0, 1.0],
                );
                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, alignment);
                for &target in targets {
                    ctx.tex_sub_image_2d(target, 0, sub_x, sub_y, sub_w, sub_h, format, data_type, &data);
                }
            }
        }

        Ok(())
    }

    /// `renderTex2D`
    fn render_tex_2d(ctx: &mut dyn SglrContext, width: i32, height: i32, target_w: i32, target_h: i32) -> Surface {
        let w = width as f32 / target_w as f32;
        let h = height as f32 / target_h as f32;

        let shader_id = ctx.create_program(Box::new(Tex2DShader::new()));
        set_uniforms(ctx, shader_id);
        draw_quad(
            ctx,
            shader_id,
            Vec3::new(-1.0, -1.0, 0.0),
            Vec3::new(-1.0 + w * 2.0, -1.0 + h * 2.0, 0.0),
        );

        // Read pixels back.
        let mut dst = Surface::new(width, height);
        ctx.read_pixels(&mut dst, 0, 0, width, height);
        dst
    }

    /// `renderTexCube`
    fn render_tex_cube(
        ctx: &mut dyn SglrContext,
        width: i32,
        height: i32,
        face: usize,
        target_w: i32,
        target_h: i32,
    ) -> Surface {
        let w = width as f32 / target_w as f32;
        let h = height as f32 / target_h as f32;

        let shader_id = ctx.create_program(Box::new(TexCubeShader::new(face)));
        set_uniforms(ctx, shader_id);
        draw_quad(
            ctx,
            shader_id,
            Vec3::new(-1.0, -1.0, 0.0),
            Vec3::new(-1.0 + w * 2.0, -1.0 + h * 2.0, 0.0),
        );

        // Read pixels back.
        let mut dst = Surface::new(width, height);
        ctx.read_pixels(&mut dst, 0, 0, width, height);
        dst
    }
}

impl TestCase for TextureSpecCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_target = context.render_target();
        let transfer_format = map_gl_transfer_format(self.format, self.data_type).ok_or_else(|| {
            TestError::Fail(format!(
                "unsupported (format, type) pair ({:#x}, {:#x})",
                self.format, self.data_type
            ))
        })?;
        // ES 3.0: `Texture2DSpecCase`'s `m_texFormat` is `mapGLInternalFormat` of a sized internal format.
        let tex_format = if self.es3 {
            map_gl_internal_format(self.internal_format).unwrap_or(transfer_format)
        } else {
            transfer_format
        };
        let es3_info = self.es3.then(|| {
            let mut info = get_texture_format_info(tex_format);
            if matches!(
                self.spec,
                Spec::Depth
                    | Spec::SubDepth
                    | Spec::ArrayDepth
                    | Spec::SubArrayDepth
                    | Spec::PboDepth
                    | Spec::PboArrayDepth
            ) {
                // We are interested in the behavior near [-2, 2], map it to visible range [0, 1].
                info.look_up_bias = [0.25, 0.0, 0.0, 1.0];
                info.look_up_scale = [0.5, 1.0, 1.0, 0.0];
            }
            info
        });
        let (sampler_2d, sampler_cube) = spec_shaders::sampler_types(tex_format);
        let (sampler_array, sampler_3d) = spec_shaders::volume_sampler_types(tex_format);
        let half_float_oes = context.context_info.is_extension_supported("GL_OES_texture_half_float");

        assert!(self.width <= 256 && self.height <= 256);

        let (min_width, min_height) = if self.es3 {
            (256, 256)
        } else {
            (self.width, self.height)
        };
        if render_target.width < min_width || render_target.height < min_height {
            return Err(TestError::NotSupported("Too small viewport".to_string()));
        }

        // Context size, and viewport for GLES2
        let mut rnd = Random::new(de_string_hash(&self.name));
        let width = render_target.width.min(256);
        let height = render_target.height.min(256);
        let x = rnd.get_int(0, render_target.width - width);
        let y = rnd.get_int(0, render_target.height - height);

        // Contexts.
        let mut gles2_context = GLContext::new(&context.render_context, (x, y, width, height));
        let mut ref_context = create_reference_context_rgb8(context, width, height, 0)?;

        // Clear color buffer.
        for ctx in [
            &mut gles2_context as &mut dyn SglrContext,
            &mut ref_context as &mut dyn SglrContext,
        ] {
            ctx.clear_color(0.125, 0.25, 0.5, 1.0);
            ctx.clear(ALL_BUFFER_BITS);
        }

        // Construct texture using both GLES2 and reference contexts.
        for ctx in [
            &mut gles2_context as &mut dyn SglrContext,
            &mut ref_context as &mut dyn SglrContext,
        ] {
            self.create_texture(ctx, tex_format, half_float_oes, render_target, (width, height))?;
            if ctx.get_error() != glw::GL_NO_ERROR {
                return Err(TestError::Fail("glGetError() == GL_NO_ERROR".to_string()));
            }
        }

        // Setup texture filtering state.
        for ctx in [
            &mut gles2_context as &mut dyn SglrContext,
            &mut ref_context as &mut dyn SglrContext,
        ] {
            let target = self.target();
            let mipmap_filter = self.es3 || self.mipmaps;
            ctx.tex_parameteri(
                target,
                glw::GL_TEXTURE_MIN_FILTER,
                (if mipmap_filter {
                    glw::GL_NEAREST_MIPMAP_NEAREST
                } else {
                    glw::GL_NEAREST
                }) as i32,
            );
            ctx.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            if matches!(self.tex_type, TextureType::Array | TextureType::ThreeD) {
                ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
            }
            if self.es3 {
                ctx.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, self.num_levels() - 1);
            }
        }

        // Verify results.
        let num_levels = self.num_levels();

        for level_ndx in 0..num_levels {
            let level_w = (self.width >> level_ndx).max(1);
            let level_h = (self.height >> level_ndx).max(1);

            if !self.es3 && (level_w <= 2 || level_h <= 2) {
                continue; // Don't bother checking.
            }

            match self.tex_type {
                TextureType::Tex2D => {
                    let (result, reference) = match &es3_info {
                        Some(info) => {
                            let base = (self.width, self.height);
                            (
                                spec_shaders::render_tex_2d(
                                    &mut gles2_context,
                                    level_w,
                                    level_h,
                                    width,
                                    height,
                                    base,
                                    sampler_2d,
                                    info.look_up_scale,
                                    info.look_up_bias,
                                ),
                                spec_shaders::render_tex_2d(
                                    &mut ref_context,
                                    level_w,
                                    level_h,
                                    width,
                                    height,
                                    base,
                                    sampler_2d,
                                    info.look_up_scale,
                                    info.look_up_bias,
                                ),
                            )
                        }
                        None => (
                            Self::render_tex_2d(&mut gles2_context, level_w, level_h, width, height),
                            Self::render_tex_2d(&mut ref_context, level_w, level_h, width, height),
                        ),
                    };

                    let threshold = compute_compare_threshold(render_target.pixel_format(), tex_format);
                    if !int_threshold_compare(&reference.get_const_access(), &result.get_const_access(), threshold).ok {
                        return Ok(TestStatus::fail("Image comparison failed"));
                    }
                }
                TextureType::Cube => {
                    for face in 0..6 {
                        if self.es3 && level_w <= 2 {
                            continue; // Fuzzy compare doesn't work for images this small.
                        }

                        let (result, reference) = match &es3_info {
                            Some(info) => (
                                spec_shaders::render_tex_cube(
                                    &mut gles2_context,
                                    level_w,
                                    level_h,
                                    width,
                                    height,
                                    face,
                                    self.width,
                                    sampler_cube,
                                    info.look_up_scale,
                                    info.look_up_bias,
                                ),
                                spec_shaders::render_tex_cube(
                                    &mut ref_context,
                                    level_w,
                                    level_h,
                                    width,
                                    height,
                                    face,
                                    self.width,
                                    sampler_cube,
                                    info.look_up_scale,
                                    info.look_up_bias,
                                ),
                            ),
                            None => (
                                Self::render_tex_cube(&mut gles2_context, level_w, level_h, face, width, height),
                                Self::render_tex_cube(&mut ref_context, level_w, level_h, face, width, height),
                            ),
                        };

                        if self.es3 {
                            // Crop away edges of the image to handle issues with cubemap LOD handling causing
                            // possible differences in boundaries and corners of the cubemap.
                            let pad = 1u32;
                            let (crop_w, crop_h) = (
                                reference.get_width() as u32 - pad * 2,
                                reference.get_height() as u32 - pad * 2,
                            );
                            let alpha_bits = render_target.pixel_format().alpha_bits;
                            let threshold = [0.02, 0.02, 0.02, if alpha_bits == 2 { 0.35 } else { 0.02 }];
                            let reference_access = reference.get_const_access();
                            let result_access = result.get_const_access();
                            let crop_ref = reference_access.get_subregion(pad, pad, 0, crop_w, crop_h, 1);
                            let crop_res = result_access.get_subregion(pad, pad, 0, crop_w, crop_h, 1);
                            if !float_threshold_compare(&crop_ref, &crop_res, threshold).ok {
                                return Ok(TestStatus::fail("Image comparison failed"));
                            }
                        } else {
                            let threshold = 0.02f32;
                            if !fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), threshold)
                                .unwrap_or(false)
                            {
                                return Ok(TestStatus::fail("Image comparison failed"));
                            }
                        }
                    }
                }
                TextureType::Array | TextureType::ThreeD => {
                    // Handled below, in upstream's own loop order (layers / slices outside).
                }
            }
        }

        if let (Some(info), TextureType::Array) = (&es3_info, self.tex_type) {
            for layer_ndx in 0..self.depth {
                for level_ndx in 0..num_levels {
                    let level_w = (self.width >> level_ndx).max(1);
                    let level_h = (self.height >> level_ndx).max(1);
                    let base = (self.width, self.height);
                    let result = spec_shaders::render_tex_array(
                        &mut gles2_context,
                        level_w,
                        level_h,
                        width,
                        height,
                        base,
                        layer_ndx,
                        sampler_array,
                        info.look_up_scale,
                        info.look_up_bias,
                    );
                    let reference = spec_shaders::render_tex_array(
                        &mut ref_context,
                        level_w,
                        level_h,
                        width,
                        height,
                        base,
                        layer_ndx,
                        sampler_array,
                        info.look_up_scale,
                        info.look_up_bias,
                    );

                    let threshold = compute_compare_threshold(render_target.pixel_format(), tex_format);
                    if !int_threshold_compare(&reference.get_const_access(), &result.get_const_access(), threshold).ok {
                        return Ok(TestStatus::fail("Image comparison failed"));
                    }
                }
            }
        }

        if let (Some(info), TextureType::ThreeD) = (&es3_info, self.tex_type) {
            for level_ndx in 0..num_levels {
                let level_w = (self.width >> level_ndx).max(1);
                let level_h = (self.height >> level_ndx).max(1);
                let level_d = (self.depth >> level_ndx).max(1);
                let base = (self.width, self.height);

                for slice in 0..level_d {
                    let depth_coord = (slice as f32 + 0.5) / level_d as f32;
                    let result = spec_shaders::render_tex_3d(
                        &mut gles2_context,
                        level_w,
                        level_h,
                        width,
                        height,
                        base,
                        depth_coord,
                        sampler_3d,
                        info.look_up_scale,
                        info.look_up_bias,
                    );
                    let reference = spec_shaders::render_tex_3d(
                        &mut ref_context,
                        level_w,
                        level_h,
                        width,
                        height,
                        base,
                        depth_coord,
                        sampler_3d,
                        info.look_up_scale,
                        info.look_up_bias,
                    );

                    let threshold = compute_compare_threshold(render_target.pixel_format(), tex_format);
                    if !int_threshold_compare(&reference.get_const_access(), &result.get_const_access(), threshold).ok {
                        return Ok(TestStatus::fail("Image comparison failed"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureSpecificationTests::init`
pub fn create_tests() -> TestCaseGroup {
    // (name, format, data type)
    const TEX_FORMATS: [(&str, u32, u32); 13] = [
        ("a8", glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("l8", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        ("la88", glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("rgb565", glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
        ("rgb888", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        ("rgba4444", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        ("rgba5551", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        ("rgba8888", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
        ("rgba16f", glw::GL_RGBA, glw::GL_HALF_FLOAT_OES),
        ("rgb16f", glw::GL_RGB, glw::GL_HALF_FLOAT_OES),
        ("la16f", glw::GL_LUMINANCE_ALPHA, glw::GL_HALF_FLOAT_OES),
        ("l16f", glw::GL_LUMINANCE, glw::GL_HALF_FLOAT_OES),
        ("a16f", glw::GL_ALPHA, glw::GL_HALF_FLOAT_OES),
    ];

    let case = |name: String,
                tex_type: TextureType,
                format: u32,
                data_type: u32,
                mipmaps: bool,
                width: i32,
                height: i32,
                spec: Spec| {
        Box::new(TextureSpecCase {
            name,
            tex_type,
            internal_format: format,
            format,
            data_type,
            mipmaps,
            width,
            height,
            depth: 1,
            spec,
            es3: false,
        }) as Box<dyn TestCase>
    };

    let mut group = TestCaseGroup::new("specification");

    // Basic TexImage2D usage.
    {
        let mut basic_tex_image_group = TestCaseGroup::new("basic_teximage2d");
        for &(fmt_name, format, data_type) in &TEX_FORMATS {
            basic_tex_image_group.add_child(case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                format,
                data_type,
                true,
                64,
                128,
                Spec::BasicTexImage,
            ));
            basic_tex_image_group.add_child(case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                format,
                data_type,
                true,
                64,
                64,
                Spec::BasicTexImage,
            ));
        }
        group.add_child(basic_tex_image_group);
    }

    // Randomized TexImage2D order.
    {
        let mut random_tex_image_group = TestCaseGroup::new("random_teximage2d");
        let mut rnd = Random::new(9);

        // 2D cases.
        for ndx in 0..10 {
            let format_ndx = rnd.get_int(0, TEX_FORMATS.len() as i32 - 1) as usize;
            let width = 1 << rnd.get_int(2, 8);
            let height = 1 << rnd.get_int(2, 8);
            let (_, format, data_type) = TEX_FORMATS[format_ndx];
            random_tex_image_group.add_child(case(
                format!("2d_{ndx}"),
                TextureType::Tex2D,
                format,
                data_type,
                true,
                width,
                height,
                Spec::RandomOrderTexImage,
            ));
        }

        // Cubemap cases.
        for ndx in 0..10 {
            let format_ndx = rnd.get_int(0, TEX_FORMATS.len() as i32 - 1) as usize;
            let size = 1 << rnd.get_int(2, 8);
            let (_, format, data_type) = TEX_FORMATS[format_ndx];
            random_tex_image_group.add_child(case(
                format!("cube_{ndx}"),
                TextureType::Cube,
                format,
                data_type,
                true,
                size,
                size,
                Spec::RandomOrderTexImage,
            ));
        }
        group.add_child(random_tex_image_group);
    }

    // TexImage2D unpack alignment.
    {
        let mut align_group = TestCaseGroup::new("teximage2d_align");

        // (prefix, format, data type, mipmaps, width, height, alignment) as listed upstream, 2D then cube.
        let mut add = |name: &str,
                       tex_type: TextureType,
                       format: u32,
                       data_type: u32,
                       mipmaps: bool,
                       width: i32,
                       height: i32,
                       alignment: i32| {
            align_group.add_child(case(
                name.to_string(),
                tex_type,
                format,
                data_type,
                mipmaps,
                width,
                height,
                Spec::TexImageAlign { alignment },
            ));
        };

        add(
            "2d_l8_4_8",
            TextureType::Tex2D,
            glw::GL_LUMINANCE,
            glw::GL_UNSIGNED_BYTE,
            true,
            4,
            8,
            8,
        );
        for a in [1, 2, 4, 8] {
            add(
                &format!("2d_l8_63_{a}"),
                TextureType::Tex2D,
                glw::GL_LUMINANCE,
                glw::GL_UNSIGNED_BYTE,
                false,
                63,
                30,
                a,
            );
        }
        for a in [1, 2, 4, 8] {
            add(
                &format!("2d_rgba4444_51_{a}"),
                TextureType::Tex2D,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_SHORT_4_4_4_4,
                false,
                51,
                30,
                a,
            );
        }
        for a in [1, 2, 4, 8] {
            add(
                &format!("2d_rgb888_39_{a}"),
                TextureType::Tex2D,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                false,
                39,
                43,
                a,
            );
        }
        for a in [1, 2, 4, 8] {
            add(
                &format!("2d_rgba8888_47_{a}"),
                TextureType::Tex2D,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                false,
                47,
                27,
                a,
            );
        }
        add(
            "cube_l8_4_8",
            TextureType::Cube,
            glw::GL_LUMINANCE,
            glw::GL_UNSIGNED_BYTE,
            true,
            4,
            4,
            8,
        );
        for a in [1, 2, 4, 8] {
            add(
                &format!("cube_l8_63_{a}"),
                TextureType::Cube,
                glw::GL_LUMINANCE,
                glw::GL_UNSIGNED_BYTE,
                false,
                63,
                63,
                a,
            );
        }
        for a in [1, 2, 4, 8] {
            add(
                &format!("cube_rgba4444_51_{a}"),
                TextureType::Cube,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_SHORT_4_4_4_4,
                false,
                51,
                51,
                a,
            );
        }
        for a in [1, 2, 4, 8] {
            add(
                &format!("cube_rgb888_39_{a}"),
                TextureType::Cube,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                false,
                39,
                39,
                a,
            );
        }
        for a in [1, 2, 4, 8] {
            add(
                &format!("cube_rgba8888_47_{a}"),
                TextureType::Cube,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                false,
                47,
                47,
                a,
            );
        }
        group.add_child(align_group);
    }

    // Basic TexSubImage2D usage.
    {
        let mut basic_tex_sub_image_group = TestCaseGroup::new("basic_texsubimage2d");
        for &(fmt_name, format, data_type) in &TEX_FORMATS {
            basic_tex_sub_image_group.add_child(case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                format,
                data_type,
                true,
                64,
                128,
                Spec::BasicTexSubImage,
            ));
            basic_tex_sub_image_group.add_child(case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                format,
                data_type,
                true,
                64,
                64,
                Spec::BasicTexSubImage,
            ));
        }
        group.add_child(basic_tex_sub_image_group);
    }

    // TexSubImage2D to empty texture.
    {
        let mut tex_sub_image_empty_tex_group = TestCaseGroup::new("texsubimage2d_empty_tex");
        for &(fmt_name, format, data_type) in &TEX_FORMATS {
            tex_sub_image_empty_tex_group.add_child(case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                format,
                data_type,
                true,
                64,
                32,
                Spec::TexSubImageEmptyTex,
            ));
            tex_sub_image_empty_tex_group.add_child(case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                format,
                data_type,
                true,
                32,
                32,
                Spec::TexSubImageEmptyTex,
            ));
        }
        group.add_child(tex_sub_image_empty_tex_group);
    }

    // TexSubImage2D alignment cases.
    {
        let mut align_group = TestCaseGroup::new("texsubimage2d_align");

        // (name stem, format, data type, subX, subY, subW, subH)
        const ALIGN_CASES: [(&str, u32, u32, i32, i32, i32, i32); 5] = [
            ("l8_1", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE, 13, 17, 1, 6),
            ("l8_63", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE, 1, 9, 63, 30),
            (
                "rgba4444_51",
                glw::GL_RGBA,
                glw::GL_UNSIGNED_SHORT_4_4_4_4,
                7,
                29,
                51,
                30,
            ),
            ("rgb888_39", glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 11, 8, 39, 43),
            ("rgba8888_47", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 10, 1, 47, 27),
        ];

        for (prefix, tex_type) in [("2d", TextureType::Tex2D), ("cube", TextureType::Cube)] {
            for &(stem, format, data_type, sub_x, sub_y, sub_w, sub_h) in &ALIGN_CASES {
                for alignment in [1, 2, 4, 8] {
                    align_group.add_child(case(
                        format!("{prefix}_{stem}_{alignment}"),
                        tex_type,
                        format,
                        data_type,
                        false,
                        64,
                        64,
                        Spec::TexSubImageAlign {
                            sub_x,
                            sub_y,
                            sub_w,
                            sub_h,
                            alignment,
                        },
                    ));
                }
            }
        }
        group.add_child(align_group);
    }

    // Basic glCopyTexImage2D() and glCopyTexSubImage2D() cases.
    {
        const COPY_FORMATS: [(&str, u32); 5] = [
            ("alpha", glw::GL_ALPHA),
            ("luminance", glw::GL_LUMINANCE),
            ("luminance_alpha", glw::GL_LUMINANCE_ALPHA),
            ("rgb", glw::GL_RGB),
            ("rgba", glw::GL_RGBA),
        ];

        for (group_name, spec) in [
            ("basic_copyteximage2d", Spec::CopyTexImage),
            ("basic_copytexsubimage2d", Spec::CopyTexSubImage),
        ] {
            let mut copy_group = TestCaseGroup::new(group_name);
            for &(fmt_name, format) in &COPY_FORMATS {
                copy_group.add_child(case(
                    format!("2d_{fmt_name}"),
                    TextureType::Tex2D,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    true,
                    128,
                    64,
                    spec,
                ));
            }
            for &(fmt_name, format) in &COPY_FORMATS {
                copy_group.add_child(case(
                    format!("cube_{fmt_name}"),
                    TextureType::Cube,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    true,
                    64,
                    64,
                    spec,
                ));
            }
            group.add_child(copy_group);
        }
    }

    group
}

/// One ES 3.0 case: `internal_format` is the sized format, `(format, data_type)` its transfer format.
#[allow(clippy::too_many_arguments)]
pub(crate) fn make_es3_case(
    name: String,
    tex_type: TextureType,
    internal_format: u32,
    format: u32,
    data_type: u32,
    mipmaps: bool,
    width: i32,
    height: i32,
    spec: Spec,
) -> Box<dyn TestCase> {
    Box::new(TextureSpecCase {
        name,
        tex_type,
        internal_format,
        format,
        data_type,
        mipmaps,
        width,
        height,
        depth: 1,
        spec,
        es3: true,
    })
}

/// One ES 3.0 case on a sized internal format, with the transfer format `glu::getTransferFormat(mapGLInternalFormat(..))`
/// derives - the sized-format constructors of upstream's cases.
#[allow(clippy::too_many_arguments)]
pub(crate) fn make_es3_sized_case(
    name: String,
    tex_type: TextureType,
    internal_format: u32,
    mipmaps: bool,
    width: i32,
    height: i32,
    spec: Spec,
) -> Box<dyn TestCase> {
    let tex_format =
        map_gl_internal_format(internal_format).expect("a sized internal format the ES 3.0 specification tests list");
    let transfer = get_transfer_format(tex_format).expect("a transfer format for a listed sized internal format");
    make_es3_case(
        name,
        tex_type,
        internal_format,
        transfer.format,
        transfer.data_type,
        mipmaps,
        width,
        height,
        spec,
    )
}

/// `make_es3_sized_case` for a texture with a third dimension (`tex_type` is `Array` or `ThreeD`).
#[allow(clippy::too_many_arguments)]
pub(crate) fn make_es3_sized_case_3d(
    name: String,
    tex_type: TextureType,
    internal_format: u32,
    mipmaps: bool,
    width: i32,
    height: i32,
    depth: i32,
    spec: Spec,
) -> Box<dyn TestCase> {
    let tex_format =
        map_gl_internal_format(internal_format).expect("a sized internal format the ES 3.0 specification tests list");
    let transfer = get_transfer_format(tex_format).expect("a transfer format for a listed sized internal format");
    Box::new(TextureSpecCase {
        name,
        tex_type,
        internal_format,
        format: transfer.format,
        data_type: transfer.data_type,
        mipmaps,
        width,
        height,
        depth,
        spec,
        es3: true,
    })
}
