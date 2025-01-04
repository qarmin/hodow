// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktTestPackage.cpp (`depth`, registered with `cts_amber::createAmberDepthGroup`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The eight Amber scripts of `data/vulkan/amber/depth` are `depth_clamp_tests.rs`.

pub mod depth_clamp_tests;

use crate::vkt::TestCaseGroup;

/// The `depth` group.
pub fn create_tests() -> TestCaseGroup {
    depth_clamp_tests::create_depth_clamp_tests()
}
