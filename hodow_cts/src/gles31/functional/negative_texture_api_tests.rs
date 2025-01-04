// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeTextureApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream spells the same call out once
// per cube face over and over; here those runs are loops over `CUBE_FACES` (upstream's
// `FOR_CUBE_FACES` order) or `CUBE_FACES_LISTED` (the +X +Y +Z -X -Y -Z order its
// hand-written lists use). The `isES` branches are resolved at port time - this port only
// ever runs an ES context.

use std::ffi::c_void;

use crate::gles31::functional::negative_test_shared::{BAD_ENUM, FunctionContainer, NegativeTestContext};
use crate::glw::{self, GLenum, GLfloat, GLint, GLsizei, GLubyte, GLuint};
use crate::tcu::TestError;

/// `deLog2Floor32(v) + 1`
fn log2_floor32(v: GLint) -> GLint {
    31 - (v as u32).leading_zeros() as GLint
}

/// `divRoundUp`
const fn div_round_up(a: i32, b: i32) -> i32 {
    a / b + if a % b != 0 { 1 } else { 0 }
}

/// `etc2DataSize`
const fn etc2_data_size(width: i32, height: i32) -> GLsizei {
    div_round_up(width, 4) * div_round_up(height, 4) * 8
}

/// `etc2EacDataSize`
const fn etc2_eac_data_size(width: i32, height: i32) -> GLsizei {
    2 * etc2_data_size(width, height)
}

