// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFboRenderTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES2.functional.fbo.render`: every case renders one scene through `sglr::Context`
// twice - against the real driver (`sglr::GLContext`) and against `sglr::ReferenceContext` -
// and compares the two frames with `fuzzy_compare` plus the two `glGetError` results.
//
// Mapping notes:
//  - Upstream's classes sharing `FboRenderCase` become one `FboRenderCase` struct and a `Kind`
//    enum; `render` is a match over it. `isConfigSupported` is `kind_supports`.
//  - A C++ `sglr::ShaderProgram` object stays usable after `createProgram(&shader)` for its
//    `setUnit`/`setColor` helpers; here the program is moved into the context, so those
//    helpers are the free functions `set_unit`/`set_color` taking the program id.
//  - `FboIncompleteException` becomes `TestError::NotSupported` for `GL_FRAMEBUFFER_UNSUPPORTED`
//    and `TestError::Fail` for any other status, which is what `FboRenderCase::iterate` makes
//    of the two.
//  - `Framebuffer` has no destructor; `destroy` is called at the end of each `render`.
//  - No `tcu::TestLog`; the reference context is always single sample and has no stencil
//    buffer of its own (`ReferenceContext::new` takes none; only FBO renderbuffers are
//    stencilled here).
//  - `tcu::fillWithMetaballs`/`fillWithRGBAQuads` are not in `tcu` yet, so they are ported
//    here, next to their only callers.

use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::sglr::gl_context::GLContext;
use crate::sglr::reference_context::{ResolvedSampler, ResolvedSampler2D};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::vector::{Vec3, Vec4};
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

// Shaders.

/// `FlatColorShader`
struct FlatColorShader {
    base: ShaderProgramBase,
}

impl FlatColorShader {
    fn new() -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
            .vertex_source(
                "attribute highp vec4 a_position;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 }\n"
                .to_string(),
            )
            .fragment_source(
                "uniform mediump vec4 u_color;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_FragColor = u_color;\n\
                 }\n"
                .to_string(),
            );
        Self {
            base: ShaderProgramBase::new(&decl),
        }
    }
}

/// `FlatColorShader::setColor`
fn set_color(ctx: &mut dyn SglrContext, program: u32, color: [f32; 4]) {
    ctx.use_program(program);
    let loc = ctx.get_uniform_location(program, "u_color");
    ctx.uniform4fv(loc, 1, &color);
}

impl VertexShader for FlatColorShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            // SAFETY: the attribute was bound by the case before the draw call.
            unsafe { read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0) };
            packet.position = position;
        }
    }
}

impl FragmentShader for FlatColorShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let c = self.base.uniform_by_name("u_color").value.as_f32_vec4();
        let color = GenericVec4::from_float(Vec4::new(c[0], c[1], c[2], c[3]));

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4 {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, color) };
            }
        }
    }
}

impl ShaderProgram for FlatColorShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

