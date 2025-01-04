// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcViewportArrayTests.cpp
//   external/openglcts/modules/common/glcViewportArrayTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop core only (the Khronos roots never run the ES branches).
//
// Ported so far: api_errors, queries, viewport_api, scissor_api, depth_range_api, scissor_test_state_api. Drawing tests ported (draw_tests.rs): draw_to_single_layer_with_multiple_viewports, dynamic_viewport_index, draw_mulitple_viewports_with_single_invocation, viewport_index_subroutine, draw_multiple_layers, scissor, scissor_zero_dimension, scissor_clear, depth_range, depth_range_depth_test, provoking_vertex. All cases are ported.

mod api_tests;
mod draw_tests;

use super::esext::{ExtParameters, TestCaseBase};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const VIEWPORT_ARRAY_NOT_SUPPORTED: &str = "Viewport array functionality not supported, skipping";

/// `APIErrors`
struct ApiErrors {
    ext_params: ExtParameters,
}

/// `APIErrors::checkGLError`
fn check_gl_error(gl: &glw::Functions, expected_error: GLenum, description: &str, out_result: &mut bool) {
    // SAFETY: reads the error flag of the current context.
    let error = unsafe { gl.get_error() };
    if expected_error != error {
        log::info!(
            "Test case fail. Description: {description} Invalid error: {} expected: {}",
            glw::error_name(error),
            glw::error_name(expected_error)
        );
        *out_result = false;
    }
}

impl ApiErrors {
    /// `APIErrors::depthRangeArrayHelper<GLdouble>`
    fn depth_range_array_helper(gl: &glw::Functions, max_viewports: GLint, test_result: &mut bool) {
        let mut data = vec![0.0f64; max_viewports as usize * 2];
        for i in 0..max_viewports as usize {
            data[i * 2] = 0.0;
            data[i * 2 + 1] = 1.0;
        }
        let first_count: [(u32, GLint, GLenum, &str); 4] = [
            (
                0,
                max_viewports - 1,
                glw::GL_NO_ERROR,
                "depthRangeArray, correct parameters",
            ),
            (
                max_viewports as u32,
                1,
                glw::GL_INVALID_VALUE,
                "depthRangeArray, <first> == GL_MAX_VIEWPORTS",
            ),
            (
                1,
                max_viewports - 1,
                glw::GL_NO_ERROR,
                "depthRangeArray, <first> + <count> == GL_MAX_VIEWPORTS",
            ),
            (
                1,
                max_viewports,
                glw::GL_INVALID_VALUE,
                "depthRangeArray, <first> + <count> > GL_MAX_VIEWPORTS",
            ),
        ];
        for (first, count, expected, description) in first_count {
            // SAFETY: `data` holds 2 doubles per viewport; the invalid-range calls are rejected before reading.
            unsafe { gl.depth_range_arrayv(first, count, data.as_ptr()) };
            check_gl_error(gl, expected, description, test_result);
        }
    }

    /// `APIErrors::depthRangeIndexedHelper<GLdouble>`
    fn depth_range_indexed_helper(gl: &glw::Functions, max_viewports: GLint, test_result: &mut bool) {
        let max = max_viewports as u32;
        let indices: [(u32, GLenum, &str); 4] = [
            (0, glw::GL_NO_ERROR, "depthRangeIndexed, <index> == 0"),
            (
                max - 1,
                glw::GL_NO_ERROR,
                "depthRangeIndexed, <index> == GL_MAX_VIEWPORTS - 1",
            ),
            (
                max,
                glw::GL_INVALID_VALUE,
                "depthRangeIndexed, <index> == GL_MAX_VIEWPORTS",
            ),
            (
                max + 1,
                glw::GL_INVALID_VALUE,
                "depthRangeIndexed, <index> > GL_MAX_VIEWPORTS",
            ),
        ];
        for (index, expected, description) in indices {
            // SAFETY: plain state call on the current context.
            unsafe { gl.depth_range_indexed(index, 0.0, 1.0) };
            check_gl_error(gl, expected, description, test_result);
        }
    }

