// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cES31CompatibilityTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The group's "Ported tests" are the Khronos `SampleVariablesTests` in GLSL ES 3.10 (`sample_variables_tests`); its `ShaderImageLoadStoreTests` and `ShaderStorageBufferObjectTests` are `es31_image_load_store` and `es31_ssbo`. `ShaderFunctionalCompatibilityTest::s_shaders` is the `SHADERS` table below (extracted from the C++ by script: TTYPE, BTYPE, LEFT, RIGHT, BDATA, REFERENCE, OPERATION, PARAMS of each entry's `#define`s). An error thrown inside either case is INTERNAL_ERROR upstream, which `iterate` keeps; a context without GL 4.5 or `GL_ARB_ES3_1_compatibility` passes without running anything, as upstream does.

use super::sample_variables_tests;
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLint};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

fn es31_compatibility_available(context: &Context) -> bool {
    context.context_type().supports_core(4, 5)
        || context
            .context_info
            .is_extension_supported("GL_ARB_ES3_1_compatibility")
}

/// What both cases report for an `is_ok`/`is_error` pair.
fn status(is_ok: bool, is_error: bool) -> TestStatus {
    if is_ok {
        TestStatus::pass("Pass")
    } else if is_error {
        log::info!("Internal error has occured during the Shader Version Test.");
        TestStatus::new(TestResult::InternalError, "Test error.")
    } else {
        log::info!("The Shader Version Test has failed.");
        TestStatus::fail("Fail")
    }
}

// ---------------------------------------------------------------------------------------------
// ShaderCompilationCompatibilityTests
// ---------------------------------------------------------------------------------------------

/// `TestShader`: type, type name, source
const COMPILATION_SHADERS: [(glw::GLenum, &str, &str); 4] = [
    // Shader for testing ES 3.1 version string support.
    (
        glw::GL_VERTEX_SHADER,
        "vertex",
        "#version 310 es\n\nvoid main()\n{\n    gl_Position = vec4(1.0);\n}\n",
    ),
    // Shader for testing ES 3.1 version string support.
    (
        glw::GL_FRAGMENT_SHADER,
        "fragment",
        "#version 310 es\n\nout highp vec4 color;\nvoid main()\n{\n    color = vec4(1.0);\n}\n",
    ),
    // Shader for testing that gl_HelperInvocation variable is supported.
    (
        glw::GL_FRAGMENT_SHADER,
        "fragment",
        "#version 310 es\n\nout highp vec4 color;\nvoid main()\n{\n    if(gl_HelperInvocation)\n    {\n        color = vec4(1.0);\n    }\n    else\n    {\n        color = vec4(0.0);\n    }\n}\n",
    ),
    // Shader for testing ES 3.1 version string support.
    (
        glw::GL_COMPUTE_SHADER,
        "compute",
        "#version 310 es\n\nlayout(local_size_x = 128) in;\nlayout(std140, binding = 0) buffer Output\n{\n    uint elements[];\n} output_data;\n\nvoid main()\n{\n    output_data.elements[gl_GlobalInvocationID.x] = gl_GlobalInvocationID.x * gl_GlobalInvocationID.x;\n}\n",
    ),
];

/// `ShaderCompilationCompatibilityTests::iterate`
fn shader_compilation(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let mut is_ok = true;
    let mut is_error = false;

    let run = || -> Res<bool> {
        let mut is_ok = true;
        for (shader_type, type_name, source) in COMPILATION_SHADERS {
            // Shader compilation.
            // SAFETY: a current context.
            let shader = unsafe { gl.create_shader(shader_type) };
            glu::expect_no_error(gl, "glCreateShader call failed.")?;
            if shader == 0 {
                return Err(TestError::Fail("glCreateShader returned 0".to_string()));
            }
            let c_source = std::ffi::CString::new(source).expect("shader source holds no nul byte");
            let pointer = c_source.as_ptr();
            gl_call!(
                gl,
                "glShaderSource call failed.",
                gl.shader_source(shader, 1, &pointer, std::ptr::null())
            );
            gl_call!(gl, "glCompileShader call failed.", gl.compile_shader(shader));

            // Checking for errors.
            let mut status: GLint = glw::GL_FALSE as GLint;
            gl_call!(
                gl,
                "glGetShaderiv call failed.",
                gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status)
            );
            if status == glw::GL_FALSE as GLint {
                // Setup result.
                is_ok = false;

                // Getting compilation informations.
                let mut log_size: GLint = 0;
                gl_call!(
                    gl,
                    "glGetShaderiv() call failed.",
                    gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut log_size)
                );
                if log_size > 0 {
                    let mut info_log = vec![0u8; log_size as usize];
                    gl_call!(
                        gl,
                        "glGetShaderInfoLog() call failed.",
                        gl.get_shader_info_log(shader, log_size, std::ptr::null_mut(), info_log.as_mut_ptr().cast())
                    );
                    let end = info_log.iter().position(|&b| b == 0).unwrap_or(info_log.len());
                    log::info!(
                        "Compilation of {type_name} shader have failed.\n Shader source was:\n{source}\nCompillation log:\n{}",
                        String::from_utf8_lossy(&info_log[..end])
                    );
                }
            }

            // Cleanup.
            gl_call!(gl, "glDeleteShader call failed.", gl.delete_shader(shader));
        }
        Ok(is_ok)
    };

    if es31_compatibility_available(context) {
        match run() {
            Ok(ok) => is_ok = ok,
            Err(error) => {
                log::info!("{error}");
                is_ok = false;
                is_error = true;
            }
        }
    }

    Ok(status(is_ok, is_error))
}

