// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fNegativeShaderApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES3F_ADD_API_CASE` body is a
// function and the registration is a table of them; see the note in
// `gles2/functional/negative_api/buffer.rs`.
//
// **29 of upstream's 63 cases are here** - the two `redeclaring_gl_frag_depth` classes
// plus `create_shader` through `uniform_block_binding`. The `glUniform*` family
// (`uniformf_invalid_program` .. `uniform_matrixfv_invalid_count`, 25 cases) and the
// transform-feedback cases (9) are not ported yet.
//
// Upstream's `isES` / `isContextTypeGLCore` branches are resolved here: `ApiType` in
// this port is ES-only by construction (see `Api::gl_api_type`), so `isES` is always
// true and `isContextTypeGLCore` always false, and only those branches are written.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, ProgramSources, ShaderProgram, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLbyte, GLenum, GLint, GLsizei, GLuint};

const VERTEX_SHADER_SOURCE: &str = "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";

const FRAGMENT_SHADER_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

const GL_FRAG_DEPTH_REDECLARATION_FRAG_SOURCE: &str = concat!(
    "#version 300 es\n",
    "#extension GL_EXT_conservative_depth: enable\n",
    "out highp float gl_FragDepth;\n",
    "void main (void)\n",
    "{\n",
    "}\n",
);

const GL_FRAG_DEPTH_REDECLARATION_FRAG_EXT_NOT_ENABLED_SOURCE: &str = concat!("#version 300 es\n", "out highp float gl_FragDepth;\n", "void main (void)\n", "{\n", "}\n",);

const UNIFORM_TEST_FRAG_SOURCE: &str = concat!(
    "#version 300 es\n",
    "uniform mediump ivec4 ivec4_f;\n",
    "uniform mediump uvec4 uvec4_f;\n",
    "uniform sampler2D sampler_f;\n",
    "layout(location = 0) out mediump vec4 fragColor;",
    "void main (void)\n",
    "{\n",
    "    fragColor.xy = (vec4(uvec4_f) + vec4(ivec4_f)).xy;\n",
    "    fragColor.zw = texture(sampler_f, vec2(0.0, 0.0)).zw;\n",
    "}\n",
);

const UNIFORM_BLOCK_VERT_SOURCE: &str = concat!(
    "#version 300 es\n",
    "layout(shared) uniform Block { lowp float var; };\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = vec4(var);\n",
    "}\n",
);

/// The literal `-1` upstream passes where the parameter is a `GLuint` name.
const BAD_NAME: GLuint = u32::MAX;

/// `ApiCaseRedeclaringGlFragDepth::test`
fn redeclaring_gl_frag_depth(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("gl_FragDepth redeclaration");

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, GL_FRAG_DEPTH_REDECLARATION_FRAG_SOURCE));

    let is_ok_program = program.is_ok();
    let conservative_depth_supported = case.context().context_info.is_extension_supported("GL_EXT_conservative_depth");

    // `at_least_es30` is what the group's registration already required, so it is not
    // re-tested here - the case only exists on an ES 3.0-or-later context.
    if conservative_depth_supported {
        if is_ok_program {
            case.section("GL_EXT_conservative_depth extension is supported, gl_FragDepth redeclaration is allowed");
        } else {
            case.fail("fragment shader compile/link error".to_string(), "Fail, fragment shader compile/link error");
        }
    } else if !is_ok_program {
        case.section("GL_EXT_conservative_depth extension is not supported, gl_FragDepth redeclaration is not allowed");
    } else {
        case.fail(
            "GL_EXT_conservative_depth extension is not supported; gl_FragDepth redeclaration must cause a compile failure".to_string(),
            "Fail, GL_EXT_conservative_depth extension is not supported; gl_FragDepth redeclaration must cause a compile failure",
        );
    }
}

