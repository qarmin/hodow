// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fNegativeTextureApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See the note in `buffer.rs` about
// the shape of these files.
//
// Upstream registers the same body once per cube-map face as six separately named
// cases (`..._cube_pos_x`, `..._cube_neg_z`, ...). Here that is one body function
// taking the face, registered six times under upstream's names - the cases and their
// names are identical, and the C++'s copy-paste is not reproduced.
//
// The nine `compressedtexsubimage2d_*` cases are here, and they are the one family in
// this file that tests nothing - upstream included. See the note above
// `compressedtexsubimage2d_body`.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, TestCase, TestCaseGroup, add_api_case, add_api_cases};
use crate::glw::{self, GLenum};
use crate::tcu::{TestOutcome, TestResult, TestStatus};

/// The six cube-map faces, in the order upstream's per-face cases are registered.
const CUBE_FACES: [(&str, GLenum); 6] = [
    ("cube_pos_x", glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X),
    ("cube_pos_y", glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y),
    ("cube_pos_z", glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z),
    ("cube_neg_x", glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X),
    ("cube_neg_y", glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y),
    ("cube_neg_z", glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z),
];

/// The order the faces are listed in inside a single `_cube` case.
const CUBE_FACE_TARGETS: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `deLog2Floor32(size) + 1` - the first level number that is out of range.
fn log2_max_texture_size(case: &ApiCase<'_>, limit: GLenum) -> i32 {
    let size = case.get_int(limit);
    // `ilog2` is `deLog2Floor32` for any positive value, and the limit is at least 1
    // on any implementation that passes `implementation_limits`.
    if size <= 0 { 1 } else { size.ilog2() as i32 + 1 }
}

/// `getFirstNonPalettedFormatNdx` - the paletted formats accept arguments the others
/// reject (a negative level, zero dimensions), so the cases that demand an error skip
/// past them.
fn first_non_paletted_format(case: &ApiCase<'_>, formats: &[i32]) -> usize {
    let mut ndx = 0;
    if case
        .context()
        .context_info
        .is_extension_supported("GL_OES_compressed_paletted_texture")
    {
        while ndx < formats.len()
            && (glw::GL_PALETTE4_RGB8_OES as i32) <= formats[ndx]
            && formats[ndx] <= (glw::GL_PALETTE8_RGB5_A1_OES as i32)
        {
            ndx += 1;
        }
    }
    ndx
}

fn compressed_formats(case: &mut ApiCase<'_>) -> Vec<i32> {
    case.get_supported_extensions(
        glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS,
        glw::GL_COMPRESSED_TEXTURE_FORMATS,
    )
}

/// The first compressed format that is not paletted, or `None` when there is none -
/// in which case upstream's case body is skipped entirely and the case passes.
fn non_paletted_format(case: &mut ApiCase<'_>) -> Option<u32> {
    let formats = compressed_formats(case);
    let ndx = first_non_paletted_format(case, &formats);
    formats.get(ndx).map(|f| *f as u32)
}

// --- glActiveTexture ---------------------------------------------------------------

