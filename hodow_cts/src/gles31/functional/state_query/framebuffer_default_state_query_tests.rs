// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFramebufferDefaultStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::{QueryType, verify_state_framebuffer_integer, verify_state_framebuffer_integer_min};
use crate::glu::{ApiCase, Framebuffer, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};

/// `getVerifierSuffix` - this file's only verifier, and it does not use the shared
/// `getinteger`-style postfix.
const VERIFIER_SUFFIX: &str = "get_framebuffer_parameteriv";
const VERIFIER: QueryType = QueryType::FramebufferInteger;

/// `FramebufferTest::iterate` - `body` is the `checkInitial` + `checkSet` pair.
fn framebuffer_test(case: &mut ApiCase<'_>, body: impl FnOnce(&mut ApiCase<'_>)) {
    let fbo = Framebuffer::new(case.gl());
    // SAFETY: a framebuffer name this case owns for the whole body.
    unsafe { case.gl().bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get()) };
    case.expect_no_error("bind");

    body(case);
}

/// `FramebufferDimensionTest`
fn framebuffer_dimension(case: &mut ApiCase<'_>, pname: GLenum) {
    framebuffer_test(case, |case| {
        case.section("Initial");
        verify_state_framebuffer_integer(case, glw::GL_DRAW_FRAMEBUFFER, pname, 0, VERIFIER);

        case.section("Set");
        // SAFETY: a parameter the query above already accepted.
        unsafe { case.gl().framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, pname, 32) };
        case.expect_no_error("set state");
        verify_state_framebuffer_integer(case, glw::GL_DRAW_FRAMEBUFFER, pname, 32, VERIFIER);
    });
}

/// `FramebufferSamplesTest`
fn framebuffer_samples(case: &mut ApiCase<'_>) {
    framebuffer_test(case, |case| {
        case.section("Initial");
        verify_state_framebuffer_integer(
            case,
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES,
            0,
            VERIFIER,
        );

        case.section("Set");
        // SAFETY: a sample count the implementation is required to accept.
        unsafe {
            case.gl()
                .framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES, 1)
        };
        case.expect_no_error("set state");
        verify_state_framebuffer_integer_min(
            case,
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES,
            1,
            VERIFIER,
        );

        // SAFETY: as above.
        unsafe {
            case.gl()
                .framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES, 0)
        };
        case.expect_no_error("set state");
        verify_state_framebuffer_integer(
            case,
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES,
            0,
            VERIFIER,
        );
    });
}

/// `FramebufferFixedSampleLocationsTest`
fn framebuffer_fixed_sample_locations(case: &mut ApiCase<'_>) {
    framebuffer_test(case, |case| {
        case.section("Initial");
        verify_state_framebuffer_integer(
            case,
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS,
            0,
            VERIFIER,
        );

        case.section("Set");
        // SAFETY: GL_TRUE is the only other legal value here.
        unsafe {
            case.gl().framebuffer_parameteri(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS,
                glw::GL_TRUE as i32,
            )
        };
        case.expect_no_error("set state");
        verify_state_framebuffer_integer(
            case,
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS,
            glw::GL_TRUE as i32,
            VERIFIER,
        );
    });
}

/// `FramebufferDefaultStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("framebuffer_default");

    add_api_case(
        &mut group,
        format!("framebuffer_default_width_{VERIFIER_SUFFIX}"),
        |case: &mut ApiCase<'_>| {
            framebuffer_dimension(case, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH);
        },
    );
    add_api_case(
        &mut group,
        format!("framebuffer_default_height_{VERIFIER_SUFFIX}"),
        |case: &mut ApiCase<'_>| {
            framebuffer_dimension(case, glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT);
        },
    );
    add_api_case(
        &mut group,
        format!("framebuffer_default_samples_{VERIFIER_SUFFIX}"),
        framebuffer_samples,
    );
    add_api_case(
        &mut group,
        format!("framebuffer_default_fixed_sample_locations_{VERIFIER_SUFFIX}"),
        framebuffer_fixed_sample_locations,
    );

    group
}
