// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineShaderModuleIdentifierTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case tree is registered, gated on VK_EXT_shader_module_identifier (NotSupported without it,
// NotPorted with it); the names are the mustpass lists of the pinned revision, one file per construction type in `shader_module_identifier_cases/`.

use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const MONOLITHIC_CASES: &str = include_str!("shader_module_identifier_cases/monolithic.txt");
const PIPELINE_LIBRARY_CASES: &str = include_str!("shader_module_identifier_cases/pipeline_library.txt");
const FAST_LINKED_LIBRARY_CASES: &str = include_str!("shader_module_identifier_cases/fast_linked_library.txt");

/// `createShaderModuleIdentifierTests`, names only; None for the construction types the mustpass has no such group for.
pub fn create_shader_module_identifier_tests(construction: PipelineConstructionType) -> Option<TestCaseGroup> {
    let names = match construction {
        PipelineConstructionType::Monolithic => MONOLITHIC_CASES,
        PipelineConstructionType::LinkTimeOptimizedLibrary => PIPELINE_LIBRARY_CASES,
        PipelineConstructionType::FastLinkedLibrary => FAST_LINKED_LIBRARY_CASES,
        _ => return None,
    };
    let mut group = TestCaseGroup::new("shader_module_identifier");
    for child in build_gated_groups(
        names,
        &["VK_EXT_shader_module_identifier"],
        "the shader module identifier tests",
    ) {
        group.add_child(child);
    }
    Some(group)
}
