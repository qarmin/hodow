// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_barycentric/vktFragmentShadingBarycentricTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Advanced Micro Devices, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `data` and `weights` groups are registered for the monolithic construction type
// directly under the root and again, as upstream does, in a `pipeline_library` and a `fast_linked_library` group whose pipelines
// are linked from graphics pipeline libraries (`vk::pipeline_construction`).

pub mod data_tests;
pub mod util;
pub mod weight_tests;

use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::TestCaseGroup;

/// `createTests` - the `fragment_shading_barycentric` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragment_shading_barycentric");
    group.add_child(data_tests::create_data_tests(PipelineConstructionType::Monolithic));
    group.add_child(weight_tests::create_weight_tests(PipelineConstructionType::Monolithic));

    for construction in [
        PipelineConstructionType::LinkTimeOptimizedLibrary,
        PipelineConstructionType::FastLinkedLibrary,
    ] {
        let mut library_group = TestCaseGroup::new(construction.group_name());
        library_group.add_child(data_tests::create_data_tests(construction));
        library_group.add_child(weight_tests::create_weight_tests(construction));
        group.add_child(library_group);
    }
    group
}
