// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeStateApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each function keeps its upstream name
// and the order of its calls; the `beginSection` strings are the spec sentences the
// following calls check, so they are kept verbatim.
//
// Upstream's `VAOHelper` binds a vertex array object only on a desktop-GL context,
// where the default VAO 0 is not legal. This port is ES-only, so it has no counterpart.

use crate::gles31::functional::negative_test_shared::{BAD_ENUM, FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram};
use crate::glw::{self, GLint, GLint64, GLsizei, GLuint};
use crate::tcu::TestError;

/// `uniformTestVertSource`
fn uniform_test_vert_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\n\
         uniform mediump vec4 vUnif_vec4;\n\
         in mediump vec4 attr;\
         layout(shared) uniform Block {{ mediump vec4 blockVar; }};\n\
         void main (void)\n\
         {{\n\
             gl_Position = vUnif_vec4 + blockVar + attr;\n\
         }}\n",
        glsl_version_decl(ctx)
    )
}

/// `uniformTestFragSource`
fn uniform_test_frag_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\n\
         uniform mediump ivec4 fUnif_ivec4;\n\
         uniform mediump uvec4 fUnif_uvec4;\n\
         layout(location = 0) out mediump vec4 fragColor;\
         void main (void)\n\
         {{\n\
             fragColor = vec4(vec4(fUnif_ivec4) + vec4(fUnif_uvec4));\n\
         }}\n",
        glsl_version_decl(ctx)
    )
}

/// `getVtxFragVersionSources`'s `${GLSL_VERSION_DECL}` - 3.2 where the context has it.
fn glsl_version_decl(ctx: &NegativeTestContext<'_>) -> &'static str {
    if ctx.context_supports(3, 2) {
        "#version 320 es"
    } else {
        "#version 300 es"
    }
}

/// `checkSupport` - ES 3.2 for the indexed and robust entry points.
fn check_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.context_supports(3, 2) {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "This test requires a higher context version.".to_string(),
        ))
    }
}

/// The uniform test program every `get_uniform*` case links.
fn uniform_test_program<'gl>(ctx: &NegativeTestContext<'gl>) -> ShaderProgram<'gl> {
    ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::vtx_frag(uniform_test_vert_source(ctx), uniform_test_frag_source(ctx)),
    )
}

// Enabling & disabling states

