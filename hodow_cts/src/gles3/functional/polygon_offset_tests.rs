// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fPolygonOffsetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ES 2.0 and ES 3.0 files differ only in
// the shader dialect and the depth-buffer list, so the port lives in `gls::polygon_offset_tests`.

use crate::gls::polygon_offset_tests::{self, GlslVersion};
use crate::glu::TestCaseGroup;

/// `PolygonOffsetTests::init`
pub fn create_tests() -> TestCaseGroup {
    polygon_offset_tests::create_tests(GlslVersion::Es300)
}
