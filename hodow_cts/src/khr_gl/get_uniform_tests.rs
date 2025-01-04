// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cGetUniform.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs `init` builds are built at the top of `iterate` (the case tree is made before a context exists). `verify_get_uniform_ops` is a template over the component type upstream and is two functions here, one for floats and one for ints. The shader strings keep the raw-string indentation of upstream.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

const VEC_VERT_SHADER: &str = "${VERSION}\n    in vec4 vertex;\n    uniform mat4 ModelViewProjectionMatrix;\n    uniform float vuni1;\n    uniform vec2 vuni2;\n    uniform vec3 vuni3;\n    uniform vec4 vuni4;\n    out vec4 color;\n\n    void main (void)\n    {\n        color = vec4(vuni1, vuni2[0] + vuni2[1], vuni3[0] + vuni3[1] + vuni3[2], vuni4[0] + vuni4[1] + vuni4[2] + vuni4[3]);\n        gl_Position = ModelViewProjectionMatrix * vertex;\n    }\n    ";

const VEC_FRAG_SHADER: &str = "${VERSION}\n    uniform float funi1;\n    uniform vec2 funi2;\n    uniform vec3 funi3;\n    uniform vec4 funi4;\n    in vec4 color;\n    out vec4 fragColor;\n\n    void main (void)\n    {\n        vec4 temp = vec4(funi1, funi2[0] + funi2[1], funi3[0] + funi3[1] + funi3[2], funi4[0] + funi4[1] + funi4[2] + funi4[3]);\n        fragColor = temp + color;\n    }\n    ";

const IVEC_VERT_SHADER: &str = "${VERSION}\n    in vec4 vertex;\n    uniform mat4 ModelViewProjectionMatrix;\n    uniform int vuni1;\n    uniform ivec2 vuni2;\n    uniform ivec3 vuni3;\n    uniform ivec4 vuni4;\n    out vec4 color;\n\n    void main (void)\n    {\n        color = vec4(float(vuni1), float(vuni2[0] + vuni2[1]), float(vuni3[0] + vuni3[1] + vuni3[2]), float(vuni4[0] + vuni4[1] + vuni4[2] + vuni4[3]) );\n        gl_Position = ModelViewProjectionMatrix * vertex;\n    }\n    ";

const IVEC_FRAG_SHADER: &str = "${VERSION}\n    uniform int funi1;\n    uniform ivec2 funi2;\n    uniform ivec3 funi3;\n    uniform ivec4 funi4;\n    in vec4 color;\n    out vec4 fragColor;\n\n    void main (void)\n    {\n        vec4 temp = vec4(float(funi1), float(funi2[0] + funi2[1]), float(funi3[0] + funi3[1] + funi3[2]), float(funi4[0] + funi4[1] + funi4[2] + funi4[3]));\n        fragColor = temp + color;\n    }\n    ";

const BVEC_VERT_SHADER: &str = "${VERSION}\n    in vec4 vertex;\n    uniform mat4 ModelViewProjectionMatrix;\n    uniform bool vuni1;\n    uniform bvec2 vuni2;\n    uniform bvec3 vuni3;\n    uniform bvec4 vuni4;\n    out vec4 color;\n\n    void main (void)\n    {\n        color = vec4(0.0, 0.0, 0.0, 0.0);\n        if(vuni1 || vuni2[0] && vuni2[1] && vuni3[0] && vuni3[1] && vuni3[2] || vuni4[0] && vuni4[1] && vuni4[2] && vuni4[3])\n        color = vec4(1.0, 0.0, 0.5, 1.0);\n        gl_Position = ModelViewProjectionMatrix * vertex;\n    }\n    ";

const BVEC_FRAG_SHADER: &str = "${VERSION}\n    uniform bool funi1;\n    uniform bvec2 funi2;\n    uniform bvec3 funi3;\n    uniform bvec4 funi4;\n    in vec4 color;\n    out vec4 fragColor;\n\n    void main (void)\n    {\n        vec4 temp = vec4(0.0, 0.0, 0.0, 0.0);\n        if(funi1 || funi2[0] && funi2[1] && funi3[0] && funi3[1] && funi3[2] || funi4[0] && funi4[1] && funi4[2] && funi4[3])\n                temp = vec4(1.0, 0.0, 0.5, 1.0);\n        fragColor = temp + color;\n    }\n    ";

