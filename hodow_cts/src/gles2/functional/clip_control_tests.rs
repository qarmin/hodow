// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fClipControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Four of the eight cases are ported:
// `initial`, `modify_get`, `errors` and `origin`. The remaining four
// (`depth_mode_zero_to_one`, `depth_mode_one_to_one`, `face_culling`,
// `viewport_bounds`) all build on `ClipControlRenderBaseTest`'s depth-texture FBO and
// its `fuzzyDepthCompare`, which is not ported yet.
//
// `ClipControlApi`'s constructor is the support check, and each case's `deinit`
// restoring `ClipControl(LOWER_LEFT, NEGATIVE_ONE_TO_ONE)` happens at the end of
// `iterate` here - `glu::resetState` knows nothing about this extension, so leaving it
// set would change what the *next* case renders.

use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArray};
use crate::glw::{self, GLenum};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Surface, TestError, TestOutcome, TestResult, TestStatus};

/// `ClipControlApi::Supported`
fn check_supported(context: &Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_EXT_clip_control") {
        return Err(TestError::NotSupported("Required extension EXT_clip_control is not supported".to_string()));
    }
    Ok(())
}

/// `ClipControlBaseTest::verifyState`
fn verify_state(context: &Context, origin: GLenum, depth: GLenum) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut ret = true;

    let mut ret_i = 0;
    // SAFETY: both queries write a single integer.
    unsafe { gl.get_integerv(glw::GL_CLIP_ORIGIN, &mut ret_i) };
    glu::expect_no_error(gl, "get GL_CLIP_ORIGIN")?;

    ret &= ret_i as GLenum == origin;

    // SAFETY: as above.
    unsafe { gl.get_integerv(glw::GL_CLIP_DEPTH_MODE, &mut ret_i) };
    glu::expect_no_error(gl, "get GL_CLIP_DEPTH_MODE")?;

    ret &= ret_i as GLenum == depth;

    Ok(ret)
}

/// The state every case leaves behind, which is upstream's `deinit`.
fn restore_default_clip_control(context: &Context) {
    // SAFETY: the two default enums; the extension is present or the case never ran.
    unsafe { context.gl().clip_control(glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE) };
}

struct ClipControlInitialState;