/// `FOR_CUBE_FACES` - `cubeFaceToGLFace` over `tcu::CubeFace`, which starts at -X.
const CUBE_FACES: &[GLenum] = &[
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

/// The order upstream's hand-written per-face lists use.
const CUBE_FACES_LISTED: &[(GLenum, &str)] = &[
    (
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        "GL_TEXTURE_CUBE_MAP_POSITIVE_X target",
    ),
    (
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        "GL_TEXTURE_CUBE_MAP_POSITIVE_Y target",
    ),
    (
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        "GL_TEXTURE_CUBE_MAP_POSITIVE_Z target",
    ),
    (
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        "GL_TEXTURE_CUBE_MAP_NEGATIVE_X target",
    ),
    (
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        "GL_TEXTURE_CUBE_MAP_NEGATIVE_Y target",
    ),
    (
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        "GL_TEXTURE_CUBE_MAP_NEGATIVE_Z target",
    ),
];

/// `supportsES32orGL45`
fn supports_es32(ctx: &NegativeTestContext<'_>) -> bool {
    ctx.context_supports(3, 2)
}

/// `glTexImage2D(target, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, nullptr)`, which
/// is how most of these cases give a texture something to complain about.
fn rgba_image(ctx: &NegativeTestContext<'_>, target: GLenum, size: GLsizei) {
    // SAFETY: a null `pixels` means "allocate, do not upload", which reads nothing.
    unsafe {
        ctx.gl().tex_image_2d(
            target,
            0,
            glw::GL_RGBA as GLint,
            size,
            size,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
}

// glActiveTexture

fn activetexture(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if texture is not one of GL_TEXTUREi, where i ranges from 0 to (GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS - 1).");
    // SAFETY: every call in this file is deliberately invalid; a conformant driver raises
    // an error and changes nothing.
    unsafe {
        ctx.gl().active_texture(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        let units = ctx.get_integer(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS) as GLenum;
        ctx.gl().active_texture(glw::GL_TEXTURE0 + units);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

// glBindTexture

fn bindtexture(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture = [0 as GLuint; 5];
    let cube_map_array = supports_es32(ctx) || ctx.is_extension_supported("GL_OES_texture_cube_map_array");

    // SAFETY: as above; the five texture names are this function's own.
    unsafe {
        ctx.gl().gen_textures(5, texture.as_mut_ptr());

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the allowable values.");
        ctx.gl().bind_texture(0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().bind_texture(glw::GL_FRAMEBUFFER, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if texture was previously created with a target that doesn't match that of target.");
        // Each name is first bound to its own target, then to each of the other three,
        // every one of which is the error under test.
        const TARGETS: &[GLenum] = &[
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_3D,
            glw::GL_TEXTURE_2D_ARRAY,
        ];
        for (index, &own) in TARGETS.iter().enumerate() {
            ctx.gl().bind_texture(own, texture[index]);
            ctx.expect_error(glw::GL_NO_ERROR);
            for &other in TARGETS {
                if other == own {
                    continue;
                }
                ctx.gl().bind_texture(other, texture[index]);
                ctx.expect_error(glw::GL_INVALID_OPERATION);
            }
        }

        if cube_map_array {
            for name in &texture[..4] {
                ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, *name);
                ctx.expect_error(glw::GL_INVALID_OPERATION);
            }
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture[4]);
            ctx.expect_error(glw::GL_NO_ERROR);
            for &other in TARGETS {
                ctx.gl().bind_texture(other, texture[4]);
                ctx.expect_error(glw::GL_INVALID_OPERATION);
            }
        }
        ctx.end_section();

        ctx.gl().delete_textures(5, texture.as_ptr());
    }
    Ok(())
}

// glCompressedTexImage2D

/// `glCompressedTexImage2D` with a null data pointer, which every call here passes.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn compressed_tex_image_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    internal_format: GLenum,
    width: GLsizei,
    height: GLsizei,
    border: GLint,
    image_size: GLsizei,
) {
    // SAFETY: a null `data` with no pixel unpack buffer bound reads nothing; the call is
    // rejected before it would.
    unsafe {
        ctx.gl().compressed_tex_image_2d(
            target,
            level,
            internal_format,
            width,
            height,
            border,
            image_size,
            std::ptr::null(),
        );
    }
}

fn compressedteximage2d_invalid_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    compressed_tex_image_2d(ctx, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    compressed_tex_image_2d(
        ctx,
        glw::GL_TEXTURE_CUBE_MAP,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_invalid_format(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if internalformat is not a supported format returned in GL_COMPRESSED_TEXTURE_FORMATS.");
    for format in [0, glw::GL_RGBA, glw::GL_RGBA32F] {
        compressed_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, format, 0, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    for (face, _) in CUBE_FACES_LISTED {
        compressed_tex_image_2d(ctx, *face, 0, 0, 0, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    compressed_tex_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        -1,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    for (face, _) in CUBE_FACES_LISTED {
        compressed_tex_image_2d(ctx, *face, -1, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section(
        "GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE) for a 2d texture target.",
    );
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    compressed_tex_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        log2_max_texture_size,
        glw::GL_COMPRESSED_RGB8_ETC2,
        16,
        16,
        0,
        etc2_data_size(16, 16),
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE) for a cubemap target.");
    let log2_max_cubemap_size = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    for (face, _) in CUBE_FACES_LISTED {
        compressed_tex_image_2d(
            ctx,
            *face,
            log2_max_cubemap_size,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            16,
            16,
            0,
            etc2_eac_data_size(16, 16),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than 0.");

    for (target, label) in
        std::iter::once((glw::GL_TEXTURE_2D, "GL_TEXTURE_2D target")).chain(CUBE_FACES_LISTED.iter().copied())
    {
        ctx.begin_section(label);
        for (w, h) in [(-1, 0), (0, -1), (-1, -1)] {
            compressed_tex_image_2d(ctx, target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, w, h, 0, 0);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_max_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_texture_size = ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_cubemap_size = ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");

    for (target, label, max) in std::iter::once((glw::GL_TEXTURE_2D, "GL_TEXTURE_2D target", max_texture_size))
        .chain(CUBE_FACES_LISTED.iter().map(|(f, l)| (*f, *l, max_cubemap_size)))
    {
        ctx.begin_section(label);
        for (w, h) in [(max, 1), (1, max), (max, max)] {
            compressed_tex_image_2d(
                ctx,
                target,
                0,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                w,
                h,
                0,
                etc2_eac_data_size(w, h),
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_invalid_border(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if border is not 0.");

    for (target, label) in
        std::iter::once((glw::GL_TEXTURE_2D, "GL_TEXTURE_2D target")).chain(CUBE_FACES_LISTED.iter().copied())
    {
        ctx.begin_section(label);
        for border in [1, -1] {
            compressed_tex_image_2d(ctx, target, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0, 0, border, 0);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

/// The ETC2/EAC formats `compressedteximage2d_invalid_size` walks, with the block width,
/// block height and bytes per block each needs.
const ETC_BLOCK_SIZES: &[(GLenum, i32, i32, i32)] = &[
    (glw::GL_COMPRESSED_R11_EAC, 4, 4, 8),
    (glw::GL_COMPRESSED_SIGNED_R11_EAC, 4, 4, 8),
    (glw::GL_COMPRESSED_RG11_EAC, 4, 4, 16),
    (glw::GL_COMPRESSED_SIGNED_RG11_EAC, 4, 4, 16),
    (glw::GL_COMPRESSED_RGB8_ETC2, 4, 4, 8),
    (glw::GL_COMPRESSED_SRGB8_ETC2, 4, 4, 8),
    (glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2, 4, 4, 8),
    (glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2, 4, 4, 8),
    (glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 4, 4, 16),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC, 4, 4, 16),
];

/// The ASTC formats and their block dimensions; every one is 16 bytes per block.
const ASTC_BLOCK_SIZES: &[(GLenum, i32, i32)] = &[
    (glw::GL_COMPRESSED_RGBA_ASTC_4x4, 4, 4),
    (glw::GL_COMPRESSED_RGBA_ASTC_5x4, 5, 4),
    (glw::GL_COMPRESSED_RGBA_ASTC_5x5, 5, 5),
    (glw::GL_COMPRESSED_RGBA_ASTC_6x5, 6, 5),
    (glw::GL_COMPRESSED_RGBA_ASTC_6x6, 6, 6),
    (glw::GL_COMPRESSED_RGBA_ASTC_8x5, 8, 5),
    (glw::GL_COMPRESSED_RGBA_ASTC_8x6, 8, 6),
    (glw::GL_COMPRESSED_RGBA_ASTC_8x8, 8, 8),
    (glw::GL_COMPRESSED_RGBA_ASTC_10x5, 10, 5),
    (glw::GL_COMPRESSED_RGBA_ASTC_10x6, 10, 6),
    (glw::GL_COMPRESSED_RGBA_ASTC_10x8, 10, 8),
    (glw::GL_COMPRESSED_RGBA_ASTC_10x10, 10, 10),
    (glw::GL_COMPRESSED_RGBA_ASTC_12x10, 12, 10),
    (glw::GL_COMPRESSED_RGBA_ASTC_12x12, 12, 12),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4, 4, 4),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4, 5, 4),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5, 5, 5),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5, 6, 5),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6, 6, 6),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5, 8, 5),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6, 8, 6),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8, 8, 8),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5, 10, 5),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6, 10, 6),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8, 10, 8),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10, 10, 10),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10, 12, 10),
    (glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12, 12, 12),
];

fn compressedteximage2d_invalid_size(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let astc = supports_es32(ctx) || ctx.is_extension_supported("GL_KHR_texture_compression_astc_ldr");

    ctx.begin_section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    // The -1 is what deviates from the size a 1x1 image of each format really needs.
    for (format, bw, bh, bytes) in ETC_BLOCK_SIZES {
        let size = div_round_up(1, *bw) * div_round_up(1, *bh) * bytes - 1;
        compressed_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, *format, 1, 1, 0, size);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }

    if astc {
        for (format, bw, bh) in ASTC_BLOCK_SIZES {
            let size = div_round_up(1, *bw) * div_round_up(1, *bh) * 16 - 1;
            compressed_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, *format, 1, 1, 0, size);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_neg_size(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if imageSize is negative.");
    compressed_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, glw::GL_COMPRESSED_R11_EAC, 0, 0, 0, -1);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_invalid_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if target is a cube map face and width and height are not equal.");
    for (face, label) in CUBE_FACES_LISTED {
        ctx.begin_section(label);
        compressed_tex_image_2d(
            ctx,
            *face,
            0,
            glw::GL_COMPRESSED_R11_EAC,
            1,
            2,
            0,
            div_round_up(1, 4) * div_round_up(2, 4) * 8,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage2d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf: GLuint = 0;
    let data = [0 as GLubyte; 64];

    // SAFETY: as above; the buffer gets 64 bytes from a 64-byte source and is deleted at
    // the end.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            64,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT);
        compressed_tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGB8_ETC2,
            4,
            4,
            0,
            etc2_data_size(4, 4),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        compressed_tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGB8_ETC2,
            16,
            16,
            0,
            etc2_data_size(16, 16),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    Ok(())
}

// glCopyTexImage2D

/// `glCopyTexImage2D`, which every call here makes from the current read buffer.
fn copy_tex_image_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    internal_format: GLenum,
    width: GLsizei,
    height: GLsizei,
    border: GLint,
) {
    // SAFETY: a copy from the read buffer touches no caller memory.
    unsafe {
        ctx.gl()
            .copy_tex_image_2d(target, level, internal_format, 0, 0, width, height, border);
    }
}

fn copyteximage2d_invalid_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    copy_tex_image_2d(ctx, 0, 0, glw::GL_RGB, 64, 64, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();
    Ok(())
}

fn copyteximage2d_invalid_format(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM or GL_INVALID_VALUE is generated if internalformat is not an accepted format.");
    copy_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 64, 64, 0);
    ctx.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
    for (face, _) in CUBE_FACES_LISTED {
        copy_tex_image_2d(ctx, *face, 0, 0, 16, 16, 0);
        ctx.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn copyteximage2d_inequal_width_height_cube(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.");
    for (face, _) in CUBE_FACES_LISTED {
        copy_tex_image_2d(ctx, *face, 0, glw::GL_RGB, 16, 17, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn copyteximage2d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    copy_tex_image_2d(ctx, glw::GL_TEXTURE_2D, -1, glw::GL_RGB, 64, 64, 0);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    for (face, _) in CUBE_FACES_LISTED {
        copy_tex_image_2d(ctx, *face, -1, glw::GL_RGB, 16, 16, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn copyteximage2d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    copy_tex_image_2d(ctx, glw::GL_TEXTURE_2D, log2_max_texture_size, glw::GL_RGB, 64, 64, 0);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    for (face, _) in CUBE_FACES_LISTED {
        copy_tex_image_2d(ctx, *face, log2_max_cubemap_size, glw::GL_RGB, 16, 16, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn copyteximage2d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than 0.");

    for (target, label) in
        std::iter::once((glw::GL_TEXTURE_2D, "GL_TEXTURE_2D target")).chain(CUBE_FACES_LISTED.iter().copied())
    {
        ctx.begin_section(label);
        for (w, h) in [(-1, 1), (1, -1), (-1, -1)] {
            copy_tex_image_2d(ctx, target, 0, glw::GL_RGB, w, h, 0);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

fn copyteximage2d_max_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_texture_size = ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_cubemap_size = ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");

    ctx.begin_section("GL_TEXTURE_2D target");
    for (w, h) in [
        (max_texture_size, 1),
        (1, max_texture_size),
        (max_texture_size, max_texture_size),
    ] {
        copy_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, glw::GL_RGB, w, h, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // \note the cube-map lists put the (1, max) pair first, unlike the 2D one above.
    for (face, label) in CUBE_FACES_LISTED {
        ctx.begin_section(label);
        for (w, h) in [
            (1, max_cubemap_size),
            (max_cubemap_size, 1),
            (max_cubemap_size, max_cubemap_size),
        ] {
            copy_tex_image_2d(ctx, *face, 0, glw::GL_RGB, w, h, 0);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

fn copyteximage2d_invalid_border(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if border is not 0.");

    // \note upstream labels the +Z section "GL_TEXTURE_2D target"; the label is only logged.
    for (target, label) in
        std::iter::once((glw::GL_TEXTURE_2D, "GL_TEXTURE_2D target")).chain(CUBE_FACES_LISTED.iter().copied())
    {
        ctx.begin_section(label);
        for border in [-1, 1] {
            copy_tex_image_2d(ctx, target, 0, glw::GL_RGB, 0, 0, border);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

fn copyteximage2d_incomplete_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;

    // SAFETY: as above; the framebuffer is this function's own.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }

    ctx.begin_section(
        "GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.",
    );
    copy_tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, glw::GL_RGBA8, 0, 0, 0);
    ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    for (face, _) in CUBE_FACES_LISTED {
        copy_tex_image_2d(ctx, *face, 0, glw::GL_RGBA8, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().delete_framebuffers(1, &fbo);
    }
    Ok(())
}

// glCopyTexSubImage2D

/// `glCopyTexSubImage2D`, always from (0, 0) of the read buffer.
fn copy_tex_sub_image_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    xoffset: GLint,
    yoffset: GLint,
    width: GLsizei,
    height: GLsizei,
) {
    // SAFETY: as in `copy_tex_image_2d`.
    unsafe {
        ctx.gl()
            .copy_tex_sub_image_2d(target, level, xoffset, yoffset, 0, 0, width, height);
    }
}

/// One 16x16 RGBA `GL_TEXTURE_2D`, which most `copytexsubimage2d_*` cases start from. The
/// name is returned so the caller can delete it.
fn bound_2d_texture(ctx: &NegativeTestContext<'_>, internal_format: GLenum, format: GLenum, ty: GLenum) -> GLuint {
    let mut texture: GLuint = 0;
    // SAFETY: as above; a null `pixels` uploads nothing.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            internal_format as GLint,
            16,
            16,
            0,
            format,
            ty,
            std::ptr::null(),
        );
    }
    texture
}

fn delete_texture(ctx: &NegativeTestContext<'_>, texture: GLuint) {
    // SAFETY: the name is the caller's own and is deleted exactly once.
    unsafe { ctx.gl().delete_textures(1, &texture) };
}

fn copytexsubimage2d_invalid_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_2d_texture(ctx, glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);

    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    copy_tex_sub_image_2d(ctx, 0, 0, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage2d_read_buffer_is_none(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_2d_texture(ctx, glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);

    ctx.begin_section("GL_INVALID_OPERATION is generated if the read buffer is NONE");
    // SAFETY: as above.
    unsafe { ctx.gl().read_buffer(glw::GL_NONE) };
    copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage2d_texture_internalformat(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_2d_texture(ctx, glw::GL_RGB9_E5, glw::GL_RGB, glw::GL_FLOAT);

    ctx.begin_section("GL_INVALID_OPERATION is generated if internal format of the texture is GL_RGB9_E5");
    copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

/// One 16x16 RGBA 2D texture and one cube map with all six faces, which the two
/// `copytexsubimage2d_*_level` cases start from.
fn bound_2d_and_cube_textures(ctx: &NegativeTestContext<'_>) -> [GLuint; 2] {
    let mut textures = [0 as GLuint; 2];
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        rgba_image(ctx, glw::GL_TEXTURE_2D, 16);
        ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[1]);
        for &face in CUBE_FACES {
            rgba_image(ctx, face, 16);
        }
    }
    textures
}

fn copytexsubimage2d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let textures = bound_2d_and_cube_textures(ctx);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, -1, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    for &face in CUBE_FACES {
        copy_tex_sub_image_2d(ctx, face, -1, 0, 0, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn copytexsubimage2d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let textures = bound_2d_and_cube_textures(ctx);

    ctx.begin_section(
        "GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE) for 2D texture targets.",
    );
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, log2_max_texture_size, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section(
        "GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_SIZE) for cubemap targets.",
    );
    let log2_max_cubemap_size = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    for &face in CUBE_FACES {
        copy_tex_sub_image_2d(ctx, face, log2_max_cubemap_size, 0, 0, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn copytexsubimage2d_neg_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_2d_texture(ctx, glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);

    ctx.begin_section("GL_INVALID_VALUE is generated if xoffset < 0 or yoffset < 0.");
    for (x, y) in [(-1, 0), (0, -1), (-1, -1)] {
        copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, x, y, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage2d_invalid_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_2d_texture(ctx, glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);

    ctx.begin_section(
        "GL_INVALID_VALUE is generated if xoffset + width > texture_width or yoffset + height > texture_height.",
    );
    for (x, y) in [(14, 0), (0, 14), (14, 14)] {
        copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, x, y, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage2d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_2d_texture(ctx, glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    for (w, h) in [(-1, 0), (0, -1), (-1, -1)] {
        copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, w, h);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage2d_incomplete_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section(
        "GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.",
    );

    let mut texture = [0 as GLuint; 2];
    let mut fbo: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, texture.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        rgba_image(ctx, glw::GL_TEXTURE_2D, 4);
        ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[1]);
        for (face, _) in CUBE_FACES_LISTED {
            rgba_image(ctx, *face, 4);
        }
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
        ctx.expect_error(glw::GL_NO_ERROR);
    }

    copy_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0);
    ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    for (face, _) in CUBE_FACES_LISTED {
        copy_tex_sub_image_2d(ctx, *face, 0, 0, 0, 0, 0);
        ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    }

    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_textures(2, texture.as_ptr());
    }

    ctx.end_section();
    Ok(())
}

// glDeleteTextures

fn deletetextures(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;

    // SAFETY: as above; a rejected count never reads the null array.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);

        ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
        ctx.gl().delete_textures(-1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);

        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().delete_textures(-1, std::ptr::null());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_textures(1, &texture);
    }
    Ok(())
}

// glGenerateMipmap

fn generatemipmap(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture = [0 as GLuint; 2];
    let float_linear = ctx.is_extension_supported("GL_EXT_color_buffer_float")
        && ctx.is_extension_supported("GL_OES_texture_float_linear");

    // SAFETY: as above; every `tex_image_2d` here uploads nothing.
    unsafe {
        ctx.gl().gen_textures(2, texture.as_mut_ptr());

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not GL_TEXTURE_2D or GL_TEXTURE_CUBE_MAP.");
        ctx.gl().generate_mipmap(0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("INVALID_OPERATION is generated if the texture bound to target is not cube complete.");
        ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[0]);
        ctx.gl().tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_REPEAT as GLint,
        );
        rgb_image(ctx, glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X, 0);
        ctx.gl().generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[0]);
        // Five faces at 16x16 and one at 32x32, which is what makes it cube-incomplete.
        for (face, _) in &CUBE_FACES_LISTED[..5] {
            rgb_image(ctx, *face, 16);
        }
        rgb_image(ctx, glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, 32);
        ctx.gl().generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if the zero level array is stored in a compressed internal format.",
        );
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture[1]);
        compressed_tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
            0,
            0,
            0,
        );
        ctx.gl().generate_mipmap(glw::GL_TEXTURE_2D);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if the level base array was not specified with an unsized internal format or a sized internal format that is both color-renderable and texture-filterable.");
        for (internal, format, ty) in [
            (glw::GL_RGB8_SNORM, glw::GL_RGB, glw::GL_BYTE),
            (glw::GL_R8I, glw::GL_RED_INTEGER, glw::GL_BYTE),
        ] {
            ctx.gl().tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                internal as GLint,
                0,
                0,
                0,
                format,
                ty,
                std::ptr::null(),
            );
            ctx.gl().generate_mipmap(glw::GL_TEXTURE_2D);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }

        if !float_linear {
            ctx.gl().tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32F as GLint,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null(),
            );
            ctx.gl().generate_mipmap(glw::GL_TEXTURE_2D);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, texture.as_ptr());
    }
    Ok(())
}

/// `glTexImage2D(target, 0, GL_RGB, size, size, 0, GL_RGB, GL_UNSIGNED_BYTE, nullptr)`
fn rgb_image(ctx: &NegativeTestContext<'_>, target: GLenum, size: GLsizei) {
    // SAFETY: a null `pixels` uploads nothing.
    unsafe {
        ctx.gl().tex_image_2d(
            target,
            0,
            glw::GL_RGB as GLint,
            size,
            size,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
    }
}

// glGenTextures

fn gentextures(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(-1, std::ptr::null_mut());
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

// glPixelStorei

fn pixelstorei(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
        ctx.gl().pixel_storei(0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if a negative row length, pixel skip, or row skip value is specified, or if alignment is specified as other than 1, 2, 4, or 8.",
        );
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
            ctx.gl().pixel_storei(pname, -1);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        for value in [0, 16] {
            ctx.gl().pixel_storei(glw::GL_PACK_ALIGNMENT, value);
            ctx.expect_error(glw::GL_INVALID_VALUE);
            ctx.gl().pixel_storei(glw::GL_UNPACK_ALIGNMENT, value);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }
    Ok(())
}

// glTexImage2D

/// `glTexImage2D` with a null `pixels`, which is what all but the byte-offset cases pass.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn tex_image_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    internal_format: GLenum,
    width: GLsizei,
    height: GLsizei,
    border: GLint,
    format: GLenum,
    ty: GLenum,
) {
    // SAFETY: a null `pixels` with no pixel unpack buffer bound uploads nothing.
    unsafe {
        ctx.gl().tex_image_2d(
            target,
            level,
            internal_format as GLint,
            width,
            height,
            border,
            format,
            ty,
            std::ptr::null(),
        );
    }
}

/// `glTexSubImage2D` with a null `pixels`.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn tex_sub_image_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    xoffset: GLint,
    yoffset: GLint,
    width: GLsizei,
    height: GLsizei,
    format: GLenum,
    ty: GLenum,
) {
    // SAFETY: as above.
    unsafe {
        ctx.gl().tex_sub_image_2d(
            target,
            level,
            xoffset,
            yoffset,
            width,
            height,
            format,
            ty,
            std::ptr::null(),
        );
    }
}

fn teximage2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    tex_image_2d(ctx, 0, 0, glw::GL_RGBA, 1, 1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_ENUM is generated if type is not a type constant.");
    tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, glw::GL_RGBA, 1, 1, 0, glw::GL_RGBA, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section(
        "GL_INVALID_OPERATION is generated if the combination of internalFormat, format and type is invalid.",
    );
    for (internal, format, ty) in [
        (glw::GL_RGBA, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_RGB5_A1, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_RGB10_A2, glw::GL_RGB, glw::GL_UNSIGNED_INT_2_10_10_10_REV),
        (glw::GL_RGB, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
        (glw::GL_RGBA32UI, glw::GL_RGBA_INTEGER, glw::GL_INT),
    ] {
        tex_image_2d(ctx, glw::GL_TEXTURE_2D, 0, internal, 1, 1, 0, format, ty);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();
    Ok(())
}

fn teximage2d_inequal_width_height_cube(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.");
    for (face, _) in CUBE_FACES_LISTED {
        tex_image_2d(ctx, *face, 0, glw::GL_RGB, 1, 2, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn teximage2d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    tex_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        -1,
        glw::GL_RGB,
        1,
        1,
        0,
        glw::GL_RGB,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    for (face, _) in CUBE_FACES_LISTED {
        tex_image_2d(ctx, *face, -1, glw::GL_RGB, 1, 1, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn teximage2d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    tex_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        log2_max_texture_size,
        glw::GL_RGB,
        1,
        1,
        0,
        glw::GL_RGB,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    for (face, _) in CUBE_FACES_LISTED {
        tex_image_2d(
            ctx,
            *face,
            log2_max_cubemap_size,
            glw::GL_RGB,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn teximage2d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than 0.");

    for (target, label) in
        std::iter::once((glw::GL_TEXTURE_2D, "GL_TEXTURE_2D target")).chain(CUBE_FACES_LISTED.iter().copied())
    {
        ctx.begin_section(label);
        for (w, h) in [(-1, 1), (1, -1), (-1, -1)] {
            tex_image_2d(ctx, target, 0, glw::GL_RGB, w, h, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }

    ctx.end_section();
    Ok(())
}

fn teximage2d_max_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_texture_size = ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_cubemap_size = ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");
    for (w, h) in [
        (max_texture_size, 1),
        (1, max_texture_size),
        (max_texture_size, max_texture_size),
    ] {
        tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB,
            w,
            h,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_CUBE_MAP_TEXTURE_SIZE.");
    for (face, label) in CUBE_FACES_LISTED {
        ctx.begin_section(label);
        for (w, h) in [
            (max_cubemap_size, 1),
            (1, max_cubemap_size),
            (max_cubemap_size, max_cubemap_size),
        ] {
            tex_image_2d(ctx, *face, 0, glw::GL_RGB, w, h, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();
    }
    ctx.end_section();
    Ok(())
}

fn teximage2d_invalid_border(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if border is not 0.");
    for border in [1, -1] {
        tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB,
            1,
            1,
            border,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    // \note the cube faces are only tried with border 1.
    for (face, _) in CUBE_FACES_LISTED {
        tex_image_2d(ctx, *face, 0, glw::GL_RGB, 1, 1, 1, glw::GL_RGB, glw::GL_UNSIGNED_BYTE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

/// A 64-byte `GL_PIXEL_UNPACK_BUFFER` and a bound 2D texture, which the two
/// `*_invalid_buffer_target` cases build on. The caller deletes both.
fn unpack_buffer_and_texture(ctx: &NegativeTestContext<'_>) -> (GLuint, GLuint) {
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0 as GLubyte; 64];

    // SAFETY: the buffer gets 64 bytes from a 64-byte source.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            64,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
    }
    (buf, texture)
}

/// A byte offset into the bound pixel unpack buffer, which is what `pixels` means while
/// one is bound.
fn byte_offset(offset: usize) -> *const c_void {
    std::ptr::without_provenance(offset)
}

fn teximage2d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let (buf, texture) = unpack_buffer_and_texture(ctx);
    ctx.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above; `pixels` is an offset into the bound unpack buffer, not a pointer
    // into this process.
    unsafe {
        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

        ctx.begin_section("...the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT);
        tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            64,
            64,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
        log::debug!("// Set byte offset = 3");
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB5_A1 as GLint,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            byte_offset(3),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().delete_textures(1, &texture);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    Ok(())
}

// glTexSubImage2D

fn texsubimage2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        rgba_image(ctx, glw::GL_TEXTURE_2D, 32);
    }
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    tex_sub_image_2d(ctx, 0, 0, 0, 0, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    // \note upstream's argument list here is one short, so `format` lands in `height` and
    // `GL_UNSIGNED_BYTE` in `format`; the call is still the invalid-format case it means.
    ctx.begin_section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 0, 4, 4, glw::GL_UNSIGNED_BYTE);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_ENUM is generated if type is not a type constant.");
    tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, glw::GL_RGB, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_OPERATION is generated if the combination of internalFormat of the previously specified texture array, format and type is not valid.");
    for (format, ty) in [
        (glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_6_5),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT),
        (glw::GL_RGB, glw::GL_FLOAT),
    ] {
        tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 4, 4, format, ty);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

/// One 32x32 RGB 2D texture plus a second name whose six cube faces are 32x32 RGB, which
/// the two `texsubimage2d_*_level` cases start from.
fn rgb_2d_and_cube_textures(ctx: &NegativeTestContext<'_>, second_target: GLenum) -> [GLuint; 2] {
    let mut textures = [0 as GLuint; 2];
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        rgb_image(ctx, glw::GL_TEXTURE_2D, 32);
        ctx.gl().bind_texture(second_target, textures[1]);
        for &face in CUBE_FACES {
            rgb_image(ctx, face, 32);
        }
    }
    textures
}

fn texsubimage2d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // \note upstream binds the second name to GL_TEXTURE_2D here, not GL_TEXTURE_CUBE_MAP,
    // so the six `glTexImage2D` calls below it all fail; the case under test is unaffected.
    let textures = rgb_2d_and_cube_textures(ctx, glw::GL_TEXTURE_2D);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        -1,
        0,
        0,
        0,
        0,
        glw::GL_RGB,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    for &face in CUBE_FACES {
        tex_sub_image_2d(ctx, face, -1, 0, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn texsubimage2d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let textures = rgb_2d_and_cube_textures(ctx, glw::GL_TEXTURE_CUBE_MAP);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        log2_max_texture_size,
        0,
        0,
        0,
        0,
        glw::GL_RGB,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    for &face in CUBE_FACES {
        tex_sub_image_2d(
            ctx,
            face,
            log2_max_cubemap_size,
            0,
            0,
            0,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn texsubimage2d_neg_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        rgb_image(ctx, glw::GL_TEXTURE_2D, 32);
    }
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if xoffset or yoffset are negative.");
    for (x, y) in [(-1, 0), (0, -1), (-1, -1)] {
        tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            x,
            y,
            0,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn texsubimage2d_invalid_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        rgba_image(ctx, glw::GL_TEXTURE_2D, 32);
    }
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section(
        "GL_INVALID_VALUE is generated if xoffset + width > texture_width or yoffset + height > texture_height.",
    );
    for (x, y) in [(30, 0), (0, 30), (30, 30)] {
        tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            x,
            y,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn texsubimage2d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        rgba_image(ctx, glw::GL_TEXTURE_2D, 32);
    }
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    for (w, h) in [(-1, 0), (0, -1), (-1, -1)] {
        tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            w,
            h,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn texsubimage2d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    let mut buf: GLuint = 0;
    let data = [0 as GLubyte; 64];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        rgba_image(ctx, glw::GL_TEXTURE_2D, 32);
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            64,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

        ctx.begin_section("...the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT);
        tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            32,
            32,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
        log::debug!("// Set byte offset = 3");
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
        tex_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA4,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
        );
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
            byte_offset(3),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().delete_textures(1, &texture);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    Ok(())
}

// glTexParameter*

/// The twelve `pname`s whose value is an enum, which every `texparameter*` case walks with
/// an invalid value.
const ENUM_PNAMES: &[GLenum] = &[
    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
    glw::GL_TEXTURE_COMPARE_MODE,
    glw::GL_TEXTURE_COMPARE_FUNC,
    glw::GL_TEXTURE_MAG_FILTER,
    glw::GL_TEXTURE_MIN_FILTER,
    glw::GL_TEXTURE_SWIZZLE_R,
    glw::GL_TEXTURE_SWIZZLE_G,
    glw::GL_TEXTURE_SWIZZLE_B,
    glw::GL_TEXTURE_SWIZZLE_A,
    glw::GL_TEXTURE_WRAP_S,
    glw::GL_TEXTURE_WRAP_T,
    glw::GL_TEXTURE_WRAP_R,
];

/// The ten `pname`s a multisample target rejects outright.
const MULTISAMPLE_PNAMES: &[GLenum] = &[
    glw::GL_TEXTURE_BORDER_COLOR,
    glw::GL_TEXTURE_MIN_FILTER,
    glw::GL_TEXTURE_MAG_FILTER,
    glw::GL_TEXTURE_WRAP_S,
    glw::GL_TEXTURE_WRAP_T,
    glw::GL_TEXTURE_WRAP_R,
    glw::GL_TEXTURE_MIN_LOD,
    glw::GL_TEXTURE_MAX_LOD,
    glw::GL_TEXTURE_COMPARE_MODE,
    glw::GL_TEXTURE_COMPARE_FUNC,
];

/// Which `glTexParameter*` a shared body calls. The four flavours differ only in how the
/// one value that matters is spelled.
#[derive(Clone, Copy)]
enum TexParamKind {
    Int,
    Float,
    IntVec,
    FloatVec,
}

impl TexParamKind {
    /// # Safety
    /// The vector forms read four elements, which is what the scratch array below is.
    unsafe fn set(self, ctx: &NegativeTestContext<'_>, target: GLenum, pname: GLenum, value: GLint) {
        // The trailing elements are never read for a scalar pname; upstream leaves them at
        // GL_INVALID_ENUM, so this does too.
        let ints: [GLint; 4] = [value, BAD_ENUM as GLint, BAD_ENUM as GLint, BAD_ENUM as GLint];
        let floats: [GLfloat; 4] = [
            value as GLfloat,
            ints[1] as GLfloat,
            ints[2] as GLfloat,
            ints[3] as GLfloat,
        ];

        // SAFETY: the caller's contract.
        unsafe {
            match self {
                Self::Int => ctx.gl().tex_parameteri(target, pname, value),
                Self::Float => ctx.gl().tex_parameterf(target, pname, value as GLfloat),
                Self::IntVec => ctx.gl().tex_parameteriv(target, pname, ints.as_ptr()),
                Self::FloatVec => ctx.gl().tex_parameterfv(target, pname, floats.as_ptr()),
            }
        }
    }
}

/// The body `texparameteri` / `texparameterf` / `texparameteriv` / `texparameterfv` share.
fn texparameter_body(ctx: &mut NegativeTestContext<'_>, kind: TexParamKind) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    let es32 = supports_es32(ctx);
    let ms_array = es32 || ctx.is_extension_supported("GL_OES_texture_storage_multisample_2d_array");
    let linear = glw::GL_LINEAR as GLint;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);

        ctx.begin_section("GL_INVALID_ENUM is generated if target or pname is not one of the accepted defined values.");
        kind.set(ctx, 0, glw::GL_TEXTURE_MIN_FILTER, linear);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        kind.set(ctx, glw::GL_TEXTURE_2D, 0, linear);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        kind.set(ctx, 0, 0, linear);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_ENUM is generated if pname is enum and the value of param(s) is not a valid value.",
        );
        for &pname in ENUM_PNAMES {
            kind.set(ctx, glw::GL_TEXTURE_2D, pname, -1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if pname is GL_TEXTURE_BASE_LEVEL or GL_TEXTURE_MAX_LEVEL and param(s) is negative.");
        for pname in [glw::GL_TEXTURE_BASE_LEVEL, glw::GL_TEXTURE_MAX_LEVEL] {
            kind.set(ctx, glw::GL_TEXTURE_2D, pname, -1);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        // Only the two scalar forms reject GL_TEXTURE_BORDER_COLOR - passing it an array is
        // exactly what the vector forms are for, so upstream leaves this section out of them.
        if es32 && matches!(kind, TexParamKind::Int | TexParamKind::Float) {
            ctx.begin_section("GL_INVALID_ENUM is generated if pname is a non-scalar parameter.");
            kind.set(ctx, glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BORDER_COLOR, 0);
            ctx.expect_error(glw::GL_INVALID_ENUM);
            ctx.end_section();
        }

        ctx.begin_section("GL_INVALID_ENUM error is generated if target is GL_TEXTURE_2D_MULTISAMPLE or GL_TEXTURE_2D_MULTISAMPLE_ARRAY and pname is not valid.");
        for &pname in MULTISAMPLE_PNAMES {
            kind.set(ctx, glw::GL_TEXTURE_2D_MULTISAMPLE, pname, -1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        if ms_array {
            for &pname in MULTISAMPLE_PNAMES {
                kind.set(ctx, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, pname, -1);
                ctx.expect_error(glw::GL_INVALID_ENUM);
            }
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if target is GL_TEXTURE_2D_MULTISAMPLE or GL_TEXTURE_2D_MULTISAMPLE_ARRAY and pname GL_TEXTURE_BASE_LEVEL is not 0.");
        kind.set(ctx, glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_BASE_LEVEL, 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        if ms_array {
            kind.set(ctx, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, glw::GL_TEXTURE_BASE_LEVEL, 1);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().delete_textures(1, &texture);
    }
    Ok(())
}

fn texparameteri(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    texparameter_body(ctx, TexParamKind::Int)
}

fn texparameterf(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    texparameter_body(ctx, TexParamKind::Float)
}

fn texparameteriv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    texparameter_body(ctx, TexParamKind::IntVec)
}

fn texparameterfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    texparameter_body(ctx, TexParamKind::FloatVec)
}

/// The two integer-vector forms differ from the four above: they need ES 3.2, take no
/// texture of their own, and try both multisample targets unconditionally.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TexParamIKind {
    Signed,
    Unsigned,
}

impl TexParamIKind {
    /// # Safety
    /// Both forms read four elements, which is what the scratch array below is.
    unsafe fn set(self, ctx: &NegativeTestContext<'_>, target: GLenum, pname: GLenum, value: GLint) {
        // Upstream sets the first *two* elements, since its initial value is a pair.
        let ints: [GLint; 4] = [value, value, BAD_ENUM as GLint, BAD_ENUM as GLint];
        let uints: [GLuint; 4] = [value as GLuint, value as GLuint, BAD_ENUM, BAD_ENUM];

        // SAFETY: the caller's contract.
        unsafe {
            match self {
                Self::Signed => ctx.gl().tex_parameter_iiv(target, pname, ints.as_ptr()),
                Self::Unsigned => ctx.gl().tex_parameter_iuiv(target, pname, uints.as_ptr()),
            }
        }
    }
}

fn texparameter_i_body(ctx: &mut NegativeTestContext<'_>, kind: TexParamIKind, what: &str) -> Result<(), TestError> {
    if !supports_es32(ctx) {
        return Err(TestError::NotSupported(format!("{what} is not supported.")));
    }

    let depth_component = glw::GL_DEPTH_COMPONENT as GLint;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if target is not a valid target.");
        kind.set(ctx, 0, glw::GL_DEPTH_STENCIL_TEXTURE_MODE, depth_component);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not a valid parameter.");
        kind.set(ctx, glw::GL_TEXTURE_2D, 0, depth_component);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_ENUM is generated if pname is enum and the value of param(s) is not a valid value.",
        );
        for &pname in ENUM_PNAMES {
            kind.set(ctx, glw::GL_TEXTURE_2D, pname, -1);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        // \note only the signed form has this section: its `params` is a GLint array, so a
        // negative level is expressible there and not in the unsigned one.
        if kind == TexParamIKind::Signed {
            ctx.begin_section("GL_INVALID_VALUE is generated if pname is GL_TEXTURE_BASE_LEVEL or GL_TEXTURE_MAX_LEVEL and param(s) is negative.");
            for pname in [glw::GL_TEXTURE_BASE_LEVEL, glw::GL_TEXTURE_MAX_LEVEL] {
                kind.set(ctx, glw::GL_TEXTURE_2D, pname, -1);
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
            ctx.end_section();
        }

        ctx.begin_section("GL_INVALID_ENUM error is generated if target is GL_TEXTURE_2D_MULTISAMPLE or GL_TEXTURE_2D_MULTISAMPLE_ARRAY and pname is not valid.");
        for target in [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY] {
            for &pname in MULTISAMPLE_PNAMES {
                kind.set(ctx, target, pname, -1);
                ctx.expect_error(glw::GL_INVALID_ENUM);
            }
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if target is GL_TEXTURE_2D_MULTISAMPLE or GL_TEXTURE_2D_MULTISAMPLE_ARRAY and pname GL_TEXTURE_BASE_LEVEL is not 0.");
        for target in [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY] {
            kind.set(ctx, target, glw::GL_TEXTURE_BASE_LEVEL, 1);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();
    }
    Ok(())
}

#[expect(non_snake_case, reason = "upstream's case name, which the diff compares against")]
fn texparameterIiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    texparameter_i_body(ctx, TexParamIKind::Signed, "glTexParameterIiv")
}

#[expect(non_snake_case, reason = "upstream's case name, which the diff compares against")]
fn texparameterIuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    texparameter_i_body(ctx, TexParamIKind::Unsigned, "glTexParameterIuiv")
}

// glCompressedTexSubImage2D

/// `glCompressedTexSubImage2D` with a null data pointer.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn compressed_tex_sub_image_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    xoffset: GLint,
    yoffset: GLint,
    width: GLsizei,
    height: GLsizei,
    format: GLenum,
    image_size: GLsizei,
) {
    // SAFETY: as in `compressed_tex_image_2d`.
    unsafe {
        ctx.gl().compressed_tex_sub_image_2d(
            target,
            level,
            xoffset,
            yoffset,
            width,
            height,
            format,
            image_size,
            std::ptr::null(),
        );
    }
}

/// One `GL_TEXTURE_2D` holding a `size`x`size` ETC2/EAC image, which most
/// `compressedtexsubimage2d_*` cases start from.
fn bound_etc2_texture(ctx: &NegativeTestContext<'_>, size: GLsizei) -> GLuint {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
    }
    compressed_tex_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        size,
        size,
        0,
        etc2_eac_data_size(size, size),
    );
    texture
}

fn compressedtexsubimage2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    compressed_tex_sub_image_2d(ctx, 0, 0, 0, 0, 0, 0, glw::GL_COMPRESSED_RGB8_ETC2, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    let texture = bound_etc2_texture(ctx, 18);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_OPERATION is generated if format does not match the internal format of the texture image being modified.");
    compressed_tex_sub_image_2d(ctx, glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, glw::GL_COMPRESSED_RGB8_ETC2, 0);
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if width is not a multiple of four, and width + xoffset is not equal to the width of the texture level.",
    );
    compressed_tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        4,
        0,
        10,
        4,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        etc2_eac_data_size(10, 4),
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if height is not a multiple of four, and height + yoffset is not equal to the height of the texture level.",
    );
    compressed_tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        0,
        4,
        4,
        10,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        etc2_eac_data_size(4, 10),
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if xoffset or yoffset is not a multiple of four.",
    );
    for (x, y) in [(0, 1), (1, 0), (1, 1)] {
        compressed_tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            x,
            y,
            4,
            4,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(4, 4),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

/// One 18x18 ETC2/EAC 2D texture plus a cube map with all six faces the same, which the
/// two `compressedtexsubimage2d_*_level` cases start from.
fn bound_etc2_2d_and_cube(ctx: &NegativeTestContext<'_>) -> [GLuint; 2] {
    let mut textures = [0 as GLuint; 2];
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, textures[0]);
    }
    compressed_tex_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        18,
        18,
        0,
        etc2_eac_data_size(18, 18),
    );
    // SAFETY: as above.
    unsafe { ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[1]) };
    for &face in CUBE_FACES {
        compressed_tex_image_2d(
            ctx,
            face,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            18,
            18,
            0,
            etc2_eac_data_size(18, 18),
        );
    }
    textures
}

fn compressedtexsubimage2d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let textures = bound_etc2_2d_and_cube(ctx);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    compressed_tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        -1,
        0,
        0,
        0,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    for &face in CUBE_FACES {
        compressed_tex_sub_image_2d(ctx, face, -1, 0, 0, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn compressedtexsubimage2d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let textures = bound_etc2_2d_and_cube(ctx);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    compressed_tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        log2_max_texture_size,
        0,
        0,
        0,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).");
    let log2_max_cubemap_size = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;
    for &face in CUBE_FACES {
        compressed_tex_sub_image_2d(
            ctx,
            face,
            log2_max_cubemap_size,
            0,
            0,
            0,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn compressedtexsubimage2d_neg_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_texture(ctx, 8);

    // \note Both GL_INVALID_VALUE and GL_INVALID_OPERATION are valid here since an
    // implementation may check the offsets against the format before checking their sign.
    ctx.begin_section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if xoffset or yoffset are negative.");
    for (x, y) in [(-4, 0), (0, -4), (-4, -4)] {
        compressed_tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            x,
            y,
            0,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
        );
        ctx.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage2d_invalid_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_texture(ctx, 16);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if xoffset + width > texture_width or yoffset + height > texture_height.");
    for (x, y, w, h) in [(12, 0, 8, 4), (0, 12, 4, 8), (12, 12, 8, 8)] {
        compressed_tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            x,
            y,
            w,
            h,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(w, h),
        );
        ctx.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage2d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_texture(ctx, 16);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if width or height is less than 0.");
    for (w, h) in [(-4, 0), (0, -4), (-4, -4)] {
        compressed_tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            w,
            h,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
        );
        ctx.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage2d_invalid_size(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_texture(ctx, 16);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    compressed_tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        0,
        0,
        0,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        -1,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);

    compressed_tex_sub_image_2d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        0,
        0,
        16,
        16,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        4 * 4 * 16 - 1,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage2d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_texture(ctx, 16);
    let mut buf: GLuint = 0;
    let data = [0 as GLubyte; 128];

    // SAFETY: the buffer gets 128 bytes from a 128-byte source.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            128,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

        ctx.begin_section("...the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 128, glw::GL_MAP_WRITE_BIT);
        compressed_tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            4,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(4, 4),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        compressed_tex_sub_image_2d(
            ctx,
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            16,
            16,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(16, 16),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    delete_texture(ctx, texture);
    Ok(())
}

// glTexImage3D

/// `glTexImage3D` with a null `pixels`.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn tex_image_3d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    internal_format: GLenum,
    width: GLsizei,
    height: GLsizei,
    depth: GLsizei,
    border: GLint,
    format: GLenum,
    ty: GLenum,
) {
    // SAFETY: a null `pixels` with no pixel unpack buffer bound uploads nothing.
    unsafe {
        ctx.gl().tex_image_3d(
            target,
            level,
            internal_format as GLint,
            width,
            height,
            depth,
            border,
            format,
            ty,
            std::ptr::null(),
        );
    }
}

/// `GL_TEXTURE_CUBE_MAP_ARRAY` is core in ES 3.2 and an extension below it.
fn cube_map_array_supported(ctx: &NegativeTestContext<'_>) -> bool {
    supports_es32(ctx) || ctx.is_extension_supported("GL_OES_texture_cube_map_array")
}

fn teximage3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);

    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    tex_image_3d(ctx, 0, 0, glw::GL_RGBA, 1, 1, 1, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RGBA,
        1,
        1,
        1,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_ENUM is generated if type is not a type constant.");
    tex_image_3d(ctx, glw::GL_TEXTURE_3D, 0, glw::GL_RGBA, 1, 1, 1, 0, glw::GL_RGBA, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        0,
        glw::GL_RGBA,
        1,
        1,
        1,
        0,
        0,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if internalFormat is not one of the accepted resolution and format symbolic constants.");
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        0,
        0,
        1,
        1,
        1,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_OPERATION is generated if target is GL_TEXTURE_3D and format is GL_DEPTH_COMPONENT, or GL_DEPTH_STENCIL.");
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        0,
        glw::GL_DEPTH_STENCIL,
        1,
        1,
        1,
        0,
        glw::GL_DEPTH_STENCIL,
        glw::GL_UNSIGNED_INT_24_8,
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        0,
        glw::GL_DEPTH_COMPONENT,
        1,
        1,
        1,
        0,
        glw::GL_DEPTH_COMPONENT,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "GL_INVALID_OPERATION is generated if the combination of internalFormat, format and type is invalid.",
    );
    for (internal, format, ty) in [
        (glw::GL_RGBA, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_RGB5_A1, glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_RGB10_A2, glw::GL_RGB, glw::GL_UNSIGNED_INT_2_10_10_10_REV),
        (glw::GL_RGB, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
        (glw::GL_RGBA32UI, glw::GL_RGBA_INTEGER, glw::GL_INT),
    ] {
        tex_image_3d(ctx, glw::GL_TEXTURE_3D, 0, internal, 1, 1, 1, 0, format, ty);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    if cube_array {
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if target is GL_TEXTURE_CUBE_MAP_ARRAY and width and height are not equal.",
        );
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA,
            2,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_VALUE is generated if target is GL_TEXTURE_CUBE_MAP_ARRAY and depth is not a multiple of six.",
        );
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn teximage3d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        tex_image_3d(
            ctx,
            target,
            -1,
            glw::GL_RGB,
            1,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }

    if cube_array {
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            -1,
            glw::GL_RGBA,
            1,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn teximage3d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_3D_TEXTURE_SIZE).");
    let log2_max_3d = log2_floor32(ctx.get_integer(glw::GL_MAX_3D_TEXTURE_SIZE)) + 1;
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        log2_max_3d,
        glw::GL_RGB,
        1,
        1,
        1,
        0,
        glw::GL_RGB,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    tex_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        log2_max_texture,
        glw::GL_RGB,
        1,
        1,
        1,
        0,
        glw::GL_RGB,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();
    Ok(())
}

fn teximage3d_neg_width_height_depth(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);

    ctx.begin_section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        for (w, h, d) in [(-1, 1, 1), (1, -1, 1), (1, 1, -1), (-1, -1, -1)] {
            tex_image_3d(
                ctx,
                target,
                0,
                glw::GL_RGBA,
                w,
                h,
                d,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    if cube_array {
        for (w, h, d) in [(-1, 1, 6), (1, -1, 6), (1, 1, -6), (-1, -1, -6)] {
            tex_image_3d(
                ctx,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                glw::GL_RGBA,
                w,
                h,
                d,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }
    ctx.end_section();
    Ok(())
}

fn teximage3d_max_width_height_depth(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_3d = ctx.get_integer(glw::GL_MAX_3D_TEXTURE_SIZE) + 1;
    let max_texture = ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_layers = ctx.get_integer(glw::GL_MAX_ARRAY_TEXTURE_LAYERS) + 1;

    ctx.begin_section(
        "GL_INVALID_VALUE is generated if width, height or depth is greater than GL_MAX_3D_TEXTURE_SIZE.",
    );
    for (w, h, d) in [(max_3d, 1, 1), (1, max_3d, 1), (1, 1, max_3d), (max_3d, max_3d, max_3d)] {
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA,
            w,
            h,
            d,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if width, height or depth is greater than GL_MAX_TEXTURE_SIZE.");
    for (w, h, d) in [
        (max_texture, 1, 1),
        (1, max_texture, 1),
        (1, 1, max_layers),
        (max_texture, max_texture, max_layers),
    ] {
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA,
            w,
            h,
            d,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn teximage3d_invalid_border(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);

    ctx.begin_section("GL_INVALID_VALUE is generated if border is not 0 or 1.");
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        for border in [-1, 2] {
            tex_image_3d(
                ctx,
                target,
                0,
                glw::GL_RGB,
                1,
                1,
                1,
                border,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    if cube_array {
        // \note the cube-map-array calls pass level 1 and border -1/1, unlike the two above.
        for border in [-1, 1] {
            tex_image_3d(
                ctx,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                1,
                glw::GL_RGBA,
                1,
                1,
                6,
                border,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }
    ctx.end_section();
    Ok(())
}

fn teximage3d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf: GLuint = 0;
    let mut texture: GLuint = 0;
    let data = [0 as GLubyte; 512];

    // SAFETY: the buffer gets 512 bytes from a 512-byte source.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            512,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, texture);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

        ctx.begin_section("...the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 128, glw::GL_MAP_WRITE_BIT);
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA,
            4,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA,
            64,
            64,
            64,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
        log::debug!("// Set byte offset = 3");
        ctx.gl().tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGB5_A1 as GLint,
            4,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            byte_offset(3),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().delete_textures(1, &texture);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    Ok(())
}

// glTexSubImage3D

/// `glTexSubImage3D` with a null `pixels`.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn tex_sub_image_3d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    xoffset: GLint,
    yoffset: GLint,
    zoffset: GLint,
    width: GLsizei,
    height: GLsizei,
    depth: GLsizei,
    format: GLenum,
    ty: GLenum,
) {
    // SAFETY: as in `tex_image_3d`.
    unsafe {
        ctx.gl().tex_sub_image_3d(
            target,
            level,
            xoffset,
            yoffset,
            zoffset,
            width,
            height,
            depth,
            format,
            ty,
            std::ptr::null(),
        );
    }
}

/// One 4x4x4 RGBA image on `target`, bound to a fresh name.
fn bound_3d_texture(ctx: &NegativeTestContext<'_>, target: GLenum, name: GLuint, depth: GLsizei) {
    // SAFETY: as above.
    unsafe { ctx.gl().bind_texture(target, name) };
    tex_image_3d(
        ctx,
        target,
        0,
        glw::GL_RGBA,
        4,
        4,
        depth,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
    );
}

fn texsubimage3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(1, &mut texture) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture, 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    tex_sub_image_3d(ctx, 0, 0, 0, 0, 0, 4, 4, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D,
        0,
        0,
        0,
        0,
        4,
        4,
        4,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    // \note upstream's argument list here is one long, so the arguments shift by one; the
    // call is still the invalid-format case it means.
    ctx.begin_section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, 0, 0, 0, 0, 4, 4, 4, glw::GL_UNSIGNED_BYTE);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_ENUM is generated if type is not a type constant.");
    tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, 0, 0, 0, 4, 4, 4, glw::GL_RGB, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_OPERATION is generated if the combination of internalFormat of the previously specified texture array, format and type is not valid.");
    for (format, ty) in [
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        (glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT),
        (glw::GL_RGB, glw::GL_FLOAT),
    ] {
        tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, 0, 0, 0, 4, 4, 4, format, ty);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn texsubimage3d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    let mut textures = [0 as GLuint; 3];
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(3, textures.as_mut_ptr()) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, textures[0], 4);
    bound_3d_texture(ctx, glw::GL_TEXTURE_2D_ARRAY, textures[1], 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        tex_sub_image_3d(ctx, target, -1, 0, 0, 0, 0, 0, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }

    if cube_array {
        bound_3d_texture(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[2], 6);
        ctx.expect_error(glw::GL_NO_ERROR);
        tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            -1,
            0,
            0,
            0,
            0,
            0,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(3, textures.as_ptr()) };
    Ok(())
}

fn texsubimage3d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // \note upstream binds `textures[1]` before generating it here, so the 2D-array image
    // below lands on whatever was bound; the level check it makes is unaffected.
    let mut textures = [0 as GLuint; 2];
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(2, textures.as_mut_ptr()) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, textures[0], 4);
    bound_3d_texture(ctx, glw::GL_TEXTURE_2D_ARRAY, textures[1], 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    let log2_max_3d = log2_floor32(ctx.get_integer(glw::GL_MAX_3D_TEXTURE_SIZE)) + 1;
    let log2_max_texture = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_3D_TEXTURE_SIZE).");
    tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        log2_max_3d,
        0,
        0,
        0,
        0,
        0,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        log2_max_texture,
        0,
        0,
        0,
        0,
        0,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(2, textures.as_ptr()) };
    Ok(())
}

fn texsubimage3d_neg_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    let mut textures = [0 as GLuint; 3];
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(3, textures.as_mut_ptr()) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, textures[0], 4);
    bound_3d_texture(ctx, glw::GL_TEXTURE_2D_ARRAY, textures[1], 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if xoffset, yoffset or zoffset are negative.");
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        for (x, y, z) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
            tex_sub_image_3d(ctx, target, 0, x, y, z, 0, 0, 0, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }

    if cube_array {
        bound_3d_texture(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[2], 6);
        ctx.expect_error(glw::GL_NO_ERROR);
        for (x, y, z) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
            tex_sub_image_3d(
                ctx,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                x,
                y,
                z,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(3, textures.as_ptr()) };
    Ok(())
}

fn texsubimage3d_invalid_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(1, &mut texture) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture, 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    for (section, (x, y, z)) in [
        (
            "GL_INVALID_VALUE is generated if xoffset + width > texture_width.",
            (2, 0, 0),
        ),
        (
            "GL_INVALID_VALUE is generated if yoffset + height > texture_height.",
            (0, 2, 0),
        ),
        (
            "GL_INVALID_VALUE is generated if zoffset + depth > texture_depth.",
            (0, 0, 2),
        ),
    ] {
        ctx.begin_section(section);
        tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            x,
            y,
            z,
            4,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    delete_texture(ctx, texture);
    Ok(())
}

fn texsubimage3d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);

    ctx.begin_section("GL_INVALID_VALUE is generated if width, height or depth is less than 0.");
    for (w, h, d) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
        tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            0,
            0,
            0,
            w,
            h,
            d,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }

    if cube_array {
        for (w, h, d) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
            tex_sub_image_3d(
                ctx,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                0,
                0,
                0,
                w,
                h,
                d,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
            );
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
    }
    ctx.end_section();
    Ok(())
}

fn texsubimage3d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    let mut buf: GLuint = 0;
    let data = [0 as GLubyte; 512];

    // SAFETY: as above; the buffer gets 512 bytes from a 512-byte source.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, texture);
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA,
            16,
            16,
            16,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            512,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

        ctx.begin_section("...the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 512, glw::GL_MAP_WRITE_BIT);
        tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            0,
            0,
            0,
            4,
            4,
            4,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            0,
            0,
            0,
            16,
            16,
            16,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("...data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.");
        log::debug!("// Set byte offset = 3");
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
        tex_image_3d(
            ctx,
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA4,
            4,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
        );
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().tex_sub_image_3d(
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
            byte_offset(3),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().delete_textures(1, &texture);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    Ok(())
}

// glCopyTexSubImage3D

/// `glCopyTexSubImage3D`, always from (0, 0) of the read buffer.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn copy_tex_sub_image_3d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    xoffset: GLint,
    yoffset: GLint,
    zoffset: GLint,
    width: GLsizei,
    height: GLsizei,
) {
    // SAFETY: a copy from the read buffer touches no caller memory.
    unsafe {
        ctx.gl()
            .copy_tex_sub_image_3d(target, level, xoffset, yoffset, zoffset, 0, 0, width, height);
    }
}

fn copytexsubimage3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(1, &mut texture) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture, 4);

    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    copy_tex_sub_image_3d(ctx, 0, 0, 0, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage3d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    let mut textures = [0 as GLuint; 3];
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(3, textures.as_mut_ptr()) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, textures[0], 4);
    bound_3d_texture(ctx, glw::GL_TEXTURE_2D_ARRAY, textures[1], 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        copy_tex_sub_image_3d(ctx, target, -1, 0, 0, 0, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }

    if cube_array {
        bound_3d_texture(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[2], 6);
        ctx.expect_error(glw::GL_NO_ERROR);
        copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, -1, 0, 0, 0, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(3, textures.as_ptr()) };
    Ok(())
}

fn copytexsubimage3d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    let log2_max_3d = log2_floor32(ctx.get_integer(glw::GL_MAX_3D_TEXTURE_SIZE)) + 1;
    let log2_max_texture = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    let log2_max_cubemap = log2_floor32(ctx.get_integer(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)) + 1;

    let mut textures = [0 as GLuint; 3];
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(3, textures.as_mut_ptr()) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, textures[0], 4);
    bound_3d_texture(ctx, glw::GL_TEXTURE_2D_ARRAY, textures[1], 4);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_3D_TEXTURE_SIZE).");
    copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, log2_max_3d, 0, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_2D_ARRAY, log2_max_texture, 0, 0, 0, 4, 4);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    if cube_array {
        bound_3d_texture(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[2], 6);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_CUBE_MAP_TEXTURE_SIZE).",
        );
        copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, log2_max_cubemap, 0, 0, 0, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    // SAFETY: as above.
    unsafe { ctx.gl().delete_textures(3, textures.as_ptr()) };
    Ok(())
}

fn copytexsubimage3d_neg_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(1, &mut texture) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture, 4);

    ctx.begin_section("GL_INVALID_VALUE is generated if xoffset, yoffset or zoffset is negative.");
    for (x, y, z) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
        copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, x, y, z, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage3d_invalid_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(1, &mut texture) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture, 4);

    for (section, (x, y, z)) in [
        (
            "GL_INVALID_VALUE is generated if xoffset + width > texture_width.",
            (1, 0, 0),
        ),
        (
            "GL_INVALID_VALUE is generated if yoffset + height > texture_height.",
            (0, 1, 0),
        ),
        (
            "GL_INVALID_VALUE is generated if zoffset + 1 > texture_depth.",
            (0, 0, 4),
        ),
    ] {
        ctx.begin_section(section);
        copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, x, y, z, 4, 4);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage3d_neg_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(1, &mut texture) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture, 4);

    ctx.begin_section("GL_INVALID_VALUE is generated if width < 0.");
    copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, 0, 0, 0, -4, 4);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_VALUE is generated if height < 0.");
    copy_tex_sub_image_3d(ctx, glw::GL_TEXTURE_3D, 0, 0, 0, 0, 4, -4);
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn copytexsubimage3d_incomplete_framebuffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut fbo: GLuint = 0;
    let mut texture = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe { ctx.gl().gen_textures(2, texture.as_mut_ptr()) };
    bound_3d_texture(ctx, glw::GL_TEXTURE_3D, texture[0], 4);
    bound_3d_texture(ctx, glw::GL_TEXTURE_2D_ARRAY, texture[1], 4);
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_READ_FRAMEBUFFER);
    }

    ctx.begin_section(
        "GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.",
    );
    for target in [glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
        copy_tex_sub_image_3d(ctx, target, 0, 0, 0, 0, 4, 4);
        ctx.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe {
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_textures(2, texture.as_ptr());
    }
    Ok(())
}

// glCompressedTexImage3D

/// `glCompressedTexImage3D` with the given data pointer.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn compressed_tex_image_3d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    internal_format: GLenum,
    width: GLsizei,
    height: GLsizei,
    depth: GLsizei,
    border: GLint,
    image_size: GLsizei,
    data: *const c_void,
) {
    // SAFETY: `data` is either null or a slice of at least `image_size` bytes, which is
    // what the call may read.
    unsafe {
        ctx.gl().compressed_tex_image_3d(
            target,
            level,
            internal_format,
            width,
            height,
            depth,
            border,
            image_size,
            data,
        );
    }
}

fn compressedteximage3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    compressed_tex_image_3d(
        ctx,
        0,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
        0,
        std::ptr::null(),
    );
    ctx.expect_error(glw::GL_INVALID_ENUM);
    compressed_tex_image_3d(
        ctx,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
        0,
        std::ptr::null(),
    );
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    ctx.begin_section(
        "GL_INVALID_ENUM is generated if internalformat is not one of the specific compressed internal formats.",
    );
    for format in [0, glw::GL_RGBA8] {
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            format,
            0,
            0,
            0,
            0,
            0,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    compressed_tex_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        -1,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
        0,
        std::ptr::null(),
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    compressed_tex_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        log2_max_texture_size,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
        0,
        std::ptr::null(),
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_neg_width_height_depth(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if width, height or depth is less than 0.");
    for (w, h, d) in [(-1, 0, 0), (0, -1, 0), (0, 0, -1), (-1, -1, -1)] {
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            w,
            h,
            d,
            0,
            0,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_max_width_height_depth(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_texture_size = ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let max_layers = ctx.get_integer(glw::GL_MAX_ARRAY_TEXTURE_LAYERS) + 1;

    ctx.begin_section("GL_INVALID_VALUE is generated if width, height or depth is greater than GL_MAX_TEXTURE_SIZE.");
    for (w, h, d) in [
        (max_texture_size, 0, 0),
        (0, max_texture_size, 0),
        (max_texture_size, max_texture_size, max_layers),
        (0, 0, max_layers),
    ] {
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            w,
            h,
            d,
            0,
            0,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_invalid_border(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if border is not 0.");
    for border in [-1, 1] {
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
            0,
            0,
            border,
            0,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_invalid_size(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    compressed_tex_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
        0,
        0,
        0,
        -1,
        std::ptr::null(),
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);

    for (format, size) in [
        (glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 4 * 4 * 8),
        (glw::GL_COMPRESSED_RGB8_ETC2, 4 * 4 * 16),
        (glw::GL_COMPRESSED_SIGNED_R11_EAC, 4 * 4 * 16),
    ] {
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            format,
            16,
            16,
            1,
            0,
            size,
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_invalid_width_height(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !cube_map_array_supported(ctx) {
        return Ok(());
    }

    const WIDTH: GLsizei = 4;
    const HEIGHT: GLsizei = 6;
    const DEPTH: GLsizei = 6;
    const IMAGE_SIZE: GLsizei = div_round_up(WIDTH, 4) * div_round_up(HEIGHT, 4) * DEPTH * 16;
    let data = vec![0 as GLubyte; IMAGE_SIZE as usize];

    ctx.begin_section(
        "GL_INVALID_VALUE is generated if target is GL_TEXTURE_CUBE_MAP_ARRAY and width and height are not equal.",
    );
    compressed_tex_image_3d(
        ctx,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        0,
        glw::GL_COMPRESSED_RGB8_ETC2,
        WIDTH,
        HEIGHT,
        DEPTH,
        0,
        IMAGE_SIZE,
        data.as_ptr().cast(),
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();
    Ok(())
}

fn compressedteximage3d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut buf: GLuint = 0;
    let data = [0 as GLubyte; 512];

    // SAFETY: the buffer asks for 64 of the 512 bytes the source holds.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            64,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and the buffer object's data store is currently mapped.");
        let _ = ctx
            .gl()
            .map_buffer_range(glw::GL_PIXEL_UNPACK_BUFFER, 0, 64, glw::GL_MAP_WRITE_BIT);
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_COMPRESSED_RGB8_ETC2,
            4,
            4,
            1,
            0,
            etc2_data_size(4, 4),
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        compressed_tex_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_COMPRESSED_RGB8_ETC2,
            16,
            16,
            1,
            0,
            etc2_data_size(16, 16),
            std::ptr::null(),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    Ok(())
}

// glCompressedTexSubImage3D

/// `glCompressedTexSubImage3D` with a null data pointer.
#[expect(clippy::too_many_arguments, reason = "mirrors the entry point being tested")]
fn compressed_tex_sub_image_3d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    level: GLint,
    xoffset: GLint,
    yoffset: GLint,
    zoffset: GLint,
    width: GLsizei,
    height: GLsizei,
    depth: GLsizei,
    format: GLenum,
    image_size: GLsizei,
) {
    // SAFETY: as in `compressed_tex_image_2d`.
    unsafe {
        ctx.gl().compressed_tex_sub_image_3d(
            target,
            level,
            xoffset,
            yoffset,
            zoffset,
            width,
            height,
            depth,
            format,
            image_size,
            std::ptr::null(),
        );
    }
}

/// One `GL_TEXTURE_2D_ARRAY` holding a `size`x`size`x1 ETC2/EAC image.
fn bound_etc2_array_texture(ctx: &NegativeTestContext<'_>, size: GLsizei, image_size: GLsizei) -> GLuint {
    let mut texture: GLuint = 0;
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture);
    }
    compressed_tex_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        size,
        size,
        1,
        0,
        image_size,
        std::ptr::null(),
    );
    texture
}

fn compressedtexsubimage3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if target is invalid.");
    compressed_tex_sub_image_3d(ctx, 0, 0, 0, 0, 0, 0, 0, 0, glw::GL_COMPRESSED_RGBA8_ETC2_EAC, 0);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    let texture = bound_etc2_array_texture(ctx, 18, etc2_eac_data_size(18, 18));
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_OPERATION is generated if format does not match the internal format of the texture image being modified.");
    compressed_tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        glw::GL_COMPRESSED_RGB8_ETC2,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section("GL_INVALID_OPERATION is generated if internalformat is an ETC2/EAC format and target is not GL_TEXTURE_2D_ARRAY.");
    compressed_tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_3D,
        0,
        0,
        0,
        0,
        18,
        18,
        1,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        etc2_eac_data_size(18, 18),
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if width is not a multiple of four, and width + xoffset is not equal to the width of the texture level.",
    );
    compressed_tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        4,
        0,
        0,
        10,
        4,
        1,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        etc2_eac_data_size(10, 4),
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if height is not a multiple of four, and height + yoffset is not equal to the height of the texture level.",
    );
    compressed_tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        0,
        4,
        0,
        4,
        10,
        1,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        etc2_eac_data_size(4, 10),
    );
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    ctx.begin_section(
        "For ETC2/EAC images GL_INVALID_OPERATION is generated if xoffset or yoffset is not a multiple of four.",
    );
    for (x, y) in [(1, 0), (0, 1), (1, 1)] {
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            x,
            y,
            0,
            4,
            4,
            1,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(4, 4),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_neg_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 16, etc2_eac_data_size(16, 16));
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is less than 0.");
    compressed_tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        -1,
        0,
        0,
        0,
        0,
        0,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_max_level(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 16, etc2_eac_data_size(16, 16));
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    let log2_max_texture_size = log2_floor32(ctx.get_integer(glw::GL_MAX_TEXTURE_SIZE)) + 1;
    compressed_tex_sub_image_3d(
        ctx,
        glw::GL_TEXTURE_2D_ARRAY,
        log2_max_texture_size,
        0,
        0,
        0,
        0,
        0,
        0,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        0,
    );
    ctx.expect_error(glw::GL_INVALID_VALUE);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_neg_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 16, etc2_eac_data_size(16, 16));
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section(
        "GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if xoffset, yoffset or zoffset are negative.",
    );
    for (x, y, z) in [(-4, 0, 0), (0, -4, 0), (0, 0, -4), (-4, -4, -4)] {
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            x,
            y,
            z,
            0,
            0,
            0,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
        );
        ctx.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_invalid_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 4, etc2_eac_data_size(4, 4));
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if xoffset + width > texture_width or yoffset + height > texture_height.");
    for (x, y, z, w, h) in [(12, 0, 0, 8, 4), (0, 12, 0, 4, 8), (0, 0, 12, 4, 4), (12, 12, 12, 8, 8)] {
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            x,
            y,
            z,
            w,
            h,
            1,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(w, h),
        );
        ctx.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_neg_width_height_depth(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 16, etc2_eac_data_size(16, 16));
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE or GL_INVALID_OPERATION is generated if width, height or depth are negative.");
    for (w, h, d) in [(-4, 0, 0), (0, -4, 0), (0, 0, -4), (-4, -4, -4)] {
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            w,
            h,
            d,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            0,
        );
        ctx.expect_error2(glw::GL_INVALID_VALUE, glw::GL_INVALID_OPERATION);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_invalid_size(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 16, 4 * 4 * 16);
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    for image_size in [-1, 4 * 4 * 16 - 1] {
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            16,
            16,
            1,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            image_size,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn compressedtexsubimage3d_invalid_buffer_target(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let texture = bound_etc2_array_texture(ctx, 16, etc2_eac_data_size(16, 16));
    let buffer_size = etc2_eac_data_size(4, 4);
    let mut buf: GLuint = 0;
    let data = vec![0 as GLubyte; buffer_size as usize];

    // SAFETY: the buffer gets `buffer_size` bytes from a source of exactly that size.
    unsafe {
        ctx.gl().gen_buffers(1, &mut buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf);
        ctx.gl().buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            buffer_size as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY,
        );
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if a non-zero buffer object name is bound to the GL_PIXEL_UNPACK_BUFFER target and...");

        ctx.begin_section("...the buffer object's data store is currently mapped.");
        let _ = ctx.gl().map_buffer_range(
            glw::GL_PIXEL_UNPACK_BUFFER,
            0,
            buffer_size as isize,
            glw::GL_MAP_WRITE_BIT,
        );
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            4,
            4,
            1,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(4, 4),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        let _ = ctx.gl().unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
        ctx.end_section();

        ctx.begin_section("...the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.");
        compressed_tex_sub_image_3d(
            ctx,
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            16,
            16,
            1,
            glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
            etc2_eac_data_size(16, 16),
        );
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().delete_buffers(1, &buf);
        ctx.gl().bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
    delete_texture(ctx, texture);
    Ok(())
}

// glTexStorage2D / glTexStorage3D

fn tex_storage_2d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    levels: GLsizei,
    format: GLenum,
    width: GLsizei,
    height: GLsizei,
) {
    // SAFETY: allocating storage touches no caller memory.
    unsafe { ctx.gl().tex_storage_2d(target, levels, format, width, height) };
}

fn tex_storage_3d(
    ctx: &NegativeTestContext<'_>,
    target: GLenum,
    levels: GLsizei,
    format: GLenum,
    width: GLsizei,
    height: GLsizei,
    depth: GLsizei,
) {
    // SAFETY: as above.
    unsafe { ctx.gl().tex_storage_3d(target, levels, format, width, height, depth) };
}

/// `GL_TEXTURE_IMMUTABLE_FORMAT` of the bound texture, which the two `invalid_binding`
/// cases log before and after allocating storage.
fn log_immutable_format(ctx: &NegativeTestContext<'_>, target: GLenum) {
    let mut immutable: GLint = 0;
    // SAFETY: one GLint out.
    unsafe {
        ctx.gl()
            .get_tex_parameteriv(target, glw::GL_TEXTURE_IMMUTABLE_FORMAT, &mut immutable)
    };
    log::debug!(
        "// GL_TEXTURE_IMMUTABLE_FORMAT = {}",
        if immutable != 0 { "GL_TRUE" } else { "GL_FALSE" }
    );
}

fn texstorage2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let es32 = supports_es32(ctx);
    let mut textures = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section(
            "GL_INVALID_ENUM or GL_INVALID_VALUE is generated if internalformat is not a valid sized internal format.",
        );
        for format in [0, glw::GL_RGBA_INTEGER] {
            tex_storage_2d(ctx, glw::GL_TEXTURE_2D, 1, format, 16, 16);
            ctx.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted target enumerants.");
        for target in [0, glw::GL_TEXTURE_3D, glw::GL_TEXTURE_2D_ARRAY] {
            tex_storage_2d(ctx, target, 1, glw::GL_RGBA8, 16, 16);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if width or height are less than 1.");
        for (w, h) in [(0, 16), (16, 0), (0, 0)] {
            tex_storage_2d(ctx, glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, w, h);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }

        if es32 {
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[1]);
            ctx.expect_error(glw::GL_NO_ERROR);
            for (w, h) in [(0, 16), (16, 0), (0, 0)] {
                tex_storage_2d(ctx, glw::GL_TEXTURE_CUBE_MAP, 1, glw::GL_RGBA8, w, h);
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, textures.as_ptr());
    }
    Ok(())
}

fn texstorage2d_invalid_binding(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let es32 = supports_es32(ctx);
    let mut textures = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if the default texture object is curently bound to target.",
        );
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, 0);
        tex_storage_2d(ctx, glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 16, 16);
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        if es32 {
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0);
            tex_storage_2d(ctx, glw::GL_TEXTURE_CUBE_MAP, 1, glw::GL_RGBA8, 16, 16);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().gen_textures(2, textures.as_mut_ptr());

        ctx.begin_section("GL_INVALID_OPERATION is generated if the texture object currently bound to target already has GL_TEXTURE_IMMUTABLE_FORMAT set to GL_TRUE.");
        let mut targets = vec![(glw::GL_TEXTURE_2D, textures[0])];
        if es32 {
            targets.push((glw::GL_TEXTURE_CUBE_MAP, textures[1]));
        }
        for (target, name) in targets {
            ctx.gl().bind_texture(target, name);
            log_immutable_format(ctx, target);
            tex_storage_2d(ctx, target, 1, glw::GL_RGBA8, 16, 16);
            ctx.expect_error(glw::GL_NO_ERROR);
            log_immutable_format(ctx, target);
            tex_storage_2d(ctx, target, 1, glw::GL_RGBA8, 16, 16);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, textures.as_ptr());
    }
    Ok(())
}

fn texstorage2d_invalid_levels(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let es32 = supports_es32(ctx);
    // floor(log2(max(16, 16))) + 1 + 1 - one level past what a 16x16 texture can have.
    let log2_max_size = log2_floor32(16) + 2;
    let mut textures = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, textures[0]);
        if es32 {
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[1]);
        }
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_VALUE is generated if levels is less than 1.");
        for (w, h) in [(16, 16), (0, 0)] {
            tex_storage_2d(ctx, glw::GL_TEXTURE_2D, 0, glw::GL_RGBA8, w, h);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }
        if es32 {
            for (w, h) in [(16, 16), (0, 0)] {
                tex_storage_2d(ctx, glw::GL_TEXTURE_CUBE_MAP, 0, glw::GL_RGBA8, w, h);
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
        }
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if levels is greater than floor(log_2(max(width, height))) + 1",
        );
        tex_storage_2d(ctx, glw::GL_TEXTURE_2D, log2_max_size, glw::GL_RGBA8, 16, 16);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        if es32 {
            tex_storage_2d(ctx, glw::GL_TEXTURE_CUBE_MAP, log2_max_size, glw::GL_RGBA8, 16, 16);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, textures.as_ptr());
    }
    Ok(())
}

fn texstorage3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    let mut textures = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, textures[0]);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section(
            "GL_INVALID_ENUM or GL_INVALID_VALUE is generated if internalformat is not a valid sized internal format.",
        );
        for format in [0, glw::GL_RGBA_INTEGER] {
            tex_storage_3d(ctx, glw::GL_TEXTURE_3D, 1, format, 4, 4, 4);
            ctx.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted target enumerants.");
        for target in [0, glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_2D] {
            tex_storage_3d(ctx, target, 1, glw::GL_RGBA8, 4, 4, 4);
            ctx.expect_error(glw::GL_INVALID_ENUM);
        }
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if width, height or depth are less than 1.");
        for (w, h, d) in [(0, 4, 4), (4, 0, 4), (4, 4, 0), (0, 0, 0)] {
            tex_storage_3d(ctx, glw::GL_TEXTURE_3D, 1, glw::GL_RGBA8, w, h, d);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }

        if cube_array {
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[1]);
            ctx.expect_error(glw::GL_NO_ERROR);
            for (w, h, d) in [(0, 4, 4), (4, 0, 4), (4, 4, 0), (0, 0, 0)] {
                tex_storage_3d(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, 1, glw::GL_RGBA8, w, h, d);
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, textures.as_ptr());
    }
    Ok(())
}

fn texstorage3d_invalid_binding(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    let mut textures = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if the default texture object is curently bound to target.",
        );
        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, 0);
        tex_storage_3d(ctx, glw::GL_TEXTURE_3D, 1, glw::GL_RGBA8, 4, 4, 4);
        ctx.expect_error(glw::GL_INVALID_OPERATION);

        if cube_array {
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            tex_storage_3d(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, 1, glw::GL_RGBA8, 4, 4, 6);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().gen_textures(2, textures.as_mut_ptr());

        ctx.begin_section("GL_INVALID_OPERATION is generated if the texture object currently bound to target already has GL_TEXTURE_IMMUTABLE_FORMAT set to GL_TRUE.");
        let mut targets = vec![(glw::GL_TEXTURE_3D, textures[0], 4)];
        if cube_array {
            targets.push((glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[1], 6));
        }
        for (target, name, depth) in targets {
            ctx.gl().bind_texture(target, name);
            log_immutable_format(ctx, target);
            tex_storage_3d(ctx, target, 1, glw::GL_RGBA8, 4, 4, depth);
            ctx.expect_error(glw::GL_NO_ERROR);
            log_immutable_format(ctx, target);
            tex_storage_3d(ctx, target, 1, glw::GL_RGBA8, 4, 4, depth);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, textures.as_ptr());
    }
    Ok(())
}

fn texstorage3d_invalid_levels(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let cube_array = cube_map_array_supported(ctx);
    // floor(log2(8)) + 1 + 1 - one level past what an 8-wide texture can have.
    let log2_max_size = log2_floor32(8) + 2;
    let mut textures = [0 as GLuint; 2];

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(2, textures.as_mut_ptr());
        ctx.gl().bind_texture(glw::GL_TEXTURE_3D, textures[0]);

        ctx.begin_section("GL_INVALID_VALUE is generated if levels is less than 1.");
        for (w, h, d) in [(4, 4, 4), (0, 0, 0)] {
            tex_storage_3d(ctx, glw::GL_TEXTURE_3D, 0, glw::GL_RGBA8, w, h, d);
            ctx.expect_error(glw::GL_INVALID_VALUE);
        }

        if cube_array {
            ctx.gl().bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[1]);
            for (w, h) in [(4, 4), (0, 0)] {
                tex_storage_3d(ctx, glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0, glw::GL_RGBA8, w, h, 6);
                ctx.expect_error(glw::GL_INVALID_VALUE);
            }
        }
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if levels is greater than floor(log_2(max(width, height, depth))) + 1",
        );
        for (w, h, d) in [(8, 2, 2), (2, 8, 2), (2, 2, 8), (8, 8, 8)] {
            tex_storage_3d(ctx, glw::GL_TEXTURE_3D, log2_max_size, glw::GL_RGBA8, w, h, d);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
        }

        if cube_array {
            for (w, h) in [(2, 2), (8, 8)] {
                tex_storage_3d(
                    ctx,
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    log2_max_size,
                    glw::GL_RGBA8,
                    w,
                    h,
                    6,
                );
                ctx.expect_error(glw::GL_INVALID_OPERATION);
            }
        }
        ctx.end_section();

        ctx.gl().delete_textures(2, textures.as_ptr());
    }
    Ok(())
}

// GL_EXT_texture_sRGB_decode

/// The section every `srgb_decode_texparameter*` case runs.
const SRGB_DECODE_SECTION: &str = "GL_INVALID_ENUM is generated if pname is GL_TEXTURE_SRGB_DECODE_EXT and the value of param(s) is not a valid value (one of DECODE_EXT, or SKIP_DECODE_EXT).";

fn check_srgb_decode(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.is_extension_supported("GL_EXT_texture_sRGB_decode") {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_texture_sRGB_decode is not supported.".to_string(),
        ))
    }
}