const MAT_VERT_SHADER: &str = "${VERSION}\n    in vec4 vertex;\n    uniform mat4 ModelViewProjectionMatrix;\n    uniform mat2 vuni2;\n    uniform mat3 vuni3;\n    uniform mat4 vuni4;\n    out vec4 color;\n\n    void main (void)\n    {\n        color = vec4( vuni2[0][0] + vuni2[0][1] + vuni2[1][0] + vuni2[1][1],\n                      vuni3[0][0] + vuni3[0][1] + vuni3[0][2] + vuni3[1][0] + vuni3[1][1] + vuni3[1][2] + vuni3[2][0] + vuni3[2][1] + vuni3[2][2],\n                      vuni4[0][0] + vuni4[0][1] + vuni4[0][2] + vuni4[0][3] + vuni4[1][0] + vuni4[1][1] + vuni4[1][2] + vuni4[1][3] + vuni4[2][0] + vuni4[2][1] + vuni4[2][2] + vuni4[2][3] + vuni4[3][0] + vuni4[3][1] + vuni4[3][2] + vuni4[3][3], 1.0 );\n\n        gl_Position = ModelViewProjectionMatrix * vertex;\n    }\n    ";

const MAT_FRAG_SHADER: &str = "${VERSION}\n    uniform mat2 funi2;\n    uniform mat3 funi3;\n    uniform mat4 funi4;\n    in vec4 color;\n    out vec4 fragColor;\n\n    void main (void)\n    {\n        vec4 temp = vec4( funi2[0][0] + funi2[0][1] + funi2[1][0] + funi2[1][1],\n                      funi3[0][0] + funi3[0][1] + funi3[0][2] + funi3[1][0] + funi3[1][1] + funi3[1][2] + funi3[2][0] + funi3[2][1] + funi3[2][2],\n                      funi4[0][0] + funi4[0][1] + funi4[0][2] + funi4[0][3] + funi4[1][0] + funi4[1][1] + funi4[1][2] + funi4[1][3] + funi4[2][0] + funi4[2][1] + funi4[2][2] + funi4[2][3] + funi4[3][0] + funi4[3][1] + funi4[3][2] + funi4[3][3], 1.0 );\n        fragColor = temp + color;\n    }\n    ";

/// `test_buffer`
fn test_buffer<T: Copy + Into<f64> + std::fmt::Display>(
    result_buf: &[T],
    expected_buf: &[T],
    size: usize,
    tolerance: f32,
) -> bool {
    for i in 0..size {
        if (result_buf[i].into() - expected_buf[i].into()).abs() > f64::from(tolerance) {
            log::info!("TestBufferf: Found : {}, Expected : {}", result_buf[i], expected_buf[i]);
            return false;
        }
    }
    true
}

fn uniform_location(gl: &glw::Functions, program: glw::GLuint, name: &std::ffi::CStr) -> Result<glw::GLint, TestError> {
    // SAFETY: a NUL-terminated name; an unknown program is an error the check below reports.
    let loc = unsafe { gl.get_uniform_location(program, name.as_ptr()) };
    glu::expect_no_error(gl, "getUniformLocation")?;
    Ok(loc)
}

/// `verify_get_uniform_ops<GLfloat>`
fn verify_get_uniform_ops_f(
    gl: &glw::Functions,
    active_program_id: glw::GLuint,
    name: &std::ffi::CStr,
    error_message: &str,
    data: &[f32],
    buf: &mut [f32; 16],
    size: usize,
    tolerance: f32,
) -> Result<bool, TestError> {
    let loc = uniform_location(gl, active_program_id, name)?;
    if loc != -1 {
        // SAFETY: `data` holds `size` floats and `buf` is larger than any uniform this test reads back.
        unsafe {
            match size {
                2 => {
                    gl.uniform_2f(loc, data[0], data[1]);
                    glu::expect_no_error(gl, "uniform2f")?;
                }
                3 => {
                    gl.uniform_3f(loc, data[0], data[1], data[2]);
                    glu::expect_no_error(gl, "uniform3f")?;
                }
                4 => {
                    gl.uniform_4f(loc, data[0], data[1], data[2], data[3]);
                    glu::expect_no_error(gl, "uniform4f")?;
                }
                _ => {
                    gl.uniform_1f(loc, data[0]);
                    glu::expect_no_error(gl, "uniform1f")?;
                }
            }
            gl.get_uniformfv(active_program_id, loc, buf.as_mut_ptr());
            glu::expect_no_error(gl, "getUniformfv")?;
        }
        if !test_buffer(&buf[..], data, size, tolerance) {
            log::info!("GetUniformTestCase::iterate: {error_message}\n");
            return Ok(false);
        }
    }
    Ok(true)
}

