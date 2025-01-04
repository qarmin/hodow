// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fColorClearTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `iterate` returns
// CONTINUE and is re-entered per iteration; here the iteration is a loop inside
// `iterate`, which leaves GL state alive across iterations exactly as upstream does
// (`glu::resetState` runs when the case finishes, not between its iterations).
//
// Upstream keeps a separate, near-identical copy of this file per API module; this
// port does the same rather than sharing the ES 2.0 one, so that a re-sync that
// changes only one of them shows up as a difference here too.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::{self, RGBA, compute_abs_diff_masked};
use crate::tcu::{IVec4, Random, Surface, TestOutcome, TestStatus};

/// `de::inBounds`
fn in_bounds(value: i32, low: i32, high: i32) -> bool {
    value >= low && value < high
}

#[derive(Clone, Copy)]
struct ColorClearCase {
    name: &'static str,
    num_iters: i32,
    num_clears_min: i32,
    num_clears_max: i32,
    test_alpha: bool,
    test_scissoring: bool,
    test_color_masks: bool,
    first_clear_full: bool,
}

/// `ClearInfo` - one recorded clear, which is all the reference needs to replay it.
struct ClearInfo {
    rect: IVec4,
    color_mask: u8,
    color: RGBA,
}

impl TestCase for ColorClearCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();
        let target_width = render_target.width;
        let target_height = render_target.height;
        let num_pixels = (target_width * target_height) as usize;

        for cur_iter in 0..self.num_iters {
            let mut rnd = Random::new(de_int32_hash(cur_iter));
            let mut pixel_known_channel_mask = vec![0u8; num_pixels];
            let mut ref_image = Surface::new(target_width, target_height);
            let mut res_image = Surface::new(target_width, target_height);
            let mut diff_image = Surface::new(target_width, target_height);
            let num_clears = (rnd.get_uint32() % (self.num_clears_max + 1 - self.num_clears_min) as u32) as i32
                + self.num_clears_min;
            let mut clear_ops: Vec<ClearInfo> = Vec::new();

            if self.test_scissoring {
                // SAFETY: enabling a capability the ES 2.0 core has.
                unsafe { gl.enable(glw::GL_SCISSOR_TEST) };
            }

            for clear_ndx in 0..num_clears {
                // Rectangle. The four are drawn in this order and nothing else may be
                // drawn between them, or the whole stream diverges from upstream's.
                let (clear_x, clear_y, clear_width, clear_height) =
                    if !self.test_scissoring || (clear_ndx == 0 && self.first_clear_full) {
                        (0, 0, target_width, target_height)
                    } else {
                        (
                            (rnd.get_uint32() % (2 * target_width) as u32) as i32 - target_width,
                            (rnd.get_uint32() % (2 * target_height) as u32) as i32 - target_height,
                            (rnd.get_uint32() % target_width as u32) as i32,
                            (rnd.get_uint32() % target_height as u32) as i32,
                        )
                    };
                // SAFETY: a scissor rectangle; GL clamps it itself.
                unsafe { gl.scissor(clear_x, clear_y, clear_width, clear_height) };

                // Color.
                let r = (rnd.get_uint32() & 0xFF) as i32;
                let g = (rnd.get_uint32() & 0xFF) as i32;
                let b = (rnd.get_uint32() & 0xFF) as i32;
                let a = if self.test_alpha {
                    (rnd.get_uint32() & 0xFF) as i32
                } else {
                    0xFF
                };
                let clear_col = RGBA::new(r, g, b, a);
                // SAFETY: in-range clear colour.
                unsafe { gl.clear_color(r as f32 / 255.0, g as f32 / 255.0, b as f32 / 255.0, a as f32 / 255.0) };

                // Mask.
                let clear_mask: u8 = if !self.test_color_masks || (clear_ndx == 0 && self.first_clear_full) {
                    0xF
                } else {
                    (rnd.get_uint32() & 0xF) as u8
                };
                // SAFETY: four booleans.
                unsafe {
                    gl.color_mask(
                        u8::from(clear_mask & 0x1 != 0),
                        u8::from(clear_mask & 0x2 != 0),
                        u8::from(clear_mask & 0x4 != 0),
                        u8::from(clear_mask & 0x8 != 0),
                    )
                };

                // Clear & store op.
                // SAFETY: a clear of the default framebuffer.
                unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
                clear_ops.push(ClearInfo {
                    rect: IVec4::new(clear_x, clear_y, clear_width, clear_height),
                    color_mask: clear_mask,
                    color: clear_col,
                });
            }

            // Compute reference image.
            for y in 0..target_height {
                // Find all rectangles affecting this scanline.
                let scanline_clear_ops: Vec<&ClearInfo> = clear_ops
                    .iter()
                    .filter(|op| in_bounds(y, op.rect.y(), op.rect.y() + op.rect.w()))
                    .collect();

                // Compute reference for scanline.
                let mut x = 0;
                while x < target_width {
                    let mut span_color = RGBA::default();
                    let mut span_known_mask = 0u8;
                    let mut span_length = target_width - x;

                    for op in scanline_clear_ops.iter().rev() {
                        if in_bounds(x, op.rect.x(), op.rect.x() + op.rect.z())
                            && in_bounds(y, op.rect.y(), op.rect.y() + op.rect.w())
                        {
                            // Compute span length until end of given rectangle.
                            span_length = span_length.min(op.rect.x() + op.rect.z() - x);

                            let clear_col = op.color;
                            let clear_mask = op.color_mask;
                            if (clear_mask & 0x1) != 0 && (span_known_mask & 0x1) == 0 {
                                span_color.set_red(clear_col.get_red());
                            }
                            if (clear_mask & 0x2) != 0 && (span_known_mask & 0x2) == 0 {
                                span_color.set_green(clear_col.get_green());
                            }
                            if (clear_mask & 0x4) != 0 && (span_known_mask & 0x4) == 0 {
                                span_color.set_blue(clear_col.get_blue());
                            }
                            if (clear_mask & 0x8) != 0 && (span_known_mask & 0x8) == 0 {
                                span_color.set_alpha(clear_col.get_alpha());
                            }
                            span_known_mask |= clear_mask;

                            // Break if have all colors.
                            if span_known_mask == 0xF {
                                break;
                            }
                        } else if op.rect.x() > x {
                            span_length = span_length.min(op.rect.x() - x);
                        }
                    }

                    // Set reference alpha channel to 0xFF, if no alpha in target.
                    if pixel_format.alpha_bits == 0 {
                        span_color.set_alpha(0xFF);
                    }

                    // Fill the span.
                    for ndx in 0..span_length {
                        ref_image.set_pixel(x + ndx, y, span_color);
                        pixel_known_channel_mask[(y * target_width + x + ndx) as usize] |= span_known_mask;
                    }

                    x += span_length;
                }
            }

            glu::read_pixels(&context.render_context, 0, 0, &mut res_image.get_access())?;
            glu::expect_no_error(gl, "glReadPixels")?;

            // Compute difference image.
            let mut color_threshold = pixel_format.get_color_threshold();
            let match_color = RGBA::new(0, 255, 0, 255);
            let diff_color = RGBA::new(255, 0, 0, 255);
            let mut max_diff = RGBA::new(0, 0, 0, 0);
            let mut is_image_ok = true;

            // SAFETY: a query of a single capability.
            if unsafe { gl.is_enabled(glw::GL_DITHER) } == glw::TRUE {
                color_threshold.set_red(color_threshold.get_red() + 1);
                color_threshold.set_green(color_threshold.get_green() + 1);
                color_threshold.set_blue(color_threshold.get_blue() + 1);
                color_threshold.set_alpha(color_threshold.get_alpha() + 1);
            }

            for y in 0..target_height {
                for x in 0..target_width {
                    let offset = (y * target_width + x) as usize;
                    let ref_rgba = ref_image.get_pixel(x, y);
                    let res_rgba = res_image.get_pixel(x, y);
                    let col_mask = u32::from(pixel_known_channel_mask[offset]);
                    let diff = compute_abs_diff_masked(ref_rgba, res_rgba, col_mask);
                    let is_pixel_ok = diff.is_below_threshold(color_threshold);

                    diff_image.set_pixel(x, y, if is_pixel_ok { match_color } else { diff_color });

                    is_image_ok = is_image_ok && is_pixel_ok;
                    max_diff = rgba::max(max_diff, diff);
                }
            }

            if !is_image_ok {
                return Ok(TestStatus::fail(format!(
                    "Image comparison failed, max diff = {max_diff}, threshold = {color_threshold}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ColorClearTest::init`
pub fn create_tests() -> TestCaseGroup {
    //                                          name                     iters, #..#, alpha?, scissor, masks, 1stfull?
    #[rustfmt::skip]
    const CASES: &[ColorClearCase] = &[
        ColorClearCase { name: "single_rgb",             num_iters: 30, num_clears_min: 1,   num_clears_max: 3,   test_alpha: false, test_scissoring: false, test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "single_rgba",            num_iters: 30, num_clears_min: 1,   num_clears_max: 3,   test_alpha: true,  test_scissoring: false, test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "multiple_rgb",           num_iters: 15, num_clears_min: 4,   num_clears_max: 20,  test_alpha: false, test_scissoring: false, test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "multiple_rgba",          num_iters: 15, num_clears_min: 4,   num_clears_max: 20,  test_alpha: true,  test_scissoring: false, test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "long_rgb",               num_iters: 2,  num_clears_min: 100, num_clears_max: 500, test_alpha: false, test_scissoring: false, test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "long_rgba",              num_iters: 2,  num_clears_min: 100, num_clears_max: 500, test_alpha: true,  test_scissoring: false, test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "subclears_rgb",          num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: false, test_scissoring: false, test_color_masks: false, first_clear_full: false },
        ColorClearCase { name: "subclears_rgba",         num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: true,  test_scissoring: false, test_color_masks: false, first_clear_full: false },
        ColorClearCase { name: "short_scissored_rgb",    num_iters: 30, num_clears_min: 2,   num_clears_max: 4,   test_alpha: false, test_scissoring: true,  test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "scissored_rgb",          num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: false, test_scissoring: true,  test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "scissored_rgba",         num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: true,  test_scissoring: true,  test_color_masks: false, first_clear_full: true  },
        ColorClearCase { name: "masked_rgb",             num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: false, test_scissoring: false, test_color_masks: true,  first_clear_full: true  },
        ColorClearCase { name: "masked_rgba",            num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: true,  test_scissoring: false, test_color_masks: true,  first_clear_full: true  },
        ColorClearCase { name: "masked_scissored_rgb",   num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: false, test_scissoring: true,  test_color_masks: true,  first_clear_full: true  },
        ColorClearCase { name: "masked_scissored_rgba",  num_iters: 15, num_clears_min: 4,   num_clears_max: 30,  test_alpha: true,  test_scissoring: true,  test_color_masks: true,  first_clear_full: true  },
        ColorClearCase { name: "complex_rgb",            num_iters: 15, num_clears_min: 5,   num_clears_max: 50,  test_alpha: false, test_scissoring: true,  test_color_masks: true,  first_clear_full: false },
        ColorClearCase { name: "complex_rgba",           num_iters: 15, num_clears_min: 5,   num_clears_max: 50,  test_alpha: true,  test_scissoring: true,  test_color_masks: true,  first_clear_full: false },
        ColorClearCase { name: "long_masked_rgb",        num_iters: 2,  num_clears_min: 100, num_clears_max: 500, test_alpha: false, test_scissoring: true,  test_color_masks: true,  first_clear_full: true  },
        ColorClearCase { name: "long_masked_rgba",       num_iters: 2,  num_clears_min: 100, num_clears_max: 500, test_alpha: true,  test_scissoring: true,  test_color_masks: true,  first_clear_full: true  },
    ];

    let mut group = TestCaseGroup::new("color_clear");
    for case in CASES {
        group.add_child(Box::new(*case) as Box<dyn TestCase>);
    }
    group
}
