// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboDepthbufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.fbo.depth`: basic, depth_write_clamp and depth_test_clamp over the five
// depth formats. Each case is an `FboRender` run by `FboTestCase`.

use super::fbo_test_case::{FboRender, FboTestCase, check_error, check_format_support, check_framebuffer_status};
use super::fbo_test_util::{
    DepthGradientShader, GradientShader, Texture2DShader, get_format_name, read_pixels, set_depth_gradient_uniforms,
    set_gradient,
};
use crate::glu::TestCaseGroup;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::pixel::{TextureLevel, fill_with_grid};
use crate::tcu::vector::Vec3;
use crate::tcu::{Surface, TestError};

fn gen_framebuffer(ctx: &mut dyn SglrContext) -> u32 {
    let mut names = [0u32];
    ctx.gen_framebuffers(&mut names);
    names[0]
}

fn gen_renderbuffer(ctx: &mut dyn SglrContext) -> u32 {
    let mut names = [0u32];
    ctx.gen_renderbuffers(&mut names);
    names[0]
}

fn gen_texture(ctx: &mut dyn SglrContext) -> u32 {
    let mut names = [0u32];
    ctx.gen_textures(&mut names);
    names[0]
}

/// `BasicFboDepthCase`
struct BasicFboDepthCase {
    format: GLenum,
    width: i32,
    height: i32,
}

impl FboRender for BasicFboDepthCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_format = glw::GL_RGBA8;
        let clear_depth = [1.0f32];

        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));

        // Setup shaders
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);
        tex_uniforms.set_uniforms(ctx, tex_shader_id);

        // Setup FBO
        let fbo = gen_framebuffer(ctx);
        let color_rbo = gen_renderbuffer(ctx);
        let depth_rbo = gen_renderbuffer(ctx);

        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, color_format, self.width, self.height);

        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.format, self.width, self.height);

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
            depth_rbo,
        );
        check_error(ctx)?;
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.viewport(0, 0, self.width, self.height);

        // Clear depth to 1
        ctx.clear_buffer_fv(glw::GL_DEPTH, 0, &clear_depth);

        // Render gradient with depth = [-1..1]
        ctx.enable(glw::GL_DEPTH_TEST);
        draw_quad(
            ctx,
            grad_shader_id,
            Vec3::new(-1.0, -1.0, -1.0),
            Vec3::new(1.0, 1.0, 1.0),
        );

        // Render grid pattern with depth = 0
        {
            let format = glw::GL_RGBA;
            let data_type = glw::GL_UNSIGNED_BYTE;
            let tex_w = 128;
            let tex_h = 128;
            let tex_format = map_gl_transfer_format(format, data_type)
                .ok_or_else(|| TestError::Fail("unknown transfer format GL_RGBA/GL_UNSIGNED_BYTE".to_string()))?;
            let mut data = TextureLevel::new(tex_format, tex_w as u32, tex_h as u32, 1)?;

            fill_with_grid(&mut data.get_access(), 8, [0.2, 0.7, 0.1, 1.0], [0.7, 0.1, 0.5, 0.8]);

            let grid_tex = gen_texture(ctx);
            ctx.bind_texture(glw::GL_TEXTURE_2D, grid_tex);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
            ctx.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format,
                tex_w,
                tex_h,
                0,
                format,
                data_type,
                Some(data.data()),
            );

            draw_quad(ctx, tex_shader_id, Vec3::new(-1.0, -1.0, 0.0), Vec3::new(1.0, 1.0, 0.0));
        }

        // Read results.
        let read_format = map_gl_internal_format(color_format)
            .ok_or_else(|| TestError::Fail("unknown internal format GL_RGBA8".to_string()))?;
        read_pixels(ctx, dst, 0, 0, self.width, self.height, read_format, [1.0; 4], [0.0; 4])
    }
}

/// Everything `DepthWriteClampCase` and `DepthTestClampCase` share: an RGBA8 renderbuffer plus a
/// depth texture of `format`, bound as the framebuffer, with the depth cleared to 1.
fn setup_depth_texture_fbo(
    ctx: &mut dyn SglrContext,
    format: GLenum,
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    let color_format = glw::GL_RGBA8;
    let tex_format = map_gl_internal_format(format)
        .ok_or_else(|| TestError::Fail(format!("unknown internal format {format:#x}")))?;
    let transfer_fmt = get_transfer_format(tex_format)?;
    let clear_depth = [1.0f32];

    let fbo = gen_framebuffer(ctx);
    let color_rbo = gen_renderbuffer(ctx);
    let depth_texture = gen_texture(ctx);

    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
    ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, color_format, width, height);

    ctx.bind_texture(glw::GL_TEXTURE_2D, depth_texture);
    ctx.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        format,
        width,
        height,
        0,
        transfer_fmt.format,
        transfer_fmt.data_type,
        None,
    );
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);

    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
    ctx.framebuffer_renderbuffer(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_RENDERBUFFER,
        color_rbo,
    );
    ctx.framebuffer_texture2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_TEXTURE_2D,
        depth_texture,
        0,
    );
    check_error(ctx)?;
    check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

    ctx.viewport(0, 0, width, height);

    // Clear depth to 1
    ctx.clear_buffer_fv(glw::GL_DEPTH, 0, &clear_depth);
    Ok(())
}

