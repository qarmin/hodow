// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeBufferApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `isES` / `isContextTypeGLCore`
// branches are resolved at port time - this port only ever runs an ES context - so the
// desktop-GL arms are gone and the `!isContextTypeGLCore` sections are unconditional.

use std::ffi::c_void;

use crate::gles31::functional::negative_test_shared::{BAD_ENUM, FunctionContainer, NegativeTestContext};
use crate::glw::{self, GLenum, GLfloat, GLint, GLsizei, GLubyte, GLuint};
use crate::tcu::TestError;

/// `deLog2Floor32`
fn log2_floor32(v: i32) -> i32 {
    31 - (v as u32).leading_zeros() as i32
}

/// A 32x32 level 0 of whatever is bound to `GL_TEXTURE_2D`, with no initial data - the shape
/// upstream repeats inline everywhere it reattaches a colour target of a different format.
fn rgba8_2d(ctx: &NegativeTestContext<'_>, internal_format: GLint, format: GLenum, ty: GLenum) {
    // SAFETY: a null `pixels` means "allocate, do not upload", which reads nothing.
    unsafe {
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            internal_format,
            32,
            32,
            0,
            format,
            ty,
            std::ptr::null(),
        );
    }
}

/// `TCU_CHECK`
fn tcu_check(condition: bool, what: &str) -> Result<(), TestError> {
    if condition {
        Ok(())
    } else {
        Err(TestError::Fail(what.to_string()))
    }
}

// Buffers

fn bind_buffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the allowable values.");
    // SAFETY: every call in this file is deliberately invalid; a conformant driver
    // raises an error and changes nothing, which is exactly what is being checked.
    unsafe {
        ctx.gl().bind_buffer(BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn delete_buffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above; a rejected count never reads the null array.
    unsafe {
        ctx.gl().delete_buffers(-1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn gen_buffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(-1, std::ptr::null_mut());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn buffer_data(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buffer: GLuint = 0;

    // SAFETY: as above; the buffer is this function's own and is deleted at the end.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buffer);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER.");
        ctx.gl().buffer_data(BAD_ENUM, 0, std::ptr::null(), glw::GL_STREAM_DRAW);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_ENUM is generated if usage is not GL_STREAM_DRAW, GL_STATIC_DRAW, or GL_DYNAMIC_DRAW.",
        );
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 0, std::ptr::null(), BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if size is negative.");
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, -1, std::ptr::null(), glw::GL_STREAM_DRAW);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 0, std::ptr::null(), glw::GL_STREAM_DRAW);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buffer);
    }
    Ok(())
}

fn buffer_sub_data(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buffer: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buffer);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 10, std::ptr::null(), glw::GL_STREAM_DRAW);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER.");
        ctx.gl().buffer_sub_data(BAD_ENUM, 1, 1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.gl().buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, 1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the buffer object being updated is mapped.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 5, glw::GL_MAP_READ_BIT);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, 1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buffer);
    }
    Ok(())
}

fn buffer_sub_data_size_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buffer: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buffer);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 10, std::ptr::null(), glw::GL_STREAM_DRAW);

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if offset or size is negative, or if together they define a region of memory that extends beyond the buffer object's allocated data store.",
        );
        for (offset, size) in [(-1, 1), (-1, -1), (1, -1), (15, 1), (1, 15), (8, 8)] {
            ctx.gl()
                .buffer_sub_data(glw::GL_ARRAY_BUFFER, offset, size, std::ptr::null());
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buffer);
    }
    Ok(())
}

fn clear(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if any bit other than the three defined bits is set in mask.");
    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        ctx.expect_error(glw::GL_NO_ERROR);
        for mask in [0x0000_0200, 0x0000_1000, 0x0000_0010] {
            ctx.gl().clear(mask);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }
    ctx.end_section();
    Ok(())
}

fn read_pixels(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut ubyte_data = [0 as GLubyte; 4];
    let mut fbo: GLuint = 0;

    // SAFETY: as above; every accepted read below is one RGBA8 pixel, which fits the
    // four-byte destination. The rejected ones write nothing.
    unsafe {
        let dst = ubyte_data.as_mut_ptr().cast::<c_void>();

        ctx.begin_section("Unsupported combinations of format and type will generate an GL_INVALID_OPERATION error.");
        ctx.gl()
            .read_pixels(0, 0, 1, 1, glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_SHORT_4_4_4_4, dst);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if either width or height is negative.");
        for (w, h) in [(-1, 1), (1, -1), (-1, -1)] {
            ctx.gl()
                .read_pixels(0, 0, w, h, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, dst);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.gl()
            .read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, dst);
        ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        ctx.end_section();

        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

fn readn_pixels(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !ctx.context_supports(3, 2)
        && !ctx.is_extension_supported("GL_KHR_robustness")
        && !ctx.is_extension_supported("GL_EXT_robustness")
    {
        return Err(TestError::NotSupported(
            "GLES 3.2 or robustness extension not supported".to_string(),
        ));
    }

    let mut float_data = [0.0 as GLfloat; 4];
    let mut ubyte_data = [0 as GLubyte; 4];
    let mut fbo: GLuint = 0;

    // SAFETY: as above, and every call passes its destination's own length as bufSize,
    // which is what makes the deliberately oversized reads safe.
    unsafe {
        let ubyte_len = ubyte_data.len() as GLsizei;
        let float_len = float_data.len() as GLsizei;
        let ubyte_dst = ubyte_data.as_mut_ptr().cast::<c_void>();
        let float_dst = float_data.as_mut_ptr().cast::<c_void>();

        ctx.begin_section("Unsupported combinations of format and type will generate an GL_INVALID_OPERATION error.");
        ctx.gl().readn_pixels(
            0,
            0,
            1,
            1,
            glw::GL_LUMINANCE_ALPHA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            ubyte_len,
            ubyte_dst,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if either width or height is negative.");
        for (w, h) in [(-1, 1), (1, -1), (-1, -1)] {
            ctx.gl()
                .readn_pixels(0, 0, w, h, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_len, ubyte_dst);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated by ReadnPixels if the buffer size required to store the requested data is larger than bufSize.");
        ctx.gl().readn_pixels(
            0,
            0,
            0x1234,
            0x1234,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            ubyte_len,
            ubyte_dst,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .readn_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, float_len, float_dst);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.gl()
            .readn_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_len, ubyte_dst);
        ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        ctx.end_section();

        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

fn read_pixels_format_mismatch(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut ubyte_data = [0 as GLubyte; 4];
    let mut ushort_data = [0u16; 4];
    let mut read_format: GLint = 0;
    let mut read_type: GLint = 0;

    // SAFETY: as above; the accepted reads are one pixel wide and both destinations hold
    // four components.
    unsafe {
        let ubyte_dst = ubyte_data.as_mut_ptr().cast::<c_void>();
        let ushort_dst = ushort_data.as_mut_ptr().cast::<c_void>();

        ctx.begin_section("Unsupported combinations of format and type will generate an GL_INVALID_OPERATION error.");
        for ty in [
            glw::GL_UNSIGNED_SHORT_5_6_5,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
        ] {
            ctx.gl().read_pixels(0, 0, 1, 1, glw::GL_ALPHA, ty, ushort_dst);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.begin_section("Unsupported combinations of format and type will generate an GL_INVALID_OPERATION error.");
        ctx.gl()
            .read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_6_5, ushort_dst);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .read_pixels(0, 0, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4, ushort_dst);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .read_pixels(0, 0, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1, ushort_dst);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_RGBA/GL_UNSIGNED_BYTE is always accepted and the other acceptable pair can be discovered by querying GL_IMPLEMENTATION_COLOR_READ_FORMAT and GL_IMPLEMENTATION_COLOR_READ_TYPE.");
        ctx.gl()
            .read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_dst);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &mut read_format);
        ctx.gl()
            .get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &mut read_type);
        ctx.gl()
            .read_pixels(0, 0, 1, 1, read_format as GLenum, read_type as GLenum, ubyte_dst);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.end_section();
    }
    Ok(())
}

fn read_pixels_fbo_format_mismatch(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut ubyte_data = [0 as GLubyte; 4];
    let mut float_data = [0.0 as GLfloat; 4];
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let color_buffer_float = ctx.context_supports(3, 2) || ctx.is_extension_supported("GL_EXT_color_buffer_float");

    // SAFETY: as above; every read is one RGBA pixel and both destinations hold four
    // components of the widest type asked for.
    unsafe {
        let ubyte_dst = ubyte_data.as_mut_ptr().cast::<c_void>();
        let float_dst = float_data.as_mut_ptr().cast::<c_void>();

        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if currently bound framebuffer format is incompatible with format and type.");

        for (internal, format, ty) in [
            (glw::GL_RGBA as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
            (glw::GL_RGBA32I as GLint, glw::GL_RGBA_INTEGER, glw::GL_INT),
            (glw::GL_RGBA32UI as GLint, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT),
        ] {
            ctx.gl()
                .tex_image_2d(glw::GL_TEXTURE_2D, 0, internal, 32, 32, 0, format, ty, std::ptr::null());
            ctx.gl().framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture,
                0,
            );
            let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
            ctx.expect_error(glw::GL_NO_ERROR);
            ctx.gl().read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, float_dst);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }

        if color_buffer_float {
            ctx.gl().tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32F as GLint,
                32,
                32,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null(),
            );
            ctx.expect_error(glw::GL_NO_ERROR);
            ctx.gl().framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture,
                0,
            );
            let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
            ctx.expect_error(glw::GL_NO_ERROR);
            ctx.gl().read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_INT, float_dst);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }

        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if GL_READ_FRAMEBUFFER_BINDING is non-zero, the read framebuffer is complete, and the value of GL_SAMPLE_BUFFERS for the read framebuffer is greater than zero.");

        let mut binding: GLint = -1;
        let mut sample_buffers: GLint = 0;
        let mut rbo: GLuint = 0;

        ctx.gl().gen_renderbuffers(1, &mut rbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        ctx.gl()
            .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_RGBA8, 32, 32);
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo,
        );

        ctx.gl().get_integerv(glw::GL_READ_FRAMEBUFFER_BINDING, &mut binding);
        log::debug!("// GL_READ_FRAMEBUFFER_BINDING: {binding}");
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.gl().get_integerv(glw::GL_SAMPLE_BUFFERS, &mut sample_buffers);
        log::debug!("// GL_SAMPLE_BUFFERS: {sample_buffers}");
        ctx.expect_error(glw::GL_NO_ERROR);

        if binding == 0 || sample_buffers <= 0 {
            log::debug!(
                "// ERROR: expected GL_READ_FRAMEBUFFER_BINDING to be non-zero and GL_SAMPLE_BUFFERS to be greater than zero"
            );
            ctx.fail("Got invalid value");
        } else {
            ctx.gl()
                .read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_dst);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }

        ctx.end_section();

        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, 0);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_textures(1, &texture);
        ctx.gl().delete_renderbuffers(1, &rbo);
    }
    Ok(())
}