fn enable(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if cap is not one of the allowed values.");
    // SAFETY: every call in this file is deliberately invalid; a conformant driver
    // raises an error and changes nothing, which is exactly what is being checked.
    unsafe {
        ctx.gl().enable(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn enablei(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if cap is not one of the allowed values.");
        ctx.gl().enablei(BAD_ENUM, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to the number of indexed capabilities for cap.");
        ctx.gl().enablei(glw::GL_BLEND, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn disable(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if cap is not one of the allowed values.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().disable(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn disablei(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if cap is not one of the allowed values.");
        ctx.gl().disablei(BAD_ENUM, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to the number of indexed capabilities for cap.");
        ctx.gl().disablei(glw::GL_BLEND, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

// Simple state queries

fn get_booleanv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    let mut params: glw::GLboolean = glw::GL_FALSE as glw::GLboolean;
    // SAFETY: as above; the driver writes nothing when it rejects the name.
    unsafe {
        ctx.gl().get_booleanv(BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_booleani_v(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut data: glw::GLboolean = glw::GL_TRUE as glw::GLboolean;
    let mut max_uniform_buffer_bindings: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if target is not indexed state queriable with these commands.");
        ctx.gl().get_booleani_v(BAD_ENUM, 0, &mut data);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.",
        );
        ctx.gl()
            .get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_booleani_v(
            glw::GL_UNIFORM_BUFFER_BINDING,
            max_uniform_buffer_bindings as GLuint,
            &mut data,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn get_floatv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    let mut params = 0.0f32;
    // SAFETY: as above.
    unsafe {
        ctx.gl().get_floatv(BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_integerv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params: GLint = -1;
    ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().get_integerv(BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_integer64v(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params: GLint64 = -1;
    ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the allowed values.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().get_integer_64v(BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_integeri_v(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut data: GLint = -1;
    let mut max_uniform_buffer_bindings: GLint = 0;
    let mut max_shader_storage_buffer_bindings: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if name is not an accepted value.");
        ctx.gl().get_integeri_v(BAD_ENUM, 0, &mut data);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.",
        );
        ctx.gl()
            .get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_integeri_v(
            glw::GL_UNIFORM_BUFFER_BINDING,
            max_uniform_buffer_bindings as GLuint,
            &mut data,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.",
        );
        ctx.gl().get_integerv(
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            &mut max_shader_storage_buffer_bindings,
        );
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_integeri_v(
            glw::GL_SHADER_STORAGE_BUFFER_BINDING,
            max_shader_storage_buffer_bindings as GLuint,
            &mut data,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn get_integer64i_v(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut data: GLint64 = -1;
    let mut max_uniform_buffer_bindings: GLint = 0;
    let mut max_shader_storage_buffer_bindings: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if name is not an accepted value.");
        ctx.gl().get_integer_64i_v(BAD_ENUM, 0, &mut data);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.",
        );
        ctx.gl()
            .get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_integer_64i_v(
            glw::GL_UNIFORM_BUFFER_START,
            max_uniform_buffer_bindings as GLuint,
            &mut data,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if index is outside of the valid range for the indexed state target.",
        );
        ctx.gl().get_integerv(
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            &mut max_shader_storage_buffer_bindings,
        );
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_integer_64i_v(
            glw::GL_SHADER_STORAGE_BUFFER_START,
            max_shader_storage_buffer_bindings as GLuint,
            &mut data,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().get_integer_64i_v(
            glw::GL_SHADER_STORAGE_BUFFER_SIZE,
            max_shader_storage_buffer_bindings as GLuint,
            &mut data,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn get_string(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if name is not an accepted value.");
    // SAFETY: as above; a rejected name answers null and the pointer is discarded.
    unsafe {
        let _ = ctx.gl().get_string(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_stringi(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut num_extensions: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if name is not an accepted value.");
        let _ = ctx.gl().get_stringi(BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is outside the valid range for indexed state name.");
        ctx.gl().get_integerv(glw::GL_NUM_EXTENSIONS, &mut num_extensions);
        let _ = ctx.gl().get_stringi(glw::GL_EXTENSIONS, num_extensions as GLuint);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

// Enumerated state queries: Shaders

fn get_attached_shaders(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut shaders = [0 as GLuint; 1];
    let mut count = [0 as GLsizei; 1];

    // SAFETY: as above; the objects created here are deleted at the end.
    unsafe {
        let shader_object = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        let program = ctx.gl().create_program();

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        ctx.gl()
            .get_attached_shaders(BAD_ENUM, 1, count.as_mut_ptr(), shaders.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        ctx.gl()
            .get_attached_shaders(shader_object, 1, count.as_mut_ptr(), shaders.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if maxCount is less than 0.");
        ctx.gl()
            .get_attached_shaders(program, -1, count.as_mut_ptr(), shaders.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_shader(shader_object);
        ctx.gl().delete_program(program);
    }
    Ok(())
}

fn get_shaderiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut param = [-1 as GLint; 1];

    // SAFETY: as above.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        let program = ctx.gl().create_program();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
        ctx.gl().get_shaderiv(shader, BAD_ENUM, param.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
        ctx.gl().get_shaderiv(BAD_ENUM, glw::GL_SHADER_TYPE, param.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if shader does not refer to a shader object.");
        ctx.gl().get_shaderiv(program, glw::GL_SHADER_TYPE, param.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_shader(shader);
        ctx.gl().delete_program(program);
    }
    Ok(())
}

fn get_shader_info_log(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut length = [-1 as GLsizei; 1];
    let mut info_log = [0u8; 128];

    // SAFETY: as above; the buffer is 128 bytes and 128 is what every call asks for.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        let program = ctx.gl().create_program();

        ctx.begin_section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
        ctx.gl()
            .get_shader_info_log(BAD_ENUM, 128, length.as_mut_ptr(), info_log.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
        ctx.gl()
            .get_shader_info_log(program, 128, length.as_mut_ptr(), info_log.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if maxLength is less than 0.");
        ctx.gl()
            .get_shader_info_log(shader, -1, length.as_mut_ptr(), info_log.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_shader(shader);
        ctx.gl().delete_program(program);
    }
    Ok(())
}

fn get_shader_precision_format(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut range = [0x_cdcd_cdcdu32 as GLint; 2];
    let mut precision = [0x_cdcd_cdcdu32 as GLint; 1];

    ctx.begin_section("GL_INVALID_ENUM is generated if shaderType or precisionType is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().get_shader_precision_format(
            BAD_ENUM,
            glw::GL_MEDIUM_FLOAT,
            range.as_mut_ptr(),
            precision.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_shader_precision_format(
            glw::GL_VERTEX_SHADER,
            BAD_ENUM,
            range.as_mut_ptr(),
            precision.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_shader_precision_format(BAD_ENUM, BAD_ENUM, range.as_mut_ptr(), precision.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_shader_source(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut length = [0 as GLsizei; 1];
    let mut source = [0u8; 1];

    // SAFETY: as above.
    unsafe {
        let program = ctx.gl().create_program();
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);

        ctx.begin_section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
        ctx.gl()
            .get_shader_source(BAD_ENUM, 1, length.as_mut_ptr(), source.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
        ctx.gl()
            .get_shader_source(program, 1, length.as_mut_ptr(), source.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if bufSize is less than 0.");
        ctx.gl()
            .get_shader_source(shader, -1, length.as_mut_ptr(), source.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_program(program);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

// Enumerated state queries: Programs

fn get_programiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = [0 as GLint; 1];

    // SAFETY: as above.
    unsafe {
        let program = ctx.gl().create_program();
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
        ctx.gl().get_programiv(program, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        ctx.gl()
            .get_programiv(BAD_ENUM, glw::GL_LINK_STATUS, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program does not refer to a program object.");
        ctx.gl().get_programiv(shader, glw::GL_LINK_STATUS, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_program(program);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

fn get_program_info_log(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut length = [0 as GLsizei; 1];
    let mut info_log = [b'x'; 1];

    // SAFETY: as above.
    unsafe {
        let program = ctx.gl().create_program();
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        ctx.gl()
            .get_program_info_log(BAD_ENUM, 1, length.as_mut_ptr(), info_log.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        ctx.gl()
            .get_program_info_log(shader, 1, length.as_mut_ptr(), info_log.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if maxLength is less than 0.");
        ctx.gl()
            .get_program_info_log(program, -1, length.as_mut_ptr(), info_log.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_program(program);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

// Enumerated state queries: Shader variables

fn get_tex_parameterfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = [0.0f32; 1];

    ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .get_tex_parameterfv(BAD_ENUM, glw::GL_TEXTURE_MAG_FILTER, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_tex_parameterfv(glw::GL_TEXTURE_2D, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_tex_parameterfv(BAD_ENUM, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_tex_parameteriv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = [0 as GLint; 1];

    ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .get_tex_parameteriv(BAD_ENUM, glw::GL_TEXTURE_MAG_FILTER, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_tex_parameteriv(glw::GL_TEXTURE_2D, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_tex_parameteriv(BAD_ENUM, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_tex_parameteriiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let mut params = [0 as GLint; 1];

    ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .get_tex_parameter_iiv(BAD_ENUM, glw::GL_TEXTURE_MAG_FILTER, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_tex_parameter_iiv(glw::GL_TEXTURE_2D, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_tex_parameter_iiv(BAD_ENUM, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_tex_parameteriuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let mut params = [0 as GLuint; 1];

    ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .get_tex_parameter_iuiv(BAD_ENUM, glw::GL_TEXTURE_MAG_FILTER, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_tex_parameter_iuiv(glw::GL_TEXTURE_2D, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_tex_parameter_iuiv(BAD_ENUM, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

/// The shared body of `get_uniformfv`/`get_uniformiv`/`get_uniformuiv`: the four error
/// sections are the same, only the getter and the uniform differ.
fn get_uniform_common(
    ctx: &mut NegativeTestContext<'_>,
    uniform: &std::ffi::CStr,
    getter: UniformGetter,
) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);

    // SAFETY: as above; the shader and empty program created here are deleted at the end.
    unsafe {
        ctx.gl().use_program(program.program());
        let unif = ctx.gl().get_uniform_location(program.program(), uniform.as_ptr());
        if unif == -1 {
            ctx.fail("Failed to retrieve uniform location");
        }

        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        let program_empty = ctx.gl().create_program();

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        getter.call(ctx, BAD_ENUM, unif);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        getter.call(ctx, shader, unif);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
        getter.call(ctx, program_empty, unif);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if location does not correspond to a valid uniform variable location for the specified program object.");
        getter.call(ctx, program.program(), -1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_shader(shader);
        ctx.gl().delete_program(program_empty);
    }
    Ok(())
}

/// Which `glGetUniform*v` the shared body above calls.
#[derive(Clone, Copy)]
enum UniformGetter {
    Float,
    Int,
    Uint,
}

impl UniformGetter {
    /// # Safety
    /// The destination below is four elements wide, which is the largest any uniform in
    /// the test program needs.
    unsafe fn call(self, ctx: &NegativeTestContext<'_>, program: GLuint, location: GLint) {
        let mut fparams = [0.0f32; 4];
        let mut iparams = [0 as GLint; 4];
        let mut uparams = [0 as GLuint; 4];

        // SAFETY: the caller's contract.
        unsafe {
            match self {
                Self::Float => ctx.gl().get_uniformfv(program, location, fparams.as_mut_ptr()),
                Self::Int => ctx.gl().get_uniformiv(program, location, iparams.as_mut_ptr()),
                Self::Uint => ctx.gl().get_uniformuiv(program, location, uparams.as_mut_ptr()),
            }
        }
    }

    /// The robust `glGetnUniform*v` flavour.
    ///
    /// # Safety
    /// As above.
    unsafe fn call_n(self, ctx: &NegativeTestContext<'_>, program: GLuint, location: GLint, buf_size: GLsizei) {
        let mut fparams = [0.0f32; 4];
        let mut iparams = [0 as GLint; 4];
        let mut uparams = [0 as GLuint; 4];

        // SAFETY: the caller's contract.
        unsafe {
            match self {
                Self::Float => ctx
                    .gl()
                    .getn_uniformfv(program, location, buf_size, fparams.as_mut_ptr()),
                Self::Int => ctx
                    .gl()
                    .getn_uniformiv(program, location, buf_size, iparams.as_mut_ptr()),
                Self::Uint => ctx
                    .gl()
                    .getn_uniformuiv(program, location, buf_size, uparams.as_mut_ptr()),
            }
        }
    }
}

/// The shared body of `get_nuniformfv`/`get_nuniformiv`/`get_nuniformuiv`.
fn get_nuniform_common(
    ctx: &mut NegativeTestContext<'_>,
    uniform: &std::ffi::CStr,
    getter: UniformGetter,
) -> Result<(), TestError> {
    check_support(ctx)?;
    let program = uniform_test_program(ctx);

    // SAFETY: as above.
    unsafe {
        let unif = ctx.gl().get_uniform_location(program.program(), uniform.as_ptr());
        ctx.gl().use_program(program.program());

        if unif == -1 {
            ctx.fail("Failed to retrieve uniform location");
        }

        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        let program_empty = ctx.gl().create_program();
        let mut buffer_size: GLint = 0;
        ctx.gl()
            .get_integerv(glw::GL_MAX_COMBINED_UNIFORM_BLOCKS, &mut buffer_size);

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        getter.call_n(ctx, BAD_ENUM, unif, buffer_size);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        getter.call_n(ctx, shader, unif, buffer_size);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
        getter.call_n(ctx, program_empty, unif, buffer_size);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if location does not correspond to a valid uniform variable location for the specified program object.");
        getter.call_n(ctx, program.program(), -1, buffer_size);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the buffer size required to store the requested data is greater than bufSize.");
        getter.call_n(ctx, program.program(), unif, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the buffer size required to store the requested data is greater than bufSize.  GL_INVALID_VALUE is also acceptable because -1 is passed to sizei.");
        getter.call_n(ctx, program.program(), unif, -1);
        ctx.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_shader(shader);
        ctx.gl().delete_program(program_empty);
    }
    Ok(())
}

fn get_uniformfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_uniform_common(ctx, c"vUnif_vec4", UniformGetter::Float)
}

fn get_uniformiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_uniform_common(ctx, c"fUnif_ivec4", UniformGetter::Int)
}

fn get_uniformuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_uniform_common(ctx, c"fUnif_uvec4", UniformGetter::Uint)
}

fn get_nuniformfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_nuniform_common(ctx, c"vUnif_vec4", UniformGetter::Float)
}

fn get_nuniformiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_nuniform_common(ctx, c"fUnif_ivec4", UniformGetter::Int)
}

fn get_nuniformuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // \note upstream asks for the *int* uniform's location here, not the uint one.
    get_nuniform_common(ctx, c"fUnif_ivec4", UniformGetter::Uint)
}

fn get_active_uniform(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);
    let mut num_active_uniforms: GLint = -1;

    // SAFETY: as above; every output pointer is null, which the entry point accepts.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        ctx.gl()
            .get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms);
        log::debug!("// GL_ACTIVE_UNIFORMS = {num_active_uniforms} (expected 4).");

        let no_length = std::ptr::null_mut::<GLsizei>();
        let no_size = std::ptr::null_mut::<GLint>();
        let no_type = std::ptr::null_mut::<glw::GLenum>();
        let no_name = std::ptr::null_mut::<glw::GLchar>();
        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        ctx.gl()
            .get_active_uniform(BAD_ENUM, 0, 0, no_length, no_size, no_type, no_name);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        ctx.gl()
            .get_active_uniform(shader, 0, 0, no_length, no_size, no_type, no_name);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to the number of active uniform variables in program.");
        ctx.gl().use_program(program.program());
        ctx.gl().get_active_uniform(
            program.program(),
            num_active_uniforms as GLuint,
            0,
            no_length,
            no_size,
            no_type,
            no_name,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if bufSize is less than 0.");
        ctx.gl()
            .get_active_uniform(program.program(), 0, -1, no_length, no_size, no_type, no_name);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().use_program(0);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

fn get_active_uniformsiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);
    let unused_uniform_index: GLuint = 1;
    let mut unused_param_dst: GLint = -1;
    let mut num_active_uniforms: GLint = -1;

    // SAFETY: as above; every array below is sized from the count passed with it.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        ctx.gl().use_program(program.program());
        ctx.gl()
            .get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms);
        log::debug!("// GL_ACTIVE_UNIFORMS = {num_active_uniforms} (expected 4).");

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        ctx.gl().get_active_uniformsiv(
            BAD_ENUM,
            1,
            &unused_uniform_index,
            glw::GL_UNIFORM_TYPE,
            &mut unused_param_dst,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        ctx.gl().get_active_uniformsiv(
            shader,
            1,
            &unused_uniform_index,
            glw::GL_UNIFORM_TYPE,
            &mut unused_param_dst,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if any value in uniformIndices is greater than or equal to the value of GL_ACTIVE_UNIFORMS for program.");
        for excess in 0..=2 {
            let invalid_uniform_indices: [GLuint; 3] = [1, (num_active_uniforms - 1 + excess) as GLuint, 1];
            let mut unused_params_dst = [0 as GLint; 3];
            ctx.gl().get_active_uniformsiv(
                program.program(),
                invalid_uniform_indices.len() as GLsizei,
                invalid_uniform_indices.as_ptr(),
                glw::GL_UNIFORM_TYPE,
                unused_params_dst.as_mut_ptr(),
            );
            ctx.expect_error(if excess == 0 {
                glw::GL_NO_ERROR
            } else {
                glw::GL_INVALID_VALUE
            });
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted token.");
        ctx.gl().get_active_uniformsiv(
            program.program(),
            1,
            &unused_uniform_index,
            BAD_ENUM,
            &mut unused_param_dst,
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.gl().use_program(0);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

fn get_active_uniform_blockiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);
    let mut params: GLint = -1;
    let mut num_active_blocks: GLint = -1;

    // SAFETY: as above.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        ctx.gl()
            .get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks);
        log::debug!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks} (expected 1).");
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if program is not the name of either a program or shader object.",
        );
        ctx.gl()
            .get_active_uniform_blockiv(BAD_ENUM, 0, glw::GL_UNIFORM_BLOCK_BINDING, &mut params);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is the name of a shader object");
        ctx.gl()
            .get_active_uniform_blockiv(shader, 0, glw::GL_UNIFORM_BLOCK_BINDING, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if uniformBlockIndex is greater than or equal to the value of GL_ACTIVE_UNIFORM_BLOCKS or is not the index of an active uniform block in program.");
        ctx.gl().use_program(program.program());
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_active_uniform_blockiv(
            program.program(),
            num_active_blocks as GLuint,
            glw::GL_UNIFORM_BLOCK_BINDING,
            &mut params,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the accepted tokens.");
        ctx.gl()
            .get_active_uniform_blockiv(program.program(), 0, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.gl().use_program(0);
    }
    Ok(())
}

fn get_active_uniform_block_name(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);
    let mut length: GLsizei = -1;
    let mut num_active_blocks: GLint = -1;
    let mut uniform_block_name = [0u8; 128];

    // SAFETY: as above; the name buffer is 128 bytes and that is the size passed.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        ctx.gl()
            .get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks);
        log::debug!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks} (expected 1).");
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is the name of a shader object.");
        ctx.gl().get_active_uniform_block_name(
            shader,
            num_active_blocks as GLuint,
            glw::GL_UNIFORM_BLOCK_BINDING as GLsizei,
            &mut length,
            uniform_block_name.as_mut_ptr().cast(),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if program is not the name of either a program or shader object.",
        );
        ctx.gl().get_active_uniform_block_name(
            BAD_ENUM,
            num_active_blocks as GLuint,
            glw::GL_UNIFORM_BLOCK_BINDING as GLsizei,
            &mut length,
            uniform_block_name.as_mut_ptr().cast(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if uniformBlockIndex is greater than or equal to the value of GL_ACTIVE_UNIFORM_BLOCKS or is not the index of an active uniform block in program.");
        ctx.gl().use_program(program.program());
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_active_uniform_block_name(
            program.program(),
            num_active_blocks as GLuint,
            uniform_block_name.len() as GLsizei,
            &mut length,
            uniform_block_name.as_mut_ptr().cast(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().use_program(0);
    }
    Ok(())
}

fn get_active_attrib(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);
    let mut num_active_attributes: GLint = -1;
    let mut length: GLsizei = -1;
    let mut size: GLint = -1;
    let mut ty: glw::GLenum = BAD_ENUM;
    let mut name = [0u8; 32];

    // SAFETY: as above; the name buffer is 32 bytes and that is the size passed.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        ctx.gl()
            .get_programiv(program.program(), glw::GL_ACTIVE_ATTRIBUTES, &mut num_active_attributes);
        log::debug!("// GL_ACTIVE_ATTRIBUTES = {num_active_attributes} (expected 1).");
        ctx.gl().use_program(program.program());

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
        ctx.gl().get_active_attrib(
            BAD_ENUM,
            0,
            32,
            &mut length,
            &mut size,
            &mut ty,
            name.as_mut_ptr().cast(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is not a program object.");
        ctx.gl()
            .get_active_attrib(shader, 0, 32, &mut length, &mut size, &mut ty, name.as_mut_ptr().cast());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_ACTIVE_ATTRIBUTES.");
        ctx.gl().get_active_attrib(
            program.program(),
            num_active_attributes as GLuint,
            name.len() as GLsizei,
            &mut length,
            &mut size,
            &mut ty,
            name.as_mut_ptr().cast(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if bufSize is less than 0.");
        ctx.gl().get_active_attrib(
            program.program(),
            0,
            -1,
            &mut length,
            &mut size,
            &mut ty,
            name.as_mut_ptr().cast(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().use_program(0);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

fn get_uniform_indices(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = uniform_test_program(ctx);
    let mut num_active_blocks: GLint = -1;
    let uniform_name = c"Block.blockVar";
    let mut uniform_indices: GLuint = BAD_ENUM;

    // SAFETY: as above; one name is passed and one index of output is given.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        ctx.gl()
            .get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks);
        log::debug!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks}");
        ctx.expect_error(glw::GL_NO_ERROR);

        let name_ptr = uniform_name.as_ptr();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is a name of shader object.");
        ctx.gl().get_uniform_indices(shader, 1, &name_ptr, &mut uniform_indices);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if program is not name of program or shader object.");
        ctx.gl()
            .get_uniform_indices(BAD_ENUM, 1, &name_ptr, &mut uniform_indices);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().use_program(0);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

/// The four `get_vertex_attrib*` cases differ only in which getter they call.
#[derive(Clone, Copy)]
enum VertexAttribGetter {
    Float,
    Int,
    IntI,
    UintI,
}

fn get_vertex_attrib_common(ctx: &mut NegativeTestContext<'_>, getter: VertexAttribGetter) -> Result<(), TestError> {
    let mut fparams = 0.0f32;
    let mut iparams: GLint = -1;
    let mut uparams: GLuint = BAD_ENUM;
    let mut max_vertex_attribs: GLint = 0;

    // SAFETY: as above; every destination is one element wide, which is what a rejected
    // query writes nothing into anyway.
    unsafe {
        let call = |ctx: &NegativeTestContext<'_>,
                    index: GLuint,
                    pname: glw::GLenum,
                    f: &mut f32,
                    i: &mut GLint,
                    u: &mut GLuint| match getter {
            VertexAttribGetter::Float => ctx.gl().get_vertex_attribfv(index, pname, f),
            VertexAttribGetter::Int => ctx.gl().get_vertex_attribiv(index, pname, i),
            VertexAttribGetter::IntI => ctx.gl().get_vertex_attrib_iiv(index, pname, i),
            VertexAttribGetter::UintI => ctx.gl().get_vertex_attrib_iuiv(index, pname, u),
        };

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
        call(ctx, 0, BAD_ENUM, &mut fparams, &mut iparams, &mut uparams);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
        ctx.gl()
            .get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        call(
            ctx,
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
            &mut fparams,
            &mut iparams,
            &mut uparams,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn get_vertex_attribfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_vertex_attrib_common(ctx, VertexAttribGetter::Float)
}

fn get_vertex_attribiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_vertex_attrib_common(ctx, VertexAttribGetter::Int)
}

fn get_vertex_attribi_iv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_vertex_attrib_common(ctx, VertexAttribGetter::IntI)
}

fn get_vertex_attribi_uiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    get_vertex_attrib_common(ctx, VertexAttribGetter::UintI)
}

fn get_vertex_attrib_pointerv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut ptr = [std::ptr::null_mut::<std::ffi::c_void>(); 1];
    let mut max_vertex_attribs: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
        ctx.gl().get_vertex_attrib_pointerv(0, BAD_ENUM, ptr.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
        ctx.gl()
            .get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs);
        ctx.gl().get_vertex_attrib_pointerv(
            max_vertex_attribs as GLuint,
            glw::GL_VERTEX_ATTRIB_ARRAY_POINTER,
            ptr.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn get_frag_data_location(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above; both objects are deleted at the end.
    unsafe {
        let shader = ctx.gl().create_shader(glw::GL_VERTEX_SHADER);
        let program = ctx.gl().create_program();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program is the name of a shader object.");
        let _ = ctx.gl().get_frag_data_location(shader, c"gl_FragColor".as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if program has not been linked.");
        let _ = ctx.gl().get_frag_data_location(program, c"gl_FragColor".as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_program(program);
        ctx.gl().delete_shader(shader);
    }
    Ok(())
}

// Enumerated state queries: Buffers

fn get_buffer_parameteriv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params: GLint = -1;
    let mut buf: GLuint = 0;

    // SAFETY: as above; one buffer name is asked for and deleted at the end.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);

        ctx.begin_section("GL_INVALID_ENUM is generated if target or value is not an accepted value.");
        ctx.gl()
            .get_buffer_parameteriv(BAD_ENUM, glw::GL_BUFFER_SIZE, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_buffer_parameteriv(glw::GL_ARRAY_BUFFER, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_buffer_parameteriv(BAD_ENUM, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.gl()
            .get_buffer_parameteriv(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_SIZE, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
    }
    Ok(())
}

fn get_buffer_parameteri64v(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params: GLint64 = -1;
    let mut buf: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);

        ctx.begin_section("GL_INVALID_ENUM is generated if target or value is not an accepted value.");
        ctx.gl()
            .get_buffer_parameteri_64v(BAD_ENUM, glw::GL_BUFFER_SIZE, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_buffer_parameteri_64v(glw::GL_ARRAY_BUFFER, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_buffer_parameteri_64v(BAD_ENUM, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.gl()
            .get_buffer_parameteri_64v(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_SIZE, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
    }
    Ok(())
}

fn get_buffer_pointerv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = std::ptr::null_mut::<std::ffi::c_void>();
    let mut buf: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);

        ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
        ctx.gl()
            .get_buffer_pointerv(glw::GL_ARRAY_BUFFER, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .get_buffer_pointerv(BAD_ENUM, glw::GL_BUFFER_MAP_POINTER, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.gl()
            .get_buffer_pointerv(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_MAP_POINTER, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
    }
    Ok(())
}

fn get_framebuffer_attachment_parameteriv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = [-1 as GLint; 1];
    let mut fbo: GLuint = 0;
    let mut rbo = [0 as GLuint; 2];

    // SAFETY: as above; the framebuffer and both renderbuffers are this function's own.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().gen_renderbuffers(2, rbo.as_mut_ptr());

        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]);
        ctx.gl()
            .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 16, 16);
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[0],
        );
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]);
        ctx.gl()
            .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8, 16, 16);
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[1],
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        // TYPE is GL_RENDERBUFFER.
        ctx.gl().get_framebuffer_attachment_parameteriv(
            BAD_ENUM,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not valid for the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE.");
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

        // TYPE is GL_FRAMEBUFFER_DEFAULT.
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_BACK,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if attachment is GL_DEPTH_STENCIL_ATTACHMENT and different objects are bound to the depth and stencil attachment points of target.",
        );
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE is GL_NONE and pname is not GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME.",
        );
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION or GL_INVALID_ENUM is generated if attachment is not one of the accepted values for the current binding of target.");
        // An FBO is bound, so GL_BACK is invalid.
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_BACK,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
        ctx.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_ENUM);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        // The default framebuffer is bound, so GL_COLOR_ATTACHMENT0 is invalid.
        ctx.gl().get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            params.as_mut_ptr(),
        );
        ctx.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_renderbuffers(2, rbo.as_ptr());
    }
    Ok(())
}

fn get_renderbuffer_parameteriv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = [-1 as GLint; 1];
    let mut rbo: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_renderbuffers(1, &mut rbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
        ctx.gl()
            .get_renderbuffer_parameteriv(BAD_ENUM, glw::GL_RENDERBUFFER_WIDTH, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the accepted tokens.");
        ctx.gl()
            .get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, BAD_ENUM, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION  is generated if the renderbuffer currently bound to target is zero.");
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, glw::GL_RENDERBUFFER_WIDTH, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_renderbuffers(1, &rbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
    }
    Ok(())
}

fn get_internalformativ(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params = [0x_cdcd_cdcdu32 as GLint; 16];
    let render_snorm = ctx.is_extension_supported("GL_EXT_render_snorm");
    let sparse_texture = ctx.is_extension_supported("GL_EXT_sparse_texture");

    // SAFETY: as above; the destination is 16 elements and 16 is the size passed.
    unsafe {
        ctx.begin_section("GL_INVALID_VALUE is generated if bufSize is negative.");
        ctx.gl().get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            -1,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not GL_SAMPLES or GL_NUM_SAMPLE_COUNTS.");
        ctx.gl()
            .get_internalformativ(glw::GL_RENDERBUFFER, glw::GL_RGBA8, BAD_ENUM, 16, params.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_ENUM is generated if internalformat is not color-, depth-, or stencil-renderable.",
        );
        if !render_snorm {
            ctx.gl().get_internalformativ(
                glw::GL_RENDERBUFFER,
                glw::GL_RG8_SNORM,
                glw::GL_NUM_SAMPLE_COUNTS,
                16,
                params.as_mut_ptr(),
            );
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.gl().get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_COMPRESSED_RGB8_ETC2,
            glw::GL_NUM_SAMPLE_COUNTS,
            16,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
        ctx.gl().get_internalformativ(
            BAD_ENUM,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            16,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_internalformativ(
            glw::GL_FRAMEBUFFER,
            glw::GL_RGBA8,
            glw::GL_NUM_SAMPLE_COUNTS,
            16,
            params.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);

        if !sparse_texture {
            ctx.gl().get_internalformativ(
                glw::GL_TEXTURE_2D,
                glw::GL_RGBA8,
                glw::GL_NUM_SAMPLE_COUNTS,
                16,
                params.as_mut_ptr(),
            );
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();
    }
    Ok(())
}

// Query object queries

fn get_queryiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params: GLint = -1;

    ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().get_queryiv(glw::GL_ANY_SAMPLES_PASSED, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_queryiv(BAD_ENUM, glw::GL_CURRENT_QUERY, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().get_queryiv(BAD_ENUM, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn get_query_objectuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut params: GLuint = BAD_ENUM;
    let mut id: GLuint = 0;

    // SAFETY: as above; the query object is this function's own.
    unsafe {
        ctx.gl().gen_queries(1, &mut id);

        ctx.begin_section("GL_INVALID_OPERATION is generated if id is not the name of a query object.");
        ctx.gl()
            .get_query_objectuiv(BAD_ENUM, glw::GL_QUERY_RESULT_AVAILABLE, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        log::debug!("// Note: {id} is not a query object yet, since it hasn't been used by glBeginQuery");
        ctx.gl()
            .get_query_objectuiv(id, glw::GL_QUERY_RESULT_AVAILABLE, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, id);
        ctx.gl().end_query(glw::GL_ANY_SAMPLES_PASSED);

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
        ctx.gl().get_query_objectuiv(id, BAD_ENUM, &mut params);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if id is the name of a currently active query object.");
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, id);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .get_query_objectuiv(id, glw::GL_QUERY_RESULT_AVAILABLE, &mut params);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().end_query(glw::GL_ANY_SAMPLES_PASSED);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.end_section();

        ctx.gl().delete_queries(1, &id);
    }
    Ok(())
}

// Sync object queries

fn get_synciv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut length: GLsizei = -1;
    let mut values = [0x_cdcd_cdcdu32 as GLint; 32];

    // SAFETY: as above; the destination is 32 elements and 32 is the size passed.
    unsafe {
        ctx.begin_section("GL_INVALID_VALUE is generated if sync is not the name of a sync object.");
        ctx.gl().get_synciv(
            std::ptr::null_mut(),
            glw::GL_OBJECT_TYPE,
            32,
            &mut length,
            values.as_mut_ptr(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not one of the accepted tokens.");
        let sync = ctx.gl().fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .get_synciv(sync, BAD_ENUM, 32, &mut length, values.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.gl().delete_sync(sync);

        ctx.begin_section("GL_INVALID_VALUE is generated if bufSize is negative.");
        let sync = ctx.gl().fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .get_synciv(sync, glw::GL_OBJECT_TYPE, -1, &mut length, values.as_mut_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_sync(sync);
    }
    Ok(())
}

// Enumerated boolean state queries

fn is_enabled(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if cap is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        let _ = ctx.gl().is_enabled(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        let _ = ctx.gl().is_enabled(glw::GL_TRIANGLES);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn is_enabledi(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if cap is not an accepted value.");
        let _ = ctx.gl().is_enabledi(BAD_ENUM, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        let _ = ctx.gl().is_enabledi(glw::GL_TRIANGLES, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if index is outside the valid range for the indexed state cap.",
        );
        let _ = ctx.gl().is_enabledi(glw::GL_BLEND, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

// Hints

fn hint(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if either target or mode is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().hint(glw::GL_GENERATE_MIPMAP_HINT, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().hint(BAD_ENUM, glw::GL_FASTEST);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().hint(BAD_ENUM, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

/// `getNegativeStateApiTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: enable,
        name: "enable",
    },
    FunctionContainer {
        function: disable,
        name: "disable",
    },
    FunctionContainer {
        function: get_booleanv,
        name: "get_booleanv",
    },
    FunctionContainer {
        function: get_floatv,
        name: "get_floatv",
    },
    FunctionContainer {
        function: get_integerv,
        name: "get_integerv",
    },
    FunctionContainer {
        function: get_integer64v,
        name: "get_integer64v",
    },
    FunctionContainer {
        function: get_integeri_v,
        name: "get_integeri_v",
    },
    FunctionContainer {
        function: get_booleani_v,
        name: "get_booleani_v",
    },
    FunctionContainer {
        function: get_integer64i_v,
        name: "get_integer64i_v",
    },
    FunctionContainer {
        function: get_string,
        name: "get_string",
    },
    FunctionContainer {
        function: get_stringi,
        name: "get_stringi",
    },
    FunctionContainer {
        function: get_attached_shaders,
        name: "get_attached_shaders",
    },
    FunctionContainer {
        function: get_shaderiv,
        name: "get_shaderiv",
    },
    FunctionContainer {
        function: get_shader_info_log,
        name: "get_shader_info_log",
    },
    FunctionContainer {
        function: get_shader_precision_format,
        name: "get_shader_precision_format",
    },
    FunctionContainer {
        function: get_shader_source,
        name: "get_shader_source",
    },
    FunctionContainer {
        function: get_programiv,
        name: "get_programiv",
    },
    FunctionContainer {
        function: get_program_info_log,
        name: "get_program_info_log",
    },
    FunctionContainer {
        function: get_tex_parameterfv,
        name: "get_tex_parameterfv",
    },
    FunctionContainer {
        function: get_tex_parameteriv,
        name: "get_tex_parameteriv",
    },
    FunctionContainer {
        function: get_uniformfv,
        name: "get_uniformfv",
    },
    FunctionContainer {
        function: get_uniformiv,
        name: "get_uniformiv",
    },
    FunctionContainer {
        function: get_uniformuiv,
        name: "get_uniformuiv",
    },
    FunctionContainer {
        function: get_active_uniform,
        name: "get_active_uniform",
    },
    FunctionContainer {
        function: get_active_uniformsiv,
        name: "get_active_uniformsiv",
    },
    FunctionContainer {
        function: get_active_uniform_blockiv,
        name: "get_active_uniform_blockiv",
    },
    FunctionContainer {
        function: get_active_uniform_block_name,
        name: "get_active_uniform_block_name",
    },
    FunctionContainer {
        function: get_active_attrib,
        name: "get_active_attrib",
    },
    FunctionContainer {
        function: get_uniform_indices,
        name: "get_uniform_indices",
    },
    FunctionContainer {
        function: get_vertex_attribfv,
        name: "get_vertex_attribfv",
    },
    FunctionContainer {
        function: get_vertex_attribiv,
        name: "get_vertex_attribiv",
    },
    FunctionContainer {
        function: get_vertex_attribi_iv,
        name: "get_vertex_attribi_iv",
    },
    FunctionContainer {
        function: get_vertex_attribi_uiv,
        name: "get_vertex_attribi_uiv",
    },
    FunctionContainer {
        function: get_vertex_attrib_pointerv,
        name: "get_vertex_attrib_pointerv",
    },
    FunctionContainer {
        function: get_frag_data_location,
        name: "get_frag_data_location",
    },
    FunctionContainer {
        function: get_buffer_parameteriv,
        name: "get_buffer_parameteriv",
    },
    FunctionContainer {
        function: get_buffer_parameteri64v,
        name: "get_buffer_parameteri64v",
    },
    FunctionContainer {
        function: get_buffer_pointerv,
        name: "get_buffer_pointerv",
    },
    FunctionContainer {
        function: get_framebuffer_attachment_parameteriv,
        name: "get_framebuffer_attachment_parameteriv",
    },
    FunctionContainer {
        function: get_renderbuffer_parameteriv,
        name: "get_renderbuffer_parameteriv",
    },
    FunctionContainer {
        function: get_internalformativ,
        name: "get_internalformativ",
    },
    FunctionContainer {
        function: get_queryiv,
        name: "get_queryiv",
    },
    FunctionContainer {
        function: get_query_objectuiv,
        name: "get_query_objectuiv",
    },
    FunctionContainer {
        function: get_synciv,
        name: "get_synciv",
    },
    FunctionContainer {
        function: is_enabled,
        name: "is_enabled",
    },
    FunctionContainer {
        function: hint,
        name: "hint",
    },
    FunctionContainer {
        function: enablei,
        name: "enablei",
    },
    FunctionContainer {
        function: disablei,
        name: "disablei",
    },
    FunctionContainer {
        function: get_tex_parameteriiv,
        name: "get_tex_parameteriiv",
    },
    FunctionContainer {
        function: get_tex_parameteriuiv,
        name: "get_tex_parameteriuiv",
    },
    FunctionContainer {
        function: get_nuniformfv,
        name: "get_nuniformfv",
    },
    FunctionContainer {
        function: get_nuniformiv,
        name: "get_nuniformiv",
    },
    FunctionContainer {
        function: get_nuniformuiv,
        name: "get_nuniformuiv",
    },
    FunctionContainer {
        function: is_enabledi,
        name: "is_enabledi",
    },
];
