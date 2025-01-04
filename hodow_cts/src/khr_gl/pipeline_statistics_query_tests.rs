// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cPipelineStatisticsQueryTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All 10 cases of `pipeline_statistics_query_tests_ARB`: the two `api_coverage_*` cases are here, `functional_*` are in `pipeline_statistics_query_functional` (1, 2) and `pipeline_statistics_query_draw` (3 to 8); the log texts of `verifyResultValues` are shortened. `PipelineStatisticsQueryUtilities::query_targets` and `isQuerySupported` are the shared helpers; the `NotSupportedError` of `iterate` is `check_support`.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const GL_VERTICES_SUBMITTED_ARB: GLenum = 0x82EE;
const GL_PRIMITIVES_SUBMITTED_ARB: GLenum = 0x82EF;
const GL_VERTEX_SHADER_INVOCATIONS_ARB: GLenum = 0x82F0;
const GL_TESS_CONTROL_SHADER_PATCHES_ARB: GLenum = 0x82F1;
const GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB: GLenum = 0x82F2;
const GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB: GLenum = 0x82F3;
const GL_FRAGMENT_SHADER_INVOCATIONS_ARB: GLenum = 0x82F4;
const GL_COMPUTE_SHADER_INVOCATIONS_ARB: GLenum = 0x82F5;
const GL_CLIPPING_INPUT_PRIMITIVES_ARB: GLenum = 0x82F6;
const GL_CLIPPING_OUTPUT_PRIMITIVES_ARB: GLenum = 0x82F7;

/// An array holding all query targets that are introduced by GL_ARB_pipeline_statistics_query
pub(super) const QUERY_TARGETS: [GLenum; 11] = [
    GL_VERTICES_SUBMITTED_ARB,
    GL_PRIMITIVES_SUBMITTED_ARB,
    GL_VERTEX_SHADER_INVOCATIONS_ARB,
    GL_TESS_CONTROL_SHADER_PATCHES_ARB,
    GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB,
    glw::GL_GEOMETRY_SHADER_INVOCATIONS,
    GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB,
    GL_FRAGMENT_SHADER_INVOCATIONS_ARB,
    GL_COMPUTE_SHADER_INVOCATIONS_ARB,
    GL_CLIPPING_INPUT_PRIMITIVES_ARB,
    GL_CLIPPING_OUTPUT_PRIMITIVES_ARB,
];

/// `PipelineStatisticsQueryUtilities::getStringForEnum` (the names only matter in log messages)
pub(super) fn string_for_enum(value: GLenum) -> &'static str {
    match value {
        GL_VERTICES_SUBMITTED_ARB => "GL_VERTICES_SUBMITTED_ARB",
        GL_PRIMITIVES_SUBMITTED_ARB => "GL_PRIMITIVES_SUBMITTED_ARB",
        GL_VERTEX_SHADER_INVOCATIONS_ARB => "GL_VERTEX_SHADER_INVOCATIONS_ARB",
        GL_TESS_CONTROL_SHADER_PATCHES_ARB => "GL_TESS_CONTROL_SHADER_PATCHES_ARB",
        GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB => "GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB",
        glw::GL_GEOMETRY_SHADER_INVOCATIONS => "GL_GEOMETRY_SHADER_INVOCATIONS",
        GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB => "GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB",
        GL_FRAGMENT_SHADER_INVOCATIONS_ARB => "GL_FRAGMENT_SHADER_INVOCATIONS_ARB",
        GL_COMPUTE_SHADER_INVOCATIONS_ARB => "GL_COMPUTE_SHADER_INVOCATIONS_ARB",
        GL_CLIPPING_INPUT_PRIMITIVES_ARB => "GL_CLIPPING_INPUT_PRIMITIVES_ARB",
        GL_CLIPPING_OUTPUT_PRIMITIVES_ARB => "GL_CLIPPING_OUTPUT_PRIMITIVES_ARB",
        _ => "[?]",
    }
}

/// `PipelineStatisticsQueryUtilities::isQuerySupported`
pub(super) fn is_query_supported(value: GLenum, context: &Context) -> bool {
    let supported = |core_version: Option<(i32, i32)>, extension: &str| {
        core_version.is_some_and(|(major, minor)| context.context_type().supports_core(major, minor))
            || context.context_info.is_extension_supported(extension)
    };
    match value {
        glw::GL_GEOMETRY_SHADER_INVOCATIONS | GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB => {
            supported(Some((3, 2)), "GL_ARB_geometry_shader4")
        }
        // `ApiType::compatibility(4, 0)` is never satisfied by the core contexts this port creates.
        GL_TESS_CONTROL_SHADER_PATCHES_ARB | GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB => {
            supported(None, "GL_ARB_tessellation_shader")
        }
        GL_COMPUTE_SHADER_INVOCATIONS_ARB => supported(Some((4, 3)), "GL_ARB_compute_shader"),
        _ => true,
    }
}

pub(super) fn check_extension(context: &Context) -> Result<(), TestError> {
    if !context.context_type().supports_core(4, 6)
        && !context
            .context_info
            .is_extension_supported("GL_ARB_pipeline_statistics_query")
    {
        return Err(TestError::NotSupported(
            "GL_ARB_pipeline_statistics_query extension is not supported".to_string(),
        ));
    }
    Ok(())
}

