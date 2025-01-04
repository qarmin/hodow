// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shader_interlock/vktFragmentShaderInterlockTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod basic_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `fragment_shader_interlock` group (VK_EXT_fragment_shader_interlock).
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragment_shader_interlock");
    group.add_child(basic_tests::create_basic_tests());
    group
}
