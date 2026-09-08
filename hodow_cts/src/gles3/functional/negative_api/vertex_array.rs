// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fNegativeVertexArrayApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES3F_ADD_API_CASE` body is a
// function and the registration is a table of them; see the note in
// `gles2/functional/negative_api/buffer.rs`.
//
// The `_invalid_program` / `_incomplete_primitive` triples stay separate bodies, as
// upstream writes them - parameterising them into one would no longer line up with the
// C++ on a re-sync. The two blocks upstream copy-pastes *inside* several of those
// bodies (the incomplete-framebuffer section and the transform-feedback section) are
// named helpers here, with the same call order; that is the one place where writing
// them out five times over would only add ways to get one copy wrong.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, Context, ProgramSources, ShaderProgram, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLuint};

const VERTEX_SHADER_SOURCE: &str = "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";

const FRAGMENT_SHADER_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

/// `VAOHelper`
///
/// Upstream needs a VAO only on a GL 4.5 context and returns straight away on an ES
/// one. `ApiType` here is ES-only by construction (see `Api::gl_api_type`), so
/// `glu::isContextTypeES` is always true and this has nothing to do - but it is kept
/// as a call so the ported bodies stay line-for-line with the C++.
fn vao_helper(_ctx: &Context) {}

/// The literal `-1` upstream passes where the parameter is a `GLuint` name or index.
const BAD_NAME: GLuint = u32::MAX;

