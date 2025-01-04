// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fRandomFragmentOpTests.cpp
//   modules/gles3/functional/es3fRandomFragmentOpTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The two upstream files differ only in the shader dialect, the `glu::ApiType` the random state is drawn for and
// the default compare threshold offset (6 vs 2), so this one port serves both. `NUM_ITERATIONS_PER_CASE` iterations
// run inside one `ApiCase` body (upstream returns `CONTINUE` between them) and stop at the first failure.
// Narrowing: no call log (`ENABLE_CALL_LOG`) and no base-seed command line option (it is 0 in this port).

use crate::gls::fragment_op_util::{
    IntegerQuad, Quad, QuadRenderer, QuadRendererGlslVersion, ReferenceQuadRenderer, get_multisample_access,
};
use crate::gls::interaction_test_util::{RenderCommand, RenderState, StencilState, compute_random_render_commands};
use crate::glu::{self, ApiCase, ApiType, TestCaseGroup, add_api_case};
use crate::glw;
use crate::rr::render_state::{
    BlendMode, BlendState as RrBlendState, FaceType, FragmentOperationState, StencilState as RrStencilState,
};
use crate::sglr::reference_utils::{map_gl_blend_equation, map_gl_blend_func, map_gl_stencil_op, map_gl_test_func};
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel, clear, clear_depth, clear_stencil};
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::UVec4;

const VIEWPORT_WIDTH: i32 = 64;
const VIEWPORT_HEIGHT: i32 = 64;
const NUM_CALLS_PER_ITERATION: usize = 3;
const NUM_ITERATIONS_PER_CASE: i32 = 10;

const CLEAR_COLOR: [f32; 4] = [0.25, 0.5, 0.75, 1.0];
const CLEAR_DEPTH: f32 = 1.0;
const CLEAR_STENCIL: i32 = 0;

/// `translateStencilState`
fn translate_stencil_state(src: &StencilState) -> Option<RrStencilState> {
    Some(RrStencilState {
        func: map_gl_test_func(src.function)?,
        reference: src.reference,
        comp_mask: src.compare_mask,
        s_fail: map_gl_stencil_op(src.stencil_fail_op)?,
        dp_fail: map_gl_stencil_op(src.depth_fail_op)?,
        dp_pass: map_gl_stencil_op(src.depth_pass_op)?,
        write_mask: src.write_mask,
    })
}

/// `translateBlendState`
fn translate_blend_state(src: &crate::gls::interaction_test_util::BlendState) -> Option<RrBlendState> {
    Some(RrBlendState {
        equation: map_gl_blend_equation(src.equation)?,
        src_func: map_gl_blend_func(src.src_func)?,
        dst_func: map_gl_blend_func(src.dst_func)?,
    })
}

/// `translateState`
#[allow(clippy::field_reassign_with_default)]
fn translate_state(src: &RenderState, depth_bits: i32, stencil_bits: i32) -> Option<FragmentOperationState> {
    let has_depth = depth_bits > 0;
    let has_stencil = stencil_bits > 0;
    let mut dst = FragmentOperationState::default();

    dst.scissor_test_enabled = src.scissor_test_enabled;
    dst.scissor_rectangle = src.scissor_rectangle;

    dst.stencil_test_enabled = has_stencil && src.stencil_test_enabled;
    dst.depth_test_enabled = has_depth && src.depth_test_enabled;
    dst.blend_mode = if src.blend_enabled {
        BlendMode::Standard
    } else {
        BlendMode::None
    };
    dst.num_stencil_bits = stencil_bits;

    dst.color_mask = src.color_mask;

    if dst.depth_test_enabled {
        dst.depth_func = map_gl_test_func(src.depth_func)?;
        dst.depth_mask = src.depth_write_mask;
    }

    if dst.stencil_test_enabled {
        dst.stencil_states[FaceType::Back as usize] = translate_stencil_state(&src.stencil[FaceType::Back as usize])?;
        dst.stencil_states[FaceType::Front as usize] = translate_stencil_state(&src.stencil[FaceType::Front as usize])?;
    }

    if src.blend_enabled {
        dst.blend_rgb_state = translate_blend_state(&src.blend_rgb_state)?;
        dst.blend_a_state = translate_blend_state(&src.blend_a_state)?;
        dst.blend_color = src.blend_color.m_data.map(|c| c.clamp(0.0, 1.0));
    }

    Some(dst)
}

