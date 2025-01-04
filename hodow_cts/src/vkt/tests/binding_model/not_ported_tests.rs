// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorHeapTests.cpp
//   external/vulkancts/modules/vulkan/binding_model/vktBindingPushConstantBankTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written for hodow_cts. The `descriptor_heap` (VK_EXT_descriptor_heap) and `push_constant_bank` (VK_NV_push_constant_bank) case trees are
// registered from the mustpass names of the pinned revision (`not_ported_cases/*.txt`), gated on the extension upstream's first support check requires:
// NotSupported without it, NotPorted with it. The bodies are not ported.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::{build_gated_groups, build_gated_groups_with};

const DESCRIPTOR_HEAP: &str = include_str!("not_ported_cases/descriptor_heap.txt");
const PUSH_CONSTANT_BANK: &str = include_str!("not_ported_cases/push_constant_bank.txt");

fn single_group(names: &str, extensions: &'static [&'static str], what: &'static str) -> TestCaseGroup {
    build_gated_groups(names, extensions, what)
        .into_iter()
        .next()
        .expect("the case list names one group")
}

/// `binding_model.descriptor_heap`
pub fn create_descriptor_heap_group() -> TestCaseGroup {
    single_group(
        DESCRIPTOR_HEAP,
        &["VK_EXT_descriptor_heap"],
        "the descriptor heap tests",
    )
}

/// `binding_model.push_constant_bank`
pub fn create_push_constant_bank_group() -> TestCaseGroup {
    let mut ported = super::push_constant_bank_tests::create_basic_cases();
    build_gated_groups_with(
        PUSH_CONSTANT_BANK,
        &["VK_NV_push_constant_bank"],
        "the push constant bank tests",
        &mut |path| ported.remove(path),
    )
    .into_iter()
    .next()
    .expect("the case list names one group")
}
