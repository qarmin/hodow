// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `draw`, `dispatch`, `clear_attachments`, `transform_feedback` and `draw_clear` (without its `_device_address` cases)
// and `conditional_ignore` (without `bind_shaders`) are ported.

pub mod clear_attachments_tests;
pub mod dispatch_tests;
pub mod draw_and_clear_tests;
pub mod draw_tests;
pub mod ignore_tests;
pub mod test_util;
pub mod transform_feedback_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `conditional_rendering` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("conditional_rendering");
    group.add_child(draw_tests::create_conditional_draw_tests());
    group.add_child(dispatch_tests::create_conditional_dispatch_tests());
    group.add_child(clear_attachments_tests::create_conditional_clear_attachment_tests());
    group.add_child(draw_and_clear_tests::create_conditional_draw_and_clear_tests());
    group.add_child(ignore_tests::create_conditional_ignore_tests());
    group.add_child(transform_feedback_tests::create_conditional_transform_feedback_tests());
    group
}
