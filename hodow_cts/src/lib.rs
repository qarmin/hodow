// SPDX-License-Identifier: Apache-2.0
//
// hodow_cts - a Rust rewrite of the Khronos Vulkan Conformance Test Suite.
//
// Copyright 2026 Rafal Mikrut
// Portions derived from VK-GL-CTS, Copyright (c) The Khronos Group Inc. and others,
// licensed under the Apache License, Version 2.0. See LICENSE and NOTICE at the
// repository root, and hodow_cts/upstream/ for the exact upstream sources each ported
// file was derived from.
//
// Layout mirrors upstream so a file can be found from its C++ counterpart:
//   tcu/   <- framework/common, framework/delibs   (tcu::, de::)
//   vk/    <- external/vulkancts/framework/vulkan  (vk::)
//   vkt/   <- external/vulkancts/modules/vulkan    (vkt::)

pub mod generated;
pub mod report;
pub mod runner;
pub mod tcu;
pub mod vk;
pub mod vkt;

/// Builds the whole test hierarchy, rooted at `dEQP-VK`.
///
/// Mirrors `createTestPackage` / `TestPackage::init` upstream: the root package name
/// is what makes the full case names identical to `deqp-vk`'s, which is what the
/// differential comparison and the upstream mustpass files both depend on.
pub fn create_test_hierarchy() -> tcu::TestCaseGroup {
    let mut root = tcu::TestCaseGroup::new("dEQP-VK");
    root.add_child(vkt::tests::api::create_tests());
    root.add_child(vkt::tests::binding_model::create_tests());
    root.add_child(vkt::tests::compute::create_tests());
    root.add_child(vkt::tests::memory::create_tests());
    root.add_child(vkt::tests::renderpass::create_tests());
    root
}

/// The flat, ordered list of every case hodow_cts knows about.
pub fn all_cases() -> Vec<tcu::FlatCase> {
    tcu::flatten(create_test_hierarchy())
}