fn bind_buffer_range(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf_ac: GLuint = 0;
    let mut buf_u: GLuint = 0;
    let mut buf_tf: GLuint = 0;
    let mut max_tf_size: GLint = 0;
    let mut max_u_size: GLint = 0;
    let mut u_alignment: GLint = 0;

    // SAFETY: as above; the three buffers are this function's own.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf_u);
        ctx.gl().bind_buffer(glw::GL_UNIFORM_BUFFER, buf_u);
        ctx.gl()
            .buffer_data(glw::GL_UNIFORM_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);

        ctx.gl().gen_buffers(1, &mut buf_tf);
        ctx.gl().bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf_tf);
        ctx.gl().buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            16,
            std::ptr::null(),
            glw::GL_STREAM_DRAW,
        );

        ctx.gl().gen_buffers(1, &mut buf_ac);
        ctx.gl().bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buf_ac);
        ctx.gl()
            .buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_ATOMIC_COUNTER_BUFFER, GL_SHADER_STORAGE_BUFFER, GL_TRANSFORM_FEEDBACK_BUFFER or GL_UNIFORM_BUFFER.");
        ctx.gl().bind_buffer_range(glw::GL_ARRAY_BUFFER, 0, buf_u, 0, 4);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if target is GL_TRANSFORM_FEEDBACK_BUFFER and index is greater than or equal to GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.",
        );
        ctx.gl()
            .get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut max_tf_size);
        ctx.gl()
            .bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, max_tf_size as GLuint, buf_tf, 0, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if target is GL_UNIFORM_BUFFER and index is greater than or equal to GL_MAX_UNIFORM_BUFFER_BINDINGS.");
        ctx.gl()
            .get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_u_size);
        ctx.gl()
            .bind_buffer_range(glw::GL_UNIFORM_BUFFER, max_u_size as GLuint, buf_u, 0, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if size is less than or equal to zero.");
        ctx.gl().bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, 0, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, 0, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if offset is less than zero.");
        ctx.gl().bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, -1, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if target is GL_TRANSFORM_FEEDBACK_BUFFER and size or offset are not multiples of 4.");
        for (offset, size) in [(4, 5), (5, 4), (5, 7)] {
            ctx.gl()
                .bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf_tf, offset, size);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if target is GL_UNIFORM_BUFFER and offset is not a multiple of GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT.");
        ctx.gl()
            .get_integerv(glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT, &mut u_alignment);
        ctx.gl()
            .bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, (u_alignment + 1) as isize, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        let mut max_ac_size: GLint = 0;
        let mut max_s_size: GLint = 0;
        let mut ss_alignment: GLint = 0;

        ctx.begin_section("GL_INVALID_VALUE is generated if target is GL_ATOMIC_COUNTER_BUFFER and index is greater than or equal to GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS.");
        ctx.gl()
            .get_integerv(glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS, &mut max_ac_size);
        ctx.gl()
            .bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, max_ac_size as GLuint, buf_u, 0, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if target is GL_SHADER_STORAGE_BUFFER and index is greater than or equal to GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS.");
        ctx.gl()
            .get_integerv(glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS, &mut max_s_size);
        ctx.gl()
            .bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, max_s_size as GLuint, buf_u, 0, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if target is GL_ATOMIC_COUNTER_BUFFER and offset is not multiples of 4.",
        );
        ctx.gl()
            .bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, buf_tf, 5, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl()
            .get_integerv(glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT, &mut ss_alignment);

        if ss_alignment != 1 {
            ctx.begin_section(
                "GL_INVALID_VALUE is generated if target is GL_SHADER_STORAGE_BUFFER and offset is not a multiple of the value of GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT.",
            );
            ctx.gl()
                .bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, buf_tf, (ss_alignment + 1) as isize, 4);
            ctx.expect_error(glw::GL_INVALID_VALUE);
            ctx.end_section();
        }

        ctx.gl().delete_buffers(1, &buf_u);
        ctx.gl().delete_buffers(1, &buf_tf);
        ctx.gl().delete_buffers(1, &buf_ac);
    }
    Ok(())
}

fn bind_buffer_base(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf_u: GLuint = 0;
    let mut buf_tf: GLuint = 0;
    let mut max_u_size: GLint = 0;
    let mut max_tf_size: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf_u);
        ctx.gl().bind_buffer(glw::GL_UNIFORM_BUFFER, buf_u);
        ctx.gl()
            .buffer_data(glw::GL_UNIFORM_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);

        ctx.gl().gen_buffers(1, &mut buf_tf);
        ctx.gl().bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf_tf);
        ctx.gl().buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            16,
            std::ptr::null(),
            glw::GL_STREAM_DRAW,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_ATOMIC_COUNTER_BUFFER, GL_SHADER_STORAGE_BUFFER, GL_TRANSFORM_FEEDBACK_BUFFER or GL_UNIFORM_BUFFER.");
        ctx.gl().bind_buffer_base(BAD_ENUM, 0, buf_u);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_buffer_base(glw::GL_ARRAY_BUFFER, 0, buf_u);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if target is GL_UNIFORM_BUFFER and index is greater than or equal to GL_MAX_UNIFORM_BUFFER_BINDINGS.");
        ctx.gl()
            .get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_u_size);
        ctx.gl()
            .bind_buffer_base(glw::GL_UNIFORM_BUFFER, max_u_size as GLuint, buf_u);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if target is GL_TRANSFORM_FEEDBACK_BUFFER andindex is greater than or equal to GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.",
        );
        ctx.gl()
            .get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut max_tf_size);
        ctx.gl()
            .bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, max_tf_size as GLuint, buf_tf);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf_u);
        ctx.gl().delete_buffers(1, &buf_tf);
    }
    Ok(())
}

