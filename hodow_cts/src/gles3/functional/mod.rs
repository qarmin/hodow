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

pub mod buffer;
pub mod color_clear_test;
pub mod default_vertex_array_object_tests;
pub mod depth_stencil_clear_tests;
pub mod fbo;
pub mod implementation_limit_tests;
pub mod negative_api;
pub mod occlusion_query_tests;
pub mod prerequisite_tests;
pub mod primitive_restart_tests;
pub mod rasterizer_discard_tests;
pub mod shader_api_tests;
pub mod state_query;
pub mod sync_tests;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported and keeping their
/// relative order from upstream.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(prerequisite_tests::create_tests());
    group.add_child(implementation_limit_tests::create_tests());
    group.add_child(color_clear_test::create_tests());
    group.add_child(depth_stencil_clear_tests::create_tests());
    group.add_child(buffer::create_tests());
    group.add_child(fbo::create_tests());
    group.add_child(occlusion_query_tests::create_tests());
    group.add_child(primitive_restart_tests::create_tests());
    group.add_child(rasterizer_discard_tests::create_tests());
    group.add_child(sync_tests::create_tests());
    group.add_child(shader_api_tests::create_tests());
    group.add_child(negative_api::create_tests());
    group.add_child(state_query::create_tests());
    group.add_child(default_vertex_array_object_tests::create_tests());
    group
}
