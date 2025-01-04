// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/data_graph/vktDataGraphTests.cpp
//   external/vulkancts/modules/vulkan/data_graph/vktDataGraphTestUtil.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The tests need VK_ARM_data_graph and VK_ARM_tensors, which this port does not drive: the case tree is
// registered with upstream's first support check (`DataGraphTestUtil::checkSupport` requires both extensions) and the bodies are not ported, so a device
// without them ends in NotSupported exactly as under deqp-vk and one with them in NotPorted. The names are the mustpass list of the pinned revision
// (`scripts/gen_data_graph_cases.py` writes `cases.txt`); upstream derives them from the parameter space of its TOSA test resources.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const CASE_NAMES: &str = include_str!("cases.txt");

/// `dataGraph::createTests` - the `data_graph` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("data_graph");
    for child in build_gated_groups(
        CASE_NAMES,
        &["VK_ARM_data_graph", "VK_ARM_tensors"],
        "the VK_ARM_data_graph pipelines",
    ) {
        group.add_child(child);
    }
    group
}
