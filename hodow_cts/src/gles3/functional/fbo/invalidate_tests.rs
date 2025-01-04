// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboInvalidateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.fbo.invalidate`: the cases that render after invalidating, i.e. `default.*`,
// `whole.render_*`, `sub.render_*` and the depth/stencil half of `format.*`.
//
// The multisampled `unbind_blit_msaa_*` cases run, but the reference context stores a multisample renderbuffer single
// sample (see `fbo::multisample_tests`), so only the fuzzy compare stands between that and the antialiased GL frame.
// `InvalidateFboUnbindBlitCase`/`InvalidateSubFboUnbindBlitCase` derive their formats from the render target in
// the constructor upstream; here `pre_check` (which gets the `glu::Context`) stores them for `render`.

use std::sync::atomic::{AtomicU32, Ordering};

use super::fbo_test_case::{FboRender, FboTestCase, check_format_support, check_framebuffer_status};
use super::fbo_test_util::{
    FlatColorShader, GradientShader, Texture2DShader, clear_color_buffer, get_format_name, get_format_threshold_gl,
    get_fragment_output_type, get_sampler_2d_type, read_pixels, set_flat_color, set_gradient,
};
use crate::glu::TestCaseGroup;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel::get_texture_format_info;
use crate::tcu::vector::Vec3;
use crate::tcu::{Surface, TestError, TextureFormat};

/// `getDefaultFBDiscardAttachments`
fn get_default_fb_discard_attachments(discard_buffer_bits: u32) -> Vec<GLenum> {
    let mut attachments = Vec::new();

    if discard_buffer_bits & glw::GL_COLOR_BUFFER_BIT != 0 {
        attachments.push(glw::GL_COLOR);
    }
    if discard_buffer_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
        attachments.push(glw::GL_DEPTH);
    }
    if discard_buffer_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
        attachments.push(glw::GL_STENCIL);
    }

    attachments
}

/// `getFBODiscardAttachments`
fn get_fbo_discard_attachments(discard_buffer_bits: u32) -> Vec<GLenum> {
    let mut attachments = Vec::new();

    if discard_buffer_bits & glw::GL_COLOR_BUFFER_BIT != 0 {
        attachments.push(glw::GL_COLOR_ATTACHMENT0);
    }

    // DEPTH_STENCIL_ATTACHMENT is allowed when discarding FBO, but not with default FB
    let ds = glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
    if discard_buffer_bits & ds == ds {
        attachments.push(glw::GL_DEPTH_STENCIL_ATTACHMENT);
    } else if discard_buffer_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
        attachments.push(glw::GL_DEPTH_ATTACHMENT);
    } else if discard_buffer_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
        attachments.push(glw::GL_STENCIL_ATTACHMENT);
    }

    attachments
}

fn full_quad(ctx: &mut dyn SglrContext, program: u32, z0: f32, z1: f32) {
    draw_quad(ctx, program, Vec3::new(-1.0, -1.0, z0), Vec3::new(1.0, 1.0, z1));
}

fn map_format(format: GLenum) -> Result<TextureFormat, TestError> {
    map_gl_internal_format(format).ok_or_else(|| TestError::Fail(format!("unknown internal format {format:#x}")))
}

fn scale_bias(c: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> [f32; 4] {
    [
        c[0] * scale[0] + bias[0],
        c[1] * scale[1] + bias[1],
        c[2] * scale[2] + bias[2],
        c[3] * scale[3] + bias[3],
    ]
}

/// The common tail of the render cases: additive blue quad, with the depth/stencil state each case left behind.
fn blend_blue_quad(ctx: &mut dyn SglrContext, flat_shader_id: u32, color: [f32; 4]) {
    ctx.enable(glw::GL_BLEND);
    ctx.blend_func(glw::GL_ONE, glw::GL_ONE);
    ctx.blend_equation(glw::GL_FUNC_ADD);

    set_flat_color(ctx, flat_shader_id, color);
    full_quad(ctx, flat_shader_id, 0.0, 0.0);
}

/// The scene every case starts from: a red quad over the whole depth range that increments nothing but
/// replaces stencil with 1 (`glStencilOp(KEEP, KEEP, REPLACE)`, `glStencilFunc(ALWAYS, 1, 0xff)`).
fn draw_initial_quad(ctx: &mut dyn SglrContext, flat_shader_id: u32, color: [f32; 4]) {
    ctx.enable(glw::GL_DEPTH_TEST);
    ctx.enable(glw::GL_STENCIL_TEST);
    ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
    ctx.stencil_func(glw::GL_ALWAYS, 1, 0xff);

    set_flat_color(ctx, flat_shader_id, color);
    full_quad(ctx, flat_shader_id, -1.0, 1.0);
}

/// `InvalidateDefaultFramebufferRenderCase`
struct InvalidateDefaultFramebufferRenderCase {
    buffers: u32,
    fbo_target: GLenum,
}

impl FboRender for InvalidateDefaultFramebufferRenderCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let attachments = get_default_fb_discard_attachments(self.buffers);
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        draw_initial_quad(ctx, flat_shader_id, [1.0, 0.0, 0.0, 1.0]);

        ctx.invalidate_framebuffer(self.fbo_target, &attachments);

        if self.buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
            // Color was not preserved - fill with green.
            ctx.disable(glw::GL_DEPTH_TEST);
            ctx.disable(glw::GL_STENCIL_TEST);

            set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);
            full_quad(ctx, flat_shader_id, 0.0, 0.0);

            ctx.enable(glw::GL_DEPTH_TEST);
            ctx.enable(glw::GL_STENCIL_TEST);
        }

        if self.buffers & glw::GL_DEPTH_BUFFER_BIT != 0 {
            // Depth was not preserved.
            ctx.depth_func(glw::GL_ALWAYS);
        }

        if self.buffers & glw::GL_STENCIL_BUFFER_BIT == 0 {
            // Stencil was preserved.
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
        }

        blend_blue_quad(ctx, flat_shader_id, [0.0, 0.0, 1.0, 1.0]);

        let (w, h) = (ctx.get_width(), ctx.get_height());
        dst.set_size(w, h);
        ctx.read_pixels(dst, 0, 0, w, h);
        Ok(())
    }
}