fn texture_vertex_shade(inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
    for packet in packets.iter_mut() {
        let mut position = Vec4::splat(0.0);
        let mut coord = Vec4::splat(0.0);
        // SAFETY: the attributes were bound by the case before the draw call.
        unsafe {
            read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
            read_vertex_attrib_float(&mut coord, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
        }
        packet.position = position;
        packet.outputs[0] = GenericVec4::from_float(coord);
    }
}

const TEXTURE_VERTEX_SOURCE: &str = "attribute highp vec4 a_position;\n\
     attribute mediump vec2 a_coord;\n\
     varying mediump vec2 v_coord;\n\
     void main (void)\n\
     {\n\
     \x20   gl_Position = a_position;\n\
     \x20   v_coord = a_coord;\n\
     }\n";

fn bind_2d(slot: &mut Option<ResolvedSampler2D>, resolved: &[(String, Option<ResolvedSampler>)], name: &str) {
    for (n, sampler) in resolved {
        if n == name {
            *slot = sampler.as_ref().and_then(ResolvedSampler::as_2d).cloned();
        }
    }
}

/// `SingleTex2DShader`
struct SingleTex2DShader {
    base: ShaderProgramBase,
    sampler0: Option<ResolvedSampler2D>,
}

impl SingleTex2DShader {
    fn new() -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_sampler0", DataType::Sampler2D))
            .vertex_source(TEXTURE_VERTEX_SOURCE.to_string())
            .fragment_source(
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

/// `SingleTex2DShader::setUnit`
fn set_unit(ctx: &mut dyn SglrContext, program: u32, unit_ndx: i32) {
    ctx.use_program(program);
    let loc = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(loc, unit_ndx);
}

impl VertexShader for SingleTex2DShader {
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

impl FragmentShader for SingleTex2DShader {
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
                let v_coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let lod = 0.0f32;
                let s = match &self.sampler0 {
                    Some(sampler) => sampler.sample(v_coord.x(), v_coord.y(), lod),
                    None => [0.0; 4],
                };
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(Vec4::new(s[0], s[1], s[2], s[3])),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for SingleTex2DShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        bind_2d(&mut self.sampler0, resolved, "u_sampler0");
    }
}

/// `MixTexturesShader`
struct MixTexturesShader {
    base: ShaderProgramBase,
    sampler0: Option<ResolvedSampler2D>,
    sampler1: Option<ResolvedSampler2D>,
}

impl MixTexturesShader {
    fn new() -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_sampler0", DataType::Sampler2D))
            .uniform(pdec::Uniform::new("u_sampler1", DataType::Sampler2D))
            .vertex_source(TEXTURE_VERTEX_SOURCE.to_string())
            .fragment_source(
                "uniform sampler2D u_sampler0;\n\
                 uniform sampler2D u_sampler1;\n\
                 varying mediump vec2 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_FragColor = texture2D(u_sampler0, v_coord)*0.5 + texture2D(u_sampler1, v_coord)*0.5;\n\
                 }\n"
                .to_string(),
            );
        Self {
            base: ShaderProgramBase::new(&decl),
            sampler0: None,
            sampler1: None,
        }
    }
}

/// `MixTexturesShader::setUnits`
fn set_units(ctx: &mut dyn SglrContext, program: u32, unit0: i32, unit1: i32) {
    ctx.use_program(program);
    let loc0 = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(loc0, unit0);
    let loc1 = ctx.get_uniform_location(program, "u_sampler1");
    ctx.uniform1i(loc1, unit1);
}

impl VertexShader for MixTexturesShader {
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

impl FragmentShader for MixTexturesShader {
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
                let v_coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let lod = 0.0f32;
                let a = match &self.sampler0 {
                    Some(sampler) => sampler.sample(v_coord.x(), v_coord.y(), lod),
                    None => [0.0; 4],
                };
                let b = match &self.sampler1 {
                    Some(sampler) => sampler.sample(v_coord.x(), v_coord.y(), lod),
                    None => [0.0; 4],
                };
                let mix = Vec4::new(
                    a[0] * 0.5 + b[0] * 0.5,
                    a[1] * 0.5 + b[1] * 0.5,
                    a[2] * 0.5 + b[2] * 0.5,
                    a[3] * 0.5 + b[3] * 0.5,
                );
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(mix),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for MixTexturesShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        bind_2d(&mut self.sampler0, resolved, "u_sampler0");
        bind_2d(&mut self.sampler1, resolved, "u_sampler1");
    }
}

// Framebuffer config.

/// `FboConfig`
#[derive(Clone, Copy)]
struct FboConfig {
    /// GL_TEXTURE_2D, GL_TEXTURE_CUBE_MAP, GL_RENDERBUFFER
    colorbuffer_type: GLenum,
    /// Internal format for color buffer texture or renderbuffer
    colorbuffer_format: GLenum,
    /// GL_RENDERBUFFER
    depthbuffer_type: GLenum,
    depthbuffer_format: GLenum,
    /// GL_RENDERBUFFER
    stencilbuffer_type: GLenum,
    stencilbuffer_format: GLenum,
}

impl FboConfig {
    fn new() -> Self {
        Self {
            colorbuffer_type: glw::GL_NONE,
            colorbuffer_format: glw::GL_NONE,
            depthbuffer_type: glw::GL_NONE,
            depthbuffer_format: glw::GL_NONE,
            stencilbuffer_type: glw::GL_NONE,
            stencilbuffer_format: glw::GL_NONE,
        }
    }

    /// `FboConfig::getFormatName`
    fn format_name(format: GLenum) -> &'static str {
        match format {
            glw::GL_RGB => "rgb",
            glw::GL_RGBA => "rgba",
            glw::GL_BGRA => "bgra",
            glw::GL_ALPHA => "alpha",
            glw::GL_LUMINANCE => "luminance",
            glw::GL_LUMINANCE_ALPHA => "luminance_alpha",
            glw::GL_RGB565 => "rgb565",
            glw::GL_RGB5_A1 => "rgb5_a1",
            glw::GL_RGBA4 => "rgba4",
            glw::GL_RGBA16F => "rgba16f",
            glw::GL_RGB16F => "rgb16f",
            glw::GL_DEPTH_COMPONENT16 => "depth_component16",
            glw::GL_STENCIL_INDEX8 => "stencil_index8",
            _ => unreachable!("FboConfig::getFormatName: unknown format {format:#x}"),
        }
    }

    /// `FboConfig::getName`
    fn name(&self) -> String {
        let mut name = String::new();

        if self.colorbuffer_type != glw::GL_NONE {
            match self.colorbuffer_type {
                glw::GL_TEXTURE_2D => name.push_str("tex2d_"),
                glw::GL_TEXTURE_CUBE_MAP => name.push_str("texcube_"),
                glw::GL_RENDERBUFFER => name.push_str("rbo_"),
                _ => unreachable!("FboConfig::getName: unknown colorbuffer type"),
            }
            name.push_str(Self::format_name(self.colorbuffer_format));
        }

        if self.depthbuffer_type != glw::GL_NONE {
            debug_assert_eq!(self.depthbuffer_type, glw::GL_RENDERBUFFER);
            if !name.is_empty() {
                name.push('_');
            }
            name.push_str(Self::format_name(self.depthbuffer_format));
        }

        if self.stencilbuffer_type != glw::GL_NONE {
            debug_assert_eq!(self.stencilbuffer_type, glw::GL_RENDERBUFFER);
            if !name.is_empty() {
                name.push('_');
            }
            name.push_str(Self::format_name(self.stencilbuffer_format));
        }

        name
    }
}

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

/// `FboIncompleteException`, as `FboRenderCase::iterate` ends up treating it.
fn fbo_incomplete_error(reason: GLenum) -> TestError {
    if reason == glw::GL_FRAMEBUFFER_UNSUPPORTED {
        TestError::NotSupported(format!(
            "Framebuffer is not complete: {}",
            fbo_incomplete_reason_name(reason)
        ))
    } else {
        TestError::Fail(format!(
            "Framebuffer is not complete: {}",
            fbo_incomplete_reason_name(reason)
        ))
    }
}

/// `isExtensionSupported`
fn is_extension_supported(ctx: &mut dyn SglrContext, name: &str) -> bool {
    ctx.get_string(glw::GL_EXTENSIONS)
        .map(|extensions| extensions.split(' ').any(|e| e == name))
        .unwrap_or(false)
}

/// `checkColorFormatSupport`
fn check_color_format_support(ctx: &mut dyn SglrContext, sized_format: GLenum) -> Result<(), TestError> {
    match sized_format {
        glw::GL_RGBA16F | glw::GL_RGB16F | glw::GL_RG16F | glw::GL_R16F => {
            if !is_extension_supported(ctx, "GL_EXT_color_buffer_half_float") {
                return Err(TestError::NotSupported(
                    "GL_EXT_color_buffer_half_float is not supported".to_string(),
                ));
            }
        }
        glw::GL_BGRA | glw::GL_BGRA8_EXT if !is_extension_supported(ctx, "GL_EXT_texture_format_BGRA8888") => {
            return Err(TestError::NotSupported(
                "GL_EXT_texture_format_BGRA8888 is not supported".to_string(),
            ));
        }
        _ => {}
    }
    Ok(())
}

/// `sglr::Context::texImage2D(target, level, internalFormat, width, height)` - the
/// storage-only overload that picks the transfer format from the internal one.
fn tex_image_2d_storage(
    ctx: &mut dyn SglrContext,
    target: GLenum,
    level: i32,
    internal_format: GLenum,
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    let (format, data_type) = match internal_format {
        glw::GL_ALPHA | glw::GL_LUMINANCE | glw::GL_LUMINANCE_ALPHA | glw::GL_RGB | glw::GL_RGBA => {
            (internal_format, glw::GL_UNSIGNED_BYTE)
        }
        _ => {
            let tex_format = map_gl_internal_format(internal_format)
                .ok_or_else(|| TestError::Fail(format!("unknown internal format {internal_format:#x}")))?;
            let transfer = get_transfer_format(tex_format)?;
            (transfer.format, transfer.data_type)
        }
    };

    ctx.tex_image_2d(
        target,
        level,
        internal_format,
        width,
        height,
        0,
        format,
        data_type,
        None,
    );
    Ok(())
}

/// `Framebuffer`
struct Framebuffer {
    config: FboConfig,
    framebuffer: u32,
    colorbuffer: u32,
    depthbuffer: u32,
    stencilbuffer: u32,
}

fn create_rbo(ctx: &mut dyn SglrContext, name: &mut u32, format: GLenum, width: i32, height: i32) {
    if *name == 0 {
        let mut names = [0u32];
        ctx.gen_renderbuffers(&mut names);
        *name = names[0];
    }
    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, *name);
    ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, format, width, height);
}

impl Framebuffer {
    fn new(ctx: &mut dyn SglrContext, config: FboConfig, width: i32, height: i32) -> Result<Self, TestError> {
        // Verify that color format is supported
        check_color_format_support(ctx, config.colorbuffer_format)?;

        let mut fb = Self {
            config,
            framebuffer: 0,
            colorbuffer: 0,
            depthbuffer: 0,
            stencilbuffer: 0,
        };

        let mut names = [0u32];
        ctx.gen_framebuffers(&mut names);
        fb.framebuffer = names[0];
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fb.framebuffer);

        match config.colorbuffer_type {
            glw::GL_TEXTURE_2D => {
                let mut names = [0u32];
                ctx.gen_textures(&mut names);
                fb.colorbuffer = names[0];
                ctx.bind_texture(glw::GL_TEXTURE_2D, fb.colorbuffer);
                tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, config.colorbuffer_format, width, height)?;
                ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
                if !is_power_of_two(width) || !is_power_of_two(height) {
                    // Set wrap mode to clamp for NPOT FBOs
                    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
                    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
                }
                ctx.framebuffer_texture2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    fb.colorbuffer,
                    0,
                );
            }
            glw::GL_TEXTURE_CUBE_MAP => {
                return Err(TestError::Fail(
                    "Framebuffer: GL_TEXTURE_CUBE_MAP colorbuffer is a TODO upstream".to_string(),
                ));
            }
            glw::GL_RENDERBUFFER => {
                create_rbo(ctx, &mut fb.colorbuffer, config.colorbuffer_format, width, height);
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    fb.colorbuffer,
                );
            }
            _ => debug_assert_eq!(config.colorbuffer_type, glw::GL_NONE),
        }

        if config.depthbuffer_type == glw::GL_RENDERBUFFER {
            create_rbo(ctx, &mut fb.depthbuffer, config.depthbuffer_format, width, height);
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                fb.depthbuffer,
            );
        } else {
            debug_assert_eq!(config.depthbuffer_type, glw::GL_NONE);
        }

        if config.stencilbuffer_type == glw::GL_RENDERBUFFER {
            create_rbo(ctx, &mut fb.stencilbuffer, config.stencilbuffer_format, width, height);
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                fb.stencilbuffer,
            );
        } else {
            debug_assert_eq!(config.stencilbuffer_type, glw::GL_NONE);
        }

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        Ok(fb)
    }

    /// `Framebuffer::checkCompleteness`
    fn check_completeness(&self, ctx: &mut dyn SglrContext) -> Result<(), TestError> {
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer);
        let status = ctx.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(fbo_incomplete_error(status));
        }
        Ok(())
    }

    /// `Framebuffer::destroyBuffer`
    fn destroy_buffer(ctx: &mut dyn SglrContext, name: u32, type_: GLenum) {
        if type_ == glw::GL_TEXTURE_2D || type_ == glw::GL_TEXTURE_CUBE_MAP {
            ctx.delete_textures(&[name]);
        } else if type_ == glw::GL_RENDERBUFFER {
            ctx.delete_renderbuffers(&[name]);
        } else {
            debug_assert_eq!(type_, glw::GL_NONE);
        }
    }

    /// `Framebuffer::~Framebuffer`
    fn destroy(self, ctx: &mut dyn SglrContext) {
        ctx.delete_framebuffers(&[self.framebuffer]);
        Self::destroy_buffer(ctx, self.colorbuffer, self.config.colorbuffer_type);
        Self::destroy_buffer(ctx, self.depthbuffer, self.config.depthbuffer_type);
        Self::destroy_buffer(ctx, self.stencilbuffer, self.config.stencilbuffer_type);
    }
}

