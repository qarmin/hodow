// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cConditionalRenderInvertedTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `throw 0` is an `Err`, and the cleanup its `catch`/tail does runs after the fallible body returns. The test program is a `glu::ShaderProgram`.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const VERTEX_SHADER: &str = "#version 130\n\
    \n\
    void main()\n\
    {\n\
    \x20   switch(gl_VertexID % 4)\n\
    \x20   {\n\
    \x20   case 0:\n\
    \x20      gl_Position = vec4(-1.0, -1.0,  0.0,  1.0);\n\
    \x20      break;\n\
    \x20   case 1:\n\
    \x20      gl_Position = vec4( 1.0, -1.0,  0.0,  1.0);\n\
    \x20      break;\n\
    \x20   case 2:\n\
    \x20      gl_Position = vec4(-1.0,  1.0,  0.0,  1.0);\n\
    \x20      break;\n\
    \x20   case 3:\n\
    \x20      gl_Position = vec4( 1.0,  1.0,  0.0,  1.0);\n\
    \x20      break;\n\
    \x20   }\n\
    }\n";

const FRAGMENT_SHADER: &str = "#version 130\n\
    \n\
    uniform float color;\n\
    uniform int   shall_pass;\n\
    \n\
    out vec4 pixel;\n\
    \n\
    void main()\n\
    {\n\
    \x20   if(0 == shall_pass)\n\
    \x20   {\n\
    \x20       discard;\n\
    \x20   }\n\
    \n\
    \x20   pixel = vec4(color);\n\
    }\n";

const VIEW_SIZE: i32 = 1;

const MODES: [glw::GLenum; 4] = [
    glw::GL_QUERY_WAIT_INVERTED,
    glw::GL_QUERY_NO_WAIT_INVERTED,
    glw::GL_QUERY_BY_REGION_WAIT_INVERTED,
    glw::GL_QUERY_BY_REGION_NO_WAIT_INVERTED,
];

/// `Utilities::modeToChars`
fn mode_to_chars(mode: glw::GLenum) -> &'static str {
    match mode {
        glw::GL_QUERY_WAIT_INVERTED => "GL_QUERY_WAIT_INVERTED",
        glw::GL_QUERY_NO_WAIT_INVERTED => "GL_QUERY_NO_WAIT_INVERTED",
        glw::GL_QUERY_BY_REGION_WAIT_INVERTED => "GL_QUERY_BY_REGION_WAIT_INVERTED",
        glw::GL_QUERY_BY_REGION_NO_WAIT_INVERTED => "GL_QUERY_BY_REGION_NO_WAIT_INVERTED",
        _ => "unknow mode",
    }
}

/// `Utilities::queryTargetToChars`
fn query_target_to_chars(target: glw::GLenum) -> &'static str {
    match target {
        glw::GL_ANY_SAMPLES_PASSED => "GL_ANY_SAMPLES_PASSED",
        glw::GL_SAMPLES_PASSED => "GL_SAMPLES_PASSED",
        _ => "unknow mode",
    }
}

/// The `is_at_least_gl_45 || is_arb_conditional_render_inverted` guard both tests start with; when it is false upstream runs nothing and passes.
fn is_supported(context: &Context) -> bool {
    context.context_type().supports_core(4, 5)
        || context
            .context_info
            .is_extension_supported("GL_ARB_conditional_render_inverted")
}

fn drain_errors(gl: &glw::Functions) {
    // SAFETY: `glGetError` takes no arguments.
    while unsafe { gl.get_error() } != glw::GL_NO_ERROR {}
}

/// `Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("conditional_render_inverted");
    group.add_child(Box::new(CoverageTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalTest) as Box<dyn TestCase>);
    group
}

/// `CoverageTest`
struct CoverageTest;

impl CoverageTest {
    /// `CoverageTest::createQueryObject`
    fn create_query_object(gl: &glw::Functions, qo_id: &mut GLuint) -> Result<(), TestError> {
        gl_call!(gl, "glGenQueries() call failed.", gl.gen_queries(1, qo_id));
        gl_call!(
            gl,
            "glBeginQuery() call failed.",
            gl.begin_query(glw::GL_SAMPLES_PASSED, *qo_id)
        );
        gl_call!(gl, "glEndQuery() call failed.", gl.end_query(glw::GL_SAMPLES_PASSED));
        Ok(())
    }

    /// `CoverageTest::test`
    fn test(gl: &glw::Functions, qo_id: GLuint, mode: glw::GLenum) -> Result<bool, TestError> {
        let mut is_no_error = true;

        // SAFETY: `qo_id` is a query object created by `create_query_object`.
        unsafe { gl.begin_conditional_render(qo_id, mode) };

        // SAFETY: `glGetError` takes no arguments.
        while glw::GL_NO_ERROR != unsafe { gl.get_error() } {
            is_no_error = false;
        }

        if is_no_error {
            gl_call!(gl, "glEndConditionalRender() call failed.", gl.end_conditional_render());
        }

        if !is_no_error {
            log::warn!(
                "glBeginConditionalRender failed when used with mode {}.",
                mode_to_chars(mode)
            );
        }

        Ok(is_no_error)
    }