/// The three integer/unsigned/float `glClearBuffer*v` cases share their setup: an FBO with
/// one colour attachment of the matching class.
fn with_clear_buffer_fbo(
    ctx: &mut NegativeTestContext<'_>,
    internal_format: GLint,
    format: GLenum,
    ty: GLenum,
    body: impl FnOnce(&mut NegativeTestContext<'_>, GLint),
) {
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let mut max_draw_buffers: GLint = 0;

    // SAFETY: as above; the texture and framebuffer are this function's own.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            internal_format,
            32,
            32,
            0,
            format,
            ty,
            std::ptr::null(),
        );
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers);
    }

    body(ctx, max_draw_buffers);

    // SAFETY: as above.
    unsafe {
        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_textures(1, &texture);
    }
}

fn clear_bufferiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let data = [0 as GLint; 32 * 32];

    with_clear_buffer_fbo(
        ctx,
        glw::GL_RGBA32I as GLint,
        glw::GL_RGBA_INTEGER,
        glw::GL_INT,
        |ctx, max_draw_buffers| {
            // SAFETY: as above; `data` is 1024 elements, far more than the four any clear reads.
            unsafe {
                ctx.begin_section("GL_INVALID_ENUM is generated if buffer is not an accepted value.");
                ctx.gl().clear_bufferiv(BAD_ENUM, 0, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.gl().clear_bufferiv(glw::GL_FRAMEBUFFER, 0, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_ENUM is generated if buffer is GL_DEPTH or GL_DEPTH_STENCIL.");
                ctx.gl().clear_bufferiv(glw::GL_DEPTH, 1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.gl().clear_bufferiv(glw::GL_DEPTH_STENCIL, 1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_COLOR or GL_STENCIL and drawBuffer is greater than or equal to GL_MAX_DRAW_BUFFERS.");
                ctx.gl().clear_bufferiv(glw::GL_COLOR, max_draw_buffers, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();

                ctx.begin_section(
                    "GL_INVALID_VALUE is generated if buffer is GL_COLOR or GL_STENCIL and drawBuffer is negative.",
                );
                ctx.gl().clear_bufferiv(glw::GL_COLOR, -1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_STENCIL and drawBuffer is not zero.");
                ctx.gl().clear_bufferiv(glw::GL_STENCIL, 1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();
            }
        },
    );
    Ok(())
}

fn clear_bufferuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let data = [0 as GLuint; 32 * 32];

    with_clear_buffer_fbo(
        ctx,
        glw::GL_RGBA32UI as GLint,
        glw::GL_RGBA_INTEGER,
        glw::GL_UNSIGNED_INT,
        |ctx, max_draw_buffers| {
            // SAFETY: as above.
            unsafe {
                ctx.begin_section("GL_INVALID_ENUM is generated if buffer is not GL_COLOR.");
                ctx.gl().clear_bufferuiv(BAD_ENUM, 0, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.gl().clear_bufferuiv(glw::GL_FRAMEBUFFER, 0, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.end_section();

                ctx.begin_section(
                    "GL_INVALID_ENUM is generated if buffer is GL_DEPTH, GL_STENCIL, or GL_DEPTH_STENCIL.",
                );
                for buffer in [glw::GL_DEPTH, glw::GL_STENCIL, glw::GL_DEPTH_STENCIL] {
                    ctx.gl().clear_bufferuiv(buffer, 0, data.as_ptr());
                    ctx.expect_error(glw::GL_INVALID_ENUM);
                }
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_COLOR and drawBuffer is greater than or equal to GL_MAX_DRAW_BUFFERS.");
                ctx.gl().clear_bufferuiv(glw::GL_COLOR, max_draw_buffers, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_COLOR and drawBuffer is negative.");
                ctx.gl().clear_bufferuiv(glw::GL_COLOR, -1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();
            }
        },
    );
    Ok(())
}

fn clear_bufferfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let data = [0.0 as GLfloat; 32 * 32];

    with_clear_buffer_fbo(
        ctx,
        glw::GL_RGBA32F as GLint,
        glw::GL_RGBA,
        glw::GL_FLOAT,
        |ctx, max_draw_buffers| {
            // SAFETY: as above.
            unsafe {
                ctx.begin_section("GL_INVALID_ENUM is generated if buffer is not GL_COLOR or GL_DEPTH.");
                ctx.gl().clear_bufferfv(BAD_ENUM, 0, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.gl().clear_bufferfv(glw::GL_FRAMEBUFFER, 0, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_ENUM is generated if buffer is GL_STENCIL or GL_DEPTH_STENCIL.");
                ctx.gl().clear_bufferfv(glw::GL_STENCIL, 1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.gl().clear_bufferfv(glw::GL_DEPTH_STENCIL, 1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_ENUM);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_COLOR and drawBuffer is greater than or equal to GL_MAX_DRAW_BUFFERS.");
                ctx.gl().clear_bufferfv(glw::GL_COLOR, max_draw_buffers, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_COLOR and drawBuffer is negative.");
                ctx.gl().clear_bufferfv(glw::GL_COLOR, -1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();

                ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_DEPTH and drawBuffer is not zero.");
                ctx.gl().clear_bufferfv(glw::GL_DEPTH, 1, data.as_ptr());
                ctx.expect_error(glw::GL_INVALID_VALUE);
                ctx.end_section();
            }
        },
    );
    Ok(())
}

fn clear_bufferfi(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if buffer is not GL_DEPTH_STENCIL.");
        for buffer in [
            BAD_ENUM,
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH,
            glw::GL_STENCIL,
            glw::GL_COLOR,
        ] {
            ctx.gl().clear_bufferfi(buffer, 0, 1.0, 1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if buffer is GL_DEPTH_STENCIL and drawBuffer is not zero.");
        ctx.gl().clear_bufferfi(glw::GL_DEPTH_STENCIL, 1, 1.0, 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn copy_buffer_sub_data(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf = [0 as GLuint; 2];
    let data = [0.0 as GLfloat; 32 * 32];

    // SAFETY: as above; both buffers get 32 bytes from a 4096-byte source.
    unsafe {
        ctx.gl().gen_buffers(2, buf.as_mut_ptr());
        ctx.gl().bind_buffer(glw::GL_COPY_READ_BUFFER, buf[0]);
        ctx.gl()
            .buffer_data(glw::GL_COPY_READ_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
        ctx.gl().bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[1]);
        ctx.gl().buffer_data(
            glw::GL_COPY_WRITE_BUFFER,
            32,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_VALUE is generated if any of readoffset, writeoffset or size is negative.");
        for (r, w, s) in [(0, 0, -4), (-1, 0, 4), (0, -1, 4)] {
            ctx.gl()
                .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, r, w, s);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if readoffset + size exceeds the size of the buffer object bound to readtarget.");
        for (r, w, s) in [(0, 0, 36), (24, 0, 16), (36, 0, 4)] {
            ctx.gl()
                .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, r, w, s);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if writeoffset + size exceeds the size of the buffer object bound to writetarget.");
        for (r, w, s) in [(0, 0, 36), (0, 24, 16), (0, 36, 4)] {
            ctx.gl()
                .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, r, w, s);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if the same buffer object is bound to both readtarget and writetarget and the ranges [readoffset, readoffset + size) and [writeoffset, writeoffset + size) overlap.");
        ctx.gl().bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[0]);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 16, 4);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 16, 18);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[1]);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if zero is bound to readtarget or writetarget.");
        ctx.gl().bind_buffer(glw::GL_COPY_READ_BUFFER, 0);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        ctx.gl().bind_buffer(glw::GL_COPY_READ_BUFFER, buf[0]);
        ctx.gl().bind_buffer(glw::GL_COPY_WRITE_BUFFER, 0);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        ctx.gl().bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[1]);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the buffer object bound to either readtarget or writetarget is mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_COPY_READ_BUFFER, 0, 4, glw::GL_MAP_READ_BIT);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_COPY_READ_BUFFER);

        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_COPY_WRITE_BUFFER, 0, 4, glw::GL_MAP_READ_BIT);
        ctx.gl()
            .copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_COPY_WRITE_BUFFER);
        ctx.end_section();

        ctx.gl().delete_buffers(2, buf.as_ptr());
    }
    Ok(())
}

fn draw_buffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let mut max_draw_buffers: GLint = 0;
    let mut max_color_attachments: GLint = -1;

    // SAFETY: as above; `values` is sized from GL_MAX_DRAW_BUFFERS, which is what the
    // deliberately oversized `n` below is derived from.
    unsafe {
        ctx.gl()
            .get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments);
        ctx.gl().get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers);

        let mut values = vec![0 as GLenum; (max_draw_buffers + 1) as usize];
        values[0] = glw::GL_NONE;
        values[1] = glw::GL_BACK;
        values[2] = glw::GL_COLOR_ATTACHMENT0;
        values[3] = glw::GL_DEPTH_ATTACHMENT;
        let attachments: [GLenum; 4] = [
            glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as GLenum,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_COLOR_ATTACHMENT1,
            glw::GL_NONE,
        ];

        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if one of the values in bufs is not an accepted value.");
        ctx.gl().draw_buffers(2, values[2..].as_ptr());
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the GL is bound to a draw framebuffer and DrawBuffers is supplied with BACK or COLOR_ATTACHMENTm where m is greater than or equal to the value of MAX_COLOR_ATTACHMENTS.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().draw_buffers(1, values[1..].as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().draw_buffers(4, attachments.as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if the GL is bound to the default framebuffer and n is not 1.",
        );
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().draw_buffers(2, values.as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the GL is bound to the default framebuffer and the value in bufs is one of the GL_COLOR_ATTACHMENTn tokens.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().draw_buffers(1, values[2..].as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the GL is bound to a framebuffer object and the ith buffer listed in bufs is anything other than GL_NONE or GL_COLOR_ATTACHMENTSi.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().draw_buffers(1, values[1..].as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().draw_buffers(4, attachments.as_ptr());
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if n is less than 0 or greater than GL_MAX_DRAW_BUFFERS.");
        ctx.gl().draw_buffers(-1, values[1..].as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().draw_buffers(max_draw_buffers + 1, values.as_ptr());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_textures(1, &texture);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

fn flush_mapped_buffer_range(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf: GLuint = 0;
    let data = [0.0 as GLfloat; 32];

    // SAFETY: as above; the 32-byte store is filled from a 128-byte source.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 32, data.as_ptr().cast(), glw::GL_STATIC_READ);
        let _ = ctx.gl().map_buffer_range(
            glw::GL_ARRAY_BUFFER,
            0,
            16,
            glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted values.");
        ctx.gl().flush_mapped_buffer_range(BAD_ENUM, 0, 16);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if offset or length is negative, or if offset + length exceeds the size of the mapping.");
        for (offset, length) in [(-1, 1), (0, -1), (12, 8), (24, 4), (0, 24)] {
            ctx.gl().flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, offset, length);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if zero is bound to target.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        ctx.gl().flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the buffer bound to target is not mapped, or is mapped without the GL_MAP_FLUSH_EXPLICIT flag.");
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        let _ = ctx.gl().unmap_buffer(glw::GL_ARRAY_BUFFER);
        ctx.gl().flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT);
        ctx.gl().flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        let _ = ctx.gl().unmap_buffer(glw::GL_ARRAY_BUFFER);
        ctx.gl().delete_buffers(1, &buf);
    }
    Ok(())
}

fn map_buffer_range(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf: GLuint = 0;
    let data = [0.0 as GLfloat; 32];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_VALUE is generated if either of offset or length is negative.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, -1, 1, glw::GL_MAP_READ_BIT);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 1, -1, glw::GL_MAP_READ_BIT);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if offset + length is greater than the value of GL_BUFFER_SIZE.",
        );
        for (offset, length) in [(0, 33), (32, 1), (16, 17)] {
            let _ = ctx
                .gl()
                .map_buffer_range(glw::GL_ARRAY_BUFFER, offset, length, glw::GL_MAP_READ_BIT);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if access has any bits set other than those accepted.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | 0x1000);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT | 0x1000);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the buffer is already in a mapped state.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT);
        ctx.expect_error(glw::GL_NO_ERROR);
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 16, 8, glw::GL_MAP_READ_BIT);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_ARRAY_BUFFER);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if neither GL_MAP_READ_BIT or GL_MAP_WRITE_BIT is set.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_INVALIDATE_RANGE_BIT);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if length is 0");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 0, glw::GL_MAP_READ_BIT);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if GL_MAP_READ_BIT is set and any of GL_MAP_INVALIDATE_RANGE_BIT, GL_MAP_INVALIDATE_BUFFER_BIT, or GL_MAP_UNSYNCHRONIZED_BIT is set.");
        for extra in [
            glw::GL_MAP_INVALIDATE_RANGE_BIT,
            glw::GL_MAP_INVALIDATE_BUFFER_BIT,
            glw::GL_MAP_UNSYNCHRONIZED_BIT,
        ] {
            let _ = ctx
                .gl()
                .map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | extra);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if GL_MAP_FLUSH_EXPLICIT_BIT is set and GL_MAP_WRITE_BIT is not set.",
        );
        let _ = ctx.gl().map_buffer_range(
            glw::GL_ARRAY_BUFFER,
            0,
            16,
            glw::GL_MAP_READ_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
    }
    Ok(())
}

fn read_buffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let mut max_color_attachments: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments);
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not GL_BACK, GL_NONE, or GL_COLOR_ATTACHMENTi.");
        ctx.gl().read_buffer(glw::GL_NONE);
        ctx.expect_error(glw::GL_NO_ERROR);
        // \note Spec isn't actually clear here, but it is safe to assume that
        //       GL_DEPTH_ATTACHMENT can't be interpreted as GL_COLOR_ATTACHMENTm
        //       where m = (GL_DEPTH_ATTACHMENT - GL_COLOR_ATTACHMENT0).
        for mode in [
            1,
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0 - 1,
            glw::GL_FRONT,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_STENCIL_ATTACHMENT,
            glw::GL_STENCIL_ATTACHMENT + 1,
            0xffff_ffff,
        ] {
            ctx.gl().read_buffer(mode);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION error is generated if src is GL_BACK or if src is GL_COLOR_ATTACHMENTm where m is greater than or equal to the value of GL_MAX_COLOR_ATTACHMENTS.");
        ctx.gl().read_buffer(glw::GL_BACK);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .read_buffer(glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as GLenum);
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        if (glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as GLenum) < glw::GL_DEPTH_ATTACHMENT - 1 {
            ctx.gl().read_buffer(glw::GL_DEPTH_ATTACHMENT - 1);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the current framebuffer is the default framebuffer and mode is not GL_NONE or GL_BACK.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().read_buffer(glw::GL_COLOR_ATTACHMENT0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the current framebuffer is a named framebuffer and mode is not GL_NONE or GL_COLOR_ATTACHMENTi.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().read_buffer(glw::GL_BACK);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_textures(1, &texture);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

fn unmap_buffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf: GLuint = 0;
    let data = [0.0 as GLfloat; 32];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        ctx.gl()
            .buffer_data(glw::GL_ARRAY_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if the buffer data store is already in an unmapped state.",
        );
        let _ = ctx.gl().unmap_buffer(glw::GL_ARRAY_BUFFER);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
    }
    Ok(())
}

// Framebuffer Objects

fn bind_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section(
        "GL_INVALID_ENUM is generated if target is not GL_DRAW_FRAMEBUFFER, GL_READ_FRAMEBUFFER, or GL_FRAMEBUFFER.",
    );
    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_framebuffer(BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_framebuffer(glw::GL_RENDERBUFFER, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn bind_renderbuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_renderbuffer(BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_renderbuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn check_framebuffer_status(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section(
        "GL_INVALID_ENUM is generated if target is not GL_DRAW_FRAMEBUFFER, GL_READ_FRAMEBUFFER, or GL_FRAMEBUFFER..",
    );
    // SAFETY: as above.
    unsafe {
        let _ = ctx.gl().check_framebuffer_status(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_RENDERBUFFER);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn gen_framebuffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_framebuffers(-1, std::ptr::null_mut());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn gen_renderbuffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_renderbuffers(-1, std::ptr::null_mut());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn delete_framebuffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().delete_framebuffers(-1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn delete_renderbuffers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().delete_renderbuffers(-1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn framebuffer_renderbuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;
    let mut rbo: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().gen_renderbuffers(1, &mut rbo);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_renderbuffer(BAD_ENUM, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if attachment is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, BAD_ENUM, glw::GL_RENDERBUFFER, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if renderbuffertarget is not GL_RENDERBUFFER.");
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        ctx.gl()
            .framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, BAD_ENUM, rbo);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if renderbuffer is neither 0 nor the name of an existing renderbuffer object.");
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            BAD_ENUM,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if zero is bound to target.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl()
            .framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_renderbuffers(1, &rbo);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

fn framebuffer_texture(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !ctx.context_supports(3, 2) {
        return Ok(());
    }

    let mut fbo: GLuint = 0;
    let mut texture = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().gen_textures(2, texture.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        ctx.gl().bind_texture(glw::GL_TEXTURE_BUFFER, texture[1]);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_texture(BAD_ENUM, glw::GL_COLOR_ATTACHMENT0, texture[0], 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if attachment is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_texture(glw::GL_FRAMEBUFFER, BAD_ENUM, texture[0], 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if texture is neither 0 nor the name of an existing texture object.",
        );
        ctx.gl()
            .framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if zero is bound to target.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl()
            .framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated by if texture is a buffer texture.");
        ctx.gl()
            .framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture[1], 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_buffers(2, texture.as_ptr());
    }
    Ok(())
}

fn framebuffer_texture2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;
    let mut tex2d: GLuint = 0;
    let mut tex_cube: GLuint = 0;
    let mut tex2dms: GLuint = 0;
    let mut max_tex_size: GLint = 0;
    let mut max_tex_cube_size: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().gen_textures(1, &mut tex2d);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, tex2d);
        ctx.gl().gen_textures(1, &mut tex_cube);
        ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
        ctx.gl().gen_textures(1, &mut tex2dms);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, tex2dms);
        ctx.gl().get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_tex_size);
        ctx.gl()
            .get_integerv(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE, &mut max_tex_cube_size);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_texture_2d(BAD_ENUM, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if textarget is not an accepted texture target.");
        ctx.gl()
            .framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, BAD_ENUM, tex2d, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if attachment is not an accepted token.");
        ctx.gl()
            .framebuffer_texture_2d(glw::GL_FRAMEBUFFER, BAD_ENUM, glw::GL_TEXTURE_2D, tex2d, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if level is less than 0 or larger than log_2 of maximum texture size.",
        );
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            -1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            log2_floor32(max_tex_size) + 1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex_cube,
            log2_floor32(max_tex_cube_size) + 1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if level is larger than maximum texture size.");
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            max_tex_size + 1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2d,
            -1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            tex_cube,
            max_tex_cube_size + 1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            tex_cube,
            -1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            tex2dms,
            1,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if texture is neither 0 nor the name of an existing texture object.",
        );
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            BAD_ENUM,
            0,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if textarget and texture are not compatible.");
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex2d,
            0,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            tex2d,
            0,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex_cube,
            0,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex2dms,
            0,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().delete_textures(1, &tex2d);
        ctx.gl().delete_textures(1, &tex_cube);
        ctx.gl().delete_textures(1, &tex2dms);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if zero is bound to target.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl()
            .framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        if ctx.context_supports(3, 2) {
            let mut tex_buf: GLuint = 0;
            ctx.begin_section("GL_INVALID_OPERATION error is generated if texture is the name of a buffer texture.");
            ctx.gl().gen_textures(1, &mut tex_buf);
            ctx.gl().bind_texture(glw::GL_TEXTURE_BUFFER, tex_buf);
            ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            ctx.expect_error(glw::GL_NO_ERROR);
            ctx.gl().framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                tex_buf,
                0,
            );
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();
        }

        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

fn renderbuffer_storage(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut rbo: GLuint = 0;
    let mut max_size: GLint = 0;
    let color_buffer_half_float = ctx.is_extension_supported("GL_EXT_color_buffer_half_float");
    let render_snorm = ctx.is_extension_supported("GL_EXT_render_snorm");

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_renderbuffers(1, &mut rbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
        ctx.gl().renderbuffer_storage(BAD_ENUM, glw::GL_RGBA4, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().renderbuffer_storage(glw::GL_FRAMEBUFFER, glw::GL_RGBA4, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if internalformat is not a color-renderable, depth-renderable, or stencil-renderable format.");
        ctx.gl().renderbuffer_storage(glw::GL_RENDERBUFFER, BAD_ENUM, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);

        if !color_buffer_half_float {
            ctx.gl()
                .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGB16F, 1, 1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }

        if !render_snorm {
            ctx.gl()
                .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8_SNORM, 1, 1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than zero.");
        for (w, h) in [(-1, 1), (1, -1), (-1, -1)] {
            ctx.gl().renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, w, h);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_RENDERBUFFER_SIZE.");
        ctx.gl().get_integerv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_size);
        for (w, h) in [(1, max_size + 1), (max_size + 1, 1), (max_size + 1, max_size + 1)] {
            ctx.gl().renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, w, h);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.gl().delete_renderbuffers(1, &rbo);
    }
    Ok(())
}

fn blit_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo = [0 as GLuint; 2];
    let mut rbo = [0 as GLuint; 2];
    let mut texture = [0 as GLuint; 2];
    let mut blank_framebuffer: GLuint = 0;

    // SAFETY: as above; every object below is this function's own and is deleted at the end.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut blank_framebuffer);
        ctx.gl().gen_framebuffers(2, fbo.as_mut_ptr());
        ctx.gl().gen_textures(2, texture.as_mut_ptr());
        ctx.gl().gen_renderbuffers(2, rbo.as_mut_ptr());

        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]);
        ctx.gl().bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo[0]);

        rgba8_2d(ctx, glw::GL_RGBA8 as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
        ctx.gl()
            .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 32, 32);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture[0],
            0,
        );
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[0],
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_READ_FRAMEBUFFER);

        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[1]);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]);
        ctx.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[1]);

        rgba8_2d(ctx, glw::GL_RGBA8 as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
        ctx.gl()
            .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 32, 32);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture[1],
            0,
        );
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[1],
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_VALUE is generated if mask contains any bits other than GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT, or GL_STENCIL_BUFFER_BIT.");
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, 1, glw::GL_NEAREST);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if filter is not GL_LINEAR or GL_NEAREST.");
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_COLOR_BUFFER_BIT, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if mask contains any of the GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT and filter is not GL_NEAREST.");
        for mask in [
            glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
            glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT,
            glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
        ] {
            ctx.gl()
                .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, mask, glw::GL_LINEAR);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if mask contains GL_COLOR_BUFFER_BIT and read buffer format is incompatible with draw buffer format.");
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[0]);

        for (internal, format, ty, label) in [
            (
                glw::GL_RGBA32UI as GLint,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                "// Read buffer: GL_RGBA32UI, draw buffer: GL_RGBA",
            ),
            (
                glw::GL_RGBA32I as GLint,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                "// Read buffer: GL_RGBA32I, draw buffer: GL_RGBA",
            ),
        ] {
            rgba8_2d(ctx, internal, format, ty);
            ctx.gl().framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture[0],
                0,
            );
            log::debug!("{label}");
            ctx.gl()
                .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_COLOR_BUFFER_BIT, glw::GL_NEAREST);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }

        rgba8_2d(ctx, glw::GL_RGBA8 as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture[0],
            0,
        );
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[1]);
        rgba8_2d(ctx, glw::GL_RGBA32I as GLint, glw::GL_RGBA_INTEGER, glw::GL_INT);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture[1],
            0,
        );
        log::debug!("// Read buffer: GL_RGBA8, draw buffer: GL_RGBA32I");
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_COLOR_BUFFER_BIT, glw::GL_NEAREST);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if filter is GL_LINEAR and the read buffer contains integer data.",
        );
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        rgba8_2d(
            ctx,
            glw::GL_RGBA32UI as GLint,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
        );
        ctx.gl().framebuffer_texture_2d(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture[0],
            0,
        );
        rgba8_2d(ctx, glw::GL_RGBA8 as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture[1],
            0,
        );
        log::debug!("// Read buffer: GL_RGBA32I, draw buffer: GL_RGBA8");
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_COLOR_BUFFER_BIT, glw::GL_LINEAR);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if mask contains GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT and the source and destination depth and stencil formats do not match.");
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]);
        ctx.gl()
            .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH32F_STENCIL8, 32, 32);
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbo[0],
        );
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_DEPTH_BUFFER_BIT, glw::GL_NEAREST);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_STENCIL_BUFFER_BIT, glw::GL_NEAREST);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the read or draw framebuffer is not framebuffer complete.");
        let _ = ctx.gl().check_framebuffer_status(glw::GL_READ_FRAMEBUFFER);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER);
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, 0, glw::GL_NEAREST);
        ctx.expect_error(glw::GL_NO_ERROR);

        for (label, read, draw, read_complete, draw_complete) in [
            ("// incomplete read framebuffer", blank_framebuffer, fbo[1], false, true),
            ("// incomplete draw framebuffer", fbo[1], blank_framebuffer, true, false),
            (
                "// incomplete read and draw framebuffer",
                blank_framebuffer,
                blank_framebuffer,
                false,
                false,
            ),
        ] {
            log::debug!("{label}");
            ctx.gl().bind_framebuffer(glw::GL_READ_FRAMEBUFFER, read);
            ctx.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, draw);
            tcu_check(
                (ctx.gl().check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) == glw::GL_FRAMEBUFFER_COMPLETE)
                    == read_complete,
                "read framebuffer completeness is not what the test set up",
            )?;
            tcu_check(
                (ctx.gl().check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) == glw::GL_FRAMEBUFFER_COMPLETE)
                    == draw_complete,
                "draw framebuffer completeness is not what the test set up",
            )?;
            ctx.gl()
                .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, 0, glw::GL_NEAREST);
            ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        }

        ctx.gl().bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo[0]);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_READ_FRAMEBUFFER);
        ctx.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[1]);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the source and destination buffers are identical.");
        ctx.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[0]);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_DEPTH_BUFFER_BIT, glw::GL_NEAREST);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[1]);
        ctx.end_section();

        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        ctx.gl().delete_framebuffers(2, fbo.as_ptr());
        ctx.gl().delete_framebuffers(1, &blank_framebuffer);
        ctx.gl().delete_textures(2, texture.as_ptr());
        ctx.gl().delete_renderbuffers(2, rbo.as_ptr());
    }
    Ok(())
}

