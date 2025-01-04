// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboMultisampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.fbo.msaa`: `{2,4,8}_samples.*` and `renderbuffer_resize.*`.
//
// Narrowing: `sglr::ReferenceContext` stores a multisample renderbuffer single sample (it ignores `samples`), so the
// reference frame is the non-antialiased scene; the two frames then differ along quad edges and rely on the
// fuzzy/bilinear compare tolerance, where upstream's reference antialiases with its own sample positions.
// `renderbuffer_resize.*` is plain GL (an `ApiCase` upstream) and needs no reference.

use super::fbo_test_case::{
    FboRender, FboTestCase, check_error, check_format_support, check_framebuffer_status, check_sample_count,
};
use super::fbo_test_util::{
    FlatColorShader, GradientShader, get_format_name, get_format_threshold_gl, get_fragment_output_type, read_pixels,
    set_flat_color, set_gradient,
};
use crate::glu::texture_util::map_gl_internal_format;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::get_texture_format_info;
use crate::tcu::vector::Vec3;
use crate::tcu::{Random, Surface, TestError, TextureFormat};

const MIN_THRESHOLD: u8 = 12;

fn map_format(format: GLenum) -> Result<TextureFormat, TestError> {
    map_gl_internal_format(format).ok_or_else(|| TestError::Fail(format!("unknown internal format {format:#x}")))
}

fn color_threshold(format: GLenum) -> Option<[u8; 4]> {
    let t = get_format_threshold_gl(format).ok()?;
    Some([
        t[0].max(MIN_THRESHOLD),
        t[1].max(MIN_THRESHOLD),
        t[2].max(MIN_THRESHOLD),
        t[3].max(MIN_THRESHOLD),
    ])
}

fn scale_bias(c: [f32; 4], min: [f32; 4], max: [f32; 4]) -> [f32; 4] {
    [
        c[0] * (max[0] - min[0]) + min[0],
        c[1] * (max[1] - min[1]) + min[1],
        c[2] * (max[2] - min[2]) + min[2],
        c[3] * (max[3] - min[3]) + min[3],
    ]
}

/// `BasicFboMultisampleCase`
struct BasicFboMultisampleCase {
    color_format: GLenum,
    depth_stencil_format: GLenum,
    size: (i32, i32),
    num_samples: i32,
}