/// The body every `srgb_decode_texparameter*` case shares.
fn srgb_decode_body(
    ctx: &mut NegativeTestContext<'_>,
    set: impl FnOnce(&NegativeTestContext<'_>),
) -> Result<(), TestError> {
    let mut texture: GLuint = 0;

    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
    }

    ctx.begin_section(SRGB_DECODE_SECTION);
    set(ctx);
    ctx.expect_error(glw::GL_INVALID_ENUM);
    ctx.end_section();

    delete_texture(ctx, texture);
    Ok(())
}

fn srgb_decode_texparameteri(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_srgb_decode(ctx)?;
    srgb_decode_body(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SRGB_DECODE_EXT, -1);
        }
    })
}

fn srgb_decode_texparameterf(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_srgb_decode(ctx)?;
    srgb_decode_body(ctx, |ctx| {
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SRGB_DECODE_EXT, -1.0);
        }
    })
}

fn srgb_decode_texparameteriv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_srgb_decode(ctx)?;
    srgb_decode_body(ctx, |ctx| {
        let params = [-1 as GLint];
        // SAFETY: as above; one element is passed and one is read.
        unsafe {
            ctx.gl()
                .tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SRGB_DECODE_EXT, params.as_ptr());
        }
    })
}

fn srgb_decode_texparameterfv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_srgb_decode(ctx)?;
    srgb_decode_body(ctx, |ctx| {
        let params = [-1.0 as GLfloat];
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SRGB_DECODE_EXT, params.as_ptr());
        }
    })
}

