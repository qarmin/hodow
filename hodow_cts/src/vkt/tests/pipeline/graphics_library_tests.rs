// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineLibraryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case tree is registered, gated on VK_EXT_graphics_pipeline_library (NotSupported without it,
// NotPorted with it); the names are the mustpass list of the pinned revision (pipeline_library construction type only).

use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const PIPELINE_LIBRARY_CASES: &str = include_str!("graphics_library_cases/pipeline_library.txt");

/// `createPipelineLibraryTests` (graphics_library), names only; None for construction types the mustpass has no such group for.
pub fn create_graphics_library_tests(construction: PipelineConstructionType) -> Option<TestCaseGroup> {
    if construction != PipelineConstructionType::LinkTimeOptimizedLibrary {
        return None;
    }
    let mut group = TestCaseGroup::new("graphics_library");
    for child in build_gated_groups(
        PIPELINE_LIBRARY_CASES,
        &["VK_EXT_graphics_pipeline_library"],
        "the graphics pipeline library tests",
    ) {
        group.add_child(child);
    }
    Some(group)
}
