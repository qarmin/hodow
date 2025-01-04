// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderInvarianceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The ES 3.0 file is the ES 2.0 file with a different `#version`, `in`/`out` instead of
// `attribute`/`varying` and a declared fragment output instead of `gl_FragColor`; every
// shader template and the whole case class are byte-identical. See
// `gles2::functional::shader_invariance_tests` for the port and for why it holds both.

use crate::gles2::functional::shader_invariance_tests;
use crate::glu::TestCaseGroup;

/// `ShaderInvarianceTests::init`
pub fn create_tests() -> TestCaseGroup {
    shader_invariance_tests::create_tests(shader_invariance_tests::ES3)
}
