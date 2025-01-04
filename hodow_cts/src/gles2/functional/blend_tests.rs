// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fBlendTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The verdict needs no rasterised reference: the geometry is one screen-aligned quad,
// so `gls::fragment_op_util::ReferenceQuadRenderer` enumerates its pixels on the host
// and runs each through `rr::FragmentProcessor`. The case draws the quad twice - once
// with blending off to establish the destination, once with it on - and compares the
// two images with `tcu::intThresholdCompare`.

use crate::gls::fragment_op_util::{
    IntegerQuad, Quad, QuadRenderer, QuadRendererGlslVersion, ReferenceQuadRenderer, get_multisample_access,
};
use crate::glu::{self, ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::rr::render_state::{BlendMode, FragmentOperationState};
use crate::sglr::reference_utils::{map_gl_blend_equation, map_gl_blend_func};
use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel};
use crate::tcu::random::{Random, de_int32_hash, de_string_hash};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::UVec4;

const MAX_VIEWPORT_WIDTH: i32 = 64;
const MAX_VIEWPORT_HEIGHT: i32 = 64;

/// `BlendParams`
#[derive(Debug, Clone, Copy)]
struct BlendParams {
    equation_rgb: GLenum,
    src_func_rgb: GLenum,
    dst_func_rgb: GLenum,
    equation_alpha: GLenum,
    src_func_alpha: GLenum,
    dst_func_alpha: GLenum,
    blend_color: [f32; 4],
}

/// `BlendCase::init` - the two quads every case draws, plus their host-side twins.
fn make_quads(viewport_w: i32, viewport_h: i32) -> (Quad, Quad, IntegerQuad, IntegerQuad) {
    const BASE_GRADIENT_COLORS: [[f32; 4]; 4] = [
        [0.0, 0.5, 1.0, 0.5],
        [0.5, 0.0, 0.5, 1.0],
        [0.5, 1.0, 0.5, 0.0],
        [1.0, 0.5, 0.0, 0.5],
    ];

    let mut first_quad = Quad::default();
    let mut second_quad = Quad::default();
    let mut first_quad_int = IntegerQuad::default();
    let mut second_quad_int = IntegerQuad::default();

    for (i, base) in BASE_GRADIENT_COLORS.iter().enumerate() {
        for (c, &b) in base.iter().enumerate() {
            first_quad.color[i][c] = (b - 0.5) * 0.2 + 0.5;
            second_quad.color[i][c] = (1.0 - b - 0.5) * 1.0 + 0.5;
        }
        first_quad_int.color[i] = first_quad.color[i];
        second_quad_int.color[i] = second_quad.color[i];
    }

    first_quad_int.pos_a = [0, 0];
    second_quad_int.pos_a = [0, 0];
    first_quad_int.pos_b = [viewport_w - 1, viewport_h - 1];
    second_quad_int.pos_b = [viewport_w - 1, viewport_h - 1];

    (first_quad, second_quad, first_quad_int, second_quad_int)
}

