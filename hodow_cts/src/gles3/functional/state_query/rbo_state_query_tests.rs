// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fRboStateQueryTests.cpp
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
        // SAFETY: one GLint out, guarded on both sides; a renderbuffer is bound.
        unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, pname, state.as_mut_ptr()) };
        if !state.verify_validity(case) {
            return;
        }
        // A driver may give more bits than asked for, never fewer.
        if state.value() < reference {
            case.fail(
                format!("expected greater or equal to {reference}; got {}", state.value()),
                "got invalid value",
            );
        }
    }
}

/// `checkRenderbufferParam`
fn check_renderbuffer_param(case: &mut ApiCase<'_>, pname: GLenum, reference: i32) {
    let gl = case.gl();
    let mut state = Guarded::<i32>::new();
    // SAFETY: as in `check_renderbuffer_component_size`.
    unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, pname, state.as_mut_ptr()) };
    if state.verify_validity(case) {
        let got = state.value();
        case.check_int_equals(got, reference);
    }
}

/// `checkRenderbufferParamGreaterOrEqual`
fn check_renderbuffer_param_greater_or_equal(case: &mut ApiCase<'_>, pname: GLenum, reference: i32) {
    let gl = case.gl();
    let mut state = Guarded::<i32>::new();
    // SAFETY: as above.
    unsafe { gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, pname, state.as_mut_ptr()) };
    if state.verify_validity(case) && state.value() < reference {
        case.fail(
            format!("expected greater or equal to {reference}; got {}", state.value()),
            "got invalid value",
        );
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

        for _ in 0..60 {
            let width = rnd.get_int(0, 128);
            let height = rnd.get_int(0, 128);
            // SAFETY: a legal internal format and non-negative extents.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGB8, width, height) };
            check_renderbuffer_param(case, glw::GL_RENDERBUFFER_WIDTH, width);
            check_renderbuffer_param(case, glw::GL_RENDERBUFFER_HEIGHT, height);
        }
    });
}

/// `RboInternalFormatCase`
fn renderbuffer_internal_format(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();

        // Upstream reads GL_RGBA for core GL 4.5; the ES-only port keeps GL_RGBA4.
        check_renderbuffer_param(case, glw::GL_RENDERBUFFER_INTERNAL_FORMAT, glw::GL_RGBA4 as i32);
        case.expect_error(glw::GL_NO_ERROR);

        const REQUIRED_COLOR_FORMATS: [GLenum; 28] = [
            glw::GL_R8,
            glw::GL_RG8,
            glw::GL_RGB8,
            glw::GL_RGB565,
            glw::GL_RGBA4,
            glw::GL_RGB5_A1,
            glw::GL_RGBA8,
            glw::GL_RGB10_A2,
            glw::GL_RGB10_A2UI,
            glw::GL_SRGB8_ALPHA8,
            glw::GL_R8I,
            glw::GL_R8UI,
            glw::GL_R16I,
            glw::GL_R16UI,
            glw::GL_R32I,
            glw::GL_R32UI,
            glw::GL_RG8I,
            glw::GL_RG8UI,
            glw::GL_RG16I,
            glw::GL_RG16UI,
            glw::GL_RG32I,
            glw::GL_RG32UI,
            glw::GL_RGBA8I,
            glw::GL_RGBA8UI,
            glw::GL_RGBA16I,
            glw::GL_RGBA16UI,
            glw::GL_RGBA32I,
            glw::GL_RGBA32UI,
        ];

        for format in REQUIRED_COLOR_FORMATS {
            // SAFETY: every format ES 3.0 requires renderbuffer support for.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 128, 128) };
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

        const REQUIRED_COLOR_FORMATS: [(GLenum, [i32; 4]); 28] = [
            (glw::GL_R8, [8, 0, 0, 0]),
            (glw::GL_RG8, [8, 8, 0, 0]),
            (glw::GL_RGB8, [8, 8, 8, 0]),
            (glw::GL_RGB565, [5, 6, 5, 0]),
            (glw::GL_RGBA4, [4, 4, 4, 4]),
            (glw::GL_RGB5_A1, [5, 5, 5, 1]),
            (glw::GL_RGBA8, [8, 8, 8, 8]),
            (glw::GL_RGB10_A2, [10, 10, 10, 2]),
            (glw::GL_RGB10_A2UI, [10, 10, 10, 2]),
            (glw::GL_SRGB8_ALPHA8, [8, 8, 8, 8]),
            (glw::GL_R8I, [8, 0, 0, 0]),
            (glw::GL_R8UI, [8, 0, 0, 0]),
            (glw::GL_R16I, [16, 0, 0, 0]),
            (glw::GL_R16UI, [16, 0, 0, 0]),
            (glw::GL_R32I, [32, 0, 0, 0]),
            (glw::GL_R32UI, [32, 0, 0, 0]),
            (glw::GL_RG8I, [8, 8, 0, 0]),
            (glw::GL_RG8UI, [8, 8, 0, 0]),
            (glw::GL_RG16I, [16, 16, 0, 0]),
            (glw::GL_RG16UI, [16, 16, 0, 0]),
            (glw::GL_RG32I, [32, 32, 0, 0]),
            (glw::GL_RG32UI, [32, 32, 0, 0]),
            (glw::GL_RGBA8I, [8, 8, 8, 8]),
            (glw::GL_RGBA8UI, [8, 8, 8, 8]),
            (glw::GL_RGBA16I, [16, 16, 16, 16]),
            (glw::GL_RGBA16UI, [16, 16, 16, 16]),
            (glw::GL_RGBA32I, [32, 32, 32, 32]),
            (glw::GL_RGBA32UI, [32, 32, 32, 32]),
        ];

        for (format, bits) in REQUIRED_COLOR_FORMATS {
            // SAFETY: as above.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 128, 128) };
            case.expect_error(glw::GL_NO_ERROR);
            check_renderbuffer_component_size(case, [bits[0], bits[1], bits[2], bits[3], -1, -1]);
        }
    });
}

