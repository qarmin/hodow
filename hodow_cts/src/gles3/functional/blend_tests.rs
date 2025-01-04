// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBlendTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The ES 3.0 half of `gles2::functional::blend_tests`, and a separate port because
// upstream keeps them separate: ES 3.0 adds `GL_MIN`/`GL_MAX` (whose cases drop the
// factor half of the name, since neither depends on a factor), and runs the whole set a
// second time against a `GL_SRGB8_ALPHA8` renderbuffer. The sRGB half is what makes the
// reference interesting - blending happens in linear space against a destination the
// framebuffer holds encoded, so `rr::FragmentProcessor` converts both ways around the
// blend and the comparison converts both images back to linear first.

use crate::gls::fragment_op_util::{
    IntegerQuad, Quad, QuadRenderer, QuadRendererGlslVersion, ReferenceQuadRenderer, get_multisample_access,
};
use crate::glu::{self, ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum, GLuint};
use crate::rr::render_state::{BlendMode, FragmentOperationState};
use crate::sglr::reference_utils::{map_gl_blend_equation, map_gl_blend_func};
use crate::tcu::PixelFormat;
use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel, srgb_to_linear};
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

/// `sRGBAToLinear` - in place, which upstream allows since the mapping is per pixel.
fn srgba_to_linear(access: &mut PixelBufferAccess<'_>) {
    let [width, height, _] = access.size();
    for y in 0..height {
        for x in 0..width {
            let c = access.as_const().get_pixel(x, y, 0);
            access.set_pixel(srgb_to_linear(c), x, y, 0);
        }
    }
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

/// `BlendCase::init`'s sRGB half - the renderbuffer and framebuffer the case renders
/// into when `use_srgb_fbo`. Returned as a pair so `deinit` can delete both.
fn create_srgb_fbo(case: &mut ApiCase<'_>, render_width: i32, render_height: i32) -> Option<(GLuint, GLuint)> {
    let gl = case.gl();
    log::debug!("Using FBO of size ({render_width}, {render_height}) with format GL_SRGB8_ALPHA8");

    let mut color_rbo: GLuint = 0;
    let mut fbo: GLuint = 0;
    // SAFETY: plain object creation and binding on a current context.
    unsafe {
        gl.gen_renderbuffers(1, &mut color_rbo);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_SRGB8_ALPHA8, render_width, render_height);

        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_rbo,
        );
    }
    if let Err(e) = glu::expect_no_error(gl, "create sRGB FBO") {
        case.fail(e.to_string(), "Fail");
        return None;
    }

    Some((color_rbo, fbo))
}

/// `BlendCase::deinit`
fn delete_srgb_fbo(gl: &glw::Functions, color_rbo: GLuint, fbo: GLuint) {
    // SAFETY: objects this case created itself.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_renderbuffers(1, &color_rbo);
        gl.delete_framebuffers(1, &fbo);
    }
}

/// `BlendCase::iterate`, run once per parameter set - upstream returns `CONTINUE` and is
/// re-entered, which is the same loop with the case object's state carried across.
fn blend_case(case: &mut ApiCase<'_>, name_hash: u32, param_sets: &[BlendParams], use_srgb_fbo: bool) {
    let target = case.context().render_target();
    let use_rgb = !use_srgb_fbo && target.pixel_format().alpha_bits == 0;

    let render_width = if use_srgb_fbo {
        2 * MAX_VIEWPORT_WIDTH
    } else {
        target.width
    };
    let render_height = if use_srgb_fbo {
        2 * MAX_VIEWPORT_HEIGHT
    } else {
        target.height
    };
    let viewport_w = render_width.min(MAX_VIEWPORT_WIDTH);
    let viewport_h = render_height.min(MAX_VIEWPORT_HEIGHT);

    let (first_quad, second_quad, first_quad_int, second_quad_int) = make_quads(viewport_w, viewport_h);

    let gl = case.gl();
    let renderer = match QuadRenderer::new(gl, QuadRendererGlslVersion::Es300) {
        Ok(renderer) => renderer,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };
    let mut reference_renderer = ReferenceQuadRenderer::new();

    let ref_order = if use_srgb_fbo {
        ChannelOrder::sRGBA
    } else if use_rgb {
        ChannelOrder::RGB
    } else {
        ChannelOrder::RGBA
    };
    let mut ref_color_buffer = match TextureLevel::new(
        TextureFormat::new(ref_order, ChannelType::UNORM_INT8),
        viewport_w as u32,
        viewport_h as u32,
        1,
    ) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let img_format = TextureFormat::new(
        if use_srgb_fbo {
            ChannelOrder::sRGBA
        } else {
            ChannelOrder::RGBA
        },
        ChannelType::UNORM_INT8,
    );

    let srgb_fbo = if use_srgb_fbo {
        match create_srgb_fbo(case, render_width, render_height) {
            Some(objects) => Some(objects),
            None => return,
        }
    } else {
        None
    };

    for (cur_param_set_ndx, param_set) in param_sets.iter().enumerate() {
        let mut rnd = Random::new(name_hash ^ de_int32_hash(cur_param_set_ndx as i32));
        let viewport_x = rnd.get_int(0, render_width - viewport_w);
        let viewport_y = rnd.get_int(0, render_height - viewport_h);
        let mut reference_state = FragmentOperationState::default();

        // Log the blend parameters. Upstream names each enum through
        // `glu::getBlendEquationName`/`getBlendFactorName`, neither of which is ported.
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
            break;
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
            break;
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

        // Copy to reference (expansion to RGBA happens here if necessary)
        let mut reference_img = match TextureLevel::new(img_format, viewport_w as u32, viewport_h as u32, 1) {
            Ok(level) => level,
            Err(e) => {
                case.fail(e.to_string(), "Fail");
                break;
            }
        };
        copy(&mut reference_img.get_access(), &ref_color_buffer);

        // Read GL image.
        let mut rendered_img = match TextureLevel::new(img_format, viewport_w as u32, viewport_h as u32, 1) {
            Ok(level) => level,
            Err(e) => {
                case.fail(e.to_string(), "Fail");
                break;
            }
        };
        if let Err(e) = glu::pixel_transfer::read_pixels(
            &case.context().render_context,
            viewport_x,
            viewport_y,
            &mut rendered_img.get_access(),
        ) {
            case.fail(e.to_string(), "Fail");
            break;
        }

        // Compare images.
        // \note In sRGB cases, convert to linear space for comparison.
        if use_srgb_fbo {
            srgba_to_linear(&mut rendered_img.get_access());
            srgba_to_linear(&mut reference_img.get_access());
        }

        // \note Non-scientific ad hoc formula. Need big threshold when few color bits;
        // blending brings extra inaccuracy.
        let base = if use_srgb_fbo {
            PixelFormat::new(8, 8, 8, 8)
        } else {
            target.pixel_format()
        }
        .get_color_threshold();
        let bias = if use_srgb_fbo { 5 } else { 3 };
        let scale = |v: i32| (v as u32) * 5 / 2 + bias;
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
            break;
        }
    }

    if let Some((color_rbo, fbo)) = srgb_fbo {
        delete_srgb_fbo(gl, color_rbo, fbo);
    }
}

