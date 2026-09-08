// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fNegativeBufferApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES3F_ADD_API_CASE` body is a
// function and the registration is a table of them; see the note in
// `gles2/functional/negative_api/buffer.rs`.
//
// **22 of upstream's 38 cases are here** - `bind_buffer` through `unmap_buffer`, i.e.
// everything before upstream's `// Framebuffer Objects` comment. The 16 after it
// (`bind_framebuffer` .. `renderbuffer_storage_multisample`) are not ported yet.
//
// Upstream's `isES` / `isContextTypeGLCore` branches are resolved here: `ApiType` in
// this port is ES-only by construction (see `Api::gl_api_type`), so `isES` is always
// true and `isContextTypeGLCore` always false, and only those branches are written.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLenum, GLint, GLuint};

// Buffers

fn bind_buffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not one of the allowable values.");
    // SAFETY: a current context; the target is invalid on purpose.
    unsafe { gl.bind_buffer(BAD_ENUM, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn delete_buffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is rejected before the null array is read, which is
    // what upstream relies on here.
    unsafe { gl.delete_buffers(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn gen_buffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.gen_buffers(-1, std::ptr::null_mut()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn buffer_data(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer: GLuint = 0;
    // SAFETY: one name asked for, one GLuint of room; deleted at the end.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER.");
    // SAFETY: a null data pointer with size 0, as upstream passes.
    unsafe { gl.buffer_data(BAD_ENUM, 0, std::ptr::null(), glw::GL_STREAM_DRAW) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if usage is not GL_STREAM_DRAW, GL_STATIC_DRAW, or GL_DYNAMIC_DRAW.");
    // SAFETY: as above.
    unsafe { gl.buffer_data(glw::GL_ARRAY_BUFFER, 0, std::ptr::null(), BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if size is negative.");
    // SAFETY: as above.
    unsafe { gl.buffer_data(glw::GL_ARRAY_BUFFER, -1, std::ptr::null(), glw::GL_STREAM_DRAW) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 0, std::ptr::null(), glw::GL_STREAM_DRAW);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buffer) };
}

fn buffer_sub_data(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer: GLuint = 0;
    // SAFETY: the 10-byte store is left uninitialised on purpose, as upstream does.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 10, std::ptr::null(), glw::GL_STREAM_DRAW);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER.");
    // SAFETY: a null source pointer, as upstream passes; every call here is rejected
    // before it would be read.
    unsafe { gl.buffer_sub_data(BAD_ENUM, 1, 1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, 1, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the buffer object being updated is mapped.");
    // SAFETY: as above; the mapping is left in place, which is the state the error
    // needs, and the buffer is deleted below with it still mapped - GL unmaps it.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 5, glw::GL_MAP_READ_BIT);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, 1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buffer) };
}

fn buffer_sub_data_size_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer: GLuint = 0;
    // SAFETY: as in `buffer_sub_data`.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 10, std::ptr::null(), glw::GL_STREAM_DRAW);
    }

    case.section(
        "GL_INVALID_VALUE is generated if offset or size is negative, or if together they define a region of memory that extends beyond the buffer object's allocated data store.",
    );
    // SAFETY: a null source pointer; every call is rejected for its offset or size.
    unsafe {
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, -1, 1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, -1, -1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, -1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 15, 1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, 15, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 8, 8, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buffer) };
}

fn clear(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if any bit other than the three defined bits is set in mask.");
    // SAFETY: a current context; an undefined mask bit is the error being provoked.
    unsafe {
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        case.expect_error(glw::GL_NO_ERROR);
        gl.clear(0x0000_0200);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.clear(0x0000_1000);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.clear(0x0000_0010);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn read_pixels(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ubyte_data = [0u8; 4];

    case.section("GL_INVALID_OPERATION is generated if the combination of format and type is unsupported.");
    // SAFETY: the destination holds four bytes, which is more than a rejected 1x1 read
    // touches - GL writes nothing at all when it raises an error.
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_SHORT_4_4_4_4, ubyte_data.as_mut_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: as above.
    unsafe {
        gl.read_pixels(0, 0, -1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.read_pixels(0, 0, 1, -1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.read_pixels(0, 0, -1, -1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    let mut fbo: GLuint = 0;
    // SAFETY: the framebuffer is this case's own and is left with no attachment on
    // purpose, which is what makes it incomplete.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_data.as_mut_ptr().cast());
    }
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);

    // SAFETY: the name is this case's own. Note upstream leaves it *bound* here and
    // relies on `glu::resetState` to undo that, which `reset_state_es` also does.
    unsafe { gl.delete_framebuffers(1, &fbo) };
}

fn read_pixels_format_mismatch(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ubyte_data = [0u8; 4];
    let mut ushort_data = [0u16; 4];

    case.section("Unsupported combinations of format and type will generate an INVALID_OPERATION error.");
    // SAFETY: each destination holds four elements of its own type, which is more than
    // a 1x1 read touches; the rejected calls write nothing.
    unsafe {
        gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_6_5, ushort_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.read_pixels(0, 0, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4, ushort_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.read_pixels(0, 0, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1, ushort_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.read_pixels(0, 0, 1, 1, glw::GL_ALPHA, glw::GL_UNSIGNED_SHORT_5_6_5, ushort_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.read_pixels(0, 0, 1, 1, glw::GL_ALPHA, glw::GL_UNSIGNED_SHORT_4_4_4_4, ushort_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.read_pixels(0, 0, 1, 1, glw::GL_ALPHA, glw::GL_UNSIGNED_SHORT_5_5_5_1, ushort_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section(
        "GL_RGBA/GL_UNSIGNED_BYTE is always accepted and the other acceptable pair can be discovered by querying GL_IMPLEMENTATION_COLOR_READ_FORMAT and GL_IMPLEMENTATION_COLOR_READ_TYPE.",
    );
    // SAFETY: the four-byte destination is exactly one RGBA8 pixel; the second read
    // uses the pair the implementation itself named, whose pixel is at most four bytes
    // for any format ES 3.0 may answer with here.
    unsafe {
        gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_NO_ERROR);
        let mut read_format: GLint = 0;
        let mut read_type: GLint = 0;
        gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &mut read_format);
        gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &mut read_type);
        gl.read_pixels(0, 0, 1, 1, read_format as GLenum, read_type as GLenum, ubyte_data.as_mut_ptr().cast());
        case.expect_error(glw::GL_NO_ERROR);
    }
}

fn read_pixels_fbo_format_mismatch(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ubyte_data = [0u8; 4];
    let mut float_data = [0.0f32; 4];
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;

    // SAFETY: every name is this case's own and every texture is left with unspecified
    // contents on purpose, which is what upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
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
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if currently bound framebuffer format is incompatible with format and type.");

    // SAFETY: the float destination holds four f32, one RGBA32F pixel, which is the
    // widest a 1x1 read here can produce; the rejected reads write nothing.
    unsafe {
        gl.tex_image_2d(
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
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, float_data.as_mut_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA32I as GLint,
            32,
            32,
            0,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            std::ptr::null(),
        );
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, float_data.as_mut_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA32UI as GLint,
            32,
            32,
            0,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
            std::ptr::null(),
        );
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, float_data.as_mut_ptr().cast()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section(
        "GL_INVALID_OPERATION is generated if GL_READ_FRAMEBUFFER_BINDING is non-zero, the read framebuffer is complete, and the value of GL_SAMPLE_BUFFERS for the read framebuffer is greater than zero.",
    );

    let mut binding: GLint = -1;
    let mut sample_buffers: GLint = 0;
    let mut rbo: GLuint = 0;

    // SAFETY: the renderbuffer is this case's own; both queries write one integer.
    unsafe {
        gl.gen_renderbuffers(1, &mut rbo);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_RGBA8, 32, 32);
        gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, rbo);

        gl.get_integerv(glw::GL_READ_FRAMEBUFFER_BINDING, &mut binding);
        log::info!("// GL_READ_FRAMEBUFFER_BINDING: {binding}");
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        gl.get_integerv(glw::GL_SAMPLE_BUFFERS, &mut sample_buffers);
        log::info!("// GL_SAMPLE_BUFFERS: {sample_buffers}");
    }
    case.expect_error(glw::GL_NO_ERROR);

    if binding == 0 || sample_buffers <= 0 {
        case.fail(
            "expected GL_READ_FRAMEBUFFER_BINDING to be non-zero and GL_SAMPLE_BUFFERS to be greater than zero".to_string(),
            "Got invalid value",
        );
    } else {
        // SAFETY: as above.
        unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_data.as_mut_ptr().cast()) };
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    // SAFETY: every name below is this case's own.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
        gl.delete_textures(1, &texture);
        gl.delete_renderbuffers(1, &rbo);
    }
}

fn bind_buffer_range(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf_u: GLuint = 0;
    let mut buf_tf: GLuint = 0;
    // SAFETY: both names are this case's own and both stores are left uninitialised on
    // purpose, as upstream does.
    unsafe {
        gl.gen_buffers(1, &mut buf_u);
        gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buf_u);
        gl.buffer_data(glw::GL_UNIFORM_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);

        gl.gen_buffers(1, &mut buf_tf);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf_tf);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_TRANSFORM_FEEDBACK_BUFFER or GL_UNIFORM_BUFFER.");
    // SAFETY: a current context; every call below is expected to be rejected.
    unsafe { gl.bind_buffer_range(glw::GL_ARRAY_BUFFER, 0, buf_u, 0, 4) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if target is GL_TRANSFORM_FEEDBACK_BUFFER and index is greater than or equal to GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.");
    let mut max_tf_size: GLint = 0;
    // SAFETY: one integer of output, then an out-of-range index on purpose.
    unsafe {
        gl.get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut max_tf_size);
        gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, max_tf_size as GLuint, buf_tf, 0, 4);
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if target is GL_UNIFORM_BUFFER and index is greater than or equal to GL_MAX_UNIFORM_BUFFER_BINDINGS.");
    let mut max_u_size: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_u_size);
        gl.bind_buffer_range(glw::GL_UNIFORM_BUFFER, max_u_size as GLuint, buf_u, 0, 4);
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if size is less than or equal to zero.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, 0, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, 0, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if target is GL_TRANSFORM_FEEDBACK_BUFFER and size or offset are not multiples of 4.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf_tf, 4, 5);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf_tf, 5, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf_tf, 5, 7);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if target is GL_UNIFORM_BUFFER and offset is not a multiple of GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT.");
    let mut alignment: GLint = 0;
    // SAFETY: one integer of output.
    unsafe { gl.get_integerv(glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT, &mut alignment) };

    if alignment > 1 {
        // SAFETY: as above.
        unsafe { gl.bind_buffer_range(glw::GL_UNIFORM_BUFFER, 0, buf_u, (alignment + 1) as isize, 4) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf_u);
        gl.delete_buffers(1, &buf_tf);
    }
}

fn bind_buffer_base(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf_u: GLuint = 0;
    let mut buf_tf: GLuint = 0;
    // SAFETY: as in `bind_buffer_range`.
    unsafe {
        gl.gen_buffers(1, &mut buf_u);
        gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buf_u);
        gl.buffer_data(glw::GL_UNIFORM_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);

        gl.gen_buffers(1, &mut buf_tf);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf_tf);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 16, std::ptr::null(), glw::GL_STREAM_DRAW);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if target is not GL_TRANSFORM_FEEDBACK_BUFFER or GL_UNIFORM_BUFFER.");
    // SAFETY: a current context; both calls are expected to be rejected.
    unsafe {
        gl.bind_buffer_base(BAD_ENUM, 0, buf_u);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.bind_buffer_base(glw::GL_ARRAY_BUFFER, 0, buf_u);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if target is GL_UNIFORM_BUFFER and index is greater than or equal to GL_MAX_UNIFORM_BUFFER_BINDINGS.");
    let mut max_u_size: GLint = 0;
    // SAFETY: one integer of output, then an out-of-range index on purpose.
    unsafe {
        gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_u_size);
        gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, max_u_size as GLuint, buf_u);
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if target is GL_TRANSFORM_FEEDBACK_BUFFER andindex is greater than or equal to GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS.");
    let mut max_tf_size: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS, &mut max_tf_size);
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, max_tf_size as GLuint, buf_tf);
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf_u);
        gl.delete_buffers(1, &buf_tf);
    }
}

