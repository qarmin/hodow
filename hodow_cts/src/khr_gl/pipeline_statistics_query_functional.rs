// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cPipelineStatisticsQueryTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `PipelineStatisticsQueryUtilities::executeQuery`/`verifyResultValues`, `PipelineStatisticsQueryTestFunctionalBase::iterate`/`deinit` (`iterate_functional`, shared with `pipeline_statistics_query_draw`) and `PipelineStatisticsQueryTestFunctional1` and `2`; the log texts of `verifyResultValues` are shortened.

use super::pipeline_statistics_query_tests::{
    QUERY_TARGETS, check_extension, is_query_supported, string_for_enum, verdict,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome};

const QO_BO_INT_OFFSET: usize = 0;
const QO_BO_INT64_OFFSET: usize = 8;
const QO_BO_UINT_OFFSET: usize = 16;
const QO_BO_UINT64_OFFSET: usize = 24;
const QO_BO_SIZE: usize = 32;

/// `PipelineStatisticsQueryUtilities::_test_execution_result`
pub(super) struct TestExecutionResult {
    result_int: i32,
    result_int64: i64,
    result_uint: u32,
    result_uint64: u64,
    int64_written: bool,
    uint64_written: bool,
    result_qo_int: i32,
    result_qo_int64: i64,
    result_qo_uint: u32,
    result_qo_uint64: u64,
}

impl Default for TestExecutionResult {
    fn default() -> Self {
        Self {
            result_int: i32::MAX,
            result_int64: i64::MAX,
            result_uint: u32::MAX,
            result_uint64: u64::MAX,
            int64_written: false,
            uint64_written: false,
            result_qo_int: i32::MAX,
            result_qo_int64: i64::MAX,
            result_qo_uint: u32::MAX,
            result_qo_uint64: u64::MAX,
        }
    }
}

/// `PipelineStatisticsQueryUtilities::_verification_type`
#[derive(Clone, Copy, PartialEq)]
pub(super) enum VerificationType {
    ExactMatch,
    EqualOrGreater,
}

/// What `executeQuery` returns through its `bool` result and its `skipped` out parameter.
pub(super) struct QueryExecution {
    pub ok: bool,
    pub skipped: bool,
}

fn fail_execution(message: String) -> Result<QueryExecution, TestError> {
    log::info!("{message}");
    Ok(QueryExecution {
        ok: false,
        skipped: false,
    })
}

