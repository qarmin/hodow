// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod color_clear_test;
pub mod depth_stencil_clear_tests;
pub mod negative_api;
pub mod prerequisite_tests;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported and keeping their
/// relative order from upstream.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(prerequisite_tests::create_tests());
    group.add_child(color_clear_test::create_tests());
    group.add_child(depth_stencil_clear_tests::create_tests());
    group.add_child(negative_api::create_tests());
    group
}