fn is_power_of_two(v: i32) -> bool {
    v > 0 && (v & (v - 1)) == 0
}

/// `tcu::fillWithMetaballs`
pub(crate) fn fill_with_metaballs(dst: &mut TextureLevel, num_balls: i32, seed: u32) {
    let [width, height, _] = dst.size();
    let mut rnd = Random::new(seed);

    let mut points: Vec<[f32; 2]> = Vec::new();
    for _ in 0..num_balls {
        let x = rnd.get_float();
        let y = rnd.get_float();
        points.push([x, y]);
    }

    let mut access = dst.get_access();
    for y in 0..height {
        for x in 0..width {
            let p = [x as f32 / width as f32, y as f32 / height as f32];

            let mut sum = 0.0f32;
            for point in &points {
                let d = [p[0] - point[0], p[1] - point[1]];
                let f = 0.01f32 / (d[0] * d[0] + d[1] * d[1]);
                sum += f;
            }

            access.set_pixel([sum; 4], x, y, 0);
        }
    }
}

/// `tcu::fillWithRGBAQuads`
pub(crate) fn fill_with_rgba_quads(dst: &mut TextureLevel) {
    let [width, height, _] = dst.size();
    let left = width / 2;
    let top = height / 2;

    let mut access = dst.get_access();
    for y in 0..height {
        for x in 0..width {
            let color = match (x < left, y < top) {
                (true, true) => [1.0, 0.0, 0.0, 1.0],
                (false, true) => [0.0, 1.0, 0.0, 1.0],
                (true, false) => [0.0, 0.0, 1.0, 0.0],
                (false, false) => [0.5, 0.5, 0.5, 1.0],
            };
            access.set_pixel(color, x, y, 0);
        }
    }
}

fn upload_level(
    ctx: &mut dyn SglrContext,
    name: u32,
    format: GLenum,
    data_type: GLenum,
    width: i32,
    height: i32,
    fill: impl FnOnce(&mut TextureLevel),
) -> Result<(), TestError> {
    let tex_format = map_gl_transfer_format(format, data_type)
        .ok_or_else(|| TestError::Fail(format!("unknown transfer format {format:#x}/{data_type:#x}")))?;
    let mut level = TextureLevel::new(tex_format, width as u32, height as u32, 1)?;
    fill(&mut level);
    ctx.bind_texture(glw::GL_TEXTURE_2D, name);
    ctx.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        format,
        width,
        height,
        0,
        format,
        data_type,
        Some(level.data()),
    );
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
    Ok(())
}

/// `createMetaballsTex2D`
pub(crate) fn create_metaballs_tex2d(
    ctx: &mut dyn SglrContext,
    name: u32,
    format: GLenum,
    data_type: GLenum,
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    upload_level(ctx, name, format, data_type, width, height, |level| {
        fill_with_metaballs(level, 5, name ^ (width as u32) ^ (height as u32))
    })
}

/// `createQuadsTex2D`
pub(crate) fn create_quads_tex2d(
    ctx: &mut dyn SglrContext,
    name: u32,
    format: GLenum,
    data_type: GLenum,
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    upload_level(ctx, name, format, data_type, width, height, fill_with_rgba_quads)
}

/// `TextureLevel` of a fixed `GL_UNSIGNED_BYTE` `format`, for the `texImage2D`/`texSubImage2D`
/// calls the texsubimage cases make with host-side data.
fn make_level(
    order: crate::tcu::ChannelOrder,
    size: u32,
    fill: impl FnOnce(&mut TextureLevel),
) -> Result<TextureLevel, TestError> {
    let mut level = TextureLevel::new(
        crate::tcu::TextureFormat::new(order, crate::tcu::ChannelType::UNORM_INT8),
        size,
        size,
        1,
    )?;
    fill(&mut level);
    Ok(level)
}

const FULL_QUAD_P0: [f32; 3] = [-1.0, -1.0, 0.0];
const FULL_QUAD_P1: [f32; 3] = [1.0, 1.0, 0.0];

fn quad(ctx: &mut dyn SglrContext, program: u32, p0: [f32; 3], p1: [f32; 3]) {
    draw_quad(
        ctx,
        program,
        Vec3::new(p0[0], p0[1], p0[2]),
        Vec3::new(p1[0], p1[1], p1[2]),
    );
}

fn full_quad(ctx: &mut dyn SglrContext, program: u32) {
    quad(ctx, program, FULL_QUAD_P0, FULL_QUAD_P1);
}

/// Clears the alpha channel of a `GL_RGB5_A1` colorbuffer, as `ColorClearsTest` and
/// `StencilClearsTest` do because the test thresholds do not account for dithering of it.
fn clear_rgb5_a1_alpha(ctx: &mut dyn SglrContext) {
    ctx.color_mask(false, false, false, true);
    ctx.clear_color(0.0, 0.0, 0.0, 1.0);
    ctx.clear(glw::GL_COLOR_BUFFER_BIT);
    ctx.color_mask(true, true, true, true);
}

const ALL_BUFFER_BITS: u32 = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;

/// The test classes of upstream's `FboCases` namespace.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    ColorClears,
    IntersectingQuads { npot: bool },
    Mix { npot: bool },
    Blend { npot: bool },
    StencilClears,
    Stencil { npot: bool },
    SharedColorbuffer,
    SharedColorbufferClears,
    SharedDepthbuffer,
    TexSubImageAfterRender,
    TexSubImageBetweenRender,
    Resize,
    RecreateBuffers { buffers: u32, rebind: bool },
    RepeatedClear,
}

/// Each class's `isConfigSupported` (`FboRenderCase::isConfigSupported` is `true`).
fn kind_supports(kind: Kind, config: &FboConfig) -> bool {
    match kind {
        Kind::ColorClears | Kind::SharedColorbuffer | Kind::Resize | Kind::RepeatedClear => true,
        // \note Disabled for stencil configurations since doesn't exercise stencil buffer
        Kind::IntersectingQuads { .. } => {
            config.depthbuffer_type != glw::GL_NONE && config.stencilbuffer_type == glw::GL_NONE
        }
        Kind::Mix { .. } => config.colorbuffer_type == glw::GL_TEXTURE_2D && config.stencilbuffer_type == glw::GL_NONE,
        Kind::Blend { .. } => config.stencilbuffer_type == glw::GL_NONE,
        Kind::StencilClears | Kind::Stencil { .. } => config.stencilbuffer_type != glw::GL_NONE,
        Kind::SharedColorbufferClears => {
            config.colorbuffer_type != glw::GL_NONE
                && config.depthbuffer_type == glw::GL_NONE
                && config.stencilbuffer_type == glw::GL_NONE
        }
        Kind::SharedDepthbuffer => config.depthbuffer_type == glw::GL_RENDERBUFFER,
        Kind::TexSubImageAfterRender | Kind::TexSubImageBetweenRender => {
            config.colorbuffer_type == glw::GL_TEXTURE_2D
                && (config.colorbuffer_format == glw::GL_RGB || config.colorbuffer_format == glw::GL_RGBA)
                && config.depthbuffer_type == glw::GL_NONE
                && config.stencilbuffer_type == glw::GL_NONE
        }
        Kind::RecreateBuffers { buffers, .. } => {
            if (buffers & glw::GL_COLOR_BUFFER_BIT) != 0 && config.colorbuffer_type == glw::GL_NONE {
                return false;
            }
            if (buffers & glw::GL_DEPTH_BUFFER_BIT) != 0 && config.depthbuffer_type == glw::GL_NONE {
                return false;
            }
            if (buffers & glw::GL_STENCIL_BUFFER_BIT) != 0 && config.stencilbuffer_type == glw::GL_NONE {
                return false;
            }
            true
        }
    }
}

