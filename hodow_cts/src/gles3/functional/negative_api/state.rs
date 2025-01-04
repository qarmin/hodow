// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fNegativeStateApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES3F_ADD_API_CASE` body is a
// function and the registration is a table of them; see the note in
// `gles2/functional/negative_api/buffer.rs`.
//
// Upstream's `isES` branches are resolved here: `ApiType` in this port is ES-only by
// construction (see `Api::gl_api_type`), so only the ES branch is written.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, ProgramSources, ShaderProgram, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLboolean, GLchar, GLint, GLint64, GLsizei, GLuint};

const UNIFORM_TEST_VERT_SOURCE: &str = concat!(
    "#version 300 es\n",
    "uniform mediump vec4 vUnif_vec4;\n",
    "in mediump vec4 attr;",
    "layout(shared) uniform Block { mediump vec4 blockVar; };\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = vUnif_vec4 + blockVar + attr;\n",
    "}\n",
);

const UNIFORM_TEST_FRAG_SOURCE: &str = concat!(
    "#version 300 es\n",
    "uniform mediump ivec4 fUnif_ivec4;\n",
    "uniform mediump uvec4 fUnif_uvec4;\n",
    "layout(location = 0) out mediump vec4 fragColor;",
    "void main (void)\n",
    "{\n",
    "    fragColor = vec4(vec4(fUnif_ivec4) + vec4(fUnif_uvec4));\n",
    "}\n",
);

/// The literal `-1` upstream passes where the parameter is a `GLuint` name.
const BAD_NAME: GLuint = u32::MAX;

// Enabling & disabling states

