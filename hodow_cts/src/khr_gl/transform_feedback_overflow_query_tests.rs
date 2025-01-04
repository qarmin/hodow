// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackOverflowQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The extension check upstream throws from `init` is `check_support`; each state/error case's `init` and `deinit` are setup guards that run their steps on creation and on drop, so a failing case still ends the queries it started. `TransformFeedbackOverflowQueryFunctionalBase` is `Functional`, built from a `FunctionalSpec` that holds what the six functional subclasses override (shaders, varyings, buffer mode, count and sizes); its `init` throws NotSupported when the TRANSFORM_FEEDBACK_OVERFLOW counter has no bits, which `check_support` does here. `verifyQueryResults` indexes the stream queries by position upstream whether or not they exist; here a missing one is skipped.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

fn fail<T>(message: &str) -> Res<T> {
    Err(TestError::Fail(message.to_string()))
}

/// What `TransformFeedbackOverflowQueryBaseTest` answers: the support checks and the vertex stream count.
struct Env<'a> {
    gl: &'a glw::Functions,
    transform_feedback3: bool,
    max_vertex_streams: GLuint,
}

fn supports_transform_feedback3(context: &Context) -> bool {
    context
        .context_info
        .is_extension_supported("GL_ARB_transform_feedback3")
        || context.context_type().supports_core(4, 0)
}

impl<'a> Env<'a> {
    /// The part of `TransformFeedbackOverflowQueryBaseTest::init` after the support check.
    fn new(context: &'a Context) -> Self {
        let gl = context.gl();
        let transform_feedback3 = supports_transform_feedback3(context);
        let mut max_vertex_streams = 0;
        if transform_feedback3 {
            let mut value: GLint = 0;
            gl!(gl.get_integerv(glw::GL_MAX_VERTEX_STREAMS, &mut value));
            max_vertex_streams = value as GLuint;
        }
        Self {
            gl,
            transform_feedback3,
            max_vertex_streams,
        }
    }

    fn gen_query(&self) -> GLuint {
        let mut query: GLuint = 0;
        gl!(self.gl.gen_queries(1, &mut query));
        query
    }

    fn delete_query(&self, query: GLuint) {
        gl!(self.gl.delete_queries(1, &query));
    }

    /// `verifyCurrentQueryState`
    fn verify_current_query_state(&self, target: GLenum, index: GLuint, value: GLuint) -> bool {
        let expected = value as GLint;
        let mut actual: GLint = 0;

        // Use GetQueryIndexediv by default
        gl!(self
            .gl
            .get_query_indexediv(target, index, glw::GL_CURRENT_QUERY, &mut actual));
        if actual != expected {
            return false;
        }

        if index == 0 {
            // If index is zero then GetQueryiv should also return the expected value
            gl!(self.gl.get_queryiv(target, glw::GL_CURRENT_QUERY, &mut actual));
            if actual != expected {
                return false;
            }
        }

        true
    }

    /// `TransformFeedbackOverflowQueryErrorBase::verifyError`: `case_name` is the failure message
    fn verify_error(&self, case_name: &str, expected_error: GLenum) -> Res<()> {
        // SAFETY: no arguments.
        let actual_error = unsafe { self.gl.get_error() };
        if actual_error != expected_error {
            return fail(case_name);
        }
        Ok(())
    }
}

