// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboStencilbufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.fbo.stencil`: basic (3 formats, plus a `_depth` variant of each
// depth-stencil one) and attach (4 attachment combinations of one DEPTH24_STENCIL8 renderbuffer).

use super::fbo_test_case::{FboRender, FboTestCase, check_error, check_format_support, check_framebuffer_status};
use super::fbo_test_util::{
    FlatColorShader, GradientShader, get_format_name, read_pixels, set_flat_color, set_gradient,
};
use crate::glu::TestCaseGroup;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::map_gl_internal_format;
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::vector::Vec3;
use crate::tcu::{ChannelOrder, Surface, TestError};

/// The part of both cases after the framebuffer is set up: `glClearBufferfv(GL_COLOR)`,
/// `glClearBufferfi`, two intersecting quads incrementing stencil on depth pass, then two stencil-tested quads.
fn render_stencil_scene(ctx: &mut dyn SglrContext, flat_shader_id: u32, grad_shader_id: u32, has_depth: bool) {
    // Clear framebuffer.
    ctx.clear_buffer_fv(glw::GL_COLOR, 0, &[0.0, 0.0, 0.0, 0.0]);
    ctx.clear_buffer_fi(glw::GL_DEPTH_STENCIL, 0, 1.0, 0);

    // Render intersecting quads - increment stencil on depth pass
    ctx.enable(glw::GL_DEPTH_TEST);
    ctx.enable(glw::GL_STENCIL_TEST);
    ctx.stencil_func(glw::GL_ALWAYS, 0, 0xff);
    ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_INCR);

    set_flat_color(ctx, flat_shader_id, [1.0, 0.0, 0.0, 1.0]);
    draw_quad(
        ctx,
        flat_shader_id,
        Vec3::new(-1.0, -1.0, 0.0),
        Vec3::new(1.0, 1.0, 0.0),
    );

    set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);
    draw_quad(
        ctx,
        grad_shader_id,
        Vec3::new(-1.0, -1.0, -1.0),
        Vec3::new(1.0, 1.0, 1.0),
    );

    ctx.disable(glw::GL_DEPTH_TEST);

    // Draw quad with stencil test (stencil == 1 or 2 depending on depth) - decrement on stencil failure
    ctx.stencil_func(glw::GL_EQUAL, if has_depth { 2 } else { 1 }, 0xff);
    ctx.stencil_op(glw::GL_DECR, glw::GL_KEEP, glw::GL_KEEP);

    set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);
    draw_quad(
        ctx,
        flat_shader_id,
        Vec3::new(-0.5, -0.5, 0.0),
        Vec3::new(0.5, 0.5, 0.0),
    );

    // Draw quad with stencil test where stencil > 1 or 2 depending on depth buffer
    ctx.stencil_func(glw::GL_GREATER, if has_depth { 1 } else { 2 }, 0xff);

    set_flat_color(ctx, flat_shader_id, [0.0, 0.0, 1.0, 1.0]);
    draw_quad(
        ctx,
        flat_shader_id,
        Vec3::new(-1.0, -1.0, 0.0),
        Vec3::new(1.0, 1.0, 0.0),
    );
}

/// Creates the colour renderbuffer and the depth-stencil renderbuffer and returns `(fbo, color_rbo, depth_stencil_rbo)`.
fn create_buffers(ctx: &mut dyn SglrContext, depth_stencil_format: GLenum, width: i32, height: i32) -> (u32, u32, u32) {
    let color_format = glw::GL_RGBA8;
    let mut names = [0u32];

    // Colorbuffer.
    ctx.gen_renderbuffers(&mut names);
    let color_rbo = names[0];
    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
    ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, color_format, width, height);

    // Stencil (and depth) buffer.
    ctx.gen_renderbuffers(&mut names);
    let depth_stencil_rbo = names[0];
    ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil_rbo);
    ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, depth_stencil_format, width, height);

    // Framebuffer.
    ctx.gen_framebuffers(&mut names);
    let fbo = names[0];
    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
    ctx.framebuffer_renderbuffer(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_RENDERBUFFER,
        color_rbo,
    );
    (fbo, color_rbo, depth_stencil_rbo)
}

fn read_rgba8(ctx: &mut dyn SglrContext, dst: &mut Surface, width: i32, height: i32) -> Result<(), TestError> {
    let read_format = map_gl_internal_format(glw::GL_RGBA8)
        .ok_or_else(|| TestError::Fail("unknown internal format GL_RGBA8".to_string()))?;
    read_pixels(ctx, dst, 0, 0, width, height, read_format, [1.0; 4], [0.0; 4])
}