/// `FboRenderCase`
struct FboRenderCase {
    name: String,
    kind: Kind,
    config: FboConfig,
}

impl FboRenderCase {
    #[allow(clippy::new_ret_no_self)]
    fn new(kind: Kind, config: FboConfig) -> Box<dyn TestCase> {
        let base = config.name();
        let name = match kind {
            Kind::ColorClears
            | Kind::StencilClears
            | Kind::SharedColorbuffer
            | Kind::SharedColorbufferClears
            | Kind::SharedDepthbuffer
            | Kind::Resize
            | Kind::RepeatedClear => base,
            Kind::IntersectingQuads { npot } | Kind::Stencil { npot } => {
                format!("{}{}", if npot { "npot_" } else { "" }, base)
            }
            Kind::Mix { npot } => format!("{}{}", if npot { "mix_npot_" } else { "mix_" }, base),
            Kind::Blend { npot } => format!("{}{}", if npot { "blend_npot_" } else { "blend_" }, base),
            Kind::TexSubImageAfterRender => format!("after_render_{base}"),
            Kind::TexSubImageBetweenRender => format!("between_render_{base}"),
            Kind::RecreateBuffers { rebind, .. } => {
                format!("{}{}", if rebind { "rebind_" } else { "no_rebind_" }, base)
            }
        };
        Box::new(Self { name, kind, config })
    }

