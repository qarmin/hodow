// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingModelTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod shader_access_tests;

use crate::vkt::TestCaseGroup;

/// `createBindingModelTests`.
///
/// Only the sub-groups that are actually ported are registered; the rest are absent
/// rather than present-and-skipped, so a comparison against `deqp-vk` reports them as
/// missing instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("binding_model");
    tests.add_child(shader_access_tests::create_shader_access_tests());
    tests
}