/// Creates the `GL_RGBA8` texture-backed FBO the two `*BindCase`s switch to; leaves the default framebuffer bound.
fn create_bind_fbo(ctx: &mut dyn SglrContext) -> Result<(u32, u32), TestError> {
    let (w, h) = (ctx.get_width(), ctx.get_height());
    let mut names = [0u32];
    ctx.gen_framebuffers(&mut names);
    let fbo = names[0];
    ctx.gen_textures(&mut names);
    let tex = names[0];

    ctx.bind_texture(glw::GL_TEXTURE_2D, tex);
    ctx.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RGBA8,
        w,
        h,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        None,
    );
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);

    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
    ctx.framebuffer_texture2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_TEXTURE_2D,
        tex,
        0,
    );
    ctx.bind_texture(glw::GL_TEXTURE_2D, 0);
    check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    Ok((fbo, tex))
}

/// `InvalidateDefaultFramebufferBindCase`
struct InvalidateDefaultFramebufferBindCase {
    buffers: u32,
}

impl FboRender for InvalidateDefaultFramebufferBindCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let attachments = get_default_fb_discard_attachments(self.buffers);
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));
        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        // Create fbo.
        let (fbo, tex) = create_bind_fbo(ctx)?;

        draw_initial_quad(ctx, flat_shader_id, [1.0, 0.0, 0.0, 1.0]);

        ctx.invalidate_framebuffer(glw::GL_FRAMEBUFFER, &attachments);

        // Switch to fbo and render gradient into it.
        ctx.disable(glw::GL_DEPTH_TEST);
        ctx.disable(glw::GL_STENCIL_TEST);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);
        full_quad(ctx, grad_shader_id, 0.0, 0.0);

        // Restore default fbo.
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

        if self.buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
            // Color was not preserved - fill with green.
            set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);
            full_quad(ctx, flat_shader_id, 0.0, 0.0);
        }

        if self.buffers & glw::GL_DEPTH_BUFFER_BIT != 0 {
            // Depth was not preserved.
            ctx.depth_func(glw::GL_ALWAYS);
        }

        if self.buffers & glw::GL_STENCIL_BUFFER_BIT == 0 {
            // Stencil was preserved.
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
        }

        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);

        ctx.enable(glw::GL_BLEND);
        ctx.blend_func(glw::GL_ONE, glw::GL_ONE);
        ctx.blend_equation(glw::GL_FUNC_ADD);

        ctx.bind_texture(glw::GL_TEXTURE_2D, tex);
        tex_uniforms.set_uniforms(ctx, tex_shader_id);
        full_quad(ctx, tex_shader_id, 0.0, 0.0);

        let (w, h) = (ctx.get_width(), ctx.get_height());
        dst.set_size(w, h);
        ctx.read_pixels(dst, 0, 0, w, h);
        Ok(())
    }
}

/// The scissored clear of the invalidated rectangle both `InvalidateDefaultSubFramebuffer*Case`s do.
fn clear_invalidated_default(ctx: &mut dyn SglrContext, buffers: u32, rect: (i32, i32, i32, i32)) {
    ctx.clear_color(0.0, 1.0, 0.0, 1.0);
    ctx.clear_stencil(1);
    ctx.scissor(rect.0, rect.1, rect.2, rect.3);
    ctx.enable(glw::GL_SCISSOR_TEST);
    ctx.clear(buffers);
    ctx.disable(glw::GL_SCISSOR_TEST);
}

/// `InvalidateDefaultSubFramebufferRenderCase`
struct InvalidateDefaultSubFramebufferRenderCase {
    buffers: u32,
}

impl FboRender for InvalidateDefaultSubFramebufferRenderCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let (w, h) = (ctx.get_width(), ctx.get_height());
        let rect = (w / 4, h / 4, w / 2, h / 2);
        let attachments = get_default_fb_discard_attachments(self.buffers);
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        draw_initial_quad(ctx, flat_shader_id, [1.0, 0.0, 0.0, 1.0]);

        ctx.invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, &attachments, rect.0, rect.1, rect.2, rect.3);

        // Clear invalidated buffers.
        clear_invalidated_default(ctx, self.buffers, rect);

        blend_blue_quad(ctx, flat_shader_id, [0.0, 0.0, 1.0, 1.0]);

        dst.set_size(w, h);
        ctx.read_pixels(dst, 0, 0, w, h);
        Ok(())
    }
}

/// `InvalidateDefaultSubFramebufferBindCase`
struct InvalidateDefaultSubFramebufferBindCase {
    buffers: u32,
}

impl FboRender for InvalidateDefaultSubFramebufferBindCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let (w, h) = (ctx.get_width(), ctx.get_height());
        let rect = (w / 4, h / 4, w / 2, h / 2);
        let attachments = get_default_fb_discard_attachments(self.buffers);
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));
        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));

        set_flat_color(ctx, flat_shader_id, [1.0, 0.0, 0.0, 1.0]);
        tex_uniforms.set_uniforms(ctx, tex_shader_id);
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        // Create fbo.
        let (fbo, tex) = create_bind_fbo(ctx)?;

        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
        ctx.stencil_func(glw::GL_ALWAYS, 1, 0xff);

        full_quad(ctx, flat_shader_id, -1.0, 1.0);

        ctx.invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, &attachments, rect.0, rect.1, rect.2, rect.3);

        // Switch to fbo and render gradient into it.
        ctx.disable(glw::GL_DEPTH_TEST);
        ctx.disable(glw::GL_STENCIL_TEST);

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        full_quad(ctx, grad_shader_id, 0.0, 0.0);

        // Restore default fbo.
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

        // Clear invalidated buffers.
        clear_invalidated_default(ctx, self.buffers, rect);

        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);

        ctx.enable(glw::GL_BLEND);
        ctx.blend_func(glw::GL_ONE, glw::GL_ONE);
        ctx.blend_equation(glw::GL_FUNC_ADD);

        ctx.bind_texture(glw::GL_TEXTURE_2D, tex);
        full_quad(ctx, tex_shader_id, 0.0, 0.0);

        dst.set_size(w, h);
        ctx.read_pixels(dst, 0, 0, w, h);
        Ok(())
    }
}

