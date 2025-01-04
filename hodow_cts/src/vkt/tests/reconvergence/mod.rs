// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/reconvergence/vktReconvergenceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `terminate_invocation` child, the `maximal.fragment` Amber scripts and the `maximal.compute` random programs and the uniform control flow groups are ported; the
// random programs of the other stages are not.

pub mod compute_cases;
pub mod compute_tests;
pub mod maximal_fragment_cases;
pub mod maximal_fragment_tests;
pub mod terminate_invocation_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `reconvergence` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("reconvergence");
    let mut maximal = maximal_fragment_tests::create_maximal_fragment_tests();
    let mut uniform_control_flow = Vec::new();
    for (name, compute) in compute_tests::create_compute_tests() {
        if name == "maximal" {
            maximal.add_child(compute);
        } else {
            let mut child = TestCaseGroup::new(name);
            child.add_child(compute);
            uniform_control_flow.push(child);
        }
    }
    group.add_child(maximal);
    group.add_child(terminate_invocation_tests::create_terminate_invocation_tests());
    for child in uniform_control_flow {
        group.add_child(child);
    }
    group
}