/// `BasicFboStencilCase`
struct BasicFboStencilCase {
    format: GLenum,
    size: (i32, i32),
    use_depth: bool,
}

impl FboRender for BasicFboStencilCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let (width, height) = self.size;

        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));
        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));

        let (_fbo, _color_rbo, depth_stencil_rbo) = create_buffers(ctx, self.format, width, height);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            depth_stencil_rbo,
        );
        if self.use_depth {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }
        check_error(ctx)?;
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.viewport(0, 0, width, height);

        render_stencil_scene(ctx, flat_shader_id, grad_shader_id, self.use_depth);

        read_rgba8(ctx, dst, width, height)
    }
}

/// `DepthStencilAttachCase`
struct DepthStencilAttachCase {
    attach_depth: GLenum,
    attach_stencil: GLenum,
}

impl DepthStencilAttachCase {
    fn new(attach_depth: GLenum, attach_stencil: GLenum) -> Self {
        debug_assert!(
            attach_depth == glw::GL_DEPTH_ATTACHMENT
                || attach_depth == glw::GL_DEPTH_STENCIL_ATTACHMENT
                || attach_depth == glw::GL_NONE
        );
        debug_assert!(attach_stencil == glw::GL_STENCIL_ATTACHMENT || attach_stencil == glw::GL_NONE);
        Self {
            attach_depth,
            attach_stencil,
        }
    }
}

impl FboRender for DepthStencilAttachCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let depth_stencil_format = glw::GL_DEPTH24_STENCIL8;
        let width = 128;
        let height = 128;
        // Upstream compares against GL_DEPTH_STENCIL (not GL_DEPTH_STENCIL_ATTACHMENT) here, which never
        // matches, so only GL_DEPTH_ATTACHMENT counts as having depth.
        let has_depth = self.attach_depth == glw::GL_DEPTH_ATTACHMENT;

        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));
        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));

        let (_fbo, _color_rbo, depth_stencil_rbo) = create_buffers(ctx, depth_stencil_format, width, height);

        if self.attach_depth != glw::GL_NONE {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                self.attach_depth,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }
        if self.attach_stencil != glw::GL_NONE {
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                self.attach_stencil,
                glw::GL_RENDERBUFFER,
                depth_stencil_rbo,
            );
        }

        check_error(ctx)?;
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.viewport(0, 0, width, height);

        render_stencil_scene(ctx, flat_shader_id, grad_shader_id, has_depth);

        read_rgba8(ctx, dst, width, height)
    }
}

/// `FboStencilTests::init`
pub fn create_tests() -> TestCaseGroup {
    let stencil_formats: [GLenum; 3] = [
        glw::GL_DEPTH32F_STENCIL8,
        glw::GL_DEPTH24_STENCIL8,
        glw::GL_STENCIL_INDEX8,
    ];

    let mut group = TestCaseGroup::new("stencil");

    // .basic
    {
        let mut basic_group = TestCaseGroup::new("basic");

        for format in stencil_formats {
            let tex_fmt = map_gl_internal_format(format);

            basic_group.add_child(FboTestCase::new(
                get_format_name(format),
                BasicFboStencilCase {
                    format,
                    size: (111, 132),
                    use_depth: false,
                },
            ));

            if tex_fmt.is_some_and(|f| f.order == ChannelOrder::DS) {
                basic_group.add_child(FboTestCase::new(
                    format!("{}_depth", get_format_name(format)),
                    BasicFboStencilCase {
                        format,
                        size: (111, 132),
                        use_depth: true,
                    },
                ));
            }
        }
        group.add_child(basic_group);
    }

    // .attach
    {
        let mut attach_group = TestCaseGroup::new("attach");

        attach_group.add_child(FboTestCase::new(
            "depth_only",
            DepthStencilAttachCase::new(glw::GL_DEPTH_ATTACHMENT, glw::GL_NONE),
        ));
        attach_group.add_child(FboTestCase::new(
            "stencil_only",
            DepthStencilAttachCase::new(glw::GL_NONE, glw::GL_STENCIL_ATTACHMENT),
        ));
        attach_group.add_child(FboTestCase::new(
            "depth_stencil_separate",
            DepthStencilAttachCase::new(glw::GL_DEPTH_ATTACHMENT, glw::GL_STENCIL_ATTACHMENT),
        ));
        attach_group.add_child(FboTestCase::new(
            "depth_stencil_attachment",
            DepthStencilAttachCase::new(glw::GL_DEPTH_STENCIL_ATTACHMENT, glw::GL_NONE),
        ));
        group.add_child(attach_group);
    }

    group
}
