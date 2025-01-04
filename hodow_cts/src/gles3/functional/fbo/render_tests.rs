// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboRenderTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.fbo.render`: every case renders one scene through `sglr::Context` against
// the real driver and against `sglr::ReferenceContext` and compares the two frames with
// `bilinear_compare` plus the two `glGetError` results.
//
// Mapping notes:
//  - Upstream's `FboCases` classes become one `FboRenderCase` and a `Kind` enum; `render` is a match.
//  - `Framebuffer` has no destructor here: the contexts are thrown away after each case.
//  - `fillWithMetaballs`/`fillWithRGBAQuads`/`createMetaballsTex2D`/`createQuadsTex2D` are the ones
//    already ported for `gles2::functional::fbo::render_tests`.
//
// Narrowing (the cases are all registered, so the counts match upstream; these end as NotSupported):
//  - Read-back of float/int/uint renderbuffers goes through `sglr::Context::read_pixels_rgba_f32`, and the
//    reference `Texture2DShader` samples integer textures with `sample_int`/`sample_uint`.
//  - The `texsubimage` variants upstream keeps under `#if 0` are not ported either.

use super::fbo_test_util::{
    FlatColorShader, Texture2DShader, clear_color_buffer, fbo_incomplete_error, get_format_name,
    get_format_threshold_gl, get_fragment_output_type, get_sampler_2d_type, read_pixels, set_flat_color,
};
use crate::gles2::functional::fbo::render_tests::{create_metaballs_tex2d, create_quads_tex2d};
use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::sglr::gl_context::GLContext;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel::get_texture_format_info;
use crate::tcu::vector::Vec3;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus, TextureFormat, de_string_hash};

/// `FboConfig`
#[derive(Clone, Copy)]
struct FboConfig {
    /// Buffer bit mask (`GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | ...`)
    buffers: u32,
    /// `GL_TEXTURE_2D` or `GL_RENDERBUFFER`
    color_type: GLenum,
    color_format: GLenum,
    depth_stencil_type: GLenum,
    depth_stencil_format: GLenum,
}

impl FboConfig {
    fn new(
        buffers: u32,
        color_type: GLenum,
        color_format: GLenum,
        depth_stencil_type: GLenum,
        depth_stencil_format: GLenum,
    ) -> Self {
        Self {
            buffers,
            color_type,
            color_format,
            depth_stencil_type,
            depth_stencil_format,
        }
    }

    /// `FboConfig::getName`
    fn name(&self) -> String {
        debug_assert!(self.buffers & glw::GL_COLOR_BUFFER_BIT != 0);
        let mut name = format!("{}_{}", type_name(self.color_type), get_format_name(self.color_format));

        if self.buffers & glw::GL_DEPTH_BUFFER_BIT != 0 {
            name.push_str("_depth");
        }
        if self.buffers & glw::GL_STENCIL_BUFFER_BIT != 0 {
            name.push_str("_stencil");
        }
        if self.buffers & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT) != 0 {
            name.push_str(&format!(
                "_{}_{}",
                type_name(self.depth_stencil_type),
                get_format_name(self.depth_stencil_format)
            ));
        }
        name
    }
}

/// `getTypeName`
fn type_name(type_: GLenum) -> &'static str {
    match type_ {
        glw::GL_TEXTURE_2D => "tex2d",
        glw::GL_RENDERBUFFER => "rbo",
        other => panic!("Unknown type {other:#x}"),
    }
}

/// `getEnablingExtensions`
fn get_enabling_extensions(format: GLenum) -> Vec<&'static str> {
    match format {
        glw::GL_RGB16F => vec!["GL_EXT_color_buffer_half_float"],
        glw::GL_RGBA16F | glw::GL_RG16F | glw::GL_R16F => {
            vec!["GL_EXT_color_buffer_half_float", "GL_EXT_color_buffer_float"]
        }
        glw::GL_RGBA32F | glw::GL_RGB32F | glw::GL_R11F_G11F_B10F | glw::GL_RG32F | glw::GL_R32F => {
            vec!["GL_EXT_color_buffer_float"]
        }
        _ => Vec::new(),
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
    let required_exts = get_enabling_extensions(sized_format);

    if !required_exts.is_empty() && !required_exts.iter().any(|e| is_extension_supported(ctx, e)) {
        let err_msg = if required_exts.len() == 1 {
            format!("Format not supported, requires {}", required_exts[0])
        } else {
            format!(
                "Format not supported, requires  one of the following: {}",
                required_exts.join(", ")
            )
        };
        return Err(TestError::NotSupported(err_msg));
    }
    Ok(())
}

fn is_power_of_two(v: i32) -> bool {
    v > 0 && (v & (v - 1)) == 0
}

/// `sglr::Context::texImage2D(target, level, internalFormat, width, height)` - the storage-only
/// overload that picks the transfer format from the internal one.
pub(super) fn tex_image_2d_storage(
    ctx: &mut dyn SglrContext,
    target: GLenum,
    level: i32,
    internal_format: GLenum,
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    let tex_format = map_gl_internal_format(internal_format)
        .ok_or_else(|| TestError::Fail(format!("unknown internal format {internal_format:#x}")))?;
    let transfer = get_transfer_format(tex_format)?;
    ctx.tex_image_2d(
        target,
        level,
        internal_format,
        width,
        height,
        0,
        transfer.format,
        transfer.data_type,
        None,
    );
    Ok(())
}

/// `Framebuffer`
struct Framebuffer {
    config: FboConfig,
    framebuffer: u32,
    color_buffer: u32,
    depth_stencil_buffer: u32,
}

