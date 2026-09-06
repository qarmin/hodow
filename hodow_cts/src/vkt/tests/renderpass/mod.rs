// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod depth_stencil_resolve_tests;
pub mod multisample_resolve_tests;
pub mod render_pass_tests;
pub mod unused_attachment_tests;
pub mod unused_clear_attachment_tests;

use crate::tcu::TestCaseGroup;

/// `createRenderPassTests`.
///
/// Only the sub-groups that are actually ported are registered; the rest are absent
/// rather than present-and-skipped, so a comparison against `deqp-vk` reports them as
/// missing instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("renderpasses");
    for mut group in render_pass_tests::create_render_pass_groups() {
        // `depth_stencil_resolve` is a renderpass2 test: it needs the resolve mode
        // fields that only VkSubpassDescription2 carries.
        if group.name() == "renderpass2" {
            group.add_child(depth_stencil_resolve_tests::create_tests());
        }
        tests.add_child(group);
    }
    tests
}
