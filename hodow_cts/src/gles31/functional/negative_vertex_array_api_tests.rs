// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeVertexArrayApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `VAOHelper` binds a vertex array object only on a desktop-GL context, where
// the default VAO 0 is not legal. This port is ES-only, so it has no counterpart, and the
// `isES` branches are resolved at port time.
//
// Every draw here is expected to be rejected before any vertex is fetched, which is why
// passing a one-byte index array and no vertex buffer is safe: a conformant driver raises
// the error and reads nothing.

use std::ffi::c_void;

use crate::gles31::functional::negative_test_shared::{BAD_ENUM, FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram, ShaderType};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::TestError;

/// `vertexShaderSource`
fn vertex_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\nvoid main (void)\n{{\n    gl_Position = vec4(0.0);\n}}\n",
        ctx.glsl_version_decl()
    )
}

/// `fragmentShaderSource`
fn fragment_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{{\n    fragColor = vec4(0.0);\n}}\n",
        ctx.glsl_version_decl()
    )
}

/// `geometryShaderSource` - pinned to 3.20 upstream, since only an ES 3.2 context reaches it.
const GEOMETRY_SHADER_SOURCE: &str =
    "#version 320 es\nlayout(points) in;\nlayout(points, max_vertices = 3) out;\nvoid main (void)\n{\n}\n";

/// The vertex+fragment program every draw case installs.
fn draw_program<'gl>(ctx: &NegativeTestContext<'gl>) -> ShaderProgram<'gl> {
    ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::vtx_frag(vertex_shader_source(ctx), fragment_shader_source(ctx)),
    )
}

/// The vertex+geometry separable program the `*_primitive_mode_mismatch` cases install.
fn geometry_program<'gl>(ctx: &NegativeTestContext<'gl>) -> ShaderProgram<'gl> {
    ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::default()
            .separable()
            .with(ShaderType::Vertex, vertex_shader_source(ctx))
            .with(ShaderType::Geometry, GEOMETRY_SHADER_SOURCE),
    )
}

/// `checkSupport`
fn check_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.context_supports(3, 2) {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "This test requires a 3.2 context or higher context version.".to_string(),
        ))
    }
}

/// The `GL_INVALID_FRAMEBUFFER_OPERATION` section every draw case ends with: bind an
/// attachment-less framebuffer, draw into it, and put the default framebuffer back.
fn with_incomplete_framebuffer(ctx: &mut NegativeTestContext<'_>, draw: impl FnOnce(&mut NegativeTestContext<'_>)) {
    let mut fbo: GLuint = 0;

    ctx.begin_section(
        "GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.",
    );
    // SAFETY: the framebuffer is this function's own and is deleted before returning.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }

    draw(ctx);
    ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);

    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
    ctx.end_section();
}

/// The transform-feedback section the `draw_elements`-family cases share. Only reached on
/// a context without `GL_EXT_geometry_shader`, which is what removes the error.
fn with_active_transform_feedback(
    ctx: &mut NegativeTestContext<'_>,
    program: &ShaderProgram<'_>,
    primitive_mode: GLenum,
    draw: impl Fn(&mut NegativeTestContext<'_>),
) {
    if ctx.is_extension_supported("GL_EXT_geometry_shader") {
        return;
    }

    let mut buf: GLuint = 0;
    let mut tf_id: GLuint = 0;

    ctx.begin_section("GL_INVALID_OPERATION is generated if transform feedback is active and not paused.");
    // SAFETY: the buffer and transform feedback object are this function's own; the
    // varying name is a static NUL-terminated string.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().gen_transform_feedbacks(1, &mut tf_id);

        ctx.gl().use_program(program.program());
        let varying = c"gl_Position".as_ptr();
        ctx.gl()
            .transform_feedback_varyings(program.program(), 1, &varying, glw::GL_INTERLEAVED_ATTRIBS);
        ctx.gl().link_program(program.program());
        ctx.gl().bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf_id);
        ctx.gl().bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            32,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW,
        );
        ctx.gl().bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf);
        ctx.gl().begin_transform_feedback(primitive_mode);
    }
    ctx.expect_error(glw::GL_NO_ERROR);

    draw(ctx);
    ctx.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: as above.
    unsafe { ctx.gl().pause_transform_feedback() };
    draw(ctx);
    ctx.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        ctx.gl().end_transform_feedback();
        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().delete_transform_feedbacks(1, &tf_id);
    }
    ctx.expect_error(glw::GL_NO_ERROR);
    ctx.end_section();
}