/// The integer-attachment FBO the three `clear_buffer*v` cases set up, which differ
/// only in the texture's format.
fn setup_clear_buffer_fbo(case: &mut ApiCase<'_>, internal_format: GLenum, format: GLenum, type_: GLenum) -> (GLuint, GLuint) {
    let gl = case.gl();
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    // SAFETY: both names are this case's own; the texture is left with unspecified
    // contents, as upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, internal_format as GLint, 32, 32, 0, format, type_, std::ptr::null());
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);
    (fbo, texture)
}

fn clear_bufferiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = vec![0i32; 32 * 32];
    let (fbo, texture) = setup_clear_buffer_fbo(case, glw::GL_RGBA32I, glw::GL_RGBA_INTEGER, glw::GL_INT);

    case.section("GL_INVALID_ENUM is generated if buffer is not an accepted value.");
    // SAFETY: the value array is far larger than the four components a clear reads.
    unsafe {
        gl.clear_bufferiv(BAD_ENUM, 0, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferiv(glw::GL_FRAMEBUFFER, 0, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section(
        "GL_INVALID_VALUE is generated if buffer is GL_COLOR, GL_FRONT, GL_BACK, GL_LEFT, GL_RIGHT, or GL_FRONT_AND_BACK and drawBuffer is greater than or equal to GL_MAX_DRAW_BUFFERS.",
    );
    let mut max_draw_buffers: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers);
        gl.clear_bufferiv(glw::GL_COLOR, max_draw_buffers, data.as_ptr());
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if buffer is GL_DEPTH or GL_DEPTH_STENCIL.");
    // SAFETY: as above.
    unsafe {
        gl.clear_bufferiv(glw::GL_DEPTH, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferiv(glw::GL_DEPTH_STENCIL, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if buffer is GL_STENCIL and drawBuffer is not zero.");
    // SAFETY: as above.
    unsafe { gl.clear_bufferiv(glw::GL_STENCIL, 1, data.as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_framebuffers(1, &fbo);
        gl.delete_textures(1, &texture);
    }
}

fn clear_bufferuiv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = vec![0u32; 32 * 32];
    let (fbo, texture) = setup_clear_buffer_fbo(case, glw::GL_RGBA32UI, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT);

    case.section("GL_INVALID_ENUM is generated if buffer is not an accepted value.");
    // SAFETY: as in `clear_bufferiv`.
    unsafe {
        gl.clear_bufferuiv(BAD_ENUM, 0, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferuiv(glw::GL_FRAMEBUFFER, 0, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section(
        "GL_INVALID_VALUE is generated if buffer is GL_COLOR, GL_FRONT, GL_BACK, GL_LEFT, GL_RIGHT, or GL_FRONT_AND_BACK and drawBuffer is greater than or equal to GL_MAX_DRAW_BUFFERS.",
    );
    let mut max_draw_buffers: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers);
        gl.clear_bufferuiv(glw::GL_COLOR, max_draw_buffers, data.as_ptr());
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if buffer is GL_DEPTH, GL_STENCIL or GL_DEPTH_STENCIL.");
    // SAFETY: as above.
    unsafe {
        gl.clear_bufferuiv(glw::GL_DEPTH, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferuiv(glw::GL_STENCIL, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferuiv(glw::GL_DEPTH_STENCIL, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_framebuffers(1, &fbo);
        gl.delete_textures(1, &texture);
    }
}

fn clear_bufferfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let data = vec![0.0f32; 32 * 32];
    let (fbo, texture) = setup_clear_buffer_fbo(case, glw::GL_RGBA32F, glw::GL_RGBA, glw::GL_FLOAT);

    case.section("GL_INVALID_ENUM is generated if buffer is not an accepted value.");
    // SAFETY: as in `clear_bufferiv`.
    unsafe {
        gl.clear_bufferfv(BAD_ENUM, 0, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferfv(glw::GL_FRAMEBUFFER, 0, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section(
        "GL_INVALID_VALUE is generated if buffer is GL_COLOR, GL_FRONT, GL_BACK, GL_LEFT, GL_RIGHT, or GL_FRONT_AND_BACK and drawBuffer is greater than or equal to GL_MAX_DRAW_BUFFERS.",
    );
    let mut max_draw_buffers: GLint = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers);
        gl.clear_bufferfv(glw::GL_COLOR, max_draw_buffers, data.as_ptr());
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_ENUM is generated if buffer is GL_STENCIL or GL_DEPTH_STENCIL.");
    // SAFETY: as above.
    unsafe {
        gl.clear_bufferfv(glw::GL_STENCIL, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferfv(glw::GL_DEPTH_STENCIL, 1, data.as_ptr());
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if buffer is GL_DEPTH and drawBuffer is not zero.");
    // SAFETY: as above.
    unsafe { gl.clear_bufferfv(glw::GL_DEPTH, 1, data.as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_framebuffers(1, &fbo);
        gl.delete_textures(1, &texture);
    }
}

fn clear_bufferfi(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if buffer is not an accepted value.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.clear_bufferfi(BAD_ENUM, 0, 1.0, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferfi(glw::GL_FRAMEBUFFER, 0, 1.0, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_ENUM is generated if buffer is not GL_DEPTH_STENCIL.");
    // SAFETY: as above.
    unsafe {
        gl.clear_bufferfi(glw::GL_DEPTH, 0, 1.0, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferfi(glw::GL_STENCIL, 0, 1.0, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.clear_bufferfi(glw::GL_COLOR, 0, 1.0, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if buffer is GL_DEPTH_STENCIL and drawBuffer is not zero.");
    // SAFETY: as above.
    unsafe { gl.clear_bufferfi(glw::GL_DEPTH_STENCIL, 1, 1.0, 1) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn copy_buffer_sub_data(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf = [0u32; 2];
    let data = vec![0.0f32; 32 * 32];

    // SAFETY: both names are this case's own and the 32-byte uploads read from an array
    // far larger than that.
    unsafe {
        gl.gen_buffers(2, buf.as_mut_ptr());
        gl.bind_buffer(glw::GL_COPY_READ_BUFFER, buf[0]);
        gl.buffer_data(glw::GL_COPY_READ_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
        gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[1]);
        gl.buffer_data(glw::GL_COPY_WRITE_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if any of readoffset, writeoffset or size is negative.");
    // SAFETY: a current context; no client pointer is involved in a buffer-to-buffer
    // copy, and every call here is expected to be rejected.
    unsafe {
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, -4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, -1, 0, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, -1, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if readoffset + size exceeds the size of the buffer object bound to readtarget.");
    // SAFETY: as above.
    unsafe {
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 36);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 24, 0, 16);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 36, 0, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if writeoffset + size exceeds the size of the buffer object bound to writetarget.");
    // SAFETY: as above.
    unsafe {
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 36);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 24, 16);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 36, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section(
        "GL_INVALID_VALUE is generated if the same buffer object is bound to both readtarget and writetarget and the ranges [readoffset, readoffset + size) and [writeoffset, writeoffset + size) overlap.",
    );
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[0]);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 16, 4);
        case.expect_error(glw::GL_NO_ERROR);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 16, 18);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[1]);
    }

    case.section("GL_INVALID_OPERATION is generated if zero is bound to readtarget or writetarget.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_COPY_READ_BUFFER, 0);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.bind_buffer(glw::GL_COPY_READ_BUFFER, buf[0]);
        gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, 0);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, buf[1]);
    }

    case.section("GL_INVALID_OPERATION is generated if the buffer object bound to either readtarget or writetarget is mapped.");
    // SAFETY: as above; each mapping is released before the next section.
    unsafe {
        gl.map_buffer_range(glw::GL_COPY_READ_BUFFER, 0, 4, glw::GL_MAP_READ_BIT);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_COPY_READ_BUFFER);

        gl.map_buffer_range(glw::GL_COPY_WRITE_BUFFER, 0, 4, glw::GL_MAP_READ_BIT);
        gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 16);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_COPY_WRITE_BUFFER);
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_buffers(2, buf.as_ptr()) };
}

fn draw_buffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let mut max_draw_buffers: GLint = 0;
    // SAFETY: one integer of output.
    unsafe { gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers) };
    let mut values = vec![0u32; max_draw_buffers as usize + 1];
    values[0] = glw::GL_NONE;
    values[1] = glw::GL_BACK;
    values[2] = glw::GL_COLOR_ATTACHMENT0;
    values[3] = glw::GL_DEPTH_ATTACHMENT;

    // SAFETY: both names are this case's own; the texture is left with unspecified
    // contents, as upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
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
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if one of the values in bufs is not an accepted value.");
    // SAFETY: `values` has MAX_DRAW_BUFFERS + 1 entries, so a two-entry read from
    // index 2 is in bounds (MAX_DRAW_BUFFERS is at least 4 in ES 3.0).
    unsafe { gl.draw_buffers(2, values[2..].as_ptr()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the GL is bound to the default framebuffer and n is not 1.");
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.draw_buffers(2, values.as_ptr());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the GL is bound to the default framebuffer and the value in bufs is one of the GL_COLOR_ATTACHMENTn tokens.");
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.draw_buffers(1, values[2..].as_ptr());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section(
        "GL_INVALID_OPERATION is generated if the GL is bound to a framebuffer object and the ith buffer listed in bufs is anything other than GL_NONE or GL_COLOR_ATTACHMENTSi.",
    );
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.draw_buffers(1, values[1..].as_ptr());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if n is less than 0 or greater than GL_MAX_DRAW_BUFFERS.");
    // SAFETY: the negative count is rejected before anything is read, and the
    // `max_draw_buffers + 1` read is exactly the length of `values`.
    unsafe {
        gl.draw_buffers(-1, values[1..].as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.draw_buffers(max_draw_buffers + 1, values.as_ptr());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_textures(1, &texture);
        gl.delete_framebuffers(1, &fbo);
    }
}

fn flush_mapped_buffer_range(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let data = [0.0f32; 32];

    // SAFETY: the 32-byte upload reads from a 128-byte array.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 32, data.as_ptr().cast(), glw::GL_STATIC_READ);
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if offset or length is negative, or if offset + length exceeds the size of the mapping.");
    // SAFETY: a current context; no client pointer is involved and every call is
    // expected to be rejected.
    unsafe {
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, -1, 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 12, 8);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 24, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 24);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_OPERATION is generated if zero is bound to target.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the buffer bound to target is not mapped, or is mapped without the GL_MAP_FLUSH_EXPLICIT flag.");
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT);
        gl.flush_mapped_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    // SAFETY: the name is this case's own.
    unsafe {
        gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
        gl.delete_buffers(1, &buf);
    }
}

fn map_buffer_range(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let data = [0.0f32; 32];

    // SAFETY: the 32-byte upload reads from a 128-byte array.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if either of offset or length is negative.");
    // SAFETY: a current context; the returned pointer is deliberately ignored, exactly
    // as upstream ignores it, and every rejected call returns null.
    unsafe {
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, -1, 1, glw::GL_MAP_READ_BIT);
        case.expect_error(glw::GL_INVALID_VALUE);

        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 1, -1, glw::GL_MAP_READ_BIT);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if offset + length is greater than the value of GL_BUFFER_SIZE.");
    // SAFETY: as above.
    unsafe {
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 33, glw::GL_MAP_READ_BIT);
        case.expect_error(glw::GL_INVALID_VALUE);

        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 32, 1, glw::GL_MAP_READ_BIT);
        case.expect_error(glw::GL_INVALID_VALUE);

        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 16, 17, glw::GL_MAP_READ_BIT);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if access has any bits set other than those accepted.");
    // SAFETY: as above.
    unsafe {
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | 0x1000);
        case.expect_error(glw::GL_INVALID_VALUE);

        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT | 0x1000);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_OPERATION is generated if the buffer is already in a mapped state.");
    // SAFETY: as above; the successful mapping is released here.
    unsafe {
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_WRITE_BIT);
        case.expect_error(glw::GL_NO_ERROR);
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 16, 8, glw::GL_MAP_READ_BIT);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_ARRAY_BUFFER);
    }

    case.section("GL_INVALID_OPERATION is generated if neither GL_MAP_READ_BIT or GL_MAP_WRITE_BIT is set.");
    // SAFETY: as above.
    unsafe { gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_INVALIDATE_RANGE_BIT) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // Upstream's section description really is truncated here, and it repeats the call
    // above verbatim.
    case.section("GL_INVALID_OPERATION is generated if ");
    // SAFETY: as above.
    unsafe { gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_INVALIDATE_RANGE_BIT) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section(
        "GL_INVALID_OPERATION is generated if GL_MAP_READ_BIT is set and any of GL_MAP_INVALIDATE_RANGE_BIT, GL_MAP_INVALIDATE_BUFFER_BIT, or GL_MAP_UNSYNCHRONIZED_BIT is set.",
    );
    // SAFETY: as above.
    unsafe {
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | glw::GL_MAP_INVALIDATE_RANGE_BIT);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | glw::GL_MAP_INVALIDATE_BUFFER_BIT);
        case.expect_error(glw::GL_INVALID_OPERATION);

        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | glw::GL_MAP_UNSYNCHRONIZED_BIT);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if GL_MAP_FLUSH_EXPLICIT_BIT is set and GL_MAP_WRITE_BIT is not set.");
    // SAFETY: as above.
    unsafe { gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 16, glw::GL_MAP_READ_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buf) };
}

fn read_buffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let mut max_color_attachments: GLint = 0;

    // SAFETY: both names are this case's own; the texture is left with unspecified
    // contents, as upstream's null pointer asks for.
    unsafe {
        gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments);
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
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
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, texture, 0);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if mode is not GL_BACK, GL_NONE, or GL_COLOR_ATTACHMENTi.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.read_buffer(glw::GL_NONE);
        case.expect_error(glw::GL_NO_ERROR);
        gl.read_buffer(1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.read_buffer(glw::GL_FRAMEBUFFER);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 - 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.read_buffer(glw::GL_FRONT);
        case.expect_error(glw::GL_INVALID_ENUM);

        // \note Spec isn't actually clear here, but it is safe to assume that
        //         GL_DEPTH_ATTACHMENT can't be interpreted as GL_COLOR_ATTACHMENTm
        //         where m = (GL_DEPTH_ATTACHMENT - GL_COLOR_ATTACHMENT0).
        gl.read_buffer(glw::GL_DEPTH_ATTACHMENT);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.read_buffer(glw::GL_STENCIL_ATTACHMENT);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.read_buffer(glw::GL_STENCIL_ATTACHMENT + 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.read_buffer(0xffff_ffff);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section(
        "GL_INVALID_OPERATION error is generated if src is GL_BACK or if src is GL_COLOR_ATTACHMENTm where m is greater than or equal to the value of GL_MAX_COLOR_ATTACHMENTS.",
    );
    // SAFETY: as above.
    unsafe {
        gl.read_buffer(glw::GL_BACK);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as GLenum);
        case.expect_error(glw::GL_INVALID_OPERATION);

        if (glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as GLenum) < glw::GL_DEPTH_ATTACHMENT - 1 {
            gl.read_buffer(glw::GL_DEPTH_ATTACHMENT - 1);
            case.expect_error(glw::GL_INVALID_OPERATION);
        }
    }

    case.section("GL_INVALID_OPERATION is generated if the current framebuffer is the default framebuffer and mode is not GL_NONE or GL_BACK.");
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.read_buffer(glw::GL_COLOR_ATTACHMENT0);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the current framebuffer is a named framebuffer and mode is not GL_NONE or GL_COLOR_ATTACHMENTi.");
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.read_buffer(glw::GL_BACK);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_textures(1, &texture);
        gl.delete_framebuffers(1, &fbo);
    }
}