/// `verify_get_uniform_ops<GLint>`
fn verify_get_uniform_ops_i(
    gl: &glw::Functions,
    active_program_id: glw::GLuint,
    name: &std::ffi::CStr,
    error_message: &str,
    data: &[i32],
    buf: &mut [i32; 4],
    size: usize,
    tolerance: f32,
) -> Result<bool, TestError> {
    let loc = uniform_location(gl, active_program_id, name)?;
    if loc != -1 {
        // SAFETY: `data` holds `size` ints and `buf` is larger than any uniform this test reads back.
        unsafe {
            match size {
                2 => {
                    gl.uniform_2i(loc, data[0], data[1]);
                    glu::expect_no_error(gl, "uniform2i")?;
                }
                3 => {
                    gl.uniform_3i(loc, data[0], data[1], data[2]);
                    glu::expect_no_error(gl, "uniform3i")?;
                }
                4 => {
                    gl.uniform_4i(loc, data[0], data[1], data[2], data[3]);
                    glu::expect_no_error(gl, "uniform4i")?;
                }
                _ => {
                    gl.uniform_1i(loc, data[0]);
                    glu::expect_no_error(gl, "uniform1f")?;
                }
            }
            gl.get_uniformiv(active_program_id, loc, buf.as_mut_ptr());
            glu::expect_no_error(gl, "getUniformiv")?;
        }
        if !test_buffer(&buf[..], data, size, tolerance) {
            log::info!("GetUniformTestCase::iterate: {error_message}\n");
            return Ok(false);
        }
    }
    Ok(true)
}

/// `GetUniformTestCase`
struct GetUniformTestCase;

fn make_program<'gl>(
    gl: &'gl glw::Functions,
    specialization_map: &[(&str, String)],
    vs: &str,
    fs: &str,
) -> Result<ShaderProgram<'gl>, TestError> {
    let vert_shader = StringTemplate::new(vs).specialize(specialization_map)?;
    let frag_shader = StringTemplate::new(fs).specialize(specialization_map)?;
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vert_shader, frag_shader));
    if !program.is_ok() {
        return Err(TestError::Fail("Invalid program".to_string()));
    }
    Ok(program)
}

type MatrixUpload = unsafe fn(&glw::Functions, glw::GLint, glw::GLsizei, glw::GLboolean, *const f32);

/// One of `iterate`'s matrix checks: upload through `upload`, read back, compare.
fn verify_matrix(
    gl: &glw::Functions,
    active_program_id: glw::GLuint,
    name: &std::ffi::CStr,
    data: &[f32],
    float_buf: &mut [f32; 16],
    size: usize,
    upload: MatrixUpload,
    what: &str,
) -> Result<bool, TestError> {
    let loc = uniform_location(gl, active_program_id, name)?;
    if loc != -1 {
        // SAFETY: `data` holds a whole matrix and `float_buf` is large enough for the biggest one.
        unsafe {
            upload(gl, loc, 1, glw::FALSE, data.as_ptr());
            glu::expect_no_error(gl, &format!("uniformMatrix{what}fv"))?;
            gl.get_uniformfv(active_program_id, loc, float_buf.as_mut_ptr());
            glu::expect_no_error(gl, "getUniformfv")?;
        }
        if !test_buffer(&float_buf[..], data, size, 0.0008) {
            log::info!("GetUniformTestCase::iterate: Error while retrieving data from mat{what} uniform\n");
            return Ok(false);
        }
    }
    Ok(true)
}