/// `InvalidateFboRenderCase` (`sub == false`) and `InvalidateSubFboRenderCase` (`sub == true`).
struct InvalidateFboRenderCase {
    color_fmt: GLenum,
    depth_stencil_fmt: GLenum,
    invalidate_buffers: u32,
    sub: bool,
}

impl FboRender for InvalidateFboRenderCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        if self.color_fmt != glw::GL_NONE {
            check_format_support(context, self.color_fmt)?;
        }
        if self.depth_stencil_fmt != glw::GL_NONE {
            check_format_support(context, self.depth_stencil_fmt)?;
        }
        Ok(())
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_fmt = map_format(self.color_fmt)?;
        let depth_stencil_fmt = if self.depth_stencil_fmt != glw::GL_NONE {
            Some(map_format(self.depth_stencil_fmt)?)
        } else {
            None
        };
        let color_fmt_info = get_texture_format_info(color_fmt);
        let depth = depth_stencil_fmt.is_some_and(|f| f.order.has_depth());
        let stencil = depth_stencil_fmt.is_some_and(|f| f.order.has_stencil());
        let c_bias = color_fmt_info.value_min;
        let mut c_scale = [0.0f32; 4];
        for i in 0..4 {
            c_scale[i] = color_fmt_info.value_max[i] - color_fmt_info.value_min[i];
        }
        let (w, h) = (ctx.get_width(), ctx.get_height());
        let rect = (w / 4, h / 4, w / 2, h / 2);

        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));
        let attachments = get_fbo_discard_attachments(self.invalidate_buffers);

        // Create fbo.
        let mut names = [0u32];
        ctx.gen_renderbuffers(&mut names);
        let color_rbo = names[0];
        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.color_fmt, w, h);

        let mut depth_stencil_rbo = 0;
        if self.depth_stencil_fmt != glw::GL_NONE {
            ctx.gen_renderbuffers(&mut names);
            depth_stencil_rbo = names[0];
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil_rbo);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.depth_stencil_fmt, w, h);
        }

        ctx.gen_framebuffers(&mut names);
        let fbo = names[0];
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_rbo,
        );
        if depth {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }
        if stencil {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        if self.sub {
            ctx.clear_buffer_fv(glw::GL_COLOR, 0, &scale_bias([0.0, 0.0, 0.0, 1.0], c_scale, c_bias));
            ctx.clear_buffer_fi(glw::GL_DEPTH_STENCIL, 0, 1.0, 0);
        } else {
            ctx.clear_color(0.0, 0.0, 0.0, 1.0);
            ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        }

        draw_initial_quad(ctx, flat_shader_id, scale_bias([1.0, 0.0, 0.0, 1.0], c_scale, c_bias));

        if self.sub {
            ctx.invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, &attachments, rect.0, rect.1, rect.2, rect.3);

            // Clear invalidated buffers.
            ctx.scissor(rect.0, rect.1, rect.2, rect.3);
            ctx.enable(glw::GL_SCISSOR_TEST);
            if self.invalidate_buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
                ctx.clear_buffer_fv(glw::GL_COLOR, 0, &scale_bias([0.0, 1.0, 0.0, 1.0], c_scale, c_bias));
            }
            ctx.clear(self.invalidate_buffers & !glw::GL_COLOR_BUFFER_BIT);
            ctx.disable(glw::GL_SCISSOR_TEST);
        } else {
            ctx.invalidate_framebuffer(glw::GL_FRAMEBUFFER, &attachments);

            if self.invalidate_buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
                // Color was not preserved - fill with green.
                ctx.disable(glw::GL_DEPTH_TEST);
                ctx.disable(glw::GL_STENCIL_TEST);

                set_flat_color(ctx, flat_shader_id, scale_bias([0.0, 1.0, 0.0, 1.0], c_scale, c_bias));
                full_quad(ctx, flat_shader_id, 0.0, 0.0);

                ctx.enable(glw::GL_DEPTH_TEST);
                ctx.enable(glw::GL_STENCIL_TEST);
            }

            if self.invalidate_buffers & glw::GL_DEPTH_BUFFER_BIT != 0 {
                // Depth was not preserved.
                ctx.depth_func(glw::GL_ALWAYS);
            }

            if self.invalidate_buffers & glw::GL_STENCIL_BUFFER_BIT == 0 {
                // Stencil was preserved.
                ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
            }
        }

        blend_blue_quad(ctx, flat_shader_id, scale_bias([0.0, 0.0, 1.0, 1.0], c_scale, c_bias));

        read_pixels(
            ctx,
            dst,
            0,
            0,
            w,
            h,
            color_fmt,
            color_fmt_info.look_up_scale,
            color_fmt_info.look_up_bias,
        )?;
        Ok(())
    }
}