impl Framebuffer {
    fn new(ctx: &mut dyn SglrContext, config: FboConfig, width: i32, height: i32) -> Result<Self, TestError> {
        // Verify that color format is supported
        check_color_format_support(ctx, config.color_format)?;

        let mut names = [0u32];
        ctx.gen_framebuffers(&mut names);
        let mut fb = Self {
            config,
            framebuffer: names[0],
            color_buffer: 0,
            depth_stencil_buffer: 0,
        };
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fb.framebuffer);

        if config.buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
            match config.color_type {
                glw::GL_TEXTURE_2D => {
                    fb.color_buffer = Self::create_tex2d(ctx, config.color_format, width, height)?;
                    ctx.framebuffer_texture2d(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_TEXTURE_2D,
                        fb.color_buffer,
                        0,
                    );
                }
                glw::GL_RENDERBUFFER => {
                    fb.color_buffer = Self::create_rbo(ctx, config.color_format, width, height);
                    ctx.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        fb.color_buffer,
                    );
                }
                _ => return Err(TestError::Fail("Unsupported type".to_string())),
            }
        }

        if config.buffers & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT) != 0 {
            match config.depth_stencil_type {
                glw::GL_TEXTURE_2D => {
                    fb.depth_stencil_buffer = Self::create_tex2d(ctx, config.depth_stencil_format, width, height)?;
                }
                glw::GL_RENDERBUFFER => {
                    fb.depth_stencil_buffer = Self::create_rbo(ctx, config.depth_stencil_format, width, height);
                }
                _ => return Err(TestError::Fail("Unsupported type".to_string())),
            }
        }

        for ndx in 0..2 {
            let bit = if ndx == 1 {
                glw::GL_STENCIL_BUFFER_BIT
            } else {
                glw::GL_DEPTH_BUFFER_BIT
            };
            let point = if ndx == 1 {
                glw::GL_STENCIL_ATTACHMENT
            } else {
                glw::GL_DEPTH_ATTACHMENT
            };

            if config.buffers & bit == 0 {
                continue; // Not used.
            }

            match config.depth_stencil_type {
                glw::GL_TEXTURE_2D => ctx.framebuffer_texture2d(
                    glw::GL_FRAMEBUFFER,
                    point,
                    glw::GL_TEXTURE_2D,
                    fb.depth_stencil_buffer,
                    0,
                ),
                glw::GL_RENDERBUFFER => ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    point,
                    glw::GL_RENDERBUFFER,
                    fb.depth_stencil_buffer,
                ),
                _ => return Err(TestError::Fail("Unsupported depth/stencil type".to_string())),
            }
        }

        let err = ctx.get_error();
        if err != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!("Got GL error {err:#x}")));
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

    /// `Framebuffer::createTex2D`
    fn create_tex2d(ctx: &mut dyn SglrContext, format: GLenum, width: i32, height: i32) -> Result<u32, TestError> {
        let mut names = [0u32];
        ctx.gen_textures(&mut names);
        let name = names[0];

        ctx.bind_texture(glw::GL_TEXTURE_2D, name);
        tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, format, width, height)?;

        if !is_power_of_two(width) || !is_power_of_two(height) {
            // Set wrap mode to clamp for NPOT FBOs
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
        }

        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);

        Ok(name)
    }

    /// `Framebuffer::createRbo`
    fn create_rbo(ctx: &mut dyn SglrContext, format: GLenum, width: i32, height: i32) -> u32 {
        let mut names = [0u32];
        ctx.gen_renderbuffers(&mut names);

        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, names[0]);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, format, width, height);

        names[0]
    }
}

/// What every test but `SharedColorbuffer*` and `SharedDepthStencil` derives from the colour format:
/// `getSampler2DType`/`getFragmentOutputType`/`getTextureFormatInfo` and the out/lookup scale and bias.
struct FboRange {
    color_format: TextureFormat,
    output_type: DataType,
    out_scale: [f32; 4],
    out_bias: [f32; 4],
    lookup_scale: [f32; 4],
    lookup_bias: [f32; 4],
}

impl FboRange {
    fn new(config: &FboConfig) -> Result<Self, TestError> {
        let color_format = map_gl_internal_format(config.color_format)
            .ok_or_else(|| TestError::Fail(format!("unknown internal format {:#x}", config.color_format)))?;

        let info = get_texture_format_info(color_format);
        let mut out_scale = [0.0f32; 4];
        for i in 0..4 {
            out_scale[i] = info.value_max[i] - info.value_min[i];
        }

        Ok(Self {
            color_format,
            output_type: get_fragment_output_type(color_format),
            out_scale,
            out_bias: info.value_min,
            lookup_scale: info.look_up_scale,
            lookup_bias: info.look_up_bias,
        })
    }

    /// `Vec4(...) * fboOutScale + fboOutBias`
    fn scale_bias(&self, c: [f32; 4]) -> [f32; 4] {
        [
            c[0] * self.out_scale[0] + self.out_bias[0],
            c[1] * self.out_scale[1] + self.out_bias[1],
            c[2] * self.out_scale[2] + self.out_bias[2],
            c[3] * self.out_scale[3] + self.out_bias[3],
        ]
    }
}

fn quad(ctx: &mut dyn SglrContext, program: u32, p0: [f32; 3], p1: [f32; 3]) {
    draw_quad(
        ctx,
        program,
        Vec3::new(p0[0], p0[1], p0[2]),
        Vec3::new(p1[0], p1[1], p1[2]),
    );
}