    /// `APIErrors::getDepthHelper<GLdouble>`
    fn get_depth_helper(gl: &glw::Functions, max_viewports: GLint, test_result: &mut bool) {
        let mut data = [0.0f64; 4];
        // SAFETY: `data` holds the two doubles of DEPTH_RANGE.
        unsafe { gl.get_doublei_v(glw::GL_DEPTH_RANGE, (max_viewports - 1) as u32, data.as_mut_ptr()) };
        check_gl_error(
            gl,
            glw::GL_NO_ERROR,
            "getDouble/Floati_v, <index> == GL_MAX_VIEWPORTS - 1",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.get_doublei_v(glw::GL_DEPTH_RANGE, max_viewports as u32, data.as_mut_ptr()) };
        check_gl_error(
            gl,
            glw::GL_INVALID_VALUE,
            "getDouble/Floati_v, <index> == GL_MAX_VIEWPORTS",
            test_result,
        );
    }

    fn viewport_errors(gl: &glw::Functions, max_viewports: GLint, test_result: &mut bool) {
        let n = max_viewports as usize;
        let max = max_viewports as u32;

        let mut data = vec![0.0f32; n * 4];
        for i in 0..n {
            data[i * 4] = 0.0;
            data[i * 4 + 1] = 0.0;
            data[i * 4 + 2] = 1.0;
            data[i * 4 + 3] = 1.0;
        }
        let array_cases: [(u32, GLint, GLenum, &str); 4] = [
            (
                0,
                max_viewports - 1,
                glw::GL_NO_ERROR,
                "viewportArrayv, correct parameters",
            ),
            (
                max,
                1,
                glw::GL_INVALID_VALUE,
                "viewportArrayv, <first> == GL_MAX_VIEWPORTS",
            ),
            (
                1,
                max_viewports - 1,
                glw::GL_NO_ERROR,
                "viewportArrayv, <first> + <count> == GL_MAX_VIEWPORTS",
            ),
            (
                1,
                max_viewports,
                glw::GL_INVALID_VALUE,
                "viewportArrayv, <first> + <count> > GL_MAX_VIEWPORTS",
            ),
        ];
        for (first, count, expected, description) in array_cases {
            // SAFETY: `data` holds 4 floats per viewport; the invalid-range calls are rejected before reading.
            unsafe { gl.viewport_arrayv(first, count, data.as_ptr()) };
            check_gl_error(gl, expected, description, test_result);
        }

        let one = [0.0f32, 0.0, 1.0, 1.0];
        let indexed_cases: [(u32, GLenum, &str, &str); 4] = [
            (
                0,
                glw::GL_NO_ERROR,
                "viewportIndexedf, <index> == 0",
                "viewportIndexedfv, <index> == 0",
            ),
            (
                max - 1,
                glw::GL_NO_ERROR,
                "viewportIndexedf, <index> == GL_MAX_VIEWPORTS - 1",
                "viewportIndexedfv, <index> == GL_MAX_VIEWPORTS - 1",
            ),
            (
                max,
                glw::GL_INVALID_VALUE,
                "viewportIndexedf, <index> == GL_MAX_VIEWPORTS",
                "viewportIndexedfv, <index> == GL_MAX_VIEWPORTS",
            ),
            (
                max + 1,
                glw::GL_INVALID_VALUE,
                "viewportIndexedf, <index> > GL_MAX_VIEWPORTS",
                "viewportIndexedfv, <index> > GL_MAX_VIEWPORTS",
            ),
        ];
        for (index, expected, description_f, _) in indexed_cases {
            // SAFETY: plain state call on the current context.
            unsafe { gl.viewport_indexedf(index, 0.0, 0.0, 1.0, 1.0) };
            check_gl_error(gl, expected, description_f, test_result);
        }
        for (index, expected, _, description_fv) in indexed_cases {
            // SAFETY: `one` holds the four floats of a viewport.
            unsafe { gl.viewport_indexedfv(index, one.as_ptr()) };
            check_gl_error(gl, expected, description_fv, test_result);
        }

        // SAFETY: state calls on the current context.
        unsafe { gl.viewport(0, 0, -1, 1) };
        check_gl_error(gl, glw::GL_INVALID_VALUE, "viewport, negative width", test_result);
        // SAFETY: as above.
        unsafe { gl.viewport(0, 0, 1, -1) };
        check_gl_error(gl, glw::GL_INVALID_VALUE, "viewport, negative height", test_result);

        for i in 0..n {
            let mut data = vec![0.0f32; n * 4];
            for j in 0..n {
                data[j * 4] = 0.0;
                data[j * 4 + 1] = 0.0;
                data[j * 4 + 2] = 1.0;
                data[j * 4 + 3] = 1.0;
            }

            data[i * 4 + 2] = -1.0;
            // SAFETY: `data` holds 4 floats per viewport.
            unsafe { gl.viewport_arrayv(0, max_viewports, data.as_ptr()) };
            check_gl_error(gl, glw::GL_INVALID_VALUE, "viewportArrayv, negative width", test_result);
            // SAFETY: plain state call.
            unsafe { gl.viewport_indexedf(i as u32, 0.0, 0.0, -1.0, 1.0) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "viewportIndexedf, negative width",
                test_result,
            );
            // SAFETY: points at the four floats of viewport `i`.
            unsafe { gl.viewport_indexedfv(i as u32, data[i * 4..].as_ptr()) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "viewportIndexedfv, negative width",
                test_result,
            );

            data[i * 4 + 2] = 1.0;
            data[i * 4 + 3] = -1.0;
            // SAFETY: as above.
            unsafe { gl.viewport_arrayv(0, max_viewports, data.as_ptr()) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "viewportArrayv, negative height",
                test_result,
            );
            // SAFETY: plain state call.
            unsafe { gl.viewport_indexedf(i as u32, 0.0, 0.0, 1.0, -1.0) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "viewportIndexedf, negative height",
                test_result,
            );
            // SAFETY: points at the four floats of viewport `i`.
            unsafe { gl.viewport_indexedfv(i as u32, data[i * 4..].as_ptr()) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "viewportIndexedfv, negative height",
                test_result,
            );
        }
    }