/// Helper shared by the two `Unbind*Read` cases: colour (and optional
/// depth/stencil) textures attached to a fresh FBO, which is left bound.
fn create_tex_fbo(
    ctx: &mut dyn SglrContext,
    color_gl: GLenum,
    color_fmt: TextureFormat,
    ds_gl: GLenum,
    ds_fmt: Option<TextureFormat>,
    color_nearest: bool,
) -> Result<(u32, u32, u32), TestError> {
    let (w, h) = (ctx.get_width(), ctx.get_height());
    let mut names = [0u32];

    let transfer = get_transfer_format(color_fmt)?;
    ctx.gen_textures(&mut names);
    let color_tex = names[0];
    ctx.bind_texture(glw::GL_TEXTURE_2D, color_tex);
    ctx.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        color_gl,
        w,
        h,
        0,
        transfer.format,
        transfer.data_type,
        None,
    );
    if color_nearest {
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    } else {
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
    }

    let mut ds_tex = 0;
    if let Some(ds_fmt) = ds_fmt {
        let transfer = get_transfer_format(ds_fmt)?;
        ctx.gen_textures(&mut names);
        ds_tex = names[0];
        ctx.bind_texture(glw::GL_TEXTURE_2D, ds_tex);
        ctx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            ds_gl,
            w,
            h,
            0,
            transfer.format,
            transfer.data_type,
            None,
        );
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    }

    ctx.gen_framebuffers(&mut names);
    let fbo = names[0];
    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
    ctx.framebuffer_texture2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_TEXTURE_2D,
        color_tex,
        0,
    );
    if ds_fmt.is_some_and(|f| f.order.has_depth()) {
        ctx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_TEXTURE_2D,
            ds_tex,
            0,
        );
    }
    if ds_fmt.is_some_and(|f| f.order.has_stencil()) {
        ctx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_TEXTURE_2D,
            ds_tex,
            0,
        );
    }
    check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

    Ok((fbo, color_tex, ds_tex))
}

/// The "Render color." / "Render depth." tail of the `Unbind*Read` cases: a fullscreen quad sampling the
/// texture that was attached to the invalidated FBO.
fn draw_attachment_texture(ctx: &mut dyn SglrContext, fmt: TextureFormat, tex: u32, scale: [f32; 4], bias: [f32; 4]) {
    let mut tex_shader =
        Texture2DShader::with_samplers(&[get_sampler_2d_type(fmt)], DataType::FloatVec4, [1.0; 4], [0.0; 4]);
    tex_shader.set_tex_scale_bias(0, scale, bias);
    let tex_uniforms = tex_shader.uniforms();
    let tex_shader_id = ctx.create_program(Box::new(tex_shader));
    tex_uniforms.set_uniforms(ctx, tex_shader_id);

    ctx.bind_texture(glw::GL_TEXTURE_2D, tex);
    full_quad(ctx, tex_shader_id, 0.0, 0.0);
}

fn read_default_framebuffer(ctx: &mut dyn SglrContext, dst: &mut Surface, w: i32, h: i32) {
    dst.set_size(w, h);
    ctx.read_pixels(dst, 0, 0, w, h);
}

fn format_pre_check(context: &crate::glu::Context, color_fmt: GLenum, ds_fmt: GLenum) -> Result<(), TestError> {
    if color_fmt != glw::GL_NONE {
        check_format_support(context, color_fmt)?;
    }
    if ds_fmt != glw::GL_NONE {
        check_format_support(context, ds_fmt)?;
    }
    Ok(())
}

/// `InvalidateFboUnbindReadCase` (`sub == false`) and `InvalidateSubFboUnbindReadCase` (`sub == true`).
struct InvalidateFboUnbindReadCase {
    color_fmt: GLenum,
    depth_stencil_fmt: GLenum,
    invalidate_buffers: u32,
    sub: bool,
}

impl FboRender for InvalidateFboUnbindReadCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        format_pre_check(context, self.color_fmt, self.depth_stencil_fmt)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_fmt = map_format(self.color_fmt)?;
        let depth_stencil_fmt = if self.depth_stencil_fmt != glw::GL_NONE {
            Some(map_format(self.depth_stencil_fmt)?)
        } else {
            None
        };
        let color_fmt_info = get_texture_format_info(color_fmt);
        let (w, h) = (ctx.get_width(), ctx.get_height());
        let attachments = get_fbo_discard_attachments(self.invalidate_buffers);

        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(get_fragment_output_type(color_fmt))));

        // Create fbo.
        let (_fbo, color_tex, depth_stencil_tex) = create_tex_fbo(
            ctx,
            self.color_fmt,
            color_fmt,
            self.depth_stencil_fmt,
            depth_stencil_fmt,
            self.sub,
        )?;

        if self.sub {
            clear_color_buffer(ctx, color_fmt, [0.0, 0.0, 0.0, 1.0]);
            ctx.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        } else {
            ctx.clear_color(0.0, 0.0, 0.0, 1.0);
            ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        }

        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
        ctx.stencil_func(glw::GL_ALWAYS, 1, 0xff);

        set_gradient(ctx, grad_shader_id, color_fmt_info.value_min, color_fmt_info.value_max);
        full_quad(ctx, grad_shader_id, -1.0, 1.0);

        if self.sub {
            ctx.invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, &attachments, 0, 0, w / 2, h);
        } else {
            ctx.invalidate_framebuffer(glw::GL_FRAMEBUFFER, &attachments);
        }

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.disable(glw::GL_DEPTH_TEST);
        ctx.disable(glw::GL_STENCIL_TEST);

        if self.sub {
            ctx.clear_color(0.25, 0.5, 0.75, 1.0);
            ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

            // Limit read area using scissor.
            ctx.scissor(w / 2, 0, w / 2, h);
            ctx.enable(glw::GL_SCISSOR_TEST);
        }

        let render_color = if self.sub {
            self.invalidate_buffers & glw::GL_COLOR_BUFFER_BIT != 0
        } else {
            self.invalidate_buffers & glw::GL_DEPTH_BUFFER_BIT != 0
        };
        if render_color {
            draw_attachment_texture(
                ctx,
                color_fmt,
                color_tex,
                color_fmt_info.look_up_scale,
                color_fmt_info.look_up_bias,
            );
        } else {
            let ds_fmt = depth_stencil_fmt.ok_or_else(|| {
                TestError::Fail("depth rendering requested without a depth/stencil format".to_string())
            })?;
            draw_attachment_texture(ctx, ds_fmt, depth_stencil_tex, [1.0; 4], [0.0; 4]);
        }

        read_default_framebuffer(ctx, dst, w, h);
        Ok(())
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        if !self.sub {
            return crate::tcu::fuzzy_image_compare::fuzzy_compare_ok(
                &reference.get_const_access(),
                &result.get_const_access(),
                0.05,
            )
            .unwrap_or(false);
        }

        let Ok(format_threshold) = get_format_threshold_gl(self.color_fmt) else {
            return false;
        };
        let threshold = [
            format_threshold[0].max(12),
            format_threshold[1].max(12),
            format_threshold[2].max(12),
            format_threshold[3].max(12),
        ];
        reference.get_const_access().size() == result.get_const_access().size()
            && bilinear_compare(
                &reference.get_const_access(),
                &result.get_const_access(),
                None,
                threshold,
            )
    }
}

