// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp (StateQueryTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's thirteen sub-groups, in its order: boolean, integer, integer64, float,
// indexed, texture, string, sampler, buffer_object, fbo, rbo, shader,
// internal_format. `texture` and `sampler` are thin wrappers over
// glsTextureStateQueryTests / glsSamplerObjectTest, neither of which is ported, so
// they are left out.

pub mod boolean_state_query_tests;
pub mod buffer_object_query_tests;
pub mod fbo_state_query_tests;
pub mod float_state_query_tests;
pub mod indexed_state_query_tests;
pub mod integer64_state_query_tests;
pub mod integer_state_query_tests;
pub mod internal_format_query_tests;
pub mod rbo_state_query_tests;
pub mod sampler_state_query_tests;
pub mod shader_state_query_tests;
pub mod string_query_tests;
pub mod texture_state_query_tests;

use crate::glu::TestCaseGroup;

/// `StateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");
    group.add_child(boolean_state_query_tests::create_tests());
    group.add_child(integer_state_query_tests::create_tests());
    group.add_child(string_query_tests::create_tests());
    group.add_child(buffer_object_query_tests::create_tests());
    group.add_child(integer64_state_query_tests::create_tests());
    group.add_child(float_state_query_tests::create_tests());
    group.add_child(indexed_state_query_tests::create_tests());
    group.add_child(fbo_state_query_tests::create_tests());
    group.add_child(rbo_state_query_tests::create_tests());
    group.add_child(shader_state_query_tests::create_tests());
    group.add_child(internal_format_query_tests::create_tests());
    group.add_child(texture_state_query_tests::create_tests());
    group.add_child(sampler_state_query_tests::create_tests());
    group
}