/// `tcu::copy` from the reference buffer's own format into the comparison format - the
/// expansion upstream writes as `copy(referenceImg, m_refColorBuffer->getAccess())`.
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

const BLEND_EQUATIONS: [EnumGl; 5] = [
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
    EnumGl {
        gl_value: glw::GL_MIN,
        name_str: "min",
    },
    EnumGl {
        gl_value: glw::GL_MAX,
        name_str: "max",
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
fn add_blend_case(group: &mut TestCaseGroup, name: String, param_sets: Vec<BlendParams>, use_srgb_fbo: bool) {
    let name_hash = de_string_hash(&name);
    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        blend_case(case, name_hash, &param_sets, use_srgb_fbo)
    });
}

/// `BlendTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("blend");

    for use_srgb_fbo_i in 0..=1 {
        let use_srgb_fbo = use_srgb_fbo_i != 0;
        let mut fb_group = TestCaseGroup::new(if use_srgb_fbo {
            "fbo_srgb"
        } else {
            "default_framebuffer"
        });

        // Test all blend equation, src blend function, dst blend function combinations. RGB and alpha modes are the same.
        {
            let mut sub = TestCaseGroup::new("equation_src_func_dst_func");

            for eq in &BLEND_EQUATIONS {
                for (src_func_ndx, src) in BLEND_FUNCTIONS.iter().enumerate() {
                    for (dst_func_ndx, dst) in BLEND_FUNCTIONS.iter().enumerate() {
                        let is_min_max = eq.gl_value == glw::GL_MIN || eq.gl_value == glw::GL_MAX;
                        if is_min_max && (src_func_ndx > 0 || dst_func_ndx > 0) {
                            // MIN and MAX don't depend on factors.
                            continue;
                        }

                        let name = if is_min_max {
                            eq.name_str.to_string()
                        } else {
                            format!("{}_{}_{}", eq.name_str, src.name_str, dst.name_str)
                        };

                        let param_sets = vec![BlendParams {
                            equation_rgb: eq.gl_value,
                            src_func_rgb: src.gl_value,
                            dst_func_rgb: dst.gl_value,
                            equation_alpha: eq.gl_value,
                            src_func_alpha: src.gl_value,
                            dst_func_alpha: dst.gl_value,
                            blend_color: DEFAULT_BLEND_COLOR,
                        }];

                        add_blend_case(&mut sub, name, param_sets, use_srgb_fbo);
                    }
                }
            }

            fb_group.add_child(sub);
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

                        add_blend_case(
                            if is_src { &mut src_group } else { &mut dst_group },
                            name,
                            param_sets,
                            use_srgb_fbo,
                        );
                    }
                }
            }

            main_group.add_child(src_group);
            main_group.add_child(dst_group);
            fb_group.add_child(main_group);
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

                    add_blend_case(&mut sub, name, param_sets, use_srgb_fbo);
                }
            }

            fb_group.add_child(sub);
        }

        group.add_child(fb_group);
    }

    group
}
