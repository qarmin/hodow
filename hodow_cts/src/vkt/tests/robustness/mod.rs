// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Children are registered in upstream order as they are ported:
// `buffer_access`, `vertex_access`, `index_access`, `non_robust_buffer_access`, `bind_index_buffer2`, `robustness1_vertex_access`, `oob_access` (without the Amber `misc` group), `robustness2`, `image_robustness`, `pipeline_robustness` (vktRobustnessExtsTests.cpp).

pub mod buffer_access_tests;
pub mod exts_instance;
pub mod exts_programs;
pub mod exts_stride_tests;
pub mod exts_tests;
pub mod index_access_tests;
pub mod non_robust_buffer_access_tests;
pub mod oob_access_tests;
pub mod robustness1_vertex_access_tests;
pub mod robustness_util;
pub mod variable_pointers_programs;
pub mod variable_pointers_tests;
pub mod vertex_access_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` (`robustness`)
pub fn create_tests() -> TestCaseGroup {
    let mut robustness_tests = TestCaseGroup::new("robustness");
    let mut buffer_access = buffer_access_tests::create_buffer_access_tests();
    buffer_access.add_child(variable_pointers_tests::create_buffer_access_with_variable_pointers_tests());
    robustness_tests.add_child(buffer_access);
    robustness_tests.add_child(vertex_access_tests::create_vertex_access_tests());
    robustness_tests.add_child(index_access_tests::create_index_access_tests());
    robustness_tests.add_child(non_robust_buffer_access_tests::create_non_robust_buffer_access_tests());
    robustness_tests.add_child(index_access_tests::create_cmd_bind_index_buffer2_tests());
    robustness_tests.add_child(robustness1_vertex_access_tests::create_robustness1_vertex_access_tests());
    robustness_tests.add_child(oob_access_tests::create_oob_access_tests());
    robustness_tests.add_child(exts_tests::create_robustness2_tests());
    robustness_tests.add_child(exts_tests::create_image_robustness_tests());
    robustness_tests.add_child(exts_tests::create_pipeline_robustness_tests());
    robustness_tests.add_child(buffer_access_tests::create_pipeline_robustness_buffer_access_tests());
    robustness_tests.add_child(buffer_access_tests::create_descriptor_heap_buffer_access_tests());
    robustness_tests.add_child(buffer_access_tests::create_pipeline_robustness_heap_buffer_access_tests());
    robustness_tests
}
