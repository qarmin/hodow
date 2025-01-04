// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcViewportArrayTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop core only (the Khronos roots never run the ES branches).

use super::VIEWPORT_ARRAY_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const N_ELEMENTS_VIEWPORT: usize = 4;
const N_ELEMENTS_DEPTH_RANGE: usize = 2;

fn result_status(test_result: bool) -> TestOutcome {
    Ok(if test_result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

fn check_supported(context: &Context, ext_params: ExtParameters) -> Result<(), TestError> {
    let base = TestCaseBase::init(context, ext_params);
    if !base.is_viewport_array_supported {
        return Err(TestError::NotSupported(VIEWPORT_ARRAY_NOT_SUPPORTED.to_string()));
    }
    Ok(())
}

fn get_max_viewports(gl: &glw::Functions) -> Result<GLint, TestError> {
    let mut max_viewports: GLint = 0;
    // SAFETY: writes one int.
    unsafe { gl.get_integerv(glw::GL_MAX_VIEWPORTS, &mut max_viewports) };
    glu::expect_no_error(gl, "GetIntegerv")?;
    Ok(max_viewports)
}

fn compare_sets<T: PartialEq + std::fmt::Display>(left: &[T], right: &[T], description: &str, out_result: &mut bool) {
    for (i, (l, r)) in left.iter().zip(right.iter()).enumerate() {
        if l != r {
            log::info!("Test case: {description} Invalid values [{i}] {l} {r}");
            *out_result = false;
        }
    }
}

/// `Queries`
pub(super) struct Queries {
    pub ext_params: ExtParameters,
}

impl Queries {
    /// `Queries::depthRangeInitialValuesHelper<GLdouble>`
    fn depth_range_initial_values_helper(
        gl: &glw::Functions,
        max_viewports: GLint,
        test_result: &mut bool,
    ) -> Result<(), TestError> {
        let mut data = vec![0.0f64; max_viewports as usize * 2];
        for i in 0..max_viewports {
            // SAFETY: writes the two doubles of index `i`, inside `data`.
            unsafe { gl.get_doublei_v(glw::GL_DEPTH_RANGE, i as u32, data[i as usize * 2..].as_mut_ptr()) };
            glu::expect_no_error(gl, "getDouble/Floati_v")?;
        }

        for i in 0..max_viewports as usize {
            let near = data[2 * i] as GLint;
            let far = data[2 * i + 1] as GLint;

            if near != 0 || far != 1 {
                log::info!("Invalid initial depth range [{i}]: {near} : {far} expected: 0.0 : 1.0");
                *test_result = false;
                break;
            }
        }
        Ok(())
    }
}

impl TestCase for Queries {
    fn name(&self) -> &str {
        "queries"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_supported(context, self.ext_params)?;
        let gl = context.gl();

        let mut test_result = true;

        let mut layer_provoking_vertex: GLint = 0;
        let mut max_renderbuffer_size = 0.0f32;
        let mut max_viewport_dims = [0.0f32; 2];
        let mut viewport_bounds_range = [0.0f32; 2];
        let mut viewport_provoking_vertex: GLint = 0;
        let mut viewport_subpixel_bits: GLint = -1;

        // SAFETY: each query writes the number of values its pname defines into the matching local.
        unsafe { gl.get_integerv(glw::GL_LAYER_PROVOKING_VERTEX, &mut layer_provoking_vertex) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let max_viewports = get_max_viewports(gl)?;

        // SAFETY: as above.
        unsafe { gl.get_floatv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_renderbuffer_size) };
        glu::expect_no_error(gl, "getFloatv")?;

        // SAFETY: as above.
        unsafe { gl.get_floatv(glw::GL_MAX_VIEWPORT_DIMS, max_viewport_dims.as_mut_ptr()) };
        glu::expect_no_error(gl, "GetFloatv")?;

        // SAFETY: as above.
        unsafe { gl.get_floatv(glw::GL_VIEWPORT_BOUNDS_RANGE, viewport_bounds_range.as_mut_ptr()) };
        glu::expect_no_error(gl, "GetFloatv")?;

        // SAFETY: as above.
        unsafe { gl.get_integerv(glw::GL_VIEWPORT_INDEX_PROVOKING_VERTEX, &mut viewport_provoking_vertex) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        // SAFETY: as above.
        unsafe { gl.get_integerv(glw::GL_VIEWPORT_SUBPIXEL_BITS, &mut viewport_subpixel_bits) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let target = context.render_target();
        let window_width = target.width;
        let window_height = target.height;

        // Initial dimensions of VIEWPORT returned by GetFloati_v match the window
        {
            let mut data = vec![0.0f32; max_viewports as usize * 4];
            for i in 0..max_viewports {
                // SAFETY: writes the four floats of index `i`, inside `data`.
                unsafe { gl.get_floati_v(glw::GL_VIEWPORT, i as u32, data[i as usize * 4..].as_mut_ptr()) };
                glu::expect_no_error(gl, "GetFloati_v")?;
            }

            for i in 0..max_viewports as usize {
                let viewport_width = data[4 * i + 2] as GLint;
                let viewport_height = data[4 * i + 3] as GLint;

                if window_width != viewport_width || window_height != viewport_height {
                    log::info!(
                        "Invalid initial viewport [{i}] dimennsions: {viewport_width} x {viewport_height} expected: {window_width} x {window_height}"
                    );
                    test_result = false;
                    break;
                }
            }
        }

        // Initial values of DEPTH_RANGE returned by GetDoublei_v are [0, 1]
        Self::depth_range_initial_values_helper(gl, max_viewports, &mut test_result)?;

        // Initial state of SCISSOR_TEST returned by IsEnabledi is FALSE
        for i in 0..max_viewports {
            // SAFETY: plain state query.
            if glw::FALSE != unsafe { gl.is_enabledi(glw::GL_SCISSOR_TEST, i as u32) } {
                log::info!("Scissor test is enabled at {i}. Expected disabled.");
                test_result = false;
                break;
            }
        }

        // Initial dimensions of SCISSOR_BOX returned by GetIntegeri_v match the window
        {
            let mut data = vec![0 as GLint; max_viewports as usize * 4];
            for i in 0..max_viewports {
                // SAFETY: writes the four ints of index `i`, inside `data`.
                unsafe { gl.get_integeri_v(glw::GL_SCISSOR_BOX, i as u32, data[i as usize * 4..].as_mut_ptr()) };
                glu::expect_no_error(gl, "getIntegeri_v")?;
            }

            for i in 0..max_viewports as usize {
                let scissor_width = data[4 * i + 2];
                let scissor_height = data[4 * i + 3];

                if window_width != scissor_width || window_height != scissor_height {
                    log::info!(
                        "Invalid initial scissor box [{i}] dimennsions: {scissor_width} x {scissor_height} expected: {window_width} x {window_height}"
                    );
                    test_result = false;
                    break;
                }
            }
        }

        // MAX_VIEWPORT_DIMS is at least as big as MAX_RENDERBUFFER_SIZE
        if max_viewport_dims[0] < max_renderbuffer_size || max_viewport_dims[1] < max_renderbuffer_size {
            log::info!(
                "Invalid MAX_VIEWPORT_DIMS: {} x {} expected: {max_renderbuffer_size} x {max_renderbuffer_size}",
                max_viewport_dims[0],
                max_viewport_dims[1]
            );
            test_result = false;
        }

        if max_viewports < 16 {
            log::info!("Invalid MAX_VIEWPORTS: {max_viewports} expected at least 16.");
            test_result = false;
        }

        if viewport_subpixel_bits < 0 {
            log::info!("Invalid VIEWPORT_SUBPIXEL_BITS: {viewport_subpixel_bits} expected at least 0.");
            test_result = false;
        }

        if viewport_bounds_range[0] > -32768.0 || viewport_bounds_range[1] < 32767.0 {
            log::info!(
                "Invalid VIEWPORT_BOUNDS_RANGE: {} : {} expected at least: -32768.0f : 32767.0f",
                viewport_bounds_range[0],
                viewport_bounds_range[1]
            );
            test_result = false;
        }

        let is_provoking_vertex = |value: GLint| {
            matches!(
                value as u32,
                glw::GL_FIRST_VERTEX_CONVENTION
                    | glw::GL_LAST_VERTEX_CONVENTION
                    | glw::GL_PROVOKING_VERTEX
                    | glw::GL_UNDEFINED_VERTEX
            )
        };
        if !is_provoking_vertex(layer_provoking_vertex) {
            log::info!("Invalid LAYER_PROVOKING_VERTEX: {layer_provoking_vertex}");
            test_result = false;
        }
        // Upstream logs layer_provoking_vertex here too (copy-paste); only the log text differs
        if !is_provoking_vertex(viewport_provoking_vertex) {
            log::info!("Invalid LAYER_PROVOKING_VERTEX: {layer_provoking_vertex}");
            test_result = false;
        }

        result_status(test_result)
    }
}

/// `ViewportAPI`
pub(super) struct ViewportApi {
    pub ext_params: ExtParameters,
}

impl ViewportApi {
    /// `ViewportAPI::getViewports`
    fn get_viewports(gl: &glw::Functions, max_viewports: GLint, out_data: &mut [f32]) -> Result<(), TestError> {
        for i in 0..max_viewports as usize {
            // SAFETY: writes the four floats of index `i`, inside `out_data`.
            unsafe { gl.get_floati_v(glw::GL_VIEWPORT, i as u32, out_data[i * 4..].as_mut_ptr()) };
            glu::expect_no_error(gl, "getFloati_v")?;
        }
        Ok(())
    }
}

impl TestCase for ViewportApi {
    fn name(&self) -> &str {
        "viewport_api"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_supported(context, self.ext_params)?;
        let gl = context.gl();
        let mut test_result = true;

        let max_viewports = get_max_viewports(gl)?;
        let n = N_ELEMENTS_VIEWPORT;
        let count = max_viewports as usize;

        let mut data_a = vec![0.0f32; count * n];
        let mut data_b = vec![0.0f32; count * n];

        Self::get_viewports(gl, max_viewports, &mut data_a)?;

        for i in 0..count {
            data_a[i * n] += 0.125;
            data_a[i * n + 1] += 0.125;
            data_a[i * n + 2] -= 0.125;
            data_a[i * n + 3] -= 0.125;
        }

        // SAFETY: `data_a` holds four floats per viewport.
        unsafe { gl.viewport_arrayv(0, max_viewports, data_a.as_ptr()) };
        glu::expect_no_error(gl, "viewportArrayv")?;

        Self::get_viewports(gl, max_viewports, &mut data_b)?;
        compare_sets(&data_a, &data_b, "viewportArrayv", &mut test_result);

        for i in 0..count {
            data_b[i * n..i * n + 4].copy_from_slice(&[0.25, 0.25, 0.75, 0.75]);

            // SAFETY: plain state setter.
            unsafe { gl.viewport_indexedf(i as u32, 0.25, 0.25, 0.75, 0.75) };
            glu::expect_no_error(gl, "viewportIndexedf")?;

            Self::get_viewports(gl, max_viewports, &mut data_a)?;
            compare_sets(&data_a, &data_b, "viewportIndexedf", &mut test_result);
        }

        for i in 0..count {
            data_a[i * n..i * n + 4].copy_from_slice(&[0.375, 0.375, 0.625, 0.625]);

            // SAFETY: reads the four floats of index `i`, inside `data_a`.
            unsafe { gl.viewport_indexedfv(i as u32, data_a[i * n..].as_ptr()) };
            glu::expect_no_error(gl, "viewportIndexedfv")?;

            Self::get_viewports(gl, max_viewports, &mut data_b)?;
            compare_sets(&data_a, &data_b, "viewportIndexedfv", &mut test_result);
        }

        for i in 0..count {
            let value = if i % 2 == 0 { 1.0f32 } else { 0.25f32 };

            for j in (0..i).chain(i + 1..count) {
                data_b[j * n..j * n + 4].fill(value);
            }

            // SAFETY: `data_b` holds four floats per viewport.
            unsafe { gl.viewport_arrayv(0, max_viewports, data_b.as_ptr()) };
            glu::expect_no_error(gl, "viewportArrayv")?;

            Self::get_viewports(gl, max_viewports, &mut data_a)?;
            compare_sets(&data_a, &data_b, "viewportArrayv", &mut test_result);
        }

        for i in 0..count {
            data_a[i * n..i * n + 4].copy_from_slice(&[0.0, 0.0, 1.0, 1.0]);
        }

        // SAFETY: plain state setter.
        unsafe { gl.viewport(0, 0, 1, 1) };
        glu::expect_no_error(gl, "viewport")?;

        Self::get_viewports(gl, max_viewports, &mut data_b)?;
        compare_sets(&data_a, &data_b, "viewport", &mut test_result);

        result_status(test_result)
    }
}

/// `ScissorAPI`
pub(super) struct ScissorApi {
    pub ext_params: ExtParameters,
}

impl ScissorApi {
    /// `ScissorAPI::getScissorBoxes`
    fn get_scissor_boxes(gl: &glw::Functions, max_viewports: GLint, out_data: &mut [GLint]) -> Result<(), TestError> {
        for i in 0..max_viewports as usize {
            // SAFETY: writes the four ints of index `i`, inside `out_data`.
            unsafe { gl.get_integeri_v(glw::GL_SCISSOR_BOX, i as u32, out_data[i * 4..].as_mut_ptr()) };
            glu::expect_no_error(gl, "getIntegeri_v")?;
        }
        Ok(())
    }
}

impl TestCase for ScissorApi {
    fn name(&self) -> &str {
        "scissor_api"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_supported(context, self.ext_params)?;
        let gl = context.gl();
        let mut test_result = true;

        let max_viewports = get_max_viewports(gl)?;
        let n = N_ELEMENTS_VIEWPORT;
        let count = max_viewports as usize;

        let mut data_a = vec![0 as GLint; count * n];
        let mut data_b = vec![0 as GLint; count * n];

        Self::get_scissor_boxes(gl, max_viewports, &mut data_a)?;

        for i in 0..count {
            data_a[i * n] += 1;
            data_a[i * n + 1] += 1;
            data_a[i * n + 2] -= 1;
            data_a[i * n + 3] -= 1;
        }

        // SAFETY: `data_a` holds four ints per viewport.
        unsafe { gl.scissor_arrayv(0, max_viewports, data_a.as_ptr()) };
        glu::expect_no_error(gl, "scissorArrayv")?;

        Self::get_scissor_boxes(gl, max_viewports, &mut data_b)?;
        compare_sets(&data_a, &data_b, "scissorArrayv", &mut test_result);

        for i in 0..count {
            data_b[i * n..i * n + 4].copy_from_slice(&[4, 4, 8, 8]);

            // SAFETY: plain state setter.
            unsafe { gl.scissor_indexed(i as u32, 4, 4, 8, 8) };
            glu::expect_no_error(gl, "scissorIndexed")?;

            Self::get_scissor_boxes(gl, max_viewports, &mut data_a)?;
            compare_sets(&data_a, &data_b, "scissorIndexed", &mut test_result);
        }

        for i in 0..count {
            data_a[i * n..i * n + 4].copy_from_slice(&[8, 8, 12, 12]);

            // SAFETY: reads the four ints of index `i`, inside `data_a`.
            unsafe { gl.scissor_indexedv(i as u32, data_a[i * n..].as_ptr()) };
            glu::expect_no_error(gl, "scissorIndexedv")?;

            Self::get_scissor_boxes(gl, max_viewports, &mut data_b)?;
            compare_sets(&data_a, &data_b, "scissorIndexedv", &mut test_result);
        }

        for i in 0..count {
            let value: GLint = if i % 2 == 0 { 1 } else { 4 };

            for j in (0..i).chain(i + 1..count) {
                data_b[j * n..j * n + 4].fill(value);
            }

            // SAFETY: `data_b` holds four ints per viewport.
            unsafe { gl.scissor_arrayv(0, max_viewports, data_b.as_ptr()) };
            glu::expect_no_error(gl, "scissorArrayv")?;

            Self::get_scissor_boxes(gl, max_viewports, &mut data_a)?;
            compare_sets(&data_a, &data_b, "scissorArrayv", &mut test_result);
        }

        for i in 0..count {
            data_a[i * n..i * n + 4].copy_from_slice(&[0, 0, 1, 1]);
        }

        // SAFETY: plain state setter.
        unsafe { gl.scissor(0, 0, 1, 1) };
        glu::expect_no_error(gl, "scissor")?;

        Self::get_scissor_boxes(gl, max_viewports, &mut data_b)?;
        compare_sets(&data_a, &data_b, "scissor", &mut test_result);

        result_status(test_result)
    }
}

/// `DepthRangeAPI`
pub(super) struct DepthRangeApi {
    pub ext_params: ExtParameters,
}

impl DepthRangeApi {
    /// `DepthRangeAPI::getDepthRanges<GLdouble>`
    fn get_depth_ranges(gl: &glw::Functions, max_viewports: GLint, out_data: &mut [f64]) -> Result<(), TestError> {
        for i in 0..max_viewports as usize {
            // SAFETY: writes the two doubles of index `i`, inside `out_data`.
            unsafe {
                gl.get_doublei_v(
                    glw::GL_DEPTH_RANGE,
                    i as u32,
                    out_data[i * N_ELEMENTS_DEPTH_RANGE..].as_mut_ptr(),
                )
            };
            glu::expect_no_error(gl, "getDouble/Floati_v")?;
        }
        Ok(())
    }
}

impl TestCase for DepthRangeApi {
    fn name(&self) -> &str {
        "depth_range_api"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_supported(context, self.ext_params)?;
        let gl = context.gl();
        let mut test_result = true;

        let max_viewports = get_max_viewports(gl)?;
        let n = N_ELEMENTS_DEPTH_RANGE;
        let count = max_viewports as usize;

        let mut data_a = vec![0.0f64; count * n];
        let mut data_b = vec![0.0f64; count * n];

        Self::get_depth_ranges(gl, max_viewports, &mut data_a)?;

        for i in 0..count {
            data_a[i * n] += 0.125;
            data_a[i * n + 1] -= 0.125;
        }

        // SAFETY: `data_a` holds two doubles per viewport.
        unsafe { gl.depth_range_arrayv(0, max_viewports, data_a.as_ptr()) };
        glu::expect_no_error(gl, "depthRangeArray")?;

        Self::get_depth_ranges(gl, max_viewports, &mut data_b)?;
        compare_sets(&data_a, &data_b, "depthRangeArray", &mut test_result);

        for i in 0..count {
            data_b[i * n] = 0.25;
            data_b[i * n + 1] = 0.75;

            // SAFETY: plain state setter.
            unsafe { gl.depth_range_indexed(i as u32, 0.25, 0.75) };
            glu::expect_no_error(gl, "depthRangeIndexed")?;

            Self::get_depth_ranges(gl, max_viewports, &mut data_a)?;
            compare_sets(&data_a, &data_b, "depthRangeIndexed", &mut test_result);
        }

        for i in 0..count {
            let value = if i % 2 == 0 { 1.0f64 } else { 0.25f64 };

            for j in (0..i).chain(i + 1..count) {
                data_b[j * n] = value;
                data_b[j * n + 1] = value;
            }

            // SAFETY: `data_b` holds two doubles per viewport.
            unsafe { gl.depth_range_arrayv(0, max_viewports, data_b.as_ptr()) };
            glu::expect_no_error(gl, "depthRangeArray")?;

            Self::get_depth_ranges(gl, max_viewports, &mut data_a)?;
            compare_sets(&data_a, &data_b, "depthRangeArray", &mut test_result);
        }

        for i in 0..count {
            data_a[i * n] = 0.0;
            data_a[i * n + 1] = 1.0;
        }

        // SAFETY: plain state setter.
        unsafe { gl.depth_range(0.0, 1.0) };
        glu::expect_no_error(gl, "depthRange")?;

        Self::get_depth_ranges(gl, max_viewports, &mut data_b)?;
        compare_sets(&data_a, &data_b, "depthRange", &mut test_result);

        result_status(test_result)
    }
}

/// `ScissorTestStateAPI`
pub(super) struct ScissorTestStateApi {
    pub ext_params: ExtParameters,
}

impl ScissorTestStateApi {
    /// `ScissorTestStateAPI::getScissorTestStates`
    fn get_scissor_test_states(
        gl: &glw::Functions,
        max_viewports: GLint,
        out_data: &mut [glw::GLboolean],
    ) -> Result<(), TestError> {
        for i in 0..max_viewports as usize {
            // SAFETY: plain state query.
            out_data[i] = unsafe { gl.is_enabledi(glw::GL_SCISSOR_TEST, i as u32) };
            glu::expect_no_error(gl, "isEnabledi")?;
        }
        Ok(())
    }

    fn toggle_all(
        gl: &glw::Functions,
        max_viewports: GLint,
        states_a: &mut [glw::GLboolean],
        states_b: &mut [glw::GLboolean],
        description: &str,
        test_result: &mut bool,
    ) -> Result<(), TestError> {
        for i in 0..max_viewports as usize {
            if states_a[i] == glw::FALSE {
                // SAFETY: plain state setter.
                unsafe { gl.enablei(glw::GL_SCISSOR_TEST, i as u32) };
                glu::expect_no_error(gl, "Enablei")?;
                states_a[i] = glw::TRUE;
            } else {
                // SAFETY: plain state setter.
                unsafe { gl.disablei(glw::GL_SCISSOR_TEST, i as u32) };
                glu::expect_no_error(gl, "Disablei")?;
                states_a[i] = glw::FALSE;
            }

            Self::get_scissor_test_states(gl, max_viewports, states_b)?;
            compare_sets(states_a, states_b, description, test_result);
        }
        Ok(())
    }
}

impl TestCase for ScissorTestStateApi {
    fn name(&self) -> &str {
        "scissor_test_state_api"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_supported(context, self.ext_params)?;
        let gl = context.gl();
        let mut test_result = true;

        let max_viewports = get_max_viewports(gl)?;
        let count = max_viewports as usize;

        let mut states_a = vec![glw::FALSE; count];
        let mut states_b = vec![glw::FALSE; count];

        Self::get_scissor_test_states(gl, max_viewports, &mut states_a)?;
        Self::toggle_all(
            gl,
            max_viewports,
            &mut states_a,
            &mut states_b,
            "1st toggle",
            &mut test_result,
        )?;
        Self::toggle_all(
            gl,
            max_viewports,
            &mut states_a,
            &mut states_b,
            "2nd toggle",
            &mut test_result,
        )?;

        states_a.fill(glw::TRUE);
        // SAFETY: plain state setter.
        unsafe { gl.enable(glw::GL_SCISSOR_TEST) };
        glu::expect_no_error(gl, "Enable")?;
        Self::get_scissor_test_states(gl, max_viewports, &mut states_b)?;
        compare_sets(&states_a, &states_b, "1st enable all", &mut test_result);

        states_a.fill(glw::FALSE);
        // SAFETY: plain state setter.
        unsafe { gl.disable(glw::GL_SCISSOR_TEST) };
        glu::expect_no_error(gl, "Disable")?;
        Self::get_scissor_test_states(gl, max_viewports, &mut states_b)?;
        compare_sets(&states_a, &states_b, "Disable all", &mut test_result);

        states_a.fill(glw::TRUE);
        // SAFETY: plain state setter.
        unsafe { gl.enable(glw::GL_SCISSOR_TEST) };
        glu::expect_no_error(gl, "Enable")?;
        Self::get_scissor_test_states(gl, max_viewports, &mut states_b)?;
        compare_sets(&states_a, &states_b, "2nd enable all", &mut test_result);

        result_status(test_result)
    }
}
