// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/descriptor_indexing/vktDescriptorIndexingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `misc_*` cases and `non_uniform_atomics` of vktDescriptorSetsIndexingTests.cpp's
// `descriptorIndexingDescriptorSetsCreateTests` are ported; its large indexing matrix is not.

pub mod misc_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `dEQP-VK.descriptor_indexing` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("descriptor_indexing");
    misc_tests::create_descriptor_indexing_misc_tests(&mut group);
    group
}