/// The two texture shaders every ranged test builds: `texToFboShader` and `texFromFboShader`, returned as
/// `(program id, uniforms)` pairs.
fn make_range_shaders(
    ctx: &mut dyn SglrContext,
    range: &FboRange,
) -> (
    u32,
    super::fbo_test_util::Texture2DUniforms,
    u32,
    super::fbo_test_util::Texture2DUniforms,
) {
    let tex_to_fbo = Texture2DShader::new(1, range.output_type, range.out_scale, range.out_bias);
    let tex_to_fbo_uniforms = tex_to_fbo.uniforms();
    let mut tex_from_fbo = Texture2DShader::with_samplers(
        &[get_sampler_2d_type(range.color_format)],
        DataType::FloatVec4,
        [1.0; 4],
        [0.0; 4],
    );
    tex_from_fbo.set_tex_scale_bias(0, range.lookup_scale, range.lookup_bias);
    let tex_from_fbo_uniforms = tex_from_fbo.uniforms();

    let tex_to_fbo_id = ctx.create_program(Box::new(tex_to_fbo));
    let tex_from_fbo_id = ctx.create_program(Box::new(tex_from_fbo));
    (
        tex_to_fbo_id,
        tex_to_fbo_uniforms,
        tex_from_fbo_id,
        tex_from_fbo_uniforms,
    )
}

fn read_fbo_result(
    ctx: &mut dyn SglrContext,
    dst: &mut Surface,
    width: i32,
    height: i32,
    color_format: TextureFormat,
    scale: [f32; 4],
    bias: [f32; 4],
) -> Result<(), TestError> {
    read_pixels(ctx, dst, 0, 0, width, height, color_format, scale, bias)
}

fn read_screen(ctx: &mut dyn SglrContext, dst: &mut Surface) {
    let (w, h) = (ctx.get_width(), ctx.get_height());
    dst.set_size(w, h);
    ctx.read_pixels(dst, 0, 0, w, h);
}

#[derive(Clone, Copy)]
enum Kind {
    StencilClears,
    SharedColorbuffer,
    SharedColorbufferClears,
    SharedDepthStencil,
    Resize,
    RecreateBuffers { buffers: u32, rebind: bool },
}