/// `getCompatibleColorFormat`
fn get_compatible_color_format(rt: &crate::glu::RenderTarget) -> GLenum {
    match (rt.red_bits, rt.green_bits, rt.blue_bits, rt.alpha_bits) {
        (8, 8, 8, 8) => glw::GL_RGBA8,
        (8, 8, 8, 0) => glw::GL_RGB8,
        (4, 4, 4, 4) => glw::GL_RGBA4,
        (5, 5, 5, 1) => glw::GL_RGB5_A1,
        (5, 6, 5, 0) => glw::GL_RGB565,
        _ => glw::GL_NONE,
    }
}

/// `getCompatibleDepthStencilFormat`
fn get_compatible_depth_stencil_format(rt: &crate::glu::RenderTarget) -> GLenum {
    let (depth_bits, stencil_bits) = (rt.depth_bits, rt.stencil_bits);
    if depth_bits <= 0 || stencil_bits <= 0 || stencil_bits != 8 {
        return glw::GL_NONE;
    }

    match depth_bits {
        32 => glw::GL_DEPTH32F_STENCIL8,
        24 => glw::GL_DEPTH24_STENCIL8,
        _ => glw::GL_NONE,
    }
}

/// `InvalidateFboUnbindBlitCase` (`sub == false`) and `InvalidateSubFboUnbindBlitCase` (`sub == true`) with
/// `numSamples == 0`. The formats are chosen from the render target in `pre_check`.
struct InvalidateFboUnbindBlitCase {
    invalidate_buffers: u32,
    sub: bool,
    num_samples: i32,
    color_fmt: AtomicU32,
    depth_stencil_fmt: AtomicU32,
}

impl InvalidateFboUnbindBlitCase {
    fn new(invalidate_buffers: u32, sub: bool, num_samples: i32) -> Self {
        Self {
            invalidate_buffers,
            sub,
            num_samples,
            color_fmt: AtomicU32::new(glw::GL_NONE),
            depth_stencil_fmt: AtomicU32::new(glw::GL_NONE),
        }
    }
}

impl FboRender for InvalidateFboUnbindBlitCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        let rt = context.render_target();
        self.color_fmt
            .store(get_compatible_color_format(&rt), Ordering::Relaxed);
        self.depth_stencil_fmt
            .store(get_compatible_depth_stencil_format(&rt), Ordering::Relaxed);

        if rt.num_samples > 0 {
            return Err(TestError::NotSupported("Not supported in MSAA config".to_string()));
        }
        let color_fmt = self.color_fmt.load(Ordering::Relaxed);
        let depth_stencil_fmt = self.depth_stencil_fmt.load(Ordering::Relaxed);
        if color_fmt == glw::GL_NONE {
            return Err(TestError::NotSupported("Unsupported color format".to_string()));
        }
        if depth_stencil_fmt == glw::GL_NONE {
            return Err(TestError::NotSupported("Unsupported depth/stencil format".to_string()));
        }

        check_format_support(context, color_fmt)?;
        check_format_support(context, depth_stencil_fmt)?;
        Ok(())
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_gl = self.color_fmt.load(Ordering::Relaxed);
        let depth_stencil_gl = self.depth_stencil_fmt.load(Ordering::Relaxed);
        let (full_w, full_h) = (ctx.get_width(), ctx.get_height());
        // \note When using fullscreen viewport (when num_samples > 0), still only use a 128x128 pixel quad at most.
        let (w, h) = if self.num_samples == 0 {
            (full_w, full_h)
        } else {
            (full_w.min(128), full_h.min(128))
        };
        let quad_ndc_right_top = (
            -1.0 + 2.0 * w as f32 / full_w as f32,
            -1.0 + 2.0 * h as f32 / full_h as f32,
        );
        let depth_stencil_fmt = map_format(depth_stencil_gl)?;
        let depth = depth_stencil_fmt.order.has_depth();
        let stencil = depth_stencil_fmt.order.has_stencil();
        let attachments = get_fbo_discard_attachments(self.invalidate_buffers);
        let (invalidate_w, invalidate_h) = (w / 2, h);
        let (blit_x0, blit_y0, blit_x1, blit_y1) = if self.sub {
            (invalidate_w, 0, invalidate_w + w / 2, h)
        } else {
            (0, 0, w, h)
        };
        let quad = |ctx: &mut dyn SglrContext, program: u32, z0: f32, z1: f32| {
            draw_quad(
                ctx,
                program,
                Vec3::new(-1.0, -1.0, z0),
                Vec3::new(quad_ndc_right_top.0, quad_ndc_right_top.1, z1),
            );
        };

        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        // Create fbo.
        let mut names = [0u32];
        ctx.gen_renderbuffers(&mut names);
        let color_rbo = names[0];
        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
        ctx.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, self.num_samples, color_gl, w, h);

        ctx.gen_renderbuffers(&mut names);
        let depth_stencil_rbo = names[0];
        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil_rbo);
        ctx.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, self.num_samples, depth_stencil_gl, w, h);

        ctx.gen_framebuffers(&mut names);
        let fbo = names[0];
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_rbo,
        );
        if depth {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }
        if stencil {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
        ctx.stencil_func(glw::GL_ALWAYS, 1, 0xff);

        set_flat_color(ctx, flat_shader_id, [1.0, 0.0, 0.0, 1.0]);
        quad(ctx, flat_shader_id, -1.0, 1.0);

        if self.sub {
            ctx.invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, &attachments, 0, 0, invalidate_w, invalidate_h);
        } else {
            ctx.invalidate_framebuffer(glw::GL_FRAMEBUFFER, &attachments);
        }

        // Set default framebuffer as draw framebuffer and blit preserved buffers.
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
        ctx.blit_framebuffer(
            blit_x0,
            blit_y0,
            blit_x1,
            blit_y1,
            blit_x0,
            blit_y0,
            blit_x1,
            blit_y1,
            (glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT)
                & !self.invalidate_buffers,
            glw::GL_NEAREST,
        );
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);

        if self.invalidate_buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
            // Color was not preserved - fill with green.
            ctx.disable(glw::GL_DEPTH_TEST);
            ctx.disable(glw::GL_STENCIL_TEST);

            set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);
            quad(ctx, flat_shader_id, 0.0, 0.0);

            ctx.enable(glw::GL_DEPTH_TEST);
            ctx.enable(glw::GL_STENCIL_TEST);
        }

        if self.invalidate_buffers & glw::GL_DEPTH_BUFFER_BIT != 0 {
            // Depth was not preserved.
            ctx.depth_func(glw::GL_ALWAYS);
        }

        if self.invalidate_buffers & glw::GL_STENCIL_BUFFER_BIT == 0 {
            // Stencil was preserved.
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
        }

        ctx.enable(glw::GL_BLEND);
        ctx.blend_func(glw::GL_ONE, glw::GL_ONE);
        ctx.blend_equation(glw::GL_FUNC_ADD);

        set_flat_color(ctx, flat_shader_id, [0.0, 0.0, 1.0, 1.0]);
        quad(ctx, flat_shader_id, 0.0, 0.0);

        read_default_framebuffer(ctx, dst, w, h);
        Ok(())
    }
}