fn unmap_buffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let data = [0.0f32; 32];

    // SAFETY: the 32-byte upload reads from a 128-byte array.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 32, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if the buffer data store is already in an unmapped state.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.unmap_buffer(glw::GL_ARRAY_BUFFER) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buf) };
}

/// `NegativeBufferApiTests::init`, restricted to the 22 ported cases.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("bind_buffer", bind_buffer),
        ("delete_buffers", delete_buffers),
        ("gen_buffers", gen_buffers),
        ("buffer_data", buffer_data),
        ("buffer_sub_data", buffer_sub_data),
        ("buffer_sub_data_size_offset", buffer_sub_data_size_offset),
        ("clear", clear),
        ("read_pixels", read_pixels),
        ("read_pixels_format_mismatch", read_pixels_format_mismatch),
        ("read_pixels_fbo_format_mismatch", read_pixels_fbo_format_mismatch),
        ("bind_buffer_range", bind_buffer_range),
        ("bind_buffer_base", bind_buffer_base),
        ("clear_bufferiv", clear_bufferiv),
        ("clear_bufferuiv", clear_bufferuiv),
        ("clear_bufferfv", clear_bufferfv),
        ("clear_bufferfi", clear_bufferfi),
        ("copy_buffer_sub_data", copy_buffer_sub_data),
        ("draw_buffers", draw_buffers),
        ("flush_mapped_buffer_range", flush_mapped_buffer_range),
        ("map_buffer_range", map_buffer_range),
        ("read_buffer", read_buffer),
        ("unmap_buffer", unmap_buffer),
    ];
    add_api_cases(&mut group, cases);
    group
}
