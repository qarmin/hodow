// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDitheringTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's own `CONTINUE`/`STOP` state
// machine (one quad draw per `iterate()` call, paced for its interactive test-log
// viewer) is collapsed into a single `iterate()` that runs every draw in a plain loop -
// the same simplification this campaign already applies to other multi-iteration cases
// (`compute_shader_builtin_var_tests`), since nothing here reads the intermediate log
// output that pacing exists for. Needs no rasterised reference image: every check is a
// per-pixel, per-channel "is this one of the two (or occasionally four) values a
// conformant dither could have quantised the input colour to", not a comparison against
// a rendered reference.
//
// Upstream's `Random rnd(deStringHash(getName()))` is reconstructed fresh inside
// `drawAndCheckGradient`/`drawAndCheckUnicoloredQuad` on every call rather than being a
// case-lifetime field - so every one of a case's iterations (both gradient directions,
// or all 30 quad steps) draws at the *same* random viewport position, deterministically
// re-derived from the case name each time. `random_viewport` below is called fresh per
// iteration for the same reason, and must stay that way.

use crate::gls::fragment_op_util::{Quad, QuadRenderer, QuadRendererGlslVersion};
use crate::glu::{Context, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::{PixelFormat, RGBA, Random, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

const NUM_QUADS: i32 = 30;

const CASE_COLORS: &[(&str, [f32; 4])] = &[
    ("white", [1.0, 1.0, 1.0, 1.0]),
    ("red", [1.0, 0.0, 0.0, 1.0]),
    ("green", [0.0, 1.0, 0.0, 1.0]),
    ("blue", [0.0, 0.0, 1.0, 1.0]),
    ("alpha", [0.0, 0.0, 0.0, 1.0]),
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum PatternType {
    Gradient,
    UnicoloredQuad,
}

fn pixel_format_to_ivec4(format: PixelFormat) -> [i32; 4] {
    [format.red_bits, format.green_bits, format.blue_bits, format.alpha_bits]
}

/// `DitheringCase::checkColor` - true if every channel `rendered` holds is one of the
/// (up to four) values a conformant dither of `input_color` at `channel_bits` precision
/// could produce.
fn check_color(input_color: [f32; 4], rendered: RGBA, channel_bits: [i32; 4]) -> bool {
    let rendered_channels = [
        rendered.get_red(),
        rendered.get_green(),
        rendered.get_blue(),
        rendered.get_alpha(),
    ];

    for chan in 0..4 {
        let bits = channel_bits[chan];
        if bits == 0 {
            continue;
        }

        let channel_max = (1i32 << bits) - 1;
        let scaled_input = input_color[chan] * channel_max as f32;
        let use_rounding_margin = (scaled_input - scaled_input.round()).abs() < 0.0001;

        let mut choices = vec![
            channel_max.min(scaled_input.ceil() as i32),
            0.max(scaled_input.ceil() as i32 - 1),
        ];
        // If the input color results in a scaled value that is very close to an
        // integer, account for a little bit of possible inaccuracy.
        if use_rounding_margin {
            if scaled_input > scaled_input.round() {
                choices.push(scaled_input.ceil() as i32 - 2);
            } else {
                choices.push(scaled_input.ceil() as i32 + 1);
            }
        }

        let rendered_in_format = ((rendered_channels[chan] * channel_max) as f32 / 255.0).round() as i32;
        if !choices.contains(&rendered_in_format) {
            return false;
        }
    }

    true
}

/// A viewport of at most `max_size` at a position freshly re-derived from `case_name` -
/// see the module's own header note on why this is not cached across a case's own
/// iterations.
fn random_viewport(context: &Context, case_name: &str, max_size: i32) -> (i32, i32, i32, i32) {
    let mut rnd = Random::new(de_string_hash(case_name));
    let render_target = context.render_target();
    let w = max_size.min(render_target.width);
    let h = max_size.min(render_target.height);
    let x = rnd.get_int(0, render_target.width - w);
    let y = rnd.get_int(0, render_target.height - h);
    (x, y, w, h)
}

/// `DitheringCase::drawAndCheckGradient`
fn draw_and_check_gradient(
    context: &Context,
    renderer: &QuadRenderer<'_>,
    case_name: &str,
    is_vertically_increasing: bool,
    high_color: [f32; 4],
    dithering_enabled: bool,
    channel_bits: [i32; 4],
) -> Result<bool, TestError> {
    let gl = context.gl();
    let (viewport_x, viewport_y, viewport_w, viewport_h) = random_viewport(context, case_name, 256);
    let quad_color0 = [0.0f32, 0.0, 0.0, 0.0];
    let quad_color1 = high_color;

    // SAFETY: a plain capability toggle, then one draw through `renderer`'s own
    // program.
    unsafe {
        gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
        if dithering_enabled {
            gl.enable(glw::GL_DITHER);
        } else {
            gl.disable(glw::GL_DITHER);
        }
    }

    let quad = Quad {
        color: [
            quad_color0,
            if is_vertically_increasing {
                quad_color1
            } else {
                quad_color0
            },
            if is_vertically_increasing {
                quad_color0
            } else {
                quad_color1
            },
            quad_color1,
        ],
        ..Default::default()
    };
    renderer.render(gl, &quad);

    let mut rendered = Surface::new(viewport_w, viewport_h);
    read_pixels(
        &context.render_context,
        viewport_x,
        viewport_y,
        &mut rendered.get_access(),
    )?;

    // Validate, at each pixel, that each color channel is one of its allowed values.
    for y in 0..viewport_h {
        for x in 0..viewport_w {
            let incr_coord = if is_vertically_increasing { y } else { x };
            let incr_size = if is_vertically_increasing {
                viewport_h
            } else {
                viewport_w
            };
            let input_f = (incr_coord as f32 + 0.5) / incr_size as f32;
            let input_color: [f32; 4] =
                std::array::from_fn(|c| (1.0 - input_f) * quad_color0[c] + input_f * quad_color1[c]);

            if !check_color(input_color, rendered.get_pixel(x, y), channel_bits) {
                return Ok(false);
            }
        }
    }

    // When dithering is disabled, the color selection must be coordinate-independent -
    // i.e. the colors must be constant in the gradient's constant direction.
    if !dithering_enabled {
        let increasing_direction_size = if is_vertically_increasing {
            viewport_h
        } else {
            viewport_w
        };
        let constant_direction_size = if is_vertically_increasing {
            viewport_w
        } else {
            viewport_h
        };

        for incr_pos in 0..increasing_direction_size {
            let mut color_has_changed = false;
            let mut prev_constant_direction_pix: Option<RGBA> = None;

            for const_pos in 0..constant_direction_size {
                let (x, y) = if is_vertically_increasing {
                    (const_pos, incr_pos)
                } else {
                    (incr_pos, const_pos)
                };
                let clr = rendered.get_pixel(x, y);

                if const_pos > 0 && Some(clr) != prev_constant_direction_pix {
                    // Allow color to change once to take into account a possible
                    // discontinuity between triangles.
                    if color_has_changed {
                        return Ok(false);
                    }
                    color_has_changed = true;
                }

                prev_constant_direction_pix = Some(clr);
            }
        }
    }

    Ok(true)
}

/// `DitheringCase::drawAndCheckUnicoloredQuad`
fn draw_and_check_unicolored_quad(
    context: &Context,
    renderer: &QuadRenderer<'_>,
    case_name: &str,
    quad_color: [f32; 4],
    dithering_enabled: bool,
    channel_bits: [i32; 4],
) -> Result<bool, TestError> {
    let gl = context.gl();
    let (viewport_x, viewport_y, viewport_w, viewport_h) = random_viewport(context, case_name, 32);

    // SAFETY: as in `draw_and_check_gradient`.
    unsafe {
        gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
        if dithering_enabled {
            gl.enable(glw::GL_DITHER);
        } else {
            gl.disable(glw::GL_DITHER);
        }
    }

    let quad = Quad {
        color: [quad_color; 4],
        ..Default::default()
    };
    renderer.render(gl, &quad);

    let mut rendered = Surface::new(viewport_w, viewport_h);
    read_pixels(
        &context.render_context,
        viewport_x,
        viewport_y,
        &mut rendered.get_access(),
    )?;

    for y in 0..viewport_h {
        for x in 0..viewport_w {
            if !check_color(quad_color, rendered.get_pixel(x, y), channel_bits) {
                return Ok(false);
            }
        }
    }

    // When dithering is disabled, the color selection must be coordinate-independent -
    // i.e. the entire rendered image must be unicolored.
    if !dithering_enabled {
        let rendered00 = rendered.get_pixel(0, 0);
        for y in 0..viewport_h {
            for x in 0..viewport_w {
                if rendered.get_pixel(x, y) != rendered00 {
                    return Ok(false);
                }
            }
        }
    }

    Ok(true)
}

struct DitheringCase {
    name: String,
    dithering_enabled: bool,
    pattern_type: PatternType,
    color: [f32; 4],
}

impl TestCase for DitheringCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let renderer = QuadRenderer::new(gl, QuadRendererGlslVersion::Es100)?;
        let channel_bits = pixel_format_to_ivec4(context.render_target().pixel_format());

        match self.pattern_type {
            PatternType::Gradient => {
                // Horizontal, then vertical.
                for iteration in 0..2 {
                    let ok = draw_and_check_gradient(
                        context,
                        &renderer,
                        &self.name,
                        iteration == 1,
                        self.color,
                        self.dithering_enabled,
                        channel_bits,
                    )?;
                    if !ok {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
            PatternType::UnicoloredQuad => {
                for iteration in 0..NUM_QUADS {
                    let quad_color: [f32; 4] =
                        std::array::from_fn(|c| (iteration as f32 / (NUM_QUADS - 1) as f32) * self.color[c]);
                    let ok = draw_and_check_unicolored_quad(
                        context,
                        &renderer,
                        &self.name,
                        quad_color,
                        self.dithering_enabled,
                        channel_bits,
                    )?;
                    if !ok {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `DitheringTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dither");

    for &dithering_enabled in &[false, true] {
        let mut sub = TestCaseGroup::new(if dithering_enabled { "enabled" } else { "disabled" });

        for (pattern_type, pattern_name) in [
            (PatternType::Gradient, "gradient"),
            (PatternType::UnicoloredQuad, "unicolored_quad"),
        ] {
            for &(color_name, color) in CASE_COLORS {
                let name = format!("{pattern_name}_{color_name}");
                sub.add_child(Box::new(DitheringCase {
                    name,
                    dithering_enabled,
                    pattern_type,
                    color,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(sub);
    }

    group
}
