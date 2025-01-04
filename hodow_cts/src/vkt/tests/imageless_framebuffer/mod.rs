// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/imageless_framebuffer/vktImagelessFramebufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod imageless_framebuffer_tests;

use crate::vkt::TestCaseGroup;

/// `imageless::createTests` - the `imageless_framebuffer` group.
pub fn create_tests() -> TestCaseGroup {
    imageless_framebuffer_tests::create_tests("imageless_framebuffer")
}