/// `TransformFeedbackOverflowQueryImplDepState::iterate`
fn implementation_dependent_state(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let gl = env.gl;
    let mut counter_bits: GLint = 0;
    gl!(gl.get_queryiv(
        glw::GL_TRANSFORM_FEEDBACK_OVERFLOW,
        glw::GL_QUERY_COUNTER_BITS,
        &mut counter_bits
    ));
    if counter_bits < 0 {
        return fail("Value of QUERY_COUNTER_BITS for query target TRANSFORM_FEEDBACK_OVERFLOW is invalid");
    }

    if env.transform_feedback3 {
        gl!(gl.get_queryiv(
            glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
            glw::GL_QUERY_COUNTER_BITS,
            &mut counter_bits
        ));
        if counter_bits < 0 {
            return fail("Value of QUERY_COUNTER_BITS for query target TRANSFORM_FEEDBACK_STREAM_OVERFLOW is invalid");
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TransformFeedbackOverflowQueryDefaultState::iterate`
fn default_context_state(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0, 0) {
        return fail("Default value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_OVERFLOW is non-zero");
    }

    if env.transform_feedback3 {
        for _ in 0..env.max_vertex_streams {
            if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, 0, 0) {
                return fail(
                    "Default value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_STREAM_OVERFLOW is non-zero",
                );
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TransformFeedbackOverflowQueryStateUpdate`: `init` generates the queries, `deinit` deletes them
struct StateUpdateSetup<'a> {
    env: &'a Env<'a>,
    overflow_query: GLuint,
    stream_overflow_query: GLuint,
}

impl Drop for StateUpdateSetup<'_> {
    fn drop(&mut self) {
        self.env.delete_query(self.overflow_query);
        self.env.delete_query(self.stream_overflow_query);
    }
}

/// `TransformFeedbackOverflowQueryStateUpdate::iterate`
fn context_state_update(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let gl = env.gl;
    let setup = StateUpdateSetup {
        env: &env,
        overflow_query: env.gen_query(),
        stream_overflow_query: env.gen_query(),
    };

    // Call BeginQuery
    gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, setup.overflow_query));

    // Verify that CURRENT_QUERY is set to the name of the query
    if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0, setup.overflow_query) {
        return fail(
            "Value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_OVERFLOW is not updated properly after a call to BeginQuery",
        );
    }

    // Call EndQuery
    gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW));

    // Verify that CURRENT_QUERY is reset to zero
    if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0, 0) {
        return fail(
            "Value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_OVERFLOW is not reset properly after a call to EndQuery",
        );
    }

    if env.transform_feedback3 {
        for i in 0..env.max_vertex_streams {
            // Call BeginQueryIndexed with specified index
            gl!(gl.begin_query_indexed(
                glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                i,
                setup.stream_overflow_query
            ));

            // Verify that CURRENT_QUERY is set to the name of the query for the specified index, but remains zero for other indices
            for j in 0..env.max_vertex_streams {
                if i == j {
                    if !env.verify_current_query_state(
                        glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                        j,
                        setup.stream_overflow_query,
                    ) {
                        return fail(
                            "Value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_STREAM_OVERFLOW is not updated properly after a call to BeginQueryIndexed",
                        );
                    }
                } else if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, j, 0) {
                    return fail(
                        "Value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_STREAM_OVERFLOW is incorrectly updated for an unrelated vertex streamindex after a call to BeginQueryIndexed",
                    );
                }
            }

            // Call EndQueryIndexed with specified index
            gl!(gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, i));

            // Verify that CURRENT_QUERY is reset to zero for all indices
            for j in 0..env.max_vertex_streams {
                if i == j {
                    if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, j, 0) {
                        return fail(
                            "Value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_STREAM_OVERFLOW is not reset properly after a call to EndQueryIndexed",
                        );
                    }
                } else if !env.verify_current_query_state(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, j, 0) {
                    return fail(
                        "Value of CURRENT_QUERY for query target TRANSFORM_FEEDBACK_STREAM_OVERFLOW is incorrectly updated for an unrelated vertex streamindex after a call to EndQueryIndexed",
                    );
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TransformFeedbackOverflowQueryErrorInvalidIndex::iterate`
fn error_invalid_index(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let gl = env.gl;
    let query = env.gen_query();
    let mut value: GLint = 0;

    let case = "GetQueryIndexediv must generate INVALID_VALUE if <target> is TRANSFORM_FEEDBACK_OVERFLOW and <index> is non-zero.";
    let result = (|| -> Res<()> {
        for i in 1..env.max_vertex_streams {
            gl!(gl.get_query_indexediv(
                glw::GL_TRANSFORM_FEEDBACK_OVERFLOW,
                i,
                glw::GL_CURRENT_QUERY,
                &mut value
            ));
            env.verify_error(case, glw::GL_INVALID_VALUE)?;
        }

        if env.transform_feedback3 {
            let case = "GetQueryIndexediv must generate INVALID_VALUE if <target> is TRANSFORM_FEEDBACK_STREAM_OVERFLOW and <index> is greater than or equal to MAX_VERTEX_STREAMS.";
            for i in env.max_vertex_streams..env.max_vertex_streams + 4 {
                gl!(gl.get_query_indexediv(
                    glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                    i,
                    glw::GL_CURRENT_QUERY,
                    &mut value
                ));
                env.verify_error(case, glw::GL_INVALID_VALUE)?;
            }
        }

        let case = "BeginQueryIndexed must generate INVALID_VALUE if <target> is TRANSFORM_FEEDBACK_OVERFLOW and <index> is non-zero.";
        for i in 1..env.max_vertex_streams {
            gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, i, query));
            env.verify_error(case, glw::GL_INVALID_VALUE)?;
        }

        if env.transform_feedback3 {
            let case = "BeginQueryIndexed must generate INVALID_VALUE if <target> is TRANSFORM_FEEDBACK_STREAM_OVERFLOW and <index> is greater than or equal to MAX_VERTEX_STREAMS.";
            for i in env.max_vertex_streams..env.max_vertex_streams + 4 {
                gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, i, query));
                env.verify_error(case, glw::GL_INVALID_VALUE)?;
            }
        }
        Ok(())
    })();

    env.delete_query(query);
    result?;
    Ok(TestStatus::pass("Pass"))
}

/// `TransformFeedbackOverflowQueryErrorAlreadyActive`: `init` starts the active queries, `deinit` ends and deletes them
struct AlreadyActiveSetup<'a> {
    env: &'a Env<'a>,
    query: GLuint,
    active_overflow_query: GLuint,
    active_stream_overflow_query: GLuint,
    active_query_stream_index: GLuint,
}

impl<'a> AlreadyActiveSetup<'a> {
    fn new(env: &'a Env<'a>) -> Self {
        let gl = env.gl;
        let query = env.gen_query();
        let active_overflow_query = env.gen_query();
        gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, active_overflow_query));

        let mut active_stream_overflow_query = 0;
        let mut active_query_stream_index = 0;
        if env.transform_feedback3 {
            active_stream_overflow_query = env.gen_query();
            active_query_stream_index = 2;
            gl!(gl.begin_query_indexed(
                glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                active_query_stream_index,
                active_stream_overflow_query
            ));
        }
        Self {
            env,
            query,
            active_overflow_query,
            active_stream_overflow_query,
            active_query_stream_index,
        }
    }
}

impl Drop for AlreadyActiveSetup<'_> {
    fn drop(&mut self) {
        let gl = self.env.gl;
        if self.env.transform_feedback3 {
            gl!(gl.end_query_indexed(
                glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                self.active_query_stream_index
            ));
            self.env.delete_query(self.active_stream_overflow_query);
        }
        gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW));
        self.env.delete_query(self.active_overflow_query);
        self.env.delete_query(self.query);
    }
}

/// `TransformFeedbackOverflowQueryErrorAlreadyActive::iterate`
fn error_already_active(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let gl = env.gl;
    let setup = AlreadyActiveSetup::new(&env);

    let case = "BeginQuery[Indexed] must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_OVERFLOW and there is already an active query for TRANSFORM_FEEDBACK_ARB.";
    gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, setup.query));
    env.verify_error(case, glw::GL_INVALID_OPERATION)?;
    gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0, setup.query));
    env.verify_error(case, glw::GL_INVALID_OPERATION)?;

    if env.transform_feedback3 {
        let case = "BeginQueryIndexed must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_STREAM_OVERFLOW and there is already an active query for TRANSFORM_FEEDBACK_STREAM_OVERFLOW for the specified index.";
        gl!(gl.begin_query_indexed(
            glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
            setup.active_query_stream_index,
            setup.query
        ));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;

        let case = "BeginQuery[Indexed] must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_STREAM_OVERFLOW and the specified query is already active on another TRANSFORM_FEEDBACK_STREAM_OVERFLOW target with a different index.";
        for i in 0..env.max_vertex_streams {
            if i != setup.active_query_stream_index {
                gl!(gl.begin_query_indexed(
                    glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                    i,
                    setup.active_stream_overflow_query
                ));
                env.verify_error(case, glw::GL_INVALID_OPERATION)?;

                if i == 0 {
                    gl!(gl.begin_query(
                        glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                        setup.active_stream_overflow_query
                    ));
                    env.verify_error(case, glw::GL_INVALID_OPERATION)?;
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TransformFeedbackOverflowQueryErrorIncompatibleTarget`: `init` uses the queries with their targets, `deinit` deletes them
struct IncompatibleTargetSetup<'a> {
    env: &'a Env<'a>,
    overflow_query: GLuint,
    stream_overflow_query: GLuint,
    incompatible_query: GLuint,
}