    fn run(context: &Context, qo_id: &mut GLuint) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut is_ok = true;

        if is_supported(context) {
            Self::create_query_object(gl, qo_id)?;

            for mode in MODES {
                is_ok &= Self::test(gl, *qo_id, mode)?;
            }
        }
        Ok(is_ok)
    }
}

impl TestCase for CoverageTest {
    fn name(&self) -> &str {
        "coverage"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut qo_id: GLuint = 0;

        let result = Self::run(context, &mut qo_id);

        // `clean`
        // SAFETY: deleting a name (or zero) generated above.
        unsafe { gl.delete_queries(1, &qo_id) };
        drain_errors(gl);

        match result? {
            true => Ok(TestStatus::pass("Pass")),
            false => {
                log::warn!("The Conditional Render Inverted Coverage Test has failed.");
                Ok(TestStatus::fail("Fail"))
            }
        }
    }
}

/// The object names `FunctionalTest` keeps as members.
#[derive(Default)]
struct Objects {
    fbo_id: GLuint,
    rbo_id: GLuint,
    vao_id: GLuint,
    qo_id: GLuint,
}

/// `FunctionalTest`
struct FunctionalTest;

impl FunctionalTest {
    /// `FunctionalTest::createView`
    fn create_view(gl: &glw::Functions, objects: &mut Objects) -> Result<(), TestError> {
        gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.5, 0.5, 0.5, 0.5));
        gl_call!(
            gl,
            "glGenFramebuffers call failed.",
            gl.gen_framebuffers(1, &mut objects.fbo_id)
        );
        gl_call!(
            gl,
            "glGenRenderbuffers call failed.",
            gl.gen_renderbuffers(1, &mut objects.rbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo_id)
        );
        gl_call!(
            gl,
            "glBindRenderbuffer call failed.",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo_id)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage call failed.",
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R8, VIEW_SIZE, VIEW_SIZE)
        );
        gl_call!(
            gl,
            "glFramebufferRenderbuffer call failed.",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                objects.rbo_id
            )
        );

        // SAFETY: a plain state query on the bound framebuffer.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::InternalError("framebuffer incomplete".to_string()));
        }

        gl_call!(gl, "glViewport call failed.", gl.viewport(0, 0, VIEW_SIZE, VIEW_SIZE));
        Ok(())
    }

    /// `FunctionalTest::createVertexArrayObject`
    fn create_vertex_array_object(gl: &glw::Functions, objects: &mut Objects) -> Result<(), TestError> {
        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut objects.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(objects.vao_id)
        );
        Ok(())
    }

    /// `FunctionalTest::setupColor`
    fn setup_color(gl: &glw::Functions, program: GLuint, red: f32) -> Result<(), TestError> {
        // SAFETY: a NUL-terminated name.
        let location = unsafe { gl.get_uniform_location(program, c"color".as_ptr()) };
        glu::expect_no_error(gl, "glGetUniformLocation() call failed.")?;
        gl_call!(gl, "glUniform1f() call failed.", gl.uniform_1f(location, red));
        Ok(())
    }

    /// `FunctionalTest::setupPassSwitch`
    fn setup_pass_switch(gl: &glw::Functions, program: GLuint, shall_pass: bool) -> Result<(), TestError> {
        // SAFETY: a NUL-terminated name.
        let location = unsafe { gl.get_uniform_location(program, c"shall_pass".as_ptr()) };
        glu::expect_no_error(gl, "glGetUniformLocation() call failed.")?;
        gl_call!(
            gl,
            "glUniform1f() call failed.",
            gl.uniform_1i(location, i32::from(shall_pass))
        );
        Ok(())
    }

    /// `FunctionalTest::draw`
    fn draw(
        gl: &glw::Functions,
        objects: &Objects,
        conditional_or_query_draw: bool,
        condition_mode_or_query_target: glw::GLenum,
    ) -> Result<(), TestError> {
        if conditional_or_query_draw {
            gl_call!(
                gl,
                "glBeginConditionalRender() call failed.",
                gl.begin_conditional_render(objects.qo_id, condition_mode_or_query_target)
            );
        } else {
            gl_call!(
                gl,
                "glBeginQuery() call failed.",
                gl.begin_query(condition_mode_or_query_target, objects.qo_id)
            );
        }

        // SAFETY: an attribute-less draw of the four vertices the vertex shader generates.
        unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };

        if conditional_or_query_draw {
            gl_call!(gl, "glEndConditionalRender() call failed.", gl.end_conditional_render());
        } else {
            gl_call!(
                gl,
                "glEndQuery() call failed.",
                gl.end_query(condition_mode_or_query_target)
            );
        }
        Ok(())
    }

    /// `FunctionalTest::fragmentsPassed`
    fn fragments_passed(gl: &glw::Functions, objects: &Objects) -> Result<bool, TestError> {
        let mut result: glw::GLint = -1;
        gl_call!(
            gl,
            "glGetQueryObjectiv() call failed.",
            gl.get_query_objectiv(objects.qo_id, glw::GL_QUERY_RESULT, &mut result)
        );

        if -1 == result {
            return Err(TestError::InternalError("query result not written".to_string()));
        }
        Ok(result > 0)
    }

    /// `FunctionalTest::readPixel`
    fn read_pixel(gl: &glw::Functions) -> Result<f32, TestError> {
        let mut red = -1.0f32;
        gl_call!(
            gl,
            "glReadPixels() call failed.",
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_RED,
                glw::GL_FLOAT,
                std::ptr::from_mut(&mut red).cast()
            )
        );
        Ok(red)
    }

    /// `FunctionalTest::cleanQueryObject`
    fn clean_query_object(gl: &glw::Functions, objects: &mut Objects) {
        if objects.qo_id != 0 {
            // SAFETY: a query name generated by `glGenQueries`, deleted once.
            unsafe { gl.delete_queries(1, &objects.qo_id) };
            objects.qo_id = 0;
        }
    }

    /// `FunctionalTest::cleanProgramViewAndVAO`
    fn clean_program_view_and_vao(gl: &glw::Functions, objects: &mut Objects) {
        // SAFETY: names generated in `create_view` / `create_vertex_array_object`, each deleted once.
        unsafe {
            if objects.fbo_id != 0 {
                gl.delete_framebuffers(1, &objects.fbo_id);
                objects.fbo_id = 0;
            }
            if objects.rbo_id != 0 {
                gl.delete_renderbuffers(1, &objects.rbo_id);
                objects.rbo_id = 0;
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
                objects.vao_id = 0;
            }
        }
    }

    fn run(context: &Context, objects: &mut Objects) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut is_ok = true;

        if !is_supported(context) {
            return Ok(is_ok);
        }

        const RENDER_CASES: [bool; 2] = [false, true];
        const QUERY_CASES: [glw::GLenum; 2] = [glw::GL_SAMPLES_PASSED, glw::GL_ANY_SAMPLES_PASSED];

        // `createProgram`
        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(VERTEX_SHADER.to_string(), FRAGMENT_SHADER.to_string()),
        );
        if !program.is_ok() {
            return Err(TestError::InternalError(
                program.build_failure_summary().unwrap_or_default(),
            ));
        }
        gl_call!(gl, "glUseProgram call failed.", gl.use_program(program.program()));

        Self::create_view(gl, objects)?;
        Self::create_vertex_array_object(gl, objects)?;

        for render_case in RENDER_CASES {
            for query_case in QUERY_CASES {
                for mode in MODES {
                    gl_call!(gl, "glGenQueries() call failed.", gl.gen_queries(1, &mut objects.qo_id));

                    Self::setup_color(gl, program.program(), 1.0)?;
                    Self::setup_pass_switch(gl, program.program(), render_case)?;
                    gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
                    Self::draw(gl, objects, false, query_case)?;

                    if render_case == Self::fragments_passed(gl, objects)? {
                        Self::setup_color(gl, program.program(), 0.0)?;
                        Self::setup_pass_switch(gl, program.program(), true)?;
                        Self::draw(gl, objects, true, mode)?;

                        let expected_value = if render_case { 1.0f32 } else { 0.0f32 };
                        let resulted_value = Self::read_pixel(gl)?;

                        if (expected_value - resulted_value).abs() > 0.0078125 {
                            log::warn!(
                                "The functional test's expected value ({expected_value}) is different than resulted value ({resulted_value}). The tested mode was {}. Query was done for target {}, and the test was prepared to {} all fragments.",
                                mode_to_chars(mode),
                                query_target_to_chars(query_case),
                                if render_case { "pass" } else { "discard" }
                            );
                            is_ok = false;
                        }
                    } else {
                        is_ok = false;
                    }

                    Self::clean_query_object(gl, objects);
                }
            }
        }
        Ok(is_ok)
    }
}

impl TestCase for FunctionalTest {
    fn name(&self) -> &str {
        "functional"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = Objects::default();

        let result = Self::run(context, &mut objects);

        Self::clean_query_object(gl, &mut objects);
        Self::clean_program_view_and_vao(gl, &mut objects);

        match result? {
            true => Ok(TestStatus::pass("Pass")),
            false => {
                log::warn!("The Conditional Render Inverted Functional Test has failed.");
                Ok(TestStatus::fail("Fail."))
            }
        }
    }
}