    fn scissor_errors(gl: &glw::Functions, max_viewports: GLint, test_result: &mut bool) {
        let n = max_viewports as usize;
        let max = max_viewports as u32;

        let mut data = vec![0 as GLint; n * 4];
        for i in 0..n {
            data[i * 4] = 0;
            data[i * 4 + 1] = 0;
            data[i * 4 + 2] = 1;
            data[i * 4 + 3] = 1;
        }
        let array_cases: [(u32, GLint, GLenum, &str); 4] = [
            (
                0,
                max_viewports - 1,
                glw::GL_NO_ERROR,
                "scissorArrayv, correct parameters",
            ),
            (
                max,
                1,
                glw::GL_INVALID_VALUE,
                "scissorArrayv, <first> == GL_MAX_VIEWPORTS",
            ),
            (
                1,
                max_viewports - 1,
                glw::GL_NO_ERROR,
                "scissorArrayv, <first> + <count> == GL_MAX_VIEWPORTS",
            ),
            (
                1,
                max_viewports,
                glw::GL_INVALID_VALUE,
                "scissorArrayv, <first> + <count> > GL_MAX_VIEWPORTS",
            ),
        ];
        for (first, count, expected, description) in array_cases {
            // SAFETY: `data` holds 4 ints per viewport; the invalid-range calls are rejected before reading.
            unsafe { gl.scissor_arrayv(first, count, data.as_ptr()) };
            check_gl_error(gl, expected, description, test_result);
        }

        let one: [GLint; 4] = [0, 0, 1, 1];
        let indexed_cases: [(u32, GLenum, &str, &str); 4] = [
            (
                0,
                glw::GL_NO_ERROR,
                "scissorIndexed, <index> == 0",
                "scissorIndexedv, <index> == 0",
            ),
            (
                max - 1,
                glw::GL_NO_ERROR,
                "scissorIndexed, <index> == GL_MAX_VIEWPORTS - 1",
                "scissorIndexedv, <index> == GL_MAX_VIEWPORTS - 1",
            ),
            (
                max,
                glw::GL_INVALID_VALUE,
                "scissorIndexed, <index> == GL_MAX_VIEWPORTS",
                "scissorIndexedv, <index> == GL_MAX_VIEWPORTS",
            ),
            (
                max + 1,
                glw::GL_INVALID_VALUE,
                "scissorIndexed, <index> > GL_MAX_VIEWPORTS",
                "scissorIndexedv, <index> > GL_MAX_VIEWPORTS",
            ),
        ];
        for (index, expected, description_f, _) in indexed_cases {
            // SAFETY: plain state call on the current context.
            unsafe { gl.scissor_indexed(index, 0, 0, 1, 1) };
            check_gl_error(gl, expected, description_f, test_result);
        }
        for (index, expected, _, description_fv) in indexed_cases {
            // SAFETY: `one` holds the four ints of a scissor box.
            unsafe { gl.scissor_indexedv(index, one.as_ptr()) };
            check_gl_error(gl, expected, description_fv, test_result);
        }

        // SAFETY: state calls on the current context.
        unsafe { gl.scissor(0, 0, -1, 1) };
        check_gl_error(gl, glw::GL_INVALID_VALUE, "scissor, negative width", test_result);
        // SAFETY: as above.
        unsafe { gl.scissor(0, 0, 1, -1) };
        check_gl_error(gl, glw::GL_INVALID_VALUE, "scissor, negative height", test_result);

        for i in 0..n {
            let mut data = vec![0 as GLint; n * 4];
            for j in 0..n {
                data[j * 4] = 0;
                data[j * 4 + 1] = 0;
                data[j * 4 + 2] = 1;
                data[j * 4 + 3] = 1;
            }

            data[i * 4 + 2] = -1;
            // SAFETY: `data` holds 4 ints per viewport.
            unsafe { gl.scissor_arrayv(0, max_viewports, data.as_ptr()) };
            check_gl_error(gl, glw::GL_INVALID_VALUE, "scissorArrayv, negative width", test_result);
            // SAFETY: plain state call.
            unsafe { gl.scissor_indexed(i as u32, 0, 0, -1, 1) };
            check_gl_error(gl, glw::GL_INVALID_VALUE, "scissorIndexed, negative width", test_result);
            // SAFETY: points at the four ints of box `i`.
            unsafe { gl.scissor_indexedv(i as u32, data[i * 4..].as_ptr()) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "scissorIndexedv, negative width",
                test_result,
            );

            data[i * 4 + 2] = 1;
            data[i * 4 + 3] = -1;
            // SAFETY: as above.
            unsafe { gl.scissor_arrayv(0, max_viewports, data.as_ptr()) };
            check_gl_error(gl, glw::GL_INVALID_VALUE, "scissorArrayv, negative height", test_result);
            // SAFETY: plain state call.
            unsafe { gl.scissor_indexed(i as u32, 0, 0, 1, -1) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "scissorIndexed, negative height",
                test_result,
            );
            // SAFETY: points at the four ints of box `i`.
            unsafe { gl.scissor_indexedv(i as u32, data[i * 4..].as_ptr()) };
            check_gl_error(
                gl,
                glw::GL_INVALID_VALUE,
                "scissorIndexedv, negative height",
                test_result,
            );
        }
    }