/// `PipelineStatisticsQueryUtilities::executeQuery`; `draw` is `pfn_draw` with its user argument captured.
pub(super) fn execute_query(
    context: &Context,
    query_type: GLenum,
    qo_id: GLuint,
    mut qo_bo_id: GLuint,
    draw: Option<&mut dyn FnMut() -> Result<(), TestError>>,
    out_result: &mut TestExecutionResult,
) -> Result<QueryExecution, TestError> {
    let gl = context.gl();
    let mut n_query_bits: GLint = 0;
    // SAFETY: the value is written to the live local.
    unsafe { gl.get_queryiv(query_type, glw::GL_QUERY_COUNTER_BITS, &mut n_query_bits) };
    // SAFETY: plain state query.
    let error_code = unsafe { gl.get_error() };
    if error_code != glw::GL_NO_ERROR {
        return fail_execution(format!(
            "glGetQueryiv() call failed for GL_QUERY_COUNTER_BITS pname and {}query target.",
            string_for_enum(query_type)
        ));
    }
    if n_query_bits == 0 {
        log::info!(
            "Skipping [{}]: zero bits available for counter storage",
            string_for_enum(query_type)
        );
        return Ok(QueryExecution {
            ok: true,
            skipped: true,
        });
    }

    // SAFETY: a plain query call on the caller's query object.
    unsafe { gl.begin_query(query_type, qo_id) };
    // SAFETY: plain state query.
    let error_code = unsafe { gl.get_error() };
    if error_code != glw::GL_NO_ERROR {
        return fail_execution(format!(
            "A valid glBeginQuery() call generated the following error code:[{error_code}]"
        ));
    }

    if context
        .context_info
        .is_extension_supported("GL_ARB_query_buffer_object")
        && qo_bo_id != 0
    {
        // SAFETY: binds a buffer object created by the caller.
        unsafe { gl.bind_buffer(glw::GL_QUERY_BUFFER, qo_bo_id) };
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_NO_ERROR {
            log::info!(
                "Could not bind a buffer object to GL_QUERY_BUFFER buffer object binding point. Error reported:[{error_code}]"
            );
            // SAFETY: stops the query started above.
            unsafe { gl.end_query(query_type) };
            return Ok(QueryExecution {
                ok: false,
                skipped: false,
            });
        }
    } else {
        qo_bo_id = 0;
    }

    if let Some(draw) = draw {
        draw()?;
    }

    // SAFETY: ends the query started above.
    unsafe { gl.end_query(query_type) };
    // SAFETY: plain state query.
    let error_code = unsafe { gl.get_error() };
    if error_code != glw::GL_NO_ERROR {
        return fail_execution(format!("glEndQuery() call failed with error code[{error_code}]"));
    }

    let supports_64_bit = context.context_type().supports_core(3, 3);
    for n_iteration in 0..2 {
        let mut result_int: i32 = i32::MAX;
        let mut result_int64: i64 = i64::MAX;
        let mut result_uint: u32 = u32::MAX;
        let mut result_uint64: u64 = u64::MAX;

        if n_iteration == 1 && qo_bo_id == 0 {
            continue;
        }

        if n_iteration == 1 {
            // SAFETY: binds a buffer object created by the caller.
            unsafe { gl.bind_buffer(glw::GL_QUERY_BUFFER, qo_bo_id) };
        } else if qo_bo_id != 0 {
            // SAFETY: unbinds the query buffer.
            unsafe { gl.bind_buffer(glw::GL_QUERY_BUFFER, 0) };
        }
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_NO_ERROR {
            return fail_execution(format!(
                "glBindBuffer() call failed for GL_QUERY_BUFFER target with error [{error_code}]"
            ));
        }

        // With a query buffer bound, the pointer arguments are offsets into it.
        let (offset_int, offset_int64, offset_uint, offset_uint64) = if n_iteration == 0 {
            (
                &mut result_int as *mut i32,
                &mut result_int64 as *mut i64,
                &mut result_uint as *mut u32,
                &mut result_uint64 as *mut u64,
            )
        } else {
            (
                QO_BO_INT_OFFSET as *mut i32,
                QO_BO_INT64_OFFSET as *mut i64,
                QO_BO_UINT_OFFSET as *mut u32,
                QO_BO_UINT64_OFFSET as *mut u64,
            )
        };

        let mut result_int64_written = false;
        if supports_64_bit {
            // SAFETY: the pointer addresses a live local or, with a query buffer bound, an offset into it.
            unsafe { gl.get_query_objecti_64v(qo_id, glw::GL_QUERY_RESULT, offset_int64) };
            // SAFETY: plain state query.
            let error_code = unsafe { gl.get_error() };
            if error_code != glw::GL_NO_ERROR {
                return fail_execution(format!("glGetQueryObjecti64v() call failed with error [{error_code}]"));
            }
            result_int64_written = true;
        }

        // SAFETY: as above.
        unsafe { gl.get_query_objectiv(qo_id, glw::GL_QUERY_RESULT, offset_int) };
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_NO_ERROR {
            return fail_execution(format!("glGetQueryObjectiv() call failed with error [{error_code}]"));
        }

        let mut result_uint64_written = false;
        if supports_64_bit {
            // SAFETY: as above.
            unsafe { gl.get_query_objectui_64v(qo_id, glw::GL_QUERY_RESULT, offset_uint64) };
            // SAFETY: plain state query.
            let error_code = unsafe { gl.get_error() };
            if error_code != glw::GL_NO_ERROR {
                return fail_execution(format!("glGetQueryObjectui64v() call failed with error [{error_code}]"));
            }
            result_uint64_written = true;
        }

        // SAFETY: as above.
        unsafe { gl.get_query_objectuiv(qo_id, glw::GL_QUERY_RESULT, offset_uint) };
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_NO_ERROR {
            return fail_execution(format!("glGetQueryObjectuiv() call failed with error [{error_code}]"));
        }

        if n_iteration == 1 {
            // SAFETY: maps the query buffer bound above.
            let bo_data_ptr = unsafe { gl.map_buffer(glw::GL_QUERY_BUFFER, glw::GL_READ_ONLY) } as *const u8;
            // SAFETY: plain state query.
            let error_code = unsafe { gl.get_error() };
            if error_code != glw::GL_NO_ERROR || bo_data_ptr.is_null() {
                return fail_execution(format!(
                    "QO BO mapping failed with error [{error_code}] and data ptr returned:[{bo_data_ptr:?}]"
                ));
            }
            // SAFETY: the mapping covers the `QO_BO_SIZE` bytes the buffer was created with; the reads are unaligned-safe.
            unsafe {
                result_int = bo_data_ptr.add(QO_BO_INT_OFFSET).cast::<i32>().read_unaligned();
                result_int64 = bo_data_ptr.add(QO_BO_INT64_OFFSET).cast::<i64>().read_unaligned();
                result_uint = bo_data_ptr.add(QO_BO_UINT_OFFSET).cast::<u32>().read_unaligned();
                result_uint64 = bo_data_ptr.add(QO_BO_UINT64_OFFSET).cast::<u64>().read_unaligned();
            }
            // SAFETY: unmaps the buffer mapped above.
            unsafe { gl.unmap_buffer(glw::GL_QUERY_BUFFER) };
            // SAFETY: plain state query.
            let error_code = unsafe { gl.get_error() };
            if error_code != glw::GL_NO_ERROR {
                return fail_execution(format!("QO BO unmapping failed with error [{error_code}]"));
            }
            out_result.result_qo_int = result_int;
            out_result.result_qo_int64 = result_int64;
            out_result.result_qo_uint = result_uint;
            out_result.result_qo_uint64 = result_uint64;
        } else {
            out_result.result_int = result_int;
            out_result.result_int64 = result_int64;
            out_result.result_uint = result_uint;
            out_result.result_uint64 = result_uint64;
        }
        out_result.int64_written = result_int64_written;
        out_result.uint64_written = result_uint64_written;
    }
    Ok(QueryExecution {
        ok: true,
        skipped: false,
    })
}