/// `BlendCase::iterate`, run once per parameter set - upstream returns `CONTINUE` and is
/// re-entered, which is the same loop with the case object's state carried across.
fn blend_case(case: &mut ApiCase<'_>, name_hash: u32, param_sets: &[BlendParams]) {
    let target = case.context().render_target();
    let use_rgb = target.pixel_format().alpha_bits == 0;

    let viewport_w = target.width.min(MAX_VIEWPORT_WIDTH);
    let viewport_h = target.height.min(MAX_VIEWPORT_HEIGHT);

    let (first_quad, second_quad, first_quad_int, second_quad_int) = make_quads(viewport_w, viewport_h);

    let gl = case.gl();
    let renderer = match QuadRenderer::new(gl, QuadRendererGlslVersion::Es100) {
        Ok(renderer) => renderer,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };
    let mut reference_renderer = ReferenceQuadRenderer::new();
    let ref_format = TextureFormat::new(
        if use_rgb { ChannelOrder::RGB } else { ChannelOrder::RGBA },
        ChannelType::UNORM_INT8,
    );
    let mut ref_color_buffer = match TextureLevel::new(ref_format, viewport_w as u32, viewport_h as u32, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let rgba8 = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);

    for (cur_param_set_ndx, param_set) in param_sets.iter().enumerate() {
        let mut rnd = Random::new(name_hash ^ de_int32_hash(cur_param_set_ndx as i32));
        let viewport_x = rnd.get_int(0, target.width - viewport_w);
        let viewport_y = rnd.get_int(0, target.height - viewport_h);
        let mut reference_state = FragmentOperationState::default();

        // Log the blend parameters. Upstream names each enum through
        // `glu::getBlendEquationName`/`getBlendFactorName`; neither is ported, and the
        // raw value says the same thing in a log nobody reads unless a case fails.
        log::debug!(
            "RGB equation = {:#06x}, src func = {:#06x}, dst func = {:#06x}",
            param_set.equation_rgb,
            param_set.src_func_rgb,
            param_set.dst_func_rgb
        );
        log::debug!(
            "Alpha equation = {:#06x}, src func = {:#06x}, dst func = {:#06x}",
            param_set.equation_alpha,
            param_set.src_func_alpha,
            param_set.dst_func_alpha
        );
        log::debug!("Blend color = {:?}", param_set.blend_color);

        // Set GL state.
        // SAFETY: plain blend state on a current context.
        unsafe {
            gl.blend_equation_separate(param_set.equation_rgb, param_set.equation_alpha);
            gl.blend_func_separate(
                param_set.src_func_rgb,
                param_set.dst_func_rgb,
                param_set.src_func_alpha,
                param_set.dst_func_alpha,
            );
            gl.blend_color(
                param_set.blend_color[0],
                param_set.blend_color[1],
                param_set.blend_color[2],
                param_set.blend_color[3],
            );
        }
        if let Err(e) = glu::expect_no_error(gl, "set blend state") {
            case.fail(e.to_string(), "Fail");
            return;
        }

        // Set reference state.
        let (Some(eq_rgb), Some(src_rgb), Some(dst_rgb), Some(eq_a), Some(src_a), Some(dst_a)) = (
            map_gl_blend_equation(param_set.equation_rgb),
            map_gl_blend_func(param_set.src_func_rgb),
            map_gl_blend_func(param_set.dst_func_rgb),
            map_gl_blend_equation(param_set.equation_alpha),
            map_gl_blend_func(param_set.src_func_alpha),
            map_gl_blend_func(param_set.dst_func_alpha),
        ) else {
            case.fail("Unmapped blend enum".to_string(), "Fail");
            return;
        };
        reference_state.blend_rgb_state.equation = eq_rgb;
        reference_state.blend_rgb_state.src_func = src_rgb;
        reference_state.blend_rgb_state.dst_func = dst_rgb;
        reference_state.blend_a_state.equation = eq_a;
        reference_state.blend_a_state.src_func = src_a;
        reference_state.blend_a_state.dst_func = dst_a;
        reference_state.blend_color = param_set.blend_color;

        // Render with GL.
        // SAFETY: plain draw state on a current context.
        unsafe {
            gl.disable(glw::GL_BLEND);
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
        }
        renderer.render(gl, &first_quad);
        // SAFETY: as above.
        unsafe { gl.enable(glw::GL_BLEND) };
        renderer.render(gl, &second_quad);
        // SAFETY: as above.
        unsafe { gl.flush() };

        // Render reference.
        reference_state.blend_mode = BlendMode::None;
        reference_renderer.render(
            &mut get_multisample_access(ref_color_buffer.get_access()),
            None,
            None,
            &first_quad_int,
            &reference_state,
        );
        reference_state.blend_mode = BlendMode::Standard;
        reference_renderer.render(
            &mut get_multisample_access(ref_color_buffer.get_access()),
            None,
            None,
            &second_quad_int,
            &reference_state,
        );

        // Expand reference color buffer to RGBA8
        let mut reference_img = match TextureLevel::new(rgba8, viewport_w as u32, viewport_h as u32, 1) {
            Ok(level) => level,
            Err(e) => {
                case.fail(e.to_string(), "Fail");
                return;
            }
        };
        copy(&mut reference_img.get_access(), &ref_color_buffer);

        // Read GL image.
        let mut rendered_img = match TextureLevel::new(rgba8, viewport_w as u32, viewport_h as u32, 1) {
            Ok(level) => level,
            Err(e) => {
                case.fail(e.to_string(), "Fail");
                return;
            }
        };
        if let Err(e) = glu::pixel_transfer::read_pixels(
            &case.context().render_context,
            viewport_x,
            viewport_y,
            &mut rendered_img.get_access(),
        ) {
            case.fail(e.to_string(), "Fail");
            return;
        }

        // Compare images.
        // \note Non-scientific ad hoc formula. Need big threshold when few color bits;
        // blending brings extra inaccuracy.
        let base = target.pixel_format().get_color_threshold();
        let scale = |v: i32| (v as u32) * 5 / 2 + 3;
        let compare_threshold = UVec4::from_array([
            scale(base.get_red()),
            scale(base.get_green()),
            scale(base.get_blue()),
            scale(base.get_alpha()),
        ]);

        let result = int_threshold_compare(
            &reference_img.get_const_access(),
            &rendered_img.get_const_access(),
            compare_threshold,
        );
        if !result.ok {
            case.fail("Image compare failed".to_string(), "Image compare failed");
            return;
        }
    }
}

