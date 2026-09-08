// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fNegativeTextureApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES3F_ADD_API_CASE` body is a
// function and the registration is a table of them; see the note in
// `gles2/functional/negative_api/buffer.rs`.
//
// **72 of upstream's 105 cases are here** - everything from `activetexture` through
// `texsubimage3d_invalid_buffer_target` in upstream's order, except
// `compressedteximage2d_invalid_astc_target` (and its `compressedteximage3d_`,
// `texstorage2d_` and `texstorage3d_` siblings), which need
// `tcu::mapGLCompressedTexFormat` / `getBlockPixelSize` / `getBlockSize` - none of
// which is ported. `copytexsubimage3d` onwards is the next batch.
//
// Upstream's `isES` branches are resolved here: `ApiType` in this port is ES-only by
// construction (see `Api::gl_api_type`), so only the ES branch is written.

use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLenum, GLint, GLuint};

/// `divRoundUp`
fn div_round_up(a: i32, b: i32) -> i32 {
    a / b + i32::from(a % b != 0)
}

/// `etc2DataSize` - one 64-bit block per 4x4 pixels.
fn etc2_data_size(width: i32, height: i32) -> i32 {
    div_round_up(width, 4) * div_round_up(height, 4) * 8
}

/// `etc2EacDataSize`
fn etc2_eac_data_size(width: i32, height: i32) -> i32 {
    2 * etc2_data_size(width, height)
}

/// `FOR_CUBE_FACES`'s six targets, in `cubeFaceToGLFace(tcu::CubeFace)` order.
///
/// The cases below list them out one by one instead, because upstream does: each face
/// gets its own log section there, and the order it writes them in is the
/// GL_TEXTURE_CUBE_MAP_* declaration order, not `tcu::CubeFace`'s.
const CUBE_FACE_TEX_TARGETS: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `deLog2Floor32`
fn de_log2_floor32(a: GLint) -> GLint {
    31 - (a as u32).leading_zeros() as GLint
}

// glActiveTexture

