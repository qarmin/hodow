// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The tests need VK_ARM_tensors. The case tree is registered from the mustpass names; the cases of the files below
// (`ported`) are real, and the rest stay gated: upstream's first
// support check (`ctx.requireDeviceFunctionality("VK_ARM_tensors")`), so a device without the extension ends in NotSupported exactly as under deqp-vk and one with
// it in NotPorted. The names are the mustpass list of the pinned revision (`scripts/gen_tensor_cases.py` writes `cases.txt`).

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups_with;

pub mod array_access_tests;
pub mod basic_access_tests;
pub mod boolean_tests;
mod copies_tests;
mod create_requirements_tests;
pub mod descriptors_array_tests;
pub mod dimension_query_tests;
pub mod graphics_pipeline_tests;
pub mod image_aliasing_tests;
mod required_formats_tests;
mod required_tests;
pub mod robustness_tests;
mod tensor_util;
mod update_after_bind_tests;

const CASE_NAMES: &str = include_str!("cases.txt");

/// `tensor::createTests` - the `tensor` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tensor");
    let mut ported = copies_tests::create_tensor_copy_cases();
    ported.extend(dimension_query_tests::create_dimension_query_cases());
    ported.extend(boolean_tests::create_boolean_cases());
    ported.extend(array_access_tests::create_array_access_cases());
    ported.extend(basic_access_tests::create_basic_access_cases());
    ported.extend(robustness_tests::create_robustness_cases());
    ported.extend(image_aliasing_tests::create_image_aliasing_cases());
    ported.extend(update_after_bind_tests::create_update_after_bind_cases());
    ported.extend(descriptors_array_tests::create_descriptors_array_cases());
    ported.extend(graphics_pipeline_tests::create_graphics_pipeline_cases());
    for child in build_gated_groups_with(
        CASE_NAMES,
        &["VK_ARM_tensors"],
        "the VK_ARM_tensors tests",
        &mut |path| ported.remove(path),
    ) {
        group.add_child(child);
    }
    group.add_child(required_tests::create_tensor_required());
    group.add_child(required_formats_tests::create_tensor_required_formats_tests());
    group.add_child(create_requirements_tests::create_tensor_create_requirements_tests());
    group
}
