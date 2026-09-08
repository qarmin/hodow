// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fNegativeBufferApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES2F_ADD_API_CASE` body is a
// function here and the registration is the table at the bottom, in upstream's order.
// The `expect_error` calls, and the specification sentence above each one, are kept
// verbatim: what this group tests is that a driver raises the error the specification
// names, so a paraphrase would be a different test.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw;

fn bind_buffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not one of the allowable values.");
    // SAFETY: every call in this file is made with a current context, and the whole
    // point of each one is that the driver rejects it - so the arguments are invalid on
    // purpose, and none of the pointers is dereferenced by a call that fails.
    unsafe { gl.bind_buffer(BAD_ENUM, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn delete_buffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
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
    let mut buffer = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER.");
    unsafe { gl.buffer_data(BAD_ENUM, 0, std::ptr::null(), glw::GL_STREAM_DRAW) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if usage is not GL_STREAM_DRAW, GL_STATIC_DRAW, or GL_DYNAMIC_DRAW.");
    unsafe { gl.buffer_data(glw::GL_ARRAY_BUFFER, 0, std::ptr::null(), BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if size is negative.");
    unsafe { gl.buffer_data(glw::GL_ARRAY_BUFFER, -1, std::ptr::null(), glw::GL_STREAM_DRAW) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 0, std::ptr::null(), glw::GL_STREAM_DRAW);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    unsafe { gl.delete_buffers(1, &buffer) };
}

fn buffer_sub_data(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 10, std::ptr::null(), glw::GL_STREAM_DRAW);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER.");
    unsafe { gl.buffer_sub_data(BAD_ENUM, 1, 1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the reserved buffer object name 0 is bound to target.");
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, 1, 1, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    unsafe { gl.delete_buffers(1, &buffer) };
}

fn buffer_sub_data_size_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 10, std::ptr::null(), glw::GL_STREAM_DRAW);
    }

    case.section(
        "GL_INVALID_VALUE is generated if offset or size is negative, or if together they define a region of memory \
         that extends beyond the buffer object's allocated data store.",
    );
    for (offset, size) in [(-1, 1), (-1, -1), (1, -1), (15, 1), (1, 15), (8, 8)] {
        unsafe { gl.buffer_sub_data(glw::GL_ARRAY_BUFFER, offset, size, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    unsafe { gl.delete_buffers(1, &buffer) };
}

fn clear(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if any bit other than the three defined bits is set in mask.");
    // SAFETY: as above.
    unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT) };
    case.expect_error(glw::GL_NO_ERROR);
    for mask in [0x0000_0200u32, 0x0000_1000, 0x0000_0010] {
        unsafe { gl.clear(mask) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn read_pixels(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ubyte_data = [0u8; 4];
    let ptr = ubyte_data.as_mut_ptr().cast();

    case.section("GL_INVALID_OPERATION is generated if the combination of format and type is unsupported.");
    // SAFETY: as above; the one call that succeeds reads a single pixel, which is at
    // most four bytes in any ES 2.0 read format, and the buffer is that large.
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_SHORT_4_4_4_4, ptr) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_VALUE is generated if either width or height is negative.");
    for (width, height) in [(-1, 1), (1, -1), (-1, -1)] {
        unsafe { gl.read_pixels(0, 0, width, height, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ptr) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    let mut fbo = 0;
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ptr);
    }
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
}

fn read_pixels_format_mismatch(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ubyte_data = [0u8; 4];
    let mut ushort_data = [0u16; 4];
    let ubyte_ptr = ubyte_data.as_mut_ptr().cast();
    let ushort_ptr = ushort_data.as_mut_ptr().cast();

    case.section("Unsupported combinations of format and type will generate an INVALID_OPERATION error.");
    // SAFETY: as in `read_pixels`.
    for (format, gl_type) in [
        (glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_6_5),
        (glw::GL_ALPHA, glw::GL_UNSIGNED_SHORT_5_6_5),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_ALPHA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_ALPHA, glw::GL_UNSIGNED_SHORT_5_5_5_1),
    ] {
        unsafe { gl.read_pixels(0, 0, 1, 1, format, gl_type, ushort_ptr) };
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section(
        "GL_RGBA/GL_UNSIGNED_BYTE is always accepted and the other acceptable pair can be discovered by querying \
         GL_IMPLEMENTATION_COLOR_READ_FORMAT and GL_IMPLEMENTATION_COLOR_READ_TYPE.",
    );
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, ubyte_ptr) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut read_format = 0;
    let mut read_type = 0;
    unsafe {
        gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &mut read_format);
        gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &mut read_type);
        gl.read_pixels(0, 0, 1, 1, read_format as u32, read_type as u32, ubyte_ptr);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

fn bind_framebuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not GL_FRAMEBUFFER.");
    // SAFETY: as above.
    for target in [BAD_ENUM, glw::GL_RENDERBUFFER] {
        unsafe { gl.bind_framebuffer(target, 0) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn bind_renderbuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
    // SAFETY: as above.
    for target in [BAD_ENUM, glw::GL_FRAMEBUFFER] {
        unsafe { gl.bind_renderbuffer(target, 0) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn check_framebuffer_status(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not GL_FRAMEBUFFER.");
    // SAFETY: as above.
    for target in [BAD_ENUM, glw::GL_RENDERBUFFER] {
        unsafe { gl.check_framebuffer_status(target) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn gen_framebuffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.gen_framebuffers(-1, std::ptr::null_mut()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn gen_renderbuffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.gen_renderbuffers(-1, std::ptr::null_mut()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn delete_framebuffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.delete_framebuffers(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn delete_renderbuffers(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.delete_renderbuffers(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn framebuffer_renderbuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut fbo = 0;
    let mut rbo = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.gen_renderbuffers(1, &mut rbo);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_FRAMEBUFFER.");
    unsafe { gl.framebuffer_renderbuffer(BAD_ENUM, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if attachment is not an accepted attachment point.");
    unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, BAD_ENUM, glw::GL_RENDERBUFFER, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if renderbuffertarget is not GL_RENDERBUFFER.");
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, BAD_ENUM, rbo);
    }
    case.expect_error(glw::GL_INVALID_ENUM);
    unsafe { gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0) };

    case.section("GL_INVALID_OPERATION is generated if renderbuffer is neither 0 nor the name of an existing renderbuffer object.");
    unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, u32::MAX) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the default framebuffer object name 0 is bound.");
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    unsafe {
        gl.delete_renderbuffers(1, &rbo);
        gl.delete_framebuffers(1, &fbo);
    }
}

fn framebuffer_texture2d(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut fbo = 0;
    let mut tex_2d = 0;
    let mut tex_cube = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.gen_textures(1, &mut tex_2d);
        gl.bind_texture(glw::GL_TEXTURE_2D, tex_2d);
        gl.gen_textures(1, &mut tex_cube);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex_cube);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if target is not GL_FRAMEBUFFER.");
    unsafe { gl.framebuffer_texture_2d(BAD_ENUM, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if textarget is not an accepted texture target.");
    unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, BAD_ENUM, tex_2d, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if attachment is not an accepted attachment point.");
    unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, BAD_ENUM, glw::GL_TEXTURE_2D, 0, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // A non-zero level is legal with GL_OES_fbo_render_mipmap, and on ES 3.0 and later,
    // so the case only demands the error where the specification does.
    if !(case.context().context_info.is_extension_supported("GL_OES_fbo_render_mipmap") || case.context().is_es3_compatible()) {
        case.section("GL_INVALID_VALUE is generated if level is not 0.");
        unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, tex_2d, 3) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_OPERATION is generated if texture is neither 0 nor the name of an existing texture object.");
    unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, u32::MAX, 0) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if texture is the name of an existing two-dimensional texture object but textarget is not GL_TEXTURE_2D.");
    case.expect_error(glw::GL_NO_ERROR);
    unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X, tex_2d, 0) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    unsafe { gl.delete_textures(1, &tex_2d) };

    case.section("GL_INVALID_OPERATION is generated if texture is the name of an existing cube map texture object but textarget is GL_TEXTURE_2D.");
    unsafe { gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, tex_cube, 0) };
    case.expect_error(glw::GL_INVALID_OPERATION);
    unsafe { gl.delete_textures(1, &tex_cube) };

    case.section("GL_INVALID_OPERATION is generated if the default framebuffer object name 0 is bound.");
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    unsafe { gl.delete_framebuffers(1, &fbo) };
}

fn renderbuffer_storage(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut rbo = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_renderbuffers(1, &mut rbo);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
    }

    case.section("GL_INVALID_ENUM is generated if target is not GL_RENDERBUFFER.");
    for target in [BAD_ENUM, glw::GL_FRAMEBUFFER] {
        unsafe { gl.renderbuffer_storage(target, glw::GL_RGBA4, 1, 1) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_ENUM is generated if internalformat is not an accepted format.");
    for format in [BAD_ENUM, glw::GL_RGBA, glw::GL_DEPTH_COMPONENT] {
        unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 1, 1) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_VALUE is generated if width or height is less than zero.");
    for (width, height) in [(-1, 1), (1, -1), (-1, -1)] {
        unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, width, height) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_RENDERBUFFER_SIZE.");
    let mut max_size = 0;
    unsafe { gl.get_integerv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_size) };
    for (width, height) in [(1, max_size + 1), (max_size + 1, 1), (max_size + 1, max_size + 1)] {
        unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, width, height) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_OPERATION is generated if the reserved renderbuffer object name 0 is bound.");
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, 1, 1);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    unsafe { gl.delete_renderbuffers(1, &rbo) };
}

/// `NegativeBufferApiTests::init`
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
        ("bind_framebuffer", bind_framebuffer),
        ("bind_renderbuffer", bind_renderbuffer),
        ("check_framebuffer_status", check_framebuffer_status),
        ("gen_framebuffers", gen_framebuffers),
        ("gen_renderbuffers", gen_renderbuffers),
        ("delete_framebuffers", delete_framebuffers),
        ("delete_renderbuffers", delete_renderbuffers),
        ("framebuffer_renderbuffer", framebuffer_renderbuffer),
        ("framebuffer_texture2d", framebuffer_texture2d),
        ("renderbuffer_storage", renderbuffer_storage),
    ];
    add_api_cases(&mut group, cases);
    group
}
