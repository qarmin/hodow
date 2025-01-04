// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDrawTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ES 2.0 and ES 3.0 files share one port in
// `gls::draw_tests`, which picks the per-API tables.

use crate::gls::draw_tests::{self, DrawApi};
use crate::glu::TestCaseGroup;

/// `DrawTests::init`
pub fn create_tests() -> TestCaseGroup {
    draw_tests::create_tests(DrawApi::Es2)
}
