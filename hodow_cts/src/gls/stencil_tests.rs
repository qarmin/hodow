// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fStencilTests.cpp
//   modules/gles3/functional/es3fStencilTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream files differ only in the
// shader dialect, so one port serves both. Upstream's `STENCIL_CASE` macro (a local struct per
// case holding a static `genOps`) becomes one plain function per case behind a function pointer.
// No `tcu::TestLog`; the reference context is single sample.

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

#[derive(Clone, Copy, PartialEq, Eq)]
enum OpType {
    ClearStencil,
    ClearDepth,
    Quad,
}

/// `StencilOp`
#[derive(Clone, Copy)]
struct StencilOp {
    type_: OpType,
    stencil_test: GLenum,
    /// Ref for quad op, clear value for clears
    stencil: i32,
    stencil_mask: u32,
    depth_test: GLenum,
    /// Quad depth or clear value
    depth: f32,
    s_fail: GLenum,
    d_fail: GLenum,
    d_pass: GLenum,
}

impl StencilOp {
    fn new(type_: OpType) -> Self {
        Self {
            type_,
            stencil_test: glw::GL_ALWAYS,
            stencil: 0,
            stencil_mask: 0xffff_ffff,
            depth_test: glw::GL_ALWAYS,
            depth: 1.0,
            s_fail: glw::GL_KEEP,
            d_fail: glw::GL_KEEP,
            d_pass: glw::GL_KEEP,
        }
    }

    fn clear_stencil(stencil: i32) -> Self {
        let mut op = Self::new(OpType::ClearStencil);
        op.stencil = stencil;
        op
    }

    fn clear_depth(depth: f32) -> Self {
        let mut op = Self::new(OpType::ClearDepth);
        op.depth = depth;
        op
    }

    fn quad(
        stencil_test: GLenum,
        stencil: i32,
        depth_test: GLenum,
        depth: f32,
        s_fail: GLenum,
        d_fail: GLenum,
        d_pass: GLenum,
    ) -> Self {
        Self {
            type_: OpType::Quad,
            stencil_test,
            stencil,
            stencil_mask: 0xffff_ffff,
            depth_test,
            depth,
            s_fail,
            d_fail,
            d_pass,
        }
    }
}

type GenStencilOpsFunc = fn(&mut Vec<StencilOp>, i32, i32, i32);

/// `StencilCase` + `SimpleStencilCase`
struct StencilCase {
    name: String,
    glsl: QuadRendererGlslVersion,
    gen_ops: GenStencilOpsFunc,
}

impl StencilCase {
    /// `StencilCase::executeOps`
    fn execute_ops(&self, ctx: &mut dyn SglrContext, shader_id: u32, cell: [i32; 4], ops: &[StencilOp]) {
        // For quadOps
        let (width, height) = (ctx.get_width(), ctx.get_height());
        let x0 = 2.0 * (cell[0] as f32 / width as f32) - 1.0;
        let y0 = 2.0 * (cell[1] as f32 / height as f32) - 1.0;
        let x1 = x0 + 2.0 * (cell[2] as f32 / width as f32);
        let y1 = y0 + 2.0 * (cell[3] as f32 / height as f32);

        set_color(ctx, shader_id, [0.0, 0.0, 0.0, 1.0]);

        for op in ops {
            match op.type_ {
                OpType::ClearDepth => {
                    ctx.enable(glw::GL_SCISSOR_TEST);
                    ctx.scissor(cell[0], cell[1], cell[2], cell[3]);
                    ctx.clear_depthf(op.depth);
                    ctx.clear(glw::GL_DEPTH_BUFFER_BIT);
                    ctx.disable(glw::GL_SCISSOR_TEST);
                }
                OpType::ClearStencil => {
                    ctx.enable(glw::GL_SCISSOR_TEST);
                    ctx.scissor(cell[0], cell[1], cell[2], cell[3]);
                    ctx.clear_stencil(op.stencil);
                    ctx.clear(glw::GL_STENCIL_BUFFER_BIT);
                    ctx.disable(glw::GL_SCISSOR_TEST);
                }
                OpType::Quad => {
                    ctx.enable(glw::GL_DEPTH_TEST);
                    ctx.enable(glw::GL_STENCIL_TEST);
                    ctx.depth_func(op.depth_test);
                    ctx.stencil_func(op.stencil_test, op.stencil, op.stencil_mask);
                    ctx.stencil_op(op.s_fail, op.d_fail, op.d_pass);
                    draw_quad(ctx, shader_id, Vec3::new(x0, y0, op.depth), Vec3::new(x1, y1, op.depth));
                    ctx.disable(glw::GL_STENCIL_TEST);
                    ctx.disable(glw::GL_DEPTH_TEST);
                }
            }
        }
    }