/// `tcu::copy` from the reference buffer's own format into RGBA8 - the expansion
/// upstream writes as `copy(referenceImg.getAccess(), m_refColorBuffer->getAccess())`.
fn copy(dst: &mut PixelBufferAccess<'_>, src: &TextureLevel) {
    let src_access = src.get_const_access();
    let [width, height, _] = src.size();
    for y in 0..height {
        for x in 0..width {
            dst.set_pixel(src_access.get_pixel(x, y, 0), x, y, 0);
        }
    }
}

struct EnumGl {
    gl_value: GLenum,
    name_str: &'static str,
}

const BLEND_EQUATIONS: [EnumGl; 3] = [
    EnumGl {
        gl_value: glw::GL_FUNC_ADD,
        name_str: "add",
    },
    EnumGl {
        gl_value: glw::GL_FUNC_SUBTRACT,
        name_str: "subtract",
    },
    EnumGl {
        gl_value: glw::GL_FUNC_REVERSE_SUBTRACT,
        name_str: "reverse_subtract",
    },
];

const BLEND_FUNCTIONS: [EnumGl; 15] = [
    EnumGl {
        gl_value: glw::GL_ZERO,
        name_str: "zero",
    },
    EnumGl {
        gl_value: glw::GL_ONE,
        name_str: "one",
    },
    EnumGl {
        gl_value: glw::GL_SRC_COLOR,
        name_str: "src_color",
    },
    EnumGl {
        gl_value: glw::GL_ONE_MINUS_SRC_COLOR,
        name_str: "one_minus_src_color",
    },
    EnumGl {
        gl_value: glw::GL_DST_COLOR,
        name_str: "dst_color",
    },
    EnumGl {
        gl_value: glw::GL_ONE_MINUS_DST_COLOR,
        name_str: "one_minus_dst_color",
    },
    EnumGl {
        gl_value: glw::GL_SRC_ALPHA,
        name_str: "src_alpha",
    },
    EnumGl {
        gl_value: glw::GL_ONE_MINUS_SRC_ALPHA,
        name_str: "one_minus_src_alpha",
    },
    EnumGl {
        gl_value: glw::GL_DST_ALPHA,
        name_str: "dst_alpha",
    },
    EnumGl {
        gl_value: glw::GL_ONE_MINUS_DST_ALPHA,
        name_str: "one_minus_dst_alpha",
    },
    EnumGl {
        gl_value: glw::GL_CONSTANT_COLOR,
        name_str: "constant_color",
    },
    EnumGl {
        gl_value: glw::GL_ONE_MINUS_CONSTANT_COLOR,
        name_str: "one_minus_constant_color",
    },
    EnumGl {
        gl_value: glw::GL_CONSTANT_ALPHA,
        name_str: "constant_alpha",
    },
    EnumGl {
        gl_value: glw::GL_ONE_MINUS_CONSTANT_ALPHA,
        name_str: "one_minus_constant_alpha",
    },
    EnumGl {
        gl_value: glw::GL_SRC_ALPHA_SATURATE,
        name_str: "src_alpha_saturate",
    },
];

const DEFAULT_BLEND_COLOR: [f32; 4] = [0.2, 0.4, 0.6, 0.8];

/// Registers one case; `name` is also its rng seed, as `deStringHash(getName())`.
fn add_blend_case(group: &mut TestCaseGroup, name: String, param_sets: Vec<BlendParams>) {
    let name_hash = de_string_hash(&name);
    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        blend_case(case, name_hash, &param_sets)
    });
}