impl TestCase for GetUniformTestCase {
    fn name(&self) -> &str {
        "get_uniform"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let version = context.context_type().glsl_version().declaration();
        let specialization_map = [("VERSION", version.to_string())];

        // init
        let programs = [
            make_program(gl, &specialization_map, VEC_VERT_SHADER, VEC_FRAG_SHADER)?,
            make_program(gl, &specialization_map, IVEC_VERT_SHADER, IVEC_FRAG_SHADER)?,
            make_program(gl, &specialization_map, BVEC_VERT_SHADER, BVEC_FRAG_SHADER)?,
            make_program(gl, &specialization_map, MAT_VERT_SHADER, MAT_FRAG_SHADER)?,
        ];

        let mut result = true;

        let mat_projection: [f32; 16] = [
            1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
        ];
        let data_boolf = [1.0f32];
        let data_booli = [1i32];
        let data_float = [-0.3f32];
        let data_int = [-1i32];
        let data_bvec2f = [0.0f32, 1.0];
        let data_bvec3f = [1.0f32, 0.0, 0.0];
        let data_bvec4f = [1.0f32, 1.0, 0.0, 1.0];
        let data_bvec2i = [0i32, 1];
        let data_bvec3i = [1i32, 0, 0];
        let data_bvec4i = [1i32, 1, 0, 1];
        let data_vec2i = [1i32, 0];
        let data_vec3i = [1i32, 0, 9];
        let data_vec4i = [8i32, 12, 6, 3];
        let data_vec2f = [0.1f32, 0.1];
        let data_vec3f = [1.0f32, 0.0, 0.9];
        let data_vec4f = [0.8f32, 12.0, 6.7, 3.8];
        let data_mat2 = [1.0f32, 2.3, 4.2, 7.8];
        let data_mat3 = [1.0f32, 2.3, 5.67, 4.2, 7.8, 8.33, 0.2, 1.23, 4.57];
        let data_mat4 = [
            1.0f32, 2.3, 5.67, 6.87, 4.2, 7.8, 8.33, 9.21, 0.2, 1.23, 4.57, 8.68, 11.93, 19.1, 22.2, 23.1,
        ];

        let mut float_buf = [0.0f32; 16];
        let mut int_buf = [0i32; 4];

        // SAFETY: plain state setters.
        unsafe {
            gl.disable(glw::GL_DITHER);
            glu::expect_no_error(gl, "disable(GL_DITHER)")?;

            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            glu::expect_no_error(gl, "clearColor")?;
        }

        // Test 4 : Program not linked successfully
        // SAFETY: a program that was just created and never linked; the buffers hold one value.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_uniformfv(program, 1, float_buf.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                result = false;
                log::info!(
                    "GetUniformTestCase::iterate: glGetUniformfv : GL_INVALID_OPERATION not returned when program handle not linked.\n"
                );
            }