/// `hasAttachment`
fn has_attachment(attachment_list: &[GLenum], attachment: GLenum) -> bool {
    attachment_list.contains(&attachment)
}

/// `InvalidateFboTargetCase`
struct InvalidateFboTargetCase {
    bound_target: GLenum,
    invalidate_target: GLenum,
    invalidate_attachments: Vec<GLenum>,
}

impl FboRender for InvalidateFboTargetCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_format = glw::GL_RGBA8;
        let depth_stencil_format = glw::GL_DEPTH24_STENCIL8;
        let color_fmt = map_format(color_format)?;
        let color_fmt_info = get_texture_format_info(color_fmt);
        let c_bias = color_fmt_info.value_min;
        let mut c_scale = [0.0f32; 4];
        for i in 0..4 {
            c_scale[i] = color_fmt_info.value_max[i] - color_fmt_info.value_min[i];
        }
        let is_discarded = self.bound_target == glw::GL_FRAMEBUFFER
            || (self.invalidate_target == glw::GL_FRAMEBUFFER && self.bound_target == glw::GL_DRAW_FRAMEBUFFER)
            || self.invalidate_target == self.bound_target;
        let is_color_discarded =
            is_discarded && has_attachment(&self.invalidate_attachments, glw::GL_COLOR_ATTACHMENT0);
        let is_depth_discarded = is_discarded
            && (has_attachment(&self.invalidate_attachments, glw::GL_DEPTH_ATTACHMENT)
                || has_attachment(&self.invalidate_attachments, glw::GL_DEPTH_STENCIL_ATTACHMENT));
        let is_stencil_discarded = is_discarded
            && (has_attachment(&self.invalidate_attachments, glw::GL_STENCIL_ATTACHMENT)
                || has_attachment(&self.invalidate_attachments, glw::GL_DEPTH_STENCIL_ATTACHMENT));
        let (w, h) = (ctx.get_width(), ctx.get_height());

        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));

        // Create fbo.
        let mut names = [0u32];
        ctx.gen_renderbuffers(&mut names);
        let color_rbo = names[0];
        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, color_format, w, h);

        ctx.gen_renderbuffers(&mut names);
        let depth_stencil_rbo = names[0];
        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil_rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, depth_stencil_format, w, h);

        ctx.gen_framebuffers(&mut names);
        let fbo = names[0];
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_rbo,
        );
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            depth_stencil_rbo,
        );
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            depth_stencil_rbo,
        );
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        draw_initial_quad(ctx, flat_shader_id, scale_bias([1.0, 0.0, 0.0, 1.0], c_scale, c_bias));

        // Bound FBO to test target and default to other.
        if self.bound_target != glw::GL_FRAMEBUFFER {
            // Unused fbo is used as complementing target (read when discarding draw for example).
            let unused_target = if self.bound_target == glw::GL_DRAW_FRAMEBUFFER {
                glw::GL_READ_FRAMEBUFFER
            } else {
                glw::GL_DRAW_FRAMEBUFFER
            };

            ctx.gen_renderbuffers(&mut names);
            let unused_color_rbo = names[0];
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, unused_color_rbo);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 64, 64);
            ctx.gen_framebuffers(&mut names);
            let unused_fbo = names[0];
            ctx.bind_framebuffer(unused_target, unused_fbo);
            ctx.framebuffer_renderbuffer(
                unused_target,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                unused_color_rbo,
            );

            ctx.bind_framebuffer(self.bound_target, fbo);
        }

        ctx.invalidate_framebuffer(self.invalidate_target, &self.invalidate_attachments);

        if self.bound_target != glw::GL_FRAMEBUFFER {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        }

        if is_color_discarded {
            // Color was not preserved - fill with green.
            ctx.disable(glw::GL_DEPTH_TEST);
            ctx.disable(glw::GL_STENCIL_TEST);

            set_flat_color(ctx, flat_shader_id, scale_bias([0.0, 1.0, 0.0, 1.0], c_scale, c_bias));
            full_quad(ctx, flat_shader_id, 0.0, 0.0);

            ctx.enable(glw::GL_DEPTH_TEST);
            ctx.enable(glw::GL_STENCIL_TEST);
        }

        if is_depth_discarded {
            // Depth was not preserved.
            ctx.depth_func(glw::GL_ALWAYS);
        }

        if !is_stencil_discarded {
            // Stencil was preserved.
            ctx.stencil_func(glw::GL_EQUAL, 1, 0xff);
        }

        blend_blue_quad(ctx, flat_shader_id, scale_bias([0.0, 0.0, 1.0, 1.0], c_scale, c_bias));

        read_pixels(
            ctx,
            dst,
            0,
            0,
            w,
            h,
            color_fmt,
            color_fmt_info.look_up_scale,
            color_fmt_info.look_up_bias,
        )?;
        Ok(())
    }
}

