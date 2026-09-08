// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fRboStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLenum};
use crate::tcu::Random;

/// `checkRenderbufferParam`
fn check_renderbuffer_param(case: &mut ApiCase<'_>, pname: GLenum, reference: i32) {
    let gl = case.gl();
    let mut state = Guarded::<i32>::new();
    // SAFETY: one GLint out, guarded on both sides; a renderbuffer is bound.
    unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, pname, state.as_mut_ptr()) };
    if !state.verify_validity(case) {
        return;
    }
    if state.value() != reference {
        case.fail(format!("expected {reference}; got {}", state.value()), "got invalid value");
    }
}

/// `checkRenderbufferComponentSize` - a component of `-1` is not checked, which is
/// how upstream asks about only the colour or only the depth/stencil sizes.
fn check_renderbuffer_component_size(case: &mut ApiCase<'_>, sizes: [i32; 6]) {
    const PARAM_NAMES: [GLenum; 6] = [
        glw::GL_RENDERBUFFER_RED_SIZE,
        glw::GL_RENDERBUFFER_GREEN_SIZE,
        glw::GL_RENDERBUFFER_BLUE_SIZE,
        glw::GL_RENDERBUFFER_ALPHA_SIZE,
        glw::GL_RENDERBUFFER_DEPTH_SIZE,
        glw::GL_RENDERBUFFER_STENCIL_SIZE,
    ];

    let gl = case.gl();
    for (reference, pname) in sizes.into_iter().zip(PARAM_NAMES) {
        if reference == -1 {
            continue;
        }
        let mut state = Guarded::<i32>::new();
        // SAFETY: as in `check_renderbuffer_param`.
        unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, pname, state.as_mut_ptr()) };
        if !state.verify_validity(case) {
            return;
        }
        // A driver may give more bits than asked for, never fewer.
        if state.value() < reference {
            case.fail(format!("expected at least {reference}; got {}", state.value()), "got invalid value");
        }
    }
}

/// Runs `body` with a fresh renderbuffer bound.
fn with_renderbuffer(case: &mut ApiCase<'_>, body: impl FnOnce(&mut ApiCase<'_>)) {
    let gl = case.gl();
    let mut renderbuffer = 0;
    // SAFETY: the name is this case's own and is deleted below.
    unsafe {
        gl.gen_renderbuffers(1, &mut renderbuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    body(case);

    // SAFETY: as above.
    unsafe { gl.delete_renderbuffers(1, &renderbuffer) };
}

/// `RboSizeCase`
fn renderbuffer_size(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();
        let mut rnd = Random::new(0x00ab_cdef);

        check_renderbuffer_param(case, glw::GL_RENDERBUFFER_WIDTH, 0);
        check_renderbuffer_param(case, glw::GL_RENDERBUFFER_HEIGHT, 0);
        case.expect_error(glw::GL_NO_ERROR);

        for _ in 0..30 {
            let width = rnd.get_int(0, 128);
            let height = rnd.get_int(0, 128);
            // SAFETY: a legal internal format and non-negative extents.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, width, height) };
            case.expect_error(glw::GL_NO_ERROR);
            check_renderbuffer_param(case, glw::GL_RENDERBUFFER_WIDTH, width);
            check_renderbuffer_param(case, glw::GL_RENDERBUFFER_HEIGHT, height);
        }

        // Upstream detaches here even though nothing was attached, which on the
        // default framebuffer is an error it does not check - kept as written.
        // SAFETY: the call is rejected without touching anything.
        unsafe { gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0) };
    });
}

/// `RboInternalFormatCase`
fn renderbuffer_internal_format(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();

        check_renderbuffer_param(case, glw::GL_RENDERBUFFER_INTERNAL_FORMAT, glw::GL_RGBA4 as i32);
        case.expect_error(glw::GL_NO_ERROR);

        for format in [glw::GL_RGBA4, glw::GL_RGB5_A1, glw::GL_RGB565] {
            // SAFETY: the three colour formats ES 2.0 requires.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 1, 1) };
            case.expect_error(glw::GL_NO_ERROR);
            check_renderbuffer_param(case, glw::GL_RENDERBUFFER_INTERNAL_FORMAT, format as i32);
        }
    });
}

/// `RboComponentSizeColorCase`
fn renderbuffer_component_size_color(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();

        check_renderbuffer_component_size(case, [0, 0, 0, 0, 0, 0]);
        case.expect_error(glw::GL_NO_ERROR);

        for (format, bits) in [(glw::GL_RGBA4, [4, 4, 4, 4]), (glw::GL_RGB5_A1, [5, 5, 5, 1]), (glw::GL_RGB565, [5, 6, 5, 0])] {
            // SAFETY: as above.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 1, 1) };
            case.expect_error(glw::GL_NO_ERROR);
            check_renderbuffer_component_size(case, [bits[0], bits[1], bits[2], bits[3], -1, -1]);
        }
    });
}

/// `RboComponentSizeDepthCase`
fn renderbuffer_component_size_depth(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();

        // SAFETY: the depth format ES 2.0 requires.
        unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 1, 1) };
        case.expect_error(glw::GL_NO_ERROR);
        check_renderbuffer_component_size(case, [-1, -1, -1, -1, 16, 0]);

        // The stencil format is checked on its own, because upstream demands at least
        // eight bits rather than exactly what it asked for.
        // SAFETY: as above.
        unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8, 1, 1) };
        case.expect_error(glw::GL_NO_ERROR);

        let mut state = Guarded::<i32>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, glw::GL_RENDERBUFFER_STENCIL_SIZE, state.as_mut_ptr()) };
        if state.verify_validity(case) && state.value() < 8 {
            case.fail(format!("expected at least 8; got {}", state.value()), "got invalid value");
        }
    });
}

/// `RboStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("rbo");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("renderbuffer_size", renderbuffer_size),
        ("renderbuffer_internal_format", renderbuffer_internal_format),
        ("renderbuffer_component_size_color", renderbuffer_component_size_color),
        ("renderbuffer_component_size_depth", renderbuffer_component_size_depth),
    ];
    add_api_cases(&mut group, cases);
    group
}