    /// `StencilCase::visualizeStencil`
    fn visualize_stencil(&self, ctx: &mut dyn SglrContext, shader_id: u32, stencil_bits: i32, stencil_step: i32) {
        let end_val = 1i32 << stencil_bits;
        let num_stencil_values = end_val / stencil_step + 1;

        ctx.enable(glw::GL_STENCIL_TEST);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);

        for ndx in 0..num_stencil_values {
            let value = (ndx * stencil_step).min(end_val - 1);
            let color_mix = value as f32 / (end_val - 1).max(1) as f32;
            let color = [0.0f32, 1.0 - color_mix, color_mix, 1.0];

            set_color(ctx, shader_id, color);
            ctx.stencil_func(glw::GL_EQUAL, value, 0xffff_ffff);
            draw_quad(ctx, shader_id, Vec3::new(-1.0, -1.0, 0.0), Vec3::new(1.0, 1.0, 0.0));
        }
    }

    fn execute(
        &self,
        ctx: &mut dyn SglrContext,
        ops: &[Vec<StencilOp>],
        cells: &[[i32; 4]],
        stencil_bits: i32,
        stencil_step: i32,
    ) {
        let shader_id = ctx.create_program(Box::new(UniformColorShader::new(self.glsl, true)));

        ctx.clear_color(1.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

        for (ndx, op_list) in ops.iter().enumerate() {
            self.execute_ops(ctx, shader_id, cells[ndx], op_list);
        }

        self.visualize_stencil(ctx, shader_id, stencil_bits, stencil_step);
    }
}

