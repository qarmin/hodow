// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory_model/vktMemoryModelMessagePassing.cpp (createTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018-2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported so far: `message_passing` (with its Amber `permuted_index` group, converted by
// scripts/gen_spirv_assembly_amber_manifest.py), `write_after_read`, `transitive`, `padding` and `shared` (its random layouts replayed by scripts/gen_memory_model_shared_layout.py).

pub mod message_passing_tests;
pub mod padding_tests;
pub mod shared_layout_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `dEQP-VK.memory_model` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("memory_model");
    for child in message_passing_tests::create_message_passing_tests() {
        group.add_child(child);
    }
    group.add_child(padding_tests::create_padding_tests());
    group.add_child(shared_layout_tests::create_shared_layout_tests());
    group
}