fn enable(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if cap is not one of the allowed values.");
    // SAFETY: a current context; the enum is invalid on purpose.
    unsafe { gl.enable(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn disable(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if cap is not one of the allowed values.");
    // SAFETY: as above.
    unsafe { gl.disable(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

// Simple state queries

fn get_booleanv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    let mut params: GLboolean = glw::FALSE;
    // SAFETY: one GLboolean of room; the rejected query writes nothing.
    unsafe { gl.get_booleanv(BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn get_floatv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    let mut params = 0.0f32;
    // SAFETY: as above.
    unsafe { gl.get_floatv(BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn get_integerv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    let mut params: GLint = -1;
    // SAFETY: as above.
    unsafe { gl.get_integerv(BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn get_integer64v(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    let mut params: GLint64 = -1;
    // SAFETY: as above.
    unsafe { gl.get_integer_64v(BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn get_integeri_v(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut data: GLint = -1;
    let mut max_uniform_buffer_bindings: GLint = 0;

    case.section("GL_INVALID_ENUM is generated if name is not an accepted value.");
    // SAFETY: one GLint of room; the rejected query writes nothing.
    unsafe { gl.get_integeri_v(BAD_ENUM, 0, &mut data) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.");
    // SAFETY: as above.
    unsafe { gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe {
        gl.get_integeri_v(
            glw::GL_UNIFORM_BUFFER_BINDING,
            max_uniform_buffer_bindings as GLuint,
            &mut data,
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_integer64i_v(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut data: GLint64 = -1;
    let mut max_uniform_buffer_bindings: GLint = 0;

    case.section("GL_INVALID_ENUM is generated if name is not an accepted value.");
    // SAFETY: one GLint64 of room; the rejected query writes nothing.
    unsafe { gl.get_integer_64i_v(BAD_ENUM, 0, &mut data) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.");
    // SAFETY: as above.
    unsafe { gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe {
        gl.get_integer_64i_v(
            glw::GL_UNIFORM_BUFFER_START,
            max_uniform_buffer_bindings as GLuint,
            &mut data,
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_string(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if name is not an accepted value.");
    // SAFETY: the returned pointer is ignored, as upstream ignores it; a rejected
    // query returns null.
    unsafe { gl.get_string(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn get_stringi(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut num_extensions: GLint = 0;

    case.section("GL_INVALID_ENUM is generated if name is not an accepted value.");
    // SAFETY: as in `get_string`.
    unsafe { gl.get_stringi(BAD_ENUM, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is outside the valid range for indexed state name.");
    // SAFETY: one GLint of room, then an index one past the last extension.
    unsafe {
        gl.get_integerv(glw::GL_NUM_EXTENSIONS, &mut num_extensions);
        gl.get_stringi(glw::GL_EXTENSIONS, num_extensions as GLuint);
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

// Enumerated state queries: Shaders

fn get_attached_shaders(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut shaders = [0u32; 1];
    let mut count = [0i32; 1];
    // SAFETY: a current context; both objects are deleted at the end.
    let (shader_object, program) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: room for one name and one count, which is what maxCount = 1 asks for.
    unsafe { gl.get_attached_shaders(BAD_NAME, 1, count.as_mut_ptr(), shaders.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_attached_shaders(shader_object, 1, count.as_mut_ptr(), shaders.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if maxCount is less than 0.");
    // SAFETY: as above.
    unsafe { gl.get_attached_shaders(program, -1, count.as_mut_ptr(), shaders.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(shader_object);
        gl.delete_program(program);
    }
}

fn get_shaderiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut shader_compiler_supported: GLboolean = glw::FALSE;
    // SAFETY: one GLboolean of room.
    unsafe { gl.get_booleanv(glw::GL_SHADER_COMPILER, &mut shader_compiler_supported) };
    log::info!(
        "// GL_SHADER_COMPILER = {}",
        if shader_compiler_supported != glw::FALSE {
            "GL_TRUE"
        } else {
            "GL_FALSE"
        }
    );

    // SAFETY: both objects are deleted at the end.
    let (shader, program) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };
    let mut param = [-1i32; 1];

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: one GLint of room; every query here is rejected and writes nothing.
    unsafe { gl.get_shaderiv(shader, BAD_ENUM, param.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
    // SAFETY: as above.
    unsafe { gl.get_shaderiv(BAD_NAME, glw::GL_SHADER_TYPE, param.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if shader does not refer to a shader object.");
    // SAFETY: as above.
    unsafe { gl.get_shaderiv(program, glw::GL_SHADER_TYPE, param.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(shader);
        gl.delete_program(program);
    }
}

fn get_shader_info_log(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are deleted at the end.
    let (shader, program) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };
    let mut length = [0i32; 1];
    let mut info_log = [0 as GLchar; 128];

    case.section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
    // SAFETY: the destination holds the 128 bytes maxLength names.
    unsafe { gl.get_shader_info_log(BAD_NAME, 128, length.as_mut_ptr(), info_log.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
    // SAFETY: as above.
    unsafe { gl.get_shader_info_log(program, 128, length.as_mut_ptr(), info_log.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if maxLength is less than 0.");
    // SAFETY: as above.
    unsafe { gl.get_shader_info_log(shader, -1, length.as_mut_ptr(), info_log.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(shader);
        gl.delete_program(program);
    }
}

fn get_shader_precision_format(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut shader_compiler_supported: GLboolean = glw::FALSE;
    // SAFETY: one GLboolean of room.
    unsafe { gl.get_booleanv(glw::GL_SHADER_COMPILER, &mut shader_compiler_supported) };
    log::info!(
        "// GL_SHADER_COMPILER = {}",
        if shader_compiler_supported != glw::FALSE {
            "GL_TRUE"
        } else {
            "GL_FALSE"
        }
    );

    // Upstream fills both with 0xcd first, so a query that writes nothing is visible.
    let mut range = [0xcdcdcdcdu32 as i32; 2];
    let mut precision = [0xcdcdcdcdu32 as i32; 1];

    case.section("GL_INVALID_ENUM is generated if shaderType or precisionType is not an accepted value.");
    // SAFETY: two GLint of range and one of precision, which is what the call writes.
    unsafe {
        gl.get_shader_precision_format(
            BAD_ENUM,
            glw::GL_MEDIUM_FLOAT,
            range.as_mut_ptr(),
            precision.as_mut_ptr(),
        );
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_shader_precision_format(
            glw::GL_VERTEX_SHADER,
            BAD_ENUM,
            range.as_mut_ptr(),
            precision.as_mut_ptr(),
        );
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_shader_precision_format(BAD_ENUM, BAD_ENUM, range.as_mut_ptr(), precision.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn get_shader_source(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut length = [0i32; 1];
    let mut source = [0 as GLchar; 1];
    // SAFETY: both objects are deleted at the end.
    let (program, shader) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };

    case.section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
    // SAFETY: one byte of destination for a bufSize of 1.
    unsafe { gl.get_shader_source(BAD_NAME, 1, length.as_mut_ptr(), source.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
    // SAFETY: as above.
    unsafe { gl.get_shader_source(program, 1, length.as_mut_ptr(), source.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if bufSize is less than 0.");
    // SAFETY: as above.
    unsafe { gl.get_shader_source(shader, -1, length.as_mut_ptr(), source.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

// Enumerated state queries: Programs

fn get_programiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are deleted at the end.
    let (program, shader) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };
    let mut params = [-1i32; 1];

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: one GLint of room; every query here is rejected and writes nothing.
    unsafe { gl.get_programiv(program, BAD_ENUM, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: as above.
    unsafe { gl.get_programiv(BAD_NAME, glw::GL_LINK_STATUS, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program does not refer to a program object.");
    // SAFETY: as above.
    unsafe { gl.get_programiv(shader, glw::GL_LINK_STATUS, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

fn get_program_info_log(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are deleted at the end.
    let (program, shader) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };
    let mut length = [0i32; 1];
    let mut info_log = [0 as GLchar; 1];

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: one byte of destination for a maxLength of 1.
    unsafe { gl.get_program_info_log(BAD_NAME, 1, length.as_mut_ptr(), info_log.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_program_info_log(shader, 1, length.as_mut_ptr(), info_log.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if maxLength is less than 0.");
    // SAFETY: as above.
    unsafe { gl.get_program_info_log(program, -1, length.as_mut_ptr(), info_log.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

// Enumerated state queries: Shader variables

fn get_tex_parameterfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = [0.0f32; 1];

    case.section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: one GLfloat of room; every query here is rejected and writes nothing.
    unsafe {
        gl.get_tex_parameterfv(BAD_ENUM, glw::GL_TEXTURE_MAG_FILTER, params.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, BAD_ENUM, params.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_tex_parameterfv(BAD_ENUM, BAD_ENUM, params.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn get_tex_parameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = [0i32; 1];

    case.section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        gl.get_tex_parameteriv(BAD_ENUM, glw::GL_TEXTURE_MAG_FILTER, params.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, BAD_ENUM, params.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_tex_parameteriv(BAD_ENUM, BAD_ENUM, params.as_mut_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

/// The three `get_uniform*v` cases' shared setup: the uniform-test program, the
/// location of the named uniform, and a shader plus an unlinked program to pass in
/// place of it.
fn uniform_query_setup<'gl>(
    case: &mut ApiCase<'gl>,
    uniform_name: &std::ffi::CStr,
) -> (ShaderProgram<'gl>, GLint, GLuint, GLuint) {
    let gl = case.gl();
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    // SAFETY: the program name is this case's own and the uniform name is
    // NUL-terminated.
    let unif = unsafe {
        gl.use_program(program.program());
        gl.get_uniform_location(program.program(), uniform_name.as_ptr())
    };
    if unif == -1 {
        case.fail(
            "Failed to retrieve uniform location".to_string(),
            "Failed to retrieve uniform location",
        );
    }

    // SAFETY: both objects are the caller's to delete.
    let (shader, program_empty) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };
    (program, unif, shader, program_empty)
}

fn get_uniformfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, unif, shader, program_empty) = uniform_query_setup(case, c"vUnif_vec4"); // vec4
    let mut params = [0.0f32; 4];

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: four floats of room, which is the widest uniform the program declares.
    unsafe { gl.get_uniformfv(BAD_NAME, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_uniformfv(shader, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
    // SAFETY: as above.
    unsafe { gl.get_uniformfv(program_empty, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if location does not correspond to a valid uniform variable location for the specified program object.");
    // SAFETY: as above.
    unsafe { gl.get_uniformfv(program.program(), -1, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(shader);
        gl.delete_program(program_empty);
    }
}

fn get_uniformiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, unif, shader, program_empty) = uniform_query_setup(case, c"fUnif_ivec4"); // ivec4
    let mut params = [0i32; 4];

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: as in `get_uniformfv`.
    unsafe { gl.get_uniformiv(BAD_NAME, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_uniformiv(shader, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
    // SAFETY: as above.
    unsafe { gl.get_uniformiv(program_empty, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if location does not correspond to a valid uniform variable location for the specified program object.");
    // SAFETY: as above.
    unsafe { gl.get_uniformiv(program.program(), -1, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(shader);
        gl.delete_program(program_empty);
    }
}

fn get_uniformuiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, unif, shader, program_empty) = uniform_query_setup(case, c"fUnif_uvec4"); // uvec4
    let mut params = [0u32; 4];

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: as in `get_uniformfv`.
    unsafe { gl.get_uniformuiv(BAD_NAME, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_uniformuiv(shader, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
    // SAFETY: as above.
    unsafe { gl.get_uniformuiv(program_empty, unif, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if location does not correspond to a valid uniform variable location for the specified program object.");
    // SAFETY: as above.
    unsafe { gl.get_uniformuiv(program.program(), -1, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(shader);
        gl.delete_program(program_empty);
    }
}

fn get_active_uniform(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    let mut num_active_uniforms: GLint = -1;

    // SAFETY: one GLint of room.
    unsafe { gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms) };
    log::info!("// GL_ACTIVE_UNIFORMS = {num_active_uniforms} (expected 4).");

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: every output pointer is null, which upstream passes too - GL writes
    // nothing through a null output and every call here is rejected anyway.
    unsafe {
        gl.get_active_uniform(
            BAD_NAME,
            0,
            0,
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe {
        gl.get_active_uniform(
            shader,
            0,
            0,
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to the number of active uniform variables in program.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.get_active_uniform(
            program.program(),
            num_active_uniforms as GLuint,
            0,
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if bufSize is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.get_active_uniform(
            program.program(),
            0,
            -1,
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the shader is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader);
    }
}

fn get_active_uniformsiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    let unused_uniform_index: GLuint = 1;
    let mut unused_param_dst: GLint = -1;
    let mut num_active_uniforms: GLint = -1;

    // SAFETY: one GLint of room.
    unsafe {
        gl.use_program(program.program());
        gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms);
    }
    log::info!("// GL_ACTIVE_UNIFORMS = {num_active_uniforms} (expected 4).");

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: one index in, one GLint of room out, matching uniformCount = 1.
    unsafe {
        gl.get_active_uniformsiv(
            BAD_NAME,
            1,
            &unused_uniform_index,
            glw::GL_UNIFORM_TYPE,
            &mut unused_param_dst,
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe {
        gl.get_active_uniformsiv(
            shader,
            1,
            &unused_uniform_index,
            glw::GL_UNIFORM_TYPE,
            &mut unused_param_dst,
        )
    };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if any value in uniformIndices is greater than or equal to the value of GL_ACTIVE_UNIFORMS for program.");
    for excess in 0..=2 {
        let invalid_uniform_indices: Vec<GLuint> = vec![1, (num_active_uniforms - 1 + excess) as GLuint, 1];

        let mut unused_params_dst = vec![0i32; invalid_uniform_indices.len()];
        // SAFETY: as many GLint of room as there are indices in.
        unsafe {
            gl.get_active_uniformsiv(
                program.program(),
                invalid_uniform_indices.len() as GLsizei,
                invalid_uniform_indices.as_ptr(),
                glw::GL_UNIFORM_TYPE,
                unused_params_dst.as_mut_ptr(),
            );
        }
        case.expect_error(if excess == 0 {
            glw::GL_NO_ERROR
        } else {
            glw::GL_INVALID_VALUE
        });
    }

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted token.");
    // SAFETY: as above.
    unsafe {
        gl.get_active_uniformsiv(
            program.program(),
            1,
            &unused_uniform_index,
            BAD_ENUM,
            &mut unused_param_dst,
        )
    };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the shader is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader);
    }
}

fn get_active_uniform_blockiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    let mut params: GLint = -1;
    let mut num_active_blocks: GLint = -1;

    // SAFETY: one GLint of room.
    unsafe { gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks) };
    log::info!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks} (expected 1).");
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if uniformBlockIndex is greater than or equal to the value of GL_ACTIVE_UNIFORM_BLOCKS or is not the index of an active uniform block in program.");
    // SAFETY: one GLint of room for a single-valued pname.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe {
        gl.get_active_uniform_blockiv(
            program.program(),
            num_active_blocks as GLuint,
            glw::GL_UNIFORM_BLOCK_BINDING,
            &mut params,
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if pname is not one of the accepted tokens.");
    // SAFETY: as above.
    unsafe { gl.get_active_uniform_blockiv(program.program(), 0, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: a current context.
    unsafe { gl.use_program(0) };
}

fn get_active_uniform_block_name(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    let mut length: GLsizei = -1;
    let mut num_active_blocks: GLint = -1;
    let mut uniform_block_name = [0 as GLchar; 128];

    // SAFETY: one GLint of room.
    unsafe { gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks) };
    log::info!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks} (expected 1).");
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if uniformBlockIndex is greater than or equal to the value of GL_ACTIVE_UNIFORM_BLOCKS or is not the index of an active uniform block in program.");
    // SAFETY: a current context.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: the destination holds the 128 bytes bufSize names.
    unsafe {
        gl.get_active_uniform_block_name(
            program.program(),
            num_active_blocks as GLuint,
            uniform_block_name.len() as GLsizei,
            &mut length,
            uniform_block_name.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: a current context.
    unsafe { gl.use_program(0) };
}

fn get_active_attrib(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    let mut num_active_attributes: GLint = -1;

    let mut length: GLsizei = -1;
    let mut size: GLint = -1;
    let mut type_ = BAD_ENUM;
    let mut name = [0 as GLchar; 32];

    // SAFETY: one GLint of room.
    unsafe { gl.get_programiv(program.program(), glw::GL_ACTIVE_ATTRIBUTES, &mut num_active_attributes) };
    log::info!("// GL_ACTIVE_ATTRIBUTES = {num_active_attributes} (expected 1).");

    // SAFETY: a current context.
    unsafe { gl.use_program(program.program()) };

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: the name buffer holds the 32 bytes bufSize names, and each of the other
    // three outputs is a single value.
    unsafe { gl.get_active_attrib(BAD_NAME, 0, 32, &mut length, &mut size, &mut type_, name.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_active_attrib(shader, 0, 32, &mut length, &mut size, &mut type_, name.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_ACTIVE_ATTRIBUTES.");
    // SAFETY: as above.
    unsafe {
        gl.get_active_attrib(
            program.program(),
            num_active_attributes as GLuint,
            name.len() as GLsizei,
            &mut length,
            &mut size,
            &mut type_,
            name.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if bufSize is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.get_active_attrib(
            program.program(),
            0,
            -1,
            &mut length,
            &mut size,
            &mut type_,
            name.as_mut_ptr(),
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the shader is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader);
    }
}

fn get_uniform_indices(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE),
    );
    let mut num_active_blocks: GLint = -1;
    let uniform_name = c"Block.blockVar";
    let mut uniform_indices = BAD_NAME;

    // SAFETY: one GLint of room.
    unsafe { gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks) };
    log::info!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks}");
    case.expect_error(glw::GL_NO_ERROR);

    let names = [uniform_name.as_ptr()];

    case.section("GL_INVALID_OPERATION is generated if program is a name of shader object.");
    // SAFETY: one NUL-terminated name in, one GLuint of room out, matching
    // uniformCount = 1.
    unsafe { gl.get_uniform_indices(shader, 1, names.as_ptr(), &mut uniform_indices) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if program is not name of program or shader object.");
    let invalid = BAD_NAME;
    // SAFETY: as above.
    unsafe { gl.get_uniform_indices(invalid, 1, names.as_ptr(), &mut uniform_indices) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the shader is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader);
    }
}

fn get_vertex_attribfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = 0.0f32;

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: one GLfloat of room; GL_VERTEX_ATTRIB_ARRAY_ENABLED is single-valued.
    unsafe { gl.get_vertex_attribfv(0, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let mut max_vertex_attribs: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        gl.get_vertex_attribfv(
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
            &mut params,
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_vertex_attribiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint = -1;

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.get_vertex_attribiv(0, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let mut max_vertex_attribs: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        gl.get_vertex_attribiv(
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
            &mut params,
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_vertex_attribi_iv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint = -1;

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.get_vertex_attrib_iiv(0, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let mut max_vertex_attribs: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        gl.get_vertex_attrib_iiv(
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
            &mut params,
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_vertex_attribi_uiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = BAD_NAME;

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.get_vertex_attrib_iuiv(0, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let mut max_vertex_attribs: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        gl.get_vertex_attrib_iuiv(
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
            &mut params,
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_vertex_attrib_pointerv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ptr = [std::ptr::null_mut::<std::ffi::c_void>(); 1];

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: one pointer of room, which is what the one accepted pname writes.
    unsafe { gl.get_vertex_attrib_pointerv(0, BAD_ENUM, ptr.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let mut max_vertex_attribs: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        gl.get_vertex_attrib_pointerv(
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_POINTER,
            ptr.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_frag_data_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are deleted at the end.
    let (shader, program) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };

    case.section("GL_INVALID_OPERATION is generated if program is the name of a shader object.");
    // SAFETY: a NUL-terminated name; the returned location is ignored.
    unsafe { gl.get_frag_data_location(shader, c"gl_FragColor".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if program has not been linked.");
    // SAFETY: as above.
    unsafe { gl.get_frag_data_location(program, c"gl_FragColor".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

// Enumerated state queries: Buffers

fn get_buffer_parameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint = -1;
    let mut buf: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
    }

    case.section("GL_INVALID_ENUM is generated if target or value is not an accepted value.");
    // SAFETY: one GLint of room; every query here is rejected and writes nothing.
    unsafe {
        gl.get_buffer_parameteriv(BAD_ENUM, glw::GL_BUFFER_SIZE, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_buffer_parameteriv(glw::GL_ARRAY_BUFFER, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_buffer_parameteriv(BAD_ENUM, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.get_buffer_parameteriv(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_SIZE, &mut params);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buf) };
}

fn get_buffer_parameteri64v(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint64 = -1;
    let mut buf: GLuint = 0;
    // SAFETY: as in `get_buffer_parameteriv`.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
    }

    case.section("GL_INVALID_ENUM is generated if target or value is not an accepted value.");
    // SAFETY: one GLint64 of room; every query here is rejected and writes nothing.
    unsafe {
        gl.get_buffer_parameteri_64v(BAD_ENUM, glw::GL_BUFFER_SIZE, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_buffer_parameteri_64v(glw::GL_ARRAY_BUFFER, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_buffer_parameteri_64v(BAD_ENUM, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.get_buffer_parameteri_64v(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_SIZE, &mut params);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buf) };
}

fn get_buffer_pointerv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = std::ptr::null_mut::<std::ffi::c_void>();
    let mut buf: GLuint = 0;
    // SAFETY: as in `get_buffer_parameteriv`.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
    }

    case.section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: one pointer of room; every query here is rejected and writes nothing.
    unsafe {
        gl.get_buffer_pointerv(glw::GL_ARRAY_BUFFER, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_buffer_pointerv(BAD_ENUM, glw::GL_BUFFER_MAP_POINTER, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.get_buffer_pointerv(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_MAP_POINTER, &mut params);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buf) };
}

fn get_framebuffer_attachment_parameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = [-1i32; 1];
    let mut fbo: GLuint = 0;
    let mut rbo = [0u32; 2];

    // SAFETY: every name is this case's own; the framebuffer gets a depth and a
    // stencil renderbuffer from *different* objects on purpose.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.gen_renderbuffers(2, rbo.as_mut_ptr());

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]);
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 16, 16);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[0],
        );
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]);
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8, 16, 16);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[1],
        );
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
    // SAFETY: one GLint of room, which is what every pname here writes.
    unsafe {
        // TYPE is GL_RENDERBUFFER
        gl.get_framebuffer_attachment_parameteriv(
            BAD_ENUM,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            params.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section(
        "GL_INVALID_ENUM is generated if pname is not valid for the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE.",
    );
    // SAFETY: as above.
    unsafe {
        // TYPE is GL_RENDERBUFFER
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
            params.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_ENUM);
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        // TYPE is GL_FRAMEBUFFER_DEFAULT
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_BACK,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_ENUM);
    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo) };

    case.section(
        "GL_INVALID_OPERATION is generated if attachment is GL_DEPTH_STENCIL_ATTACHMENT and different objects are bound to the depth and stencil attachment points of target.",
    );
    // SAFETY: as above.
    unsafe {
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE is GL_NONE and pname is not GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME.");
    // SAFETY: as above.
    unsafe {
        // TYPE is GL_NONE
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe {
        // TYPE is GL_NONE
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            params.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION or GL_INVALID_ENUM is generated if attachment is not one of the accepted values for the current binding of target.");
    // SAFETY: as above.
    unsafe {
        // A FBO is bound so GL_BACK is invalid
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_BACK,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
    }
    case.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_ENUM);
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        // Default framebuffer is bound so GL_COLOR_ATTACHMENT0 is invalid
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
    }
    case.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_ENUM);

    // SAFETY: the name is this case's own. Upstream leaks the two renderbuffers here;
    // reproduced, since deleting them would change what the driver sees.
    unsafe { gl.delete_framebuffers(1, &fbo) };
}

fn get_renderbuffer_parameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = [-1i32; 1];
    let mut rbo: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_renderbuffers(1, &mut rbo);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
    // SAFETY: one GLint of room; every query here is rejected and writes nothing.
    unsafe { gl.get_renderbuffer_parameteriv(BAD_ENUM, glw::GL_RENDERBUFFER_WIDTH, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if pname is not one of the accepted tokens.");
    // SAFETY: as above.
    unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, BAD_ENUM, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the name is this case's own.
    unsafe {
        gl.delete_renderbuffers(1, &rbo);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
    }
}

fn get_internalformativ(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // Upstream fills this with 0xcd first, so a query that writes nothing is visible.
    let mut params = [0xcdcdcdcdu32 as i32; 16];

    case.section("GL_INVALID_VALUE is generated if bufSize is negative.");
    // SAFETY: the destination holds the 16 GLint the widest bufSize below names.
    unsafe {
        gl.get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            -1,
            params.as_mut_ptr(),
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if pname is not GL_SAMPLES or GL_NUM_SAMPLE_COUNTS.");
    // SAFETY: as above.
    unsafe { gl.get_internalformativ(glw::GL_RENDERBUFFER, glw::GL_RGBA8, BAD_ENUM, 16, params.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if internalformat is not color-, depth-, or stencil-renderable.");
    if !case
        .context()
        .context_info
        .is_extension_supported("GL_EXT_render_snorm")
    {
        // SAFETY: as above.
        unsafe {
            gl.get_internalformativ(
                glw::GL_RENDERBUFFER,
                glw::GL_RG8_SNORM,
                glw::GL_NUM_SAMPLE_COUNTS,
                16,
                params.as_mut_ptr(),
            )
        };
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    // SAFETY: as above.
    unsafe {
        gl.get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_COMPRESSED_RGB8_ETC2,
            glw::GL_NUM_SAMPLE_COUNTS,
            16,
            params.as_mut_ptr(),
        )
    };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
    // SAFETY: as above.
    unsafe {
        gl.get_internalformativ(
            BAD_ENUM,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            16,
            params.as_mut_ptr(),
        );
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_internalformativ(
            glw::GL_FRAMEBUFFER,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            16,
            params.as_mut_ptr(),
        );
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    if !case
        .context()
        .context_info
        .is_extension_supported("GL_EXT_sparse_texture")
    {
        // SAFETY: as above.
        unsafe {
            gl.get_internalformativ(
                glw::GL_TEXTURE_2D,
                glw::GL_RGBA8,
                glw::GL_NUM_SAMPLE_COUNTS,
                16,
                params.as_mut_ptr(),
            )
        };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

// Query object queries

fn get_queryiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint = -1;

    case.section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: one GLint of room; every query here is rejected and writes nothing.
    unsafe {
        gl.get_queryiv(glw::GL_ANY_SAMPLES_PASSED, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_queryiv(BAD_ENUM, glw::GL_CURRENT_QUERY, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.get_queryiv(BAD_ENUM, BAD_ENUM, &mut params);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn get_query_objectuiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = BAD_NAME;
    let mut id: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe { gl.gen_queries(1, &mut id) };

    case.section("GL_INVALID_OPERATION is generated if id is not the name of a query object.");
    // SAFETY: one GLuint of room; a rejected query writes nothing.
    unsafe { gl.get_query_objectuiv(BAD_NAME, glw::GL_QUERY_RESULT_AVAILABLE, &mut params) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    log::info!("// Note: {id} is not a query object yet, since it hasn't been used by glBeginQuery");
    // SAFETY: as above.
    unsafe { gl.get_query_objectuiv(id, glw::GL_QUERY_RESULT_AVAILABLE, &mut params) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: as above.
    unsafe {
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, id);
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
    }

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.get_query_objectuiv(id, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if id is the name of a currently active query object.");
    // SAFETY: as above.
    unsafe { gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, id) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_query_objectuiv(id, glw::GL_QUERY_RESULT_AVAILABLE, &mut params) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe { gl.end_query(glw::GL_ANY_SAMPLES_PASSED) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_queries(1, &id) };
}

// Sync object queries

fn get_synciv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut length: GLsizei = -1;
    // Upstream fills this with 0xcd first, so a query that writes nothing is visible.
    let mut values = [0xcdcdcdcdu32 as i32; 32];

    case.section("GL_INVALID_VALUE is generated if sync is not the name of a sync object.");
    // SAFETY: the destination holds the 32 GLint bufSize names; a null handle is
    // exactly the error being provoked.
    unsafe {
        gl.get_synciv(
            std::ptr::null_mut(),
            glw::GL_OBJECT_TYPE,
            32,
            &mut length,
            values.as_mut_ptr(),
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if pname is not one of the accepted tokens.");
    // SAFETY: as above. Upstream leaks this sync object; reproduced.
    let sync = unsafe { gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: the handle is the one created above.
    unsafe { gl.get_synciv(sync, BAD_ENUM, 32, &mut length, values.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

// Enumerated boolean state queries

fn is_enabled(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if cap is not an accepted value.");
    // SAFETY: a current context; the returned boolean is ignored, as upstream ignores
    // it.
    unsafe {
        gl.is_enabled(BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.is_enabled(glw::GL_TRIANGLES);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

// Hints

fn hint(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if either target or mode is not an accepted value.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.hint(glw::GL_GENERATE_MIPMAP_HINT, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.hint(BAD_ENUM, glw::GL_FASTEST);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.hint(BAD_ENUM, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

// Named Object Usage

fn is_buffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer: GLuint = 0;

    case.section("A name returned by glGenBuffers, but not yet associated with a buffer object by calling glBindBuffer, is not the name of a buffer object.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_buffer = unsafe { gl.is_buffer(buffer) };
    case.check_booleans(is_buffer as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        is_buffer = gl.is_buffer(buffer);
    }
    case.check_booleans(is_buffer as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        is_buffer = gl.is_buffer(buffer);
    }
    case.check_booleans(is_buffer as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.delete_buffers(1, &buffer);
        is_buffer = gl.is_buffer(buffer);
    }
    case.check_booleans(is_buffer as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_framebuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut fbo: GLuint = 0;

    case.section("A name returned by glGenFramebuffers, but not yet bound through a call to glBindFramebuffer is not the name of a framebuffer object.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_fbo = unsafe { gl.is_framebuffer(fbo) };
    case.check_booleans(is_fbo as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        is_fbo = gl.is_framebuffer(fbo);
    }
    case.check_booleans(is_fbo as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        is_fbo = gl.is_framebuffer(fbo);
    }
    case.check_booleans(is_fbo as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
        is_fbo = gl.is_framebuffer(fbo);
    }
    case.check_booleans(is_fbo as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut program: GLuint = 0;

    case.section(
        "A name created with glCreateProgram, and not yet deleted with glDeleteProgram is a name of a program object.",
    );
    // SAFETY: the object is this case's own and is deleted below.
    let mut is_program = unsafe { gl.is_program(program) };
    case.check_booleans(is_program as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        program = gl.create_program();
        is_program = gl.is_program(program);
    }
    case.check_booleans(is_program as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.delete_program(program);
        is_program = gl.is_program(program);
    }
    case.check_booleans(is_program as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_renderbuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut rbo: GLuint = 0;

    case.section(
        "A name returned by glGenRenderbuffers, but not yet bound through a call to glBindRenderbuffer or glFramebufferRenderbuffer is not the name of a renderbuffer object.",
    );
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_rbo = unsafe { gl.is_renderbuffer(rbo) };
    case.check_booleans(is_rbo as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_renderbuffers(1, &mut rbo);
        is_rbo = gl.is_renderbuffer(rbo);
    }
    case.check_booleans(is_rbo as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        is_rbo = gl.is_renderbuffer(rbo);
    }
    case.check_booleans(is_rbo as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.delete_renderbuffers(1, &rbo);
        is_rbo = gl.is_renderbuffer(rbo);
    }
    case.check_booleans(is_rbo as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_shader(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut shader: GLuint = 0;

    case.section(
        "A name created with glCreateShader, and not yet deleted with glDeleteShader is a name of a shader object.",
    );
    // SAFETY: the object is this case's own and is deleted below. Note upstream calls
    // `glIsProgram` here, not `glIsShader` - reproduced, since 0 is neither.
    let mut is_shader = unsafe { gl.is_program(shader) };
    case.check_booleans(is_shader as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        shader = gl.create_shader(glw::GL_VERTEX_SHADER);
        is_shader = gl.is_shader(shader);
    }
    case.check_booleans(is_shader as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.delete_shader(shader);
        is_shader = gl.is_shader(shader);
    }
    case.check_booleans(is_shader as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_texture(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;

    case.section("A name returned by glGenTextures, but not yet bound through a call to glBindTexture is not the name of a texture.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_texture = unsafe { gl.is_texture(texture) };
    case.check_booleans(is_texture as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_textures(1, &mut texture);
        is_texture = gl.is_texture(texture);
    }
    case.check_booleans(is_texture as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        is_texture = gl.is_texture(texture);
    }
    case.check_booleans(is_texture as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        gl.delete_textures(1, &texture);
        is_texture = gl.is_texture(texture);
    }
    case.check_booleans(is_texture as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_query(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut query: GLuint = 0;

    case.section("A name returned by glGenQueries, but not yet associated with a query object by calling glBeginQuery, is not the name of a query object.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_query = unsafe { gl.is_query(query) };
    case.check_booleans(is_query as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_queries(1, &mut query);
        is_query = gl.is_query(query);
    }
    case.check_booleans(is_query as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, query);
        is_query = gl.is_query(query);
    }
    case.check_booleans(is_query as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
        gl.delete_queries(1, &query);
        is_query = gl.is_query(query);
    }
    case.check_booleans(is_query as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_sampler(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut sampler: GLuint = 0;

    case.section("A name returned by glGenSamplers is the name of a sampler object.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_sampler = unsafe { gl.is_sampler(sampler) };
    case.check_booleans(is_sampler as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_samplers(1, &mut sampler);
        is_sampler = gl.is_sampler(sampler);
    }
    case.check_booleans(is_sampler as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_sampler(0, sampler);
        is_sampler = gl.is_sampler(sampler);
    }
    case.check_booleans(is_sampler as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.delete_samplers(1, &sampler);
        is_sampler = gl.is_sampler(sampler);
    }
    case.check_booleans(is_sampler as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_sync(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    case.section("A name returned by glFenceSync is the name of a sync object.");
    // SAFETY: a null handle is not a sync object, which is what is being checked.
    let mut is_sync = unsafe { gl.is_sync(std::ptr::null_mut()) };
    case.check_booleans(is_sync as i32, glw::FALSE);

    // SAFETY: the handle is this case's own and is deleted below.
    let sync = unsafe { gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0) };
    // SAFETY: as above.
    is_sync = unsafe { gl.is_sync(sync) };
    case.check_booleans(is_sync as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.delete_sync(sync);
        is_sync = gl.is_sync(sync);
    }
    case.check_booleans(is_sync as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_transform_feedback(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf: GLuint = 0;

    case.section("A name returned by glGenTransformFeedbacks, but not yet bound using glBindTransformFeedback, is not the name of a transform feedback object.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_tf = unsafe { gl.is_transform_feedback(tf) };
    case.check_booleans(is_tf as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_transform_feedbacks(1, &mut tf);
        is_tf = gl.is_transform_feedback(tf);
    }
    case.check_booleans(is_tf as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf);
        is_tf = gl.is_transform_feedback(tf);
    }
    case.check_booleans(is_tf as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        gl.delete_transform_feedbacks(1, &tf);
        is_tf = gl.is_transform_feedback(tf);
    }
    case.check_booleans(is_tf as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

fn is_vertex_array(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut vao: GLuint = 0;

    case.section("A name returned by glGenVertexArrays, but not yet bound using glBindVertexArray, is not the name of a vertex array object.");
    // SAFETY: the name is this case's own and is deleted below.
    let mut is_vao = unsafe { gl.is_vertex_array(vao) };
    case.check_booleans(is_vao as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.gen_vertex_arrays(1, &mut vao);
        is_vao = gl.is_vertex_array(vao);
    }
    case.check_booleans(is_vao as i32, glw::FALSE);

    // SAFETY: as above.
    unsafe {
        gl.bind_vertex_array(vao);
        is_vao = gl.is_vertex_array(vao);
    }
    case.check_booleans(is_vao as i32, glw::TRUE);

    // SAFETY: as above.
    unsafe {
        gl.bind_vertex_array(0);
        gl.delete_vertex_arrays(1, &vao);
        is_vao = gl.is_vertex_array(vao);
    }
    case.check_booleans(is_vao as i32, glw::FALSE);

    case.expect_error(glw::GL_NO_ERROR);
}

/// `NegativeStateApiTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("enable", enable),
        ("disable", disable),
        ("get_booleanv", get_booleanv),
        ("get_floatv", get_floatv),
        ("get_integerv", get_integerv),
        ("get_integer64v", get_integer64v),
        ("get_integeri_v", get_integeri_v),
        ("get_integer64i_v", get_integer64i_v),
        ("get_string", get_string),
        ("get_stringi", get_stringi),
        ("get_attached_shaders", get_attached_shaders),
        ("get_shaderiv", get_shaderiv),
        ("get_shader_info_log", get_shader_info_log),
        ("get_shader_precision_format", get_shader_precision_format),
        ("get_shader_source", get_shader_source),
        ("get_programiv", get_programiv),
        ("get_program_info_log", get_program_info_log),
        ("get_tex_parameterfv", get_tex_parameterfv),
        ("get_tex_parameteriv", get_tex_parameteriv),
        ("get_uniformfv", get_uniformfv),
        ("get_uniformiv", get_uniformiv),
        ("get_uniformuiv", get_uniformuiv),
        ("get_active_uniform", get_active_uniform),
        ("get_active_uniformsiv", get_active_uniformsiv),
        ("get_active_uniform_blockiv", get_active_uniform_blockiv),
        ("get_active_uniform_block_name", get_active_uniform_block_name),
        ("get_active_attrib", get_active_attrib),
        ("get_uniform_indices", get_uniform_indices),
        ("get_vertex_attribfv", get_vertex_attribfv),
        ("get_vertex_attribiv", get_vertex_attribiv),
        ("get_vertex_attribi_iv", get_vertex_attribi_iv),
        ("get_vertex_attribi_uiv", get_vertex_attribi_uiv),
        ("get_vertex_attrib_pointerv", get_vertex_attrib_pointerv),
        ("get_frag_data_location", get_frag_data_location),
        ("get_buffer_parameteriv", get_buffer_parameteriv),
        ("get_buffer_parameteri64v", get_buffer_parameteri64v),
        ("get_buffer_pointerv", get_buffer_pointerv),
        (
            "get_framebuffer_attachment_parameteriv",
            get_framebuffer_attachment_parameteriv,
        ),
        ("get_renderbuffer_parameteriv", get_renderbuffer_parameteriv),
        ("get_internalformativ", get_internalformativ),
        ("get_queryiv", get_queryiv),
        ("get_query_objectuiv", get_query_objectuiv),
        ("get_synciv", get_synciv),
        ("is_enabled", is_enabled),
        ("hint", hint),
        ("is_buffer", is_buffer),
        ("is_framebuffer", is_framebuffer),
        ("is_program", is_program),
        ("is_renderbuffer", is_renderbuffer),
        ("is_shader", is_shader),
        ("is_texture", is_texture),
        ("is_query", is_query),
        ("is_sampler", is_sampler),
        ("is_sync", is_sync),
        ("is_transform_feedback", is_transform_feedback),
        ("is_vertex_array", is_vertex_array),
    ];
    add_api_cases(&mut group, cases);
    group
}