/// `FboRenderCase` and the `FboCases` subclasses.
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
            Kind::RecreateBuffers { rebind, .. } if !rebind => format!("{base}_no_rebind"),
            _ => base,
        };
        Box::new(Self { name, kind, config })
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        match self.kind {
            Kind::StencilClears => self.render_stencil_clears(ctx, dst),
            Kind::SharedColorbuffer => self.render_shared_colorbuffer(ctx, dst),
            Kind::SharedColorbufferClears => self.render_shared_colorbuffer_clears(ctx, dst),
            Kind::SharedDepthStencil => self.render_shared_depth_stencil(ctx, dst),
            Kind::Resize => self.render_resize(ctx, dst),
            Kind::RecreateBuffers { buffers, rebind } => self.render_recreate_buffers(ctx, dst, buffers, rebind),
        }
    }

    /// `StencilClearsTest::render`
    fn render_stencil_clears(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let range = FboRange::new(&self.config)?;
        let (tex_to_fbo_id, tex_to_fbo_u, tex_from_fbo_id, tex_from_fbo_u) = make_range_shaders(ctx, &range);

        let metaballs_tex = 1u32;
        let quads_tex = 2u32;
        let width = 128;
        let height = 128;

        create_quads_tex2d(ctx, quads_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, width, height)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, width, height)?;

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Bind framebuffer and clear
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        // Do stencil clears
        ctx.enable(glw::GL_SCISSOR_TEST);
        ctx.scissor(10, 16, 32, 120);
        ctx.clear_stencil(1);
        ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
        ctx.scissor(16, 32, 100, 64);
        ctx.clear_stencil(2);
        ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
        ctx.disable(glw::GL_SCISSOR_TEST);

        // Draw 2 textures with stencil tests
        ctx.enable(glw::GL_STENCIL_TEST);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);

        tex_to_fbo_u.set_uniforms(ctx, tex_to_fbo_id);
        quad(ctx, tex_to_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        ctx.stencil_func(glw::GL_EQUAL, 2, 0xff);

        tex_to_fbo_u.set_uniforms(ctx, tex_to_fbo_id);
        quad(ctx, tex_to_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        ctx.disable(glw::GL_STENCIL_TEST);

        if fbo.config.color_type == glw::GL_TEXTURE_2D {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.color_buffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);

            tex_from_fbo_u.set_uniforms(ctx, tex_from_fbo_id);
            quad(ctx, tex_from_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

            read_screen(ctx, dst);
            Ok(())
        } else {
            read_fbo_result(
                ctx,
                dst,
                width,
                height,
                range.color_format,
                range.lookup_scale,
                range.lookup_bias,
            )
        }
    }

    /// `SharedColorbufferTest::render`
    fn render_shared_colorbuffer(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));

        let width = 128;
        let height = 128;
        let quads_tex = 1u32;
        let metaballs_tex = 2u32;
        let stencil = self.config.buffers & glw::GL_STENCIL_BUFFER_BIT != 0;

        ctx.disable(glw::GL_DITHER);

        // Textures
        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        ctx.viewport(0, 0, width, height);

        // Fbo A
        let fbo_a = Framebuffer::new(ctx, self.config, width, height)?;
        fbo_a.check_completeness(ctx)?;

        // Fbo B - don't create colorbuffer
        let mut cfg = self.config;
        cfg.buffers &= !glw::GL_COLOR_BUFFER_BIT;
        cfg.color_type = glw::GL_NONE;
        cfg.color_format = glw::GL_NONE;
        let fbo_b = Framebuffer::new(ctx, cfg, width, height)?;

        // Attach color buffer from fbo A
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        match self.config.color_type {
            glw::GL_TEXTURE_2D => ctx.framebuffer_texture2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                fbo_a.color_buffer,
                0,
            ),
            glw::GL_RENDERBUFFER => ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                fbo_a.color_buffer,
            ),
            _ => return Err(TestError::Fail("Unsupported colour type".to_string())),
        }

        // Clear depth and stencil in fbo B
        ctx.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        // Render quads to fbo 1, with depth 0.0
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_a.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        if stencil {
            // Stencil to 1 in fbo A
            ctx.clear_stencil(1);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
        }

        tex_uniforms.set_uniforms(ctx, tex_shader_id);

        ctx.enable(glw::GL_DEPTH_TEST);
        quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);
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
        quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        // Render small quad that is only visible if depth buffer is not shared with fbo A - or there is no depth bits
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        ctx.enable(glw::GL_DEPTH_TEST);
        quad(ctx, tex_shader_id, [0.5, 0.5, 0.5], [1.0, 1.0, 0.5]);
        ctx.disable(glw::GL_DEPTH_TEST);

        if stencil {
            set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);

            // Clear subset of stencil buffer to 1
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.scissor(10, 10, 12, 25);
            ctx.clear_stencil(1);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);

            // Render quad with stencil mask == 1
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
            quad(ctx, flat_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        // Get results
        if fbo_a.config.color_type == glw::GL_TEXTURE_2D {
            tex_uniforms.set_uniforms(ctx, tex_shader_id);

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_a.color_buffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);
            read_screen(ctx, dst);
            Ok(())
        } else {
            let format = map_gl_internal_format(fbo_a.config.color_format)
                .ok_or_else(|| TestError::Fail("unknown colour format".to_string()))?;
            read_fbo_result(ctx, dst, width, height, format, [1.0; 4], [0.0; 4])
        }
    }

    /// `SharedColorbufferClearsTest::render`
    fn render_shared_colorbuffer_clears(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let config = &self.config;
        let color_format = map_gl_internal_format(config.color_format)
            .ok_or_else(|| TestError::Fail("unknown colour format".to_string()))?;
        let width = 128;
        let height = 128;
        let colorbuffer = 1u32;

        // Check for format support.
        check_color_format_support(ctx, config.color_format)?;

        // Single colorbuffer
        if config.color_type == glw::GL_TEXTURE_2D {
            ctx.bind_texture(glw::GL_TEXTURE_2D, colorbuffer);
            tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, config.color_format, width, height)?;
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        } else {
            debug_assert_eq!(config.color_type, glw::GL_RENDERBUFFER);
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, colorbuffer);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, config.color_format, width, height);
        }

        // Multiple framebuffers sharing the colorbuffer
        for fbo in 1..=3u32 {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);

            if config.color_type == glw::GL_TEXTURE_2D {
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

        if config.color_type == glw::GL_TEXTURE_2D {
            let shader = Texture2DShader::with_samplers(
                &[get_sampler_2d_type(color_format)],
                DataType::FloatVec4,
                [1.0; 4],
                [0.0; 4],
            );
            let uniforms = shader.uniforms();
            let shader_id = ctx.create_program(Box::new(shader));

            uniforms.set_uniforms(ctx, shader_id);

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            quad(ctx, shader_id, [-0.9, -0.9, 0.0], [0.9, 0.9, 0.0]);
            read_screen(ctx, dst);
            Ok(())
        } else {
            read_fbo_result(ctx, dst, width, height, color_format, [1.0; 4], [0.0; 4])
        }
    }

    /// `SharedDepthStencilTest::render`
    fn render_shared_depth_stencil(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));
        let width = 128;
        let height = 128;
        let stencil = self.config.buffers & glw::GL_STENCIL_BUFFER_BIT != 0;

        // Textures
        let metaballs_tex = 5u32;
        let quads_tex = 6u32;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        ctx.viewport(0, 0, width, height);

        // Fbo A
        let fbo_a = Framebuffer::new(ctx, self.config, width, height)?;
        fbo_a.check_completeness(ctx)?;

        // Fbo B
        let mut cfg = self.config;
        cfg.buffers &= !(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        cfg.depth_stencil_type = glw::GL_NONE;
        cfg.depth_stencil_format = glw::GL_NONE;
        let fbo_b = Framebuffer::new(ctx, cfg, width, height)?;

        // Bind depth/stencil buffers from fbo A to fbo B
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        for ndx in 0..2 {
            let bit = if ndx == 1 {
                glw::GL_STENCIL_BUFFER_BIT
            } else {
                glw::GL_DEPTH_BUFFER_BIT
            };
            let point = if ndx == 1 {
                glw::GL_STENCIL_ATTACHMENT
            } else {
                glw::GL_DEPTH_ATTACHMENT
            };

            if self.config.buffers & bit == 0 {
                continue;
            }

            match self.config.depth_stencil_type {
                glw::GL_TEXTURE_2D => ctx.framebuffer_texture2d(
                    glw::GL_FRAMEBUFFER,
                    point,
                    glw::GL_TEXTURE_2D,
                    fbo_a.depth_stencil_buffer,
                    0,
                ),
                glw::GL_RENDERBUFFER => ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    point,
                    glw::GL_RENDERBUFFER,
                    fbo_a.depth_stencil_buffer,
                ),
                _ => return Err(TestError::Fail("Not implemented".to_string())),
            }
        }

        // Setup uniforms
        tex_uniforms.set_uniforms(ctx, tex_shader_id);

        // Clear color to red and stencil to 1 in fbo B.
        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear_stencil(1);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        ctx.enable(glw::GL_DEPTH_TEST);

        // Render quad to fbo A
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_a.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        if stencil {
            // Clear subset of stencil buffer to 0 in fbo A
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.scissor(10, 10, 12, 25);
            ctx.clear_stencil(0);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);
        }

        // Render metaballs to fbo B
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_b.framebuffer);
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_shader_id, [-1.0, -1.0, -1.0], [1.0, 1.0, 1.0]);

        ctx.disable(glw::GL_DEPTH_TEST);

        if stencil {
            // Render quad with stencil mask == 0
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 0, 0xff);
            ctx.use_program(flat_shader_id);
            set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);
            quad(ctx, flat_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        if self.config.color_type == glw::GL_TEXTURE_2D {
            // Render both to screen
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_a.color_buffer);
            quad(ctx, tex_shader_id, [-1.0, -1.0, 0.0], [0.0, 1.0, 0.0]);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo_b.color_buffer);
            quad(ctx, tex_shader_id, [0.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

            read_screen(ctx, dst);
            Ok(())
        } else {
            // Read results from fbo B
            let format = map_gl_internal_format(self.config.color_format)
                .ok_or_else(|| TestError::Fail("unknown colour format".to_string()))?;
            read_fbo_result(ctx, dst, width, height, format, [1.0; 4], [0.0; 4])
        }
    }

    /// `ResizeTest::render`
    fn render_resize(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let range = FboRange::new(&self.config)?;
        let (tex_to_fbo_id, tex_to_fbo_u, tex_from_fbo_id, tex_from_fbo_u) = make_range_shaders(ctx, &range);
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(range.output_type)));

        let quads_tex = 1u32;
        let metaballs_tex = 2u32;
        let depth = self.config.buffers & glw::GL_DEPTH_BUFFER_BIT != 0;
        let stencil = self.config.buffers & glw::GL_STENCIL_BUFFER_BIT != 0;
        let initial_width = 128;
        let initial_height = 128;
        let new_width = 64;
        let new_height = 32;

        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 32, 32)?;

        let fbo = Framebuffer::new(ctx, self.config, initial_width, initial_height)?;
        fbo.check_completeness(ctx)?;

        // Setup shaders
        tex_to_fbo_u.set_uniforms(ctx, tex_to_fbo_id);
        tex_from_fbo_u.set_uniforms(ctx, tex_from_fbo_id);
        set_flat_color(ctx, flat_shader_id, range.scale_bias([0.0, 1.0, 0.0, 1.0]));

        // Render quads
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, initial_width, initial_height);
        clear_color_buffer(ctx, range.color_format, [0.0, 0.0, 0.0, 1.0]);
        ctx.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        quad(ctx, tex_to_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        if fbo.config.color_type == glw::GL_TEXTURE_2D {
            // Render fbo to screen
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.color_buffer);
            quad(ctx, tex_from_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

            // Restore binding
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        }

        // Resize buffers
        match fbo.config.color_type {
            glw::GL_TEXTURE_2D => {
                ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.color_buffer);
                tex_image_2d_storage(
                    ctx,
                    glw::GL_TEXTURE_2D,
                    0,
                    fbo.config.color_format,
                    new_width,
                    new_height,
                )?;
            }
            glw::GL_RENDERBUFFER => {
                ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, fbo.color_buffer);
                ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, fbo.config.color_format, new_width, new_height);
            }
            _ => return Err(TestError::Fail("Unsupported colour type".to_string())),
        }

        if depth || stencil {
            match fbo.config.depth_stencil_type {
                glw::GL_TEXTURE_2D => {
                    ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.depth_stencil_buffer);
                    tex_image_2d_storage(
                        ctx,
                        glw::GL_TEXTURE_2D,
                        0,
                        fbo.config.depth_stencil_format,
                        new_width,
                        new_height,
                    )?;
                }
                glw::GL_RENDERBUFFER => {
                    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, fbo.depth_stencil_buffer);
                    ctx.renderbuffer_storage(
                        glw::GL_RENDERBUFFER,
                        fbo.config.depth_stencil_format,
                        new_width,
                        new_height,
                    );
                }
                _ => return Err(TestError::Fail("Unsupported depth/stencil type".to_string())),
            }
        }

        // Render to resized fbo
        ctx.viewport(0, 0, new_width, new_height);
        clear_color_buffer(ctx, range.color_format, [1.0, 0.0, 0.0, 1.0]);
        ctx.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        ctx.enable(glw::GL_DEPTH_TEST);

        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_to_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        quad(ctx, tex_to_fbo_id, [0.0, 0.0, -1.0], [1.0, 1.0, 1.0]);

        ctx.disable(glw::GL_DEPTH_TEST);

        if stencil {
            ctx.enable(glw::GL_SCISSOR_TEST);
            ctx.clear_stencil(1);
            ctx.scissor(10, 10, 5, 15);
            ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);

            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
            quad(ctx, flat_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        if self.config.color_type == glw::GL_TEXTURE_2D {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.color_buffer);
            quad(ctx, tex_from_fbo_id, [-0.5, -0.5, 0.0], [0.5, 0.5, 0.0]);
            read_screen(ctx, dst);
            Ok(())
        } else {
            read_fbo_result(
                ctx,
                dst,
                new_width,
                new_height,
                range.color_format,
                range.lookup_scale,
                range.lookup_bias,
            )
        }
    }

    /// `RecreateBuffersTest::render`
    fn render_recreate_buffers(
        &self,
        ctx: &mut dyn SglrContext,
        dst: &mut Surface,
        m_buffers: u32,
        rebind: bool,
    ) -> Result<(), TestError> {
        let range = FboRange::new(&self.config)?;
        let (tex_to_fbo_id, tex_to_fbo_u, tex_from_fbo_id, tex_from_fbo_u) = make_range_shaders(ctx, &range);
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(range.output_type)));

        let width = 128;
        let height = 128;
        let metaballs_tex = 1u32;
        let quads_tex = 2u32;
        let stencil = self.config.buffers & glw::GL_STENCIL_BUFFER_BIT != 0;

        create_quads_tex2d(ctx, quads_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;
        create_metaballs_tex2d(ctx, metaballs_tex, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, 64, 64)?;

        let fbo = Framebuffer::new(ctx, self.config, width, height)?;
        fbo.check_completeness(ctx)?;

        // Setup shaders
        tex_to_fbo_u.set_uniforms(ctx, tex_to_fbo_id);
        tex_from_fbo_u.set_uniforms(ctx, tex_from_fbo_id);
        set_flat_color(ctx, flat_shader_id, range.scale_bias([0.0, 0.0, 1.0, 1.0]));

        // Draw scene
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        ctx.viewport(0, 0, width, height);
        clear_color_buffer(ctx, range.color_format, [1.0, 0.0, 0.0, 1.0]);
        ctx.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        ctx.enable(glw::GL_DEPTH_TEST);

        ctx.bind_texture(glw::GL_TEXTURE_2D, quads_tex);
        quad(ctx, tex_to_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

        ctx.disable(glw::GL_DEPTH_TEST);

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

        debug_assert!(
            (m_buffers & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT)) == 0
                || (m_buffers & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT))
                    == (self.config.buffers & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT))
        );

        // Recreate.
        for ndx in 0..2 {
            let bit = if ndx == 0 {
                glw::GL_COLOR_BUFFER_BIT
            } else {
                glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT
            };
            let type_ = if ndx == 0 {
                fbo.config.color_type
            } else {
                fbo.config.depth_stencil_type
            };
            let format = if ndx == 0 {
                fbo.config.color_format
            } else {
                fbo.config.depth_stencil_format
            };
            let buf = if ndx == 0 {
                fbo.color_buffer
            } else {
                fbo.depth_stencil_buffer
            };

            if m_buffers & bit == 0 {
                continue;
            }

            match type_ {
                glw::GL_TEXTURE_2D => {
                    ctx.delete_textures(&[buf]);
                    ctx.bind_texture(glw::GL_TEXTURE_2D, buf);
                    tex_image_2d_storage(ctx, glw::GL_TEXTURE_2D, 0, format, width, height)?;
                    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
                    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                }
                glw::GL_RENDERBUFFER => {
                    ctx.delete_renderbuffers(&[buf]);
                    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, buf);
                    ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, format, width, height);
                }
                _ => return Err(TestError::Fail("Unsupported type".to_string())),
            }
        }

        // Rebind.
        if rebind {
            for ndx in 0..3 {
                let bit = match ndx {
                    0 => glw::GL_COLOR_BUFFER_BIT,
                    1 => glw::GL_DEPTH_BUFFER_BIT,
                    _ => glw::GL_STENCIL_BUFFER_BIT,
                };
                let point = match ndx {
                    0 => glw::GL_COLOR_ATTACHMENT0,
                    1 => glw::GL_DEPTH_ATTACHMENT,
                    _ => glw::GL_STENCIL_ATTACHMENT,
                };
                let type_ = if ndx == 0 {
                    fbo.config.color_type
                } else {
                    fbo.config.depth_stencil_type
                };
                let buf = if ndx == 0 {
                    fbo.color_buffer
                } else {
                    fbo.depth_stencil_buffer
                };

                if m_buffers & bit == 0 {
                    continue;
                }

                match type_ {
                    glw::GL_TEXTURE_2D => {
                        ctx.framebuffer_texture2d(glw::GL_FRAMEBUFFER, point, glw::GL_TEXTURE_2D, buf, 0)
                    }
                    glw::GL_RENDERBUFFER => {
                        ctx.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, point, glw::GL_RENDERBUFFER, buf)
                    }
                    _ => return Err(TestError::Fail("Unsupported type".to_string())),
                }
            }
        }

        if !rebind {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.framebuffer);
        }

        ctx.clear_stencil(0);
        // Clear only buffers that were re-created
        ctx.clear(m_buffers & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
        if m_buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
            // Clearing of integer buffers is undefined so do clearing by rendering flat color.
            quad(ctx, flat_shader_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);
        }

        ctx.enable(glw::GL_DEPTH_TEST);

        if stencil {
            // Stencil test enabled only if we have stencil buffer
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_EQUAL, 0, 0xff);
        }
        ctx.bind_texture(glw::GL_TEXTURE_2D, metaballs_tex);
        quad(ctx, tex_to_fbo_id, [-1.0, -1.0, 1.0], [1.0, 1.0, -1.0]);
        if stencil {
            ctx.disable(glw::GL_STENCIL_TEST);
        }

        ctx.disable(glw::GL_DEPTH_TEST);

        if fbo.config.color_type == glw::GL_TEXTURE_2D {
            // Unbind fbo
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

            // Draw to screen
            ctx.bind_texture(glw::GL_TEXTURE_2D, fbo.color_buffer);
            let (w, h) = (ctx.get_width(), ctx.get_height());
            ctx.viewport(0, 0, w, h);
            quad(ctx, tex_from_fbo_id, [-1.0, -1.0, 0.0], [1.0, 1.0, 0.0]);

            // Read from screen
            read_screen(ctx, dst);
            Ok(())
        } else {
            // Read from fbo
            read_fbo_result(
                ctx,
                dst,
                width,
                height,
                range.color_format,
                range.lookup_scale,
                range.lookup_bias,
            )
        }
    }
}