            gl.get_uniformiv(program, 1, int_buf.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                result = false;
                log::info!(
                    "GetUniformTestCase::iterate: glGetUniformiv : GL_INVALID_OPERATION not returned when program handle not linked.\n"
                );
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;

            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        for (s, program) in programs.iter().enumerate() {
            let active_program_id = program.program();

            // SAFETY: a program that built.
            unsafe {
                gl.use_program(active_program_id);
                glu::expect_no_error(gl, "useProgram")?;
            }

            let loc_mat_projection = uniform_location(gl, active_program_id, c"ModelViewProjectionMatrix")?;
            if loc_mat_projection != -1 {
                // SAFETY: sixteen floats for a mat4.
                unsafe {
                    gl.uniform_matrix_4fv(loc_mat_projection, 1, 0, mat_projection.as_ptr());
                    glu::expect_no_error(gl, "uniformMatrix4fv")?;
                }
            }

            // SAFETY: a linked program and a NUL-terminated name.
            let loc_vertices = unsafe { gl.get_attrib_location(active_program_id, c"vertex".as_ptr()) };
            glu::expect_no_error(gl, "getAttribLocation")?;
            if loc_vertices != -1 {
                // SAFETY: an attribute location the program reported.
                unsafe { gl.enable_vertex_attrib_array(loc_vertices as u32) };
                glu::expect_no_error(gl, "enableVertexAttribArray")?;
            }

            // Render Code
            // vec_tests.vert
            if s == 0 {
                let mut check_get_uniform_error = |msg: &str, expected: glw::GLenum| {
                    // SAFETY: glGetError needs nothing but a current context.
                    if unsafe { gl.get_error() } != expected {
                        result = false;
                        log::info!("GetUniformTestCase::iterate: {msg}");
                    }
                };

                let fragment_shader = program
                    .shader(ShaderType::Fragment)
                    .ok_or_else(|| TestError::Fail("no fragment shader".to_string()))?;
                let vertex_shader = program
                    .shader(ShaderType::Vertex)
                    .ok_or_else(|| TestError::Fail("no vertex shader".to_string()))?;

                // SAFETY: the buffers hold one value; the calls are meant to raise errors and write nothing.
                unsafe {
                    // Test 1 : Fragment shader for program handle
                    gl.get_uniformfv(fragment_shader, 1, float_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformfv : GL_INVALID_OPERATION not returned when passing fragment shader as handle.\n",
                        glw::GL_INVALID_OPERATION,
                    );

                    gl.get_uniformiv(fragment_shader, 1, int_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformiv : GL_INVALID_OPERATION not returned when passing fragment shader as handle.\n",
                        glw::GL_INVALID_OPERATION,
                    );

                    // Test 1B : Vertex shader for program handle
                    gl.get_uniformfv(vertex_shader, 1, float_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformfv : GL_INVALID_OPERATION not returned when passing vertex shader as handle.\n",
                        glw::GL_INVALID_OPERATION,
                    );

                    gl.get_uniformiv(vertex_shader, 1, int_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformiv : GL_INVALID_OPERATION not returned when passing vertex shader as handle.\n",
                        glw::GL_INVALID_OPERATION,
                    );

                    // Test 2 : Invalid location passed
                    gl.get_uniformfv(active_program_id, -1, float_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformfv : GL_INVALID_OPERATION not returned when passing invalid location.\n",
                        glw::GL_INVALID_OPERATION,
                    );

                    gl.get_uniformiv(active_program_id, -1, int_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformiv : GL_INVALID_OPERATION not returned when passing invalid location.\n",
                        glw::GL_INVALID_OPERATION,
                    );

                    // Test 3 : Invalid program handle
                    gl.get_uniformfv(0, 1, float_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformfv : GL_INVALID_VALUE not returned when passing invalid(0) program object.\n",
                        glw::GL_INVALID_VALUE,
                    );

                    gl.get_uniformiv(0, 1, int_buf.as_mut_ptr());
                    check_get_uniform_error(
                        "glGetUniformiv : GL_INVALID_VALUE not returned when passing invalid(0) program object.\n",
                        glw::GL_INVALID_VALUE,
                    );
                }
            }

            // Other tests
            let float_checks: Vec<(&std::ffi::CStr, &str, &[f32], usize)> = match s {
                0 => vec![
                    (
                        c"funi1",
                        "Error while retrieving data from bool uniform.",
                        &data_boolf,
                        1,
                    ),
                    (
                        c"vuni1",
                        "Error while retrieving data from bool uniform.",
                        &data_boolf,
                        1,
                    ),
                    (
                        c"funi1",
                        "Error while retrieving data from float uniform.",
                        &data_float,
                        1,
                    ),
                    (
                        c"vuni1",
                        "Error while retrieving data from float uniform.",
                        &data_float,
                        1,
                    ),
                    (
                        c"funi2",
                        "Error while retrieving data from vec2 uniform.",
                        &data_vec2f,
                        2,
                    ),
                    (
                        c"vuni2",
                        "Error while retrieving data from vec2 uniform.",
                        &data_vec2f,
                        2,
                    ),
                    (
                        c"funi3",
                        "Error while retrieving data from vec3 uniform.",
                        &data_vec3f,
                        3,
                    ),
                    (
                        c"vuni3",
                        "Error while retrieving data from vec3 uniform.",
                        &data_vec3f,
                        3,
                    ),
                    (
                        c"funi4",
                        "Error while retrieving data from vec4 uniform.",
                        &data_vec4f,
                        4,
                    ),
                    (
                        c"vuni4",
                        "Error while retrieving data from vec4 uniform.",
                        &data_vec4f,
                        4,
                    ),
                ],
                _ => Vec::new(),
            };
            for &(name, message, data, size) in &float_checks {
                result &=
                    verify_get_uniform_ops_f(gl, active_program_id, name, message, data, &mut float_buf, size, 0.0008)?;
            }

            if s == 1 {
                let int_checks: [(&std::ffi::CStr, &str, &[i32], usize); 10] = [
                    (
                        c"funi1",
                        "Error while retrieving data from bool uniform.",
                        &data_booli,
                        1,
                    ),
                    (
                        c"vuni1",
                        "Error while retrieving data from bool uniform.",
                        &data_booli,
                        1,
                    ),
                    (c"funi1", "Error while retrieving data from int uniform.", &data_int, 1),
                    (c"vuni1", "Error while retrieving data from int uniform.", &data_int, 1),
                    (
                        c"funi2",
                        "Error while retrieving data from vec2 uniform.",
                        &data_vec2i,
                        2,
                    ),
                    (
                        c"vuni2",
                        "Error while retrieving data from vec2 uniform.",
                        &data_vec2i,
                        2,
                    ),
                    (
                        c"funi3",
                        "Error while retrieving data from vec3 uniform.",
                        &data_vec3i,
                        3,
                    ),
                    (
                        c"vuni3",
                        "Error while retrieving data from vec3 uniform.",
                        &data_vec3i,
                        3,
                    ),
                    (
                        c"funi4",
                        "Error while retrieving data from vec4 uniform.",
                        &data_vec4i,
                        4,
                    ),
                    (
                        c"vuni4",
                        "Error while retrieving data from vec4 uniform.",
                        &data_vec4i,
                        4,
                    ),
                ];
                for (name, message, data, size) in int_checks {
                    result &=
                        verify_get_uniform_ops_i(gl, active_program_id, name, message, data, &mut int_buf, size, 0.0)?;
                }
            } else if s == 2 {
                let float_checks: [(&std::ffi::CStr, &str, &[f32], usize); 6] = [
                    (
                        c"funi2",
                        "Error while retrieving data from bvec2 uniform.",
                        &data_bvec2f,
                        2,
                    ),
                    (
                        c"vuni2",
                        "Error while retrieving data from bvec2 uniform.",
                        &data_bvec2f,
                        2,
                    ),
                    (
                        c"funi3",
                        "Error while retrieving data from bvec3 uniform.",
                        &data_bvec3f,
                        3,
                    ),
                    (
                        c"vuni3",
                        "Error while retrieving data from bvec3 uniform.",
                        &data_bvec3f,
                        3,
                    ),
                    (
                        c"funi4",
                        "Error while retrieving data from bvec4 uniform.",
                        &data_bvec4f,
                        4,
                    ),
                    (
                        c"vuni4",
                        "Error while retrieving data from bvec4 uniform.",
                        &data_bvec4f,
                        4,
                    ),
                ];
                for (name, message, data, size) in float_checks {
                    result &= verify_get_uniform_ops_f(
                        gl,
                        active_program_id,
                        name,
                        message,
                        data,
                        &mut float_buf,
                        size,
                        0.0008,
                    )?;
                }
                let int_checks: [(&std::ffi::CStr, &str, &[i32], usize); 6] = [
                    (
                        c"funi2",
                        "Error while retrieving data from bvec2 uniform.",
                        &data_bvec2i,
                        2,
                    ),
                    (
                        c"vuni2",
                        "Error while retrieving data from bvec2 uniform.",
                        &data_bvec2i,
                        2,
                    ),
                    (
                        c"funi3",
                        "Error while retrieving data from bvec3 uniform.",
                        &data_bvec3i,
                        3,
                    ),
                    (
                        c"vuni3",
                        "Error while retrieving data from bvec3 uniform.",
                        &data_bvec3i,
                        3,
                    ),
                    (
                        c"funi4",
                        "Error while retrieving data from bvec4 uniform.",
                        &data_bvec4i,
                        4,
                    ),
                    (
                        c"vuni4",
                        "Error while retrieving data from bvec4 uniform.",
                        &data_bvec4i,
                        4,
                    ),
                ];
                for (name, message, data, size) in int_checks {
                    result &=
                        verify_get_uniform_ops_i(gl, active_program_id, name, message, data, &mut int_buf, size, 0.0)?;
                }
            } else if s == 3 {
                // mat2 / mat3 / mat4, fragment then vertex stage
                let matrix_checks: [(&std::ffi::CStr, &[f32], usize, MatrixUpload, &str); 6] = [
                    (c"funi2", &data_mat2[..], 4, glw::Functions::uniform_matrix_2fv, "2"),
                    (c"vuni2", &data_mat2[..], 4, glw::Functions::uniform_matrix_2fv, "2"),
                    (c"funi3", &data_mat3[..], 9, glw::Functions::uniform_matrix_3fv, "3"),
                    (c"vuni3", &data_mat3[..], 9, glw::Functions::uniform_matrix_3fv, "3"),
                    (c"funi4", &data_mat4[..], 16, glw::Functions::uniform_matrix_4fv, "4"),
                    (c"vuni4", &data_mat4[..], 16, glw::Functions::uniform_matrix_4fv, "4"),
                ];
                for (name, data, size, upload, what) in matrix_checks {
                    if !verify_matrix(gl, active_program_id, name, data, &mut float_buf, size, upload, what)? {
                        result = false;
                    }
                }
            }
        }

        // SAFETY: plain state setter.
        unsafe { gl.clear_color(0.1, 0.2, 0.3, 1.0) };
        glu::expect_no_error(gl, "clearColor")?;

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `GetUniformTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("get_uniform_tests");
    group.add_child(Box::new(GetUniformTestCase) as Box<dyn TestCase>);
    group
}
