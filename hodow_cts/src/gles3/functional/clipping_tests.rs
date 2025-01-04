// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fClippingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ES 2.0 and ES 3.0 files differ only in the
// shader dialect and one distance constant, so the port lives in `gls::clipping_tests`.

use crate::gls::clipping_tests::{self, ClippingGlslVersion};
use crate::glu::TestCaseGroup;

/// `ClippingTests::init`
pub fn create_tests() -> TestCaseGroup {
    clipping_tests::create_tests(ClippingGlslVersion::Es300)
}
