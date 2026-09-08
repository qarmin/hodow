// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fNegativeFragmentApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See the note in `buffer.rs` about
// the shape of these files.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw;

fn scissor(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: a current context; the arguments are invalid on purpose and no pointer
    // is involved.
    for (width, height) in [(-1, 0), (0, -1), (-1, -1)] {
        unsafe { gl.scissor(0, 0, width, height) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn depth_func(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if func is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.depth_func(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn viewport(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: as above.
    for (width, height) in [(-1, 1), (1, -1), (-1, -1)] {
        unsafe { gl.viewport(0, 0, width, height) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn stencil_func(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if func is not one of the eight accepted values.");
    // SAFETY: as above.
    unsafe { gl.stencil_func(BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn stencil_func_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if face is not GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
    // SAFETY: as above.
    unsafe { gl.stencil_func_separate(BAD_ENUM, glw::GL_NEVER, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if func is not one of the eight accepted values.");
    unsafe { gl.stencil_func_separate(glw::GL_FRONT, BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn stencil_op(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if sfail, dpfail, or dppass is any value other than the eight defined symbolic constant values.");
    // SAFETY: as above.
    for (sfail, dpfail, dppass) in [
        (BAD_ENUM, glw::GL_ZERO, glw::GL_REPLACE),
        (glw::GL_KEEP, BAD_ENUM, glw::GL_REPLACE),
        (glw::GL_KEEP, glw::GL_ZERO, BAD_ENUM),
    ] {
        unsafe { gl.stencil_op(sfail, dpfail, dppass) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn stencil_op_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if face is any value other than GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
    // SAFETY: as above.
    unsafe { gl.stencil_op_separate(BAD_ENUM, glw::GL_KEEP, glw::GL_ZERO, glw::GL_REPLACE) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if sfail, dpfail, or dppass is any value other than the eight defined symbolic constant values.");
    for (sfail, dpfail, dppass) in [
        (BAD_ENUM, glw::GL_ZERO, glw::GL_REPLACE),
        (glw::GL_KEEP, BAD_ENUM, glw::GL_REPLACE),
        (glw::GL_KEEP, glw::GL_ZERO, BAD_ENUM),
    ] {
        unsafe { gl.stencil_op_separate(glw::GL_FRONT, sfail, dpfail, dppass) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn stencil_mask_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if face is not GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
    // SAFETY: as above.
    unsafe { gl.stencil_mask_separate(BAD_ENUM, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn blend_equation(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if mode is not one of GL_FUNC_ADD, GL_FUNC_SUBTRACT, or GL_FUNC_REVERSE_SUBTRACT.");
    // SAFETY: as above.
    unsafe { gl.blend_equation(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn blend_equation_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if either modeRGB or modeAlpha is not one of GL_FUNC_ADD, GL_FUNC_SUBTRACT, or GL_FUNC_REVERSE_SUBTRACT.");
    // SAFETY: as above.
    for (mode_rgb, mode_alpha) in [(BAD_ENUM, glw::GL_FUNC_ADD), (glw::GL_FUNC_ADD, BAD_ENUM)] {
        unsafe { gl.blend_equation_separate(mode_rgb, mode_alpha) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn blend_func_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if srcRGB, dstRGB, srcAlpha, or dstAlpha is not an accepted value.");
    // SAFETY: as above.
    for (src_rgb, dst_rgb, src_alpha, dst_alpha) in [
        (BAD_ENUM, glw::GL_ONE, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR),
        (glw::GL_ZERO, BAD_ENUM, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR),
        (glw::GL_ZERO, glw::GL_ONE, BAD_ENUM, glw::GL_ONE_MINUS_SRC_COLOR),
        (glw::GL_ZERO, glw::GL_ONE, glw::GL_SRC_COLOR, BAD_ENUM),
    ] {
        unsafe { gl.blend_func_separate(src_rgb, dst_rgb, src_alpha, dst_alpha) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn blend_func(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if either sfactor or dfactor is not an accepted value.");
    // SAFETY: as above.
    for (sfactor, dfactor) in [(BAD_ENUM, glw::GL_ONE), (glw::GL_ONE, BAD_ENUM)] {
        unsafe { gl.blend_func(sfactor, dfactor) };
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn cull_face(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.cull_face(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn front_face(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.front_face(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn line_width(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width is less than or equal to 0.");
    // SAFETY: as above.
    for width in [0.0, -1.0] {
        unsafe { gl.line_width(width) };
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

/// `NegativeFragmentApiTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragment");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("scissor", scissor),
        ("depth_func", depth_func),
        ("viewport", viewport),
        ("stencil_func", stencil_func),
        ("stencil_func_separate", stencil_func_separate),
        ("stencil_op", stencil_op),
        ("stencil_op_separate", stencil_op_separate),
        ("stencil_mask_separate", stencil_mask_separate),
        ("blend_equation", blend_equation),
        ("blend_equation_separate", blend_equation_separate),
        ("blend_func_separate", blend_func_separate),
        ("blend_func", blend_func),
        ("cull_face", cull_face),
        ("front_face", front_face),
        ("line_width", line_width),
    ];
    add_api_cases(&mut group, cases);
    group
}