impl TestCase for FboRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let clear_color = [0.125f32, 0.25, 0.5, 1.0];
        let rt = context.render_target();
        let all_buffers = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;

        // Position & size for context
        let mut rnd = Random::new(de_string_hash(&self.name));
        let width = rt.width.min(128);
        let height = rt.height.min(128);
        let x_max = rt.width - width + 1;
        let y_max = rt.height - height + 1;
        let x = (rnd.get_uint32() % x_max as u32) as i32;
        let y = (rnd.get_uint32() % y_max as u32) as i32;

        let mut gles3_frame = Surface::new(width, height);
        let mut ref_frame = Surface::new(width, height);

        // Render using GLES3
        let gles3_error = {
            let mut gl_ctx = GLContext::new(&context.render_context, (x, y, width, height));
            gl_ctx.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
            gl_ctx.clear(all_buffers);
            self.render(&mut gl_ctx, &mut gles3_frame)?; // Call actual render func
            gl_ctx.get_error()
        };

        // Render reference image
        let ref_error = {
            let mut ref_ctx = create_reference_context_rgb8(context, width, height, rt.depth_bits)?;
            ref_ctx.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
            ref_ctx.clear(all_buffers);
            self.render(&mut ref_ctx, &mut ref_frame)?;
            ref_ctx.get_error()
        };

        // Compare error codes
        let mut fail_reason: Option<&str> = None;
        let error_codes_ok = gles3_error == ref_error;
        if !error_codes_ok {
            fail_reason = Some("Got unexpected error");
        }

        // Compare images
        let format_threshold = get_format_threshold_gl(self.config.color_format)?;
        let threshold = [
            format_threshold[0].max(12),
            format_threshold[1].max(12),
            format_threshold[2].max(12),
            format_threshold[3].max(12),
        ];
        let images_ok = ref_frame.get_const_access().size() == gles3_frame.get_const_access().size()
            && bilinear_compare(
                &ref_frame.get_const_access(),
                &gles3_frame.get_const_access(),
                None,
                threshold,
            );
        if !images_ok && fail_reason.is_none() {
            fail_reason = Some("Image comparison failed");
        }

        if error_codes_ok && images_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(fail_reason.unwrap_or("Image comparison failed")))
        }
    }
}