/// `PipelineStatisticsQueryUtilities::verifyResultValues`; `details` stands for the draw call, primitive type and primitive restart arguments upstream formats into the message.
pub(super) fn verify_result_values(
    run_result: &TestExecutionResult,
    expected_values: &[u64],
    should_check_qo_bo_values: bool,
    query_type: GLenum,
    details: &str,
    verification_type: VerificationType,
) -> bool {
    let matches = |value: u64, expected: u64| match verification_type {
        VerificationType::ExactMatch => value == expected,
        VerificationType::EqualOrGreater => value >= expected,
    };
    let signed_matches = |value: i64, expected: u64| match verification_type {
        VerificationType::ExactMatch => value == expected as i64,
        VerificationType::EqualOrGreater => value >= expected as i64,
    };
    let any = |check: &dyn Fn(u64) -> bool| expected_values.iter().any(|expected| check(*expected));

    let mut result = true;
    let mut report = |valid: bool, value: String, what: &str| {
        if !valid {
            log::info!(
                "Invalid {what} query result [{value}] for query type {}; expected one of {expected_values:?}{details}",
                string_for_enum(query_type)
            );
            result = false;
        }
    };
    report(
        any(&|expected| matches(run_result.result_int as i64 as u64, expected)),
        run_result.result_int.to_string(),
        "non-QO BO int32",
    );
    report(
        !run_result.int64_written || any(&|expected| signed_matches(run_result.result_int64, expected)),
        run_result.result_int64.to_string(),
        "non-QO BO int64",
    );
    report(
        any(&|expected| matches(u64::from(run_result.result_uint), expected)),
        run_result.result_uint.to_string(),
        "non-QO BO uint32",
    );
    report(
        !run_result.uint64_written || any(&|expected| matches(run_result.result_uint64, expected)),
        run_result.result_uint64.to_string(),
        "non-QO BO uint64",
    );
    if should_check_qo_bo_values {
        report(
            any(&|expected| matches(run_result.result_qo_int as i64 as u64, expected)),
            run_result.result_qo_int.to_string(),
            "QO BO int32",
        );
        report(
            !run_result.int64_written || any(&|expected| signed_matches(run_result.result_qo_int64, expected)),
            run_result.result_qo_int64.to_string(),
            "QO BO int64",
        );
        report(
            any(&|expected| matches(u64::from(run_result.result_qo_uint), expected)),
            run_result.result_qo_uint.to_string(),
            "QO BO uint32",
        );
        report(
            !run_result.uint64_written || any(&|expected| matches(run_result.result_qo_uint64, expected)),
            run_result.result_qo_uint64.to_string(),
            "QO BO uint64",
        );
    }
    result
}