    fn indexed_state_errors(gl: &glw::Functions, max_viewports: GLint, test_result: &mut bool) {
        let max = max_viewports as u32;

        // SAFETY: state calls on the current context.
        unsafe { gl.disablei(glw::GL_SCISSOR_TEST, max - 1) };
        check_gl_error(
            gl,
            glw::GL_NO_ERROR,
            "disablei, <index> == GL_MAX_VIEWPORTS - 1",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.disablei(glw::GL_SCISSOR_TEST, max) };
        check_gl_error(
            gl,
            glw::GL_INVALID_VALUE,
            "disablei, <index> == GL_MAX_VIEWPORTS",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.enablei(glw::GL_SCISSOR_TEST, max - 1) };
        check_gl_error(
            gl,
            glw::GL_NO_ERROR,
            "enablei, <index> == GL_MAX_VIEWPORTS - 1",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.enablei(glw::GL_SCISSOR_TEST, max) };
        check_gl_error(
            gl,
            glw::GL_INVALID_VALUE,
            "enablei, <index> == GL_MAX_VIEWPORTS",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.is_enabledi(glw::GL_SCISSOR_TEST, max - 1) };
        check_gl_error(
            gl,
            glw::GL_NO_ERROR,
            "isEnabledi, <index> == GL_MAX_VIEWPORTS - 1",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.is_enabledi(glw::GL_SCISSOR_TEST, max) };
        check_gl_error(
            gl,
            glw::GL_INVALID_VALUE,
            "isEnabledi, <index> == GL_MAX_VIEWPORTS",
            test_result,
        );

        let mut int_data = [0 as GLint; 4];
        // SAFETY: `int_data` holds the four ints of SCISSOR_BOX.
        unsafe { gl.get_integeri_v(glw::GL_SCISSOR_BOX, max - 1, int_data.as_mut_ptr()) };
        check_gl_error(
            gl,
            glw::GL_NO_ERROR,
            "getIntegeri_v, <index> == GL_MAX_VIEWPORTS - 1",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.get_integeri_v(glw::GL_SCISSOR_BOX, max, int_data.as_mut_ptr()) };
        check_gl_error(
            gl,
            glw::GL_INVALID_VALUE,
            "getIntegeri_v, <index> == GL_MAX_VIEWPORTS",
            test_result,
        );

        let mut float_data = [0.0f32; 4];
        // SAFETY: `float_data` holds the four floats of VIEWPORT.
        unsafe { gl.get_floati_v(glw::GL_VIEWPORT, max - 1, float_data.as_mut_ptr()) };
        check_gl_error(
            gl,
            glw::GL_NO_ERROR,
            "getFloati_v, <index> == GL_MAX_VIEWPORTS - 1",
            test_result,
        );
        // SAFETY: as above.
        unsafe { gl.get_floati_v(glw::GL_VIEWPORT, max, float_data.as_mut_ptr()) };
        check_gl_error(
            gl,
            glw::GL_INVALID_VALUE,
            "getFloati_v, <index> == GL_MAX_VIEWPORTS",
            test_result,
        );
    }
}

