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

const UNIFORM_TEST_VERT_SOURCE: &str = concat!(
    "#version 300 es\n",
    "uniform mediump vec4 vec4_v;\n",
    "uniform mediump mat4 mat4_v;\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = mat4_v * vec4_v;\n",
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

/// The four uniform locations the `glUniform*` cases look up in the uniform-test
/// program, in upstream's order: `vec4_v`, `ivec4_f`, `uvec4_f`, `sampler_f`.
///
/// Upstream records a failure and then carries on with whatever locations it got, so
/// the caller gets the values either way.
fn uniform_test_program<'gl>(case: &mut ApiCase<'gl>) -> (ShaderProgram<'gl>, [GLint; 4]) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));

    // SAFETY: the program name is this case's own and every name is NUL-terminated.
    let locations = unsafe {
        gl.use_program(program.program());
        [
            gl.get_uniform_location(program.program(), c"vec4_v".as_ptr()),    // vec4
            gl.get_uniform_location(program.program(), c"ivec4_f".as_ptr()),   // ivec4
            gl.get_uniform_location(program.program(), c"uvec4_f".as_ptr()),   // uvec4
            gl.get_uniform_location(program.program(), c"sampler_f".as_ptr()), // sampler2D
        ]
    };
    case.expect_error(glw::GL_NO_ERROR);

    if locations.contains(&-1) {
        case.fail("Failed to retrieve uniform location".to_string(), "Failed to retrieve uniform location");
    }

    (program, locations)
}