/// `FormatType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum FormatType {
    Float,
    Fixed,
    Int,
    Uint,
}

/// `FboRenderTestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    use FormatType::*;

    let object_types: [GLenum; 2] = [glw::GL_TEXTURE_2D, glw::GL_RENDERBUFFER];

    // Required by specification.
    let color_formats: [(GLenum, FormatType); 36] = [
        (glw::GL_RGBA32F, Float),
        (glw::GL_RGBA32I, Int),
        (glw::GL_RGBA32UI, Uint),
        (glw::GL_RGBA16F, Float),
        (glw::GL_RGBA16I, Int),
        (glw::GL_RGBA16UI, Uint),
        (glw::GL_RGB16F, Float),
        (glw::GL_RGBA8, Fixed),
        (glw::GL_RGBA8I, Int),
        (glw::GL_RGBA8UI, Uint),
        (glw::GL_SRGB8_ALPHA8, Fixed),
        (glw::GL_RGB10_A2, Fixed),
        (glw::GL_RGB10_A2UI, Uint),
        (glw::GL_RGBA4, Fixed),
        (glw::GL_RGB5_A1, Fixed),
        (glw::GL_RGB8, Fixed),
        (glw::GL_RGB565, Fixed),
        (glw::GL_R11F_G11F_B10F, Float),
        (glw::GL_RG32F, Float),
        (glw::GL_RG32I, Int),
        (glw::GL_RG32UI, Uint),
        (glw::GL_RG16F, Float),
        (glw::GL_RG16I, Int),
        (glw::GL_RG16UI, Uint),
        (glw::GL_RG8, Float),
        (glw::GL_RG8I, Int),
        (glw::GL_RG8UI, Uint),
        (glw::GL_R32F, Float),
        (glw::GL_R32I, Int),
        (glw::GL_R32UI, Uint),
        (glw::GL_R16F, Float),
        (glw::GL_R16I, Int),
        (glw::GL_R16UI, Uint),
        (glw::GL_R8, Float),
        (glw::GL_R8I, Int),
        (glw::GL_R8UI, Uint),
    ];

    // (format, depth, stencil)
    let depth_stencil_formats: [(GLenum, bool, bool); 6] = [
        (glw::GL_DEPTH_COMPONENT32F, true, false),
        (glw::GL_DEPTH_COMPONENT24, true, false),
        (glw::GL_DEPTH_COMPONENT16, true, false),
        (glw::GL_DEPTH32F_STENCIL8, true, true),
        (glw::GL_DEPTH24_STENCIL8, true, true),
        (glw::GL_STENCIL_INDEX8, false, true),
    ];

    let mut group = TestCaseGroup::new("render");

    // .stencil_clear
    {
        let mut stencil_clear_group = TestCaseGroup::new("stencil_clear");
        for (format, _depth, stencil) in depth_stencil_formats {
            let color_type = glw::GL_TEXTURE_2D;
            let stencil_type = glw::GL_RENDERBUFFER;
            let color_fmt = glw::GL_RGBA8;

            if !stencil {
                continue;
            }

            let config = FboConfig::new(
                glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                color_type,
                color_fmt,
                stencil_type,
                format,
            );
            stencil_clear_group.add_child(FboRenderCase::new(Kind::StencilClears, config));
        }
        group.add_child(stencil_clear_group);
    }

    // .shared_colorbuffer_clear
    {
        let mut shared_colorbuffer_clear_group = TestCaseGroup::new("shared_colorbuffer_clear");
        for (format, type_) in color_formats {
            // Clearing of integer buffers is undefined.
            if type_ == Int || type_ == Uint {
                continue;
            }

            for object_type in object_types {
                let config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT,
                    object_type,
                    format,
                    glw::GL_NONE,
                    glw::GL_NONE,
                );
                shared_colorbuffer_clear_group.add_child(FboRenderCase::new(Kind::SharedColorbufferClears, config));
            }
        }
        group.add_child(shared_colorbuffer_clear_group);
    }

    // .shared_colorbuffer
    {
        let mut shared_colorbuffer_group = TestCaseGroup::new("shared_colorbuffer");
        for (format, type_) in color_formats {
            let depth_stencil_type = glw::GL_RENDERBUFFER;
            let depth_stencil_format = glw::GL_DEPTH24_STENCIL8;

            // Blending with integer buffers and fp32 targets is not supported.
            if type_ == Int
                || type_ == Uint
                || format == glw::GL_RGBA32F
                || format == glw::GL_RGB32F
                || format == glw::GL_RG32F
                || format == glw::GL_R32F
            {
                continue;
            }

            for object_type in object_types {
                let color_only_config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT,
                    object_type,
                    format,
                    glw::GL_NONE,
                    glw::GL_NONE,
                );
                let color_depth_config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT,
                    object_type,
                    format,
                    depth_stencil_type,
                    depth_stencil_format,
                );
                let color_depth_stencil_config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                    object_type,
                    format,
                    depth_stencil_type,
                    depth_stencil_format,
                );

                shared_colorbuffer_group.add_child(FboRenderCase::new(Kind::SharedColorbuffer, color_only_config));
                shared_colorbuffer_group.add_child(FboRenderCase::new(Kind::SharedColorbuffer, color_depth_config));
                shared_colorbuffer_group
                    .add_child(FboRenderCase::new(Kind::SharedColorbuffer, color_depth_stencil_config));
            }
        }
        group.add_child(shared_colorbuffer_group);
    }

    // .shared_depth_stencil
    {
        let mut shared_depth_stencil_group = TestCaseGroup::new("shared_depth_stencil");
        for (format, depth, stencil) in depth_stencil_formats {
            let color_type = glw::GL_TEXTURE_2D;
            let color_fmt = glw::GL_RGBA8;

            if !depth {
                continue; // Not verified.
            }

            // Depth and stencil: both rbo and textures
            for object_type in object_types {
                let config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT
                        | if depth { glw::GL_DEPTH_BUFFER_BIT } else { 0 }
                        | if stencil { glw::GL_STENCIL_BUFFER_BIT } else { 0 },
                    color_type,
                    color_fmt,
                    object_type,
                    format,
                );
                shared_depth_stencil_group.add_child(FboRenderCase::new(Kind::SharedDepthStencil, config));
            }
        }
        group.add_child(shared_depth_stencil_group);
    }

    // .resize
    {
        let mut resize_group = TestCaseGroup::new("resize");
        for (color_format, _type) in color_formats {
            // Color-only.
            for object_type in object_types {
                let config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT,
                    object_type,
                    color_format,
                    glw::GL_NONE,
                    glw::GL_NONE,
                );
                resize_group.add_child(FboRenderCase::new(Kind::Resize, config));
            }

            // For selected color formats tests depth & stencil variants.
            if color_format == glw::GL_RGBA8 || color_format == glw::GL_RGBA16F {
                for (ds_format, depth, stencil) in depth_stencil_formats {
                    let color_type = glw::GL_TEXTURE_2D;

                    // Depth and stencil: both rbo and textures
                    for object_type in object_types {
                        if !depth && object_type != glw::GL_RENDERBUFFER {
                            continue; // Not supported.
                        }

                        let config = FboConfig::new(
                            glw::GL_COLOR_BUFFER_BIT
                                | if depth { glw::GL_DEPTH_BUFFER_BIT } else { 0 }
                                | if stencil { glw::GL_STENCIL_BUFFER_BIT } else { 0 },
                            color_type,
                            color_format,
                            object_type,
                            ds_format,
                        );
                        resize_group.add_child(FboRenderCase::new(Kind::Resize, config));
                    }
                }
            }
        }
        group.add_child(resize_group);
    }

    // .recreate_color
    {
        let mut recreate_color_group = TestCaseGroup::new("recreate_color");
        for (color_format, _type) in color_formats {
            let depth_stencil_format = glw::GL_DEPTH24_STENCIL8;
            let depth_stencil_type = glw::GL_RENDERBUFFER;

            // Color-only.
            for object_type in object_types {
                let config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                    object_type,
                    color_format,
                    depth_stencil_type,
                    depth_stencil_format,
                );
                recreate_color_group.add_child(FboRenderCase::new(
                    Kind::RecreateBuffers {
                        buffers: glw::GL_COLOR_BUFFER_BIT,
                        rebind: true,
                    },
                    config,
                ));
            }
        }
        group.add_child(recreate_color_group);
    }

    // .recreate_depth_stencil
    {
        let mut recreate_depth_stencil_group = TestCaseGroup::new("recreate_depth_stencil");
        for (format, depth, stencil) in depth_stencil_formats {
            let color_type = glw::GL_TEXTURE_2D;
            let color_fmt = glw::GL_RGBA8;

            // Depth and stencil: both rbo and textures
            for object_type in object_types {
                if !depth && object_type != glw::GL_RENDERBUFFER {
                    continue;
                }

                let ds_bits = (if depth { glw::GL_DEPTH_BUFFER_BIT } else { 0 })
                    | (if stencil { glw::GL_STENCIL_BUFFER_BIT } else { 0 });
                let config = FboConfig::new(
                    glw::GL_COLOR_BUFFER_BIT | ds_bits,
                    color_type,
                    color_fmt,
                    object_type,
                    format,
                );
                recreate_depth_stencil_group.add_child(FboRenderCase::new(
                    Kind::RecreateBuffers {
                        buffers: ds_bits,
                        rebind: true,
                    },
                    config,
                ));
            }
        }
        group.add_child(recreate_depth_stencil_group);
    }

    group
}