/// The part of `PipelineStatisticsQueryTestFunctionalBase` that Functional1 and 2 use: the query buffer object and the query object of the current target.
pub(super) struct FunctionalState {
    pub bo_qo_id: GLuint,
    pub qo_id: GLuint,
}

/// `PipelineStatisticsQueryTestFunctionalBase::initQOBO`
fn init_qobo(gl: &glw::Functions) -> Result<GLuint, TestError> {
    let bo_data = [0xFFu8; QO_BO_SIZE];
    let mut bo_qo_id: GLuint = 0;
    // SAFETY: the name is written to the live local.
    unsafe { gl.gen_buffers(1, &mut bo_qo_id) };
    glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
    // SAFETY: binds the buffer created above.
    unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo_qo_id) };
    glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
    // SAFETY: the data pointer covers the `QO_BO_SIZE` bytes passed.
    unsafe {
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            QO_BO_SIZE as glw::GLsizeiptr,
            bo_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        )
    };
    glu::expect_no_error(gl, "glBufferData() call failed.")?;
    Ok(bo_qo_id)
}

/// `PipelineStatisticsQueryTestFunctionalBase::iterate` and `deinit` around a test's `initObjects`, `executeTest` and `deinitObjects`.
pub(super) fn iterate_functional(
    context: &Context,
    should_execute_for_query_target: fn(GLenum) -> bool,
    init_objects: &mut dyn FnMut(&Context) -> Result<(), TestError>,
    execute_test: &mut dyn FnMut(&Context, &FunctionalState, GLenum) -> Result<bool, TestError>,
    deinit_objects: &mut dyn FnMut(&Context),
) -> TestOutcome {
    check_extension(context)?;
    let gl = context.gl();
    let mut state = FunctionalState { bo_qo_id: 0, qo_id: 0 };

    let result = (|| -> Result<bool, TestError> {
        let mut has_passed = true;
        if context
            .context_info
            .is_extension_supported("GL_ARB_query_buffer_object")
        {
            state.bo_qo_id = init_qobo(gl)?;
        }
        init_objects(context)?;
        for current_query_target in QUERY_TARGETS {
            if !is_query_supported(current_query_target, context)
                || !should_execute_for_query_target(current_query_target)
            {
                continue;
            }
            // SAFETY: the name is written to the live field.
            unsafe { gl.gen_queries(1, &mut state.qo_id) };
            glu::expect_no_error(gl, "glGenQueries() call failed.")?;
            has_passed &= execute_test(context, &state, current_query_target)?;
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_queries(1, &state.qo_id) };
            glu::expect_no_error(gl, "glDeleteQueries() call failed.")?;
            state.qo_id = 0;
        }
        Ok(has_passed)
    })();

    if state.bo_qo_id != 0 {
        // SAFETY: deletes the name created above (`deinit`).
        unsafe { gl.delete_buffers(1, &state.bo_qo_id) };
    }
    if state.qo_id != 0 {
        // SAFETY: as above.
        unsafe { gl.delete_queries(1, &state.qo_id) };
    }
    deinit_objects(context);
    verdict(result?)
}

/// `PipelineStatisticsQueryTestFunctional1`
struct Functional1;

