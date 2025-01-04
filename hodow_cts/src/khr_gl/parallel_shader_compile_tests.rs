// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcParallelShaderCompileTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only. `max_shader_compile_threads` keeps upstream's verdicts for its two mismatch branches, which are `QP_TEST_RESULT_PASS` carrying a failure message.

use std::time::{Duration, Instant};

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const SHADER_VERSION_GL: &str = "#version 450\n";
const V_SHADER: &str = "\nin vec3 vertex;\n\nvoid main() {\n    gl_Position = vec4(vertex, 1);\n}\n";
const F_SHADER: &str = "\nout vec4 fragColor;\n\nvoid main() {\n    fragColor = vec4(1, 1, 1, 1);\n}\n";

/// The support check each of the three cases starts with.
fn check_parallel_supported(context: &Context) -> Result<(), TestError> {
    let supported = context
        .context_info
        .is_extension_supported("GL_ARB_parallel_shader_compile")
        || context
            .context_info
            .is_extension_supported("GL_KHR_parallel_shader_compile");

    if supported {
        Ok(())
    } else {
        Err(TestError::NotSupported("Not supported".to_string()))
    }
}

/// `SimpleQueriesTest`
struct SimpleQueriesTest;

impl TestCase for SimpleQueriesTest {
    fn name(&self) -> &str {
        "simple_queries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_parallel_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let mut bool_value: glw::GLboolean = 0;
        let mut int_value: GLint = 0;
        let mut int64_value: glw::GLint64 = 0;
        let mut float_value: glw::GLfloat = 0.0;
        let mut double_value: glw::GLdouble = 0.0;

        gl_call!(
            gl,
            "getBooleanv",
            gl.get_booleanv(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut bool_value)
        );
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut int_value)
        );
        gl_call!(
            gl,
            "getInteger64v",
            gl.get_integer_64v(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut int64_value)
        );
        gl_call!(
            gl,
            "getFloatv",
            gl.get_floatv(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut float_value)
        );
        gl_call!(
            gl,
            "getDoublev",
            gl.get_doublev(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut double_value)
        );

        if (bool_value != 0) != (int_value != 0)
            || int_value != float_value as GLint
            || int_value != int64_value as GLint
            || int_value != double_value as GLint
        {
            log::warn!(
                "Simple queries returned different values: bool({bool_value}), int({int_value}), int64({int64_value}), float({float_value}), double({double_value})"
            );
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `MaxShaderCompileThreadsTest`
struct MaxShaderCompileThreadsTest;

impl TestCase for MaxShaderCompileThreadsTest {
    fn name(&self) -> &str {
        "max_shader_compile_threads"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_parallel_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut int_value: GLint = 0;

        gl_call!(gl, "maxShaderCompilerThreadsKHR", gl.max_shader_compiler_threads_khr(0));
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut int_value)
        );

        if int_value != 0 {
            return Ok(TestStatus::pass("Failed to disable parallel shader compilation."));
        }

        gl_call!(
            gl,
            "maxShaderCompilerThreadsKHR",
            gl.max_shader_compiler_threads_khr(0xFFFF_FFFF)
        );
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_SHADER_COMPILER_THREADS_KHR, &mut int_value)
        );

        if int_value != 0xFFFF_FFFFu32 as GLint {
            return Ok(TestStatus::pass("Failed to set maximum shader compiler threads."));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `CompilationCompletionParallelTest`
struct CompilationCompletionParallelTest;

impl CompilationCompletionParallelTest {
    /// Polls `query` for all eight objects until each reports completion or a second has passed; true when all did.
    fn wait_for_completion(
        gl: &glw::Functions,
        objects: &[GLuint; 8],
        what: &str,
        is_program: bool,
    ) -> Result<bool, TestError> {
        let start = Instant::now();
        let mut completion = 0;

        while completion != 8 && start.elapsed() < Duration::from_secs(1) {
            completion = 0;
            for &object in objects {
                let mut completion_status: GLint = 0;
                if is_program {
                    gl_call!(
                        gl,
                        what,
                        gl.get_programiv(object, glw::GL_COMPLETION_STATUS_KHR, &mut completion_status)
                    );
                } else {
                    gl_call!(
                        gl,
                        what,
                        gl.get_shaderiv(object, glw::GL_COMPLETION_STATUS_KHR, &mut completion_status)
                    );
                }
                if completion_status != 0 {
                    completion += 1;
                }
            }
        }

        Ok(completion == 8)
    }

    fn body(
        gl: &glw::Functions,
        vertex_shader: GLuint,
        fragment_shader: &mut [GLuint; 8],
        program: &mut [GLuint; 8],
    ) -> TestOutcome {
        for i in 0..8 {
            // SAFETY: plain object creation with a current context.
            unsafe {
                fragment_shader[i] = gl.create_shader(glw::GL_FRAGMENT_SHADER);
                program[i] = gl.create_program();
            }
        }

        let v_sources = [SHADER_VERSION_GL, V_SHADER];
        let v_pointers = v_sources.map(|source| source.as_ptr().cast::<glw::GLchar>());
        let v_lengths = v_sources.map(|source| source.len() as GLint);
        // SAFETY: two strings that outlive the call, with their exact lengths.
        unsafe { gl.shader_source(vertex_shader, 2, v_pointers.as_ptr(), v_lengths.as_ptr()) };

        // Compilation test
        let f_sources = [SHADER_VERSION_GL, F_SHADER];
        let f_pointers = f_sources.map(|source| source.as_ptr().cast::<glw::GLchar>());
        let f_lengths = f_sources.map(|source| source.len() as GLint);
        for &shader in fragment_shader.iter() {
            // SAFETY: two strings that outlive the call, with their exact lengths.
            unsafe { gl.shader_source(shader, 2, f_pointers.as_ptr(), f_lengths.as_ptr()) };
        }

        gl_call!(gl, "compileShader", gl.compile_shader(vertex_shader));
        for &shader in fragment_shader.iter() {
            gl_call!(gl, "compileShader", gl.compile_shader(shader));
        }

        if !Self::wait_for_completion(gl, fragment_shader, "getShaderiv", false)? {
            return Ok(TestStatus::fail(
                "Failed reading completion status for parallel shader compiling",
            ));
        }

        for i in 0..8 {
            gl_call!(gl, "attachShader", gl.attach_shader(program[i], vertex_shader));
            gl_call!(gl, "attachShader", gl.attach_shader(program[i], fragment_shader[i]));
        }

        // Linking test
        for &object in program.iter() {
            gl_call!(gl, "linkProgram", gl.link_program(object));
        }

        if !Self::wait_for_completion(gl, program, "getProgramiv", true)? {
            return Ok(TestStatus::fail(
                "Failed reading completion status for parallel program linking",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for CompilationCompletionParallelTest {
    fn name(&self) -> &str {
        "compilation_completion_parallel"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_parallel_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        gl_call!(gl, "maxShaderCompilerThreadsKHR", gl.max_shader_compiler_threads_khr(8));

        // SAFETY: plain object creation with a current context.
        let vertex_shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
        let mut fragment_shader = [0 as GLuint; 8];
        let mut program = [0 as GLuint; 8];

        let outcome = Self::body(gl, vertex_shader, &mut fragment_shader, &mut program);

        // SAFETY: the objects created above, each deleted once (zero names are ignored by GL).
        unsafe {
            for i in 0..8 {
                gl.delete_program(program[i]);
                gl.delete_shader(fragment_shader[i]);
            }
            gl.delete_shader(vertex_shader);
        }

        outcome
    }
}

/// `ParallelShaderCompileTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("parallel_shader_compile");
    group.add_child(Box::new(SimpleQueriesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(MaxShaderCompileThreadsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(CompilationCompletionParallelTest) as Box<dyn TestCase>);
    group
}