fn blit_framebuffer_multisample(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo = [0 as GLuint; 2];
    let mut rbo = [0 as GLuint; 2];
    let nv_multisample = ctx.is_extension_supported("GL_NV_framebuffer_multisample");

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_framebuffers(2, fbo.as_mut_ptr());
        ctx.gl().gen_renderbuffers(2, rbo.as_mut_ptr());

        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]);
        ctx.gl().bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo[0]);
        ctx.gl()
            .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_RGBA8, 32, 32);
        ctx.gl().framebuffer_renderbuffer(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo[0],
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_READ_FRAMEBUFFER);

        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]);
        ctx.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[1]);

        ctx.expect_error(glw::GL_NO_ERROR);

        if !nv_multisample {
            ctx.begin_section("GL_INVALID_OPERATION is generated if the value of GL_SAMPLE_BUFFERS for the draw buffer is greater than zero.");
            ctx.gl()
                .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_RGBA8, 32, 32);
            ctx.gl().framebuffer_renderbuffer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo[1],
            );
            ctx.gl()
                .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_COLOR_BUFFER_BIT, glw::GL_NEAREST);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.begin_section(
                "GL_INVALID_OPERATION is generated if GL_SAMPLE_BUFFERS for the read buffer is greater than zero and the formats of draw and read buffers are not identical.",
            );
            ctx.gl()
                .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, 32, 32);
            ctx.gl().framebuffer_renderbuffer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo[1],
            );
            ctx.gl()
                .blit_framebuffer(0, 0, 16, 16, 0, 0, 16, 16, glw::GL_COLOR_BUFFER_BIT, glw::GL_NEAREST);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.begin_section("GL_INVALID_OPERATION is generated if GL_SAMPLE_BUFFERS for the read buffer is greater than zero and the source and destination rectangles are not defined with the same (X0, Y0) and (X1, Y1) bounds.");
            ctx.gl()
                .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 32, 32);
            ctx.gl().framebuffer_renderbuffer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo[1],
            );
            ctx.gl()
                .blit_framebuffer(0, 0, 16, 16, 2, 2, 18, 18, glw::GL_COLOR_BUFFER_BIT, glw::GL_NEAREST);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();
        }

        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().delete_renderbuffers(2, rbo.as_ptr());
        ctx.gl().delete_framebuffers(2, fbo.as_ptr());
    }
    Ok(())
}

