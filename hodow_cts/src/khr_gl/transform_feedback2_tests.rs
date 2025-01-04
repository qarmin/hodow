// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTransformFeedbackTests.cpp
//   external/openglcts/modules/common/glcTransformFeedbackTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the root that registers this group). The group is `transform_feedback2`, with the single `transform_feedback2_states` case. The support condition upstream throws from `iterate` is `check_support`. Upstream first compiles a checker program with a fragment shader and then builds the vertex-only transform feedback program by hand; here that is two `ShaderProgram`s. The transform feedback object, buffers, queries, vertex array and program are guards released when `iterate` ends (upstream's destructor).

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const VERTICES: [f32; 24] = [
    -0.8, -0.8, 0.0, 1.0, 0.8, -0.8, 0.0, 1.0, -0.8, 0.8, 0.0, 1.0, 0.8, 0.8, 0.0, 1.0, -0.8, 0.8, 0.0, 1.0, 0.8, -0.8,
    0.0, 1.0,
];

/// Vertex shader source code to test transform feedback states conformance.
const SHADER_VERT: &str = "${VERSION}\n    in vec4 in_vertex;\n    void main (void)\n    {\n        vec4 temp = in_vertex;\n        temp.xyz *= 0.5;\n        gl_Position = temp;\n    }\n";

/// Fragment shader source code to test transform feedback states conformance.
const SHADER_FRAG: &str =
    "${VERSION}\n    ${PRECISION}\n    out vec4 frag;\n    void main (void)\n    {\n        frag = vec4(0.0);\n    }\n";

/// `draw_simple2` (the one test that uses it): the draw with a pause and resume in the middle; `false` is a failed check, upstream's `result`.
fn draw_simple2(
    gl: &glw::Functions,
    program: GLuint,
    primitive_type: glw::GLenum,
    vertex_count: GLint,
    pause_resume: bool,
) -> Res<Option<bool>> {
    // SAFETY: a linked program and a NUL-terminated name.
    let loc_vertices = unsafe { gl.get_attrib_location(program, c"in_vertex".as_ptr()) };
    if loc_vertices < 0 {
        return Ok(None);
    }
    glu::expect_no_error(gl, "getAttribLocation")?;

    let mut result = true;

    let vao = glu::VertexArray::new(gl);
    glu::expect_no_error(gl, "genVertexArrays")?;
    gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao.get()));

    gl_call!(gl, "clearColor", gl.clear_color(0.1, 0.0, 0.0, 1.0));
    gl_call!(
        gl,
        "clear",
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
    );
    gl_call!(
        gl,
        "vertexAttribPointer",
        gl.vertex_attrib_pointer(
            loc_vertices as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        )
    );
    gl_call!(
        gl,
        "enableVertexAttribArray",
        gl.enable_vertex_attrib_array(loc_vertices as GLuint)
    );

    gl_call!(
        gl,
        "beginTransformFeedback",
        gl.begin_transform_feedback(primitive_type)
    );

    if pause_resume {
        // Query the transform feedback state for TRANSFORM_FEEDBACK_BUFFER_PAUSED and TRANSFORM_FEEDBACK_BUFFER_ACTIVE to verify the state is reflected correctly.
        let mut paused: glw::GLboolean = 0;
        let mut active: glw::GLboolean = 0;
        gl_call!(gl, "pauseTransformFeedback", gl.pause_transform_feedback());

        // While the transform feedback is paused, verify that drawing with incompatible primitives does not produce an error like it would when transform feedback is not paused.
        gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_LINES, 0, vertex_count));
        // SAFETY: no arguments.
        if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
            result = false;
        }

        gl_call!(
            gl,
            "getBooleanv",
            gl.get_booleanv(glw::GL_TRANSFORM_FEEDBACK_PAUSED, &mut paused)
        );
        gl_call!(
            gl,
            "getBooleanv",
            gl.get_booleanv(glw::GL_TRANSFORM_FEEDBACK_ACTIVE, &mut active)
        );
        if paused == 0 || active == 0 {
            result = false;
        }

        gl_call!(gl, "resumeTransformFeedback", gl.resume_transform_feedback());
        gl_call!(
            gl,
            "getBooleanv",
            gl.get_booleanv(glw::GL_TRANSFORM_FEEDBACK_PAUSED, &mut paused)
        );
        gl_call!(
            gl,
            "getBooleanv",
            gl.get_booleanv(glw::GL_TRANSFORM_FEEDBACK_ACTIVE, &mut active)
        );
        if paused != 0 || active == 0 {
            result = false;
        }
    }

    // Draw primitives.
    gl_call!(gl, "drawArrays", gl.draw_arrays(primitive_type, 0, vertex_count));
    // An overflow while writing out to transform feedback buffers generates an error; clear it out in case of an overflow.
    // SAFETY: no arguments.
    unsafe { gl.get_error() };

    gl_call!(gl, "endTransformFeedback", gl.end_transform_feedback());
    gl_call!(
        gl,
        "disableVertexAttribArray",
        gl.disable_vertex_attrib_array(loc_vertices as GLuint)
    );
    gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(0));

    Ok(Some(result))
}

