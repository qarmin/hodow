// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryPipelineBarrierTests.cpp
//   external/vulkancts/modules/vulkan/memory/vktMemoryPipelineBarrierComputeTests.cpp
//   external/vulkancts/modules/vulkan/memory/vktMemoryPipelineBarrierGraphicsTests.cpp
//   external/vulkancts/modules/vulkan/memory/vktMemoryPipelineBarrierTransferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written for hodow_cts. `memory.pipeline_barrier` (compute 64, graphics 104, transfer 16 cases) is registered from the mustpass names
// (`not_ported_cases/pipeline_barrier.txt`) and reports NotPorted: the memory operation model of vktMemoryPipelineBarrierTestUtils.cpp (6k lines) is not ported.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const NAMES: &str = include_str!("not_ported_cases/pipeline_barrier.txt");

/// `createPipelineBarrierTests`
pub fn create_pipeline_barrier_tests() -> TestCaseGroup {
    build_gated_groups(NAMES, &[], "the pipeline barrier memory operation model")
        .into_iter()
        .next()
        .expect("the case list names the pipeline_barrier group")
}