// ---------------------------------------------------------------------------------------------
// ShaderFunctionalCompatibilityTest
// ---------------------------------------------------------------------------------------------

const SHADER_VERSION: &str = "#version 310 es\n";

const VERTEX_SHADER_BODY: &str = "\nout highp float vout;\n\nvoid main()\n{\n    switch(gl_VertexID % 4)\n    {\n    case 0:\n       gl_Position = vec4(-1.0, -1.0,  0.0,  1.0);\n       break;\n    case 1:\n       gl_Position = vec4( 1.0, -1.0,  0.0,  1.0);\n       break;\n    case 2:\n       gl_Position = vec4(-1.0,  1.0,  0.0,  1.0);\n       break;\n    case 3:\n       gl_Position = vec4( 1.0,  1.0,  0.0,  1.0);\n       break;\n    }\n\n    vout = float(gl_VertexID % 4);\n   /* Always less than 4. */}\n";

const FRAGMENT_SHADER_BODY: &str = "\nin highp float vout;\n\nout highp vec4 result;\n\nvoid main()\n{\n    TTYPE a  = LEFT;\n    TTYPE b  = RIGHT;\n    BTYPE v1 = BDATA;\n    BTYPE v2 = BTYPE(PARAMS);\n    BTYPE c  = BTYPE(OPERATION);\n\n    TTYPE mixed = mix(a, b, c);\n\n    if(REFERENCE == mixed)\n    {\n        result = vec4(1.0);\n    }\n    else\n    {\n        result = vec4(0.0);\n    }\n}\n";