fn read_rgba8(ctx: &mut dyn SglrContext, dst: &mut Surface, width: i32, height: i32) -> Result<(), TestError> {
    let read_format = map_gl_internal_format(glw::GL_RGBA8)
        .ok_or_else(|| TestError::Fail("unknown internal format GL_RGBA8".to_string()))?;
    read_pixels(ctx, dst, 0, 0, width, height, read_format, [1.0; 4], [0.0; 4])
}

const FULL_DEPTH_P0: Vec3 = Vec3::new(-1.0, -1.0, -1.0);
const FULL_DEPTH_P1: Vec3 = Vec3::new(1.0, 1.0, 1.0);

/// `DepthWriteClampCase`
struct DepthWriteClampCase {
    format: GLenum,
    width: i32,
    height: i32,
}

impl FboRender for DepthWriteClampCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let depth_grad_shader_id = ctx.create_program(Box::new(DepthGradientShader::new(DataType::FloatVec4)));
        let red = [1.0, 0.0, 0.0, 1.0];
        let green = [0.0, 1.0, 0.0, 1.0];

        setup_depth_texture_fbo(ctx, self.format, self.width, self.height)?;

        // Test that invalid values are not written to the depth buffer

        // Render green quad, depth gradient = [-1..2]
        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.depth_func(glw::GL_ALWAYS);

        set_depth_gradient_uniforms(ctx, depth_grad_shader_id, -1.0, 2.0, green);
        draw_quad(ctx, depth_grad_shader_id, FULL_DEPTH_P0, FULL_DEPTH_P1);
        ctx.depth_mask(false);

        // Test if any fragment has greater depth than 1; there should be none
        ctx.depth_func(glw::GL_LESS); // (1 < depth) ?
        set_depth_gradient_uniforms(ctx, depth_grad_shader_id, 1.0, 1.0, red);
        draw_quad(ctx, depth_grad_shader_id, FULL_DEPTH_P0, FULL_DEPTH_P1);

        // Test if any fragment has smaller depth than 0; there should be none
        ctx.depth_func(glw::GL_GREATER); // (0 > depth) ?
        set_depth_gradient_uniforms(ctx, depth_grad_shader_id, 0.0, 0.0, red);
        draw_quad(ctx, depth_grad_shader_id, FULL_DEPTH_P0, FULL_DEPTH_P1);

        // Read results.
        read_rgba8(ctx, dst, self.width, self.height)
    }
}

/// `DepthTestClampCase`
struct DepthTestClampCase {
    format: GLenum,
    width: i32,
    height: i32,
}

impl FboRender for DepthTestClampCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let depth_grad_shader_id = ctx.create_program(Box::new(DepthGradientShader::new(DataType::FloatVec4)));
        let yellow = [1.0, 1.0, 0.0, 1.0];
        let green = [0.0, 1.0, 0.0, 1.0];

        setup_depth_texture_fbo(ctx, self.format, self.width, self.height)?;

        // Test values used in depth test are clamped

        // Render green quad, depth gradient = [-1..2]
        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.depth_func(glw::GL_ALWAYS);

        set_depth_gradient_uniforms(ctx, depth_grad_shader_id, -1.0, 2.0, green);
        draw_quad(ctx, depth_grad_shader_id, FULL_DEPTH_P0, FULL_DEPTH_P1);

        // Render yellow quad, depth gradient = [-0.5..3]. Gradients have equal values only outside [0, 1] range due to clamping
        ctx.depth_func(glw::GL_EQUAL);
        set_depth_gradient_uniforms(ctx, depth_grad_shader_id, -0.5, 3.0, yellow);
        draw_quad(ctx, depth_grad_shader_id, FULL_DEPTH_P0, FULL_DEPTH_P1);

        // Read results.
        read_rgba8(ctx, dst, self.width, self.height)
    }
}

/// `FboDepthTests::init`
pub fn create_tests() -> TestCaseGroup {
    let depth_formats: [GLenum; 5] = [
        glw::GL_DEPTH_COMPONENT32F,
        glw::GL_DEPTH_COMPONENT24,
        glw::GL_DEPTH_COMPONENT16,
        glw::GL_DEPTH32F_STENCIL8,
        glw::GL_DEPTH24_STENCIL8,
    ];

    let mut group = TestCaseGroup::new("depth");

    // .basic
    {
        let mut basic_group = TestCaseGroup::new("basic");
        for format in depth_formats {
            basic_group.add_child(FboTestCase::new(
                get_format_name(format),
                BasicFboDepthCase {
                    format,
                    width: 119,
                    height: 127,
                },
            ));
        }
        group.add_child(basic_group);
    }

    // .depth_write_clamp
    {
        let mut depth_clamp_group = TestCaseGroup::new("depth_write_clamp");
        for format in depth_formats {
            depth_clamp_group.add_child(FboTestCase::new(
                get_format_name(format),
                DepthWriteClampCase {
                    format,
                    width: 119,
                    height: 127,
                },
            ));
        }
        group.add_child(depth_clamp_group);
    }

    // .depth_test_clamp
    {
        let mut depth_clamp_group = TestCaseGroup::new("depth_test_clamp");
        for format in depth_formats {
            depth_clamp_group.add_child(FboTestCase::new(
                get_format_name(format),
                DepthTestClampCase {
                    format,
                    width: 119,
                    height: 127,
                },
            ));
        }
        group.add_child(depth_clamp_group);
    }

    group
}