    /// `FboRenderCase::render` and its overrides
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        match self.kind {
            Kind::ColorClears => self.render_color_clears(ctx, dst),
            Kind::IntersectingQuads { npot } => self.render_intersecting_quads(ctx, dst, npot),
            Kind::Mix { npot } => self.render_mix(ctx, dst, npot),
            Kind::Blend { npot } => self.render_blend(ctx, dst, npot),
            Kind::StencilClears => self.render_stencil_clears(ctx, dst),
            Kind::Stencil { npot } => self.render_stencil(ctx, dst, npot),
            Kind::SharedColorbuffer => self.render_shared_colorbuffer(ctx, dst),
            Kind::SharedColorbufferClears => self.render_shared_colorbuffer_clears(ctx, dst),
            Kind::SharedDepthbuffer => self.render_shared_depthbuffer(ctx, dst),
            Kind::TexSubImageAfterRender => self.render_tex_sub_image_after_render(ctx, dst),
            Kind::TexSubImageBetweenRender => self.render_tex_sub_image_between_render(ctx, dst),
            Kind::Resize => self.render_resize(ctx, dst),
            Kind::RecreateBuffers { buffers, rebind } => self.render_recreate_buffers(ctx, dst, buffers, rebind),
            Kind::RepeatedClear => self.render_repeated_clear(ctx, dst),
        }
    }

    /// The tail every texture-backed case shares: draw the colorbuffer texture to the screen
    /// and read the screen back, or read the renderbuffer straight from the fbo.
    fn present(
        &self,
        ctx: &mut dyn SglrContext,
        dst: &mut Surface,
        fbo: &Framebuffer,
        shader_id: u32,
        fbo_width: i32,
        fbo_height: i32,
    ) {
        if fbo.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            // Unbind fbo
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            // Draw to screen
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            full_quad(ctx, shader_id);
            // Read from screen
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            // Read from fbo
            ctx.read_pixels(dst, 0, 0, fbo_width, fbo_height);
        }
    }

    fn render_color_clears(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let width = 128;
        let height = 128;
        let mut rnd = Random::new(0);

        // Create framebuffer
        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Clear fbo
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        // Enable scissor test.
        ctx.enable(glw::GL_SCISSOR_TEST);

        // Do 10 random color clears
        for _ in 0..15 {
            let c_x = (rnd.get_uint32() & 0x7fff_ffff) as i32 % width;
            let c_y = (rnd.get_uint32() & 0x7fff_ffff) as i32 % height;
            let c_width = (rnd.get_uint32() & 0x7fff_ffff) as i32 % (width - c_x);
            let c_height = (rnd.get_uint32() & 0x7fff_ffff) as i32 % (height - c_y);
            let packed = rnd.get_uint32();
            let color = crate::tcu::RGBA::from_packed(packed).to_vec();

            ctx.scissor(c_x, c_y, c_width, c_height);
            ctx.clear_color(color.x(), color.y(), color.z(), color.w());
            ctx.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        // Disable scissor.
        ctx.disable(glw::GL_SCISSOR_TEST);

        if fbo.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            // Unbind fbo
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

            // Draw to screen
            let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
            set_unit(ctx, shader_id, 0);

            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            full_quad(ctx, shader_id);

            // Read from screen
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            // clear alpha channel for GL_RGB5_A1 format because test
            // thresholds for the alpha channel do not account for dithering
            if self.config.colorbuffer_format == glw::GL_RGB5_A1 {
                clear_rgb5_a1_alpha(ctx);
            }

            // Read from fbo
            ctx.read_pixels(dst, 0, 0, width, height);
        }

        fbo.destroy(ctx);
        Ok(())
    }

    fn render_intersecting_quads(
        &self,
        ctx: &mut dyn SglrContext,
        dst: &mut Surface,
        npot: bool,
    ) -> Result<(), TestError> {
        let fbo_width = if npot { 127 } else { 128 };
        let fbo_height = if npot { 95 } else { 128 };

        let tex_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));

        let metaballs_tex = 1;
        let quads_tex = 2;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        let (width, height) = (fbo_width, fbo_height);

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Setup shaders
        set_unit(ctx, tex_shader_id, 0);

        // Draw scene
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        ctx.enable(glw::GL_DEPTH_TEST);

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, -1.0], [1.0, 1.0, 1.0]);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, 1.0], [1.0, 1.0, -1.0]);

        ctx.disable(glw::GL_DEPTH_TEST);

        self.present(ctx, dst, &fbo, tex_shader_id, width, height);
        fbo.destroy(ctx);
        Ok(())
    }

    fn render_mix(&self, ctx: &mut dyn SglrContext, dst: &mut Surface, npot: bool) -> Result<(), TestError> {
        let (fbo_a_width, fbo_a_height) = if npot { (127, 95) } else { (128, 128) };
        let (fbo_b_width, fbo_b_height) = if npot { (55, 63) } else { (64, 64) };

        let single_tex_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let mix_shader_id = ctx.create_program(Box::new(MixTexturesShader::new()));

        // Texture with metaballs
        let metaballs_tex = 1;
        ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        // Setup shaders
        set_unit(ctx, single_tex_shader_id, 0);
        set_units(ctx, mix_shader_id, 0, 1);

        // Fbo, quad with metaballs texture
        let fbo_a = Framebuffer::new(ctx, self.config, fbo_a_width, fbo_a_height)?;
        fbo_a.check_completeness(ctx)?;

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_a.framebuffer);
        ctx.viewport(0, 0, fbo_a_width, fbo_a_height);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        full_quad(ctx, single_tex_shader_id);

        // Fbo, color clears
        let fbo_b = Framebuffer::new(ctx, self.config, fbo_b_width, fbo_b_height)?;
        fbo_b.check_completeness(ctx)?;

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        ctx.viewport(0, 0, fbo_b_width, fbo_b_height);

        ctx.enable(glw::GL_SCISSOR_TEST);

        ctx.scissor(0, 0, 32, 64);
        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.scissor(32, 0, 32, 64);
        ctx.clear_color(0.0, 1.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.disable(glw::GL_SCISSOR_TEST);

        // Final mix op
        ctx.active_texture(glw::GL_TEXTURE0);
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_a.colorbuffer);
        ctx.active_texture(glw::GL_TEXTURE1);
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_b.colorbuffer);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        let (w, h) = (ctx.get_width(), ctx.get_height());
        ctx.viewport(0, 0, w, h);

        full_quad(ctx, mix_shader_id);

        ctx.read_pixels(dst, 0, 0, w, h);

        fbo_a.destroy(ctx);
        fbo_b.destroy(ctx);
        Ok(())
    }

    fn render_blend(&self, ctx: &mut dyn SglrContext, dst: &mut Surface, npot: bool) -> Result<(), TestError> {
        let (width, height) = if npot { (111, 122) } else { (128, 128) };

        let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));

        let metaballs_tex = 1;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        set_unit(ctx, shader_id, 0);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);

        ctx.clear_color(0.6, 0.0, 0.6, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        ctx.enable(glw::GL_BLEND);
        ctx.blend_equation(glw::GL_FUNC_ADD);
        ctx.blend_func_separate(
            glw::GL_SRC_ALPHA,
            glw::GL_ONE_MINUS_SRC_ALPHA,
            glw::GL_ZERO,
            glw::GL_ONE,
        );
        full_quad(ctx, shader_id);
        ctx.disable(glw::GL_BLEND);

        self.present(ctx, dst, &fbo, shader_id, width, height);
        fbo.destroy(ctx);
        Ok(())
    }

    fn render_stencil_clears(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));

        let width = 128;
        let height = 128;
        let quads_tex = 1;
        let metaballs_tex = 2;

        create_quads_tex2d(ctx, quads_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, width, height)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, width, height)?;

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Bind framebuffer and clear
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        // Do stencil clears
        ctx.enable(glw::GL_SCISSOR_TEST);
        ctx.scissor(10, 16, 32, 120);
        ctx.clear_stencil(1);
        ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
        ctx.scissor(16, 32, 100, 64);
        ctx.clear_stencil(2);
        ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
        ctx.disable(glw::GL_SCISSOR_TEST);

        // Draw 2 textures with stecil tests
        ctx.active_texture(glw::GL_TEXTURE0);
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.active_texture(glw::GL_TEXTURE1);
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);

        ctx.enable(glw::GL_STENCIL_TEST);

        ctx.stencil_func(glw::GL_EQUAL, 1, 0xffff_ffff);
        set_unit(ctx, shader_id, 0);
        full_quad(ctx, shader_id);

        ctx.stencil_func(glw::GL_EQUAL, 2, 0xffff_ffff);
        set_unit(ctx, shader_id, 1);
        full_quad(ctx, shader_id);

        ctx.disable(glw::GL_STENCIL_TEST);

        if fbo.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.active_texture(glw::GL_TEXTURE0);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            set_unit(ctx, shader_id, 0);
            full_quad(ctx, shader_id);
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            // clear alpha channel for GL_RGB5_A1 format because test
            // thresholds for the alpha channel do not account for dithering
            if self.config.colorbuffer_format == glw::GL_RGB5_A1 {
                clear_rgb5_a1_alpha(ctx);
            }

            ctx.read_pixels(dst, 0, 0, width, height);
        }

        fbo.destroy(ctx);
        Ok(())
    }

    fn render_stencil(&self, ctx: &mut dyn SglrContext, dst: &mut Surface, npot: bool) -> Result<(), TestError> {
        let (width, height) = if npot { (99, 110) } else { (128, 128) };

        let color_shader_id = ctx.create_program(Box::new(FlatColorShader::new()));
        let tex_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));

        let tex_width = 64;
        let tex_height = 64;
        let quads_tex = 1;
        let metaballs_tex = 2;
        let depth = self.config.depthbuffer_type != glw::GL_NONE;

        create_quads_tex2d(
            ctx,
            quads_tex,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            tex_width,
            tex_height,
        )?;
        create_metaballs_tex2d(
            ctx,
            metaballs_tex,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            tex_width,
            tex_height,
        )?;

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Bind framebuffer and clear
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        // Render intersecting quads - increment stencil on depth pass
        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);
        ctx.stencil_func(glw::GL_ALWAYS, 0, 0xff);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_INCR);

        set_color(ctx, color_shader_id, [0.0, 0.0, 1.0, 1.0]);
        quad(ctx, color_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        set_unit(ctx, tex_shader_id, 0);
        quad(ctx, tex_shader_id, [-1.0, -1.0, -1.0], [1.0, 1.0, 1.0]);

        // Draw quad with stencil test (stencil == 1 or 2 depending on depth) - decrement on stencil failure
        ctx.disable(glw::GL_DEPTH_TEST);
        ctx.stencil_func(glw::GL_EQUAL, if depth { 2 } else { 1 }, 0xff);
        ctx.stencil_op(glw::GL_DECR, glw::GL_KEEP, glw::GL_KEEP);

        set_color(ctx, color_shader_id, [0.0, 1.0, 0.0, 1.0]);
        quad(ctx, color_shader_id, [-0.5, -0.5, 0.0], [0.5, 0.5, 0.0]);

        // Draw metaballs with stencil test where stencil > 1 or 2 depending on depth buffer
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);

        ctx.stencil_func(glw::GL_GREATER, if depth { 1 } else { 2 }, 0xff);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);

        full_quad(ctx, tex_shader_id);

        ctx.disable(glw::GL_STENCIL_TEST);

        if fbo.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.active_texture(glw::GL_TEXTURE0);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            full_quad(ctx, tex_shader_id);
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            ctx.read_pixels(dst, 0, 0, width, height);
        }

        fbo.destroy(ctx);
        Ok(())
    }

    fn render_shared_colorbuffer(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let width = 128;
        let height = 128;
        // bool depth = getConfig().depthbufferFormat != GL_NONE;
        let stencil = self.config.stencilbuffer_format != glw::GL_NONE;

        // Textures
        let quads_tex = 1;
        let metaballs_tex = 2;
        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        ctx.viewport(0, 0, width, height);
        set_unit(ctx, shader_id, 0);

        // Fbo A
        let fbo_a = Framebuffer::new(ctx, self.config, width, height)?;
        fbo_a.check_completeness(ctx)?;

        // Fbo B - don't create colorbuffer
        let mut cfg = self.config;
        cfg.colorbuffer_type = glw::GL_NONE;
        cfg.colorbuffer_format = glw::GL_NONE;
        let fbo_b = Framebuffer::new(ctx, cfg, width, height)?;

        // Attach color buffer from fbo A
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        match self.config.colorbuffer_type {
            glw::GL_TEXTURE_2D => {
                ctx.framebuffer_texture2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    fbo_a.colorbuffer,
                    0,
                );
            }
            glw::GL_RENDERBUFFER => {
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    fbo_a.colorbuffer,
                );
            }
            _ => unreachable!("SharedColorbufferTest: colorbuffer type"),
        }

        // Clear depth and stencil in fbo B
        ctx.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        // Render quads to fbo 1, with depth 0.0
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_a.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        if stencil {
            // Stencil to 1 in fbo A
            ctx.clear_stencil(1);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
        }

        ctx.enable(glw::GL_DEPTH_TEST);
        full_quad(ctx, shader_id);
        ctx.disable(glw::GL_DEPTH_TEST);

        // Blend metaballs to fbo 2
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        ctx.enable(glw::GL_BLEND);
        ctx.blend_func_separate(
            glw::GL_SRC_ALPHA,
            glw::GL_ONE_MINUS_SRC_ALPHA,
            glw::GL_ZERO,
            glw::GL_ONE,
        );
        full_quad(ctx, shader_id);

        // Render small quad that is only visible if depth buffer is not shared with fbo A - or there is no depth bits
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.enable(glw::GL_DEPTH_TEST);
        quad(ctx, shader_id, [0.5, 0.5, 0.5], [1.0, 1.0, 0.5]);
        ctx.disable(glw::GL_DEPTH_TEST);

        if stencil {
            let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new()));
            set_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);

            // Clear subset of stencil buffer to 1
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.scissor(10, 10, 12, 25);
            ctx.clear_stencil(1);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);

            // Render quad with stencil mask == 1
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
            full_quad(ctx, flat_shader_id);
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        // Get results
        if fbo_a.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_a.colorbuffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            full_quad(ctx, shader_id);
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            ctx.read_pixels(dst, 0, 0, width, height);
        }

        fbo_a.destroy(ctx);
        fbo_b.destroy(ctx);
        Ok(())
    }

    fn render_shared_colorbuffer_clears(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let width = 128;
        let height = 128;
        let colorbuffer = 1;

        check_color_format_support(ctx, self.config.colorbuffer_format)?;

        // Single colorbuffer
        if self.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            ctx.bind_texture(glw::GL_TEXTURE_2D, colorbuffer);
            tex_image_2d_storage(
                ctx,
                glw::GL_TEXTURE_2D,
                0,
                self.config.colorbuffer_format,
                width,
                height,
            )?;
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        } else {
            debug_assert_eq!(self.config.colorbuffer_type, glw::GL_RENDERBUFFER);
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, colorbuffer);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.config.colorbuffer_format, width, height);
        }

        // Multiple framebuffers sharing the colorbuffer
        for fbo in 1..=3u32 {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);

            if self.config.colorbuffer_type == glw::GL_TEXTURE_2D {
                ctx.framebuffer_texture2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    colorbuffer,
                    0,
                );
            } else {
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    colorbuffer,
                );
            }
        }

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 1);

        // Check completeness
        {
            let status = ctx.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(fbo_incomplete_error(status));
            }
        }

        // Render to them
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(0.0, 0.0, 1.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.enable(glw::GL_SCISSOR_TEST);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 2);
        ctx.clear_color(0.6, 0.0, 0.0, 1.0);
        ctx.scissor(10, 10, 64, 64);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);
        ctx.clear_color(0.0, 0.6, 0.0, 1.0);
        ctx.scissor(60, 60, 40, 20);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 3);
        ctx.clear_color(0.0, 0.0, 0.6, 1.0);
        ctx.scissor(20, 20, 100, 10);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 1);
        ctx.clear_color(0.6, 0.0, 0.6, 1.0);
        ctx.scissor(20, 20, 5, 100);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.disable(glw::GL_SCISSOR_TEST);

        if self.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
            set_unit(ctx, shader_id, 0);

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            quad(ctx, shader_id, [-0.9, -0.9, 0.0], [0.9, 0.9, 0.0]);
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            ctx.read_pixels(dst, 0, 0, width, height);
        }

        Ok(())
    }

    fn render_shared_depthbuffer(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let tex_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let color_shader_id = ctx.create_program(Box::new(FlatColorShader::new()));
        let width = 128;
        let height = 128;
        let stencil = self.config.stencilbuffer_type != glw::GL_NONE;

        // Setup shaders
        set_unit(ctx, tex_shader_id, 0);
        set_color(ctx, color_shader_id, [0.0, 1.0, 0.0, 1.0]);

        // Textures
        let metaballs_tex = 5;
        let quads_tex = 6;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        ctx.viewport(0, 0, width, height);

        // Fbo A
        let fbo_a = Framebuffer::new(ctx, self.config, width, height)?;
        fbo_a.check_completeness(ctx)?;

        // Fbo B
        let mut cfg = self.config;
        cfg.depthbuffer_type = glw::GL_NONE;
        cfg.depthbuffer_format = glw::GL_NONE;
        let fbo_b = Framebuffer::new(ctx, cfg, width, height)?;

        // Bind depth buffer from fbo A to fbo B
        debug_assert_eq!(fbo_a.config.depthbuffer_type, glw::GL_RENDERBUFFER);
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            fbo_a.depthbuffer,
        );

        // Clear fbo B color to red and stencil to 1
        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear_stencil(1);
        ctx.clear(ALL_BUFFER_BITS);

        // Enable depth test.
        ctx.enable(glw::GL_DEPTH_TEST);

        // Render quad to fbo A
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_a.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);
        full_quad(ctx, tex_shader_id);

        // Render metaballs to fbo B
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, -1.0], [1.0, 1.0, 1.0]);

        ctx.disable(glw::GL_DEPTH_TEST);

        if stencil {
            // Clear subset of stencil buffer to 0
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.scissor(10, 10, 12, 25);
            ctx.clear_stencil(0);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);

            // Render quad with stencil mask == 0
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 0, 0xff);
            full_quad(ctx, color_shader_id);
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        if self.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            // Render both to screen
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);

            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_a.colorbuffer);
            quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [0.0, 1.0, 0.0]);

            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_b.colorbuffer);
            quad(ctx, tex_shader_id, [0.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            // Read results from fbo B
            ctx.read_pixels(dst, 0, 0, width, height);
        }

        fbo_a.destroy(ctx);
        fbo_b.destroy(ctx);
        Ok(())
    }

    fn render_tex_sub_image_after_render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        use crate::tcu::ChannelOrder;

        let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let is_rgba = self.config.colorbuffer_format == glw::GL_RGBA;

        let four_quads = make_level(ChannelOrder::RGB, 64, fill_with_rgba_quads)?;
        let metaballs = make_level(if is_rgba { ChannelOrder::RGBA } else { ChannelOrder::RGB }, 64, |l| {
            fill_with_metaballs(l, 5, 3)
        })?;

        set_unit(ctx, shader_id, 0);

        let four_quads_tex = 1;
        ctx.bind_texture(glw::GL_TEXTURE_2D, four_quads_tex);
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        ctx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB,
            64,
            64,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            Some(four_quads.data()),
        );

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 1);
        let fbo_tex = 2;
        let fbo_format = if is_rgba { glw::GL_RGBA } else { glw::GL_RGB };
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_tex);
        tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, fbo_format, 128, 128)?;
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        ctx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            fbo_tex,
            0,
        );

        // Render to fbo
        ctx.viewport(0, 0, 128, 128);
        ctx.bind_texture(glw::GL_TEXTURE_2D, four_quads_tex);
        full_quad(ctx, shader_id);

        // Update texture using TexSubImage2D
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_tex);
        ctx.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            32,
            32,
            64,
            64,
            fbo_format,
            glw::GL_UNSIGNED_BYTE,
            metaballs.data(),
        );

        // Draw to screen
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        let (w, h) = (ctx.get_width(), ctx.get_height());
        ctx.viewport(0, 0, w, h);
        full_quad(ctx, shader_id);

        ctx.read_pixels(dst, 0, 0, w, h);
        Ok(())
    }

    fn render_tex_sub_image_between_render(
        &self,
        ctx: &mut dyn SglrContext,
        dst: &mut Surface,
    ) -> Result<(), TestError> {
        use crate::tcu::ChannelOrder;

        let shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let is_rgba = self.config.colorbuffer_format == glw::GL_RGBA;

        let four_quads = make_level(ChannelOrder::RGB, 64, fill_with_rgba_quads)?;
        let metaballs = make_level(if is_rgba { ChannelOrder::RGBA } else { ChannelOrder::RGB }, 64, |l| {
            fill_with_metaballs(l, 5, 3)
        })?;
        let metaballs2 = make_level(ChannelOrder::RGBA, 64, |l| fill_with_metaballs(l, 5, 4))?;

        let metaballs_tex = 3;
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        ctx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            64,
            64,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(metaballs2.data()),
        );

        let four_quads_tex = 1;
        ctx.bind_texture(glw::GL_TEXTURE_2D, four_quads_tex);
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        ctx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB,
            64,
            64,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            Some(four_quads.data()),
        );

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 1);
        let fbo_tex = 2;
        let fbo_format = if is_rgba { glw::GL_RGBA } else { glw::GL_RGB };
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_tex);
        tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, fbo_format, 128, 128)?;
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        ctx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            fbo_tex,
            0,
        );

        set_unit(ctx, shader_id, 0);

        // Render to fbo
        ctx.viewport(0, 0, 128, 128);
        ctx.bind_texture(glw::GL_TEXTURE_2D, four_quads_tex);
        full_quad(ctx, shader_id);

        // Update texture using TexSubImage2D
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_tex);
        ctx.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            32,
            32,
            64,
            64,
            fbo_format,
            glw::GL_UNSIGNED_BYTE,
            metaballs.data(),
        );

        // Render again to fbo
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        ctx.enable(glw::GL_BLEND);
        ctx.blend_func_separate(
            glw::GL_SRC_ALPHA,
            glw::GL_ONE_MINUS_SRC_ALPHA,
            glw::GL_ZERO,
            glw::GL_ONE,
        );
        full_quad(ctx, shader_id);
        ctx.disable(glw::GL_BLEND);

        // Draw to screen
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        let (w, h) = (ctx.get_width(), ctx.get_height());
        ctx.viewport(0, 0, w, h);
        ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_tex);
        full_quad(ctx, shader_id);

        ctx.read_pixels(dst, 0, 0, w, h);
        Ok(())
    }

    fn render_resize(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let tex_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let color_shader_id = ctx.create_program(Box::new(FlatColorShader::new()));
        let quads_tex = 1;
        let metaballs_tex = 2;
        let depth = self.config.depthbuffer_type != glw::GL_NONE;
        let stencil = self.config.stencilbuffer_type != glw::GL_NONE;

        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 32, 32)?;

        let fbo = Framebuffer::new(ctx, self.config, 128, 128)?;
        fbo.check_completeness(ctx)?;

        // Setup shaders
        set_unit(ctx, tex_shader_id, 0);
        set_color(ctx, color_shader_id, [0.0, 1.0, 0.0, 1.0]);

        // Render quads
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, 128, 128);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        full_quad(ctx, tex_shader_id);

        if fbo.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            // Render fbo to screen
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
            full_quad(ctx, tex_shader_id);

            // Restore binding
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        }

        let new_width = 64;
        let new_height = 32;

        // Resize buffers
        match fbo.config.colorbuffer_type {
            glw::GL_TEXTURE_2D => {
                ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
                tex_image_2d_storage(
                    ctx,
                    glw::GL_TEXTURE_2D,
                    0,
                    fbo.config.colorbuffer_format,
                    new_width,
                    new_height,
                )?;
            }
            glw::GL_RENDERBUFFER => {
                ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, fbo.colorbuffer);
                ctx.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    fbo.config.colorbuffer_format,
                    new_width,
                    new_height,
                );
            }
            _ => unreachable!("ResizeTest: colorbuffer type"),
        }

        if depth {
            debug_assert_eq!(fbo.config.depthbuffer_type, glw::GL_RENDERBUFFER);
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, fbo.depthbuffer);
            ctx.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                fbo.config.depthbuffer_format,
                new_width,
                new_height,
            );
        }

        if stencil {
            debug_assert_eq!(fbo.config.stencilbuffer_type, glw::GL_RENDERBUFFER);
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, fbo.stencilbuffer);
            ctx.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                fbo.config.stencilbuffer_format,
                new_width,
                new_height,
            );
        }

        // Render to resized fbo
        ctx.viewport(0, 0, new_width, new_height);
        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        ctx.enable(glw::GL_DEPTH_TEST);

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        quad(ctx, tex_shader_id, [0.0, 0.0, -1.0], [1.0, 1.0, 1.0]);

        ctx.disable(glw::GL_DEPTH_TEST);

        if stencil {
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.scissor(10, 10, 5, 15);
            ctx.clear_stencil(1);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);

            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
            full_quad(ctx, color_shader_id);
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        if self.config.colorbuffer_type == glw::GL_TEXTURE_2D {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.colorbuffer);
            quad(ctx, tex_shader_id, [-0.5, -0.5, 0.0], [0.5, 0.5, 0.0]);
            ctx.read_pixels(dst, 0, 0, w, h);
        } else {
            ctx.read_pixels(dst, 0, 0, new_width, new_height);
        }

        fbo.destroy(ctx);
        Ok(())
    }

    fn render_recreate_buffers(
        &self,
        ctx: &mut dyn SglrContext,
        dst: &mut Surface,
        buffers: u32,
        rebind: bool,
    ) -> Result<(), TestError> {
        let tex_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));
        let width = 128;
        let height = 128;
        let metaballs_tex = 1;
        let quads_tex = 2;
        let stencil = self.config.stencilbuffer_type != glw::GL_NONE;

        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Setup shader
        set_unit(ctx, tex_shader_id, 0);

        // Draw scene
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear(ALL_BUFFER_BITS);

        ctx.enable(glw::GL_DEPTH_TEST);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        full_quad(ctx, tex_shader_id);

        if stencil {
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.scissor(width / 4, height / 4, width / 2, height / 2);
            ctx.clear_stencil(1);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);
        }

        // Recreate buffers
        if !rebind {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        }

        if (buffers & glw::GL_COLOR_BUFFER_BIT) != 0 {
            let colorbuf = fbo.colorbuffer;

            match fbo.config.colorbuffer_type {
                glw::GL_TEXTURE_2D => {
                    ctx.delete_textures(&[colorbuf]);
                    ctx.bind_texture(glw::GL_TEXTURE_2D, colorbuf);
                    tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, fbo.config.colorbuffer_format, width, height)?;
                    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
                    if rebind {
                        ctx.framebuffer_texture2d(
                            glw::GL_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_TEXTURE_2D,
                            colorbuf,
                            0,
                        );
                    }
                }
                glw::GL_RENDERBUFFER => {
                    ctx.delete_renderbuffers(&[colorbuf]);
                    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, colorbuf);
                    ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, fbo.config.colorbuffer_format, width, height);
                    if rebind {
                        ctx.framebuffer_renderbuffer(
                            glw::GL_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_RENDERBUFFER,
                            colorbuf,
                        );
                    }
                }
                _ => unreachable!("RecreateBuffersTest: colorbuffer type"),
            }
        }

        if (buffers & glw::GL_DEPTH_BUFFER_BIT) != 0 {
            let depthbuf = fbo.depthbuffer;
            debug_assert_eq!(fbo.config.depthbuffer_type, glw::GL_RENDERBUFFER);

            ctx.delete_renderbuffers(&[depthbuf]);
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depthbuf);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, fbo.config.depthbuffer_format, width, height);
            if rebind {
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    depthbuf,
                );
            }
        }

        if (buffers & glw::GL_STENCIL_BUFFER_BIT) != 0 {
            let stencilbuf = fbo.stencilbuffer;
            debug_assert_eq!(fbo.config.stencilbuffer_type, glw::GL_RENDERBUFFER);

            ctx.delete_renderbuffers(&[stencilbuf]);
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, stencilbuf);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, fbo.config.stencilbuffer_format, width, height);
            if rebind {
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    stencilbuf,
                );
            }
        }

        if !rebind {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        }

        ctx.clear_color(0.0, 0.0, 1.0, 0.0);
        ctx.clear_stencil(0);
        ctx.clear(buffers); // \note Clear only buffers that were re-created

        if stencil {
            // \note Stencil test enabled only if we have stencil buffer
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 0, 0xff);
        }

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, 1.0], [1.0, 1.0, -1.0]);

        if stencil {
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        ctx.disable(glw::GL_DEPTH_TEST);

        // Read from fbo
        ctx.read_pixels(dst, 0, 0, width, height);

        fbo.destroy(ctx);
        Ok(())
    }

    fn render_repeated_clear(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let num_rows_cols = 4;
        let cell_size = 16;
        let fbo_sizes = [cell_size, cell_size * num_rows_cols];

        let fbo_blit_shader_id = ctx.create_program(Box::new(SingleTex2DShader::new()));

        let mut rnd = Random::new(18169662);

        let mut fbos = [0u32; 2];
        let mut textures = [0u32; 2];

        ctx.gen_framebuffers(&mut fbos);
        ctx.gen_textures(&mut textures);

        for fbo_ndx in 0..fbos.len() {
            let format = self.config.colorbuffer_format;
            ctx.bind_texture(glw::GL_TEXTURE_2D, textures[fbo_ndx]);
            ctx.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format,
                fbo_sizes[fbo_ndx],
                fbo_sizes[fbo_ndx],
                0,
                format,
                glw::GL_UNSIGNED_BYTE,
                None,
            );
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[fbo_ndx]);
            ctx.framebuffer_texture2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                textures[fbo_ndx],
                0,
            );

            {
                let status = ctx.check_framebuffer_status(glw::GL_FRAMEBUFFER);
                if status != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(fbo_incomplete_error(status));
                }
            }
        }

        // larger fbo bound -- clear to transparent black
        ctx.clear_color(0.0, 0.0, 0.0, 0.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        set_unit(ctx, fbo_blit_shader_id, 0);
        ctx.bind_texture(glw::GL_TEXTURE_2D, textures[0]);

        for cell_y in 0..num_rows_cols {
            for cell_x in 0..num_rows_cols {
                let r = rnd.get_float();
                let g = rnd.get_float();
                let b = rnd.get_float();
                let a = rnd.get_float();

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[0]);
                ctx.clear_color(r, g, b, a);
                ctx.clear(glw::GL_COLOR_BUFFER_BIT);

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[1]);
                ctx.viewport(cell_x * cell_size, cell_y * cell_size, cell_size, cell_size);
                full_quad(ctx, fbo_blit_shader_id);
            }
        }

        ctx.read_pixels(dst, 0, 0, fbo_sizes[1], fbo_sizes[1]);
        Ok(())
    }
}