fn framebuffer_texture_layer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;
    let mut tex3d: GLuint = 0;
    let mut tex2d_array: GLuint = 0;
    let mut tex2d: GLuint = 0;
    let mut max3d_tex_size: GLint = 0;
    let mut max_tex_size: GLint = 0;
    let mut max_array_tex_layers: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().get_integerv(glw::GL_MAX_3D_TEXTURE_SIZE, &mut max3d_tex_size);
        ctx.gl().get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_tex_size);
        ctx.gl()
            .get_integerv(glw::GL_MAX_ARRAY_TEXTURE_LAYERS, &mut max_array_tex_layers);

        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().gen_textures(1, &mut tex3d);
        ctx.gl().gen_textures(1, &mut tex2d_array);
        ctx.gl().gen_textures(1, &mut tex2d);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);

        for (target, texture) in [(glw::GL_TEXTURE_3D, tex3d), (glw::GL_TEXTURE_2D_ARRAY, tex2d_array)] {
            ctx.gl().bind_texture(target, texture);
            ctx.gl().tex_image_3d(
                target,
                0,
                glw::GL_RGBA as GLint,
                4,
                4,
                4,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, tex2d);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );

        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_texture_layer(BAD_ENUM, glw::GL_COLOR_ATTACHMENT0, tex3d, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_RENDERBUFFER, glw::GL_COLOR_ATTACHMENT0, tex3d, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if attachment is not one of the accepted tokens.");
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, BAD_ENUM, tex3d, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_BACK, tex3d, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if texture is non-zero and not the name of a 3D texture or 2D array texture, 2D multisample array texture or cube map array texture.");
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, BAD_ENUM, 0, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex2d, 0, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if texture is not zero and layer is negative.");
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex3d, 0, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if texture is not zero and layer is greater than GL_MAX_3D_TEXTURE_SIZE-1 for a 3D texture.");
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex3d, 0, max3d_tex_size);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if texture is not zero and layer is greater than GL_MAX_ARRAY_TEXTURE_LAYERS-1 for a 2D array texture.");
        ctx.gl().framebuffer_texture_layer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            tex2d_array,
            0,
            max_array_tex_layers,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if zero is bound to target.");
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl()
            .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex3d, 0, 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if texture is a 3D texture and level is less than 0 or greater than log2 of the value of GL_MAX_3D_TEXTURE_SIZE.");
        for level in [-1, log2_floor32(max3d_tex_size) + 1] {
            ctx.gl().framebuffer_texture_layer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                tex3d,
                level,
                max3d_tex_size - 1,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if texture is a 2D array texture and level is less than 0 or greater than log2 of the value of GL_MAX_TEXTURE_SIZE.");
        for level in [-1, log2_floor32(max_tex_size) + 1] {
            ctx.gl().framebuffer_texture_layer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                tex2d_array,
                level,
                max_array_tex_layers - 1,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        if ctx.context_supports(3, 2) {
            let mut tex2dms_array: GLuint = 0;
            let mut tex_cube_array: GLuint = 0;
            let mut tex_buffer: GLuint = 0;
            ctx.gl().gen_textures(1, &mut tex2dms_array);
            ctx.gl().gen_textures(1, &mut tex_cube_array);
            ctx.gl().gen_textures(1, &mut tex_buffer);
            ctx.gl()
                .bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, tex2dms_array);
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, tex_cube_array);
            ctx.gl().bind_texture(glw::GL_TEXTURE_BUFFER, tex_buffer);
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.begin_section(
                "GL_INVALID_VALUE is generated if texture is a 2D multisample array texture and level is not 0.",
            );
            for level in [-1, 1] {
                ctx.gl().framebuffer_texture_layer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    tex2dms_array,
                    level,
                    0,
                );
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
            ctx.end_section();

            ctx.begin_section("GL_INVALID_VALUE is generated if texture is a cube map array texture and layer is larger than MAX_ARRAY_TEXTURE_LAYERS-1. (See Khronos bug 15968)");
            ctx.gl().framebuffer_texture_layer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                tex_cube_array,
                0,
                max_array_tex_layers,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
            ctx.end_section();

            ctx.begin_section("GL_INVALID_OPERATION is generated if texture is the name of a buffer texture.");
            ctx.gl()
                .framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex_buffer, 0, 0);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.gl().delete_textures(1, &tex2dms_array);
            ctx.gl().delete_textures(1, &tex_cube_array);
            ctx.gl().delete_textures(1, &tex_buffer);
        }

        ctx.gl().delete_textures(1, &tex3d);
        ctx.gl().delete_textures(1, &tex2d_array);
        ctx.gl().delete_textures(1, &tex2d);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

