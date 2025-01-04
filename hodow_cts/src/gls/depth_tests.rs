// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDepthTests.cpp
//   modules/gles3/functional/es3fDepthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream files differ only in the
// shader dialect (`QuadRendererGlslVersion`), so this one port serves both. No `tcu::TestLog`;
// the reference context is single sample.

use crate::gls::fragment_op_util::QuadRendererGlslVersion;
use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::gls::uniform_color_shader::{UniformColorShader, set_color};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::sglr::gl_context::GLContext;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::vector::Vec3;
use crate::tcu::{Random, Surface, TestOutcome, TestStatus, de_string_hash};

/// `DepthCompareCase`
struct DepthCompareCase {
    name: String,
    glsl: QuadRendererGlslVersion,
    compare_op: GLenum,
}

impl DepthCompareCase {
    /// `DepthCompareCase::render`
    fn render(&self, ctx: &mut dyn SglrContext) {
        let shader_id = ctx.create_program(Box::new(UniformColorShader::new(self.glsl, false)));

        let red = [1.0f32, 0.0, 0.0, 1.0];
        let green = [0.0f32, 1.0, 0.0, 1.0];
        let quad = |ctx: &mut dyn SglrContext, p0: [f32; 3], p1: [f32; 3]| {
            draw_quad(
                ctx,
                shader_id,
                Vec3::new(p0[0], p0[1], p0[2]),
                Vec3::new(p1[0], p1[1], p1[2]),
            );
        };

        // Clear depth to 1
        ctx.clear_depthf(1.0);
        ctx.clear(glw::GL_DEPTH_BUFFER_BIT);

        // Enable depth test.
        ctx.enable(glw::GL_DEPTH_TEST);

        // Upper left: two quads with same depth
        ctx.depth_func(glw::GL_ALWAYS);
        set_color(ctx, shader_id, red);
        quad(ctx, [-1.0, -1.0, 0.2], [0.0, 0.0, 0.2]);
        ctx.depth_func(self.compare_op);
        set_color(ctx, shader_id, green);
        quad(ctx, [-1.0, -1.0, 0.2], [0.0, 0.0, 0.2]);

        // Lower left: two quads, d1 < d2
        ctx.depth_func(glw::GL_ALWAYS);
        set_color(ctx, shader_id, red);
        quad(ctx, [-1.0, 0.0, -0.4], [0.0, 1.0, -0.4]);
        ctx.depth_func(self.compare_op);
        set_color(ctx, shader_id, green);
        quad(ctx, [-1.0, 0.0, -0.1], [0.0, 1.0, -0.1]);

        // Upper right: two quads, d1 > d2
        ctx.depth_func(glw::GL_ALWAYS);
        set_color(ctx, shader_id, red);
        quad(ctx, [0.0, -1.0, 0.5], [1.0, 0.0, 0.5]);
        ctx.depth_func(self.compare_op);
        set_color(ctx, shader_id, green);
        quad(ctx, [0.0, -1.0, 0.3], [1.0, 0.0, 0.3]);

        // Lower right: two quads, d1 = 0, d2 = [-1..1]
        ctx.depth_func(glw::GL_ALWAYS);
        set_color(ctx, shader_id, red);
        quad(ctx, [0.0, 0.0, 0.0], [1.0, 1.0, 0.0]);
        ctx.depth_func(self.compare_op);
        set_color(ctx, shader_id, green);
        quad(ctx, [0.0, 0.0, -1.0], [1.0, 1.0, 1.0]);
    }
}

impl TestCase for DepthCompareCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DepthCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let clear_color = [0.125f32, 0.25, 0.5, 1.0];
        let rt = context.render_target();

        // Position & size for context
        let mut rnd = Random::new(de_string_hash(&self.name));

        let width = rt.width.min(128);
        let height = rt.height.min(128);
        let x = rnd.get_int(0, rt.width - width);
        let y = rnd.get_int(0, rt.height - height);

        let mut gles2_frame = Surface::new(width, height);
        let mut ref_frame = Surface::new(width, height);

        // Render using GLES2
        let gles2_error = {
            let mut gl_ctx = GLContext::new(&context.render_context, (x, y, width, height));

            gl_ctx.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
            gl_ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

            self.render(&mut gl_ctx); // Call actual render func
            gl_ctx.read_pixels(&mut gles2_frame, 0, 0, width, height);
            gl_ctx.get_error()
        };

        // Render reference image
        let ref_error = {
            let mut ref_ctx = create_reference_context_rgb8(context, width, height, rt.depth_bits)?;

            ref_ctx.clear_color(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
            ref_ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

            self.render(&mut ref_ctx);
            ref_ctx.read_pixels(&mut ref_frame, 0, 0, width, height);
            ref_ctx.get_error()
        };

        // Compare error codes
        let mut fail_reason: Option<&str> = None;
        let error_codes_ok = gles2_error == ref_error;
        if !error_codes_ok {
            fail_reason = Some("Got unexpected error");
        }

        // Compare images
        let threshold = 0.02f32;
        let images_ok = fuzzy_compare_ok(
            &ref_frame.get_const_access(),
            &gles2_frame.get_const_access(),
            threshold,
        )
        .unwrap_or(false);
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

/// `DepthTests::init`
pub fn create_tests(glsl: QuadRendererGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth");

    let cases: [(&str, GLenum); 8] = [
        ("cmp_always", glw::GL_ALWAYS),
        ("cmp_never", glw::GL_NEVER),
        ("cmp_equal", glw::GL_EQUAL),
        ("cmp_not_equal", glw::GL_NOTEQUAL),
        ("cmp_less_than", glw::GL_LESS),
        ("cmp_less_or_equal", glw::GL_LEQUAL),
        ("cmp_greater_than", glw::GL_GREATER),
        ("cmp_greater_or_equal", glw::GL_GEQUAL),
    ];
    for (name, compare_op) in cases {
        group.add_child(Box::new(DepthCompareCase {
            name: name.to_string(),
            glsl,
            compare_op,
        }) as Box<dyn TestCase>);
    }

    group
}