impl TestCase for FboRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let clear_color = [0.125f32, 0.25, 0.5, 1.0];
        let rt = context.render_target();

        // Position & size for context
        let mut rnd = Random::new(de_string_hash(&self.name));
        let width = rt.width.min(128);
        let height = rt.height.min(128);
        let x_max = rt.width - width + 1;
        let y_max = rt.height - height + 1;
        let x = (rnd.get_uint32() % x_max as u32) as i32;
        let y = (rnd.get_uint32() % y_max as u32) as i32;

        let mut gles2_frame = Surface::new(width, height);
        let mut ref_frame = Surface::new(width, height);

        // Render using GLES2
        let gles2_error = {
            let mut gl_ctx = GLContext::new(&context.render_context, (x, y, width, height));
            gl_ctx.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
            gl_ctx.clear(ALL_BUFFER_BITS);
            self.render(&mut gl_ctx, &mut gles2_frame)?; // Call actual render func
            gl_ctx.get_error()
        };

        // Render reference image
        let ref_error = {
            let mut ref_ctx = create_reference_context_rgb8(context, width, height, rt.depth_bits)?;
            ref_ctx.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
            ref_ctx.clear(ALL_BUFFER_BITS);
            self.render(&mut ref_ctx, &mut ref_frame)?;
            ref_ctx.get_error()
        };

        // Compare error codes
        let mut fail_reason: Option<&str> = None;
        let error_codes_ok = gles2_error == ref_error;
        if !error_codes_ok {
            fail_reason = Some("Got unexpected error");
        }

        // Compare images
        let threshold = 0.05f32;
        let images_ok = fuzzy_compare_ok(
            &ref_frame.get_const_access(),
            &gles2_frame.get_const_access(),
            threshold,
        )
        .unwrap_or(false);
        if !images_ok && fail_reason.is_none() {
            fail_reason = Some("Image comparison failed");
        }

        // Store test result
        if error_codes_ok && images_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(fail_reason.unwrap_or("Image comparison failed")))
        }
    }
}