impl FboRender for BasicFboMultisampleCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.color_format)?;
        check_sample_count(context, self.color_format, self.num_samples)?;

        if self.depth_stencil_format != glw::GL_NONE {
            check_format_support(context, self.depth_stencil_format)?;
            check_sample_count(context, self.depth_stencil_format, self.num_samples)?;
        }
        Ok(())
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_fmt = map_format(self.color_format)?;
        let depth_stencil_fmt = if self.depth_stencil_format != glw::GL_NONE {
            Some(map_format(self.depth_stencil_format)?)
        } else {
            None
        };
        let color_fmt_info = get_texture_format_info(color_fmt);
        let (min, max) = (color_fmt_info.value_min, color_fmt_info.value_max);
        let depth = depth_stencil_fmt.is_some_and(|f| f.order.has_depth());
        let stencil = depth_stencil_fmt.is_some_and(|f| f.order.has_stencil());

        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(get_fragment_output_type(color_fmt))));
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(get_fragment_output_type(color_fmt))));

        let mut msaa_fbo = 0;
        let mut resolve_fbo = 0;

        // Create framebuffers.
        for ndx in 0..2 {
            let samples = if ndx == 1 { 0 } else { self.num_samples };
            let mut names = [0u32];

            ctx.gen_renderbuffers(&mut names);
            let color_rbo = names[0];
            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
            ctx.renderbuffer_storage_multisample(
                glw::GL_RENDERBUFFER,
                samples,
                self.color_format,
                self.size.0,
                self.size.1,
            );

            let mut depth_stencil_rbo = 0;
            if depth || stencil {
                ctx.gen_renderbuffers(&mut names);
                depth_stencil_rbo = names[0];
                ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil_rbo);
                ctx.renderbuffer_storage_multisample(
                    glw::GL_RENDERBUFFER,
                    samples,
                    self.depth_stencil_format,
                    self.size.0,
                    self.size.1,
                );
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
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

            if ndx == 1 {
                resolve_fbo = fbo;
            } else {
                msaa_fbo = fbo;
            }
        }

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, msaa_fbo);
        ctx.viewport(0, 0, self.size.0, self.size.1);

        // Clear depth and stencil buffers.
        ctx.clear_buffer_fi(glw::GL_DEPTH_STENCIL, 0, 1.0, 0);

        // Fill MSAA fbo with gradient, depth = [-1..1]
        ctx.enable(glw::GL_DEPTH_TEST);

        set_gradient(ctx, grad_shader_id, min, max);
        draw_quad(
            ctx,
            grad_shader_id,
            Vec3::new(-1.0, -1.0, -1.0),
            Vec3::new(1.0, 1.0, 1.0),
        );

        // Render random-colored quads.
        {
            let num_quads = 8;
            let mut rnd = Random::new(9);

            ctx.depth_func(glw::GL_ALWAYS);
            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_func(glw::GL_ALWAYS, 0, 0xff);
            ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_INCR);

            for _ in 0..num_quads {
                let r = rnd.get_float();
                let g = rnd.get_float();
                let b = rnd.get_float();
                let a = rnd.get_float();
                let x0 = rnd.get_float_range(-1.0, 1.0);
                let y0 = rnd.get_float_range(-1.0, 1.0);
                let z0 = rnd.get_float_range(-1.0, 1.0);
                let x1 = rnd.get_float_range(-1.0, 1.0);
                let y1 = rnd.get_float_range(-1.0, 1.0);
                let z1 = rnd.get_float_range(-1.0, 1.0);

                set_flat_color(ctx, flat_shader_id, scale_bias([r, g, b, a], min, max));
                draw_quad(ctx, flat_shader_id, Vec3::new(x0, y0, z0), Vec3::new(x1, y1, z1));
            }
        }

        ctx.disable(glw::GL_DEPTH_TEST);
        ctx.disable(glw::GL_STENCIL_TEST);

        check_error(ctx)?;

        // Resolve using glBlitFramebuffer().
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resolve_fbo);
        ctx.blit_framebuffer(
            0,
            0,
            self.size.0,
            self.size.1,
            0,
            0,
            self.size.0,
            self.size.1,
            glw::GL_COLOR_BUFFER_BIT
                | if depth { glw::GL_DEPTH_BUFFER_BIT } else { 0 }
                | if stencil { glw::GL_STENCIL_BUFFER_BIT } else { 0 },
            glw::GL_NEAREST,
        );
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resolve_fbo);

        if depth {
            // Visualize depth.
            let num_steps = 8;
            let step = 2.0 / num_steps as f32;

            ctx.enable(glw::GL_DEPTH_TEST);
            ctx.depth_func(glw::GL_LESS);
            ctx.depth_mask(false);
            ctx.color_mask(false, false, true, false);

            for ndx in 0..num_steps {
                let d = -1.0 + step * ndx as f32;
                let c = ndx as f32 / (num_steps - 1) as f32;

                set_flat_color(ctx, flat_shader_id, scale_bias([0.0, 0.0, c, 1.0], min, max));
                draw_quad(ctx, flat_shader_id, Vec3::new(-1.0, -1.0, d), Vec3::new(1.0, 1.0, d));
            }

            ctx.disable(glw::GL_DEPTH_TEST);
        }

        if stencil {
            // Visualize stencil.
            let num_steps = 4;
            let step = 1;

            ctx.enable(glw::GL_STENCIL_TEST);
            ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
            ctx.color_mask(false, true, false, false);

            for ndx in 0..num_steps {
                let s = step * ndx;
                let c = ndx as f32 / (num_steps - 1) as f32;

                ctx.stencil_func(glw::GL_EQUAL, s, 0xff);
                set_flat_color(ctx, flat_shader_id, scale_bias([0.0, c, 0.0, 1.0], min, max));
                draw_quad(
                    ctx,
                    flat_shader_id,
                    Vec3::new(-1.0, -1.0, 0.0),
                    Vec3::new(1.0, 1.0, 0.0),
                );
            }

            ctx.disable(glw::GL_STENCIL_TEST);
        }

        read_pixels(
            ctx,
            dst,
            0,
            0,
            self.size.0,
            self.size.1,
            color_fmt,
            color_fmt_info.look_up_scale,
            color_fmt_info.look_up_bias,
        )
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        if self.depth_stencil_format != glw::GL_NONE {
            return fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.05).unwrap_or(false);
        }

        // `colorCompare`
        let Some(threshold) = color_threshold(self.color_format) else {
            return false;
        };
        reference.get_const_access().size() == result.get_const_access().size()
            && bilinear_compare(
                &reference.get_const_access(),
                &result.get_const_access(),
                None,
                threshold,
            )
    }
}

