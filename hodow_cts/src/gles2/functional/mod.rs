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
pub mod fbo;
pub mod implementation_limit_tests;
pub mod light_amount_test;
pub mod multisampled_render_to_texture_tests;
pub mod negative_api;
pub mod shader_api_tests;
pub mod prerequisite_tests;
pub mod shader_frag_data_tests;
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
    group.add_child(create_shaders_tests());
    group.add_child(fbo::create_tests());
    group.add_child(shader_api_tests::create_tests());
    group.add_child(negative_api::create_tests());
    group.add_child(state_query::create_tests());
    group
}

/// `ShadersTestGroup::init`, restricted to the sub-groups that are ported. The rest of
/// its 29 children are the `gls::ShaderLibrary`-driven ones (`preprocessor`,
/// `constants`, ...) and the `gls::ShaderRenderCase`-driven ones (`indexing`, `loops`,
/// `operator`, ...); neither framework is ported yet.
fn create_shaders_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shaders");
    group.add_child(shader_frag_data_tests::create_tests());
    group
}