fn activetexture_invalid_texture(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if texture is not one of GL_TEXTUREi, where i ranges from 0 to (GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS - 1).");
    // SAFETY: every call in this file is made with a current context, and each one is
    // meant to be rejected - the arguments are invalid on purpose. Where a pointer is
    // passed it is null or points into a local array sized for the call.
    unsafe { gl.active_texture(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
    let num_max_texture_units = case.get_int(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS) as u32;
    unsafe { gl.active_texture(glw::GL_TEXTURE0 + num_max_texture_units) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

// --- glBindTexture -----------------------------------------------------------------

fn bindtexture_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not one of the allowable values.");
    // SAFETY: as above.
    unsafe { gl.bind_texture(0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn bindtexture_type_mismatch(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if texture was previously created with a target that doesn't match that of target.");
    let mut texture = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture);
    }
    case.expect_error(glw::GL_INVALID_OPERATION);
    unsafe { gl.delete_textures(1, &texture) };
}

// --- glCompressedTexImage2D --------------------------------------------------------

fn compressedteximage_2d_invalid_target(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    let Some(format) = formats.first().copied() else { return };
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: as above.
    unsafe { gl.compressed_tex_image_2d(0, 0, format as u32, 0, 0, 0, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn compressedteximage_2d_invalid_format(case: &mut ApiCase<'_>, targets: &[GLenum]) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if internalformat is not a supported format returned in GL_COMPRESSED_TEXTURE_FORMATS.");
    // SAFETY: as above.
    for target in targets {
        unsafe { gl.compressed_tex_image_2d(*target, 0, 0, 0, 0, 0, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn compressedteximage2d_neg_level(case: &mut ApiCase<'_>, targets: &[GLenum]) {
    let Some(format) = non_paletted_format(case) else {
        return;
    };
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    for target in targets {
        unsafe { gl.compressed_tex_image_2d(*target, -1, format, 0, 0, 0, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_level_max_tex2d(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    let Some(format) = formats.first().copied() else { return };
    let level = log2_max_texture_size(case, glw::GL_MAX_TEXTURE_SIZE);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    unsafe { gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, level, format as u32, 0, 0, 0, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn compressedteximage2d_level_max_cube_pos(case: &mut ApiCase<'_>) {
    // Paletted formats do not support cube maps.
    let Some(format) = non_paletted_format(case) else {
        return;
    };
    let level = log2_max_texture_size(case, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe { gl.compressed_tex_image_2d(target, level, format, 0, 0, 0, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_neg_width_height_tex2d(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    let Some(format) = formats.first().copied() else { return };
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    for (width, height) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe {
            gl.compressed_tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format as u32,
                width,
                height,
                0,
                0,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_neg_width_height_cube(case: &mut ApiCase<'_>, target: GLenum) {
    let Some(format) = non_paletted_format(case) else {
        return;
    };
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    for (width, height) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe { gl.compressed_tex_image_2d(target, 0, format, width, height, 0, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_width_height_max_tex2d(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    let Some(format) = formats.first().copied() else { return };
    let max = case.get_int(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");
    // SAFETY: as above.
    for (width, height) in [(max, 0), (0, max), (max, max)] {
        unsafe {
            gl.compressed_tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format as u32,
                width,
                height,
                0,
                0,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_width_height_max_cube(case: &mut ApiCase<'_>, target: GLenum) {
    let Some(format) = non_paletted_format(case) else {
        return;
    };
    let max = case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_CUBE_MAP_TEXTURE_SIZE.");
    // SAFETY: as above.
    for (width, height) in [(max, 0), (0, max), (max, max)] {
        unsafe { gl.compressed_tex_image_2d(target, 0, format, width, height, 0, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_invalid_border_tex2d(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    let Some(format) = formats.first().copied() else { return };
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0.");
    // SAFETY: as above.
    for border in [1, -1] {
        unsafe { gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, format as u32, 0, 0, border, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_invalid_border_cube(case: &mut ApiCase<'_>, target: GLenum) {
    let Some(format) = non_paletted_format(case) else {
        return;
    };
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0.");
    // SAFETY: as above.
    for border in [1, -1] {
        unsafe { gl.compressed_tex_image_2d(target, 0, format, 0, 0, border, 0, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn compressedteximage2d_invalid_size(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    let Some(format) = formats.first().copied() else { return };
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.");
    // SAFETY: as above.
    unsafe { gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, format as u32, 0, 0, 0, -1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

// --- glCopyTexImage2D --------------------------------------------------------------

fn copyteximage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: as above.
    unsafe { gl.copy_tex_image_2d(0, 0, glw::GL_RGB, 0, 0, 64, 64, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn copyteximage2d_invalid_format(case: &mut ApiCase<'_>, targets: &[GLenum], size: i32) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM or GL_INVALID_VALUE is generated if internalformat is not an accepted format.");
    // SAFETY: as above.
    for target in targets {
        unsafe { gl.copy_tex_image_2d(*target, 0, 0, 0, 0, size, size, 0) };
        case.expect_error2(glw::GL_INVALID_ENUM, glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_inequal_width_height_cube(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe { gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 16, 17, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_neg_level(case: &mut ApiCase<'_>, targets: &[GLenum], size: i32) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    for target in targets {
        unsafe { gl.copy_tex_image_2d(*target, -1, glw::GL_RGB, 0, 0, size, size, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_level_max(case: &mut ApiCase<'_>, targets: &[GLenum], limit: GLenum, size: i32) {
    let level = log2_max_texture_size(case, limit);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    for target in targets {
        unsafe { gl.copy_tex_image_2d(*target, level, glw::GL_RGB, 0, 0, size, size, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_invalid_width_height(case: &mut ApiCase<'_>, target: GLenum) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    for (width, height) in [(-1, 1), (1, -1), (-1, -1)] {
        unsafe { gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, width, height, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_width_height_max_tex2d(case: &mut ApiCase<'_>) {
    let max = case.get_int(glw::GL_MAX_TEXTURE_SIZE) + 1;
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_TEXTURE_SIZE.");
    // SAFETY: as above.
    for (width, height) in [(max, 1), (1, max), (max, max)] {
        unsafe { gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, width, height, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_width_height_max_cube(case: &mut ApiCase<'_>, target: GLenum) {
    let max = case.get_int(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE) + 1;
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is greater than GL_MAX_CUBE_MAP_TEXTURE_SIZE.");
    // SAFETY: as above; note the order upstream uses here - height first.
    for (width, height) in [(1, max), (max, 1), (max, max)] {
        unsafe { gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, width, height, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_invalid_border(case: &mut ApiCase<'_>, target: GLenum, size: i32) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0.");
    // SAFETY: as above.
    for border in [-1, 1] {
        unsafe { gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, size, size, border) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn copyteximage2d_incomplete_framebuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section(
        "GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.",
    );
    let mut fbo = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, glw::GL_RGB, 0, 0, 64, 64, 0);
    }
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    for target in CUBE_FACE_TARGETS {
        unsafe { gl.copy_tex_image_2d(target, 0, glw::GL_RGB, 0, 0, 16, 16, 0) };
        case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    }
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
    }
}

// --- glCopyTexSubImage2D -----------------------------------------------------------

/// The 16x16 texture every `copytexsubimage2d_*` and `texsubimage2d_*` case needs
/// before it can ask for a sub-image error.
struct SubImageTexture {
    name: u32,
}

impl SubImageTexture {
    fn tex_2d(case: &ApiCase<'_>) -> Self {
        let gl = case.gl();
        let mut name = 0;
        // SAFETY: the image has no data pointer, so nothing is read.
        unsafe {
            gl.gen_textures(1, &mut name);
            gl.bind_texture(glw::GL_TEXTURE_2D, name);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA as i32,
                16,
                16,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }
        Self { name }
    }

    fn cube(case: &ApiCase<'_>) -> Self {
        let gl = case.gl();
        let mut name = 0;
        // SAFETY: as above, for all six faces.
        unsafe {
            gl.gen_textures(1, &mut name);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, name);
            for target in CUBE_FACE_TARGETS {
                gl.tex_image_2d(
                    target,
                    0,
                    glw::GL_RGBA as i32,
                    16,
                    16,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
            }
        }
        Self { name }
    }

    fn delete(self, case: &ApiCase<'_>) {
        // SAFETY: the name is this helper's own and is deleted exactly once.
        unsafe { case.gl().delete_textures(1, &self.name) };
    }
}

fn copytexsubimage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not GL_TEXTURE_2D or one of the cube map face targets.");
    // SAFETY: as above.
    unsafe { gl.copy_tex_sub_image_2d(0, 0, 0, 0, 0, 0, 0, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn copytexsubimage2d_neg_level_tex2d(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, -1, 0, 0, 0, 0, 0, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);
    texture.delete(case);
}

fn copytexsubimage2d_neg_level_cube(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::cube(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe { gl.copy_tex_sub_image_2d(target, -1, 0, 0, 0, 0, 0, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn copytexsubimage2d_level_max_tex2d(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let level = log2_max_texture_size(case, glw::GL_MAX_TEXTURE_SIZE);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, level, 0, 0, 0, 0, 0, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);
    texture.delete(case);
}

fn copytexsubimage2d_level_max_cube_pos(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::cube(case);
    let level = log2_max_texture_size(case, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe { gl.copy_tex_sub_image_2d(target, level, 0, 0, 0, 0, 0, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn copytexsubimage2d_neg_offset(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if xoffset or yoffset is less than 0.");
    // SAFETY: as above.
    for (x, y) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, x, y, 0, 0, 0, 0) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn copytexsubimage2d_offset_allowed(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section(
        "GL_INVALID_VALUE is generated if xoffset + width > texture width or yoffset + height > texture height.",
    );
    // SAFETY: as above.
    for (x, y) in [(8, 4), (4, 8), (8, 8)] {
        unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, x, y, 0, 0, 10, 10) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn copytexsubimage2d_neg_wdt_hgt(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    for (width, height) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, width, height) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn copytexsubimage2d_incomplete_framebuffer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture = [0u32; 2];
    let mut fbo = 0;
    // SAFETY: as above; the images have no data pointer.
    unsafe {
        gl.gen_textures(2, texture.as_mut_ptr());
        gl.bind_texture(glw::GL_TEXTURE_2D, texture[0]);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as i32,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture[1]);
        for target in CUBE_FACE_TARGETS {
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGBA as i32,
                4,
                4,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }
    }
    case.expect_error(glw::GL_NO_ERROR);

    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }
    case.expect_error(glw::GL_NO_ERROR);

    case.section(
        "GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.",
    );
    unsafe { gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, 0, 0) };
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    for target in CUBE_FACE_TARGETS {
        unsafe { gl.copy_tex_sub_image_2d(target, 0, 0, 0, 0, 0, 0, 0) };
        case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    }

    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
        gl.delete_textures(2, texture.as_ptr());
    }
}

// --- glDeleteTextures / glGenTextures ----------------------------------------------

fn deletetextures_invalid_number(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.delete_textures(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn deletetextures_invalid_number_bind(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
    }
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    unsafe { gl.delete_textures(-1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.delete_textures(1, &texture) };
}

fn gentextures_invalid_size(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: as above.
    unsafe { gl.gen_textures(-1, std::ptr::null_mut()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

// --- glGenerateMipmap --------------------------------------------------------------

fn generatemipmap_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is not GL_TEXTURE_2D or GL_TEXTURE_CUBE_MAP.");
    // SAFETY: as above.
    unsafe { gl.generate_mipmap(0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn generatemipmap_npot_wdt_hgt(case: &mut ApiCase<'_>) {
    // With GL_OES_texture_npot a non-power-of-two mipmap is legal, so there is no
    // error to demand and upstream skips the case.
    if case
        .context()
        .context_info
        .is_extension_supported("GL_OES_texture_npot")
    {
        log::debug!("// GL_OES_texture_npot extension removes the error");
        return;
    }

    let gl = case.gl();
    let mut texture = 0;
    case.section(
        "INVALID_OPERATION is generated if either the width or height of the zero level array is not a power of two.",
    );
    // SAFETY: as above; the images have no data pointer.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
    }
    for (width, height) in [(256, 257), (257, 256), (257, 257)] {
        unsafe {
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGB as i32,
                width,
                height,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            gl.generate_mipmap(glw::GL_TEXTURE_2D);
        }
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
    unsafe { gl.delete_textures(1, &texture) };
}

fn generatemipmap_incomplete_cube(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut texture = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture);
    }

    case.section("INVALID_OPERATION is generated if the texture bound to target is not cube complete.");
    // Five faces at 16x16 and one at 32x32, which is what makes it incomplete.
    unsafe {
        for target in CUBE_FACE_TARGETS.iter().take(5) {
            gl.tex_image_2d(
                *target,
                0,
                glw::GL_RGB as i32,
                16,
                16,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
        }
        gl.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            0,
            glw::GL_RGB as i32,
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

    unsafe { gl.delete_textures(1, &texture) };
}

fn generatemipmap_zero_level_array_compressed(case: &mut ApiCase<'_>) {
    let formats = compressed_formats(case);
    if formats.is_empty() {
        return;
    }

    // A paletted format accepts zero dimensions and a zero image size, and the PVRTCv1
    // formats need at least 32 bytes of data even then - so neither can produce the
    // "zero level array is compressed" state this case needs.
    let mut ndx = first_non_paletted_format(case, &formats);
    let info = &case.context().context_info;
    if info.is_extension_supported("GL_EXT_pvrtc_sRGB") {
        while ndx < formats.len() && (0x8A54..=0x8A57).contains(&formats[ndx]) {
            ndx += 1;
        }
    }
    if info.is_extension_supported("GL_IMG_texture_compression_pvrtc") {
        while ndx < formats.len() && (0x8C00..=0x8C03).contains(&formats[ndx]) {
            ndx += 1;
        }
    }
    let Some(format) = formats.get(ndx).map(|f| *f as u32) else {
        return;
    };

    let gl = case.gl();
    let mut texture = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
    }

    case.section(
        "GL_INVALID_OPERATION is generated if the zero level array is stored in a compressed internal format.",
    );
    unsafe { gl.compressed_tex_image_2d(glw::GL_TEXTURE_2D, 0, format, 0, 0, 0, 0, std::ptr::null()) };
    case.expect_error(glw::GL_NO_ERROR);
    unsafe { gl.generate_mipmap(glw::GL_TEXTURE_2D) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    unsafe { gl.delete_textures(1, &texture) };
}

// --- glPixelStorei -----------------------------------------------------------------

fn pixelstorei_invalid_pname(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if pname is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.pixel_storei(0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn pixelstorei_invalid_param(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if alignment is specified as other than 1, 2, 4, or 8.");
    // SAFETY: as above.
    for (pname, param) in [
        (glw::GL_PACK_ALIGNMENT, 0),
        (glw::GL_UNPACK_ALIGNMENT, 0),
        (glw::GL_PACK_ALIGNMENT, 16),
        (glw::GL_UNPACK_ALIGNMENT, 16),
    ] {
        unsafe { gl.pixel_storei(pname, param) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

// --- glTexImage2D ------------------------------------------------------------------

fn teximage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            0,
            0,
            glw::GL_RGB as i32,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn teximage2d_invalid_format(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as i32,
            1,
            1,
            0,
            0,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn teximage2d_invalid_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if type is not a type constant.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as i32,
            1,
            1,
            0,
            glw::GL_RGB,
            0,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn teximage2d_inequal_width_height_cube(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe {
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGB as i32,
                1,
                2,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn teximage2d_neg_level(case: &mut ApiCase<'_>, targets: &[GLenum]) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    for target in targets {
        unsafe {
            gl.tex_image_2d(
                *target,
                -1,
                glw::GL_RGB as i32,
                1,
                1,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn teximage2d_level_max(case: &mut ApiCase<'_>, targets: &[GLenum], limit: GLenum) {
    let level = log2_max_texture_size(case, limit);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    for target in targets {
        unsafe {
            gl.tex_image_2d(
                *target,
                level,
                glw::GL_RGB as i32,
                1,
                1,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn teximage2d_invalid_internalformat(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if internalFormat is not an accepted format.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            1,
            1,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn teximage2d_neg_width_height(case: &mut ApiCase<'_>, target: GLenum) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    for (width, height) in [(-1, 1), (1, -1), (-1, -1)] {
        unsafe {
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGB as i32,
                width,
                height,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn teximage2d_width_height_max(case: &mut ApiCase<'_>, target: GLenum, limit: GLenum) {
    let max = case.get_int(limit) + 1;
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is greater than the maximum texture size.");
    // SAFETY: as above.
    for (width, height) in [(max, 1), (1, max), (max, max)] {
        unsafe {
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGB as i32,
                width,
                height,
                0,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn teximage2d_invalid_border(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if border is not 0.");
    // SAFETY: as above.
    for border in [1, -1] {
        unsafe {
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGB as i32,
                1,
                1,
                border,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn teximage2d_format_mismatch(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if format does not match internalFormat.");
    // SAFETY: as above.
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB as i32,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_OPERATION);
}

fn teximage2d_type_format_mismatch(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if type is GL_UNSIGNED_SHORT_4_4_4_4 or GL_UNSIGNED_SHORT_5_5_5_1 and format is not GL_RGBA.");
    // SAFETY: as above.
    for gl_type in [glw::GL_UNSIGNED_SHORT_4_4_4_4, glw::GL_UNSIGNED_SHORT_5_5_5_1] {
        unsafe {
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGB as i32,
                1,
                1,
                0,
                glw::GL_RGB,
                gl_type,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
}

// --- glTexSubImage2D ---------------------------------------------------------------

fn texsubimage2d_invalid_target(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if target is invalid.");
    // SAFETY: as above.
    unsafe { gl.tex_sub_image_2d(0, 0, 0, 0, 0, 0, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn texsubimage2d_invalid_format(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if format is not an accepted format constant.");
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            0,
            0,
            0,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_ENUM);
    texture.delete(case);
}

fn texsubimage2d_invalid_type(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if type is not a type constant.");
    // SAFETY: as above.
    unsafe { gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, glw::GL_RGB, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);
    texture.delete(case);
}

fn texsubimage2d_neg_level_tex2d(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            -1,
            0,
            0,
            0,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);
    texture.delete(case);
}

fn texsubimage2d_neg_level_cube(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::cube(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is less than 0.");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe {
            gl.tex_sub_image_2d(
                target,
                -1,
                0,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn texsubimage2d_level_max_tex2d(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let level = log2_max_texture_size(case, glw::GL_MAX_TEXTURE_SIZE);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    unsafe {
        gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            level,
            0,
            0,
            0,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_INVALID_VALUE);
    texture.delete(case);
}

fn texsubimage2d_level_max_cube(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::cube(case);
    let level = log2_max_texture_size(case, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if level is greater than log_2(GL_MAX_TEXTURE_SIZE).");
    // SAFETY: as above.
    for target in CUBE_FACE_TARGETS {
        unsafe {
            gl.tex_sub_image_2d(
                target,
                level,
                0,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn texsubimage2d_neg_offset(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if xoffset or yoffset is less than 0.");
    // SAFETY: as above.
    for (x, y) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                x,
                y,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn texsubimage2d_offset_allowed(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section(
        "GL_INVALID_VALUE is generated if xoffset + width > texture width or yoffset + height > texture height.",
    );
    // SAFETY: the image has no data pointer, so the size arguments read nothing.
    for (x, y) in [(8, 4), (4, 8), (8, 8)] {
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                x,
                y,
                10,
                10,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn texsubimage2d_neg_wdt_hgt(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width or height is less than 0.");
    // SAFETY: as above.
    for (width, height) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                width,
                height,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            )
        };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
    texture.delete(case);
}

fn texsubimage2d_type_format_mismatch(case: &mut ApiCase<'_>) {
    let texture = SubImageTexture::tex_2d(case);
    let gl = case.gl();
    case.section("GL_INVALID_OPERATION is generated if type is GL_UNSIGNED_SHORT_5_6_5 and format is not GL_RGB, or if type is GL_UNSIGNED_SHORT_4_4_4_4 or GL_UNSIGNED_SHORT_5_5_5_1 and format is not GL_RGBA.");
    // SAFETY: as above.
    for (format, gl_type) in [
        (glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_6_5),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        (glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_5_5_1),
    ] {
        unsafe { gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, format, gl_type, std::ptr::null()) };
        case.expect_error(glw::GL_INVALID_OPERATION);
    }
    texture.delete(case);
}

// --- glCompressedTexSubImage2D -----------------------------------------------------

/// The six formats `getCompressedTexSubImage2DFormat` accepts: upstream looks for one
/// of these among `GL_COMPRESSED_TEXTURE_FORMATS` before it will run the case.
const COMPRESSED_TEX_SUB_IMAGE_2D_FORMATS: [i32; 6] = [
    0x83F0, // GL_COMPRESSED_RGB_S3TC_DXT1_EXT
    0x83F1, // GL_COMPRESSED_RGBA_S3TC_DXT1_EXT
    0x8C00, // GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG
    0x8C01, // GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG
    0x8C02, // GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG
    0x8C03, // GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG
];

/// The shared shape of all nine `compressedtexsubimage2d_*` cases - and the reason
/// none of them ever reaches its `glCompressedTexSubImage2D` calls.
///
/// Upstream needs a valid one-block image before it can ask for a sub-image error, so
/// it maps the GL format through `glu::mapGLCompressedTexFormat` to get the block size.
/// That function knows ETC, EAC and ASTC and **nothing else** - all six formats above
/// fall through to its `throw tcu::InternalError`, which the case body catches and
/// answers with "Skipping unknown format". So on every driver in existence the outcome
/// is one of exactly two things, and this port reproduces both:
///
///   - none of the six formats advertised -> NotSupported, "No suitable compressed
///     formats found";
///   - at least one advertised -> Pass, having tested nothing.
///
/// Reproducing that faithfully is the only way `cts-diff` can agree, and writing the
/// "real" body instead would disagree with upstream on a driver that advertises DXT1.
/// If upstream ever teaches `mapGLCompressedTexFormat` those formats, this is the
/// function to fill in - the per-case argument lists are in the C++ next to each name.
fn compressedtexsubimage2d_body(case: &mut ApiCase<'_>) -> TestOutcome {
    let supported = compressed_formats(case);
    let accepted: Vec<i32> = COMPRESSED_TEX_SUB_IMAGE_2D_FORMATS
        .into_iter()
        .filter(|f| supported.contains(f))
        .collect();

    if accepted.is_empty() {
        log::info!("// No suitable compressed formats found, cannot evaluate test.");
        return Ok(TestStatus::new(
            TestResult::NotSupported,
            "No suitable compressed formats found",
        ));
    }

    for format in accepted {
        log::info!("Skipping unknown format: {format}");
    }
    Ok(TestStatus::pass("Pass"))
}

// --- glTexParameter* ---------------------------------------------------------------

/// The seven (target, pname, param) triples every `texparameter*` case walks, each of
/// which must produce GL_INVALID_ENUM.
const TEX_PARAMETER_CASES: [(GLenum, GLenum, GLenum); 7] = [
    (0, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR),
    (glw::GL_TEXTURE_2D, 0, glw::GL_LINEAR),
    (0, 0, glw::GL_LINEAR),
    (glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, 0),
    (glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_REPEAT),
    (glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, 0),
    (glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_NEAREST),
];

/// A bound texture, or none - the `_bind` variant of each case exists to check that
/// the error does not depend on whether one is bound.
fn with_optional_texture(case: &mut ApiCase<'_>, bind: bool, body: impl FnOnce(&mut ApiCase<'_>)) {
    let gl = case.gl();
    let mut texture = 0;
    if bind {
        // SAFETY: as above.
        unsafe {
            gl.gen_textures(1, &mut texture);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        }
    }
    body(case);
    if bind {
        unsafe { gl.delete_textures(1, &texture) };
    }
}

fn texparameteri(case: &mut ApiCase<'_>, bind: bool) {
    with_optional_texture(case, bind, |case| {
        let gl = case.gl();
        case.section("GL_INVALID_ENUM is generated if target or pname is not one of the accepted defined values, or if param should have a defined constant value (based on the value of pname) and does not.");
        // SAFETY: as above.
        for (target, pname, param) in TEX_PARAMETER_CASES {
            unsafe { gl.tex_parameteri(target, pname, param as i32) };
            case.expect_error(glw::GL_INVALID_ENUM);
        }
    });
}

fn texparameterf(case: &mut ApiCase<'_>, bind: bool) {
    with_optional_texture(case, bind, |case| {
        let gl = case.gl();
        case.section("GL_INVALID_ENUM is generated if target or pname is not one of the accepted defined values, or if param should have a defined constant value (based on the value of pname) and does not.");
        // SAFETY: as above.
        for (target, pname, param) in TEX_PARAMETER_CASES {
            unsafe { gl.tex_parameterf(target, pname, param as f32) };
            case.expect_error(glw::GL_INVALID_ENUM);
        }
    });
}

fn texparameteriv(case: &mut ApiCase<'_>, bind: bool) {
    with_optional_texture(case, bind, |case| {
        let gl = case.gl();
        let mut params = [0i32; 1];
        case.section("GL_INVALID_ENUM is generated if target or pname is not one of the accepted defined values, or if params should have a defined constant value (based on the value of pname) and does not.");
        // SAFETY: the array holds the single value any of these pnames reads. The value
        // goes into it per iteration, which is what upstream does with `params[0] = ...`
        // between calls - the same table of (target, pname, param) as the scalar cases.
        for (target, pname, param) in TEX_PARAMETER_CASES {
            params[0] = param as i32;
            unsafe { gl.tex_parameteriv(target, pname, params.as_ptr()) };
            case.expect_error(glw::GL_INVALID_ENUM);
        }
    });
}

fn texparameterfv(case: &mut ApiCase<'_>, bind: bool) {
    with_optional_texture(case, bind, |case| {
        let gl = case.gl();
        let mut params = [0.0f32; 1];
        case.section("GL_INVALID_ENUM is generated if target or pname is not one of the accepted defined values, or if params should have a defined constant value (based on the value of pname) and does not.");
        // SAFETY: as in `texparameteriv`.
        for (target, pname, param) in TEX_PARAMETER_CASES {
            params[0] = param as f32;
            unsafe { gl.tex_parameterfv(target, pname, params.as_ptr()) };
            case.expect_error(glw::GL_INVALID_ENUM);
        }
    });
}

/// One of the nine `compressedtexsubimage2d_*` cases.
///
/// A plain `TestCase` rather than an `ApiCase` because its verdict can be
/// NotSupported, which an API case - always Pass unless an error mismatched - cannot
/// express.
struct CompressedTexSubImage2DCase {
    name: &'static str,
}

impl TestCase for CompressedTexSubImage2DCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &crate::glu::Context) -> TestOutcome {
        let mut case = ApiCase::new(context);
        compressedtexsubimage2d_body(&mut case)
    }
}

/// `NegativeTextureApiTests::init`, in upstream's order and under upstream's names.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");

    // glActiveTexture, glBindTexture
    add_api_cases(
        &mut group,
        &[
            (
                "activetexture_invalid_texture",
                activetexture_invalid_texture as ApiCaseFn,
            ),
            ("bindtexture_invalid_target", bindtexture_invalid_target),
            ("bindtexture_type_mismatch", bindtexture_type_mismatch),
        ],
    );

    // glCompressedTexImage2D
    add_api_case(
        &mut group,
        "compressedteximage_2d_invalid_target",
        compressedteximage_2d_invalid_target,
    );
    add_api_case(&mut group, "compressedteximage_2d_invalid_format_tex2d", |case| {
        compressedteximage_2d_invalid_format(case, &[glw::GL_TEXTURE_2D]);
    });
    add_api_case(&mut group, "compressedteximage_2d_invalid_format_cube", |case| {
        compressedteximage_2d_invalid_format(case, &CUBE_FACE_TARGETS);
    });
    add_api_case(&mut group, "compressedteximage2d_neg_level_tex2d", |case| {
        compressedteximage2d_neg_level(case, &[glw::GL_TEXTURE_2D]);
    });
    add_api_case(&mut group, "compressedteximage2d_neg_level_cube", |case| {
        compressedteximage2d_neg_level(case, &CUBE_FACE_TARGETS);
    });
    add_api_case(
        &mut group,
        "compressedteximage2d_level_max_tex2d",
        compressedteximage2d_level_max_tex2d,
    );
    add_api_case(
        &mut group,
        "compressedteximage2d_level_max_cube_pos",
        compressedteximage2d_level_max_cube_pos,
    );
    add_api_case(
        &mut group,
        "compressedteximage2d_neg_width_height_tex2d",
        compressedteximage2d_neg_width_height_tex2d,
    );
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("compressedteximage2d_neg_width_height_{suffix}"),
            move |case| {
                compressedteximage2d_neg_width_height_cube(case, target);
            },
        );
    }
    add_api_case(
        &mut group,
        "compressedteximage2d_width_height_max_tex2d",
        compressedteximage2d_width_height_max_tex2d,
    );
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("compressedteximage2d_width_height_max_{suffix}"),
            move |case| {
                compressedteximage2d_width_height_max_cube(case, target);
            },
        );
    }
    add_api_case(
        &mut group,
        "compressedteximage2d_invalid_border",
        compressedteximage2d_invalid_border_tex2d,
    );
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("compressedteximage2d_invalid_border_{suffix}"),
            move |case| {
                compressedteximage2d_invalid_border_cube(case, target);
            },
        );
    }
    add_api_case(
        &mut group,
        "compressedteximage2d_invalid_size",
        compressedteximage2d_invalid_size,
    );

    // glCopyTexImage2D
    add_api_case(
        &mut group,
        "copyteximage2d_invalid_target",
        copyteximage2d_invalid_target,
    );
    add_api_case(&mut group, "copyteximage2d_invalid_format_tex2d", |case| {
        copyteximage2d_invalid_format(case, &[glw::GL_TEXTURE_2D], 64);
    });
    add_api_case(&mut group, "copyteximage2d_invalid_format_cube", |case| {
        copyteximage2d_invalid_format(case, &CUBE_FACE_TARGETS, 16);
    });
    add_api_case(
        &mut group,
        "copyteximage2d_inequal_width_height_cube",
        copyteximage2d_inequal_width_height_cube,
    );
    add_api_case(&mut group, "copyteximage2d_neg_level_tex2d", |case| {
        copyteximage2d_neg_level(case, &[glw::GL_TEXTURE_2D], 64);
    });
    add_api_case(&mut group, "copyteximage2d_neg_level_cube", |case| {
        copyteximage2d_neg_level(case, &CUBE_FACE_TARGETS, 16);
    });
    add_api_case(&mut group, "copyteximage2d_level_max_tex2d", |case| {
        copyteximage2d_level_max(case, &[glw::GL_TEXTURE_2D], glw::GL_MAX_TEXTURE_SIZE, 64);
    });
    add_api_case(&mut group, "copyteximage2d_level_max_cube", |case| {
        copyteximage2d_level_max(case, &CUBE_FACE_TARGETS, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE, 16);
    });
    add_api_case(&mut group, "copyteximage2d_invalid_width_height_tex2d", |case| {
        copyteximage2d_invalid_width_height(case, glw::GL_TEXTURE_2D);
    });
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("copyteximage2d_invalid_width_height_{suffix}"),
            move |case| {
                copyteximage2d_invalid_width_height(case, target);
            },
        );
    }
    add_api_case(
        &mut group,
        "copyteximage2d_width_height_max_tex2d",
        copyteximage2d_width_height_max_tex2d,
    );
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("copyteximage2d_width_height_max_{suffix}"),
            move |case| {
                copyteximage2d_width_height_max_cube(case, target);
            },
        );
    }
    add_api_case(&mut group, "copyteximage2d_invalid_border_tex2d", |case| {
        copyteximage2d_invalid_border(case, glw::GL_TEXTURE_2D, 0);
    });
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("copyteximage2d_invalid_border_{suffix}"),
            move |case| {
                copyteximage2d_invalid_border(case, target, 0);
            },
        );
    }
    add_api_case(
        &mut group,
        "copyteximage2d_incomplete_framebuffer",
        copyteximage2d_incomplete_framebuffer,
    );

    // glCopyTexSubImage2D
    add_api_cases(
        &mut group,
        &[
            (
                "copytexsubimage2d_invalid_target",
                copytexsubimage2d_invalid_target as ApiCaseFn,
            ),
            ("copytexsubimage2d_neg_level_tex2d", copytexsubimage2d_neg_level_tex2d),
            ("copytexsubimage2d_neg_level_cube", copytexsubimage2d_neg_level_cube),
            ("copytexsubimage2d_level_max_tex2d", copytexsubimage2d_level_max_tex2d),
            (
                "copytexsubimage2d_level_max_cube_pos",
                copytexsubimage2d_level_max_cube_pos,
            ),
            ("copytexsubimage2d_neg_offset", copytexsubimage2d_neg_offset),
            ("copytexsubimage2d_offset_allowed", copytexsubimage2d_offset_allowed),
            ("copytexsubimage2d_neg_wdt_hgt", copytexsubimage2d_neg_wdt_hgt),
            (
                "copytexsubimage2d_incomplete_framebuffer",
                copytexsubimage2d_incomplete_framebuffer,
            ),
        ],
    );

    // glDeleteTextures, glGenerateMipmap, glGenTextures, glPixelStorei
    add_api_cases(
        &mut group,
        &[
            (
                "deletetextures_invalid_number",
                deletetextures_invalid_number as ApiCaseFn,
            ),
            ("deletetextures_invalid_number_bind", deletetextures_invalid_number_bind),
            ("generatemipmap_invalid_target", generatemipmap_invalid_target),
            ("generatemipmap_npot_wdt_hgt", generatemipmap_npot_wdt_hgt),
            (
                "generatemipmap_zero_level_array_compressed",
                generatemipmap_zero_level_array_compressed,
            ),
            ("generatemipmap_incomplete_cube", generatemipmap_incomplete_cube),
            ("gentextures_invalid_size", gentextures_invalid_size),
            ("pixelstorei_invalid_pname", pixelstorei_invalid_pname),
            ("pixelstorei_invalid_param", pixelstorei_invalid_param),
        ],
    );

    // glTexImage2D
    add_api_cases(
        &mut group,
        &[
            ("teximage2d_invalid_target", teximage2d_invalid_target as ApiCaseFn),
            ("teximage2d_invalid_format", teximage2d_invalid_format),
            ("teximage2d_invalid_type", teximage2d_invalid_type),
            (
                "teximage2d_inequal_width_height_cube",
                teximage2d_inequal_width_height_cube,
            ),
        ],
    );
    add_api_case(&mut group, "teximage2d_neg_level_tex2d", |case| {
        teximage2d_neg_level(case, &[glw::GL_TEXTURE_2D]);
    });
    add_api_case(&mut group, "teximage2d_neg_level_cube", |case| {
        teximage2d_neg_level(case, &CUBE_FACE_TARGETS);
    });
    add_api_case(&mut group, "teximage2d_level_max_tex2d", |case| {
        teximage2d_level_max(case, &[glw::GL_TEXTURE_2D], glw::GL_MAX_TEXTURE_SIZE);
    });
    add_api_case(&mut group, "teximage2d_level_max_cube", |case| {
        teximage2d_level_max(case, &CUBE_FACE_TARGETS, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE);
    });
    add_api_case(
        &mut group,
        "teximage2d_invalid_internalformat",
        teximage2d_invalid_internalformat,
    );
    add_api_case(&mut group, "teximage2d_neg_width_height_tex2d", |case| {
        teximage2d_neg_width_height(case, glw::GL_TEXTURE_2D);
    });
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("teximage2d_neg_width_height_{suffix}"),
            move |case| {
                teximage2d_neg_width_height(case, target);
            },
        );
    }
    add_api_case(&mut group, "teximage2d_width_height_max_tex2d", |case| {
        teximage2d_width_height_max(case, glw::GL_TEXTURE_2D, glw::GL_MAX_TEXTURE_SIZE);
    });
    for (suffix, target) in CUBE_FACES {
        add_api_case(
            &mut group,
            format!("teximage2d_width_height_max_{suffix}"),
            move |case| {
                teximage2d_width_height_max(case, target, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE);
            },
        );
    }
    add_api_cases(
        &mut group,
        &[
            ("teximage2d_invalid_border", teximage2d_invalid_border as ApiCaseFn),
            ("teximage2d_format_mismatch", teximage2d_format_mismatch),
            ("teximage2d_type_format_mismatch", teximage2d_type_format_mismatch),
        ],
    );

    // glTexSubImage2D
    add_api_cases(
        &mut group,
        &[
            (
                "texsubimage2d_invalid_target",
                texsubimage2d_invalid_target as ApiCaseFn,
            ),
            ("texsubimage2d_invalid_format", texsubimage2d_invalid_format),
            ("texsubimage2d_invalid_type", texsubimage2d_invalid_type),
            ("texsubimage2d_neg_level_tex2d", texsubimage2d_neg_level_tex2d),
            ("texsubimage2d_neg_level_cube", texsubimage2d_neg_level_cube),
            ("texsubimage2d_level_max_tex2d", texsubimage2d_level_max_tex2d),
            ("texsubimage2d_level_max_cube", texsubimage2d_level_max_cube),
            ("texsubimage2d_neg_offset", texsubimage2d_neg_offset),
            ("texsubimage2d_offset_allowed", texsubimage2d_offset_allowed),
            ("texsubimage2d_neg_wdt_hgt", texsubimage2d_neg_wdt_hgt),
            ("texsubimage2d_type_format_mismatch", texsubimage2d_type_format_mismatch),
        ],
    );

    // glCompressedTexSubImage2D
    for name in [
        "compressedtexsubimage2d_invalid_target",
        "compressedtexsubimage2d_neg_level_tex2d",
        "compressedtexsubimage2d_neg_level_cube",
        "compressedtexsubimage2d_level_max_tex2d",
        "compressedtexsubimage2d_level_max_cube",
        "compressedtexsubimage2d_neg_offset",
        "compressedtexsubimage2d_offset_allowed",
        "compressedtexsubimage2d_neg_wdt_hgt",
        "compressedtexsubimage2d_invalid_size",
    ] {
        group.add_child(Box::new(CompressedTexSubImage2DCase { name }) as Box<dyn TestCase>);
    }

    // glTexParameter*
    add_api_case(&mut group, "texparameteri", |case| texparameteri(case, false));
    add_api_case(&mut group, "texparameteri_bind", |case| texparameteri(case, true));
    add_api_case(&mut group, "texparameterf", |case| texparameterf(case, false));
    add_api_case(&mut group, "texparameterf_bind", |case| texparameterf(case, true));
    add_api_case(&mut group, "texparameteriv", |case| texparameteriv(case, false));
    add_api_case(&mut group, "texparameteriv_bind", |case| texparameteriv(case, true));
    add_api_case(&mut group, "texparameterfv", |case| texparameterfv(case, false));
    add_api_case(&mut group, "texparameterfv_bind", |case| texparameterfv(case, true));

    group
}