/// The `unbind_read_*` and `unbind_blit_*` (non-multisampled) cases of `invalidate.whole`/`invalidate.sub`.
fn add_unbind_cases(group: &mut TestCaseGroup, sub: bool) {
    let ds = glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
    let read_sets: [(&str, u32); 5] = [
        ("unbind_read_color", glw::GL_COLOR_BUFFER_BIT),
        ("unbind_read_depth", glw::GL_DEPTH_BUFFER_BIT),
        ("unbind_read_stencil", glw::GL_STENCIL_BUFFER_BIT),
        ("unbind_read_depth_stencil", ds),
        (
            "unbind_read_color_stencil",
            glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
        ),
    ];
    for (name, buffers) in read_sets {
        group.add_child(FboTestCase::new(
            name,
            InvalidateFboUnbindReadCase {
                color_fmt: glw::GL_RGBA8,
                depth_stencil_fmt: glw::GL_DEPTH24_STENCIL8,
                invalidate_buffers: buffers,
                sub,
            },
        ));
    }

    let blit_sets: [(&str, u32); 4] = [
        ("color", glw::GL_COLOR_BUFFER_BIT),
        ("depth", glw::GL_DEPTH_BUFFER_BIT),
        ("stencil", glw::GL_STENCIL_BUFFER_BIT),
        ("depth_stencil", ds),
    ];
    for (suffix, buffers) in blit_sets {
        group.add_child(FboTestCase::new(
            format!("unbind_blit_{suffix}"),
            InvalidateFboUnbindBlitCase::new(buffers, sub, 0),
        ));
    }
    // Fullscreen viewport when multisampling - no random viewport position, since source and destination
    // rectangles of `glBlitFramebuffer` must match.
    for (suffix, buffers) in blit_sets {
        group.add_child(FboTestCase::new_screen_sized(
            format!("unbind_blit_msaa_{suffix}"),
            InvalidateFboUnbindBlitCase::new(buffers, sub, 4),
        ));
    }
}