/// `addChildVariants<CaseType>`
fn add_child_variants(group: &mut TestCaseGroup, kind: Kind) {
    // (type, format)
    let colorbuffer_configs: [(GLenum, GLenum); 7] = [
        // { GL_TEXTURE_2D, GL_ALPHA },
        // { GL_TEXTURE_2D, GL_LUMINANCE },
        // { GL_TEXTURE_2D, GL_LUMINANCE_ALPHA },
        (glw::GL_TEXTURE_2D, glw::GL_RGB),
        (glw::GL_TEXTURE_2D, glw::GL_RGBA),
        (glw::GL_TEXTURE_2D, glw::GL_BGRA),
        (glw::GL_RENDERBUFFER, glw::GL_RGB565),
        (glw::GL_RENDERBUFFER, glw::GL_RGB5_A1),
        (glw::GL_RENDERBUFFER, glw::GL_RGBA4),
        // { GL_RENDERBUFFER, GL_RGBA16F },
        // { GL_RENDERBUFFER, GL_RGB16F }
        (glw::GL_RENDERBUFFER, glw::GL_BGRA),
    ];
    let depthbuffer_configs: [(GLenum, GLenum); 2] = [
        (glw::GL_NONE, glw::GL_NONE),
        (glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16),
    ];
    let stencilbuffer_configs: [(GLenum, GLenum); 2] = [
        (glw::GL_NONE, glw::GL_NONE),
        (glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8),
    ];

    for colorbuffer in colorbuffer_configs {
        for depthbuffer in depthbuffer_configs {
            for stencilbuffer in stencilbuffer_configs {
                let config = FboConfig {
                    colorbuffer_type: colorbuffer.0,
                    colorbuffer_format: colorbuffer.1,
                    depthbuffer_type: depthbuffer.0,
                    depthbuffer_format: depthbuffer.1,
                    stencilbuffer_type: stencilbuffer.0,
                    stencilbuffer_format: stencilbuffer.1,
                };

                if kind_supports(kind, &config) {
                    group.add_child(FboRenderCase::new(kind, config));
                }
            }
        }
    }
}