/// `RenderbufferResizeCase::test`
fn renderbuffer_resize_case(case: &mut ApiCase<'_>, multisampled1: bool, multisampled2: bool) {
    const W1: i32 = 10;
    const H1: i32 = 10;
    const W2: i32 = 40;
    const H2: i32 = 40;

    let gl = case.gl();
    let mut max_samples = 0;

    // SAFETY: plain state and object calls on a current context; every pointer names a local that outlives the call.
    unsafe {
        gl.disable(glw::GL_DEPTH_TEST);

        gl.get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_RGBA8,
            glw::GL_SAMPLES,
            1,
            &mut max_samples,
        );
    }
    let samp1 = if multisampled1 { max_samples } else { 0 };
    let samp2 = if multisampled2 { max_samples } else { 0 };

    // Set up non-multisampled buffer to blit to and read back from.
    let mut fbo_resolve = 0u32;
    let mut rbo_resolve = 0u32;
    {
        // SAFETY: as above.
        let status = unsafe {
            gl.gen_framebuffers(1, &mut fbo_resolve);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_resolve);
            gl.gen_renderbuffers(1, &mut rbo_resolve);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_resolve);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, W2, H2);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo_resolve,
            );
            let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            let red = [1.0f32, 0.0, 0.0, 1.0];
            gl.clear_bufferfv(glw::GL_COLOR, 0, red.as_ptr());
            status
        };
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            case.fail("Resolve framebuffer is incomplete".to_string(), "Fail");
            return;
        }
    }

    case.expect_error(glw::GL_NO_ERROR);

    // Set up multisampled buffer to test.
    let mut fbo_multisampled = 0u32;
    let mut rbo_multisampled = 0u32;
    {
        // SAFETY: as above.
        let (status1, status2) = unsafe {
            gl.gen_framebuffers(1, &mut fbo_multisampled);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_multisampled);
            gl.gen_renderbuffers(1, &mut rbo_multisampled);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_multisampled);

            // Allocate,
            gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, samp1, glw::GL_RGBA8, W1, H1);

            // attach,
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo_multisampled,
            );
            let status1 = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);

            let blue = [0.0f32, 0.0, 1.0, 1.0];
            gl.clear_bufferfv(glw::GL_COLOR, 0, blue.as_ptr());

            // and allocate again with different parameters.
            gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, samp2, glw::GL_RGBA8, W2, H2);
            let status2 = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);

            let green = [0.0f32, 1.0, 0.0, 1.0];
            gl.clear_bufferfv(glw::GL_COLOR, 0, green.as_ptr());
            (status1, status2)
        };
        if status1 != glw::GL_FRAMEBUFFER_COMPLETE || status2 != glw::GL_FRAMEBUFFER_COMPLETE {
            case.fail("Multisampled framebuffer is incomplete".to_string(), "Fail");
            return;
        }
    }

    case.expect_error(glw::GL_NO_ERROR);

    // This is a blit from the multisampled buffer to the non-multisampled buffer.
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_multisampled);
        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_resolve);

        // Blit color from fboMultisampled (should be green) to fboResolve (should currently be red).
        gl.blit_framebuffer(0, 0, W2, H2, 0, 0, W2, H2, glw::GL_COLOR_BUFFER_BIT, glw::GL_NEAREST);

        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
    }

    case.expect_error(glw::GL_NO_ERROR);

    // fboResolve should now be green.
    let mut pixels = vec![0u8; (W2 * H2 * 4) as usize];
    // SAFETY: `pixels` holds exactly W2 * H2 RGBA8 pixels.
    unsafe {
        gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_resolve);
        gl.read_pixels(
            0,
            0,
            W2,
            H2,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            pixels.as_mut_ptr().cast::<std::ffi::c_void>(),
        );
    }

    case.expect_error(glw::GL_NO_ERROR);

    let Some(threshold) = color_threshold(glw::GL_RGBA8) else {
        case.fail("No threshold for GL_RGBA8".to_string(), "Fail");
        return;
    };
    let green = [0u8, 255, 0, 255];
    for pixel in pixels.as_chunks::<4>().0 {
        let ok = (0..4).all(|c| pixel[c].abs_diff(green[c]) <= threshold[c]);
        if !ok {
            case.fail(format!("Unexpected pixel {pixel:?}, expected green"), "Fail");
            return;
        }
    }
}