/// `FboInvalidateTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("invalidate");

    let all = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
    let ds = glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;

    // invalidate.default.
    {
        let mut default_fb_group = TestCaseGroup::new("default");

        // (name, buffers) shared by the render/bind variants; `render_none` exists for the plain render case only.
        default_fb_group.add_child(FboTestCase::new(
            "render_none",
            InvalidateDefaultFramebufferRenderCase {
                buffers: 0,
                fbo_target: glw::GL_FRAMEBUFFER,
            },
        ));
        let sets: [(&str, u32); 5] = [
            ("color", glw::GL_COLOR_BUFFER_BIT),
            ("depth", glw::GL_DEPTH_BUFFER_BIT),
            ("stencil", glw::GL_STENCIL_BUFFER_BIT),
            ("depth_stencil", ds),
            ("all", all),
        ];
        for (name, buffers) in sets {
            default_fb_group.add_child(FboTestCase::new(
                format!("render_{name}"),
                InvalidateDefaultFramebufferRenderCase {
                    buffers,
                    fbo_target: glw::GL_FRAMEBUFFER,
                },
            ));
        }
        for (name, buffers) in sets {
            default_fb_group.add_child(FboTestCase::new(
                format!("bind_{name}"),
                InvalidateDefaultFramebufferBindCase { buffers },
            ));
        }
        for (name, buffers) in sets {
            default_fb_group.add_child(FboTestCase::new(
                format!("sub_render_{name}"),
                InvalidateDefaultSubFramebufferRenderCase { buffers },
            ));
        }
        for (name, buffers) in sets {
            default_fb_group.add_child(FboTestCase::new(
                format!("sub_bind_{name}"),
                InvalidateDefaultSubFramebufferBindCase { buffers },
            ));
        }

        let targets: [(&str, u32, GLenum); 4] = [
            (
                "draw_framebuffer_color",
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_DRAW_FRAMEBUFFER,
            ),
            ("draw_framebuffer_all", all, glw::GL_DRAW_FRAMEBUFFER),
            (
                "read_framebuffer_color",
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_READ_FRAMEBUFFER,
            ),
            ("read_framebuffer_all", all, glw::GL_READ_FRAMEBUFFER),
        ];
        for (name, buffers, fbo_target) in targets {
            default_fb_group.add_child(FboTestCase::new(
                name,
                InvalidateDefaultFramebufferRenderCase { buffers, fbo_target },
            ));
        }

        group.add_child(default_fb_group);
    }

    let render_sets: [(&str, u32); 6] = [
        ("render_none", 0),
        ("render_color", glw::GL_COLOR_BUFFER_BIT),
        ("render_depth", glw::GL_DEPTH_BUFFER_BIT),
        ("render_stencil", glw::GL_STENCIL_BUFFER_BIT),
        ("render_depth_stencil", ds),
        ("render_all", all),
    ];

    // invalidate.whole.
    {
        let mut whole_fbo_group = TestCaseGroup::new("whole");
        for (name, buffers) in render_sets {
            whole_fbo_group.add_child(FboTestCase::new(
                name,
                InvalidateFboRenderCase {
                    color_fmt: glw::GL_RGBA8,
                    depth_stencil_fmt: glw::GL_DEPTH24_STENCIL8,
                    invalidate_buffers: buffers,
                    sub: false,
                },
            ));
        }
        add_unbind_cases(&mut whole_fbo_group, false);
        group.add_child(whole_fbo_group);
    }

    // invalidate.sub.
    {
        let mut sub_fbo_group = TestCaseGroup::new("sub");
        for (name, buffers) in render_sets {
            sub_fbo_group.add_child(FboTestCase::new(
                name,
                InvalidateFboRenderCase {
                    color_fmt: glw::GL_RGBA8,
                    depth_stencil_fmt: glw::GL_DEPTH24_STENCIL8,
                    invalidate_buffers: buffers,
                    sub: true,
                },
            ));
        }
        add_unbind_cases(&mut sub_fbo_group, true);
        group.add_child(sub_fbo_group);
    }

    // invalidate.format.
    {
        let mut format_group = TestCaseGroup::new("format");

        // Color buffer formats.
        let color_formats: [GLenum; 35] = [
            glw::GL_RGBA32I,
            glw::GL_RGBA32UI,
            glw::GL_RGBA16I,
            glw::GL_RGBA16UI,
            glw::GL_RGBA8,
            glw::GL_RGBA8I,
            glw::GL_RGBA8UI,
            glw::GL_SRGB8_ALPHA8,
            glw::GL_RGB10_A2,
            glw::GL_RGB10_A2UI,
            glw::GL_RGBA4,
            glw::GL_RGB5_A1,
            glw::GL_RGB8,
            glw::GL_RGB565,
            glw::GL_RG32I,
            glw::GL_RG32UI,
            glw::GL_RG16I,
            glw::GL_RG16UI,
            glw::GL_RG8,
            glw::GL_RG8I,
            glw::GL_RG8UI,
            glw::GL_R32I,
            glw::GL_R32UI,
            glw::GL_R16I,
            glw::GL_R16UI,
            glw::GL_R8,
            glw::GL_R8I,
            glw::GL_R8UI,
            glw::GL_RGBA32F,
            glw::GL_RGBA16F,
            glw::GL_R11F_G11F_B10F,
            glw::GL_RG32F,
            glw::GL_RG16F,
            glw::GL_R32F,
            glw::GL_R16F,
        ];

        // Depth/stencilbuffer formats.
        let depth_stencil_formats: [GLenum; 6] = [
            glw::GL_DEPTH_COMPONENT32F,
            glw::GL_DEPTH_COMPONENT24,
            glw::GL_DEPTH_COMPONENT16,
            glw::GL_DEPTH32F_STENCIL8,
            glw::GL_DEPTH24_STENCIL8,
            glw::GL_STENCIL_INDEX8,
        ];

        // Colorbuffer tests use invalidate, unbind, read test.
        for format in color_formats {
            format_group.add_child(FboTestCase::new(
                get_format_name(format),
                InvalidateFboUnbindReadCase {
                    color_fmt: format,
                    depth_stencil_fmt: glw::GL_NONE,
                    invalidate_buffers: glw::GL_COLOR_BUFFER_BIT,
                    sub: true,
                },
            ));
        }

        // Depth/stencilbuffer tests use invalidate, render test.
        for format in depth_stencil_formats {
            format_group.add_child(FboTestCase::new(
                get_format_name(format),
                InvalidateFboRenderCase {
                    color_fmt: glw::GL_RGBA8,
                    depth_stencil_fmt: format,
                    invalidate_buffers: ds,
                    sub: true,
                },
            ));
        }

        group.add_child(format_group);
    }

    // invalidate.target.
    {
        let mut target_group = TestCaseGroup::new("target");

        let target_cases: [(&str, GLenum, GLenum); 9] = [
            ("framebuffer_framebuffer", glw::GL_FRAMEBUFFER, glw::GL_FRAMEBUFFER),
            (
                "framebuffer_read_framebuffer",
                glw::GL_FRAMEBUFFER,
                glw::GL_READ_FRAMEBUFFER,
            ),
            (
                "framebuffer_draw_framebuffer",
                glw::GL_FRAMEBUFFER,
                glw::GL_DRAW_FRAMEBUFFER,
            ),
            (
                "read_framebuffer_framebuffer",
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER,
            ),
            (
                "read_framebuffer_read_framebuffer",
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_READ_FRAMEBUFFER,
            ),
            (
                "read_framebuffer_draw_framebuffer",
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_DRAW_FRAMEBUFFER,
            ),
            (
                "draw_framebuffer_framebuffer",
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER,
            ),
            (
                "draw_framebuffer_read_framebuffer",
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_READ_FRAMEBUFFER,
            ),
            (
                "draw_framebuffer_draw_framebuffer",
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_DRAW_FRAMEBUFFER,
            ),
        ];
        let attachment_sets: [(&str, Vec<GLenum>); 3] = [
            ("color", vec![glw::GL_COLOR_ATTACHMENT0]),
            ("depth_stencil", vec![glw::GL_DEPTH_STENCIL_ATTACHMENT]),
            (
                "all",
                vec![
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_STENCIL_ATTACHMENT,
                ],
            ),
        ];

        for (base_name, invalidate_target, bound_target) in target_cases {
            for (suffix, attachments) in &attachment_sets {
                target_group.add_child(FboTestCase::new(
                    format!("{base_name}_{suffix}"),
                    InvalidateFboTargetCase {
                        bound_target,
                        invalidate_target,
                        invalidate_attachments: attachments.clone(),
                    },
                ));
            }
        }

        group.add_child(target_group);
    }

    group
}