impl Functional1 {
    fn execute_test(
        context: &Context,
        state: &FunctionalState,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let mut run_result = TestExecutionResult::default();
        let execution = execute_query(
            context,
            current_query_target,
            state.qo_id,
            state.bo_qo_id,
            None,
            &mut run_result,
        )?;
        if !execution.ok {
            log::info!(
                "Could not retrieve test run results for query target [{}]",
                string_for_enum(current_query_target)
            );
            return Ok(false);
        }
        if execution.skipped {
            return Ok(true);
        }
        Ok(verify_result_values(
            &run_result,
            &[0],
            state.bo_qo_id != 0,
            current_query_target,
            "",
            VerificationType::ExactMatch,
        ))
    }
}

impl TestCase for Functional1 {
    fn name(&self) -> &str {
        "functional_default_qo_values"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        iterate_functional(context, |_| true, &mut |_| Ok(()), &mut Self::execute_test, &mut |_| {})
    }
}

const F2_BO_SIZE: usize = 32;
const F2_TO_SIZE: glw::GLsizei = 16;

/// The objects `PipelineStatisticsQueryTestFunctional2::initObjects` creates.
#[derive(Default, Clone, Copy)]
struct Functional2Objects {
    bo_id: GLuint,
    fbo_draw_id: GLuint,
    fbo_read_id: GLuint,
    to_draw_fbo_id: GLuint,
    to_read_fbo_id: GLuint,
}

/// `PipelineStatisticsQueryTestFunctional2`
struct Functional2;

type NonRenderingCommand = fn(&glw::Functions, &Context, &Functional2Objects) -> Result<bool, TestError>;

impl Functional2 {
    fn blit_framebuffer(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        // SAFETY: a blit between the framebuffers bound by `initObjects`.
        unsafe {
            gl.blit_framebuffer(
                0,
                0,
                F2_TO_SIZE,
                F2_TO_SIZE,
                0,
                0,
                F2_TO_SIZE << 1,
                F2_TO_SIZE << 1,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_LINEAR,
            )
        };
        glu::expect_no_error(gl, "glBlitFramebuffer() call failed.")?;
        Ok(true)
    }

    fn buffer_sub_data(gl: &glw::Functions, _: &Context, objects: &Functional2Objects) -> Result<bool, TestError> {
        let test_data_size = F2_BO_SIZE / 2;
        let test_bo_data = [0xFFu8; F2_BO_SIZE / 2];
        // SAFETY: binds the buffer created by `initObjects`.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.bo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        // SAFETY: the data pointer covers `test_data_size` bytes.
        unsafe {
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                0,
                test_data_size as glw::GLsizeiptr,
                test_bo_data.as_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glBufferSubData() call failed.")?;
        Ok(true)
    }

    fn clear_bufferfv_color(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        let clear_color: [glw::GLfloat; 4] = [0.0, 0.1, 0.2, 0.3];
        // SAFETY: the pointer addresses four floats.
        unsafe { gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color.as_ptr()) };
        glu::expect_no_error(gl, "glClearBufferfv() call failed.")?;
        Ok(true)
    }

    fn clear_bufferfv_depth(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        let clear_depth: glw::GLfloat = 0.1;
        // SAFETY: the pointer addresses one float.
        unsafe { gl.clear_bufferfv(glw::GL_DEPTH, 0, &clear_depth) };
        glu::expect_no_error(gl, "glClearBufferfv() call failed.")?;
        Ok(true)
    }

    fn clear_bufferiv_stencil(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        let clear_stencil: GLint = 123;
        // SAFETY: the pointer addresses one integer.
        unsafe { gl.clear_bufferiv(glw::GL_STENCIL, 0, &clear_stencil) };
        glu::expect_no_error(gl, "glClearBufferfv() call failed.")?;
        Ok(true)
    }