impl TestCase for ClipControlInitialState {
    fn name(&self) -> &str {
        "initial"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !verify_state(context, glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE)? {
            return Err(TestError::Fail(
                "Wrong intitial state: GL_CLIP_ORIGIN should be GL_LOWER_LEFT, GL_CLIP_ORIGIN should be NEGATIVE_ONE_TO_ONE".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct ClipControlModifyGetState;

impl TestCase for ClipControlModifyGetState {
    fn name(&self) -> &str {
        "modify_get"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let cases: [[GLenum; 2]; 4] = [
            [glw::GL_UPPER_LEFT, glw::GL_ZERO_TO_ONE],
            [glw::GL_UPPER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE],
            [glw::GL_LOWER_LEFT, glw::GL_ZERO_TO_ONE],
            [glw::GL_LOWER_LEFT, glw::GL_NEGATIVE_ONE_TO_ONE],
        ];

        for case in cases {
            // SAFETY: every combination below is one the extension defines.
            unsafe { gl.clip_control(case[0], case[1]) };
            glu::expect_no_error(gl, "ClipControl()")?;
            if !verify_state(context, case[0], case[1])? {
                restore_default_clip_control(context);
                return Err(TestError::Fail("Wrong ClipControl state after ClipControl() call".to_string()));
            }
        }

        restore_default_clip_control(context);
        Ok(TestStatus::pass("Pass"))
    }
}

struct ClipControlErrors;

impl TestCase for ClipControlErrors {
    fn name(&self) -> &str {
        "errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // Finding improper value.
        let mut improper_value = glw::GL_NONE;
        while improper_value == glw::GL_UPPER_LEFT || improper_value == glw::GL_LOWER_LEFT || improper_value == glw::GL_ZERO_TO_ONE || improper_value == glw::GL_NEGATIVE_ONE_TO_ONE
        {
            improper_value += 1;
        }

        // Test setup.
        let cases: [[GLenum; 2]; 5] = [
            [glw::GL_UPPER_LEFT, improper_value],
            [glw::GL_LOWER_LEFT, improper_value],
            [improper_value, glw::GL_ZERO_TO_ONE],
            [improper_value, glw::GL_NEGATIVE_ONE_TO_ONE],
            [improper_value, improper_value],
        ];

        // Test iterations.
        for case in cases {
            // SAFETY: an invalid enum is exactly what is being provoked; GL answers
            // with an error rather than acting on it.
            unsafe { gl.clip_control(case[0], case[1]) };

            // SAFETY: a plain error query.
            if unsafe { gl.get_error() } != glw::GL_INVALID_ENUM {
                log::warn!(
                    "ClipControl have not generated GL_INVALID_ENUM error when called with invalid value ({}, {}).",
                    case[0],
                    case[1]
                );
            }
        }

        restore_default_clip_control(context);

        // Upstream sets FAIL inside the loop above and then PASS unconditionally here,
        // so a driver that accepts an invalid enum still passes this case. Reporting
        // the failure instead would disagree with `deqp-gles2` on a working driver.
        Ok(TestStatus::pass("Pass"))
    }
}

struct ClipControlOriginTest;

impl ClipControlOriginTest {
    fn vsh() -> &'static str {
        "attribute highp vec2 Position;\nvoid main() {\n    gl_Position = vec4(Position, 0.0, 1.0);\n}"
    }

    /// `ClipControlRenderBaseTest::fsh`
    fn fsh() -> &'static str {
        "void main() {\n    gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n}"
    }

    /// `ClipControlOriginTest::ValidateFramebuffer`
    fn validate_framebuffer(&self, context: &Context, origin: GLenum) -> Result<TestResult, TestError> {
        let render_target = context.render_target();
        let viewport_w = render_target.width;
        let viewport_h = render_target.height;
        let mut rendered_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_frame = Surface::new(viewport_w, viewport_h);

        for y in 0..reference_frame.get_height() {
            let y_coord = y as f32 / reference_frame.get_height() as f32;

            for x in 0..reference_frame.get_width() {
                let x_coord = x as f32 / reference_frame.get_width() as f32;

                let green_quadrant = if origin == glw::GL_UPPER_LEFT {
                    y_coord > 0.5 && x_coord <= 0.5
                } else {
                    y_coord <= 0.5 && x_coord <= 0.5
                };

                if green_quadrant {
                    reference_frame.set_pixel(x, y, RGBA::green());
                } else {
                    reference_frame.set_pixel(x, y, RGBA::red());
                }
            }
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut rendered_frame.get_access())?;

        let ok = fuzzy_compare_ok(&reference_frame.get_const_access(), &rendered_frame.get_const_access(), 0.05)
            .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;

        Ok(if ok { TestResult::Pass } else { TestResult::Fail })
    }
}

impl TestCase for ClipControlOriginTest {
    fn name(&self) -> &str {
        "origin"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_supported(context)?;
        // Upstream reaches `glGenVertexArrays` through GL_OES_vertex_array_object on an
        // ES 2.0 context (`glwInitExtES.inl` loads the OES entry point into the core
        // slot); without the extension the call is not there at all.
        if !context.context_info.is_extension_supported("GL_OES_vertex_array_object") {
            return Err(TestError::NotSupported("Required extension GL_OES_vertex_array_object is not supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // Render a triangle fan covering (-1.0, -1.0) to (1.0, 0.0) and
        // write a pixel value of green (0, 1, 0).
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(Self::vsh(), Self::fsh()));
        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let vao = VertexArray::new(gl);
        let vbo = Buffer::new(gl);

        const VERTEX_DATA0: [f32; 8] = [-1.0, -1.0, 0.0, -1.0, -1.0, 0.0, 0.0, 0.0];

        let origins: [GLenum; 2] = [glw::GL_UPPER_LEFT, glw::GL_LOWER_LEFT];
        let mut result = TestResult::Pass;

        // SAFETY: the vertex data outlives the upload, the attribute is fed from the
        // buffer bound here, and every enum is one the extension defines.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VERTEX_DATA0) as isize,
                VERTEX_DATA0.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(0);

            gl.use_program(program.program());

            for origin in origins {
                // Clear the default framebuffer to red (1, 0, 0).
                gl.clear_color(1.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);

                // Set ClipControl(UPPER_LEFT, NEGATIVE_ONE_TO_ONE)
                gl.clip_control(origin, glw::GL_NEGATIVE_ONE_TO_ONE);
                glu::expect_no_error(gl, "ClipControl()")?;

                // test method modification: use GL_TRIANGLE_STRIP, not FAN.
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);

                // Read back the default framebuffer with ReadPixels
                // Verify the green pixels at the top and red at the bottom.
                let loop_result = self.validate_framebuffer(context, origin)?;
                if loop_result != TestResult::Pass {
                    result = loop_result;
                }
            }

            restore_default_clip_control(context);
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.bind_vertex_array(0);
        }

        Ok(TestStatus::new(result, result.as_str()))
    }
}

/// `ClipControlTests::init`, restricted to the four ported cases.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clip_control");
    group.add_child(Box::new(ClipControlInitialState) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlModifyGetState) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlErrors) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipControlOriginTest) as Box<dyn TestCase>);
    group
}