fn activetexture(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if texture is not one of GL_TEXTUREi, where i ranges from 0 to (GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS - 1).");
    // SAFETY: a current context; the enum is invalid on purpose.
    unsafe { gl.active_texture(glw::GL_NONE.wrapping_sub(1)) };
    case.expect_error(glw::GL_INVALID_ENUM);
    let num_max_texture_units = case.get_int(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS);
    // SAFETY: as above; one past the last texture unit.
    unsafe { gl.active_texture(glw::GL_TEXTURE0 + num_max_texture_units as GLenum) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

// glBindTexture

fn bindtexture(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture = [0u32; 2];
    // SAFETY: two names asked for, two GLuint of room; both are deleted at the end.
    unsafe { gl.gen_textures(2, texture.as_mut_ptr()) };

    case.section("GL_INVALID_ENUM is generated if target is not one of the allowable values.");
    // SAFETY: a current context; no pointer is involved.
    unsafe {
        gl.bind_texture(0, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.bind_texture(glw::GL_FRAMEBUFFER, 1);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_OPERATION is generated if texture was previously created with a target that doesn't match that of target.");
    // SAFETY: both names are this case's own.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        case.expect_error(glw::GL_NO_ERROR);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[0]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture[0]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture[0]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[1]);
        case.expect_error(glw::GL_NO_ERROR);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture[1]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture[1]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture[1]);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, texture.as_ptr()) };
}

// glCompressedTexImage2D

fn compressedteximage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a null data pointer with imageSize 0, as upstream passes; every call is
    // rejected for its target before anything is read.
    unsafe {
        gl.compressed_tex_image_2d(0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_CUBE_MAP, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn compressedteximage2d_invalid_format(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if internalformat is not a supported format returned in GL_COMPRESSED_TEXTURE_FORMATS.");
    // SAFETY: as in `compressedteximage2d_invalid_target`.
    unsafe {
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA, 0, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA32F, 0, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.compressed_tex_image_2d(target, 0, 0, 0, 0, 0, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_ENUM);
        }
    }
}

fn compressedteximage2d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, -1, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.compressed_tex_image_2d(target, -1, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn compressedteximage2d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE) for a 2d texture target.");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: a null data pointer, so the imageSize argument is only ever validated
    // against the dimensions, never dereferenced.
    unsafe {
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            log2_max_texture_size,
            glw::GL_COMPRESSED_RGB8_ETC2,
            16,
            16,
            0,
            etc2_data_size(16, 16),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE) for a cubemap target.");
    let log2_max_cubemap_size = de_log2_floor32(case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.compressed_tex_image_2d(
                target,
                log2_max_cubemap_size,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                16,
                16,
                0,
                etc2_eac_data_size(16, 16),
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn compressedteximage2d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: a null data pointer with imageSize 0 throughout.
    unsafe {
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, -1, 0, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, -1, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, -1, -1, 0, 0, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        case.section(&format!("{target:#x} target"));
        // SAFETY: as above.
        unsafe {
            gl.compressed_tex_image_2d(target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, -1, 0, 0, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.compressed_tex_image_2d(target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, -1, 0, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.compressed_tex_image_2d(target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, -1, -1, 0, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn compressedteximage2d_max_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let max_texture_size = case.get_int(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_cubemap_size = case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;

    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: a null data pointer, so `imageSize` is only validated, never read
    // through - which is what lets upstream name a size no allocation backs.
    unsafe {
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            max_texture_size,
            1,
            0,
            etc2_eac_data_size(max_texture_size, 1),
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            1,
            max_texture_size,
            0,
            etc2_eac_data_size(1, max_texture_size),
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            max_texture_size,
            max_texture_size,
            0,
            etc2_eac_data_size(max_texture_size, max_texture_size),
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        case.section(&format!("{target:#x} target"));
        // SAFETY: as above.
        unsafe {
            gl.compressed_tex_image_2d(
                target,
                0,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                max_cubemap_size,
                1,
                0,
                etc2_eac_data_size(max_cubemap_size, 1),
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.compressed_tex_image_2d(
                target,
                0,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                1,
                max_cubemap_size,
                0,
                etc2_eac_data_size(1, max_cubemap_size),
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.compressed_tex_image_2d(
                target,
                0,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                max_cubemap_size,
                max_cubemap_size,
                0,
                etc2_eac_data_size(max_cubemap_size, max_cubemap_size),
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn compressedteximage2d_invalid_border(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let error = glw::GL_INVALID_VALUE;
    case.section("GL_INVALID_VALUE is generated if border is not 0.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: a null data pointer with imageSize 0 throughout.
    unsafe {
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 1, 0, std::ptr::null());
        case.expect_error(error);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, -1, 0, std::ptr::null());
        case.expect_error(error);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        case.section(&format!("{target:#x} target"));
        // SAFETY: as above.
        unsafe {
            gl.compressed_tex_image_2d(target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 1, 0, std::ptr::null());
            case.expect_error(error);
            gl.compressed_tex_image_2d(target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, -1, 0, std::ptr::null());
            case.expect_error(error);
        }
    }
}

fn compressedteximage2d_invalid_size(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    // SAFETY: a null data pointer, so every deliberately-wrong `imageSize` here is
    // only compared against the dimensions, never used to read.
    unsafe {
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, -1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 16, 16, 0, 4 * 4 * 8, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGB8_ETC2, 16, 16, 0, 4 * 4 * 16, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_SIGNED_R11_EAC, 16, 16, 0, 4 * 4 * 16, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_invalid_buffer_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let data = [0u8; 64];
    // SAFETY: the name is this case's own and the 64-byte upload reads a 64-byte array.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        gl.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, 64, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section(
        "GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and the buffer object's data store is currently mapped.",
    );
    // SAFETY: with a pixel-unpack buffer bound, the last argument is an offset into
    // that buffer, not a pointer - hence the null.
    unsafe {
        gl.map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGB8_ETC2, 4, 4, 0, etc2_data_size(4, 4), std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
    }

    case.section(
        "GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.",
    );
    // SAFETY: as above; a 16x16 ETC2 image needs 128 bytes and the buffer holds 64.
    unsafe {
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGB8_ETC2, 16, 16, 0, etc2_data_size(16, 16), std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_buffers(1, &buf) };
}

// glCopyTexImage2D

fn copyteximage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a current context; a copy takes no client pointer.
    unsafe { gl.copy_tex_image_2d(0, 0, glw::GL_RGB, 0, 0, 64, 64, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn copyteximage2d_invalid_format(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM or GL_INVALID_VALUE is generated if internalformat is not an accepted format.");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 64, 64, 0);
        case.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_image_2d(target, 0, 0, 0, 0, 16, 16, 0);
            case.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_inequal_width_height_cube(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.");
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 16, 17, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, -1, glw::GL_RGB, 0, 0, 64, 64, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_image_2d(target, -1, glw::GL_RGB, 0, 0, 16, 16, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe { gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, log2_max_texture_size, glw::GL_RGB, 0, 0, 64, 64, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = de_log2_floor32(case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_image_2d(target, log2_max_cubemap_size, glw::GL_RGB, 0, 0, 16, 16, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, -1, 1, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, 1, -1, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, -1, -1, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        // SAFETY: as above.
        unsafe {
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, -1, 1, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 1, -1, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, -1, -1, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_max_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let max_texture_size = case.get_int(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_cubemap_size = case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;

    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, max_texture_size, 1, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, 1, max_texture_size, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, max_texture_size, max_texture_size, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        case.section(&format!("{target:#x} target"));
        // SAFETY: as above. Note the width/height order is the other way round from
        // the 2D block above, which is upstream's.
        unsafe {
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 1, max_cubemap_size, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, max_cubemap_size, 1, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, max_cubemap_size, max_cubemap_size, 0);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_invalid_border(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, 0, 0, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, 0, 0, 1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        // SAFETY: as above.
        unsafe {
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 0, 0, -1);
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 0, 0, 1);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn copyteximage2d_incomplete_framebuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut fbo: GLuint = 0;
    // SAFETY: the framebuffer is this case's own and is left with no attachment on
    // purpose, which is what makes it incomplete.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    // SAFETY: a copy takes no client pointer.
    unsafe {
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA8, 0, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_image_2d(target, 0, glw::GL_RGBA8, 0, 0, 0, 0, 0);
            case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        }
    }

    // SAFETY: the name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
    }
}

// glCopyTexSubImage2D

/// The 2D texture with a 16x16 RGBA level 0 that most `copytexsubimage2d_*` cases set
/// up, and which they delete again at the end.
fn gen_2d_texture_16x16(case: &mut ApiCase<'_>) -> GLuint {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is the caller's to delete; the level is left with unspecified
    // contents, as upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            16,
            16,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    texture
}

/// The 2D + cube-map pair the two `copytexsubimage2d_*level` cases set up, each with a
/// 16x16 RGBA level 0.
fn gen_2d_and_cube_textures_16x16(case: &mut ApiCase<'_>) -> [GLuint; 2] {
    let gl = case.gl();
    let mut textures = [0u32; 2];
    // SAFETY: as above, for two names.
    unsafe {
        gl.gen_textures(2, textures.as_mut_ptr());
        gl.bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            16,
            16,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[1]);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(target, 0, glw::GL_RGBA as GLint, 16, 16, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        }
    }
    textures
}

fn copytexsubimage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_16x16(case);

    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a current context; a copy takes no client pointer.
    unsafe { gl.copy_tex_sub_image_2d(0, 0, 0, 0, 0, 0, 4, 4) };
    case.expect_error(glw::GL_INVALID_ENUM);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn copytexsubimage2d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = gen_2d_and_cube_textures_16x16(case);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, -1, 0, 0, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_sub_image_2d(target, -1, 0, 0, 0, 0, 4, 4);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn copytexsubimage2d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = gen_2d_and_cube_textures_16x16(case);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE) for 2D texture targets.");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, log2_max_texture_size, 0, 0, 0, 0, 4, 4) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_SIZE) for cubemap targets.");
    let log2_max_cubemap_size = de_log2_floor32(case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_sub_image_2d(target, log2_max_cubemap_size, 0, 0, 0, 0, 4, 4);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn copytexsubimage2d_neg_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_16x16(case);

    case.section("GL_INVALID_VALUE is generated if xoffset < 0 or yoffset < 0.");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, -1, 0, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, -1, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, -1, -1, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn copytexsubimage2d_invalid_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_16x16(case);

    case.section("GL_INVALID_VALUE is generated if xoffset + width > texture_width or yoffset + height > texture_height.");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 14, 0, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 14, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 14, 14, 0, 0, 4, 4);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn copytexsubimage2d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_16x16(case);

    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, -1, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, 0, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, -1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn copytexsubimage2d_incomplete_framebuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    let mut texture = [0u32; 2];
    let mut fbo: GLuint = 0;
    // SAFETY: every name is this case's own; each level is left with unspecified
    // contents, as upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(2, texture.as_mut_ptr());
        gl.bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA as GLint, 4, 4, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[1]);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(target, 0, glw::GL_RGBA as GLint, 4, 4, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        }
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: the framebuffer is this case's own and is left with no attachment on
    // purpose.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: a copy takes no client pointer.
    unsafe {
        gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, 0, 0);
        case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.copy_tex_sub_image_2d(target, 0, 0, 0, 0, 0, 0, 0);
            case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
        }
    }

    // SAFETY: every name is this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
        gl.delete_textures(2, texture.as_ptr());
    }
}

// glDeleteTextures

fn deletetextures(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe { gl.gen_textures(1, &mut texture) };

    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is rejected before the null array is read, which is
    // what upstream relies on here - and it checks it twice, once with a texture bound.
    unsafe {
        gl.delete_textures(-1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.delete_textures(-1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

// glGenerateMipmap

fn generatemipmap(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture = [0u32; 2];
    // SAFETY: two names asked for, two GLuint of room; both are deleted at the end.
    unsafe { gl.gen_textures(2, texture.as_mut_ptr()) };

    case.section("GL_INVALID_ENUM is generated if target is not GL_TEXTURE_2D or GL_TEXTURE_CUBE_MAP.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.generate_mipmap(0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("INVALID_OPERATION is generated if the texture bound to target is not cube complete.");
    // SAFETY: every level is left with unspecified contents, as upstream's null
    // pointer asks for; the 0x0 face is what makes the cube map incomplete.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[0]);
        gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as GLint);
        gl.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            0,
            glw::GL_RGB as GLint,
            0,
            0,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
    // SAFETY: as above; the last face is 32x32 where the others are 16x16, which is
    // again not cube complete.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[0]);
        for target in [
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        ] {
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, 16, 16, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        }
        gl.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            0,
            glw::GL_RGB as GLint,
            32,
            32,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if the zero level array is stored in a compressed internal format.");
    // SAFETY: as above; a null compressed image with imageSize 0.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, texture[1]);
        gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0, std::ptr::null());
        gl.generate_mipmap(glw::GL_TEXTURE_2D);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section(
        "GL_INVALID_OPERATION is generated if the level base array was not specified with an unsized internal format or a sized internal format that is both color-renderable and texture-filterable.",
    );
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB8_SNORM as GLint, 0, 0, 0, glw::GL_RGB, glw::GL_BYTE, std::ptr::null());
        gl.generate_mipmap(glw::GL_TEXTURE_2D);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_R8I as GLint, 0, 0, 0, glw::GL_RED_INTEGER, glw::GL_BYTE, std::ptr::null());
        gl.generate_mipmap(glw::GL_TEXTURE_2D);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    if !(case.context().context_info.is_extension_supported("GL_EXT_color_buffer_float") && case.context().context_info.is_extension_supported("GL_OES_texture_float_linear")) {
        // SAFETY: as above.
        unsafe {
            gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA32F as GLint, 0, 0, 0, glw::GL_RGBA, glw::GL_FLOAT, std::ptr::null());
            gl.generate_mipmap(glw::GL_TEXTURE_2D);
        }
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, texture.as_ptr()) };
}

// glGenTextures

fn gentextures(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is rejected before the destination is written.
    unsafe { gl.gen_textures(-1, std::ptr::null_mut()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

// glPixelStorei

fn pixelstorei(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: a current context; no pointer is involved.
    unsafe { gl.pixel_storei(0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if a negative row length, pixel skip, or row skip value is specified, or if alignment is specified as other than 1, 2, 4, or 8.");
    // SAFETY: as above.
    unsafe {
        for pname in [
            glw::GL_PACK_ROW_LENGTH,
            glw::GL_PACK_SKIP_ROWS,
            glw::GL_PACK_SKIP_PIXELS,
            glw::GL_UNPACK_ROW_LENGTH,
            glw::GL_UNPACK_IMAGE_HEIGHT,
            glw::GL_UNPACK_SKIP_ROWS,
            glw::GL_UNPACK_SKIP_PIXELS,
            glw::GL_UNPACK_SKIP_IMAGES,
        ] {
            gl.pixel_storei(pname, -1);
            case.expect_error(glw::GL_INVALID_VALUE);
        }
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 16);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 16);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

// glTexImage2D

fn teximage2d(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a null pixel pointer throughout, as upstream passes, so nothing is read.
    unsafe { gl.tex_image_2d(0, 0, glw::GL_RGBA as GLint, 1, 1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not a type constant.");
    // SAFETY: as above.
    unsafe { gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA as GLint, 1, 1, 0, glw::GL_RGBA, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the combination of internalFormat, format and type is invalid.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB5_A1 as GLint,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB10_A2 as GLint,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_INT_2_10_10_10_REV,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, 1, 1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA32UI as GLint,
            1,
            1,
            0,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn teximage2d_inequal_width_height_cube(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.");
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, 1, 2, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage2d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe { gl.tex_image_2d(glw::GL_TEXTURE_2D, -1, glw::GL_RGB as GLint, 1, 1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(target, -1, glw::GL_RGB as GLint, 1, 1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage2d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            log2_max_texture_size,
            glw::GL_RGB as GLint,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = de_log2_floor32(case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(
                target,
                log2_max_cubemap_size,
                glw::GL_RGB as GLint,
                1,
                1,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage2d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");

    case.section("GL_TEXTURE_2D target");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, -1, 1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, 1, -1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, -1, -1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    for target in CUBE_FACE_TEX_TARGETS {
        case.section(&format!("{target:#x} target"));
        // SAFETY: as above.
        unsafe {
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, -1, 1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, 1, -1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, -1, -1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage2d_max_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let max_texture_size = case.get_int(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_cubemap_size = case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;

    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");
    // SAFETY: a null pixel pointer, so the over-large dimensions are only validated -
    // no allocation and no read happens.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as GLint,
            max_texture_size,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as GLint,
            1,
            max_texture_size,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as GLint,
            max_texture_size,
            max_texture_size,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_CUBE_MAP_TEXTURE_SIZE.");
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGB as GLint,
                max_cubemap_size,
                1,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGB as GLint,
                1,
                max_cubemap_size,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGB as GLint,
                max_cubemap_size,
                max_cubemap_size,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage2d_invalid_border(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, 1, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, 1, 1, -1, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, 1, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, 1, 1, -1, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage2d_invalid_buffer_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0u8; 64];
    // SAFETY: both names are this case's own and the 64-byte upload reads a 64-byte
    // array.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        gl.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, 64, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

    case.section("...the buffer object's data store is currently mapped.");
    // SAFETY: with a pixel-unpack buffer bound, the last argument is a byte offset into
    // that buffer, not a pointer.
    unsafe {
        gl.map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGBA as GLint, 4, 4, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
    }

    case.section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
    // SAFETY: as above; a 64x64 RGBA8 image needs 16 KiB and the buffer holds 64 bytes.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            64,
            64,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
    log::debug!("// Set byte offset = 3");
    // SAFETY: as above - 3 is a byte *offset* into the bound unpack buffer, which is
    // what makes it a misalignment rather than a bad pointer.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB5_A1 as GLint,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            std::ptr::without_provenance(3),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_textures(1, &texture);
    }
}

// glTexSubImage2D

/// The 2D texture with a 32x32 level 0 of `internal_format` that the
/// `texsubimage2d_*` cases set up.
fn gen_2d_texture_32x32(case: &mut ApiCase<'_>, internal_format: GLenum, format: GLenum) -> GLuint {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is the caller's to delete; the level is left with unspecified
    // contents, as upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, internal_format as GLint, 32, 32, 0, format, glw::GL_UNSIGNED_BYTE, std::ptr::null());
    }
    case.expect_error(glw::GL_NO_ERROR);
    texture
}

fn texsubimage2d(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_32x32(case, glw::GL_RGBA, glw::GL_RGBA);

    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a null pixel pointer throughout, as upstream passes.
    unsafe { gl.tex_sub_image_2d(0, 0, 0, 0, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    // SAFETY: as above. Upstream's argument list here is shifted by one relative to
    // its neighbours - width lands on 0, height on 4 and *format* on the literal 4,
    // which is what makes this an invalid format rather than an invalid width;
    // reproduced literally.
    unsafe { gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 4, 4, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not a type constant.");
    // SAFETY: as above.
    unsafe { gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGB, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the combination of internalFormat of the previously specified texture array, format and type is not valid.");
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_6_5, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGB, glw::GL_FLOAT, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

/// The 2D + cube-map pair the two `texsubimage2d_*level` cases set up, each with a
/// 32x32 RGB level 0.
///
/// Note `texsubimage2d_neg_level` binds *both* names to GL_TEXTURE_2D, so its cube
/// faces are specified against whatever cube map is bound (none) - upstream's own
/// copy-paste, reproduced by the `cube_target` argument.
fn gen_texsubimage2d_level_textures(case: &mut ApiCase<'_>, cube_target: GLenum) -> [GLuint; 2] {
    let gl = case.gl();
    let mut textures = [0u32; 2];
    // SAFETY: two names asked for, two GLuint of room; the levels are left with
    // unspecified contents, as upstream's null pointer asks for.
    unsafe {
        gl.gen_textures(2, textures.as_mut_ptr());
        gl.bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        gl.tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB as GLint, 32, 32, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        gl.bind_texture(cube_target, textures[1]);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_image_2d(target, 0, glw::GL_RGB as GLint, 32, 32, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        }
    }
    case.expect_error(glw::GL_NO_ERROR);
    textures
}

fn texsubimage2d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // Upstream binds the second texture to GL_TEXTURE_2D here, not to
    // GL_TEXTURE_CUBE_MAP as its `max_level` sibling does; reproduced.
    let textures = gen_texsubimage2d_level_textures(case, glw::GL_TEXTURE_2D);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: a null pixel pointer with a 0x0 region.
    unsafe { gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, -1, 0, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_sub_image_2d(target, -1, 0, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn texsubimage2d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = gen_texsubimage2d_level_textures(case, glw::GL_TEXTURE_CUBE_MAP);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, log2_max_texture_size, 0, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = de_log2_floor32(case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.tex_sub_image_2d(target, log2_max_cubemap_size, 0, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn texsubimage2d_neg_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_32x32(case, glw::GL_RGB, glw::GL_RGB);

    case.section("GL_INVALID_VALUE is generated if xoffset or yoffset are negative.");
    // SAFETY: a null pixel pointer with a 0x0 region.
    unsafe {
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, -1, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, -1, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, -1, -1, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn texsubimage2d_invalid_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_32x32(case, glw::GL_RGBA, glw::GL_RGBA);

    case.section("GL_INVALID_VALUE is generated if xoffset + width > texture_width or yoffset + height > texture_height.");
    // SAFETY: a null pixel pointer, so the out-of-range region is only validated.
    unsafe {
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 30, 0, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 30, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 30, 30, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn texsubimage2d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let texture = gen_2d_texture_32x32(case, glw::GL_RGBA, glw::GL_RGBA);

    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: a null pixel pointer.
    unsafe {
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, -1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, -1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, -1, -1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn texsubimage2d_invalid_buffer_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0u8; 64];
    // SAFETY: both names are this case's own and the 64-byte upload reads a 64-byte
    // array.
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
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        gl.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, 64, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

    case.section("...the buffer object's data store is currently mapped.");
    // SAFETY: with a pixel-unpack buffer bound, the last argument is a byte offset into
    // that buffer, not a pointer.
    unsafe {
        gl.map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT);
        gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
    }

    case.section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
    // SAFETY: as above; a 32x32 RGBA8 region needs 4 KiB and the buffer holds 64 bytes.
    unsafe { gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 32, 32, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
    log::debug!("// Set byte offset = 3");
    // SAFETY: the re-specification happens with no unpack buffer bound, so its null
    // pixel pointer is a real (absent) pointer; the last call's 3 is a byte offset into
    // the buffer that is bound again by then.
    unsafe {
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA4 as GLint,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            std::ptr::null(),
        );
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            std::ptr::without_provenance(3),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_textures(1, &texture);
    }
}

// glTexParameteri / glTexParameterf / glTexParameteriv / glTexParameterfv

/// The four sections each `texparameter*` case runs, once with no texture bound and
/// again with one bound - upstream writes both out identically.
fn texparameter_sections(case: &mut ApiCase<'_>, set: impl Fn(GLenum, GLenum, GLint)) {
    case.section("GL_INVALID_ENUM is generated if target or pname is not one of the accepted defined values.");
    set(0, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint);
    case.expect_error(glw::GL_INVALID_ENUM);
    set(glw::GL_TEXTURE_2D, 0, glw::GL_LINEAR as GLint);
    case.expect_error(glw::GL_INVALID_ENUM);
    set(0, 0, glw::GL_LINEAR as GLint);
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if params should have a defined symbolic constant value (based on the value of pname) and does not.");
    set(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, 0);
    case.expect_error(glw::GL_INVALID_ENUM);
    set(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_REPEAT as GLint);
    case.expect_error(glw::GL_INVALID_ENUM);
    set(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, 0);
    case.expect_error(glw::GL_INVALID_ENUM);
    set(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_NEAREST as GLint);
    case.expect_error(glw::GL_INVALID_ENUM);
}

/// The whole body of a `texparameter*` case: the sections above with nothing bound,
/// then a texture bound, then the same sections again.
fn texparameter_case(case: &mut ApiCase<'_>, set: impl Fn(GLenum, GLenum, GLint) + Copy) {
    let gl = case.gl();
    texparameter_sections(case, set);

    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
    }

    texparameter_sections(case, set);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn texparameteri(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    texparameter_case(case, |target, pname, param| {
        // SAFETY: a current context; no pointer is involved.
        unsafe { gl.tex_parameteri(target, pname, param) };
    });
}

fn texparameterf(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    texparameter_case(case, |target, pname, param| {
        // SAFETY: as above. Upstream passes the same symbolic constants here, as a
        // float, which is what this API takes.
        unsafe { gl.tex_parameterf(target, pname, param as f32) };
    });
}

fn texparameteriv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    texparameter_case(case, |target, pname, param| {
        let params = [param];
        // SAFETY: one GLint of source, which is what every pname here reads.
        unsafe { gl.tex_parameteriv(target, pname, params.as_ptr()) };
    });
}

fn texparameterfv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    texparameter_case(case, |target, pname, param| {
        let params = [param as f32];
        // SAFETY: one GLfloat of source, which is what every pname here reads.
        unsafe { gl.tex_parameterfv(target, pname, params.as_ptr()) };
    });
}

// glCompressedTexSubImage2D

fn compressedtexsubimage2d(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a current context; no client data is read (imageSize is 0).
    unsafe {
        gl.compressed_tex_sub_image_2d(0, 0, 0, 0, 0, 0, glw::GL_COMPRESSED_RGB8_ETC2, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_ENUM);

    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end; the base image is
    // allocated with a null pointer, so nothing is read.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            18,
            18,
            0,
            etc2_eac_data_size(18, 18),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if format does not match the internal format of the texture image being modified.");
    // SAFETY: as above; every call below rejects before reading any data.
    unsafe {
        gl.compressed_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, glw::GL_COMPRESSED_RGB8_ETC2, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("For ETC2/EAC images GL_INVALID_OPERATION is generated if width is not a multiple of four, and width + xoffset is not equal to the width of the texture level.");
    // SAFETY: as above.
    unsafe {
        gl.compressed_tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            4,
            0,
            10,
            4,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(10, 4),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if height is not a multiple of four, and height + yoffset is not equal to the height of the texture level.",
    );
    // SAFETY: as above.
    unsafe {
        gl.compressed_tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            4,
            4,
            10,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(4, 10),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("For ETC2/EAC images GL_INVALID_OPERATION is generated if xoffset or yoffset is not a multiple of four.");
    // SAFETY: as above.
    unsafe {
        for (xoffset, yoffset) in [(0, 1), (1, 0), (1, 1)] {
            gl.compressed_tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                xoffset,
                yoffset,
                4,
                4,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                etc2_eac_data_size(4, 4),
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_OPERATION);
        }
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

/// The two textures every `compressedtexsubimage2d_*_level` case sets up: an 18x18
/// ETC2/EAC 2D image and the same on all six cube faces.
fn compressedtexsubimage2d_level_setup(case: &mut ApiCase<'_>) -> [GLuint; 2] {
    let gl = case.gl();
    let mut textures = [0u32; 2];
    // SAFETY: two names asked for, two GLuint of room; every image is allocated with a
    // null pointer, so nothing is read.
    unsafe {
        gl.gen_textures(2, textures.as_mut_ptr());
        gl.bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            18,
            18,
            0,
            etc2_eac_data_size(18, 18),
            std::ptr::null(),
        );
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[1]);
        for target in CUBE_FACE_TEX_TARGETS {
            gl.compressed_tex_image_2d(target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 18, 18, 0, etc2_eac_data_size(18, 18), std::ptr::null());
        }
    }
    case.expect_error(glw::GL_NO_ERROR);
    textures
}

fn compressedtexsubimage2d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = compressedtexsubimage2d_level_setup(case);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: a current context; imageSize is 0, so no data is read.
    unsafe {
        gl.compressed_tex_sub_image_2d(glw::GL_TEXTURE_2D, -1, 0, 0, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.compressed_tex_sub_image_2d(target, -1, 0, 0, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn compressedtexsubimage2d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = compressedtexsubimage2d_level_setup(case);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: a current context; imageSize is 0, so no data is read.
    unsafe {
        gl.compressed_tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            log2_max_texture_size,
            0,
            0,
            0,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = de_log2_floor32(case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        for target in CUBE_FACE_TEX_TARGETS {
            gl.compressed_tex_sub_image_2d(target, log2_max_cubemap_size, 0, 0, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn compressedtexsubimage2d_neg_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            8,
            8,
            0,
            etc2_eac_data_size(8, 8),
            std::ptr::null(),
        );
    }

    // Upstream: both errors are valid, since an implementation may check the offsets
    // against the format before checking they are not negative.
    case.section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if xoffset or yoffset are negative.");
    // SAFETY: a current context; imageSize is 0, so no data is read.
    unsafe {
        for (xoffset, yoffset) in [(-4, 0), (0, -4), (-4, -4)] {
            gl.compressed_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, xoffset, yoffset, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, std::ptr::null());
            case.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
        }
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn compressedtexsubimage2d_invalid_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            16,
            16,
            0,
            etc2_eac_data_size(16, 16),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if xoffset + width > texture_width or yoffset + height > texture_height.");
    // SAFETY: a current context; every call is rejected before any data is read.
    unsafe {
        for (xoffset, yoffset, width, height) in [(12, 0, 8, 4), (0, 12, 4, 8), (12, 12, 8, 8)] {
            gl.compressed_tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                xoffset,
                yoffset,
                width,
                height,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                etc2_eac_data_size(width, height),
                std::ptr::null(),
            );
            case.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
        }
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn compressedtexsubimage2d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            16,
            16,
            0,
            etc2_eac_data_size(16, 16),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if width or height is less than 0.");
    // SAFETY: a current context; imageSize is 0, so no data is read.
    unsafe {
        for (width, height) in [(-4, 0), (0, -4), (-4, -4)] {
            gl.compressed_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, width, height, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, std::ptr::null());
            case.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
        }
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn compressedtexsubimage2d_invalid_size(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            16,
            16,
            0,
            etc2_eac_data_size(16, 16),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    // SAFETY: a current context; both calls are rejected before any data is read.
    unsafe {
        gl.compressed_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, -1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);

        gl.compressed_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 16, 16, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 4 * 4 * 16 - 1, std::ptr::null());
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn compressedtexsubimage2d_invalid_buffer_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0u8; 128];

    // SAFETY: both names are this case's own; the 128-byte upload reads a 128-byte array.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.compressed_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            16,
            16,
            0,
            etc2_eac_data_size(16, 16),
            std::ptr::null(),
        );
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        gl.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, 128, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");
    case.section("...the buffer object's data store is currently mapped.");
    // SAFETY: with a pixel-unpack buffer bound, the last argument is an offset into
    // that buffer, not a pointer - hence the null.
    unsafe {
        gl.map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 128, glw::GL_MAP_WRITE_BIT);
        gl.compressed_tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            4,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(4, 4),
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
    }

    case.section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
    // SAFETY: as above; a 16x16 ETC2/EAC image needs 256 bytes and the buffer holds 128.
    unsafe {
        gl.compressed_tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            16,
            16,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(16, 16),
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_textures(1, &texture);
    }
}

// glTexImage3D

fn teximage3d(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        gl.tex_image_3d(0, 0, glw::GL_RGBA as GLint, 1, 1, 1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.tex_image_3d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section("GL_INVALID_ENUM is generated if type is not a type constant.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_3d(glw::GL_TEXTURE_3D, 0, glw::GL_RGBA as GLint, 1, 1, 1, 0, glw::GL_RGBA, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_3d(glw::GL_TEXTURE_3D, 0, glw::GL_RGBA as GLint, 1, 1, 1, 0, 0, glw::GL_UNSIGNED_BYTE, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section(
        "GL_INVALID_VALUE is generated if internalFormat is not one of the accepted resolution and format symbolic constants or GL_INVALID_OPERATION is generated if internalformat, format and type are not compatible.",
    );
    // SAFETY: as above.
    unsafe {
        gl.tex_image_3d(glw::GL_TEXTURE_3D, 0, 0, 1, 1, 1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
    }
    case.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);

    case.section("GL_INVALID_OPERATION is generated if target is GL_TEXTURE_3D and format is GL_DEPTH_COMPONENT, or GL_DEPTH_STENCIL.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_DEPTH_STENCIL as GLint,
            1,
            1,
            1,
            0,
            glw::GL_DEPTH_STENCIL,
            glw::GL_UNSIGNED_INT_24_8,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_DEPTH_COMPONENT as GLint,
            1,
            1,
            1,
            0,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if the combination of internalFormat, format and type is invalid.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGB5_A1 as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGB10_A2 as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_INT_2_10_10_10_REV,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGB as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA32UI as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            std::ptr::null(),
        );
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

fn teximage3d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            gl.tex_image_3d(target, -1, glw::GL_RGB as GLint, 1, 1, 1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage3d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_3D_TEXTURE_SIZE).");
    let log2_max_3d_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_3D_TEXTURE_SIZE)) + 1;
    // SAFETY: a current context; a null pixel pointer.
    unsafe {
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            log2_max_3d_texture_size,
            glw::GL_RGB as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    // SAFETY: as above.
    unsafe {
        gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            log2_max_texture_size,
            glw::GL_RGB as GLint,
            1,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn teximage3d_neg_width_height_depth(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            for (width, height, depth) in [(-1, 1, 1), (1, -1, 1), (1, 1, -1), (-1, -1, -1)] {
                gl.tex_image_3d(
                    target,
                    0,
                    glw::GL_RGBA as GLint,
                    width,
                    height,
                    depth,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                case.expect_error(glw::GL_INVALID_VALUE);
            }
        }
    }
}

fn teximage3d_max_width_height_depth(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let max_3d_texture_size = case.get_int(glw::GL_MAX_3D_TEXTURE_SIZE) + 1;
    let max_texture_size = case.get_int(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_texture_layers = case.get_int(glw::GL_MAX_ARRAY_TEXTURE_LAYERS) + 1;

    case.section("GL_INVALID_VALUE is generated if width, height or depth is greater than GL_MAX_3D_TEXTURE_SIZE.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for (width, height, depth) in [
            (max_3d_texture_size, 1, 1),
            (1, max_3d_texture_size, 1),
            (1, 1, max_3d_texture_size),
            (max_3d_texture_size, max_3d_texture_size, max_3d_texture_size),
        ] {
            gl.tex_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                glw::GL_RGBA as GLint,
                width,
                height,
                depth,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    case.section("GL_INVALID_VALUE is generated if width, height or depth is greater than GL_MAX_TEXTURE_SIZE.");
    // SAFETY: as above. Upstream checks the array texture's depth against
    // GL_MAX_ARRAY_TEXTURE_LAYERS, not GL_MAX_TEXTURE_SIZE, despite the section title.
    unsafe {
        for (width, height, depth) in [
            (max_texture_size, 1, 1),
            (1, max_texture_size, 1),
            (1, 1, max_texture_layers),
            (max_texture_size, max_texture_size, max_texture_layers),
        ] {
            gl.tex_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                glw::GL_RGBA as GLint,
                width,
                height,
                depth,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn teximage3d_invalid_border(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0 or 1.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            for border in [-1, 2] {
                gl.tex_image_3d(target, 0, glw::GL_RGB as GLint, 1, 1, 1, border, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null());
                case.expect_error(glw::GL_INVALID_VALUE);
            }
        }
    }
}

fn teximage3d_invalid_buffer_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0u8; 512];

    // SAFETY: both names are this case's own; the 512-byte upload reads a 512-byte array.
    unsafe {
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        gl.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, 512, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");
    case.section("...the buffer object's data store is currently mapped.");
    // SAFETY: with a pixel-unpack buffer bound, the last argument is an offset into
    // that buffer, not a pointer - hence the null. Upstream maps only 128 of the 512
    // bytes, which is enough to make the buffer mapped.
    unsafe {
        gl.map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 128, glw::GL_MAP_WRITE_BIT);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
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
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
    }

    case.section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
    // SAFETY: as above; 64x64x64 RGBA8 needs 1 MiB and the buffer holds 512 bytes.
    unsafe {
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA as GLint,
            64,
            64,
            64,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
    // SAFETY: as above; the offset 3 is a byte offset into the bound buffer.
    unsafe {
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGB5_A1 as GLint,
            4,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            std::ptr::without_provenance(3),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_textures(1, &texture);
    }
}

// glTexSubImage3D

fn texsubimage3d(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
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
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for target in [0, glw::GL_TEXTURE_2D] {
            gl.tex_sub_image_3d(target, 0, 0, 0, 0, 4, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_ENUM);
        }
    }

    case.section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    // SAFETY: as above. Upstream's argument list here is shifted by one - it passes an
    // extra 0 - so this is really width=0, height=4, depth=4 and *format*=4.
    unsafe {
        gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, 0, 4, 4, 4, glw::GL_UNSIGNED_BYTE, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not a type constant.");
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, 4, 4, 4, glw::GL_RGB, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if the combination of internalFormat of the previously specified texture array, format and type is not valid.");
    // SAFETY: as above. The GL_RGB/GL_UNSIGNED_SHORT_5_5_5_1 pair is written twice
    // upstream.
    unsafe {
        for (format, type_) in [
            (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
            (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
            (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
            (glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT),
            (glw::GL_RGB, glw::GL_FLOAT),
        ] {
            gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, 4, 4, 4, format, type_, std::ptr::null());
            case.expect_error(glw::GL_INVALID_OPERATION);
        }
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

/// The two textures every `texsubimage3d_*_level`/`_neg_offset` case sets up: a 4x4x4
/// 3D image and a 4x4x4 2D-array one.
fn texsubimage3d_two_textures(case: &mut ApiCase<'_>) -> [GLuint; 2] {
    let gl = case.gl();
    let mut textures = [0u32; 2];
    // SAFETY: two names asked for, two GLuint of room; both images pass a null pixel
    // pointer.
    unsafe {
        gl.gen_textures(2, textures.as_mut_ptr());
        gl.bind_texture(glw::GL_TEXTURE_3D, textures[0]);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
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
        gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, textures[1]);
        gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
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
    case.expect_error(glw::GL_NO_ERROR);
    textures
}

fn texsubimage3d_neg_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = texsubimage3d_two_textures(case);

    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            gl.tex_sub_image_3d(target, -1, 0, 0, 0, 0, 0, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn texsubimage3d_max_level(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = texsubimage3d_two_textures(case);

    let log2_max_3d_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_3D_TEXTURE_SIZE)) + 1;
    let log2_max_texture_size = de_log2_floor32(case.get_int(glw::GL_MAX_TEXTURE_SIZE)) + 1;

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_3D_TEXTURE_SIZE).");
    // SAFETY: a current context; a null pixel pointer.
    unsafe {
        gl.tex_sub_image_3d(
            glw::GL_TEXTURE_3D,
            log2_max_3d_texture_size,
            0,
            0,
            0,
            0,
            0,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            log2_max_texture_size,
            0,
            0,
            0,
            0,
            0,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn texsubimage3d_neg_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let textures = texsubimage3d_two_textures(case);

    case.section("GL_INVALID_VALUE is generated if xoffset, yoffset or zoffset are negative.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            for (xoffset, yoffset, zoffset) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
                gl.tex_sub_image_3d(target, 0, xoffset, yoffset, zoffset, 0, 0, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
                case.expect_error(glw::GL_INVALID_VALUE);
            }
        }
    }

    // SAFETY: both names are this case's own.
    unsafe { gl.delete_textures(2, textures.as_ptr()) };
}

fn texsubimage3d_invalid_offset(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture: GLuint = 0;
    // SAFETY: the name is this case's own and is deleted at the end.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
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
    case.expect_error(glw::GL_NO_ERROR);

    for (title, xoffset, yoffset, zoffset) in [
        ("GL_INVALID_VALUE is generated if xoffset + width > texture_width.", 2, 0, 0),
        ("GL_INVALID_VALUE is generated if yoffset + height > texture_height.", 0, 2, 0),
        ("GL_INVALID_VALUE is generated if zoffset + depth > texture_depth.", 0, 0, 2),
    ] {
        case.section(title);
        // SAFETY: a current context; a null pixel pointer.
        unsafe {
            gl.tex_sub_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                xoffset,
                yoffset,
                zoffset,
                4,
                4,
                4,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }
        case.expect_error(glw::GL_INVALID_VALUE);
    }

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_textures(1, &texture) };
}

fn texsubimage3d_neg_width_height(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width, height or depth is less than 0.");
    // SAFETY: a current context; every call passes a null pixel pointer.
    unsafe {
        for (width, height, depth) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
            gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, width, height, depth, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
            case.expect_error(glw::GL_INVALID_VALUE);
        }
    }
}

fn texsubimage3d_invalid_buffer_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0u8; 512];

    // SAFETY: both names are this case's own; the 512-byte upload reads a 512-byte array.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA as GLint,
            16,
            16,
            16,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.gen_buffers(1, &mut buf);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        gl.buffer_data(glw::GL_PIXEL_UNPACK_BUFFER, 512, data.as_ptr().cast(), glw::GL_DYNAMIC_COPY);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");
    case.section("...the buffer object's data store is currently mapped.");
    // SAFETY: with a pixel-unpack buffer bound, the last argument is an offset into
    // that buffer, not a pointer - hence the null.
    unsafe {
        gl.map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 512, glw::GL_MAP_WRITE_BIT);
        gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, 4, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
    }

    case.section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
    // SAFETY: as above; 16x16x16 RGBA8 needs 16 KiB and the buffer holds 512 bytes.
    unsafe {
        gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, 16, 16, 16, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, std::ptr::null());
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
    // SAFETY: as above; the base image is respecified with the unpack buffer unbound so
    // the null pointer really is a client pointer there, and it reads nothing.
    unsafe {
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA4 as GLint,
            4,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            std::ptr::null(),
        );
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above; the offset 3 is a byte offset into the bound buffer.
    unsafe {
        gl.tex_sub_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            0,
            0,
            0,
            4,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            std::ptr::without_provenance(3),
        );
    }
    case.expect_error(glw::GL_INVALID_OPERATION);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_buffers(1, &buf);
        gl.delete_textures(1, &texture);
    }
}

/// `NegativeTextureApiTests::init`, restricted to the 72 ported cases.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("activetexture", activetexture),
        ("bindtexture", bindtexture),
        ("compressedteximage2d_invalid_target", compressedteximage2d_invalid_target),
        ("compressedteximage2d_invalid_format", compressedteximage2d_invalid_format),
        ("compressedteximage2d_neg_level", compressedteximage2d_neg_level),
        ("compressedteximage2d_max_level", compressedteximage2d_max_level),
        ("compressedteximage2d_neg_width_height", compressedteximage2d_neg_width_height),
        ("compressedteximage2d_max_width_height", compressedteximage2d_max_width_height),
        ("compressedteximage2d_invalid_border", compressedteximage2d_invalid_border),
        ("compressedteximage2d_invalid_size", compressedteximage2d_invalid_size),
        ("compressedteximage2d_invalid_buffer_target", compressedteximage2d_invalid_buffer_target),
        ("copyteximage2d_invalid_target", copyteximage2d_invalid_target),
        ("copyteximage2d_invalid_format", copyteximage2d_invalid_format),
        ("copyteximage2d_inequal_width_height_cube", copyteximage2d_inequal_width_height_cube),
        ("copyteximage2d_neg_level", copyteximage2d_neg_level),
        ("copyteximage2d_max_level", copyteximage2d_max_level),
        ("copyteximage2d_neg_width_height", copyteximage2d_neg_width_height),
        ("copyteximage2d_max_width_height", copyteximage2d_max_width_height),
        ("copyteximage2d_invalid_border", copyteximage2d_invalid_border),
        ("copyteximage2d_incomplete_framebuffer", copyteximage2d_incomplete_framebuffer),
        ("copytexsubimage2d_invalid_target", copytexsubimage2d_invalid_target),
        ("copytexsubimage2d_neg_level", copytexsubimage2d_neg_level),
        ("copytexsubimage2d_max_level", copytexsubimage2d_max_level),
        ("copytexsubimage2d_neg_offset", copytexsubimage2d_neg_offset),
        ("copytexsubimage2d_invalid_offset", copytexsubimage2d_invalid_offset),
        ("copytexsubimage2d_neg_width_height", copytexsubimage2d_neg_width_height),
        ("copytexsubimage2d_incomplete_framebuffer", copytexsubimage2d_incomplete_framebuffer),
        ("deletetextures", deletetextures),
        ("generatemipmap", generatemipmap),
        ("gentextures", gentextures),
        ("pixelstorei", pixelstorei),
        ("teximage2d", teximage2d),
        ("teximage2d_inequal_width_height_cube", teximage2d_inequal_width_height_cube),
        ("teximage2d_neg_level", teximage2d_neg_level),
        ("teximage2d_max_level", teximage2d_max_level),
        ("teximage2d_neg_width_height", teximage2d_neg_width_height),
        ("teximage2d_max_width_height", teximage2d_max_width_height),
        ("teximage2d_invalid_border", teximage2d_invalid_border),
        ("teximage2d_invalid_buffer_target", teximage2d_invalid_buffer_target),
        ("texsubimage2d", texsubimage2d),
        ("texsubimage2d_neg_level", texsubimage2d_neg_level),
        ("texsubimage2d_max_level", texsubimage2d_max_level),
        ("texsubimage2d_neg_offset", texsubimage2d_neg_offset),
        ("texsubimage2d_invalid_offset", texsubimage2d_invalid_offset),
        ("texsubimage2d_neg_width_height", texsubimage2d_neg_width_height),
        ("texsubimage2d_invalid_buffer_target", texsubimage2d_invalid_buffer_target),
        ("texparameteri", texparameteri),
        ("texparameterf", texparameterf),
        ("texparameteriv", texparameteriv),
        ("texparameterfv", texparameterfv),
        ("compressedtexsubimage2d", compressedtexsubimage2d),
        ("compressedtexsubimage2d_neg_level", compressedtexsubimage2d_neg_level),
        ("compressedtexsubimage2d_max_level", compressedtexsubimage2d_max_level),
        ("compressedtexsubimage2d_neg_offset", compressedtexsubimage2d_neg_offset),
        ("compressedtexsubimage2d_invalid_offset", compressedtexsubimage2d_invalid_offset),
        ("compressedtexsubimage2d_neg_width_height", compressedtexsubimage2d_neg_width_height),
        ("compressedtexsubimage2d_invalid_size", compressedtexsubimage2d_invalid_size),
        ("compressedtexsubimage2d_invalid_buffer_target", compressedtexsubimage2d_invalid_buffer_target),
        ("teximage3d", teximage3d),
        ("teximage3d_neg_level", teximage3d_neg_level),
        ("teximage3d_max_level", teximage3d_max_level),
        ("teximage3d_neg_width_height_depth", teximage3d_neg_width_height_depth),
        ("teximage3d_max_width_height_depth", teximage3d_max_width_height_depth),
        ("teximage3d_invalid_border", teximage3d_invalid_border),
        ("teximage3d_invalid_buffer_target", teximage3d_invalid_buffer_target),
        ("texsubimage3d", texsubimage3d),
        ("texsubimage3d_neg_level", texsubimage3d_neg_level),
        ("texsubimage3d_max_level", texsubimage3d_max_level),
        ("texsubimage3d_neg_offset", texsubimage3d_neg_offset),
        ("texsubimage3d_invalid_offset", texsubimage3d_invalid_offset),
        ("texsubimage3d_neg_width_height", texsubimage3d_neg_width_height),
        ("texsubimage3d_invalid_buffer_target", texsubimage3d_invalid_buffer_target),
    ];
    add_api_cases(&mut group, cases);
    group
}