/// `mat4_v`'s location, for the `glUniformMatrix*fv` cases.
fn uniform_matrix_test_program<'gl>(case: &mut ApiCase<'gl>) -> (ShaderProgram<'gl>, GLint, GLint) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));

    // SAFETY: as above.
    let (mat4_v, sampler_f) = unsafe {
        gl.use_program(program.program());
        (
            gl.get_uniform_location(program.program(), c"mat4_v".as_ptr()),    // mat4
            gl.get_uniform_location(program.program(), c"sampler_f".as_ptr()), // sampler2D
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    if mat4_v == -1 || sampler_f == -1 {
        case.fail("Failed to retrieve uniform location".to_string(), "Failed to retrieve uniform location");
    }

    (program, mat4_v, sampler_f)
}

// glUniform*f

fn uniformf_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(0);
        gl.uniform_1f(-1, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2f(-1, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3f(-1, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4f(-1, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn uniformf_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, [vec4_v, ivec4_f, uvec4_f, sampler_f]) = uniform_test_program(case);

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1f(vec4_v, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2f(vec4_v, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3f(vec4_v, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4f(vec4_v, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}f is used to load a uniform variable of type int, ivec2, ivec3, ivec4, unsigned int, uvec2, uvec3, uvec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_4f(ivec4_f, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4f(uvec4_f, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if a sampler is loaded using a command other than glUniform1i and glUniform1iv.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1f(sampler_f, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

fn uniformf_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1f(-2, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2f(-2, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3f(-2, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4f(-2, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.use_program(program.program());
        gl.uniform_1f(-1, 0.0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_2f(-1, 0.0, 0.0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_3f(-1, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_4f(-1, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_NO_ERROR);

        gl.use_program(0);
    }
}

// glUniform*fv

fn uniformfv_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = [0.0f32; 4];

    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: four floats of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(0);
        gl.uniform_1fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn uniformfv_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, [vec4_v, ivec4_f, uvec4_f, sampler_f]) = uniform_test_program(case);
    let data = [0.0f32; 4];

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: four floats of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1fv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2fv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3fv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4fv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}fv is used to load a uniform variable of type int, ivec2, ivec3, ivec4, unsigned int, uvec2, uvec3, uvec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_4fv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4fv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if a sampler is loaded using a command other than glUniform1i and glUniform1iv.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1fv(sampler_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

fn uniformfv_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    let data = [0.0f32; 4];

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: four floats of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1fv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2fv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3fv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4fv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.use_program(program.program());
        gl.uniform_1fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_2fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_3fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_4fv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);

        gl.use_program(0);
    }
}

fn uniformfv_invalid_count(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own and the name is NUL-terminated.
    let vec4_v = unsafe {
        gl.use_program(program.program());
        gl.get_uniform_location(program.program(), c"vec4_v".as_ptr()) // vec4
    };
    case.expect_error(glw::GL_NO_ERROR);

    if vec4_v == -1 {
        case.fail("Failed to retrieve uniform location".to_string(), "Failed to retrieve uniform location");
    }

    let data = [0.0f32; 8];

    case.section("GL_INVALID_OPERATION is generated if count is greater than 1 and the indicated uniform variable is not an array variable.");
    // SAFETY: eight floats of source, which is what the widest call reads for count 2.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1fv(vec4_v, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2fv(vec4_v, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3fv(vec4_v, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4fv(vec4_v, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

// glUniform*i

fn uniformi_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(0);
        gl.uniform_1i(-1, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2i(-1, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3i(-1, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4i(-1, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn uniformi_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, [vec4_v, ivec4_f, uvec4_f, _sampler_f]) = uniform_test_program(case);

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(ivec4_f, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2i(ivec4_f, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3i(ivec4_f, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4i(ivec4_f, 0, 0, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}i is used to load a uniform variable of type unsigned int, uvec2, uvec3, uvec4, or an array of these.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(uvec4_f, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2i(uvec4_f, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3i(uvec4_f, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4i(uvec4_f, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}i is used to load a uniform variable of type float, vec2, vec3, or vec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(vec4_v, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2i(vec4_v, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3i(vec4_v, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4i(vec4_v, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

fn uniformi_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(-2, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2i(-2, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3i(-2, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4i(-2, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.use_program(program.program());
        gl.uniform_1i(-1, 0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_2i(-1, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_3i(-1, 0, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_4i(-1, 0, 0, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);

        gl.use_program(0);
    }
}

// glUniform*iv

fn uniformiv_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = [0i32; 4];

    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: four ints of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(0);
        gl.uniform_1iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn uniformiv_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, [vec4_v, ivec4_f, uvec4_f, _sampler_f]) = uniform_test_program(case);
    let data = [0i32; 4];

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: four ints of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1iv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2iv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3iv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4iv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}iv is used to load a uniform variable of type float, vec2, vec3, or vec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1iv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2iv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3iv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4iv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}iv is used to load a uniform variable of type unsigned int, uvec2, uvec3 or uvec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1iv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2iv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3iv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4iv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

fn uniformiv_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    let data = [0i32; 4];

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: four ints of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1iv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2iv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3iv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4iv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.use_program(program.program());
        gl.uniform_1iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_2iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_3iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_4iv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);

        gl.use_program(0);
    }
}

fn uniformiv_invalid_count(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own and the name is NUL-terminated.
    let ivec4_f = unsafe {
        gl.use_program(program.program());
        gl.get_uniform_location(program.program(), c"ivec4_f".as_ptr()) // ivec4
    };
    case.expect_error(glw::GL_NO_ERROR);

    if ivec4_f == -1 {
        case.fail("Failed to retrieve uniform location".to_string(), "Failed to retrieve uniform location");
    }

    let data = [0i32; 8];

    case.section("GL_INVALID_OPERATION is generated if count is greater than 1 and the indicated uniform variable is not an array variable.");
    // SAFETY: eight ints of source, which is what the widest call reads for count 2.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1iv(ivec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2iv(ivec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3iv(ivec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4iv(ivec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

// glUniform{1234}ui

fn uniformui_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(0);
        gl.uniform_1ui(-1, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2ui(-1, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3ui(-1, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4ui(-1, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn uniformui_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, [vec4_v, ivec4_f, uvec4_f, sampler_f]) = uniform_test_program(case);

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1ui(uvec4_f, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2ui(uvec4_f, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3ui(uvec4_f, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4ui(uvec4_f, 0, 0, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}i is used to load a uniform variable of type int, ivec2, ivec3, ivec4, or an array of these.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1ui(ivec4_f, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2ui(ivec4_f, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3ui(ivec4_f, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4ui(ivec4_f, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}i is used to load a uniform variable of type float, vec2, vec3, or vec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1ui(vec4_v, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2ui(vec4_v, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3ui(vec4_v, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4ui(vec4_v, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if a sampler is loaded using a command other than glUniform1i and glUniform1iv.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1ui(sampler_f, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

fn uniformui_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: a current context; no pointer is involved. Upstream's `_ui` case really
    // does call the signed `glUniform{1234}i` here; reproduced.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(-2, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2i(-2, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3i(-2, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4i(-2, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.use_program(program.program());
        gl.uniform_1i(-1, 0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_2i(-1, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_3i(-1, 0, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_4i(-1, 0, 0, 0, 0);
        case.expect_error(glw::GL_NO_ERROR);

        gl.use_program(0);
    }
}

// glUniform{1234}uiv

fn uniformuiv_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = [0u32; 4];

    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: four uints of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(0);
        gl.uniform_1uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn uniformuiv_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, [vec4_v, ivec4_f, uvec4_f, sampler_f]) = uniform_test_program(case);
    let data = [0u32; 4];

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: four uints of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1uiv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2uiv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3uiv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4uiv(uvec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}uiv is used to load a uniform variable of type float, vec2, vec3, or vec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1uiv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2uiv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3uiv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4uiv(vec4_v, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if glUniform{1234}uiv is used to load a uniform variable of type int, ivec2, ivec3 or ivec4.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1uiv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2uiv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3uiv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4uiv(ivec4_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if a sampler is loaded using a command other than glUniform1i and glUniform1iv.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1uiv(sampler_f, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

fn uniformuiv_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    let data = [0u32; 4];

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: four uints of source, which is what the widest call reads for count 1.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1uiv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2uiv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3uiv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4uiv(-2, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.use_program(program.program());
        gl.uniform_1uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_2uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_3uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);
        gl.uniform_4uiv(-1, 1, data.as_ptr());
        case.expect_error(glw::GL_NO_ERROR);

        gl.use_program(0);
    }
}

fn uniformuiv_invalid_count(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own and the name is NUL-terminated.
    let uvec4_f = unsafe {
        gl.use_program(program.program());
        gl.get_uniform_location(program.program(), c"uvec4_f".as_ptr()) // uvec4
    };
    case.expect_error(glw::GL_NO_ERROR);

    if uvec4_f == -1 {
        case.fail("Failed to retrieve uniform location".to_string(), "Failed to retrieve uniform location");
    }

    let data = [0u32; 8];

    case.section("GL_INVALID_OPERATION is generated if count is greater than 1 and the indicated uniform variable is not an array variable.");
    // SAFETY: eight uints of source, which is what the widest call reads for count 2.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1uiv(uvec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_2uiv(uvec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_3uiv(uvec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.uniform_4uiv(uvec4_f, 2, data.as_ptr());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.use_program(0);
    }
}

// glUniformMatrix*fv

/// The nine `glUniformMatrix*fv` entry points, called in upstream's order with the
/// location, count and data every case passes them.
fn uniform_matrix_all(case: &mut ApiCase<'_>, location: GLint, data: &[f32], square: (GLsizei, [GLenum; 3]), non_square: (GLsizei, GLenum)) {
    let gl = case.gl();
    let (count, square_expected) = square;
    let (non_square_count, non_square_expected) = non_square;
    // SAFETY: the caller sizes `data` for the widest matrix and count in play; every
    // one of these reads at most that much.
    unsafe {
        gl.uniform_matrix_2fv(location, count, glw::FALSE, data.as_ptr());
        case.expect_error(square_expected[0]);
        gl.uniform_matrix_3fv(location, count, glw::FALSE, data.as_ptr());
        case.expect_error(square_expected[1]);
        gl.uniform_matrix_4fv(location, count, glw::FALSE, data.as_ptr());
        case.expect_error(square_expected[2]);
        gl.uniform_matrix_2x_3fv(location, non_square_count, glw::FALSE, data.as_ptr());
        case.expect_error(non_square_expected);
        gl.uniform_matrix_3x_2fv(location, non_square_count, glw::FALSE, data.as_ptr());
        case.expect_error(non_square_expected);
        gl.uniform_matrix_2x_4fv(location, non_square_count, glw::FALSE, data.as_ptr());
        case.expect_error(non_square_expected);
        gl.uniform_matrix_4x_2fv(location, non_square_count, glw::FALSE, data.as_ptr());
        case.expect_error(non_square_expected);
        gl.uniform_matrix_3x_4fv(location, non_square_count, glw::FALSE, data.as_ptr());
        case.expect_error(non_square_expected);
        gl.uniform_matrix_4x_3fv(location, non_square_count, glw::FALSE, data.as_ptr());
        case.expect_error(non_square_expected);
    }
}

fn uniform_matrixfv_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = [0.0f32; 16];

    case.section("GL_INVALID_OPERATION is generated if there is no current program object.");
    // SAFETY: sixteen floats of source, which is what mat4 reads for count 1.
    unsafe { gl.use_program(0) };
    uniform_matrix_all(case, -1, &data, (1, [glw::GL_INVALID_OPERATION; 3]), (1, glw::GL_INVALID_OPERATION));
}

fn uniform_matrixfv_incompatible_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (program, mat4_v, sampler_f) = uniform_matrix_test_program(case);
    let data = [0.0f32; 16];

    case.section("GL_INVALID_OPERATION is generated if the size of the uniform variable declared in the shader does not match the size indicated by the glUniform command.");
    // SAFETY: as above; only mat4 is the right size, so only it succeeds.
    unsafe { gl.use_program(program.program()) };
    uniform_matrix_all(
        case,
        mat4_v,
        &data,
        (1, [glw::GL_INVALID_OPERATION, glw::GL_INVALID_OPERATION, glw::GL_NO_ERROR]),
        (1, glw::GL_INVALID_OPERATION),
    );

    case.section("GL_INVALID_OPERATION is generated if a sampler is loaded using a command other than glUniform1i and glUniform1iv.");
    // SAFETY: as above.
    unsafe { gl.use_program(program.program()) };
    uniform_matrix_all(case, sampler_f, &data, (1, [glw::GL_INVALID_OPERATION; 3]), (1, glw::GL_INVALID_OPERATION));

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn uniform_matrixfv_invalid_location(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    let data = [0.0f32; 16];

    case.section("GL_INVALID_OPERATION is generated if location is an invalid uniform location for the current program object and location is not equal to -1.");
    // SAFETY: sixteen floats of source, which is what mat4 reads for count 1.
    unsafe { gl.use_program(program.program()) };
    uniform_matrix_all(case, -2, &data, (1, [glw::GL_INVALID_OPERATION; 3]), (1, glw::GL_INVALID_OPERATION));

    // SAFETY: as above; -1 is the "no such uniform, ignore it" location.
    unsafe { gl.use_program(program.program()) };
    uniform_matrix_all(case, -1, &data, (1, [glw::GL_NO_ERROR; 3]), (1, glw::GL_NO_ERROR));

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn uniform_matrixfv_invalid_count(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(UNIFORM_TEST_VERT_SOURCE, UNIFORM_TEST_FRAG_SOURCE));
    // SAFETY: the program name is this case's own and the name is NUL-terminated.
    let mat4_v = unsafe {
        gl.use_program(program.program());
        gl.get_uniform_location(program.program(), c"mat4_v".as_ptr()) // mat4
    };
    case.expect_error(glw::GL_NO_ERROR);

    if mat4_v == -1 {
        case.fail("Failed to retrieve uniform location".to_string(), "Failed to retrieve uniform location");
    }

    let data = [0.0f32; 32];

    case.section("GL_INVALID_OPERATION is generated if count is greater than 1 and the indicated uniform variable is not an array variable.");
    // SAFETY: thirty-two floats of source, which is what mat4 reads for count 2.
    //
    // Note the non-square calls pass count 1, not 2, upstream - they fail for the size
    // mismatch instead, which is the same verdict either way; reproduced.
    unsafe { gl.use_program(program.program()) };
    uniform_matrix_all(case, mat4_v, &data, (2, [glw::GL_INVALID_OPERATION; 3]), (1, glw::GL_INVALID_OPERATION));

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

// Transform feedback

fn gen_transform_feedbacks(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    let mut id: GLuint = 0;
    // SAFETY: the negative count is rejected before the destination is written.
    unsafe { gl.gen_transform_feedbacks(-1, &mut id) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

/// The setup the transform-feedback cases share: `count` feedback objects, a 32-byte
/// buffer bound at binding point 0, and `program`'s `gl_Position` captured, with
/// `tf_id[0]` bound but *not* yet begun.
fn transform_feedback_setup(case: &mut ApiCase<'_>, program: GLuint, count: GLsizei, tf_id: &mut [GLuint]) -> GLuint {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let tf_varying = c"gl_Position";

    // SAFETY: `tf_id` has room for `count` names (the caller sizes it), the varying
    // name is NUL-terminated and the buffer is sized before it is bound.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.gen_transform_feedbacks(count, tf_id.as_mut_ptr());

        gl.use_program(program);
        let varyings = [tf_varying.as_ptr()];
        gl.transform_feedback_varyings(program, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(program);
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id[0]);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 32, std::ptr::null(), glw::GL_DYNAMIC_DRAW);
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf);
    }
    buf
}

fn bind_transform_feedback(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id = [0u32; 2];
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let mut buf: GLuint = 0;
    let tf_varying = c"gl_Position";

    // SAFETY: two names asked for, two GLuint of room.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.gen_transform_feedbacks(2, tf_id.as_mut_ptr());
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_TRANSFORM_FEEDBACK.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.bind_transform_feedback(BAD_ENUM, tf_id[0]) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the transform feedback operation is active on the currently bound transform feedback object, and is not paused.");
    // SAFETY: the varying name is NUL-terminated and the buffer is sized before it is
    // bound as a feedback target.
    unsafe {
        gl.use_program(program.program());
        let varyings = [tf_varying.as_ptr()];
        gl.transform_feedback_varyings(program.program(), 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(program.program());
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id[0]);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 32, std::ptr::null(), glw::GL_DYNAMIC_DRAW);
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf);
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id[1]) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe { gl.end_transform_feedback() };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_buffers(1, &buf);
        gl.delete_transform_feedbacks(2, tf_id.as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn delete_transform_feedbacks(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut id: GLuint = 0;
    // SAFETY: one name asked for, one GLuint of room.
    unsafe { gl.gen_transform_feedbacks(1, &mut id) };

    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is the error being provoked.
    unsafe { gl.delete_transform_feedbacks(-1, &id) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_transform_feedbacks(1, &id) };
}

fn begin_transform_feedback(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id = [0u32; 2];
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let buf = transform_feedback_setup(case, program.program(), 2, &mut tf_id);
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if primitiveMode is not one of GL_POINTS, GL_LINES, or GL_TRIANGLES.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.begin_transform_feedback(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if transform feedback is already active.");
    // SAFETY: as above.
    unsafe { gl.begin_transform_feedback(glw::GL_TRIANGLES) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe { gl.end_transform_feedback() };

    case.section("GL_INVALID_OPERATION is generated if any binding point used in transform feedback mode does not have a buffer object bound.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf) };

    case.section("GL_INVALID_OPERATION is generated if no binding points would be used because no program object is active.");
    // SAFETY: as above.
    unsafe {
        gl.use_program(0);
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe { gl.use_program(program.program()) };

    case.section("GL_INVALID_OPERATION is generated if no binding points would be used because the active program object has specified no varying variables to record.");
    // SAFETY: a null varyings array with count 0, as upstream passes.
    unsafe {
        gl.transform_feedback_varyings(program.program(), 0, std::ptr::null(), glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(program.program());
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.begin_transform_feedback(glw::GL_TRIANGLES) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_transform_feedbacks(2, tf_id.as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn pause_transform_feedback(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id = [0u32; 2];
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let buf = transform_feedback_setup(case, program.program(), 2, &mut tf_id);
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if the currently bound transform feedback object is not active or is paused.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.pause_transform_feedback() };
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe {
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
        gl.pause_transform_feedback();
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.pause_transform_feedback() };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.end_transform_feedback();
        gl.delete_buffers(1, &buf);
        gl.delete_transform_feedbacks(2, tf_id.as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn resume_transform_feedback(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id = [0u32; 2];
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let buf = transform_feedback_setup(case, program.program(), 2, &mut tf_id);
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if the currently bound transform feedback object is not active or is not paused.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.resume_transform_feedback() };
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe {
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
        gl.resume_transform_feedback();
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe {
        gl.pause_transform_feedback();
        gl.resume_transform_feedback();
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.end_transform_feedback();
        gl.delete_buffers(1, &buf);
        gl.delete_transform_feedbacks(2, tf_id.as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn end_transform_feedback(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id = [0u32; 1];
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let buf = transform_feedback_setup(case, program.program(), 1, &mut tf_id);
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if transform feedback is not active.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.end_transform_feedback() };
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above.
    unsafe {
        gl.begin_transform_feedback(glw::GL_TRIANGLES);
        gl.end_transform_feedback();
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_transform_feedbacks(1, tf_id.as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn get_transform_feedback_varying(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id: GLuint = 0;
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let program_invalid = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, ""));
    let tf_varying = c"gl_Position";
    let mut max_transform_feedback_varyings: GLint = 0;
    let mut length: GLsizei = 0;
    let mut size: GLsizei = 0;
    let mut type_ = BAD_ENUM;
    let mut name = [0i8; 32];

    // SAFETY: one name asked for, one GLuint of room; the varying name is
    // NUL-terminated.
    unsafe {
        gl.gen_transform_feedbacks(1, &mut tf_id);
        let varyings = [tf_varying.as_ptr()];
        gl.transform_feedback_varyings(program.program(), 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.link_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if program is not the name of a program object.");
    // SAFETY: the name buffer holds the 32 bytes bufSize names, and each of the other
    // three outputs is a single value.
    unsafe { gl.get_transform_feedback_varying(BAD_NAME, 0, 32, &mut length, &mut size, &mut type_, name.as_mut_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if index is greater or equal to the value of GL_TRANSFORM_FEEDBACK_VARYINGS.");
    // SAFETY: as above.
    unsafe {
        gl.get_programiv(program.program(), glw::GL_TRANSFORM_FEEDBACK_VARYINGS, &mut max_transform_feedback_varyings);
        gl.get_transform_feedback_varying(
            program.program(),
            max_transform_feedback_varyings as GLuint,
            32,
            &mut length,
            &mut size,
            &mut type_,
            name.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION or GL_INVALID_VALUE is generated program has not been linked.");
    // SAFETY: as above.
    unsafe {
        gl.get_transform_feedback_varying(program_invalid.program(), 0, 32, &mut length, &mut size, &mut type_, name.as_mut_ptr());
    }
    case.expect_error2(glw::GL_INVALID_OPERATION, glw::GL_INVALID_VALUE);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_transform_feedbacks(1, &tf_id) };
    case.expect_error(glw::GL_NO_ERROR);
}

fn transform_feedback_varyings(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut tf_id: GLuint = 0;
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    let tf_varying = c"gl_Position";
    let mut max_transform_feedback_separate_attribs: GLint = 0;
    // SAFETY: one name asked for, one GLuint of room.
    unsafe { gl.gen_transform_feedbacks(1, &mut tf_id) };
    case.expect_error(glw::GL_NO_ERROR);

    let varyings = [tf_varying.as_ptr()];

    case.section("GL_INVALID_VALUE is generated if program is not the name of a program object.");
    // SAFETY: one NUL-terminated name in for count 1.
    unsafe { gl.transform_feedback_varyings(0, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if bufferMode is GL_SEPARATE_ATTRIBS and count is greater than GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.");
    // SAFETY: the over-large count is what makes GL reject the call, before it reads
    // past the single name in `varyings` - upstream relies on the same thing.
    unsafe {
        gl.get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut max_transform_feedback_separate_attribs);
        gl.transform_feedback_varyings(program.program(), max_transform_feedback_separate_attribs + 1, varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS);
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_transform_feedbacks(1, &tf_id) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `NegativeShaderApiTests::init`
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
        ("uniformf_invalid_program", uniformf_invalid_program),
        ("uniformf_incompatible_type", uniformf_incompatible_type),
        ("uniformf_invalid_location", uniformf_invalid_location),
        ("uniformfv_invalid_program", uniformfv_invalid_program),
        ("uniformfv_incompatible_type", uniformfv_incompatible_type),
        ("uniformfv_invalid_location", uniformfv_invalid_location),
        ("uniformfv_invalid_count", uniformfv_invalid_count),
        ("uniformi_invalid_program", uniformi_invalid_program),
        ("uniformi_incompatible_type", uniformi_incompatible_type),
        ("uniformi_invalid_location", uniformi_invalid_location),
        ("uniformiv_invalid_program", uniformiv_invalid_program),
        ("uniformiv_incompatible_type", uniformiv_incompatible_type),
        ("uniformiv_invalid_location", uniformiv_invalid_location),
        ("uniformiv_invalid_count", uniformiv_invalid_count),
        ("uniformui_invalid_program", uniformui_invalid_program),
        ("uniformui_incompatible_type", uniformui_incompatible_type),
        ("uniformui_invalid_location", uniformui_invalid_location),
        ("uniformuiv_invalid_program", uniformuiv_invalid_program),
        ("uniformuiv_incompatible_type", uniformuiv_incompatible_type),
        ("uniformuiv_invalid_location", uniformuiv_invalid_location),
        ("uniformuiv_invalid_count", uniformuiv_invalid_count),
        ("uniform_matrixfv_invalid_program", uniform_matrixfv_invalid_program),
        ("uniform_matrixfv_incompatible_type", uniform_matrixfv_incompatible_type),
        ("uniform_matrixfv_invalid_location", uniform_matrixfv_invalid_location),
        ("uniform_matrixfv_invalid_count", uniform_matrixfv_invalid_count),
        ("gen_transform_feedbacks", gen_transform_feedbacks),
        ("bind_transform_feedback", bind_transform_feedback),
        ("delete_transform_feedbacks", delete_transform_feedbacks),
        ("begin_transform_feedback", begin_transform_feedback),
        ("pause_transform_feedback", pause_transform_feedback),
        ("resume_transform_feedback", resume_transform_feedback),
        ("end_transform_feedback", end_transform_feedback),
        ("get_transform_feedback_varying", get_transform_feedback_varying),
        ("transform_feedback_varyings", transform_feedback_varyings),
    ];
    add_api_cases(&mut group, cases);
    group
}