/// `ApiCaseRedeclaringGlFragDepthExtensionNotEnabled::test`
fn redeclaring_gl_frag_depth_extension_not_enabled(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("gl_FragDepth redeclaration without extension enabled in shader");

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, GL_FRAG_DEPTH_REDECLARATION_FRAG_EXT_NOT_ENABLED_SOURCE));

    let is_ok_program = program.is_ok();
    let conservative_depth_supported = case.context().context_info.is_extension_supported("GL_EXT_conservative_depth");

    if conservative_depth_supported {
        if is_ok_program {
            case.fail(
                "GL_EXT_conservative_depth extension is supported and not enabled in shader. There should be compile/link error".to_string(),
                "Fail, GL_EXT_conservative_depth extension is supported and not enabled in shader. There should be compile/link error",
            );
        } else {
            case.section("GL_EXT_conservative_depth extension is supported but not enabled in shader, gl_FragDepth redeclaration is not allowed");
        }
    } else if !is_ok_program {
        case.section("GL_EXT_conservative_depth extension is not supported and not enabled in shader, gl_FragDepth redeclaration is not allowed");
    } else {
        case.fail(
            "GL_EXT_conservative_depth extension is not supported and not enabled in shader; gl_FragDepth redeclaration must cause a compile failure".to_string(),
            "Fail, GL_EXT_conservative_depth extension is not supported and not enabled in shader; gl_FragDepth redeclaration must cause a compile failure",
        );
    }
}

// Shader control commands