/// `createChildGroup<CaseType>`
fn create_child_group(parent: &mut TestCaseGroup, name: &str, kind: Kind) {
    let mut group = TestCaseGroup::new(name);
    add_child_variants(&mut group, kind);
    parent.add_child(group);
}

/// `createRecreateBuffersGroup<Buffers>`
fn create_recreate_buffers_group(parent: &mut TestCaseGroup, name: &str, buffers: u32) {
    let mut group = TestCaseGroup::new(name);
    add_child_variants(&mut group, Kind::RecreateBuffers { buffers, rebind: true });
    add_child_variants(&mut group, Kind::RecreateBuffers { buffers, rebind: false });
    parent.add_child(group);
}

/// `FboRenderTestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("render");

    create_child_group(&mut group, "color_clear", Kind::ColorClears);
    create_child_group(&mut group, "stencil_clear", Kind::StencilClears);

    let mut color_group = TestCaseGroup::new("color");
    add_child_variants(&mut color_group, Kind::Mix { npot: false });
    add_child_variants(&mut color_group, Kind::Mix { npot: true });
    add_child_variants(&mut color_group, Kind::Blend { npot: false });
    add_child_variants(&mut color_group, Kind::Blend { npot: true });
    group.add_child(color_group);

    let mut depth_group = TestCaseGroup::new("depth");
    add_child_variants(&mut depth_group, Kind::IntersectingQuads { npot: false });
    add_child_variants(&mut depth_group, Kind::IntersectingQuads { npot: true });
    group.add_child(depth_group);

    let mut stencil_group = TestCaseGroup::new("stencil");
    add_child_variants(&mut stencil_group, Kind::Stencil { npot: false });
    add_child_variants(&mut stencil_group, Kind::Stencil { npot: true });
    group.add_child(stencil_group);

    create_child_group(&mut group, "shared_colorbuffer_clear", Kind::SharedColorbufferClears);
    create_child_group(&mut group, "shared_colorbuffer", Kind::SharedColorbuffer);
    create_child_group(&mut group, "shared_depthbuffer", Kind::SharedDepthbuffer);
    create_child_group(&mut group, "resize", Kind::Resize);

    create_recreate_buffers_group(&mut group, "recreate_colorbuffer", glw::GL_COLOR_BUFFER_BIT);
    create_recreate_buffers_group(&mut group, "recreate_depthbuffer", glw::GL_DEPTH_BUFFER_BIT);
    create_recreate_buffers_group(&mut group, "recreate_stencilbuffer", glw::GL_STENCIL_BUFFER_BIT);

    let mut tex_sub_image_group = TestCaseGroup::new("texsubimage");
    add_child_variants(&mut tex_sub_image_group, Kind::TexSubImageAfterRender);
    add_child_variants(&mut tex_sub_image_group, Kind::TexSubImageBetweenRender);
    group.add_child(tex_sub_image_group);

    {
        let mut repeated_clear_group = TestCaseGroup::new("repeated_clear");
        for format in [glw::GL_RGB, glw::GL_RGBA] {
            let mut config = FboConfig::new();
            config.colorbuffer_type = glw::GL_TEXTURE_2D;
            config.colorbuffer_format = format;
            config.depthbuffer_type = glw::GL_NONE;
            config.stencilbuffer_type = glw::GL_NONE;
            repeated_clear_group.add_child(FboRenderCase::new(Kind::RepeatedClear, config));
        }
        group.add_child(repeated_clear_group);
    }

    group
}