/// The shared setup of `invalidate_framebuffer` / `invalidate_sub_framebuffer`: an FBO with
/// one RGBA colour attachment, plus the three attachment names both cases index.
fn with_invalidate_fbo(
    ctx: &mut NegativeTestContext<'_>,
    body: impl FnOnce(&mut NegativeTestContext<'_>, &[GLenum; 3]),
) {
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let mut max_color_attachments: GLint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments);
        let attachments: [GLenum; 3] = [
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as GLenum,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
        ];

        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        rgba8_2d(ctx, glw::GL_RGBA as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);

        body(ctx, &attachments);

        ctx.gl().delete_textures(1, &texture);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
}

fn invalidate_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    with_invalidate_fbo(ctx, |ctx, attachments| {
        // SAFETY: as above; each call names one attachment and passes one element.
        unsafe {
            ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_FRAMEBUFFER, GL_READ_FRAMEBUFFER or GL_DRAW_FRAMEBUFFER.");
            ctx.gl().invalidate_framebuffer(BAD_ENUM, 1, &attachments[0]);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.gl().invalidate_framebuffer(glw::GL_BACK, 1, &attachments[0]);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.end_section();

            ctx.begin_section(
                "GL_INVALID_OPERATION is generated if attachments contains GL_COLOR_ATTACHMENTm and m is greater than or equal to the value of GL_MAX_COLOR_ATTACHMENTS.",
            );
            ctx.gl().invalidate_framebuffer(glw::GL_FRAMEBUFFER, 1, &attachments[1]);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.begin_section("GL_INVALID_VALUE is generated if numAttachments is negative.");
            ctx.gl()
                .invalidate_framebuffer(glw::GL_FRAMEBUFFER, -1, &attachments[0]);
            ctx.expect_error(glw::GL_INVALID_VALUE);
            ctx.end_section();

            ctx.begin_section(
                "GL_INVALID_ENUM is generated if the default framebuffer is bound to target and any elements of attachments are not one of the accepted attachments.",
            );
            ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.gl().invalidate_framebuffer(glw::GL_FRAMEBUFFER, 1, &attachments[2]);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.end_section();
        }
    });
    Ok(())
}

