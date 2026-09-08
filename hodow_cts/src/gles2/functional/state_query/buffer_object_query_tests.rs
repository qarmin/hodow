// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fBufferObjectQueryTests.cpp
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

/// `GetBufferParameterIVerifier` - the only verifier ES 2.0 has for these.
fn verify_integer(case: &mut ApiCase<'_>, target: GLenum, name: GLenum, reference: i32) {
    let gl = case.gl();
    let mut state = Guarded::<i32>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe { gl.get_buffer_parameteriv(target, name, state.as_mut_ptr()) };
    if !state.verify_validity(case) {
        return;
    }
    if state.value() != reference {
        case.fail(format!("expected {reference}; got {}", state.value()), "Got invalid value");
    }
}

/// `BufferCase::test` - every case runs against both buffer targets in turn, each
/// with its own buffer.
fn for_each_buffer_target(case: &mut ApiCase<'_>, mut body: impl FnMut(&mut ApiCase<'_>, GLenum)) {
    for target in [glw::GL_ARRAY_BUFFER, glw::GL_ELEMENT_ARRAY_BUFFER] {
        let gl = case.gl();
        let mut buffer = 0;
        // SAFETY: the name is this case's own and is deleted below.
        unsafe {
            gl.gen_buffers(1, &mut buffer);
            gl.bind_buffer(target, buffer);
        }
        case.expect_error(glw::GL_NO_ERROR);

        body(case, target);

        // SAFETY: as above.
        unsafe { gl.delete_buffers(1, &buffer) };
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `BufferSizeCase`
fn buffer_size(case: &mut ApiCase<'_>) {
    for_each_buffer_target(case, |case, target| {
        let gl = case.gl();
        let mut rnd = Random::new(0x00ab_cdef);

        verify_integer(case, target, glw::GL_BUFFER_SIZE, 0);

        for _ in 0..16 {
            let len = rnd.get_int(0, 1024);
            // SAFETY: a null data pointer with a non-negative size only allocates.
            unsafe { gl.buffer_data(target, len as isize, std::ptr::null(), glw::GL_STREAM_DRAW) };
            case.expect_error(glw::GL_NO_ERROR);
            verify_integer(case, target, glw::GL_BUFFER_SIZE, len);
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `BufferUsageCase`
fn buffer_usage(case: &mut ApiCase<'_>) {
    for_each_buffer_target(case, |case, target| {
        let gl = case.gl();

        verify_integer(case, target, glw::GL_BUFFER_USAGE, glw::GL_STATIC_DRAW as i32);

        for usage in [glw::GL_STATIC_DRAW, glw::GL_DYNAMIC_DRAW, glw::GL_STREAM_DRAW] {
            // SAFETY: as above.
            unsafe { gl.buffer_data(target, 16, std::ptr::null(), usage) };
            case.expect_error(glw::GL_NO_ERROR);
            verify_integer(case, target, glw::GL_BUFFER_USAGE, usage as i32);
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `BufferObjectQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer_object");
    let cases: &[(&'static str, ApiCaseFn)] = &[("buffer_size_getbufferparameteri", buffer_size), ("buffer_usage_getbufferparameteri", buffer_usage)];
    add_api_cases(&mut group, cases);
    group
}