    fn clear_buffer_sub_data(
        gl: &glw::Functions,
        context: &Context,
        _: &Functional2Objects,
    ) -> Result<bool, TestError> {
        if !context.context_type().supports_core(4, 3) && gl.clear_buffer_sub_data.is_none() {
            return Ok(false);
        }
        let value: u8 = 0xFF;
        // SAFETY: the pointer addresses one byte, the format being GL_RED / GL_UNSIGNED_BYTE.
        unsafe {
            gl.clear_buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                glw::GL_R8,
                0,
                F2_BO_SIZE as glw::GLsizeiptr,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::from_ref(&value).cast(),
            )
        };
        glu::expect_no_error(gl, "glClearBufferSubData() call failed.")?;
        Ok(true)
    }

    fn clear_color_buffer(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        // SAFETY: a plain clear of the bound framebuffer.
        unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
        glu::expect_no_error(gl, "glClear() call failed.")?;
        Ok(true)
    }

    fn clear_depth_buffer(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        // SAFETY: as above.
        unsafe { gl.clear(glw::GL_DEPTH_BUFFER_BIT) };
        glu::expect_no_error(gl, "glClear() call failed.")?;
        Ok(true)
    }

    fn clear_stencil_buffer(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        // SAFETY: as above.
        unsafe { gl.clear(glw::GL_STENCIL_BUFFER_BIT) };
        glu::expect_no_error(gl, "glClear() call failed.")?;
        Ok(true)
    }

    fn clear_tex_sub_image(
        gl: &glw::Functions,
        context: &Context,
        objects: &Functional2Objects,
    ) -> Result<bool, TestError> {
        if !context.context_type().supports_core(4, 4) && gl.clear_tex_sub_image.is_none() {
            return Ok(false);
        }
        let test_value: u8 = 0xFF;
        // SAFETY: the pointer addresses one byte, the format being GL_RED / GL_UNSIGNED_BYTE.
        unsafe {
            gl.clear_tex_sub_image(
                objects.to_draw_fbo_id,
                0,
                0,
                0,
                0,
                F2_TO_SIZE / 2,
                F2_TO_SIZE / 2,
                1,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::from_ref(&test_value).cast(),
            )
        };
        glu::expect_no_error(gl, "glClearTexSubImage() call failed.")?;
        Ok(true)
    }

    fn copy_image_sub_data(
        gl: &glw::Functions,
        context: &Context,
        objects: &Functional2Objects,
    ) -> Result<bool, TestError> {
        if !context.context_type().supports_core(4, 3) && gl.copy_image_sub_data.is_none() {
            return Ok(false);
        }
        // SAFETY: copies between the two textures created by `initObjects`.
        unsafe {
            gl.copy_image_sub_data(
                objects.to_draw_fbo_id,
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                0,
                objects.to_read_fbo_id,
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                0,
                F2_TO_SIZE / 2,
                F2_TO_SIZE / 2,
                1,
            )
        };
        glu::expect_no_error(gl, "glCopyImageSubData() call failed.")?;
        Ok(true)
    }

    fn tex_sub_image(gl: &glw::Functions, _: &Context, _: &Functional2Objects) -> Result<bool, TestError> {
        let test_data = [0xFFu8; F2_BO_SIZE / 2];
        // SAFETY: the data covers the 8x8 GL_RED / GL_UNSIGNED_BYTE region (64 bytes are not required: the upstream buffer is `bo_size / 2` bytes, kept as is).
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                F2_TO_SIZE / 2,
                F2_TO_SIZE / 2,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                test_data.as_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glTexSubImage2D() call failed.")?;
        Ok(true)
    }

    fn init_objects(gl: &glw::Functions, objects: &mut Functional2Objects) -> Result<(), TestError> {
        // SAFETY: the names are written to live fields.
        unsafe { gl.gen_buffers(1, &mut objects.bo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: binds the buffer created above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.bo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call(s) failed.")?;
        // SAFETY: allocates without data.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                F2_BO_SIZE as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        // SAFETY: the names are written to live fields.
        unsafe { gl.gen_textures(1, &mut objects.to_draw_fbo_id) };
        // SAFETY: as above.
        unsafe { gl.gen_textures(1, &mut objects.to_read_fbo_id) };
        glu::expect_no_error(gl, "glGenTextures() call(s) failed")?;
        for texture in [objects.to_draw_fbo_id, objects.to_read_fbo_id] {
            // SAFETY: binds and allocates the textures created above.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
            glu::expect_no_error(gl, "glBindTexture() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, F2_TO_SIZE, F2_TO_SIZE) };
            glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
        }

        // SAFETY: the names are written to live fields.
        unsafe { gl.gen_framebuffers(1, &mut objects.fbo_draw_id) };
        // SAFETY: as above.
        unsafe { gl.gen_framebuffers(1, &mut objects.fbo_read_id) };
        glu::expect_no_error(gl, "glGenFramebuffers() call(s) failed.")?;
        // SAFETY: binds the framebuffers created above.
        unsafe { gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, objects.fbo_draw_id) };
        // SAFETY: as above.
        unsafe { gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, objects.fbo_read_id) };
        glu::expect_no_error(gl, "glBindFramebuffer() call(s) failed.")?;
        // SAFETY: attaches the textures created above.
        unsafe {
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                objects.to_draw_fbo_id,
                0,
            )
        };
        // SAFETY: as above.
        unsafe {
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                objects.to_read_fbo_id,
                0,
            )
        };
        glu::expect_no_error(gl, "glFramebufferTexture2D() call(s) failed.")
    }

    fn deinit_objects(gl: &glw::Functions, objects: &mut Functional2Objects) {
        // SAFETY: deletes only names that `initObjects` created (zero names are skipped, as upstream).
        unsafe {
            if objects.bo_id != 0 {
                gl.delete_buffers(1, &objects.bo_id);
            }
            if objects.fbo_draw_id != 0 {
                gl.delete_framebuffers(1, &objects.fbo_draw_id);
            }
            if objects.fbo_read_id != 0 {
                gl.delete_framebuffers(1, &objects.fbo_read_id);
            }
            if objects.to_draw_fbo_id != 0 {
                gl.delete_textures(1, &objects.to_draw_fbo_id);
            }
            if objects.to_read_fbo_id != 0 {
                gl.delete_textures(1, &objects.to_read_fbo_id);
            }
        }
        *objects = Functional2Objects::default();
    }

    fn execute_test(
        context: &Context,
        state: &FunctionalState,
        objects: &Functional2Objects,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let query_draw_handlers: [NonRenderingCommand; 12] = [
            Self::blit_framebuffer,
            Self::buffer_sub_data,
            Self::clear_bufferfv_color,
            Self::clear_bufferfv_depth,
            Self::clear_bufferiv_stencil,
            Self::clear_buffer_sub_data,
            Self::clear_color_buffer,
            Self::clear_depth_buffer,
            Self::clear_stencil_buffer,
            Self::clear_tex_sub_image,
            Self::copy_image_sub_data,
            Self::tex_sub_image,
        ];
        let mut result = true;
        for (n, draw_handler) in query_draw_handlers.iter().enumerate() {
            if !draw_handler(gl, context, objects)? {
                continue;
            }
            let mut run_result = TestExecutionResult::default();
            let execution = execute_query(
                context,
                current_query_target,
                state.qo_id,
                state.bo_qo_id,
                None,
                &mut run_result,
            )?;
            if !execution.ok {
                log::info!(
                    "Query execution failed for query target [{}]",
                    string_for_enum(current_query_target)
                );
                result = false;
            } else if !execution.skipped {
                let has_passed = verify_result_values(
                    &run_result,
                    &[0],
                    state.bo_qo_id != 0,
                    current_query_target,
                    "",
                    VerificationType::ExactMatch,
                );
                if !has_passed {
                    log::info!("Test failed for iteration index [{n}].");
                    result = false;
                }
            }
        }
        Ok(result)
    }
}

impl TestCase for Functional2 {
    fn name(&self) -> &str {
        "functional_non_rendering_commands_do_not_affect_queries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let objects = std::cell::RefCell::new(Functional2Objects::default());
        iterate_functional(
            context,
            |_| true,
            &mut |_| Self::init_objects(gl, &mut objects.borrow_mut()),
            &mut |context, state, target| Self::execute_test(context, state, &objects.borrow(), target),
            &mut |_| Self::deinit_objects(gl, &mut objects.borrow_mut()),
        )
    }
}

pub(super) fn add_tests(group: &mut glu::TestCaseGroup) {
    group.add_child(Box::new(Functional1) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional2) as Box<dyn TestCase>);
    super::pipeline_statistics_query_draw::add_tests(group);
}