impl TestCase for StencilCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `StencilCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let rt = context.render_target();
        let depth_bits = rt.depth_bits;
        let stencil_bits = rt.stencil_bits;

        let stencil_step = if stencil_bits == 8 { 8 } else { 1 };
        let num_stencil_values = (1i32 << stencil_bits) / stencil_step + 1;
        let grid_size = ((num_stencil_values + 2) as f32).sqrt().ceil() as i32;

        let width = rt.width.min(128);
        let height = rt.height.min(128);

        let mut rnd = Random::new(de_string_hash(&self.name));
        let viewport_x = rnd.get_int(0, rt.width - width);
        let viewport_y = rnd.get_int(0, rt.height - height);

        let mut gles2_frame = Surface::new(width, height);
        let mut ref_frame = Surface::new(width, height);

        // Get ops for stencil values
        let mut ops: Vec<Vec<StencilOp>> = vec![Vec::new(); (num_stencil_values + 2) as usize];
        {
            // Values from 0 to max
            for ndx in 0..num_stencil_values {
                (self.gen_ops)(
                    &mut ops[ndx as usize],
                    stencil_bits,
                    depth_bits,
                    (ndx * stencil_step).min((1i32 << stencil_bits) - 1),
                );
            }

            // -1 and max+1
            (self.gen_ops)(
                &mut ops[(num_stencil_values) as usize],
                stencil_bits,
                depth_bits,
                1i32 << stencil_bits,
            );
            (self.gen_ops)(
                &mut ops[(num_stencil_values + 1) as usize],
                stencil_bits,
                depth_bits,
                -1,
            );
        }

        // Compute cells: (x, y, w, h)
        let mut cells: Vec<[i32; 4]> = Vec::new();
        let cell_width = width / grid_size;
        let cell_height = height / grid_size;
        for y in 0..grid_size {
            for x in 0..grid_size {
                cells.push([x * cell_width, y * cell_height, cell_width, cell_height]);
            }
        }
        debug_assert!(ops.len() <= cells.len());

        // Execute for gles2 context
        let gles2_error = {
            let mut gl_ctx = GLContext::new(&context.render_context, (viewport_x, viewport_y, width, height));
            self.execute(&mut gl_ctx, &ops, &cells, stencil_bits, stencil_step);
            let error = gl_ctx.get_error();
            gl_ctx.read_pixels(&mut gles2_frame, 0, 0, width, height);
            error
        };

        // Execute for reference context
        {
            let mut ref_ctx = create_reference_context_rgb8(context, width, height, rt.depth_bits)?;
            self.execute(&mut ref_ctx, &ops, &cells, stencil_bits, stencil_step);
            ref_ctx.read_pixels(&mut ref_frame, 0, 0, width, height);
        }

        // Check error
        let mut fail_reason: Option<&str> = None;
        let error_code_ok = gles2_error == glw::GL_NO_ERROR;
        if !error_code_ok {
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

        if error_code_ok && images_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(fail_reason.unwrap_or("Image comparison failed")))
        }
    }
}

// The cases' `genOps` bodies. `stencil_bits`/`depth_bits` are unused by some, as upstream's
// `DE_UNREF(stencilBits && depthBits)` allows.

fn gen_clear(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    // \note Unused bits are set to 1, clear should mask them out
    let mask = (1i32 << stencil_bits) - 1;
    dst.push(StencilOp::clear_stencil(target_stencil | !mask));
}

fn gen_stencil_fail_replace(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    dst.push(StencilOp::quad(
        glw::GL_NEVER,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_REPLACE,
        glw::GL_KEEP,
        glw::GL_KEEP,
    ));
}

fn gen_depth_fail_replace(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    dst.push(StencilOp::clear_depth(0.0));
    dst.push(StencilOp::quad(
        glw::GL_ALWAYS,
        target_stencil,
        glw::GL_LESS,
        0.5,
        glw::GL_KEEP,
        glw::GL_REPLACE,
        glw::GL_KEEP,
    ));
}

fn gen_depth_pass_replace(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    dst.push(StencilOp::quad(
        glw::GL_ALWAYS,
        target_stencil,
        glw::GL_LESS,
        0.0,
        glw::GL_KEEP,
        glw::GL_KEEP,
        glw::GL_REPLACE,
    ));
}

fn gen_incr_stencil_fail(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    if target_stencil > 0 {
        dst.push(StencilOp::clear_stencil(target_stencil - 1));
        dst.push(StencilOp::quad(
            glw::GL_EQUAL,
            target_stencil,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_INCR,
            glw::GL_KEEP,
            glw::GL_KEEP,
        ));
    } else {
        dst.push(StencilOp::clear_stencil(target_stencil));
    }
}

fn gen_decr_stencil_fail(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let max_stencil = (1i32 << stencil_bits) - 1;
    if target_stencil < max_stencil {
        dst.push(StencilOp::clear_stencil(target_stencil + 1));
        dst.push(StencilOp::quad(
            glw::GL_EQUAL,
            target_stencil,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_DECR,
            glw::GL_KEEP,
            glw::GL_KEEP,
        ));
    } else {
        dst.push(StencilOp::clear_stencil(target_stencil));
    }
}

fn gen_incr_wrap_stencil_fail(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let max_stencil = (1i32 << stencil_bits) - 1;
    dst.push(StencilOp::clear_stencil((target_stencil - 1) & max_stencil));
    dst.push(StencilOp::quad(
        glw::GL_EQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_INCR_WRAP,
        glw::GL_KEEP,
        glw::GL_KEEP,
    ));
}

fn gen_decr_wrap_stencil_fail(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let max_stencil = (1i32 << stencil_bits) - 1;
    dst.push(StencilOp::clear_stencil((target_stencil + 1) & max_stencil));
    dst.push(StencilOp::quad(
        glw::GL_EQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_DECR_WRAP,
        glw::GL_KEEP,
        glw::GL_KEEP,
    ));
}

fn gen_zero_stencil_fail(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    dst.push(StencilOp::clear_stencil(target_stencil));
    dst.push(StencilOp::quad(
        glw::GL_NOTEQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_ZERO,
        glw::GL_KEEP,
        glw::GL_KEEP,
    ));
    dst.push(StencilOp::quad(
        glw::GL_EQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_REPLACE,
        glw::GL_KEEP,
        glw::GL_KEEP,
    ));
}

fn gen_invert_stencil_fail(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let mask = (1i32 << stencil_bits) - 1;
    dst.push(StencilOp::clear_stencil((!target_stencil) & mask));
    dst.push(StencilOp::quad(
        glw::GL_EQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_INVERT,
        glw::GL_KEEP,
        glw::GL_KEEP,
    ));
}

fn gen_cmp_equal(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let mask = (1i32 << stencil_bits) - 1;
    let inv = (!target_stencil) & mask;
    dst.push(StencilOp::clear_stencil(inv));
    dst.push(StencilOp::quad(
        glw::GL_EQUAL,
        inv,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_KEEP,
        glw::GL_KEEP,
        glw::GL_INVERT,
    ));
    dst.push(StencilOp::quad(
        glw::GL_EQUAL,
        inv,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_KEEP,
        glw::GL_KEEP,
        glw::GL_INVERT,
    ));
}

fn gen_cmp_not_equal(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let mask = (1i32 << stencil_bits) - 1;
    let inv = (!target_stencil) & mask;
    dst.push(StencilOp::clear_stencil(inv));
    dst.push(StencilOp::quad(
        glw::GL_NOTEQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_KEEP,
        glw::GL_KEEP,
        glw::GL_INVERT,
    ));
    dst.push(StencilOp::quad(
        glw::GL_NOTEQUAL,
        target_stencil,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_KEEP,
        glw::GL_KEEP,
        glw::GL_INVERT,
    ));
}

fn gen_cmp_less_than(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let max_stencil = (1i32 << stencil_bits) - 1;
    if target_stencil < max_stencil {
        dst.push(StencilOp::clear_stencil(target_stencil + 1));
        dst.push(StencilOp::quad(
            glw::GL_LESS,
            target_stencil,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_DECR,
        ));
        dst.push(StencilOp::quad(
            glw::GL_LESS,
            target_stencil,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_DECR,
        ));
    } else {
        dst.push(StencilOp::clear_stencil(target_stencil));
    }
}

fn gen_cmp_less_or_equal(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let max_stencil = (1i32 << stencil_bits) - 1;
    if target_stencil < max_stencil {
        dst.push(StencilOp::clear_stencil(target_stencil + 1));
        dst.push(StencilOp::quad(
            glw::GL_LEQUAL,
            target_stencil + 1,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_DECR,
        ));
        dst.push(StencilOp::quad(
            glw::GL_LEQUAL,
            target_stencil + 1,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_DECR,
        ));
    } else {
        dst.push(StencilOp::clear_stencil(target_stencil));
    }
}

fn gen_cmp_greater_than(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    if target_stencil > 0 {
        dst.push(StencilOp::clear_stencil(target_stencil - 1));
        dst.push(StencilOp::quad(
            glw::GL_GREATER,
            target_stencil,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_INCR,
        ));
        dst.push(StencilOp::quad(
            glw::GL_GREATER,
            target_stencil,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_INCR,
        ));
    } else {
        dst.push(StencilOp::clear_stencil(target_stencil));
    }
}

fn gen_cmp_greater_or_equal(dst: &mut Vec<StencilOp>, _stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    if target_stencil > 0 {
        dst.push(StencilOp::clear_stencil(target_stencil - 1));
        dst.push(StencilOp::quad(
            glw::GL_GEQUAL,
            target_stencil - 1,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_INCR,
        ));
        dst.push(StencilOp::quad(
            glw::GL_GEQUAL,
            target_stencil - 1,
            glw::GL_ALWAYS,
            0.0,
            glw::GL_KEEP,
            glw::GL_KEEP,
            glw::GL_INCR,
        ));
    } else {
        dst.push(StencilOp::clear_stencil(target_stencil));
    }
}

fn gen_cmp_mask_equal(dst: &mut Vec<StencilOp>, stencil_bits: i32, _depth_bits: i32, target_stencil: i32) {
    let val_mask = (1i32 << stencil_bits) - 1;
    let mask = (1i32 << 7) | (1i32 << 5) | (1i32 << 3) | (1i32 << 1);

    dst.push(StencilOp::clear_stencil(!target_stencil));

    let mut op = StencilOp::quad(
        glw::GL_EQUAL,
        (!target_stencil | !mask) & val_mask,
        glw::GL_ALWAYS,
        0.0,
        glw::GL_KEEP,
        glw::GL_KEEP,
        glw::GL_INVERT,
    );
    op.stencil_mask = mask as u32;
    dst.push(op);
}

/// `StencilTests::init`
pub fn create_tests(glsl: QuadRendererGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("stencil");

    let cases: [(&str, GenStencilOpsFunc); 17] = [
        ("clear", gen_clear),
        // Replace in different points
        ("stencil_fail_replace", gen_stencil_fail_replace),
        ("depth_fail_replace", gen_depth_fail_replace),
        ("depth_pass_replace", gen_depth_pass_replace),
        // Increment, decrement
        ("incr_stencil_fail", gen_incr_stencil_fail),
        ("decr_stencil_fail", gen_decr_stencil_fail),
        ("incr_wrap_stencil_fail", gen_incr_wrap_stencil_fail),
        ("decr_wrap_stencil_fail", gen_decr_wrap_stencil_fail),
        // Zero, Invert
        ("zero_stencil_fail", gen_zero_stencil_fail),
        ("invert_stencil_fail", gen_invert_stencil_fail),
        // Comparison modes
        ("cmp_equal", gen_cmp_equal),
        ("cmp_not_equal", gen_cmp_not_equal),
        ("cmp_less_than", gen_cmp_less_than),
        ("cmp_less_or_equal", gen_cmp_less_or_equal),
        ("cmp_greater_than", gen_cmp_greater_than),
        ("cmp_greater_or_equal", gen_cmp_greater_or_equal),
        ("cmp_mask_equal", gen_cmp_mask_equal),
    ];
    for (name, gen_ops) in cases.iter() {
        group.add_child(Box::new(StencilCase {
            name: name.to_string(),
            glsl,
            gen_ops: *gen_ops,
        }) as Box<dyn TestCase>);
    }

    group
}
