// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDefaultVertexArrayObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, the same shape
// `gles3::functional::default_vertex_array_object_tests` already uses for its own,
// textually near-identical case (upstream's `!isContextTypeES` guard in `init` is
// always false in this ES-only port and is not ported, per that file's own precedent).

use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw;

/// `VertexAttributeDivisorCase::iterate`
fn vertex_attrib_divisor(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    // SAFETY: the default VAO is always a legal binding.
    unsafe { gl.bind_vertex_array(0) };

    // Using vertexAttribDivisor with default vao is not an error in ES 3.1.
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 3) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `DefaultVertexArrayObjectTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("default_vertex_array_object");
    let cases: &[(&'static str, ApiCaseFn)] = &[("vertex_attrib_divisor", vertex_attrib_divisor)];
    add_api_cases(&mut group, cases);
    group
}