/// `BlendTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("blend");

    // Test all blend equation, src blend function, dst blend function combinations. RGB and alpha modes are the same.
    {
        let mut sub = TestCaseGroup::new("equation_src_func_dst_func");

        for eq in &BLEND_EQUATIONS {
            for src in &BLEND_FUNCTIONS {
                for dst in &BLEND_FUNCTIONS {
                    if dst.gl_value == glw::GL_SRC_ALPHA_SATURATE {
                        // SRC_ALPHA_SATURATE is only valid for src func.
                        continue;
                    }

                    let name = format!("{}_{}_{}", eq.name_str, src.name_str, dst.name_str);
                    let param_sets = vec![BlendParams {
                        equation_rgb: eq.gl_value,
                        src_func_rgb: src.gl_value,
                        dst_func_rgb: dst.gl_value,
                        equation_alpha: eq.gl_value,
                        src_func_alpha: src.gl_value,
                        dst_func_alpha: dst.gl_value,
                        blend_color: DEFAULT_BLEND_COLOR,
                    }];

                    add_blend_case(&mut sub, name, param_sets);
                }
            }
        }

        group.add_child(sub);
    }

    // Test all RGB src, alpha src and RGB dst, alpha dst combinations. Equations are ADD.
    // \note For all RGB src, alpha src combinations, also test a couple of different RGBA dst functions, and vice versa.
    {
        let mut main_group = TestCaseGroup::new("rgb_func_alpha_func");
        let mut src_group = TestCaseGroup::new("src");
        let mut dst_group = TestCaseGroup::new("dst");

        for is_dst_i in 0..=1 {
            for func_rgb in &BLEND_FUNCTIONS {
                for func_alpha in &BLEND_FUNCTIONS {
                    let is_src = is_dst_i == 0;

                    if !is_src
                        && (func_rgb.gl_value == glw::GL_SRC_ALPHA_SATURATE
                            || func_alpha.gl_value == glw::GL_SRC_ALPHA_SATURATE)
                    {
                        // SRC_ALPHA_SATURATE is only valid for src func.
                        continue;
                    }

                    let name = format!("{}_{}", func_rgb.name_str, func_alpha.name_str);

                    // First, make param sets as if this was a src case.
                    let mut param_sets: Vec<BlendParams> =
                        [glw::GL_ONE, glw::GL_ZERO, glw::GL_SRC_COLOR, glw::GL_DST_COLOR]
                            .into_iter()
                            .map(|other| BlendParams {
                                equation_rgb: glw::GL_FUNC_ADD,
                                src_func_rgb: func_rgb.gl_value,
                                dst_func_rgb: other,
                                equation_alpha: glw::GL_FUNC_ADD,
                                src_func_alpha: func_alpha.gl_value,
                                dst_func_alpha: other,
                                blend_color: DEFAULT_BLEND_COLOR,
                            })
                            .collect();

                    // Swap src and dst params if this is a dst case.
                    if !is_src {
                        for params in param_sets.iter_mut() {
                            std::mem::swap(&mut params.src_func_rgb, &mut params.dst_func_rgb);
                            std::mem::swap(&mut params.src_func_alpha, &mut params.dst_func_alpha);
                        }
                    }

                    add_blend_case(if is_src { &mut src_group } else { &mut dst_group }, name, param_sets);
                }
            }
        }

        main_group.add_child(src_group);
        main_group.add_child(dst_group);
        group.add_child(main_group);
    }

    // Test all RGB and alpha equation combinations. Src and dst funcs are ONE for both.
    {
        let mut sub = TestCaseGroup::new("rgb_equation_alpha_equation");

        for eq_rgb in &BLEND_EQUATIONS {
            for eq_alpha in &BLEND_EQUATIONS {
                let name = format!("{}_{}", eq_rgb.name_str, eq_alpha.name_str);
                let param_sets = vec![BlendParams {
                    equation_rgb: eq_rgb.gl_value,
                    src_func_rgb: glw::GL_ONE,
                    dst_func_rgb: glw::GL_ONE,
                    equation_alpha: eq_alpha.gl_value,
                    src_func_alpha: glw::GL_ONE,
                    dst_func_alpha: glw::GL_ONE,
                    blend_color: DEFAULT_BLEND_COLOR,
                }];

                add_blend_case(&mut sub, name, param_sets);
            }
        }

        group.add_child(sub);
    }

    group
}