/// `RboComponentSizeDepthCase`
fn renderbuffer_component_size_depth(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();

        const REQUIRED_DEPTH_FORMATS: [(GLenum, i32, i32); 5] = [
            (glw::GL_DEPTH_COMPONENT16, 16, 0),
            (glw::GL_DEPTH_COMPONENT24, 24, 0),
            (glw::GL_DEPTH_COMPONENT32F, 32, 0),
            (glw::GL_DEPTH24_STENCIL8, 24, 8),
            (glw::GL_DEPTH32F_STENCIL8, 32, 8),
        ];

        for (format, dbits, sbits) in REQUIRED_DEPTH_FORMATS {
            // SAFETY: every depth format ES 3.0 requires.
            unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, 128, 128) };
            case.expect_error(glw::GL_NO_ERROR);
            check_renderbuffer_component_size(case, [-1, -1, -1, -1, dbits, sbits]);
        }

        // STENCIL_INDEX8 is required, in that case sBits >= 8.
        // SAFETY: as above.
        unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8, 128, 128) };
        case.expect_error(glw::GL_NO_ERROR);

        let mut state = Guarded::<i32>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe {
            gl.get_renderbuffer_parameteriv(
                glw::GL_RENDERBUFFER,
                glw::GL_RENDERBUFFER_STENCIL_SIZE,
                state.as_mut_ptr(),
            )
        };
        if state.verify_validity(case) && state.value() < 8 {
            case.fail(
                format!("expected greater or equal to 8; got {}", state.value()),
                "got invalid value",
            );
        }
    });
}

/// `RboSamplesCase`
fn renderbuffer_samples(case: &mut ApiCase<'_>) {
    with_renderbuffer(case, |case| {
        let gl = case.gl();

        check_renderbuffer_param(case, glw::GL_RENDERBUFFER_SAMPLES, 0);
        case.expect_error(glw::GL_NO_ERROR);

        let mut max_samples = Guarded::<i32>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, max_samples.as_mut_ptr()) };
        if !max_samples.verify_validity(case) {
            return;
        }

        // 0 samples is a special case.
        // SAFETY: a legal sample count and internal format.
        unsafe { gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 0, glw::GL_RGBA8, 128, 128) };
        case.expect_error(glw::GL_NO_ERROR);
        check_renderbuffer_param(case, glw::GL_RENDERBUFFER_SAMPLES, 0);

        for samples in 1..=max_samples.value() {
            // SAFETY: as above, samples is within GL_MAX_SAMPLES.
            unsafe { gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, samples, glw::GL_RGBA8, 128, 128) };
            case.expect_error(glw::GL_NO_ERROR);
            check_renderbuffer_param_greater_or_equal(case, glw::GL_RENDERBUFFER_SAMPLES, samples);
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
        ("renderbuffer_samples", renderbuffer_samples),
    ];
    add_api_cases(&mut group, cases);
    group
}