/// `TransformFeedbackStatesTestCase::iterate`
fn transform_feedback2_states(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let specialization = [
        (
            "VERSION",
            context.context_type().glsl_version().declaration().to_string(),
        ),
        ("PRECISION", String::new()),
    ];
    let mut ret = true;

    // setup shader program
    let vshader = StringTemplate::new(SHADER_VERT).specialize(&specialization)?;
    let fshader = StringTemplate::new(SHADER_FRAG).specialize(&specialization)?;
    let checker_program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vshader.as_str(), fshader.as_str()));
    if !checker_program.is_ok() {
        log::info!(
            "Shader build failed.\n{}",
            checker_program.build_failure_summary().unwrap_or_default()
        );
        return Err(TestError::Fail("Compile failed".to_string()));
    }

    // buildTransformFeedbackProgram: the vertex shader only (a fragment shader is needed only for GLES linking)
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::default()
            .with(ShaderType::Vertex, vshader.as_str())
            .with_transform_feedback(&["gl_Position".to_string()], glw::GL_SEPARATE_ATTRIBS),
    );
    if !program.is_ok() {
        return Err(TestError::Fail(format!(
            "Failed to compile or link the transform feedback program. {}",
            program.build_failure_summary().unwrap_or_default()
        )));
    }
    gl_call!(gl, "useProgram", gl.use_program(program.program()));

    // Create and bind a user transform feedback object with GenTransformFeedbacks and BindTransformFeedback and ensure the test runs correctly. Delete the user transform buffer object.
    // Create multiple user transform feedback objects and configure different state in each object. The state tested should be the following: TRANSFORM_FEEDBACK_BUFFER_BINDING, TRANSFORM_FEEDBACK_BUFFER_START, TRANSFORM_FEEDBACK_BUFFER_SIZE
    let tf = glu::TransformFeedback::new(gl);
    glu::expect_no_error(gl, "genTransformFeedbacks")?;
    gl_call!(
        gl,
        "bindTransformFeedback",
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf.get())
    );
    let buffers = [glu::Buffer::new(gl), glu::Buffer::new(gl)];
    glu::expect_no_error(gl, "genBuffers")?;
    let vertices_size = std::mem::size_of_val(&VERTICES) as isize;
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffers[0].get()));
    gl_call!(
        gl,
        "bufferData",
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            vertices_size,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        )
    );
    gl_call!(
        gl,
        "bindBufferBase",
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffers[0].get())
    );
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffers[1].get()));
    gl_call!(
        gl,
        "bufferData",
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            vertices_size,
            VERTICES.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );

    // Test
    let mut bbinding: GLint = 0;
    gl_call!(
        gl,
        "getIntegerv",
        gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, &mut bbinding)
    );
    let mut bstart: i64 = 0;
    let mut bsize: i64 = 0;
    gl_call!(
        gl,
        "getTransformFeedbacki64_v",
        gl.get_transform_feedbacki_64_v(tf.get(), glw::GL_TRANSFORM_FEEDBACK_BUFFER_START, 0, &mut bstart)
    );
    gl_call!(
        gl,
        "getTransformFeedbacki64_v",
        gl.get_transform_feedbacki_64_v(tf.get(), glw::GL_TRANSFORM_FEEDBACK_BUFFER_SIZE, 0, &mut bsize)
    );
    if bbinding >= 0 && (bbinding as GLuint != tf.get()) && (bstart != 0) && (bsize != vertices_size as i64) {
        return Err(TestError::Fail(
            "Unexpected state of transform feedback buffer".to_string(),
        ));
    }

    // Create two query objects and call BeginQuery(PRIMITIVES_GENERATED) and BeginQuery(TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN), which can be used to determine when feedback is complete.
    let queries = [glu::Query::new(gl), glu::Query::new(gl)];
    glu::expect_no_error(gl, "genQueries")?;
    gl_call!(
        gl,
        "beginQuery",
        gl.begin_query(glw::GL_PRIMITIVES_GENERATED, queries[0].get())
    );
    gl_call!(
        gl,
        "beginQuery",
        gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, queries[1].get())
    );

    match draw_simple2(gl, program.program(), glw::GL_TRIANGLES, 6, true)? {
        Some(true) => {}
        _ => return Ok(TestStatus::fail("Fail")),
    }

    gl_call!(gl, "endQuery", gl.end_query(glw::GL_PRIMITIVES_GENERATED));
    gl_call!(
        gl,
        "endQuery",
        gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)
    );

    let mut queryresults: [GLuint; 2] = [0, 0];
    gl_call!(
        gl,
        "getQueryObjectuiv",
        gl.get_query_objectuiv(queries[0].get(), glw::GL_QUERY_RESULT, &mut queryresults[0])
    );
    gl_call!(
        gl,
        "getQueryObjectuiv",
        gl.get_query_objectuiv(queries[1].get(), glw::GL_QUERY_RESULT, &mut queryresults[1])
    );

    if queryresults[0] != 5 || queryresults[1] != 2 {
        ret = false;
        log::info!("Query result error: {} != 5, {} != 2", queryresults[0], queryresults[1]);
    }

    Ok(if ret {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

struct TransformFeedbackStatesCase;

impl TestCase for TransformFeedbackStatesCase {
    fn name(&self) -> &str {
        "transform_feedback2_states"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let context_type = context.context_type();
        let supported = (context_type.supports_core(1, 4)
            && context
                .context_info
                .is_extension_supported("GL_ARB_transform_feedback2"))
            || context_type.supports_core(4, 0);
        if !supported {
            return Err(TestError::NotSupported(
                "transform_feedback2 is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        transform_feedback2_states(context)
    }
}

/// `TransformFeedbackTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback2");
    group.add_child(Box::new(TransformFeedbackStatesCase) as Box<dyn TestCase>);
    group
}