pub(super) fn verdict(has_passed: bool) -> TestOutcome {
    Ok(if has_passed {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `PipelineStatisticsQueryTestAPICoverage1`
struct ApiCoverage1;

impl TestCase for ApiCoverage1 {
    fn name(&self) -> &str {
        "api_coverage_invalid_glbeginquery_calls"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_passed = true;
        let mut qo_id: GLuint = 0;

        let result = (|| -> Result<(), TestError> {
            for current_pq in QUERY_TARGETS {
                if !is_query_supported(current_pq, context) {
                    continue;
                }

                // SAFETY: the name is written to the live local.
                unsafe { gl.gen_queries(1, &mut qo_id) };
                glu::expect_no_error(gl, "glGenQueries() call failed.")?;
                // SAFETY: plain query calls on the object created above.
                unsafe { gl.begin_query(current_pq, qo_id) };
                glu::expect_no_error(gl, "glBeginQuery() call failed.")?;
                // SAFETY: as above.
                unsafe { gl.end_query(current_pq) };
                glu::expect_no_error(gl, "glEndQuery() call failed.")?;

                for different_pq in QUERY_TARGETS {
                    if current_pq == different_pq || !is_query_supported(different_pq, context) {
                        continue;
                    }

                    // SAFETY: the call is expected to fail validation.
                    unsafe { gl.begin_query(different_pq, qo_id) };
                    // SAFETY: plain state query.
                    let error_code = unsafe { gl.get_error() };
                    if error_code != glw::GL_INVALID_OPERATION {
                        log::info!(
                            "[{}] generated when using glBeginQuery() for a query object of type [{}], when used for a query type [{}]; GL_INVALID_OPERATION was expected.",
                            glw::error_name(error_code),
                            string_for_enum(current_pq),
                            string_for_enum(different_pq)
                        );
                        has_passed = false;
                    }

                    if error_code == glw::GL_NO_ERROR {
                        // SAFETY: the query was started successfully.
                        unsafe { gl.end_query(different_pq) };
                        glu::expect_no_error(
                            gl,
                            "glEndQuery() should not have failed for a successful glBeginQuery() call",
                        )?;
                    }
                }

                // SAFETY: deletes the name created above.
                unsafe { gl.delete_queries(1, &qo_id) };
                glu::expect_no_error(gl, "glDeleteQueries() call failed.")?;
            }
            Ok(())
        })();

        if qo_id != 0 {
            // SAFETY: deletes a name created above (`deinit`).
            unsafe { gl.delete_queries(1, &qo_id) };
        }
        match result {
            Ok(()) => verdict(has_passed),
            Err(error) => Err(error),
        }
    }
}

/// `PipelineStatisticsQueryTestAPICoverage2`
struct ApiCoverage2;

impl TestCase for ApiCoverage2 {
    fn name(&self) -> &str {
        "api_coverage_unsupported_calls"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_passed = true;
        let mut qo_id: GLuint = 0;

        let result = (|| -> Result<(), TestError> {
            // SAFETY: the name is written to the live local.
            unsafe { gl.gen_queries(1, &mut qo_id) };
            glu::expect_no_error(gl, "glGenQueries() call failed.")?;

            for query_type in [
                glw::GL_GEOMETRY_SHADER_INVOCATIONS,
                GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB,
                GL_TESS_CONTROL_SHADER_PATCHES_ARB,
                GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB,
                GL_COMPUTE_SHADER_INVOCATIONS_ARB,
            ] {
                if !is_query_supported(query_type, context) {
                    // SAFETY: the call is expected to fail validation.
                    unsafe { gl.begin_query(query_type, qo_id) };
                    // SAFETY: plain state query.
                    let error_code = unsafe { gl.get_error() };
                    if error_code != glw::GL_INVALID_ENUM {
                        log::info!(
                            "[{}] generated for an unsupported query type [{}]; GL_INVALID_ENUM was expected.",
                            glw::error_name(error_code),
                            string_for_enum(query_type)
                        );
                        has_passed = false;
                    }

                    if error_code == glw::GL_NO_ERROR {
                        // SAFETY: the query was started successfully.
                        unsafe { gl.end_query(query_type) };
                        glu::expect_no_error(gl, "glEndQuery() call failed.")?;
                    }
                }
            }
            Ok(())
        })();

        if qo_id != 0 {
            // SAFETY: deletes the name created above (`deinit`).
            unsafe { gl.delete_queries(1, &qo_id) };
        }
        match result {
            Ok(()) => verdict(has_passed),
            Err(error) => Err(error),
        }
    }
}

/// `PipelineStatisticsQueryTests::init` (the ported part)
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pipeline_statistics_query_tests_ARB");
    group.add_child(Box::new(ApiCoverage1) as Box<dyn TestCase>);
    group.add_child(Box::new(ApiCoverage2) as Box<dyn TestCase>);
    super::pipeline_statistics_query_functional::add_tests(&mut group);
    group
}
