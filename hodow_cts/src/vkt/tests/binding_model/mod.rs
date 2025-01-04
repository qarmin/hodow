// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingModelTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod buffer_device_address_tests;
pub mod descriptor_combination_tests;
pub mod descriptor_copy_table;
pub mod descriptor_copy_tests;
pub mod descriptor_update_as_tests;
pub mod descriptor_update_tests;
pub mod descriptorset_random_tests;
pub mod dynamic_offset_tests;
pub mod heap_random_programs;
pub mod heap_random_tests;
pub mod image_array_maintenance11_tests;
pub mod image_atomic_tests;
pub mod inline_uniform_tests;
pub mod mutable_programs;
pub mod mutable_tests;
pub mod not_ported_tests;
pub mod push_constant_bank_tests;
pub mod shader_access_tests;
pub mod stages_tests;
pub mod unused_invalid_descriptor_tests;

use crate::vkt::TestCaseGroup;

/// `createBindingModelTests`.
///
/// Only the sub-groups that are actually ported are registered; the rest are absent
/// rather than present-and-skipped, so a comparison against `deqp-vk` reports them as
/// missing instead of as passing.
pub fn create_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("binding_model");
    tests.add_child(shader_access_tests::create_shader_access_tests());
    tests.add_child(descriptor_combination_tests::create_descriptor_combination_tests());
    tests.add_child(descriptor_update_tests::create_descriptor_update_tests());
    tests.add_child(dynamic_offset_tests::create_dynamic_offset_tests());
    tests.add_child(image_atomic_tests::create_image_atomic_tests());
    tests.add_child(inline_uniform_tests::create_descriptor_inline_uniform_tests());
    tests.add_child(stages_tests::create_stages_tests());
    tests.add_child(unused_invalid_descriptor_tests::create_unused_invalid_descriptor_tests());
    tests.add_child(image_array_maintenance11_tests::create_image_array_maintenance11_tests());
    tests.add_child(buffer_device_address_tests::create_buffer_device_address_tests());
    tests.add_child(mutable_tests::create_descriptor_mutable_tests());
    tests.add_child(descriptor_copy_tests::create_descriptor_copy_tests());
    tests.add_child(descriptorset_random_tests::create_descriptorset_random_tests());
    tests.add_child(heap_random_tests::create_descriptor_heap_random_tests());
    tests.add_child(not_ported_tests::create_descriptor_heap_group());
    tests.add_child(not_ported_tests::create_push_constant_bank_group());
    tests
}
