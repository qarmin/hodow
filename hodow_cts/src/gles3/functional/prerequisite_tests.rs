// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fPrerequisiteTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `iterate` returns
// CONTINUE and is re-entered once per iteration; the runner here calls `iterate` once,
// so the iteration is a loop inside it. The verdict of the *last* iteration is the
// verdict of the case, because upstream's `setTestResult` overwrites rather than
// accumulates - a later passing iteration really does hide an earlier failure.
//
// Upstream keeps a separate, near-identical copy of this file per API module; this
// port does the same rather than sharing the ES 2.0 one, so that a re-sync that
// changes only one of them shows up as a difference here too.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::{RGBA, compare_threshold};
use crate::tcu::{Random, Surface, TestOutcome, TestStatus};

struct StateResetCase;

impl TestCase for StateResetCase {
    fn name(&self) -> &str {
        "state_reset"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        glu::reset_state_es(context);
        match glu::expect_no_error(context.gl(), "glu::resetState()") {
            Ok(()) => Ok(TestStatus::pass("Pass")),
            Err(e) => Ok(TestStatus::fail(format!("Fail: {e}"))),
        }
    }
}

struct ClearColorCase {
    num_iters: i32,
}

impl TestCase for ClearColorCase {
    fn name(&self) -> &str {
        "clear_color"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        for cur_iter in 0..self.num_iters {
            let mut r = 0;
            let mut g = 0;
            let mut b = 0;
            let mut a = 255;

            match cur_iter {
                0 => {
                    // Black, skip
                }
                1 => {
                    r = 255;
                    g = 255;
                    b = 255;
                }
                2 => r = 255,
                3 => g = 255,
                4 => b = 255,
                _ => {
                    let mut rnd = Random::new(de_int32_hash(cur_iter));
                    r = (rnd.get_uint32() & 0xFF) as i32;
                    g = (rnd.get_uint32() & 0xFF) as i32;
                    b = (rnd.get_uint32() & 0xFF) as i32;
                    a = (rnd.get_uint32() & 0xFF) as i32;
                }
            }

            // SAFETY: a clear of the default framebuffer with in-range colours.
            unsafe {
                gl.clear_color(r as f32 / 255.0, g as f32 / 255.0, b as f32 / 255.0, a as f32 / 255.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            if let Err(e) = glu::expect_no_error(gl, "CLES2 ClearColor failed.") {
                return Ok(TestStatus::fail(format!("{e}")));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct ReadPixelsCase {
    num_iters: i32,
}

impl TestCase for ReadPixelsCase {
    fn name(&self) -> &str {
        "read_pixels"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();
        let target_width = render_target.width;
        let target_height = render_target.height;
        let mut result = TestStatus::pass("Pass");

        for cur_iter in 0..self.num_iters {
            let x;
            let y;
            let image_width;
            let image_height;

            let mut rnd = Random::new(de_int32_hash(cur_iter));

            match cur_iter {
                0 => {
                    // Fullscreen
                    x = 0;
                    y = 0;
                    image_width = target_width;
                    image_height = target_height;
                }
                1 => {
                    // Upper left corner
                    x = 0;
                    y = 0;
                    image_width = target_width / 2;
                    image_height = target_height / 2;
                }
                2 => {
                    // Lower right corner
                    x = target_width / 2;
                    y = target_height / 2;
                    image_width = target_width - x;
                    image_height = target_height - y;
                }
                _ => {
                    x = (rnd.get_uint32() % (target_width - 1) as u32) as i32;
                    y = (rnd.get_uint32() % (target_height - 1) as u32) as i32;
                    image_width = 1 + (rnd.get_uint32() % (target_width - x - 1) as u32) as i32;
                    image_height = 1 + (rnd.get_uint32() % (target_height - y - 1) as u32) as i32;
                }
            }

            let mut res_image = Surface::new(image_width, image_height);
            let mut ref_image = Surface::new(image_width, image_height);
            let mut diff_image = Surface::new(image_width, image_height);

            let r = (rnd.get_uint32() & 0xFF) as i32;
            let g = (rnd.get_uint32() & 0xFF) as i32;
            let b = (rnd.get_uint32() & 0xFF) as i32;

            if !crate::tcu::pixel::clear_int(&mut ref_image.get_access(), [r, g, b, 255]) {
                return Err(crate::tcu::TestError::InternalError(
                    "clearing an RGBA8 surface".to_string(),
                ));
            }
            // SAFETY: a clear of the default framebuffer with in-range colours.
            unsafe {
                gl.clear_color(r as f32 / 255.0, g as f32 / 255.0, b as f32 / 255.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            glu::read_pixels(&context.render_context, x, y, &mut res_image.get_access())?;
            glu::expect_no_error(gl, "glReadPixels() failed.")?;

            let color_threshold = pixel_format.get_color_threshold();
            let match_color = RGBA::new(0, 255, 0, 255);
            let diff_color = RGBA::new(255, 0, 0, 255);
            let mut is_image_ok = true;

            for j in 0..image_height {
                for i in 0..image_width {
                    let res_rgba = res_image.get_pixel(i, j);
                    let ref_rgba = ref_image.get_pixel(i, j);
                    let is_pixel_ok = compare_threshold(ref_rgba, res_rgba, color_threshold);
                    diff_image.set_pixel(i, j, if is_pixel_ok { match_color } else { diff_color });

                    is_image_ok = is_image_ok && is_pixel_ok;
                }
            }

            result = if is_image_ok {
                TestStatus::pass("Pass")
            } else {
                TestStatus::fail("Fail")
            };
        }

        Ok(result)
    }
}

/// `PrerequisiteTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("prerequisite");
    group.add_child(Box::new(StateResetCase) as Box<dyn TestCase>);
    group.add_child(Box::new(ClearColorCase { num_iters: 10 }) as Box<dyn TestCase>);
    group.add_child(Box::new(ReadPixelsCase { num_iters: 20 }) as Box<dyn TestCase>);
    group
}