impl<'a> IncompatibleTargetSetup<'a> {
    fn new(env: &'a Env<'a>) -> Self {
        let gl = env.gl;
        let incompatible_query = env.gen_query();
        gl!(gl.begin_query(glw::GL_SAMPLES_PASSED, incompatible_query));
        gl!(gl.end_query(glw::GL_SAMPLES_PASSED));

        let overflow_query = env.gen_query();
        gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, overflow_query));
        gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW));

        let mut stream_overflow_query = 0;
        if env.transform_feedback3 {
            stream_overflow_query = env.gen_query();
            gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, stream_overflow_query));
            gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW));
        }
        Self {
            env,
            overflow_query,
            stream_overflow_query,
            incompatible_query,
        }
    }
}

impl Drop for IncompatibleTargetSetup<'_> {
    fn drop(&mut self) {
        self.env.delete_query(self.incompatible_query);
        self.env.delete_query(self.overflow_query);
        if self.env.transform_feedback3 {
            self.env.delete_query(self.stream_overflow_query);
        }
    }
}

/// `TransformFeedbackOverflowQueryErrorIncompatibleTarget::iterate`
fn error_incompatible_target(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let gl = env.gl;
    let setup = IncompatibleTargetSetup::new(&env);

    let case = "BeginQuery[Indexed] must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_OVERFLOW and the specified query was previously used with another target.";
    gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, setup.incompatible_query));
    env.verify_error(case, glw::GL_INVALID_OPERATION)?;
    gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0, setup.incompatible_query));
    env.verify_error(case, glw::GL_INVALID_OPERATION)?;

    if env.transform_feedback3 {
        gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, setup.stream_overflow_query));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;
        gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0, setup.stream_overflow_query));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;

        let case = "BeginQuery[Indexed] must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_STREAM_OVERFLOW and the specified query was previously used with another target.";
        gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, setup.incompatible_query));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;
        gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, 2, setup.incompatible_query));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;
        gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, setup.overflow_query));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;
        gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, 2, setup.overflow_query));
        env.verify_error(case, glw::GL_INVALID_OPERATION)?;
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TransformFeedbackOverflowQueryErrorNoActiveQuery`: `init` starts a stream query, `deinit` ends and deletes it
struct NoActiveQuerySetup<'a> {
    env: &'a Env<'a>,
    active_stream_overflow_query: GLuint,
    active_query_stream_index: GLuint,
}

impl<'a> NoActiveQuerySetup<'a> {
    fn new(env: &'a Env<'a>) -> Self {
        let mut active_stream_overflow_query = 0;
        let mut active_query_stream_index = 0;
        if env.transform_feedback3 {
            active_stream_overflow_query = env.gen_query();
            active_query_stream_index = 2;
            gl!(env.gl.begin_query_indexed(
                glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                active_query_stream_index,
                active_stream_overflow_query
            ));
        }
        Self {
            env,
            active_stream_overflow_query,
            active_query_stream_index,
        }
    }
}

impl Drop for NoActiveQuerySetup<'_> {
    fn drop(&mut self) {
        if self.env.transform_feedback3 {
            gl!(self.env.gl.end_query_indexed(
                glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
                self.active_query_stream_index
            ));
            self.env.delete_query(self.active_stream_overflow_query);
        }
    }
}

/// `TransformFeedbackOverflowQueryErrorNoActiveQuery::iterate`
fn error_no_active_query(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let gl = env.gl;
    let setup = NoActiveQuerySetup::new(&env);

    let case = "EndQuery[Indexed] must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_OVERFLOW and there is no query active for TRANSFORM_FEEDBACK_OVERFLOW.";
    gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW));
    env.verify_error(case, glw::GL_INVALID_OPERATION)?;
    gl!(gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, 0));
    env.verify_error(case, glw::GL_INVALID_OPERATION)?;

    if env.transform_feedback3 {
        let case = "EndQuery[Indexed] must generate INVALID_OPERATION if <target> is TRANSFORM_FEEDBACK_STREAM_OVERFLOW and there is no query active for TRANSFORM_FEEDBACK_STREAM_OVERFLOW for the given index.";
        for i in 0..env.max_vertex_streams {
            if i != setup.active_query_stream_index {
                gl!(gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, i));
                env.verify_error(case, glw::GL_INVALID_OPERATION)?;

                if i == 0 {
                    gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW));
                    env.verify_error(case, glw::GL_INVALID_OPERATION)?;
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------
// Functional cases
// ---------------------------------------------------------------------------------------------

/// Minimal vertex shader.
const MINIMAL_VSH: &str = "#version 150 core\nvoid main() {\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n}\n";

/// Minimal fragment shader
const MINIMAL_FSH: &str = "#version 150 core\nvoid main() {}\n";

const SINGLE_STREAM_VSH: &str = "#version 150 core\nout float output1;\nout float output2;\nout float output3;\nout float output4;\nvoid main() {\n    output1 = 1.0;\n    output2 = 2.0;\n    output3 = 3.0;\n    output4 = 4.0;\n}";
const SINGLE_STREAM_VARYINGS: [&str; 4] = ["output1", "output2", "output3", "output4"];

const MULTIPLE_STREAMS_VSH: &str = "#version 150 core\nvoid main() {\n}";

const ONE_BUFFER_PER_STREAM_GSH: &str = "#version 150 core\n#extension GL_ARB_gpu_shader5 : require\nlayout(points) in;\nlayout(points, max_vertices = 1) out;\nlayout(stream=0) out float output1;\nlayout(stream=1) out float output2;\nlayout(stream=2) out float output3;\nlayout(stream=3) out float output4;\nuniform uint stream;\nvoid main() {\n    if (stream == 0) {\n        output1 = 1.0;\n        EmitStreamVertex(0);\n        EndStreamPrimitive(0);\n    }\n    if (stream == 1) {\n        output2 = 2.0;\n        EmitStreamVertex(1);\n        EndStreamPrimitive(1);\n    }\n    if (stream == 2) {\n        output3 = 3.0;\n        EmitStreamVertex(2);\n        EndStreamPrimitive(2);\n    }\n    if (stream == 3) {\n        output4 = 4.0;\n        EmitStreamVertex(3);\n        EndStreamPrimitive(3);\n    }\n}";
/// Each output goes to different buffer. The mapping between vertex stream outputs and transform feedback buffers is non-identity.
const ONE_BUFFER_PER_STREAM_VARYINGS: [&str; 7] = [
    "output4",
    "gl_NextBuffer",
    "output3",
    "gl_NextBuffer",
    "output2",
    "gl_NextBuffer",
    "output1",
];

const MULTIPLE_BUFFERS_PER_STREAM_GSH: &str = "#version 150 core\n#extension GL_ARB_gpu_shader5 : require\nlayout(points) in;\nlayout(points, max_vertices = 1) out;\nlayout(stream=0) out float output1;\nlayout(stream=0) out float output2;\nlayout(stream=1) out float output3;\nlayout(stream=1) out float output4;\nuniform uint stream;\nvoid main() {\n    if (stream == 0) {\n        output1 = 1.0;\n        output2 = 2.0;\n        EmitStreamVertex(0);\n        EndStreamPrimitive(0);\n    }\n    if (stream == 1) {\n        output3 = 3.0;\n        output4 = 4.0;\n        EmitStreamVertex(1);\n        EndStreamPrimitive(1);\n    }\n}";
/// Vertex stream #0 is captured by transform feedback buffers #1 and #2, while vertex stream #1 is captured by transform feedback buffers #3 and #0.
const MULTIPLE_BUFFERS_PER_STREAM_VARYINGS: [&str; 7] = [
    "output4",
    "gl_NextBuffer",
    "output1",
    "gl_NextBuffer",
    "output2",
    "gl_NextBuffer",
    "output3",
];

/// What the functional subclasses override
struct FunctionalSpec {
    vertex_shader: &'static str,
    geometry_shader: Option<&'static str>,
    varyings: &'static [&'static str],
    buffer_mode: GLenum,
    buffer_count: usize,
    buffer_size: fn(usize) -> isize,
}

fn supports_conditional_render_inverted(context: &Context) -> bool {
    context
        .context_info
        .is_extension_supported("GL_ARB_conditional_render_inverted")
        || context.context_type().supports_core(4, 5)
}

fn supports_query_buffer_object(context: &Context) -> bool {
    context
        .context_info
        .is_extension_supported("GL_ARB_query_buffer_object")
        || context.context_type().supports_core(4, 4)
}

fn supports_transform_feedback2(context: &Context) -> bool {
    context
        .context_info
        .is_extension_supported("GL_ARB_transform_feedback2")
        || context.context_type().supports_core(4, 0)
}

fn supports_gpu_shader5(context: &Context) -> bool {
    context.context_info.is_extension_supported("GL_ARB_gpu_shader5") || context.context_type().supports_core(4, 0)
}

/// `canTestOverflow`
fn can_test_overflow(gl: &glw::Functions) -> bool {
    let mut counter_bits: GLint = 0;
    gl!(gl.get_queryiv(
        glw::GL_TRANSFORM_FEEDBACK_OVERFLOW,
        glw::GL_QUERY_COUNTER_BITS,
        &mut counter_bits
    ));
    counter_bits > 0
}

/// `canTestStreamOverflow`
fn can_test_stream_overflow(env: &Env<'_>) -> bool {
    if env.transform_feedback3 {
        let mut counter_bits: GLint = 0;
        gl!(env.gl.get_queryiv(
            glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW,
            glw::GL_QUERY_COUNTER_BITS,
            &mut counter_bits
        ));
        counter_bits > 0
    } else {
        false
    }
}

/// `TransformFeedbackOverflowQueryFunctionalBase` after `init`
struct Functional<'a> {
    context: &'a Context,
    env: &'a Env<'a>,
    vao: GLuint,
    overflow_query: GLuint,
    stream_overflow_query: Vec<GLuint>,
    checker_program: ShaderProgram<'a>,
    program: ShaderProgram<'a>,
    _tf_buffers: Vec<glu::Buffer<'a>>,
}

impl<'a> Functional<'a> {
    /// Functional test init. Creates necessary query objects.
    fn new(context: &'a Context, env: &'a Env<'a>, spec: &FunctionalSpec) -> Res<Self> {
        let gl = env.gl;
        let mut vao: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vao));
        gl!(gl.bind_vertex_array(vao));
        let overflow_query = env.gen_query();
        let mut stream_overflow_query = Vec::new();
        if can_test_stream_overflow(env) {
            stream_overflow_query = (0..env.max_vertex_streams).map(|_| env.gen_query()).collect();
        }

        let checker_program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(MINIMAL_VSH, MINIMAL_FSH));
        if !checker_program.is_ok() {
            return fail("Checker program compilation failed");
        }

        // buildTransformFeedbackProgram
        let mut sources = ProgramSources::default().with(ShaderType::Vertex, spec.vertex_shader);
        if let Some(geometry_shader) = spec.geometry_shader {
            sources = sources.with(ShaderType::Geometry, geometry_shader);
        }
        let varyings: Vec<String> = spec.varyings.iter().map(|name| (*name).to_string()).collect();
        let program = ShaderProgram::new(gl, &sources.with_transform_feedback(&varyings, spec.buffer_mode));
        if !program.is_ok() {
            return Err(TestError::Fail(format!(
                "Failed to compile or link the transform feedback program. {}",
                program.build_failure_summary().unwrap_or_default()
            )));
        }
        gl!(gl.use_program(program.program()));

        // setupTransformFeedbackBuffers: generates a number of transform feedback buffers and binds them.
        let tf_buffers: Vec<glu::Buffer<'a>> = (0..spec.buffer_count).map(|_| glu::Buffer::new(gl)).collect();
        for (i, buffer) in tf_buffers.iter().enumerate() {
            gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, i as GLuint, buffer.get()));
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                (spec.buffer_size)(i),
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            ));
        }

        Ok(Self {
            context,
            env,
            vao,
            overflow_query,
            stream_overflow_query,
            checker_program,
            program,
            _tf_buffers: tf_buffers,
        })
    }

    /// The basic checking mechanism: conditional render in both senses, the query result, and the query buffer object variant.
    fn verify_query_result(&self, query: GLuint, expected: bool) -> bool {
        let gl = self.env.gl;
        let mut result = true;
        let mut actual: GLuint = 0;
        let mut current_program: GLint = 0;
        gl!(gl.get_integerv(glw::GL_CURRENT_PROGRAM, &mut current_program));
        let mut check_result: GLuint = 0;
        let checker_query = self.env.gen_query();

        gl!(gl.use_program(self.checker_program.program()));
        gl!(gl.begin_conditional_render(query, glw::GL_QUERY_WAIT));
        gl!(gl.begin_query(glw::GL_PRIMITIVES_GENERATED, checker_query));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl!(gl.end_query(glw::GL_PRIMITIVES_GENERATED));
        gl!(gl.end_conditional_render());
        gl!(gl.get_query_objectuiv(checker_query, glw::GL_QUERY_RESULT, &mut check_result));
        if check_result != GLuint::from(expected) {
            result = false;
        }

        if supports_conditional_render_inverted(self.context) {
            gl!(gl.begin_conditional_render(query, glw::GL_QUERY_WAIT_INVERTED));
            gl!(gl.begin_query(glw::GL_PRIMITIVES_GENERATED, checker_query));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl!(gl.end_query(glw::GL_PRIMITIVES_GENERATED));
            gl!(gl.end_conditional_render());
            gl!(gl.get_query_objectuiv(checker_query, glw::GL_QUERY_RESULT, &mut check_result));
            if check_result == GLuint::from(expected) {
                result = false;
            }
        }

        gl!(gl.use_program(current_program as GLuint));
        gl!(gl.get_query_objectuiv(query, glw::GL_QUERY_RESULT, &mut actual));
        if actual as u8 != u8::from(expected) {
            result = false;
        }

        if supports_query_buffer_object(self.context) {
            let init_value: GLuint = 0xDEADBEEF;
            let query_buffer = glu::Buffer::new(gl);
            gl!(gl.bind_buffer(glw::GL_QUERY_BUFFER, query_buffer.get()));
            gl!(gl.buffer_data(
                glw::GL_QUERY_BUFFER,
                4,
                std::ptr::from_ref(&init_value).cast(),
                glw::GL_STREAM_READ
            ));
            gl!(gl.get_query_objectuiv(query, glw::GL_QUERY_RESULT, std::ptr::null_mut()));
            gl!(gl.get_buffer_sub_data(glw::GL_QUERY_BUFFER, 0, 4, std::ptr::from_mut(&mut actual).cast()));
            if actual as u8 != u8::from(expected) {
                result = false;
            }
        }

        self.env.delete_query(checker_query);
        result
    }

    /// Verifies the result of all queries. There can only be up to 5 non-FALSE result queries as none of the tests use more than 4 vertex streams so the rest is assumed to always have a FALSE result.
    fn verify_query_results(&self, any: bool, stream0: bool, stream1: bool, stream2: bool, stream3: bool) -> Res<()> {
        let mut result = true;
        result &= self.verify_query_result(self.overflow_query, any);
        if self.env.transform_feedback3 {
            for (i, expected) in [stream0, stream1, stream2, stream3].into_iter().enumerate() {
                if let Some(&query) = self.stream_overflow_query.get(i) {
                    result &= self.verify_query_result(query, expected);
                }
            }
            for i in 4..self.env.max_vertex_streams as usize {
                if let Some(&query) = self.stream_overflow_query.get(i) {
                    result &= self.verify_query_result(query, false);
                }
            }
        }
        if !result {
            return fail("Failed to validate the results of the queries");
        }
        Ok(())
    }

    /// Single stream version of verifyQueryResults
    fn verify_query_results_single(&self, result: bool) -> Res<()> {
        self.verify_query_results(result, result, false, false, false)
    }

    /// Starts all overflow queries.
    fn begin_queries(&self) {
        let gl = self.env.gl;
        gl!(gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW, self.overflow_query));
        if self.env.transform_feedback3 {
            for (i, &query) in self.stream_overflow_query.iter().enumerate() {
                gl!(gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, i as GLuint, query));
            }
        }
    }

    /// Stops all overflow queries.
    fn end_queries(&self) {
        let gl = self.env.gl;
        gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_OVERFLOW));
        if self.env.transform_feedback3 {
            for i in 0..self.stream_overflow_query.len() {
                gl!(gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW, i as GLuint));
            }
        }
    }

    /// Draws a set of points to vertex stream #0 while having the overflow queries active.
    fn draw_points(&self, count: i32) {
        self.begin_queries();
        gl!(self.env.gl.draw_arrays(glw::GL_POINTS, 0, count));
        self.end_queries();
    }

    /// Draws a set of triangles to vertex stream #0 while having the overflow queries active.
    fn draw_triangles(&self, count: i32) {
        self.begin_queries();
        gl!(self.env.gl.draw_arrays(glw::GL_TRIANGLES, 0, count * 3));
        self.end_queries();
    }

    /// Draws a set of points to each vertex stream while having the overflow queries active.
    fn draw_streams(&self, counts: [i32; 4]) {
        let gl = self.env.gl;
        // SAFETY: a linked program and a NUL-terminated name.
        let stream_loc = unsafe { gl.get_uniform_location(self.program.program(), c"stream".as_ptr()) };
        self.begin_queries();
        for (stream, count) in counts.into_iter().enumerate() {
            gl!(gl.uniform_1ui(stream_loc, stream as GLuint));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, count));
        }
        self.end_queries();
    }

    fn begin_tf(&self, primitive_mode: GLenum) {
        gl!(self.env.gl.begin_transform_feedback(primitive_mode));
    }

    fn end_tf(&self) {
        gl!(self.env.gl.end_transform_feedback());
    }

    fn pause_tf(&self) {
        gl!(self.env.gl.pause_transform_feedback());
    }

    fn resume_tf(&self) {
        gl!(self.env.gl.resume_transform_feedback());
    }
}

impl Drop for Functional<'_> {
    /// Functional test deinit. Deletes created query objects
    fn drop(&mut self) {
        let gl = self.env.gl;
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        self.env.delete_query(self.overflow_query);
        for &query in &self.stream_overflow_query {
            self.env.delete_query(query);
        }
        gl!(gl.use_program(0));
    }
}

fn buffer_size_ten_vertices_interleaved(_index: usize) -> isize {
    (10 * std::mem::size_of::<f32>() * SINGLE_STREAM_VARYINGS.len()) as isize
}

fn buffer_size_basic_separate(index: usize) -> isize {
    // One of the transform feedback buffers should be able to capture exactly 12 vertices, the others should be able to capture at least 15 vertices.
    if index == 1 { 12 * 4 } else { 15 * 4 }
}

fn buffer_size_advanced_separate(index: usize) -> isize {
    if index == 2 { 12 * 4 } else { 15 * 4 }
}

fn buffer_size_ten_floats(_index: usize) -> isize {
    10 * 4
}

fn buffer_size_ten_or_twenty_floats(index: usize) -> isize {
    // Transform feedback buffers #0 and #1 should be able to capture exactly 10 vertices, while transform feedback buffers #2 and #3 should be able to capture exactly 20 vertices.
    if index < 2 { 10 * 4 } else { 20 * 4 }
}

fn single_stream_spec(buffer_mode: GLenum, buffer_count: usize, buffer_size: fn(usize) -> isize) -> FunctionalSpec {
    FunctionalSpec {
        vertex_shader: SINGLE_STREAM_VSH,
        geometry_shader: None,
        varyings: &SINGLE_STREAM_VARYINGS,
        buffer_mode,
        buffer_count,
        buffer_size,
    }
}

/// Test case #1 - Basic single stream, interleaved attributes.
fn basic_single_stream_interleaved(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let f = Functional::new(
        context,
        &env,
        &single_stream_spec(glw::GL_INTERLEAVED_ATTRIBS, 1, buffer_size_ten_vertices_interleaved),
    )?;

    f.begin_tf(glw::GL_POINTS);
    f.draw_points(10);
    f.end_tf();
    f.verify_query_results_single(false)?;

    f.begin_tf(glw::GL_POINTS);
    f.draw_points(11);
    f.end_tf();
    f.verify_query_results_single(true)?;

    Ok(TestStatus::pass("Pass"))
}

/// Test case #2 - Basic single stream, separate attributes.
fn basic_single_stream_separate(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let f = Functional::new(
        context,
        &env,
        &single_stream_spec(
            glw::GL_SEPARATE_ATTRIBS,
            SINGLE_STREAM_VARYINGS.len(),
            buffer_size_basic_separate,
        ),
    )?;

    f.begin_tf(glw::GL_TRIANGLES);
    f.draw_triangles(4);
    f.end_tf();
    f.verify_query_results_single(false)?;

    f.begin_tf(glw::GL_TRIANGLES);
    f.draw_triangles(5);
    f.end_tf();
    f.verify_query_results_single(true)?;

    Ok(TestStatus::pass("Pass"))
}

/// Test case #3 - Advanced single stream, interleaved attributes.
fn advanced_single_stream_interleaved(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let f = Functional::new(
        context,
        &env,
        &single_stream_spec(glw::GL_INTERLEAVED_ATTRIBS, 1, buffer_size_ten_vertices_interleaved),
    )?;

    if !supports_transform_feedback2(context) {
        return Err(TestError::NotSupported(
            "Required transform_feedback2 extension is not supported".to_string(),
        ));
    }

    f.begin_tf(glw::GL_POINTS);
    f.draw_points(8);
    f.pause_tf();
    f.verify_query_results_single(false)?;
    f.draw_points(11);
    f.verify_query_results_single(false)?;
    f.resume_tf();
    f.draw_points(1);
    f.pause_tf();
    f.verify_query_results_single(false)?;
    f.resume_tf();
    f.draw_points(2);
    f.end_tf();
    f.verify_query_results_single(true)?;

    Ok(TestStatus::pass("Pass"))
}

/// Test case #4 - Advanced single stream, separate attributes.
fn advanced_single_stream_separate(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let f = Functional::new(
        context,
        &env,
        &single_stream_spec(
            glw::GL_SEPARATE_ATTRIBS,
            SINGLE_STREAM_VARYINGS.len(),
            buffer_size_advanced_separate,
        ),
    )?;

    if !supports_transform_feedback2(context) {
        return Err(TestError::NotSupported(
            "Required transform_feedback2 extension is not supported".to_string(),
        ));
    }

    f.begin_tf(glw::GL_TRIANGLES);
    f.draw_triangles(2);
    f.pause_tf();
    f.verify_query_results_single(false)?;
    f.draw_triangles(4);
    f.verify_query_results_single(false)?;
    f.resume_tf();
    f.draw_triangles(2);
    f.pause_tf();
    f.verify_query_results_single(false)?;
    f.resume_tf();
    f.draw_triangles(1);
    f.end_tf();
    f.verify_query_results_single(true)?;

    Ok(TestStatus::pass("Pass"))
}

fn require_multiple_streams(context: &Context) -> Res<()> {
    if !supports_transform_feedback3(context) {
        return Err(TestError::NotSupported(
            "Required transform_feedback3 extension is not supported".to_string(),
        ));
    }
    if !supports_gpu_shader5(context) {
        return Err(TestError::NotSupported(
            "Required gpu_shader5 extension is not supported".to_string(),
        ));
    }
    Ok(())
}

/// Test case #5 - Advanced multiple streams, one buffer per stream.
fn multiple_streams_one_buffer_per_stream(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let spec = FunctionalSpec {
        vertex_shader: MULTIPLE_STREAMS_VSH,
        geometry_shader: Some(ONE_BUFFER_PER_STREAM_GSH),
        varyings: &ONE_BUFFER_PER_STREAM_VARYINGS,
        buffer_mode: glw::GL_INTERLEAVED_ATTRIBS,
        buffer_count: 4,
        buffer_size: buffer_size_ten_floats,
    };
    let f = Functional::new(context, &env, &spec)?;
    require_multiple_streams(context)?;

    f.begin_tf(glw::GL_POINTS);
    f.draw_streams([8, 8, 8, 8]);
    f.pause_tf();
    f.verify_query_results(false, false, false, false, false)?;
    f.draw_streams([11, 11, 11, 11]);
    f.verify_query_results(false, false, false, false, false)?;
    f.resume_tf();
    f.draw_streams([0, 3, 0, 3]);
    f.pause_tf();
    f.verify_query_results(true, false, true, false, true)?;
    f.resume_tf();
    f.draw_streams([2, 0, 2, 0]);
    f.pause_tf();
    f.verify_query_results(false, false, false, false, false)?;
    f.resume_tf();
    f.draw_streams([0, 0, 1, 1]);
    f.end_tf();
    f.verify_query_results(true, false, false, true, true)?;

    Ok(TestStatus::pass("Pass"))
}

/// Test case #6 - Advanced multiple streams, multiple buffers per stream.
fn multiple_streams_multiple_buffers_per_stream(context: &Context) -> TestOutcome {
    let env = Env::new(context);
    let spec = FunctionalSpec {
        vertex_shader: MULTIPLE_STREAMS_VSH,
        geometry_shader: Some(MULTIPLE_BUFFERS_PER_STREAM_GSH),
        varyings: &MULTIPLE_BUFFERS_PER_STREAM_VARYINGS,
        buffer_mode: glw::GL_INTERLEAVED_ATTRIBS,
        buffer_count: 4,
        buffer_size: buffer_size_ten_or_twenty_floats,
    };
    let f = Functional::new(context, &env, &spec)?;
    require_multiple_streams(context)?;

    f.begin_tf(glw::GL_POINTS);
    f.draw_streams([8, 8, 0, 0]);
    f.pause_tf();
    f.verify_query_results(false, false, false, false, false)?;
    f.draw_streams([11, 11, 0, 0]);
    f.verify_query_results(false, false, false, false, false)?;
    f.resume_tf();
    f.draw_streams([1, 3, 0, 0]);
    f.pause_tf();
    f.verify_query_results(true, false, true, false, false)?;
    f.resume_tf();
    f.draw_streams([1, 0, 0, 0]);
    f.pause_tf();
    f.verify_query_results(false, false, false, false, false)?;
    f.resume_tf();
    f.draw_streams([1, 1, 0, 0]);
    f.end_tf();
    f.verify_query_results(true, true, true, false, false)?;

    Ok(TestStatus::pass("Pass"))
}

struct OverflowQueryCase {
    name: &'static str,
    test: fn(&Context) -> TestOutcome,
    functional: bool,
}

impl TestCase for OverflowQueryCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `featureSupported`, thrown from `init` upstream
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !(context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback_overflow_query")
            || context.context_type().supports_core(4, 6))
        {
            return Err(TestError::NotSupported(
                "Required transform_feedback_overflow_query extension is not supported".to_string(),
            ));
        }
        if self.functional && !can_test_overflow(context.gl()) {
            return Err(TestError::NotSupported(
                "QUERY_COUNTER_BITS for TRANSFORM_FEEDBACK_OVERFLOW queries is zero, skipping test".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        (self.test)(context)
    }
}

/// `TransformFeedbackOverflowQueryTests::init` (API_GL_ARB_transform_feedback_overflow_query)
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback_overflow_query_ARB");
    let cases: [(&'static str, fn(&Context) -> TestOutcome, bool); 13] = [
        ("implementation-dependent-state", implementation_dependent_state, false),
        ("default-context-state", default_context_state, false),
        ("context-state-update", context_state_update, false),
        ("error-invalid-index", error_invalid_index, false),
        ("error-already-active", error_already_active, false),
        ("error-incompatible-target", error_incompatible_target, false),
        ("error-no-active-query", error_no_active_query, false),
        (
            "basic-single-stream-interleaved-attribs",
            basic_single_stream_interleaved,
            true,
        ),
        (
            "basic-single-stream-separate-attribs",
            basic_single_stream_separate,
            true,
        ),
        (
            "advanced-single-stream-interleaved-attribs",
            advanced_single_stream_interleaved,
            true,
        ),
        (
            "advanced-single-stream-separate-attribs",
            advanced_single_stream_separate,
            true,
        ),
        (
            "multiple-streams-one-buffer-per-stream",
            multiple_streams_one_buffer_per_stream,
            true,
        ),
        (
            "multiple-streams-multiple-buffers-per-stream",
            multiple_streams_multiple_buffers_per_stream,
            true,
        ),
    ];
    for (name, test, functional) in cases {
        group.add_child(Box::new(OverflowQueryCase { name, test, functional }) as Box<dyn TestCase>);
    }
    group
}