fn vertex_attribf(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    // SAFETY: every call in this file is deliberately invalid; a conformant driver raises
    // an error and changes nothing.
    unsafe {
        ctx.gl().vertex_attrib_1f(max, 0.0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_2f(max, 0.0, 0.0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_3f(max, 0.0, 0.0, 0.0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_4f(max, 0.0, 0.0, 0.0, 0.0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn vertex_attribfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let v = [0.0f32; 4];
    // SAFETY: as above; `v` is four elements, which is the widest of the four calls.
    unsafe {
        ctx.gl().vertex_attrib_1fv(max, v.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_2fv(max, v.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_3fv(max, v.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_4fv(max, v.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn vertex_attribi4(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;

    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().vertex_attrib_i_4i(max, 0, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_i_4ui(max, 0, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn vertex_attribi4v(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let val_int = [0 as GLint; 4];
    let val_uint = [0 as GLuint; 4];

    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: as above; both arrays are four elements, which is what the call reads.
    unsafe {
        ctx.gl().vertex_attrib_i_4iv(max, val_int.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().vertex_attrib_i_4uiv(max, val_uint.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn vertex_attrib_pointer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut vao: GLuint = 0;
    let offset: i8 = 1;

    // SAFETY: as above; the VAO is this function's own.
    unsafe {
        ctx.gl().gen_vertex_arrays(1, &mut vao);
        ctx.gl().bind_vertex_array(0);

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not an accepted value.");
        ctx.gl()
            .vertex_attrib_pointer(0, 1, 0, glw::GL_TRUE as glw::GLboolean, 0, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
        let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
        ctx.gl().vertex_attrib_pointer(
            max,
            1,
            glw::GL_BYTE,
            glw::GL_TRUE as glw::GLboolean,
            0,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if size is not 1, 2, 3, or 4.");
        ctx.gl()
            .vertex_attrib_pointer(0, 0, glw::GL_BYTE, glw::GL_TRUE as glw::GLboolean, 0, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if stride is negative.");
        ctx.gl()
            .vertex_attrib_pointer(0, 1, glw::GL_BYTE, glw::GL_TRUE as glw::GLboolean, -1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if type is GL_INT_2_10_10_10_REV or GL_UNSIGNED_INT_2_10_10_10_REV and size is not 4.");
        for ty in [glw::GL_INT_2_10_10_10_REV, glw::GL_UNSIGNED_INT_2_10_10_10_REV] {
            ctx.gl()
                .vertex_attrib_pointer(0, 2, ty, glw::GL_TRUE as glw::GLboolean, 0, std::ptr::null());
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        for ty in [glw::GL_INT_2_10_10_10_REV, glw::GL_UNSIGNED_INT_2_10_10_10_REV] {
            ctx.gl()
                .vertex_attrib_pointer(0, 4, ty, glw::GL_TRUE as glw::GLboolean, 0, std::ptr::null());
            ctx.expect_error(glw::GL_NO_ERROR);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated a non-zero vertex array object is bound, zero is bound to the GL_ARRAY_BUFFER buffer object binding point and the pointer argument is not NULL.");
        ctx.gl().bind_vertex_array(vao);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.gl().vertex_attrib_pointer(
            0,
            1,
            glw::GL_BYTE,
            glw::GL_TRUE as glw::GLboolean,
            0,
            std::ptr::from_ref(&offset).cast::<c_void>(),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        ctx.gl().bind_vertex_array(0);
        ctx.gl().delete_vertex_arrays(1, &vao);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.end_section();
    }
    Ok(())
}

fn vertex_attrib_i_pointer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut vao: GLuint = 0;
    let offset: i8 = 1;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_vertex_arrays(1, &mut vao);
        ctx.gl().bind_vertex_array(0);

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not an accepted value.");
        ctx.gl().vertex_attrib_i_pointer(0, 1, 0, 0, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        for ty in [glw::GL_INT_2_10_10_10_REV, glw::GL_UNSIGNED_INT_2_10_10_10_REV] {
            ctx.gl().vertex_attrib_i_pointer(0, 4, ty, 0, std::ptr::null());
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
        let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
        ctx.gl()
            .vertex_attrib_i_pointer(max, 1, glw::GL_BYTE, 0, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if size is not 1, 2, 3, or 4.");
        ctx.gl()
            .vertex_attrib_i_pointer(0, 0, glw::GL_BYTE, 0, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if stride is negative.");
        ctx.gl()
            .vertex_attrib_i_pointer(0, 1, glw::GL_BYTE, -1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated a non-zero vertex array object is bound, zero is bound to the GL_ARRAY_BUFFER buffer object binding point and the pointer argument is not NULL.");
        ctx.gl().bind_vertex_array(vao);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.gl()
            .vertex_attrib_i_pointer(0, 1, glw::GL_BYTE, 0, std::ptr::from_ref(&offset).cast::<c_void>());
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        ctx.gl().bind_vertex_array(0);
        ctx.gl().delete_vertex_arrays(1, &vao);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.end_section();
    }
    Ok(())
}

/// Upstream generates a fresh VAO per section in the two `*_format` cases and never
/// deletes them; this keeps that shape but reuses one name, since the leak is not the
/// point of the test.
fn fresh_vao(ctx: &NegativeTestContext<'_>, bind: bool) -> GLuint {
    let mut vao: GLuint = 0;
    // SAFETY: one name is asked for and one GLuint of output is given.
    unsafe {
        ctx.gl().gen_vertex_arrays(1, &mut vao);
        ctx.gl().bind_vertex_array(if bind { vao } else { 0 });
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }
    vao
}

fn vertex_attrib_format(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_attribs = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let max_offset = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET) as GLuint;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if attribindex is greater than or equal to the value of MAX_VERTEX_ATTRIBS.",
        );
        fresh_vao(ctx, true);
        ctx.gl().vertex_attrib_format(
            max_attribs,
            4,
            glw::GL_FLOAT,
            glw::GL_FALSE as glw::GLboolean,
            max_offset,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if size is not one of 1, 2, 3, 4.");
        fresh_vao(ctx, true);
        ctx.gl()
            .vertex_attrib_format(1, 0, glw::GL_FLOAT, glw::GL_FALSE as glw::GLboolean, max_offset);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the parameter token names allowed.");
        fresh_vao(ctx, true);
        ctx.gl()
            .vertex_attrib_format(1, 4, 1, glw::GL_FALSE as glw::GLboolean, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if type is not a token name allowed.");
        fresh_vao(ctx, false);
        ctx.gl()
            .vertex_attrib_format(1, 4, glw::GL_FLOAT, glw::GL_FALSE as glw::GLboolean, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        for ty in [glw::GL_INT_2_10_10_10_REV, glw::GL_UNSIGNED_INT_2_10_10_10_REV] {
            ctx.begin_section("GL_INVALID_OPERATION is generated if type is GL_INT_2_10_10_10_REV and size is not 4.");
            fresh_vao(ctx, true);
            ctx.gl()
                .vertex_attrib_format(1, 3, ty, glw::GL_FALSE as glw::GLboolean, 0);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();
        }

        ctx.begin_section("GL_INVALID_VALUE is generated if relativeoffset is larger than the value of GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET.");
        fresh_vao(ctx, true);
        ctx.gl()
            .vertex_attrib_format(1, 4, glw::GL_FLOAT, glw::GL_FALSE as glw::GLboolean, max_offset + 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn vertex_attrib_i_format(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_attribs = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;
    let max_offset = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET) as GLuint;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_VALUE is generated if attribindex is greater than or equal to the value of GL_MAX_VERTEX_ATTRIBS.");
        fresh_vao(ctx, true);
        ctx.gl().vertex_attrib_i_format(max_attribs, 4, glw::GL_INT, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if size is not one the values 1, 2, 3, 4.");
        fresh_vao(ctx, true);
        ctx.gl().vertex_attrib_i_format(1, 0, glw::GL_INT, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the parameter token names allowed.");
        fresh_vao(ctx, true);
        ctx.gl().vertex_attrib_i_format(1, 4, glw::GL_FLOAT, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if type is not a token name allowed.");
        fresh_vao(ctx, false);
        ctx.gl().vertex_attrib_i_format(1, 4, glw::GL_INT, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if relativeoffset is larger than the value of GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET.");
        fresh_vao(ctx, true);
        ctx.gl().vertex_attrib_i_format(1, 4, glw::GL_INT, max_offset + 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn enable_vertex_attrib_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;

    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().enable_vertex_attrib_array(max);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn disable_vertex_attrib_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;

    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().disable_vertex_attrib_array(max);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn gen_vertex_arrays(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut arrays: GLuint = 0;

    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above; a rejected count writes nothing.
    unsafe {
        ctx.gl().gen_vertex_arrays(-1, &mut arrays);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn bind_vertex_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section(
        "GL_INVALID_OPERATION is generated if array is not zero or the name of an existing vertex array object.",
    );
    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_vertex_array(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();
    Ok(())
}

fn delete_vertex_arrays(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().delete_vertex_arrays(-1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn vertex_attrib_divisor(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max = ctx.get_integer(glw::GL_MAX_VERTEX_ATTRIBS) as GLuint;

    ctx.begin_section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().vertex_attrib_divisor(max, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

/// The one-byte index array every `draw_elements`-family case passes.
const INDICES: [u8; 1] = [0];

fn indices_ptr() -> *const c_void {
    INDICES.as_ptr().cast::<c_void>()
}

/// The shared body of `draw_arrays` / `draw_arrays_incomplete_primitive`, which differ
/// only in the primitive mode the last two sections use.
fn draw_arrays_body(ctx: &mut NegativeTestContext<'_>, mode: GLenum) {
    // SAFETY: as above; every draw here is rejected before a vertex is fetched.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl().draw_arrays(BAD_ENUM, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count is negative.");
        ctx.gl().draw_arrays(mode, 0, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe { ctx.gl().draw_arrays(mode, 0, 1) };
    });
}

fn draw_arrays(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: the program is this function's own.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_arrays_body(ctx, glw::GL_POINTS);

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_arrays_invalid_program(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    draw_arrays_body(ctx, glw::GL_POINTS);
    Ok(())
}

fn draw_arrays_incomplete_primitive(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_arrays_body(ctx, glw::GL_TRIANGLES);

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

/// The shared body of the three `draw_elements` cases.
fn draw_elements_body(ctx: &mut NegativeTestContext<'_>, mode: GLenum) {
    // SAFETY: as above; the index array is one byte and every call reads one index.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl()
            .draw_elements(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
        ctx.gl().draw_elements(mode, 1, BAD_ENUM, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().draw_elements(mode, 1, glw::GL_FLOAT, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count is negative.");
        ctx.gl().draw_elements(mode, -1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl().draw_elements(mode, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        }
    });
}

fn draw_elements(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_elements_body(ctx, glw::GL_POINTS);
    with_active_transform_feedback(ctx, &program, glw::GL_POINTS, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_elements_invalid_program(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    draw_elements_body(ctx, glw::GL_POINTS);
    Ok(())
}

fn draw_elements_incomplete_primitive(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_elements_body(ctx, glw::GL_TRIANGLES);
    with_active_transform_feedback(ctx, &program, glw::GL_TRIANGLES, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

/// The one-element `GLuint` index array the `*_base_vertex` cases pass.
const UINT_INDICES: [GLuint; 1] = [0];

fn uint_indices_ptr() -> *const c_void {
    UINT_INDICES.as_ptr().cast::<c_void>()
}

fn draw_elements_base_vertex(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl()
            .draw_elements_base_vertex(BAD_ENUM, 1, glw::GL_UNSIGNED_INT, uint_indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
        ctx.gl()
            .draw_elements_base_vertex(glw::GL_POINTS, 1, BAD_ENUM, uint_indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .draw_elements_base_vertex(glw::GL_POINTS, 1, glw::GL_FLOAT, uint_indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count is negative.");
        ctx.gl()
            .draw_elements_base_vertex(glw::GL_POINTS, -1, glw::GL_UNSIGNED_INT, uint_indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements_base_vertex(glw::GL_POINTS, 1, glw::GL_UNSIGNED_INT, uint_indices_ptr(), 1);
        }
    });
    Ok(())
}

fn draw_elements_base_vertex_primitive_mode_mismatch(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let program = geometry_program(ctx);

    ctx.begin_section("GL_INVALID_OPERATION is generated if a geometry shader is active and mode is incompatible with the input primitive type of the geometry shader in the currently installed program object.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().use_program(program.program());
        ctx.gl()
            .draw_elements_base_vertex(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_INT, uint_indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().use_program(0);
    }
    Ok(())
}

/// The shared body of the three `draw_arrays_instanced` cases.
fn draw_arrays_instanced_body(ctx: &mut NegativeTestContext<'_>, mode: GLenum) {
    // SAFETY: as above.
    unsafe {
        ctx.gl().vertex_attrib_divisor(0, 1);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl().draw_arrays_instanced(BAD_ENUM, 0, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count or primcount are negative.");
        ctx.gl().draw_arrays_instanced(mode, 0, -1, 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().draw_arrays_instanced(mode, 0, 1, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe { ctx.gl().draw_arrays_instanced(mode, 0, 1, 1) };
    });
}

fn draw_arrays_instanced(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_arrays_instanced_body(ctx, glw::GL_POINTS);

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_arrays_instanced_invalid_program(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    draw_arrays_instanced_body(ctx, glw::GL_POINTS);
    Ok(())
}

fn draw_arrays_instanced_incomplete_primitive(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // \note upstream builds the program here but never installs it, so the draws below run
    // against whatever program was left current.
    let _program = draw_program(ctx);
    draw_arrays_instanced_body(ctx, glw::GL_TRIANGLES);

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

/// The shared body of the three `draw_elements_instanced` cases.
fn draw_elements_instanced_body(ctx: &mut NegativeTestContext<'_>, mode: GLenum) {
    // SAFETY: as above.
    unsafe {
        ctx.gl().vertex_attrib_divisor(0, 1);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl()
            .draw_elements_instanced(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
        ctx.gl().draw_elements_instanced(mode, 1, BAD_ENUM, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .draw_elements_instanced(mode, 1, glw::GL_FLOAT, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count or primcount are negative.");
        ctx.gl()
            .draw_elements_instanced(mode, -1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl()
            .draw_elements_instanced(mode, 11, glw::GL_UNSIGNED_BYTE, indices_ptr(), -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements_instanced(mode, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        }
    });
}

fn draw_elements_instanced(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };

    draw_elements_instanced_body(ctx, glw::GL_POINTS);
    with_active_transform_feedback(ctx, &program, glw::GL_POINTS, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements_instanced(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_elements_instanced_invalid_program(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    draw_elements_instanced_body(ctx, glw::GL_POINTS);
    Ok(())
}

fn draw_elements_instanced_incomplete_primitive(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };

    draw_elements_instanced_body(ctx, glw::GL_TRIANGLES);
    with_active_transform_feedback(ctx, &program, glw::GL_TRIANGLES, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements_instanced(glw::GL_TRIANGLES, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_elements_instanced_base_vertex(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let program = draw_program(ctx);

    // SAFETY: as above.
    unsafe {
        ctx.gl().use_program(program.program());
        ctx.gl().vertex_attrib_divisor(0, 1);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl()
            .draw_elements_instanced_base_vertex(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
        ctx.gl()
            .draw_elements_instanced_base_vertex(glw::GL_POINTS, 1, BAD_ENUM, indices_ptr(), 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .draw_elements_instanced_base_vertex(glw::GL_POINTS, 1, glw::GL_FLOAT, indices_ptr(), 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count or primcount are negative.");
        ctx.gl()
            .draw_elements_instanced_base_vertex(glw::GL_POINTS, -1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1, 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl()
            .draw_elements_instanced_base_vertex(glw::GL_POINTS, 11, glw::GL_UNSIGNED_BYTE, indices_ptr(), -1, 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_elements_instanced_base_vertex(glw::GL_POINTS, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1, 1);
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_elements_instanced_base_vertex_primitive_mode_mismatch(
    ctx: &mut NegativeTestContext<'_>,
) -> Result<(), TestError> {
    check_support(ctx)?;
    let program = geometry_program(ctx);

    ctx.begin_section("GL_INVALID_OPERATION is generated if a geometry shader is active and mode is incompatible with the input primitive type of the geometry shader in the currently installed program object.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().use_program(program.program());
        ctx.gl().draw_elements_instanced_base_vertex(
            glw::GL_TRIANGLES,
            1,
            glw::GL_UNSIGNED_INT,
            uint_indices_ptr(),
            1,
            1,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().use_program(0);
    }
    Ok(())
}

/// The shared body of the three `draw_range_elements` cases.
fn draw_range_elements_body(ctx: &mut NegativeTestContext<'_>, mode: GLenum) {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl()
            .draw_range_elements(BAD_ENUM, 0, 1, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
        ctx.gl().draw_range_elements(mode, 0, 1, 1, BAD_ENUM, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .draw_range_elements(mode, 0, 1, 1, glw::GL_FLOAT, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count is negative.");
        ctx.gl()
            .draw_range_elements(mode, 0, 1, -1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if end < start.");
        ctx.gl()
            .draw_range_elements(mode, 1, 0, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_range_elements(mode, 0, 1, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        }
    });
}

fn draw_range_elements(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_range_elements_body(ctx, glw::GL_POINTS);
    with_active_transform_feedback(ctx, &program, glw::GL_POINTS, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_range_elements(glw::GL_POINTS, 0, 1, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_range_elements_invalid_program(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    draw_range_elements_body(ctx, glw::GL_POINTS);
    Ok(())
}

fn draw_range_elements_incomplete_primitive(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = draw_program(ctx);
    // SAFETY: as above.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    draw_range_elements_body(ctx, glw::GL_TRIANGLES);
    with_active_transform_feedback(ctx, &program, glw::GL_TRIANGLES, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_range_elements(glw::GL_TRIANGLES, 0, 1, 1, glw::GL_UNSIGNED_BYTE, indices_ptr());
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_range_elements_base_vertex(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let program = draw_program(ctx);

    // SAFETY: as above.
    unsafe {
        ctx.gl().use_program(program.program());
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
        ctx.gl()
            .draw_range_elements_base_vertex(BAD_ENUM, 0, 1, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if type is not one of the accepted values.");
        ctx.gl()
            .draw_range_elements_base_vertex(glw::GL_POINTS, 0, 1, 1, BAD_ENUM, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .draw_range_elements_base_vertex(glw::GL_POINTS, 0, 1, 1, glw::GL_FLOAT, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if count is negative.");
        ctx.gl()
            .draw_range_elements_base_vertex(glw::GL_POINTS, 0, 1, -1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if end < start.");
        ctx.gl()
            .draw_range_elements_base_vertex(glw::GL_POINTS, 1, 0, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    with_incomplete_framebuffer(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .draw_range_elements_base_vertex(glw::GL_POINTS, 0, 1, 1, glw::GL_UNSIGNED_BYTE, indices_ptr(), 1);
        }
    });

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn draw_range_elements_base_vertex_primitive_mode_mismatch(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let program = geometry_program(ctx);

    ctx.begin_section("GL_INVALID_OPERATION is generated if a geometry shader is active and mode is incompatible with the input primitive type of the geometry shader in the currently installed program object.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().use_program(program.program());
        ctx.gl().draw_range_elements_base_vertex(
            glw::GL_TRIANGLES,
            0,
            1,
            1,
            glw::GL_UNSIGNED_INT,
            uint_indices_ptr(),
            1,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().use_program(0);
    }
    Ok(())
}

/// `getNegativeVertexArrayApiTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: vertex_attribf,
        name: "vertex_attribf",
    },
    FunctionContainer {
        function: vertex_attribfv,
        name: "vertex_attribfv",
    },
    FunctionContainer {
        function: vertex_attribi4,
        name: "vertex_attribi4",
    },
    FunctionContainer {
        function: vertex_attribi4v,
        name: "vertex_attribi4v",
    },
    FunctionContainer {
        function: vertex_attrib_pointer,
        name: "vertex_attrib_pointer",
    },
    FunctionContainer {
        function: vertex_attrib_i_pointer,
        name: "vertex_attrib_i_pointer",
    },
    FunctionContainer {
        function: vertex_attrib_format,
        name: "vertex_attrib_format",
    },
    FunctionContainer {
        function: vertex_attrib_i_format,
        name: "vertex_attrib_i_format",
    },
    FunctionContainer {
        function: enable_vertex_attrib_array,
        name: "enable_vertex_attrib_array",
    },
    FunctionContainer {
        function: disable_vertex_attrib_array,
        name: "disable_vertex_attrib_array",
    },
    FunctionContainer {
        function: gen_vertex_arrays,
        name: "gen_vertex_arrays",
    },
    FunctionContainer {
        function: bind_vertex_array,
        name: "bind_vertex_array",
    },
    FunctionContainer {
        function: delete_vertex_arrays,
        name: "delete_vertex_arrays",
    },
    FunctionContainer {
        function: vertex_attrib_divisor,
        name: "vertex_attrib_divisor",
    },
    FunctionContainer {
        function: draw_arrays,
        name: "draw_arrays",
    },
    FunctionContainer {
        function: draw_arrays_invalid_program,
        name: "draw_arrays_invalid_program",
    },
    FunctionContainer {
        function: draw_arrays_incomplete_primitive,
        name: "draw_arrays_incomplete_primitive",
    },
    FunctionContainer {
        function: draw_elements,
        name: "draw_elements",
    },
    FunctionContainer {
        function: draw_elements_base_vertex,
        name: "draw_elements_base_vertex",
    },
    FunctionContainer {
        function: draw_elements_base_vertex_primitive_mode_mismatch,
        name: "draw_elements_base_vertex_primitive_mode_mismatch",
    },
    FunctionContainer {
        function: draw_elements_invalid_program,
        name: "draw_elements_invalid_program",
    },
    FunctionContainer {
        function: draw_elements_incomplete_primitive,
        name: "draw_elements_incomplete_primitive",
    },
    FunctionContainer {
        function: draw_arrays_instanced,
        name: "draw_arrays_instanced",
    },
    FunctionContainer {
        function: draw_arrays_instanced_invalid_program,
        name: "draw_arrays_instanced_invalid_program",
    },
    FunctionContainer {
        function: draw_arrays_instanced_incomplete_primitive,
        name: "draw_arrays_instanced_incomplete_primitive",
    },
    FunctionContainer {
        function: draw_elements_instanced,
        name: "draw_elements_instanced",
    },
    FunctionContainer {
        function: draw_elements_instanced_invalid_program,
        name: "draw_elements_instanced_invalid_program",
    },
    FunctionContainer {
        function: draw_elements_instanced_incomplete_primitive,
        name: "draw_elements_instanced_incomplete_primitive",
    },
    FunctionContainer {
        function: draw_elements_instanced_base_vertex,
        name: "draw_elements_instanced_base_vertex",
    },
    FunctionContainer {
        function: draw_elements_instanced_base_vertex_primitive_mode_mismatch,
        name: "draw_elements_instanced_base_vertex_primitive_mode_mismatch",
    },
    FunctionContainer {
        function: draw_range_elements,
        name: "draw_range_elements",
    },
    FunctionContainer {
        function: draw_range_elements_invalid_program,
        name: "draw_range_elements_invalid_program",
    },
    FunctionContainer {
        function: draw_range_elements_incomplete_primitive,
        name: "draw_range_elements_incomplete_primitive",
    },
    FunctionContainer {
        function: draw_range_elements_base_vertex,
        name: "draw_range_elements_base_vertex",
    },
    FunctionContainer {
        function: draw_range_elements_base_vertex_primitive_mode_mismatch,
        name: "draw_range_elements_base_vertex_primitive_mode_mismatch",
    },
];