/// `renderQuad`
#[allow(clippy::field_reassign_with_default)]
fn render_quad(gl: &glw::Functions, renderer: &QuadRenderer<'_>, quad: &IntegerQuad, base_x: i32, base_y: i32) {
    let flip_x = quad.pos_b[0] < quad.pos_a[0];
    let flip_y = quad.pos_b[1] < quad.pos_a[1];
    let viewport_x = quad.pos_a[0].min(quad.pos_b[0]);
    let viewport_y = quad.pos_a[1].min(quad.pos_b[1]);
    let viewport_w = (quad.pos_a[0] - quad.pos_b[0]).abs() + 1;
    let viewport_h = (quad.pos_a[1] - quad.pos_b[1]).abs() + 1;

    let mut translated = Quad::default();
    translated.color = quad.color;
    translated.pos_a = [if flip_x { 1.0 } else { -1.0 }, if flip_y { 1.0 } else { -1.0 }];
    translated.pos_b = [if flip_x { -1.0 } else { 1.0 }, if flip_y { -1.0 } else { 1.0 }];

    // \todo [2012-12-18 pyry] Pass in DepthRange parameters.
    for ndx in 0..translated.depth.len() {
        translated.depth[ndx] = quad.depth[ndx] * 2.0 - 1.0;
    }

    // SAFETY: plain viewport state on a current context.
    unsafe { gl.viewport(base_x + viewport_x, base_y + viewport_y, viewport_w, viewport_h) };
    renderer.render(gl, &translated);
}

fn gl_bool(v: bool) -> glw::GLboolean {
    if v { glw::TRUE } else { glw::FALSE }
}

/// `setGLState`
fn set_gl_state(gl: &glw::Functions, state: &RenderState, viewport_x: i32, viewport_y: i32) {
    // SAFETY: plain fragment-operation state on a current context.
    unsafe {
        if state.scissor_test_enabled {
            gl.enable(glw::GL_SCISSOR_TEST);
            gl.scissor(
                viewport_x + state.scissor_rectangle.left,
                viewport_y + state.scissor_rectangle.bottom,
                state.scissor_rectangle.width,
                state.scissor_rectangle.height,
            );
        } else {
            gl.disable(glw::GL_SCISSOR_TEST);
        }

        if state.stencil_test_enabled {
            gl.enable(glw::GL_STENCIL_TEST);

            for face in [FaceType::Front, FaceType::Back] {
                let gl_face = if face == FaceType::Back {
                    glw::GL_BACK
                } else {
                    glw::GL_FRONT
                };
                let s_params = &state.stencil[face as usize];

                gl.stencil_func_separate(gl_face, s_params.function, s_params.reference, s_params.compare_mask);
                gl.stencil_op_separate(
                    gl_face,
                    s_params.stencil_fail_op,
                    s_params.depth_fail_op,
                    s_params.depth_pass_op,
                );
                gl.stencil_mask_separate(gl_face, s_params.write_mask);
            }
        } else {
            gl.disable(glw::GL_STENCIL_TEST);
        }

        if state.depth_test_enabled {
            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_func(state.depth_func);
            gl.depth_mask(gl_bool(state.depth_write_mask));
        } else {
            gl.disable(glw::GL_DEPTH_TEST);
        }

        if state.blend_enabled {
            gl.enable(glw::GL_BLEND);
            gl.blend_equation_separate(state.blend_rgb_state.equation, state.blend_a_state.equation);
            gl.blend_func_separate(
                state.blend_rgb_state.src_func,
                state.blend_rgb_state.dst_func,
                state.blend_a_state.src_func,
                state.blend_a_state.dst_func,
            );
            gl.blend_color(
                state.blend_color.x(),
                state.blend_color.y(),
                state.blend_color.z(),
                state.blend_color.w(),
            );
        } else {
            gl.disable(glw::GL_BLEND);
        }

        if state.dither_enabled {
            gl.enable(glw::GL_DITHER);
        } else {
            gl.disable(glw::GL_DITHER);
        }

        gl.color_mask(
            gl_bool(state.color_mask[0]),
            gl_bool(state.color_mask[1]),
            gl_bool(state.color_mask[2]),
            gl_bool(state.color_mask[3]),
        );
    }
}

