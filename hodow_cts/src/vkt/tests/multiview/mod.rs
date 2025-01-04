// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod render_tests;

use crate::vkt::TestCaseGroup;

/// `createMultiViewTests` - the `multiview` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multiview");
    render_tests::multi_view_render_create_tests(&mut group);
    group
}
