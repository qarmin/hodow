// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFunctionalTests.cpp (StateQueryTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's thirteen sub-groups, in its order: boolean, integer, indexed, texture,
// texture_level, sampler, shader, internal_format, vertex_attribute_binding,
// multisample_interpolation, framebuffer_default, program, program_pipeline. All
// thirteen are ported.

pub mod boolean_state_query_tests;
pub mod framebuffer_default_state_query_tests;
pub mod indexed_state_query_tests;
pub mod integer_state_query_tests;
pub mod internal_format_query_tests;
pub mod program_pipeline_state_query_tests;
pub mod program_state_query_tests;
pub mod sampler_state_query_tests;
pub mod shader_multisample_interpolation_state_query_tests;
pub mod shader_state_query_tests;
pub mod texture_level_state_query_tests;
pub mod texture_state_query_tests;
pub mod vertex_attribute_binding_state_query_tests;

use crate::glu::TestCaseGroup;

/// `StateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");
    group.add_child(boolean_state_query_tests::create_tests());
    group.add_child(integer_state_query_tests::create_tests());
    group.add_child(indexed_state_query_tests::create_tests());
    group.add_child(texture_state_query_tests::create_tests());
    group.add_child(texture_level_state_query_tests::create_tests());
    group.add_child(sampler_state_query_tests::create_tests());
    group.add_child(shader_state_query_tests::create_tests());
    group.add_child(internal_format_query_tests::create_tests());
    group.add_child(vertex_attribute_binding_state_query_tests::create_tests());
    group.add_child(shader_multisample_interpolation_state_query_tests::create_tests());
    group.add_child(framebuffer_default_state_query_tests::create_tests());
    group.add_child(program_state_query_tests::create_tests());
    group.add_child(program_pipeline_state_query_tests::create_tests());
    group
}