/// `tcu::copy` from the reference buffer's own format into RGBA8.
fn copy(dst: &mut PixelBufferAccess<'_>, src: &TextureLevel) {
    let src_access = src.get_const_access();
    let [width, height, _] = src.size();
    for y in 0..height {
        for x in 0..width {
            dst.set_pixel(src_access.get_pixel(x, y, 0), x, y, 0);
        }
    }
}

/// `RandomFragmentOpCase::getCompareThreshold`
fn get_compare_threshold(format: crate::tcu::PixelFormat, default_offset: u32) -> UVec4 {
    let base = format.get_color_threshold();
    let base = [
        base.get_red() as u32,
        base.get_green() as u32,
        base.get_blue() as u32,
        base.get_alpha() as u32,
    ];
    let is_8888 = format.red_bits == 8 && format.green_bits == 8 && format.blue_bits == 8 && format.alpha_bits == 8;
    let is_888 = format.red_bits == 8 && format.green_bits == 8 && format.blue_bits == 8 && format.alpha_bits == 0;

    if is_8888 || is_888 {
        UVec4::from_array(base.map(|c| c + default_offset))
    } else {
        // \note Non-scientific ad hoc formula. Need big threshold when few color bits; especially multiple blendings
        // bring extra inaccuracy.
        UVec4::from_array(base.map(|c| c * 5 + 2))
    }
}