#[expect(non_snake_case, reason = "upstream's case name, which the diff compares against")]
fn srgb_decode_texparameterIiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !supports_es32(ctx) {
        return Err(TestError::NotSupported(
            "glTexParameterIiv is not supported.".to_string(),
        ));
    }
    check_srgb_decode(ctx)?;
    srgb_decode_body(ctx, |ctx| {
        let params = [-1 as GLint, -1];
        // SAFETY: as above; two elements are passed and at most two are read.
        unsafe {
            ctx.gl()
                .tex_parameter_iiv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SRGB_DECODE_EXT, params.as_ptr());
        }
    })
}

#[expect(non_snake_case, reason = "upstream's case name, which the diff compares against")]
fn srgb_decode_texparameterIuiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !supports_es32(ctx) {
        return Err(TestError::NotSupported(
            "glTexParameterIuiv is not supported.".to_string(),
        ));
    }
    check_srgb_decode(ctx)?;
    srgb_decode_body(ctx, |ctx| {
        let params = [glw::GL_DONT_CARE, glw::GL_DONT_CARE];
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .tex_parameter_iuiv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SRGB_DECODE_EXT, params.as_ptr());
        }
    })
}

/// `getNegativeTextureApiTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: activetexture,
        name: "activetexture",
    },
    FunctionContainer {
        function: bindtexture,
        name: "bindtexture",
    },
    FunctionContainer {
        function: compressedteximage2d_invalid_target,
        name: "compressedteximage2d_invalid_target",
    },
    FunctionContainer {
        function: compressedteximage2d_invalid_format,
        name: "compressedteximage2d_invalid_format",
    },
    FunctionContainer {
        function: compressedteximage2d_neg_level,
        name: "compressedteximage2d_neg_level",
    },
    FunctionContainer {
        function: compressedteximage2d_max_level,
        name: "compressedteximage2d_max_level",
    },
    FunctionContainer {
        function: compressedteximage2d_neg_width_height,
        name: "compressedteximage2d_neg_width_height",
    },
    FunctionContainer {
        function: compressedteximage2d_max_width_height,
        name: "compressedteximage2d_max_width_height",
    },
    FunctionContainer {
        function: compressedteximage2d_invalid_border,
        name: "compressedteximage2d_invalid_border",
    },
    FunctionContainer {
        function: compressedteximage2d_invalid_size,
        name: "compressedteximage2d_invalid_size",
    },
    FunctionContainer {
        function: compressedteximage2d_neg_size,
        name: "compressedteximage2d_neg_size",
    },
    FunctionContainer {
        function: compressedteximage2d_invalid_width_height,
        name: "compressedteximage2d_invalid_width_height",
    },
    FunctionContainer {
        function: compressedteximage2d_invalid_buffer_target,
        name: "compressedteximage2d_invalid_buffer_target",
    },
    FunctionContainer {
        function: copyteximage2d_invalid_target,
        name: "copyteximage2d_invalid_target",
    },
    FunctionContainer {
        function: copyteximage2d_invalid_format,
        name: "copyteximage2d_invalid_format",
    },
    FunctionContainer {
        function: copyteximage2d_inequal_width_height_cube,
        name: "copyteximage2d_inequal_width_height_cube",
    },
    FunctionContainer {
        function: copyteximage2d_neg_level,
        name: "copyteximage2d_neg_level",
    },
    FunctionContainer {
        function: copyteximage2d_max_level,
        name: "copyteximage2d_max_level",
    },
    FunctionContainer {
        function: copyteximage2d_neg_width_height,
        name: "copyteximage2d_neg_width_height",
    },
    FunctionContainer {
        function: copyteximage2d_max_width_height,
        name: "copyteximage2d_max_width_height",
    },
    FunctionContainer {
        function: copyteximage2d_invalid_border,
        name: "copyteximage2d_invalid_border",
    },
    FunctionContainer {
        function: copyteximage2d_incomplete_framebuffer,
        name: "copyteximage2d_incomplete_framebuffer",
    },
    FunctionContainer {
        function: copytexsubimage2d_invalid_target,
        name: "copytexsubimage2d_invalid_target",
    },
    FunctionContainer {
        function: copytexsubimage2d_read_buffer_is_none,
        name: "copytexsubimage2d_read_buffer_is_none",
    },
    FunctionContainer {
        function: copytexsubimage2d_texture_internalformat,
        name: "copytexsubimage2d_texture_internalformat",
    },
    FunctionContainer {
        function: copytexsubimage2d_neg_level,
        name: "copytexsubimage2d_neg_level",
    },
    FunctionContainer {
        function: copytexsubimage2d_max_level,
        name: "copytexsubimage2d_max_level",
    },
    FunctionContainer {
        function: copytexsubimage2d_neg_offset,
        name: "copytexsubimage2d_neg_offset",
    },
    FunctionContainer {
        function: copytexsubimage2d_invalid_offset,
        name: "copytexsubimage2d_invalid_offset",
    },
    FunctionContainer {
        function: copytexsubimage2d_neg_width_height,
        name: "copytexsubimage2d_neg_width_height",
    },
    FunctionContainer {
        function: copytexsubimage2d_incomplete_framebuffer,
        name: "copytexsubimage2d_incomplete_framebuffer",
    },
    FunctionContainer {
        function: deletetextures,
        name: "deletetextures",
    },
    FunctionContainer {
        function: generatemipmap,
        name: "generatemipmap",
    },
    FunctionContainer {
        function: gentextures,
        name: "gentextures",
    },
    FunctionContainer {
        function: pixelstorei,
        name: "pixelstorei",
    },
    FunctionContainer {
        function: teximage2d,
        name: "teximage2d",
    },
    FunctionContainer {
        function: teximage2d_inequal_width_height_cube,
        name: "teximage2d_inequal_width_height_cube",
    },
    FunctionContainer {
        function: teximage2d_neg_level,
        name: "teximage2d_neg_level",
    },
    FunctionContainer {
        function: teximage2d_max_level,
        name: "teximage2d_max_level",
    },
    FunctionContainer {
        function: teximage2d_neg_width_height,
        name: "teximage2d_neg_width_height",
    },
    FunctionContainer {
        function: teximage2d_max_width_height,
        name: "teximage2d_max_width_height",
    },
    FunctionContainer {
        function: teximage2d_invalid_border,
        name: "teximage2d_invalid_border",
    },
    FunctionContainer {
        function: teximage2d_invalid_buffer_target,
        name: "teximage2d_invalid_buffer_target",
    },
    FunctionContainer {
        function: texsubimage2d,
        name: "texsubimage2d",
    },
    FunctionContainer {
        function: texsubimage2d_neg_level,
        name: "texsubimage2d_neg_level",
    },
    FunctionContainer {
        function: texsubimage2d_max_level,
        name: "texsubimage2d_max_level",
    },
    FunctionContainer {
        function: texsubimage2d_neg_offset,
        name: "texsubimage2d_neg_offset",
    },
    FunctionContainer {
        function: texsubimage2d_invalid_offset,
        name: "texsubimage2d_invalid_offset",
    },
    FunctionContainer {
        function: texsubimage2d_neg_width_height,
        name: "texsubimage2d_neg_width_height",
    },
    FunctionContainer {
        function: texsubimage2d_invalid_buffer_target,
        name: "texsubimage2d_invalid_buffer_target",
    },
    FunctionContainer {
        function: texparameteri,
        name: "texparameteri",
    },
    FunctionContainer {
        function: texparameterf,
        name: "texparameterf",
    },
    FunctionContainer {
        function: texparameteriv,
        name: "texparameteriv",
    },
    FunctionContainer {
        function: texparameterfv,
        name: "texparameterfv",
    },
    FunctionContainer {
        function: texparameterIiv,
        name: "texparameterIiv",
    },
    FunctionContainer {
        function: texparameterIuiv,
        name: "texparameterIuiv",
    },
    FunctionContainer {
        function: compressedtexsubimage2d,
        name: "compressedtexsubimage2d",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_neg_level,
        name: "compressedtexsubimage2d_neg_level",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_max_level,
        name: "compressedtexsubimage2d_max_level",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_neg_offset,
        name: "compressedtexsubimage2d_neg_offset",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_invalid_offset,
        name: "compressedtexsubimage2d_invalid_offset",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_neg_width_height,
        name: "compressedtexsubimage2d_neg_width_height",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_invalid_size,
        name: "compressedtexsubimage2d_invalid_size",
    },
    FunctionContainer {
        function: compressedtexsubimage2d_invalid_buffer_target,
        name: "compressedtexsubimage2d_invalid_buffer_target",
    },
    FunctionContainer {
        function: teximage3d,
        name: "teximage3d",
    },
    FunctionContainer {
        function: teximage3d_neg_level,
        name: "teximage3d_neg_level",
    },
    FunctionContainer {
        function: teximage3d_max_level,
        name: "teximage3d_max_level",
    },
    FunctionContainer {
        function: teximage3d_neg_width_height_depth,
        name: "teximage3d_neg_width_height_depth",
    },
    FunctionContainer {
        function: teximage3d_max_width_height_depth,
        name: "teximage3d_max_width_height_depth",
    },
    FunctionContainer {
        function: teximage3d_invalid_border,
        name: "teximage3d_invalid_border",
    },
    FunctionContainer {
        function: teximage3d_invalid_buffer_target,
        name: "teximage3d_invalid_buffer_target",
    },
    FunctionContainer {
        function: texsubimage3d,
        name: "texsubimage3d",
    },
    FunctionContainer {
        function: texsubimage3d_neg_level,
        name: "texsubimage3d_neg_level",
    },
    FunctionContainer {
        function: texsubimage3d_max_level,
        name: "texsubimage3d_max_level",
    },
    FunctionContainer {
        function: texsubimage3d_neg_offset,
        name: "texsubimage3d_neg_offset",
    },
    FunctionContainer {
        function: texsubimage3d_invalid_offset,
        name: "texsubimage3d_invalid_offset",
    },
    FunctionContainer {
        function: texsubimage3d_neg_width_height,
        name: "texsubimage3d_neg_width_height",
    },
    FunctionContainer {
        function: texsubimage3d_invalid_buffer_target,
        name: "texsubimage3d_invalid_buffer_target",
    },
    FunctionContainer {
        function: copytexsubimage3d,
        name: "copytexsubimage3d",
    },
    FunctionContainer {
        function: copytexsubimage3d_neg_level,
        name: "copytexsubimage3d_neg_level",
    },
    FunctionContainer {
        function: copytexsubimage3d_max_level,
        name: "copytexsubimage3d_max_level",
    },
    FunctionContainer {
        function: copytexsubimage3d_neg_offset,
        name: "copytexsubimage3d_neg_offset",
    },
    FunctionContainer {
        function: copytexsubimage3d_invalid_offset,
        name: "copytexsubimage3d_invalid_offset",
    },
    FunctionContainer {
        function: copytexsubimage3d_neg_width_height,
        name: "copytexsubimage3d_neg_width_height",
    },
    FunctionContainer {
        function: copytexsubimage3d_incomplete_framebuffer,
        name: "copytexsubimage3d_incomplete_framebuffer",
    },
    FunctionContainer {
        function: compressedteximage3d,
        name: "compressedteximage3d",
    },
    FunctionContainer {
        function: compressedteximage3d_neg_level,
        name: "compressedteximage3d_neg_level",
    },
    FunctionContainer {
        function: compressedteximage3d_max_level,
        name: "compressedteximage3d_max_level",
    },
    FunctionContainer {
        function: compressedteximage3d_neg_width_height_depth,
        name: "compressedteximage3d_neg_width_height_depth",
    },
    FunctionContainer {
        function: compressedteximage3d_max_width_height_depth,
        name: "compressedteximage3d_max_width_height_depth",
    },
    FunctionContainer {
        function: compressedteximage3d_invalid_border,
        name: "compressedteximage3d_invalid_border",
    },
    FunctionContainer {
        function: compressedteximage3d_invalid_size,
        name: "compressedteximage3d_invalid_size",
    },
    FunctionContainer {
        function: compressedteximage3d_invalid_width_height,
        name: "compressedteximage3d_invalid_width_height",
    },
    FunctionContainer {
        function: compressedteximage3d_invalid_buffer_target,
        name: "compressedteximage3d_invalid_buffer_target",
    },
    FunctionContainer {
        function: compressedtexsubimage3d,
        name: "compressedtexsubimage3d",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_neg_level,
        name: "compressedtexsubimage3d_neg_level",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_max_level,
        name: "compressedtexsubimage3d_max_level",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_neg_offset,
        name: "compressedtexsubimage3d_neg_offset",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_invalid_offset,
        name: "compressedtexsubimage3d_invalid_offset",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_neg_width_height_depth,
        name: "compressedtexsubimage3d_neg_width_height_depth",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_invalid_size,
        name: "compressedtexsubimage3d_invalid_size",
    },
    FunctionContainer {
        function: compressedtexsubimage3d_invalid_buffer_target,
        name: "compressedtexsubimage3d_invalid_buffer_target",
    },
    FunctionContainer {
        function: texstorage2d,
        name: "texstorage2d",
    },
    FunctionContainer {
        function: texstorage2d_invalid_binding,
        name: "texstorage2d_invalid_binding",
    },
    FunctionContainer {
        function: texstorage2d_invalid_levels,
        name: "texstorage2d_invalid_levels",
    },
    FunctionContainer {
        function: texstorage3d,
        name: "texstorage3d",
    },
    FunctionContainer {
        function: texstorage3d_invalid_binding,
        name: "texstorage3d_invalid_binding",
    },
    FunctionContainer {
        function: texstorage3d_invalid_levels,
        name: "texstorage3d_invalid_levels",
    },
    FunctionContainer {
        function: srgb_decode_texparameteri,
        name: "srgb_decode_texparameteri",
    },
    FunctionContainer {
        function: srgb_decode_texparameterf,
        name: "srgb_decode_texparameterf",
    },
    FunctionContainer {
        function: srgb_decode_texparameteriv,
        name: "srgb_decode_texparameteriv",
    },
    FunctionContainer {
        function: srgb_decode_texparameterfv,
        name: "srgb_decode_texparameterfv",
    },
    FunctionContainer {
        function: srgb_decode_texparameterIiv,
        name: "srgb_decode_texparameterIiv",
    },
    FunctionContainer {
        function: srgb_decode_texparameterIuiv,
        name: "srgb_decode_texparameterIuiv",
    },
];
