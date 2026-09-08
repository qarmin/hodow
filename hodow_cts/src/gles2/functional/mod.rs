// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod buffer_test_util;
pub mod buffer_write_tests;
pub mod clip_control_tests;
pub mod color_clear_test;
pub mod depth_stencil_clear_tests;
pub mod implementation_limit_tests;
pub mod light_amount_test;
pub mod multisampled_render_to_texture_tests;
pub mod negative_api;
pub mod prerequisite_tests;
pub mod state_query;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported and keeping their
/// relative order from upstream.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(prerequisite_tests::create_tests());
    group.add_child(implementation_limit_tests::create_tests());
    group.add_child(clip_control_tests::create_tests());
    group.add_child(color_clear_test::create_tests());
    group.add_child(depth_stencil_clear_tests::create_tests());
    group.add_child(buffer_write_tests::create_tests());
    group.add_child(light_amount_test::create_tests());
    group.add_child(multisampled_render_to_texture_tests::create_tests());
    group.add_child(negative_api::create_tests());
    group.add_child(state_query::create_tests());
    group
}