fn invalidate_sub_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    with_invalidate_fbo(ctx, |ctx, attachments| {
        // SAFETY: as above.
        unsafe {
            ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_FRAMEBUFFER, GL_READ_FRAMEBUFFER or GL_DRAW_FRAMEBUFFER.");
            ctx.gl()
                .invalidate_sub_framebuffer(BAD_ENUM, 1, &attachments[0], 0, 0, 16, 16);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.gl()
                .invalidate_sub_framebuffer(glw::GL_BACK, 1, &attachments[0], 0, 0, 16, 16);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.end_section();

            ctx.begin_section(
                "GL_INVALID_OPERATION is generated if attachments contains GL_COLOR_ATTACHMENTm and m is greater than or equal to the value of GL_MAX_COLOR_ATTACHMENTS.",
            );
            ctx.gl()
                .invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, 1, &attachments[1], 0, 0, 16, 16);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.begin_section("GL_INVALID_VALUE is generated if numAttachments, width, or heigh is negative.");
            for (n, w, h) in [
                (-1, 16, 16),
                (-1, -1, 16),
                (-1, 16, -1),
                (-1, -1, -1),
                (1, -1, 16),
                (1, 16, -1),
                (1, -1, -1),
            ] {
                ctx.gl()
                    .invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, n, &attachments[0], 0, 0, w, h);
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
            ctx.end_section();

            ctx.begin_section(
                "GL_INVALID_ENUM is generated if the default framebuffer is bound to target and any elements of attachments are not one of the accepted attachments.",
            );
            ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            ctx.gl()
                .invalidate_sub_framebuffer(glw::GL_FRAMEBUFFER, 1, &attachments[2], 0, 0, 16, 16);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.end_section();
        }
    });
    Ok(())
}

fn renderbuffer_storage_multisample(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut rbo: GLuint = 0;
    let mut max_samples_rgba4: GLint = -1;
    let mut max_samples_rgba8ui: GLint = -1;
    let mut max_size: GLint = 0;
    let color_buffer_half_float = ctx.is_extension_supported("GL_EXT_color_buffer_half_float");
    let render_snorm = ctx.is_extension_supported("GL_EXT_render_snorm");

    // SAFETY: as above; each `get_internalformativ` asks for one value into one slot.
    unsafe {
        ctx.gl().get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_RGBA4,
            glw::GL_SAMPLES,
            1,
            &mut max_samples_rgba4,
        );
        ctx.gl().get_internalformativ(
            glw::GL_RENDERBUFFER,
            glw::GL_RGBA8UI,
            glw::GL_SAMPLES,
            1,
            &mut max_samples_rgba8ui,
        );

        ctx.gl().gen_renderbuffers(1, &mut rbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
        ctx.gl()
            .renderbuffer_storage_multisample(BAD_ENUM, 2, glw::GL_RGBA4, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .renderbuffer_storage_multisample(glw::GL_FRAMEBUFFER, 2, glw::GL_RGBA4, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if samples is greater than the maximum number of samples supported for internalformat.");
        ctx.gl()
            .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, max_samples_rgba4 + 1, glw::GL_RGBA4, 1, 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if internalformat is not a color-renderable, depth-renderable, or stencil-renderable format.");
        ctx.gl()
            .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 2, BAD_ENUM, 1, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);

        if !color_buffer_half_float {
            ctx.gl()
                .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 2, glw::GL_RGB16F, 1, 1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }

        if !render_snorm {
            ctx.gl()
                .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 2, glw::GL_RGBA8_SNORM, 1, 1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if samples is greater than the maximum number of samples supported for internalformat. (Unsigned integer format)");
        ctx.gl()
            .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, max_samples_rgba8ui + 1, glw::GL_RGBA8UI, 1, 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than zero.");
        for (samples, w, h) in [
            (2, -1, 1),
            (2, 1, -1),
            (2, -1, -1),
            (-1, 1, 1),
            (-1, -1, 1),
            (-1, 1, -1),
            (-1, -1, -1),
        ] {
            ctx.gl()
                .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, samples, glw::GL_RGBA4, w, h);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_RENDERBUFFER_SIZE.");
        ctx.gl().get_integerv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_size);
        for (w, h) in [(1, max_size + 1), (max_size + 1, 1), (max_size + 1, max_size + 1)] {
            ctx.gl()
                .renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_RGBA4, w, h);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.gl().delete_renderbuffers(1, &rbo);
    }
    Ok(())
}

/// `glCopyImageSubData` with everything but the two object names and targets fixed at the
/// shape every section below uses.
#[expect(
    clippy::too_many_arguments,
    reason = "mirrors the 15-parameter entry point being tested"
)]
fn copy_image(
    ctx: &NegativeTestContext<'_>,
    src: GLuint,
    src_target: GLenum,
    src_level: GLint,
    dst: GLuint,
    dst_target: GLenum,
    dst_level: GLint,
    w: GLsizei,
    h: GLsizei,
    d: GLsizei,
) {
    // SAFETY: as above.
    unsafe {
        ctx.gl().copy_image_sub_data(
            src, src_target, src_level, 0, 0, 0, dst, dst_target, dst_level, 0, 0, 0, w, h, d,
        );
    }
}

