// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image_processing/vktImageProcessingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only `api` is ported. `graphics` and `compute` (block matching, box filter sampling, weight image
// sampling over VK_QCOM_image_processing) are registered with upstream's `ImageProcessingTestInstance` support check (VK_QCOM_image_processing required)
// and no body: NotSupported on every device without the extension, NotPorted on one with it. The names are the mustpass list of the pinned revision
// (`scripts/gen_image_processing_cases.py` writes `cases.txt`).

pub mod api_tests;
pub mod test_util;

use crate::vkt::TestCaseGroup;

const CASE_NAMES: &str = include_str!("cases.txt");

/// `createTests` - the `image_processing` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("image_processing");
    group.add_child(api_tests::create_image_processing_api_tests());
    for child in crate::vkt::gated::build_gated_groups(
        CASE_NAMES,
        &["VK_QCOM_image_processing"],
        "the VK_QCOM_image_processing shaders",
    ) {
        group.add_child(child);
    }
    group
}