impl TestCase for ApiErrors {
    fn name(&self) -> &str {
        "api_errors"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_viewport_array_supported {
            return Err(TestError::NotSupported(VIEWPORT_ARRAY_NOT_SUPPORTED.to_string()));
        }

        let mut test_result = true;

        let mut max_viewports: GLint = 0;
        // SAFETY: writes one int.
        unsafe { gl.get_integerv(glw::GL_MAX_VIEWPORTS, &mut max_viewports) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        Self::depth_range_array_helper(gl, max_viewports, &mut test_result);
        Self::depth_range_indexed_helper(gl, max_viewports, &mut test_result);
        Self::viewport_errors(gl, max_viewports, &mut test_result);
        Self::scissor_errors(gl, max_viewports, &mut test_result);
        Self::indexed_state_errors(gl, max_viewports, &mut test_result);
        Self::get_depth_helper(gl, max_viewports, &mut test_result);

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ViewportArrayTests::init`
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("viewport_array");
    group.add_child(Box::new(ApiErrors { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(api_tests::Queries { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(api_tests::ViewportApi { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(api_tests::ScissorApi { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(api_tests::DepthRangeApi { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(api_tests::ScissorTestStateApi { ext_params }) as Box<dyn TestCase>);
    for kind in [
        draw_tests::Kind::DrawToSingleLayerWithMultipleViewports,
        draw_tests::Kind::DynamicViewportIndex,
        draw_tests::Kind::DrawMulitpleViewportsWithSingleInvocation,
        draw_tests::Kind::ViewportIndexSubroutine,
        draw_tests::Kind::DrawMultipleLayers,
        draw_tests::Kind::Scissor,
        draw_tests::Kind::ScissorZeroDimension,
        draw_tests::Kind::ScissorClear,
        draw_tests::Kind::DepthRange,
        draw_tests::Kind::DepthRangeDepthTest,
        draw_tests::Kind::ProvokingVertex,
    ] {
        group.add_child(Box::new(draw_tests::DrawCase { ext_params, kind }) as Box<dyn TestCase>);
    }
    group
}
