// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFunctionalTests.cpp (FboTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Only `api` is ported - upstream's other `fbo` sub-groups (render, completeness,
// multisample) render and compare against a reference image.

pub mod fbo_api_tests;

use crate::glu::TestCaseGroup;

/// `FboTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fbo");
    group.add_child(fbo_api_tests::create_tests());
    group
}