fn create_shader(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if shaderType is not an accepted value.");
    // SAFETY: a current context; the enum is invalid on purpose, so no object is
    // created and none leaks.
    unsafe { gl.create_shader(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn shader_source(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // \note Shader compilation must be supported.

    case.section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
    // SAFETY: a null source array with count 0, as upstream passes; every call here is
    // rejected before anything is read.
    unsafe { gl.shader_source(123456, 0, std::ptr::null(), std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if count is less than 0.");
    // SAFETY: the shader is this case's own and is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    // SAFETY: as above.
    unsafe { gl.shader_source(shader, -1, std::ptr::null(), std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
    // SAFETY: as above.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe { gl.shader_source(program, 0, std::ptr::null(), std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

fn compile_shader(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // \note Shader compilation must be supported.

    case.section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
    // SAFETY: a current context; the name was never handed out.
    unsafe { gl.compile_shader(9) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
    // SAFETY: the program is this case's own and is deleted at the end.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe { gl.compile_shader(program) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the program is this case's own.
    unsafe { gl.delete_program(program) };
}

fn delete_shader(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if shader is not a value generated by OpenGL.");
    // SAFETY: a current context; the name was never handed out.
    unsafe { gl.delete_shader(9) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn shader_binary(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let binary_formats = case.get_supported_extensions(glw::GL_NUM_SHADER_BINARY_FORMATS, glw::GL_SHADER_BINARY_FORMATS);
    let shader_binary_supported = !binary_formats.is_empty();
    if !shader_binary_supported {
        log::debug!("// Shader binaries not supported.");
    } else {
        log::debug!("// Shader binaries supported");
    }

    // SAFETY: both shaders are this case's own and are deleted at the end.
    let shaders = unsafe { [gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_shader(glw::GL_VERTEX_SHADER)] };

    case.section("GL_INVALID_ENUM is generated if binaryFormat is not an accepted value.");
    // SAFETY: one name in for count 1, and a null binary with length 0 - the call is
    // rejected for its format before either is read.
    unsafe { gl.shader_binary(1, shaders.as_ptr(), BAD_ENUM, std::ptr::null(), 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    if shader_binary_supported {
        case.section("GL_INVALID_VALUE is generated if the data pointed to by binary does not match the format specified by binaryFormat.");
        let data: GLbyte = 0x5F;
        // SAFETY: one byte of source for a length of 1.
        unsafe { gl.shader_binary(1, shaders.as_ptr(), binary_formats[0] as GLenum, (&raw const data).cast(), 1) };
        case.expect_error(glw::GL_INVALID_VALUE);

        // Error handling is different in case of SPIRV.
        let spirv_binary = binary_formats[0] as GLenum == glw::GL_SHADER_BINARY_FORMAT_SPIR_V;
        if spirv_binary {
            case.section("GL_INVALID_VALUE due to invalid data pointer.");
        } else {
            case.section(
                "GL_INVALID_OPERATION is generated if more than one of the handles in shaders refers to the same type of shader, or GL_INVALID_VALUE due to invalid data pointer.",
            );
        }

        // SAFETY: two names in for count 2, and a null binary with length 0.
        unsafe { gl.shader_binary(2, shaders.as_ptr(), binary_formats[0] as GLenum, std::ptr::null(), 0) };

        if spirv_binary {
            case.expect_error(glw::GL_INVALID_VALUE);
        } else {
            case.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both shaders are this case's own.
    unsafe {
        gl.delete_shader(shaders[0]);
        gl.delete_shader(shaders[1]);
    }
}

fn attach_shader(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: every object is this case's own and is deleted at the end.
    let (shader1, shader2, program) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.attach_shader(shader1, shader1) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, program);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.attach_shader(shader1, program);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_VALUE is generated if either program or shader is not a value generated by OpenGL.");
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, BAD_NAME);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.attach_shader(BAD_NAME, shader1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.attach_shader(BAD_NAME, BAD_NAME);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_OPERATION is generated if shader is already attached to program.");
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, shader1);
        case.expect_error(glw::GL_NO_ERROR);
        gl.attach_shader(program, shader1);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if a shader of the same type as shader is already attached to program.");
    // SAFETY: as above.
    unsafe { gl.attach_shader(program, shader2) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: every object is this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader1);
        gl.delete_shader(shader2);
    }
}

fn detach_shader(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are this case's own and are deleted at the end.
    let (shader, program) = unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_program()) };

    case.section("GL_INVALID_VALUE is generated if either program or shader is not a value generated by OpenGL.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.detach_shader(BAD_NAME, shader);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.detach_shader(program, BAD_NAME);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.detach_shader(BAD_NAME, BAD_NAME);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.detach_shader(shader, shader) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if shader is not a shader object.");
    // SAFETY: as above.
    unsafe {
        gl.detach_shader(program, program);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.detach_shader(shader, program);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if shader is not attached to program.");
    // SAFETY: as above.
    unsafe { gl.detach_shader(program, shader) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

/// The transform-feedback setup `link_program` and `use_program` share: a feedback
/// object and a 32-byte buffer bound to binding point 0, with `program`'s
/// `gl_Position` captured, left mid-`BeginTransformFeedback`.
fn begin_transform_feedback_on(case: &mut ApiCase<'_>, program: GLuint) -> (GLuint, GLuint) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let mut tf_id: GLuint = 0;
    let tf_varying = c"gl_Position";

    // SAFETY: both names are the caller's to delete, the varying name is
    // NUL-terminated and the buffer is sized before it is bound as a feedback target.
    unsafe {
        gl.gen_transform_feedbacks(1, &mut tf_id);
        gl.gen_buffers(1, &mut buf);

        gl.use_program(program);
        let varyings = [tf_varying.as_ptr()];
        gl.transform_feedback_varyings(program, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(program);
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 32, std::ptr::null(), glw::GL_DYNAMIC_DRAW);
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf);
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
    }
    case.expect_error(glw::GL_NO_ERROR);
    (buf, tf_id)
}

fn link_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is this case's own and is deleted below.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.link_program(BAD_NAME) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.link_program(shader) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the shader is this case's own.
    unsafe { gl.delete_shader(shader) };

    case.section("GL_INVALID_OPERATION is generated if program is the currently active program object and transform feedback mode is active.");
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let (buf, tf_id) = begin_transform_feedback_on(case, program.program());

    // SAFETY: as above.
    unsafe { gl.link_program(program.program()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.end_transform_feedback();
        gl.delete_transform_feedbacks(1, &tf_id);
        gl.delete_buffers(1, &buf);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn use_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is this case's own and is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };

    case.section("GL_INVALID_VALUE is generated if program is neither 0 nor a value generated by OpenGL.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.use_program(BAD_NAME) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.use_program(shader) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if transform feedback mode is active and not paused.");
    let program1 = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let program2 = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let (buf, tf_id) = begin_transform_feedback_on(case, program1.program());

    // SAFETY: as above.
    unsafe { gl.use_program(program2.program()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: as above.
    unsafe {
        gl.pause_transform_feedback();
        gl.use_program(program2.program());
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.end_transform_feedback();
        gl.delete_transform_feedbacks(1, &tf_id);
        gl.delete_buffers(1, &buf);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the shader is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader);
    }
}

fn delete_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: a current context; the name was never handed out.
    unsafe { gl.delete_program(BAD_NAME) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn validate_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the shader is this case's own and is deleted at the end.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.validate_program(BAD_NAME) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.validate_program(shader) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the shader is this case's own.
    unsafe { gl.delete_shader(shader) };
}

fn get_program_binary(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let program_invalid = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, ""));
    let mut binary_format = BAD_ENUM;
    let mut binary_length: GLsizei = -1;
    let mut binary_ptr: GLint = -1;
    let mut buf_size: GLint = -1;
    let mut link_status: GLint = -1;

    case.section("GL_INVALID_OPERATION is generated if bufSize is less than the size of GL_PROGRAM_BINARY_LENGTH for program.");
    // SAFETY: one GLint of room per query.
    unsafe { gl.get_programiv(program.program(), glw::GL_PROGRAM_BINARY_LENGTH, &mut buf_size) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_programiv(program.program(), glw::GL_LINK_STATUS, &mut link_status) };
    log::debug!("// GL_PROGRAM_BINARY_LENGTH = {buf_size}");
    log::debug!("// GL_LINK_STATUS = {link_status}");
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: `binary_ptr` is a single GLint standing in for the binary destination,
    // exactly as upstream passes it - both calls below are rejected for their bufSize
    // and write nothing through it.
    unsafe { gl.get_program_binary(program.program(), 0, &mut binary_length, &mut binary_format, (&raw mut binary_ptr).cast()) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    if buf_size > 0 {
        // SAFETY: as above.
        unsafe {
            gl.get_program_binary(program.program(), buf_size - 1, &mut binary_length, &mut binary_format, (&raw mut binary_ptr).cast());
        }
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if GL_LINK_STATUS for the program object is false.");
    // SAFETY: as above.
    unsafe { gl.get_programiv(program_invalid.program(), glw::GL_PROGRAM_BINARY_LENGTH, &mut buf_size) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_programiv(program_invalid.program(), glw::GL_LINK_STATUS, &mut link_status) };
    log::debug!("// GL_PROGRAM_BINARY_LENGTH = {buf_size}");
    log::debug!("// GL_LINK_STATUS = {link_status}");
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above; an unlinked program has a binary length of 0, so bufSize is 0
    // here and nothing is written either way.
    unsafe {
        gl.get_program_binary(program_invalid.program(), buf_size, &mut binary_length, &mut binary_format, (&raw mut binary_ptr).cast());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
}

fn program_binary(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let src_program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: both objects are this case's own and are deleted at the end.
    let (dst_program, unused_shader) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };
    let mut binary_format = BAD_ENUM;
    let mut binary_length: GLsizei = -1;
    let mut buf_size: GLint = -1;
    let mut link_status: GLint = -1;

    // SAFETY: one GLint of room per query.
    unsafe {
        gl.get_programiv(src_program.program(), glw::GL_PROGRAM_BINARY_LENGTH, &mut buf_size);
        gl.get_programiv(src_program.program(), glw::GL_LINK_STATUS, &mut link_status);
    }
    log::debug!("// GL_PROGRAM_BINARY_LENGTH = {buf_size}");
    log::debug!("// GL_LINK_STATUS = {link_status}");

    if buf_size < 0 {
        case.fail("GL_PROGRAM_BINARY_LENGTH is negative".to_string(), "GL_PROGRAM_BINARY_LENGTH is negative");
        return;
    }

    if buf_size > 0 {
        let mut binary_buf = vec![0u8; buf_size as usize];
        // SAFETY: the buffer holds exactly the bufSize bytes asked for.
        unsafe {
            gl.get_program_binary(src_program.program(), buf_size, &mut binary_length, &mut binary_format, binary_buf.as_mut_ptr().cast());
        }
        case.expect_error(glw::GL_NO_ERROR);

        case.section("GL_INVALID_OPERATION is generated if program is not the name of an existing program object.");
        // SAFETY: the source is the binary just read back, of the length GL reported.
        unsafe { gl.program_binary(unused_shader, binary_format, binary_buf.as_ptr().cast(), binary_length) };
        case.expect_error(glw::GL_INVALID_OPERATION);

        case.section("GL_INVALID_ENUM is generated if binaryFormat is not a value recognized by the implementation.");
        // SAFETY: as above.
        unsafe { gl.program_binary(dst_program, BAD_ENUM, binary_buf.as_ptr().cast(), binary_length) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_shader(unused_shader);
        gl.delete_program(dst_program);
    }
}

fn program_parameteri(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: the program is this case's own and is deleted at the end.
    let program = unsafe { gl.create_program() };

    case.section("GL_INVALID_VALUE is generated if program is not the name of an existing program object.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.program_parameteri(0, glw::GL_PROGRAM_BINARY_RETRIEVABLE_HINT, glw::TRUE as GLint) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if pname is not GL_PROGRAM_BINARY_RETRIEVABLE_HINT.");
    // SAFETY: as above.
    unsafe { gl.program_parameteri(program, BAD_ENUM, glw::TRUE as GLint) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if value is not GL_FALSE or GL_TRUE.");
    // SAFETY: as above.
    unsafe { gl.program_parameteri(program, glw::GL_PROGRAM_BINARY_RETRIEVABLE_HINT, 2) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the program is this case's own.
    unsafe { gl.delete_program(program) };
}

fn gen_samplers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    let mut sampler: GLuint = 0;
    // SAFETY: the negative count is rejected before the destination is written.
    unsafe { gl.gen_samplers(-1, &mut sampler) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn bind_sampler(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut max_tex_image_units: GLint = 0;
    let mut sampler: GLuint = 0;
    // SAFETY: one GLint of room; the sampler is this case's own and is deleted below.
    unsafe {
        gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut max_tex_image_units);
        gl.gen_samplers(1, &mut sampler);
    }

    case.section("GL_INVALID_VALUE is generated if unit is greater than or equal to the value of GL_MAX_COMBIED_TEXTURE_IMAGE_UNITS.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.bind_sampler(max_tex_image_units as GLuint, sampler) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if sampler is not zero or a name previously returned from a call to glGenSamplers.");
    // SAFETY: as above.
    unsafe { gl.bind_sampler(1, BAD_NAME) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if sampler has been deleted by a call to glDeleteSamplers.");
    // SAFETY: the sampler is this case's own.
    unsafe {
        gl.delete_samplers(1, &sampler);
        gl.bind_sampler(1, sampler);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
}

fn delete_samplers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is rejected before the null array is read.
    unsafe { gl.delete_samplers(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn get_sampler_parameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint = -1;
    let mut sampler: GLuint = 0;
    // SAFETY: the sampler is this case's own and is deleted at the end.
    unsafe { gl.gen_samplers(1, &mut sampler) };

    case.section("GL_INVALID_OPERATION is generated if sampler is not the name of a sampler object returned from a previous call to glGenSamplers.");
    // SAFETY: one GLint of room; a rejected query writes nothing.
    unsafe { gl.get_sampler_parameteriv(BAD_NAME, glw::GL_TEXTURE_MAG_FILTER, &mut params) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.get_sampler_parameteriv(sampler, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the sampler is this case's own.
    unsafe { gl.delete_samplers(1, &sampler) };
}

fn get_sampler_parameterfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params = 0.0f32;
    let mut sampler: GLuint = 0;
    // SAFETY: the sampler is this case's own and is deleted at the end.
    unsafe { gl.gen_samplers(1, &mut sampler) };

    case.section("GL_INVALID_OPERATION is generated if sampler is not the name of a sampler object returned from a previous call to glGenSamplers.");
    // SAFETY: one GLfloat of room; a rejected query writes nothing.
    unsafe { gl.get_sampler_parameterfv(BAD_NAME, glw::GL_TEXTURE_MAG_FILTER, &mut params) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.get_sampler_parameterfv(sampler, BAD_ENUM, &mut params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the sampler is this case's own.
    unsafe { gl.delete_samplers(1, &sampler) };
}

fn sampler_parameteri(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut sampler: GLuint = 0;
    // SAFETY: the sampler is this case's own and is deleted at the end.
    unsafe { gl.gen_samplers(1, &mut sampler) };

    case.section("GL_INVALID_OPERATION is generated if sampler is not the name of a sampler object previously returned from a call to glGenSamplers.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.sampler_parameteri(BAD_NAME, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_ENUM is generated if params should have a defined constant value (based on the value of pname) and does not.");
    // SAFETY: as above.
    unsafe { gl.sampler_parameteri(sampler, glw::GL_TEXTURE_WRAP_S, -1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the sampler is this case's own.
    unsafe { gl.delete_samplers(1, &sampler) };
}

fn sampler_parameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: GLint;
    let mut sampler: GLuint = 0;
    // SAFETY: the sampler is this case's own and is deleted at the end.
    unsafe { gl.gen_samplers(1, &mut sampler) };

    case.section("GL_INVALID_OPERATION is generated if sampler is not the name of a sampler object previously returned from a call to glGenSamplers.");
    params = glw::GL_CLAMP_TO_EDGE as GLint;
    // SAFETY: one GLint of source, which is what GL_TEXTURE_WRAP_S reads.
    unsafe { gl.sampler_parameteriv(BAD_NAME, glw::GL_TEXTURE_WRAP_S, &params) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_ENUM is generated if params should have a defined constant value (based on the value of pname) and does not.");
    params = -1;
    // SAFETY: as above.
    unsafe { gl.sampler_parameteriv(sampler, glw::GL_TEXTURE_WRAP_S, &params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the sampler is this case's own.
    unsafe { gl.delete_samplers(1, &sampler) };
}

fn sampler_parameterf(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut sampler: GLuint = 0;
    // SAFETY: the sampler is this case's own and is deleted at the end.
    unsafe { gl.gen_samplers(1, &mut sampler) };

    case.section("GL_INVALID_OPERATION is generated if sampler is not the name of a sampler object previously returned from a call to glGenSamplers.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.sampler_parameterf(BAD_NAME, glw::GL_TEXTURE_MIN_LOD, -1000.0) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_ENUM is generated if params should have a defined constant value (based on the value of pname) and does not.");
    // SAFETY: as above.
    unsafe { gl.sampler_parameterf(sampler, glw::GL_TEXTURE_WRAP_S, -1.0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the sampler is this case's own.
    unsafe { gl.delete_samplers(1, &sampler) };
}

fn sampler_parameterfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut params: f32;
    let mut sampler: GLuint = 0;
    // SAFETY: the sampler is this case's own and is deleted at the end.
    unsafe { gl.gen_samplers(1, &mut sampler) };

    case.section("GL_INVALID_OPERATION is generated if sampler is not the name of a sampler object previously returned from a call to glGenSamplers.");
    params = -1000.0;
    // SAFETY: one GLfloat of source, which is what GL_TEXTURE_WRAP_S reads.
    unsafe { gl.sampler_parameterfv(BAD_NAME, glw::GL_TEXTURE_WRAP_S, &params) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_ENUM is generated if params should have a defined constant value (based on the value of pname) and does not.");
    params = -1.0;
    // SAFETY: as above.
    unsafe { gl.sampler_parameterfv(sampler, glw::GL_TEXTURE_WRAP_S, &params) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the sampler is this case's own.
    unsafe { gl.delete_samplers(1, &sampler) };
}

// Shader data commands

fn get_attrib_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are this case's own and are deleted at the end.
    let (program_empty, shader) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));

    case.section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
    // SAFETY: a NUL-terminated attribute name; the returned location is ignored.
    unsafe {
        gl.bind_attrib_location(program_empty, 0, c"test".as_ptr());
        gl.get_attrib_location(program_empty, c"test".as_ptr());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if program is not a program or shader object.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.bind_attrib_location(program.program(), 0, c"test".as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_attrib_location(program.program(), c"test".as_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above; `-2` as a GLuint is a name GL never handed out.
    unsafe { gl.get_attrib_location(BAD_NAME - 1, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.get_attrib_location(shader, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader);
        gl.delete_program(program_empty);
    }
}

fn get_uniform_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are this case's own and are deleted at the end.
    let (program_empty, shader) = unsafe { (gl.create_program(), gl.create_shader(glw::GL_VERTEX_SHADER)) };

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));

    case.section("GL_INVALID_OPERATION is generated if program has not been successfully linked.");
    // SAFETY: a NUL-terminated uniform name; the returned location is ignored.
    unsafe { gl.get_uniform_location(program_empty, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: as above; `-2` as a GLuint is a name GL never handed out.
    unsafe {
        gl.use_program(program.program());
        gl.get_uniform_location(BAD_NAME - 1, c"test".as_ptr());
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above. Upstream really does call `glGetAttribLocation` in this
    // section of the `get_uniform_location` case; reproduced.
    unsafe { gl.get_attrib_location(shader, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_program(program_empty);
        gl.delete_shader(shader);
    }
}

fn bind_attrib_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: both objects are this case's own and are deleted at the end.
    let program = unsafe { gl.create_program() };
    let max_index = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: as above.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: a NUL-terminated attribute name.
    unsafe { gl.bind_attrib_location(program, max_index, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if name starts with the reserved prefix \"gl_\".");
    // SAFETY: as above.
    unsafe { gl.bind_attrib_location(program, max_index - 1, c"gl_test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if program is not a value generated by OpenGL.");
    // SAFETY: as above.
    unsafe { gl.bind_attrib_location(BAD_NAME, max_index - 1, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if program is not a program object.");
    // SAFETY: as above.
    unsafe { gl.bind_attrib_location(shader, max_index - 1, c"test".as_ptr()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both objects are this case's own.
    unsafe {
        gl.delete_program(program);
        gl.delete_shader(shader);
    }
}

fn uniform_block_binding(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_BLOCK_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));

    let mut max_uniform_buffer_bindings: GLint = 0;
    let mut num_active_uniforms: GLint = -1;
    let mut num_active_blocks: GLint = -1;
    // SAFETY: one GLint of room per query.
    unsafe {
        gl.use_program(program.program());
        gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings);
        gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms);
        gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks);
    }
    log::debug!("// GL_MAX_UNIFORM_BUFFER_BINDINGS = {max_uniform_buffer_bindings}");
    log::debug!("// GL_ACTIVE_UNIFORMS = {num_active_uniforms}");
    log::debug!("// GL_ACTIVE_UNIFORM_BLOCKS = {num_active_blocks}");
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if uniformBlockIndex is not an active uniform block index of program.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.uniform_block_binding(program.program(), BAD_NAME, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.uniform_block_binding(program.program(), 5, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if uniformBlockBinding is greater than or equal to the value of GL_MAX_UNIFORM_BUFFER_BINDINGS.");
    // SAFETY: as above.
    unsafe { gl.uniform_block_binding(program.program(), max_uniform_buffer_bindings as GLuint, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if program is not the name of a program object generated by the GL.");
    // SAFETY: as above.
    unsafe { gl.uniform_block_binding(BAD_NAME, 0, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

/// `NegativeShaderApiTests::init`, restricted to the 29 ported cases.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        // Registered first, and only on an ES 3.0-or-later context - which is the only
        // kind this port builds for the `dEQP-GLES3` root.
        ("redeclaring_gl_frag_depth", redeclaring_gl_frag_depth),
        ("redeclaring_gl_frag_depth_extension_not_enabled", redeclaring_gl_frag_depth_extension_not_enabled),
        ("create_shader", create_shader),
        ("shader_source", shader_source),
        ("compile_shader", compile_shader),
        ("delete_shader", delete_shader),
        ("shader_binary", shader_binary),
        ("attach_shader", attach_shader),
        ("detach_shader", detach_shader),
        ("link_program", link_program),
        ("use_program", use_program),
        ("delete_program", delete_program),
        ("validate_program", validate_program),
        ("get_program_binary", get_program_binary),
        ("program_binary", program_binary),
        ("program_parameteri", program_parameteri),
        ("gen_samplers", gen_samplers),
        ("bind_sampler", bind_sampler),
        ("delete_samplers", delete_samplers),
        ("get_sampler_parameteriv", get_sampler_parameteriv),
        ("get_sampler_parameterfv", get_sampler_parameterfv),
        ("sampler_parameteri", sampler_parameteri),
        ("sampler_parameteriv", sampler_parameteriv),
        ("sampler_parameterf", sampler_parameterf),
        ("sampler_parameterfv", sampler_parameterfv),
        ("get_attrib_location", get_attrib_location),
        ("get_uniform_location", get_uniform_location),
        ("bind_attrib_location", bind_attrib_location),
        ("uniform_block_binding", uniform_block_binding),
    ];
    add_api_cases(&mut group, cases);
    group
}