const SHADERS: [[&str; 8]; 28] = [
    ["highp int", "bool", "-1", "-2", "true", "-2", "v1 && v2", "vout < 4.0"],
    ["highp uint", "bool", "1u", "2u", "true", "2u", "v1 && v2", "vout < 4.0"],
    [
        "mediump int",
        "bool",
        "-1",
        "-2",
        "true",
        "-2",
        "v1 && v2",
        "vout < 4.0",
    ],
    [
        "mediump uint",
        "bool",
        "1u",
        "2u",
        "true",
        "2u",
        "v1 && v2",
        "vout < 4.0",
    ],
    ["lowp int", "bool", "-1", "-2", "true", "-2", "v1 && v2", "vout < 4.0"],
    ["lowp uint", "bool", "1u", "2u", "true", "2u", "v1 && v2", "vout < 4.0"],
    [
        "bool",
        "bool",
        "false",
        "true",
        "true",
        "true",
        "v1 && v2",
        "vout < 4.0",
    ],
    [
        "highp ivec2",
        "bvec2",
        "ivec2(-1, -2)",
        "ivec2(-3, -4)",
        "bvec2(true, false)",
        "ivec2(-3, -2)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "highp uvec2",
        "bvec2",
        "uvec2(1, 2)",
        "uvec2(3, 4)",
        "bvec2(true, false)",
        "uvec2(3, 2)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "mediump ivec2",
        "bvec2",
        "ivec2(-1, -2)",
        "ivec2(-3, -4)",
        "bvec2(true, false)",
        "ivec2(-3, -2)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "mediump uvec2",
        "bvec2",
        "uvec2(1, 2)",
        "uvec2(3, 4)",
        "bvec2(true, false)",
        "uvec2(3, 2)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "lowp ivec2",
        "bvec2",
        "ivec2(-1, -2)",
        "ivec2(-3, -4)",
        "bvec2(true, false)",
        "ivec2(-3, -2)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "lowp uvec2",
        "bvec2",
        "uvec2(1, 2)",
        "uvec2(3, 4)",
        "bvec2(true, false)",
        "uvec2(3, 2)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "bvec2",
        "bvec2",
        "bvec2(true,  true)",
        "bvec2(false, false)",
        "bvec2(true,  false)",
        "bvec2(false, true)",
        "v1.x && v2.x, v1.y && v2.y",
        "vout < 4.0, true",
    ],
    [
        "highp ivec3",
        "bvec3",
        "ivec3(-1, -2, -3)",
        "ivec3(-4, -5, -6)",
        "bvec3(true, false, true)",
        "ivec3(-4, -2, -6)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "highp uvec3",
        "bvec3",
        "uvec3(1, 2, 3)",
        "uvec3(4, 5, 6)",
        "bvec3(true, false, true)",
        "uvec3(4, 2, 6)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "mediump ivec3",
        "bvec3",
        "ivec3(-1, -2, -3)",
        "ivec3(-4, -5, -6)",
        "bvec3(true, false, true)",
        "ivec3(-4, -2, -6)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "mediump uvec3",
        "bvec3",
        "uvec3(1, 2, 3)",
        "uvec3(4, 5, 6)",
        "bvec3(true, false, true)",
        "uvec3(4, 2, 6)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "lowp ivec3",
        "bvec3",
        "ivec3(-1, -2, -3)",
        "ivec3(-4, -5, -6)",
        "bvec3(true, false, true)",
        "ivec3(-4, -2, -6)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "lowp uvec3",
        "bvec3",
        "uvec3(1, 2, 3)",
        "uvec3(4, 5, 6)",
        "bvec3(true, false, true)",
        "uvec3(4, 2, 6)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "bvec3",
        "bvec3",
        "bvec3(true,  true, true)",
        "bvec3(false, false, false)",
        "bvec3(true,  false, true)",
        "bvec3(false, true, false)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z",
        "vout < 4.0, true, true",
    ],
    [
        "highp ivec4",
        "bvec4",
        "ivec4(-1, -2, -3, -4)",
        "ivec4(-5, -6, -7, -8)",
        "bvec4(true, false, true, false)",
        "ivec4(-5, -2, -7, -4)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
    [
        "highp uvec4",
        "bvec4",
        "uvec4(1, 2, 3, 4)",
        "uvec4(5, 6, 7, 8)",
        "bvec4(true, false, true, false)",
        "uvec4(5, 2, 7, 4)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
    [
        "mediump ivec4",
        "bvec4",
        "ivec4(-1, -2, -3, -4)",
        "ivec4(-5, -6, -7, -8)",
        "bvec4(true, false, true, false)",
        "ivec4(-5, -2, -7, -4)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
    [
        "mediump uvec4",
        "bvec4",
        "uvec4(1, 2, 3, 4)",
        "uvec4(5, 6, 7, 8)",
        "bvec4(true, false, true, false)",
        "uvec4(5, 2, 7, 4)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
    [
        "lowp ivec4",
        "bvec4",
        "ivec4(-1, -2, -3, -4)",
        "ivec4(-5, -6, -7, -8)",
        "bvec4(true, false, true, false)",
        "ivec4(-5, -2, -7, -4)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
    [
        "lowp uvec4",
        "bvec4",
        "uvec4(1, 2, 3, 4)",
        "uvec4(5, 6, 7, 8)",
        "bvec4(true, false, true, false)",
        "uvec4(5, 2, 7, 4)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
    [
        "bvec4",
        "bvec4",
        "bvec4(true,  true,  true,  true)",
        "bvec4(false, false, false, false)",
        "bvec4(true,  false, true,  false)",
        "bvec4(false, true,  false, true)",
        "v1.x && v2.x, v1.y && v2.y, v1.z && v2.z, v1.w && v2.w",
        "vout < 4.0, true, true, true",
    ],
];

/// `createProgram`: `None` when building failed (already logged)
fn create_program<'gl>(gl: &'gl glw::Functions, row: &[&str; 8]) -> Res<Option<ShaderProgram<'gl>>> {
    let [ttype, btype, left, right, bdata, reference, operation, params] = *row;
    let defines = format!(
        "#define TTYPE {ttype}\n#define BTYPE {btype}\n#define LEFT {left}\n#define RIGHT {right}\n#define BDATA {bdata}\n#define REFERENCE {reference}\n#define OPERATION {operation}\n#define PARAMS {params}\n"
    );
    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, format!("{SHADER_VERSION}{VERTEX_SHADER_BODY}"))
        .with(
            ShaderType::Fragment,
            format!("{SHADER_VERSION}{defines}{FRAGMENT_SHADER_BODY}"),
        );
    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        log::info!(
            "Compilation or linkage of shader program has failed.\n{}",
            program.build_failure_summary().unwrap_or_default()
        );
        return Ok(None);
    }

    gl_call!(gl, "glUseProgram call failed.", gl.use_program(program.program()));
    Ok(Some(program))
}

/// `ShaderFunctionalCompatibilityTest::test`
fn functional_test(gl: &glw::Functions) -> Res<bool> {
    // Drawing quad which shall output result.
    gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl_call!(
        gl,
        "glDrawArrays() call failed.",
        gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4)
    );

    // Fetching result.
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
    Ok(f64::from((1.0 - red).abs()) <= 0.125) // Precision.
}

/// `ShaderFunctionalCompatibilityTest::iterate`'s body: the framebuffer and vertex array, then every shader
fn run_functional(context: &Context) -> Res<bool> {
    let gl = context.gl();
    let mut is_ok = true;

    // createFramebufferAndVertexArrayObject
    gl_call!(gl, "glClearColor call failed.", gl.clear_color(0.0, 0.0, 0.0, 0.0));
    let fbo = glu::Framebuffer::new(gl);
    glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
    let rbo = glu::Renderbuffer::new(gl);
    glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
    gl_call!(
        gl,
        "glBindFramebuffer call failed.",
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get())
    );
    gl_call!(
        gl,
        "glBindRenderbuffer call failed.",
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get())
    );
    gl_call!(
        gl,
        "glRenderbufferStorage call failed.",
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R8, 1, 1)
    );
    gl_call!(
        gl,
        "glFramebufferRenderbuffer call failed.",
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo.get()
        )
    );

    // Check if all went ok.
    // SAFETY: a current context.
    if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
        return Err(TestError::Fail("The framebuffer is incomplete".to_string()));
    }

    // View Setup.
    gl_call!(gl, "glViewport call failed.", gl.viewport(0, 0, 1, 1));

    // Create and bind empty vertex array object.
    let vao = glu::VertexArray::new(gl);
    glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
    if vao.get() == 0 {
        return Err(TestError::Fail("glGenVertexArrays returned 0".to_string()));
    }
    gl_call!(gl, "glBindVertexArray() call failed.", gl.bind_vertex_array(vao.get()));

    for row in &SHADERS {
        let Some(program) = create_program(gl, row)? else {
            is_ok = false;
            continue; // if createProgram failed we shall omit this iteration
        };
        is_ok &= functional_test(gl)?;

        // cleanProgram
        // SAFETY: a current context.
        unsafe { gl.use_program(0) };
        drop(program);
    }

    Ok(is_ok)
}