/// `FboMultisampleTests::init`
pub fn create_tests() -> TestCaseGroup {
    let color_formats: [GLenum; 16] = [
        // RGBA formats
        glw::GL_RGBA8,
        glw::GL_SRGB8_ALPHA8,
        glw::GL_RGB10_A2,
        glw::GL_RGBA4,
        glw::GL_RGB5_A1,
        // RGB formats
        glw::GL_RGB8,
        glw::GL_RGB565,
        // RG formats
        glw::GL_RG8,
        // R formats
        glw::GL_R8,
        // GL_EXT_color_buffer_float
        glw::GL_RGBA32F,
        glw::GL_RGBA16F,
        glw::GL_R11F_G11F_B10F,
        glw::GL_RG32F,
        glw::GL_RG16F,
        glw::GL_R32F,
        glw::GL_R16F,
    ];
    let depth_stencil_formats: [GLenum; 6] = [
        glw::GL_DEPTH_COMPONENT32F,
        glw::GL_DEPTH_COMPONENT24,
        glw::GL_DEPTH_COMPONENT16,
        glw::GL_DEPTH32F_STENCIL8,
        glw::GL_DEPTH24_STENCIL8,
        glw::GL_STENCIL_INDEX8,
    ];

    let mut group = TestCaseGroup::new("msaa");

    for samples in [2, 4, 8] {
        let mut sample_count_group = TestCaseGroup::new(format!("{samples}_samples"));

        // Color formats.
        for format in color_formats {
            sample_count_group.add_child(FboTestCase::new(
                get_format_name(format),
                BasicFboMultisampleCase {
                    color_format: format,
                    depth_stencil_format: glw::GL_NONE,
                    size: (119, 131),
                    num_samples: samples,
                },
            ));
        }

        // Depth/stencil formats.
        for format in depth_stencil_formats {
            sample_count_group.add_child(FboTestCase::new(
                get_format_name(format),
                BasicFboMultisampleCase {
                    color_format: glw::GL_RGBA8,
                    depth_stencil_format: format,
                    size: (119, 131),
                    num_samples: samples,
                },
            ));
        }

        group.add_child(sample_count_group);
    }

    // .renderbuffer_resize
    {
        let mut resize_group = TestCaseGroup::new("renderbuffer_resize");
        for (name, ms1, ms2) in [
            ("nonms_to_nonms", false, false),
            ("nonms_to_ms", false, true),
            ("ms_to_nonms", true, false),
            ("ms_to_ms", true, true),
        ] {
            add_api_case(&mut resize_group, name, move |case: &mut ApiCase<'_>| {
                renderbuffer_resize_case(case, ms1, ms2)
            });
        }
        group.add_child(resize_group);
    }

    group
}