fn copy_image_sub_data(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !ctx.context_supports(3, 2) {
        return Ok(());
    }

    let mut texture = [0 as GLuint; 5];
    let mut rbo: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(5, texture.as_mut_ptr());
        ctx.gl().gen_renderbuffers(1, &mut rbo);
        ctx.gl().bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);

        for name in [texture[0], texture[1]] {
            ctx.gl().bind_texture(glw::GL_TEXTURE_2D, name);
            ctx.gl()
                .tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            ctx.gl()
                .tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            rgba8_2d(ctx, glw::GL_RGBA8 as GLint, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
            if name == texture[0] {
                ctx.gl()
                    .renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 32, 32);
            }
        }
        ctx.expect_error(glw::GL_NO_ERROR);

        // texture[2] is a complete 3D texture, texture[3] deliberately keeps the default
        // mipmap filter and so is incomplete.
        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, texture[2]);
        ctx.gl()
            .tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
        ctx.gl()
            .tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
        ctx.gl().tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8 as GLint,
            32,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, texture[3]);
        ctx.gl().tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8 as GLint,
            32,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[4]);
        ctx.gl()
            .tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
        ctx.gl()
            .tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
        rgba8_2d(ctx, glw::GL_RGBA32F as GLint, glw::GL_RGBA, glw::GL_FLOAT);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_VALUE is generated if srcWidth, srcHeight, or srcDepth is negative.");
        for (w, h, d) in [
            (-1, 1, 1),
            (1, -1, 1),
            (1, 1, -1),
            (-1, -1, 1),
            (-1, 1, -1),
            (1, -1, -1),
            (-1, -1, -1),
        ] {
            copy_image(
                ctx,
                texture[0],
                glw::GL_TEXTURE_2D,
                0,
                texture[1],
                glw::GL_TEXTURE_2D,
                0,
                w,
                h,
                d,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if srcLevel and dstLevel are not valid levels for the corresponding images.",
        );
        for (src_level, dst_level) in [(1, 0), (0, 1), (1, 1), (-1, 0), (0, -1), (-1, -1)] {
            copy_image(
                ctx,
                texture[0],
                glw::GL_TEXTURE_2D,
                src_level,
                texture[1],
                glw::GL_TEXTURE_2D,
                dst_level,
                0,
                0,
                1,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        for level in [-1, 1] {
            copy_image(
                ctx,
                rbo,
                glw::GL_RENDERBUFFER,
                level,
                texture[1],
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                1,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        for level in [-1, 1] {
            copy_image(
                ctx,
                texture[1],
                glw::GL_TEXTURE_2D,
                0,
                rbo,
                glw::GL_RENDERBUFFER,
                level,
                0,
                0,
                1,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        // \note This could be either:
        //       1. GL_INVALID_ENUM if either target does not match the type of the object.
        //       2. GL_INVALID_VALUE if either name does not correspond to a valid renderbuffer
        //          or texture object according to the corresponding target parameter.
        ctx.begin_section("GL_INVALID_ENUM is generated if either target does not match the type of the object.");
        for (src, src_target, dst, dst_target) in [
            (texture[0], glw::GL_TEXTURE_2D, texture[1], glw::GL_TEXTURE_3D),
            (texture[0], glw::GL_TEXTURE_2D, texture[2], glw::GL_TEXTURE_2D),
            (texture[0], glw::GL_TEXTURE_3D, texture[1], glw::GL_TEXTURE_2D),
            (texture[2], glw::GL_TEXTURE_2D, texture[1], glw::GL_TEXTURE_2D),
        ] {
            copy_image(ctx, src, src_target, 0, dst, dst_target, 0, 0, 0, 1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if either object is a texture and the texture is not complete.",
        );
        for (src, src_target, dst, dst_target) in [
            (texture[0], glw::GL_TEXTURE_2D, texture[3], glw::GL_TEXTURE_3D),
            (texture[3], glw::GL_TEXTURE_3D, texture[0], glw::GL_TEXTURE_2D),
            (texture[3], glw::GL_TEXTURE_3D, texture[3], glw::GL_TEXTURE_3D),
        ] {
            copy_image(ctx, src, src_target, 0, dst, dst_target, 0, 0, 0, 1);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if the dimensions of either subregion exceeds the boundaries of the corresponding image object.");
        for (w, h) in [(33, 0), (0, 33)] {
            copy_image(
                ctx,
                texture[0],
                glw::GL_TEXTURE_2D,
                0,
                texture[1],
                glw::GL_TEXTURE_2D,
                0,
                w,
                h,
                1,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION error is generated if the source and destination internal formats are not compatible.");
        for (src, dst) in [(texture[0], texture[4]), (texture[4], texture[0])] {
            copy_image(ctx, src, glw::GL_TEXTURE_2D, 0, dst, glw::GL_TEXTURE_2D, 0, 0, 0, 1);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().delete_textures(5, texture.as_ptr());
        ctx.gl().delete_renderbuffers(1, &rbo);
    }
    Ok(())
}

/// `getNegativeBufferApiTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: bind_buffer,
        name: "bind_buffer",
    },
    FunctionContainer {
        function: delete_buffers,
        name: "delete_buffers",
    },
    FunctionContainer {
        function: gen_buffers,
        name: "gen_buffers",
    },
    FunctionContainer {
        function: buffer_data,
        name: "buffer_data",
    },
    FunctionContainer {
        function: buffer_sub_data,
        name: "buffer_sub_data",
    },
    FunctionContainer {
        function: buffer_sub_data_size_offset,
        name: "buffer_sub_data_size_offset",
    },
    FunctionContainer {
        function: clear,
        name: "clear",
    },
    FunctionContainer {
        function: read_pixels,
        name: "read_pixels",
    },
    FunctionContainer {
        function: readn_pixels,
        name: "readn_pixels",
    },
    FunctionContainer {
        function: read_pixels_format_mismatch,
        name: "read_pixels_format_mismatch",
    },
    FunctionContainer {
        function: read_pixels_fbo_format_mismatch,
        name: "read_pixels_fbo_format_mismatch",
    },
    FunctionContainer {
        function: bind_buffer_range,
        name: "bind_buffer_range",
    },
    FunctionContainer {
        function: bind_buffer_base,
        name: "bind_buffer_base",
    },
    FunctionContainer {
        function: clear_bufferiv,
        name: "clear_bufferiv",
    },
    FunctionContainer {
        function: clear_bufferuiv,
        name: "clear_bufferuiv",
    },
    FunctionContainer {
        function: clear_bufferfv,
        name: "clear_bufferfv",
    },
    FunctionContainer {
        function: clear_bufferfi,
        name: "clear_bufferfi",
    },
    FunctionContainer {
        function: copy_buffer_sub_data,
        name: "copy_buffer_sub_data",
    },
    FunctionContainer {
        function: draw_buffers,
        name: "draw_buffers",
    },
    FunctionContainer {
        function: flush_mapped_buffer_range,
        name: "flush_mapped_buffer_range",
    },
    FunctionContainer {
        function: map_buffer_range,
        name: "map_buffer_range",
    },
    FunctionContainer {
        function: read_buffer,
        name: "read_buffer",
    },
    FunctionContainer {
        function: unmap_buffer,
        name: "unmap_buffer",
    },
    FunctionContainer {
        function: bind_framebuffer,
        name: "bind_framebuffer",
    },
    FunctionContainer {
        function: bind_renderbuffer,
        name: "bind_renderbuffer",
    },
    FunctionContainer {
        function: check_framebuffer_status,
        name: "check_framebuffer_status",
    },
    FunctionContainer {
        function: gen_framebuffers,
        name: "gen_framebuffers",
    },
    FunctionContainer {
        function: gen_renderbuffers,
        name: "gen_renderbuffers",
    },
    FunctionContainer {
        function: delete_framebuffers,
        name: "delete_framebuffers",
    },
    FunctionContainer {
        function: delete_renderbuffers,
        name: "delete_renderbuffers",
    },
    FunctionContainer {
        function: framebuffer_renderbuffer,
        name: "framebuffer_renderbuffer",
    },
    FunctionContainer {
        function: framebuffer_texture,
        name: "framebuffer_texture",
    },
    FunctionContainer {
        function: framebuffer_texture2d,
        name: "framebuffer_texture2d",
    },
    FunctionContainer {
        function: renderbuffer_storage,
        name: "renderbuffer_storage",
    },
    FunctionContainer {
        function: blit_framebuffer,
        name: "blit_framebuffer",
    },
    FunctionContainer {
        function: blit_framebuffer_multisample,
        name: "blit_framebuffer_multisample",
    },
    FunctionContainer {
        function: framebuffer_texture_layer,
        name: "framebuffer_texture_layer",
    },
    FunctionContainer {
        function: invalidate_framebuffer,
        name: "invalidate_framebuffer",
    },
    FunctionContainer {
        function: invalidate_sub_framebuffer,
        name: "invalidate_sub_framebuffer",
    },
    FunctionContainer {
        function: renderbuffer_storage_multisample,
        name: "renderbuffer_storage_multisample",
    },
    FunctionContainer {
        function: copy_image_sub_data,
        name: "copy_image_sub_data",
    },
];