/// `ShaderFunctionalCompatibilityTest::iterate`
fn shader_functional(context: &Context) -> TestOutcome {
    let mut is_ok = true;
    let mut is_error = false;

    if es31_compatibility_available(context) {
        match run_functional(context) {
            Ok(ok) => is_ok = ok,
            Err(error) => {
                log::info!("{error}");
                is_ok = false;
                is_error = true;
            }
        }
    }

    Ok(status(is_ok, is_error))
}

struct Es31CompatibilityCase {
    name: &'static str,
    test: fn(&Context) -> TestOutcome,
}

impl TestCase for Es31CompatibilityCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        (self.test)(context)
    }
}

/// `es31compatibility::Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("es_31_compatibility");

    // New tests.
    let mut new_cases_group = TestCaseGroup::new("new_cases");
    new_cases_group.add_child(Box::new(Es31CompatibilityCase {
        name: "shader_compilation",
        test: shader_compilation,
    }) as Box<dyn TestCase>);
    new_cases_group.add_child(Box::new(Es31CompatibilityCase {
        name: "shader_functional",
        test: shader_functional,
    }) as Box<dyn TestCase>);
    group.add_child(new_cases_group);

    // Ported tests.
    group.add_child(sample_variables_tests::create_tests(GlslVersion::Es310));
    group.add_child(super::es31_image_load_store::create_tests());
    group.add_child(super::es31_ssbo::create_tests());

    group
}
