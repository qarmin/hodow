// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDepthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ES 2.0 and ES 3.0 files differ only in
// the shader dialect, so the port lives in `gls::depth_tests`.

use crate::gls::depth_tests;
use crate::gls::fragment_op_util::QuadRendererGlslVersion;
use crate::glu::TestCaseGroup;

/// `DepthTests::init`
pub fn create_tests() -> TestCaseGroup {
    depth_tests::create_tests(QuadRendererGlslVersion::Es100)
}