fn vertex_attribf(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: a current context; the index is out of range on purpose and no pointer
    // is involved.
    unsafe {
        gl.vertex_attrib_1f(max_vertex_attribs, 0.0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_2f(max_vertex_attribs, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_3f(max_vertex_attribs, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_4f(max_vertex_attribs, 0.0, 0.0, 0.0, 0.0);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn vertex_attribfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let v = [0.0f32; 4];
    // SAFETY: the source array holds the four components the widest call reads, and
    // every call is rejected for the index before it reads anything at all.
    unsafe {
        gl.vertex_attrib_1fv(max_vertex_attribs, v.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_2fv(max_vertex_attribs, v.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_3fv(max_vertex_attribs, v.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_4fv(max_vertex_attribs, v.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn vertex_attribi4(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let val_int = 0;
    let val_uint = 0;

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: as above.
    unsafe {
        gl.vertex_attrib_i_4i(max_vertex_attribs, val_int, val_int, val_int, val_int);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_i_4ui(max_vertex_attribs, val_uint, val_uint, val_uint, val_uint);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn vertex_attribi4v(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let val_int = [0i32; 4];
    let val_uint = [0u32; 4];

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: four components of source for a four-component call, and it is rejected
    // for the index before reading anything.
    unsafe {
        gl.vertex_attrib_i_4iv(max_vertex_attribs, val_int.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.vertex_attrib_i_4uiv(max_vertex_attribs, val_uint.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn vertex_attrib_pointer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut vao: GLuint = 0;
    // SAFETY: one name asked for, one GLuint of room; the name is deleted below.
    unsafe {
        gl.gen_vertex_arrays(1, &mut vao);
        gl.bind_vertex_array(0);
    }

    case.section("GL_INVALID_ENUM is generated if type is not an accepted value.");
    // SAFETY: a current context and a null client pointer throughout, which is what
    // upstream passes; every call here is expected to be rejected.
    unsafe { gl.vertex_attrib_pointer(0, 1, 0, glw::TRUE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_pointer(max_vertex_attribs, 1, glw::GL_BYTE, glw::TRUE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if size is not 1, 2, 3, or 4.");
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_pointer(0, 0, glw::GL_BYTE, glw::TRUE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if stride is negative.");
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_pointer(0, 1, glw::GL_BYTE, glw::TRUE, -1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if type is GL_INT_2_10_10_10_REV or GL_UNSIGNED_INT_2_10_10_10_REV and size is not 4.");
    // SAFETY: as above; the two accepted calls only record a null client pointer on
    // the default vertex array, which nothing draws from here.
    unsafe {
        gl.vertex_attrib_pointer(0, 2, glw::GL_INT_2_10_10_10_REV, glw::TRUE, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.vertex_attrib_pointer(0, 2, glw::GL_UNSIGNED_INT_2_10_10_10_REV, glw::TRUE, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.vertex_attrib_pointer(0, 4, glw::GL_INT_2_10_10_10_REV, glw::TRUE, 0, std::ptr::null());
        case.expect_error(glw::GL_NO_ERROR);
        gl.vertex_attrib_pointer(0, 4, glw::GL_UNSIGNED_INT_2_10_10_10_REV, glw::TRUE, 0, std::ptr::null());
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section(
        "GL_INVALID_OPERATION is generated a non-zero vertex array object is bound, zero is bound to the GL_ARRAY_BUFFER buffer object binding point and the pointer argument is not NULL.",
    );
    let offset: i8 = 1;
    // SAFETY: the pointer is to a live local and the call is rejected before GL reads
    // through it; the VAO is this case's own.
    unsafe {
        gl.bind_vertex_array(vao);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        case.expect_error(glw::GL_NO_ERROR);

        gl.vertex_attrib_pointer(0, 1, glw::GL_BYTE, glw::TRUE, 0, (&raw const offset).cast());
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.bind_vertex_array(0);
        gl.delete_vertex_arrays(1, &vao);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

fn vertex_attrib_i_pointer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut vao: GLuint = 0;
    // SAFETY: as in `vertex_attrib_pointer`.
    unsafe {
        gl.gen_vertex_arrays(1, &mut vao);
        gl.bind_vertex_array(0);
    }

    case.section("GL_INVALID_ENUM is generated if type is not an accepted value.");
    // SAFETY: a null client pointer throughout, as upstream passes.
    unsafe {
        gl.vertex_attrib_i_pointer(0, 1, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.vertex_attrib_i_pointer(0, 4, glw::GL_INT_2_10_10_10_REV, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.vertex_attrib_i_pointer(0, 4, glw::GL_UNSIGNED_INT_2_10_10_10_REV, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_i_pointer(max_vertex_attribs, 1, glw::GL_BYTE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if size is not 1, 2, 3, or 4.");
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_i_pointer(0, 0, glw::GL_BYTE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if stride is negative.");
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_i_pointer(0, 1, glw::GL_BYTE, -1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section(
        "GL_INVALID_OPERATION is generated a non-zero vertex array object is bound, zero is bound to the GL_ARRAY_BUFFER buffer object binding point and the pointer argument is not NULL.",
    );
    let offset: i8 = 1;
    // SAFETY: as in `vertex_attrib_pointer`.
    unsafe {
        gl.bind_vertex_array(vao);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        case.expect_error(glw::GL_NO_ERROR);

        gl.vertex_attrib_i_pointer(0, 1, glw::GL_BYTE, 0, (&raw const offset).cast());
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.bind_vertex_array(0);
        gl.delete_vertex_arrays(1, &vao);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

fn enable_vertex_attrib_array(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: a current context, an out-of-range index on purpose.
    unsafe { gl.enable_vertex_attrib_array(max_vertex_attribs) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn disable_vertex_attrib_array(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: as above.
    unsafe { gl.disable_vertex_attrib_array(max_vertex_attribs) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn gen_vertex_arrays(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    let mut arrays: GLuint = 0;
    // SAFETY: the negative count is the error being provoked; GL writes nothing when
    // it rejects the call, and the destination is a real GLuint either way.
    unsafe { gl.gen_vertex_arrays(-1, &mut arrays) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn bind_vertex_array(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if array is not zero or the name of an existing vertex array object.");
    // SAFETY: a name GL never handed out, which it rejects.
    unsafe { gl.bind_vertex_array(BAD_NAME) };
    case.expect_error(glw::GL_INVALID_OPERATION);
}

fn delete_vertex_arrays(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is rejected before the null array is read, which is
    // exactly what upstream relies on here.
    unsafe { gl.delete_vertex_arrays(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn vertex_attrib_divisor(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: an out-of-range index on purpose.
    unsafe { gl.vertex_attrib_divisor(max_vertex_attribs, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

/// The incomplete-framebuffer section every draw case ends with.
fn expect_incomplete_framebuffer(case: &mut ApiCase<'_>, draw: impl FnOnce()) {
    let gl = case.gl();
    let mut fbo: GLuint = 0;
    // SAFETY: the framebuffer is this case's own and is deleted here; it is left with
    // no attachment on purpose, which is what makes it incomplete.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    draw();
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
    }
}

/// The transform-feedback section the three `draw_elements`-family cases share, and
/// which upstream writes out once per case. `mode` is the primitive each of them uses.
fn expect_transform_feedback_active(case: &mut ApiCase<'_>, program: GLuint, mode: glw::GLenum, draw: impl Fn(), draw_in_range: impl Fn()) {
    let gl = case.gl();
    if case.context().context_info.is_extension_supported("GL_EXT_geometry_shader") {
        // GL_EXT_geometry_shader removes error
        return;
    }

    case.section("GL_INVALID_OPERATION is generated if transform feedback is active and not paused.");
    let tf_varying = c"gl_Position";
    let mut buf: GLuint = 0;
    let mut tf_id: GLuint = 0;

    // SAFETY: both names are this case's own, the varying name is NUL-terminated and
    // the buffer is sized before it is bound as a transform-feedback target.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.gen_transform_feedbacks(1, &mut tf_id);

        gl.use_program(program);
        let varyings = [tf_varying.as_ptr()];
        gl.transform_feedback_varyings(program, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(program);
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 32, std::ptr::null(), glw::GL_DYNAMIC_DRAW);
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf);
        gl.begin_transform_feedback(mode);
    }
    case.expect_error(glw::GL_NO_ERROR);

    draw();
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: as above.
    unsafe { gl.pause_transform_feedback() };
    draw_in_range();
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.end_transform_feedback();
        gl.delete_buffers(1, &buf);
        gl.delete_transform_feedbacks(1, &tf_id);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn draw_arrays(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: a current context; nothing is drawn from a client pointer here.
    unsafe { gl.draw_arrays(BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_arrays(glw::GL_POINTS, 0, -1) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
    });

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_arrays_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: unbinding whatever program was in use.
    unsafe { gl.use_program(0) };
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: a current context; nothing is drawn from a client pointer here.
    unsafe { gl.draw_arrays(BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_arrays(glw::GL_POINTS, 0, -1) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
    });
}

fn draw_arrays_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: a current context; nothing is drawn from a client pointer here.
    unsafe { gl.draw_arrays(BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_arrays(glw::GL_TRIANGLES, 0, -1) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_TRIANGLES, 0, 1) };
    });

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_elements(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    let vertices = [0.0f32; 1];
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: the index array is a live local of at least one byte, which is all a
    // one-element GL_UNSIGNED_BYTE draw can read.
    unsafe { gl.draw_elements(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements(glw::GL_POINTS, 1, BAD_ENUM, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_elements(glw::GL_POINTS, 1, glw::GL_FLOAT, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_elements(glw::GL_POINTS, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_elements(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    });

    let program_name = program.program();
    expect_transform_feedback_active(
        case,
        program_name,
        glw::GL_POINTS,
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
        },
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
        },
    );

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_elements_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: unbinding whatever program was in use.
    unsafe { gl.use_program(0) };
    let vertices = [0.0f32; 1];
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_elements`.
    unsafe { gl.draw_elements(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements(glw::GL_POINTS, 1, BAD_ENUM, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_elements(glw::GL_POINTS, 1, glw::GL_FLOAT, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_elements(glw::GL_POINTS, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_elements(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    });
}

fn draw_elements_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    let vertices = [0.0f32; 1];
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_elements`.
    unsafe { gl.draw_elements(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements(glw::GL_TRIANGLES, 1, BAD_ENUM, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_elements(glw::GL_TRIANGLES, 1, glw::GL_FLOAT, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_elements(glw::GL_TRIANGLES, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_elements(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    });

    let program_name = program.program();
    expect_transform_feedback_active(
        case,
        program_name,
        glw::GL_TRIANGLES,
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
        },
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
        },
    );

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_arrays_instanced(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    vao_helper(case.context());
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: a current context; nothing is drawn from a client pointer here.
    unsafe { gl.draw_arrays_instanced(BAD_ENUM, 0, 1, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count or primcount are negative.");
    // SAFETY: as above.
    unsafe {
        gl.draw_arrays_instanced(glw::GL_POINTS, 0, -1, 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_arrays_instanced(glw::GL_POINTS, 0, 1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_arrays_instanced(glw::GL_POINTS, 0, 1, 1) };
    });

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_arrays_instanced_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: unbinding whatever program was in use.
    unsafe { gl.use_program(0) };
    vao_helper(case.context());
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: a current context; nothing is drawn from a client pointer here.
    unsafe { gl.draw_arrays_instanced(BAD_ENUM, 0, 1, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count or primcount are negative.");
    // SAFETY: as above.
    unsafe {
        gl.draw_arrays_instanced(glw::GL_POINTS, 0, -1, 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_arrays_instanced(glw::GL_POINTS, 0, 1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_arrays_instanced(glw::GL_POINTS, 0, 1, 1) };
    });
}

fn draw_arrays_instanced_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    vao_helper(case.context());
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: a current context; nothing is drawn from a client pointer here.
    unsafe { gl.draw_arrays_instanced(BAD_ENUM, 0, 1, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count or primcount are negative.");
    // SAFETY: as above.
    unsafe {
        gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, -1, 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 1, 1) };
    });

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_elements_instanced(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    let vertices = [0.0f32; 1];
    vao_helper(case.context());

    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_elements`.
    unsafe { gl.draw_elements_instanced(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements_instanced(glw::GL_POINTS, 1, BAD_ENUM, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_FLOAT, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count or primcount are negative.");
    // SAFETY: as above; the 11-element draw is rejected for its negative primcount
    // before any index is read.
    unsafe {
        gl.draw_elements_instanced(glw::GL_POINTS, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_elements_instanced(glw::GL_POINTS, 11, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
    });

    let program_name = program.program();
    expect_transform_feedback_active(
        case,
        program_name,
        glw::GL_POINTS,
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
        },
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
        },
    );

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_elements_instanced_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: unbinding whatever program was in use.
    unsafe { gl.use_program(0) };
    let vertices = [0.0f32; 1];
    vao_helper(case.context());
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_elements`.
    unsafe { gl.draw_elements_instanced(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements_instanced(glw::GL_POINTS, 1, BAD_ENUM, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_FLOAT, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count or primcount are negative.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements_instanced(glw::GL_POINTS, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_elements_instanced(glw::GL_POINTS, 11, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
    });
}

fn draw_elements_instanced_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    let vertices = [0.0f32; 1];
    vao_helper(case.context());
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_elements`.
    unsafe { gl.draw_elements_instanced(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements_instanced(glw::GL_TRIANGLES, 1, BAD_ENUM, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_elements_instanced(glw::GL_TRIANGLES, 1, glw::GL_FLOAT, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count or primcount are negative.");
    // SAFETY: as above.
    unsafe {
        gl.draw_elements_instanced(glw::GL_TRIANGLES, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_elements_instanced(glw::GL_TRIANGLES, 11, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_elements_instanced(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
    });

    let program_name = program.program();
    expect_transform_feedback_active(
        case,
        program_name,
        glw::GL_TRIANGLES,
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements_instanced(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
        },
        || {
            // SAFETY: as above.
            unsafe { gl.draw_elements_instanced(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast(), 1) };
        },
    );

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_range_elements(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    let vertices = [0xffffffffu32; 1];
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: the index array is a live local of four bytes, more than a one-element
    // GL_UNSIGNED_BYTE draw can read.
    unsafe { gl.draw_range_elements(BAD_ENUM, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, BAD_ENUM, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_FLOAT, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_range_elements(glw::GL_POINTS, 0, 1, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if end < start.");
    // SAFETY: as above.
    unsafe { gl.draw_range_elements(glw::GL_POINTS, 1, 0, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    });

    // The paused draw uses an index that is inside [start, end], because the out-of-
    // range one upstream declares would be an error of its own.
    let vertices_in_range = [0u32; 1];
    let program_name = program.program();
    expect_transform_feedback_active(
        case,
        program_name,
        glw::GL_POINTS,
        || {
            // SAFETY: as above.
            unsafe { gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
        },
        || {
            // SAFETY: as above.
            unsafe { gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices_in_range.as_ptr().cast()) };
        },
    );

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

fn draw_range_elements_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: unbinding whatever program was in use.
    unsafe { gl.use_program(0) };
    let vertices = [0xffffffffu32; 1];
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_range_elements`.
    unsafe { gl.draw_range_elements(BAD_ENUM, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, BAD_ENUM, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_FLOAT, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_range_elements(glw::GL_POINTS, 0, 1, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if end < start.");
    // SAFETY: as above.
    unsafe { gl.draw_range_elements(glw::GL_POINTS, 1, 0, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    });
}

fn draw_range_elements_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program name is this case's own.
    unsafe { gl.use_program(program.program()) };
    let vertices = [0xffffffffu32; 1];
    vao_helper(case.context());

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as in `draw_range_elements`.
    unsafe { gl.draw_range_elements(BAD_ENUM, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
    // SAFETY: as above.
    unsafe {
        gl.draw_range_elements(glw::GL_TRIANGLES, 0, 1, 1, BAD_ENUM, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.draw_range_elements(glw::GL_TRIANGLES, 0, 1, 1, glw::GL_FLOAT, vertices.as_ptr().cast());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    // SAFETY: as above.
    unsafe { gl.draw_range_elements(glw::GL_TRIANGLES, 0, 1, -1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if end < start.");
    // SAFETY: as above.
    unsafe { gl.draw_range_elements(glw::GL_TRIANGLES, 1, 0, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    expect_incomplete_framebuffer(case, || {
        // SAFETY: as above.
        unsafe { gl.draw_range_elements(glw::GL_TRIANGLES, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
    });

    let vertices_in_range = [0u32; 1];
    let program_name = program.program();
    expect_transform_feedback_active(
        case,
        program_name,
        glw::GL_TRIANGLES,
        || {
            // SAFETY: as above.
            unsafe { gl.draw_range_elements(glw::GL_TRIANGLES, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices.as_ptr().cast()) };
        },
        || {
            // SAFETY: as above.
            unsafe { gl.draw_range_elements(glw::GL_TRIANGLES, 0, 1, 1, glw::GL_UNSIGNED_BYTE, vertices_in_range.as_ptr().cast()) };
        },
    );

    // SAFETY: as above.
    unsafe { gl.use_program(0) };
}

/// `NegativeVertexArrayApiTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_array");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("vertex_attribf", vertex_attribf),
        ("vertex_attribfv", vertex_attribfv),
        ("vertex_attribi4", vertex_attribi4),
        ("vertex_attribi4v", vertex_attribi4v),
        ("vertex_attrib_pointer", vertex_attrib_pointer),
        ("vertex_attrib_i_pointer", vertex_attrib_i_pointer),
        ("enable_vertex_attrib_array", enable_vertex_attrib_array),
        ("disable_vertex_attrib_array", disable_vertex_attrib_array),
        ("gen_vertex_arrays", gen_vertex_arrays),
        ("bind_vertex_array", bind_vertex_array),
        ("delete_vertex_arrays", delete_vertex_arrays),
        ("vertex_attrib_divisor", vertex_attrib_divisor),
        ("draw_arrays", draw_arrays),
        ("draw_arrays_invalid_program", draw_arrays_invalid_program),
        ("draw_arrays_incomplete_primitive", draw_arrays_incomplete_primitive),
        ("draw_elements", draw_elements),
        ("draw_elements_invalid_program", draw_elements_invalid_program),
        ("draw_elements_incomplete_primitive", draw_elements_incomplete_primitive),
        ("draw_arrays_instanced", draw_arrays_instanced),
        ("draw_arrays_instanced_invalid_program", draw_arrays_instanced_invalid_program),
        ("draw_arrays_instanced_incomplete_primitive", draw_arrays_instanced_incomplete_primitive),
        ("draw_elements_instanced", draw_elements_instanced),
        ("draw_elements_instanced_invalid_program", draw_elements_instanced_invalid_program),
        ("draw_elements_instanced_incomplete_primitive", draw_elements_instanced_incomplete_primitive),
        ("draw_range_elements", draw_range_elements),
        ("draw_range_elements_invalid_program", draw_range_elements_invalid_program),
        ("draw_range_elements_incomplete_primitive", draw_range_elements_incomplete_primitive),
    ];
    add_api_cases(&mut group, cases);
    group
}