/// `RandomFragmentOpCase::init` + `iterate`, all iterations.
fn random_fragment_op_case(
    case: &mut ApiCase<'_>,
    seed: u32,
    glsl: QuadRendererGlslVersion,
    api_type: ApiType,
    default_offset: u32,
) {
    let target = case.context().render_target();
    let width = target.width.min(VIEWPORT_WIDTH);
    let height = target.height.min(VIEWPORT_HEIGHT);
    let use_rgb = target.pixel_format().alpha_bits == 0;
    let is_msaa = target.num_samples > 1;

    let gl = case.gl();
    let renderer = match QuadRenderer::new(gl, glsl) {
        Ok(renderer) => renderer,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let color_format = TextureFormat::new(
        if use_rgb { ChannelOrder::RGB } else { ChannelOrder::RGBA },
        ChannelType::UNORM_INT8,
    );
    let depth_format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
    let stencil_format = TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT32);
    let rgba8 = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let (Ok(mut ref_color_buffer), Ok(mut ref_depth_buffer), Ok(mut ref_stencil_buffer)) = (
        TextureLevel::new(color_format, width as u32, height as u32, 1),
        TextureLevel::new(depth_format, width as u32, height as u32, 1),
        TextureLevel::new(stencil_format, width as u32, height as u32, 1),
    ) else {
        case.fail("Could not allocate the reference buffers".to_string(), "Fail");
        return;
    };
    let mut ref_renderer = ReferenceQuadRenderer::new();

    for iter_ndx in 0..NUM_ITERATIONS_PER_CASE {
        let iter_seed = de_int32_hash(seed as i32) ^ de_int32_hash(iter_ndx) ^ de_int32_hash(0);
        let mut rnd = Random::new(iter_seed);

        let viewport_x = rnd.get_int(0, target.width - width);
        let viewport_y = rnd.get_int(0, target.height - height);

        // Compute randomized rendering commands.
        let commands: Vec<RenderCommand> =
            compute_random_render_commands(&mut rnd, api_type, NUM_CALLS_PER_ITERATION, width, height);

        // Reset default fragment state.
        // SAFETY: plain state resets on a current context.
        unsafe {
            gl.disable(glw::GL_SCISSOR_TEST);
            gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
            gl.depth_mask(glw::TRUE);
            gl.stencil_mask(!0u32);

            // Render using GL.
            gl.clear_color(CLEAR_COLOR[0], CLEAR_COLOR[1], CLEAR_COLOR[2], CLEAR_COLOR[3]);
            gl.clear_depthf(CLEAR_DEPTH);
            gl.clear_stencil(CLEAR_STENCIL);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.viewport(viewport_x, viewport_y, width, height);
        }

        for cmd in &commands {
            set_gl_state(gl, &cmd.state, viewport_x, viewport_y);
            render_quad(gl, &renderer, &cmd.quad, viewport_x, viewport_y);
        }

        // Check error.
        // SAFETY: error query on a current context.
        let got_error = unsafe { gl.get_error() } != glw::GL_NO_ERROR;

        // SAFETY: as above.
        unsafe { gl.flush() };

        // Render reference while GPU is doing work.
        clear(&mut ref_color_buffer.get_access(), CLEAR_COLOR);
        clear_depth(&mut ref_depth_buffer.get_access(), CLEAR_DEPTH);
        clear_stencil(&mut ref_stencil_buffer.get_access(), CLEAR_STENCIL as u32);

        for cmd in &commands {
            let Some(ref_state) = translate_state(&cmd.state, target.depth_bits, target.stencil_bits) else {
                case.fail("Unmapped GL enum in the random render state".to_string(), "Fail");
                return;
            };

            ref_renderer.render(
                &mut get_multisample_access(ref_color_buffer.get_access()),
                Some(&mut get_multisample_access(ref_depth_buffer.get_access())),
                Some(&mut get_multisample_access(ref_stencil_buffer.get_access())),
                &cmd.quad,
                &ref_state,
            );
        }

        // Expand reference color buffer to RGBA8
        let (Ok(mut reference_img), Ok(mut rendered_img)) = (
            TextureLevel::new(rgba8, width as u32, height as u32, 1),
            TextureLevel::new(rgba8, width as u32, height as u32, 1),
        ) else {
            case.fail("Could not allocate the comparison images".to_string(), "Fail");
            return;
        };
        copy(&mut reference_img.get_access(), &ref_color_buffer);

        // Read rendered image.
        if let Err(e) = glu::pixel_transfer::read_pixels(
            &case.context().render_context,
            viewport_x,
            viewport_y,
            &mut rendered_img.get_access(),
        ) {
            case.fail(e.to_string(), "Fail");
            return;
        }

        // Compare to reference.
        let threshold = get_compare_threshold(target.pixel_format(), default_offset);
        let compare_ok = if is_msaa {
            // In MSAA cases, the sampling points could be anywhere in the pixel and we could even have multiple
            // samples that are combined in resolve. Allow arbitrary sample positions by using bilinearCompare.
            let t = threshold.m_data.map(|c| c.min(255) as u8);
            bilinear_compare(
                &reference_img.get_const_access(),
                &rendered_img.get_const_access(),
                None,
                t,
            )
        } else {
            int_threshold_compare(
                &reference_img.get_const_access(),
                &rendered_img.get_const_access(),
                threshold,
            )
            .ok
        };

        if !compare_ok {
            case.fail("Image comparison failed".to_string(), "Image comparison failed");
            return;
        }
        if got_error {
            case.fail("GL error".to_string(), "GL error");
            return;
        }
    }
}

/// `RandomFragmentOpTests::init` for either API.
pub fn create_tests(glsl: QuadRendererGlslVersion) -> TestCaseGroup {
    let (api_type, default_offset) = match glsl {
        QuadRendererGlslVersion::Es100 => (ApiType::es(2, 0), 6),
        QuadRendererGlslVersion::Es300 => (ApiType::es(3, 0), 2),
    };

    let mut group = TestCaseGroup::new("random");
    for ndx in 0..100u32 {
        let seed = ndx * NUM_ITERATIONS_PER_CASE as u32;
        add_api_case(&mut group, ndx.to_string(), move |case: &mut ApiCase<'_>| {
            random_fragment_op_case(case, seed, glsl, api_type, default_offset)
        });
    }
    group
}
