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
// Upstream's three sub-groups, in its order: api, render, completeness.

pub mod completeness_tests;
pub mod fbo_api_tests;
pub mod render_tests;

use crate::glu::TestCaseGroup;

/// `FboTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fbo");
    group.add_child(fbo_api_tests::create_tests());
    group.add_child(render_tests::create_tests());
    group.add_child(completeness_tests::create_tests());
    group
}
