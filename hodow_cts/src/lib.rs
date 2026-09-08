// SPDX-License-Identifier: Apache-2.0
//
// hodow_cts - a Rust rewrite of the Khronos Conformance Test Suite (Vulkan and
// OpenGL ES).
//
// Copyright 2026 Rafal Mikrut
// Portions derived from VK-GL-CTS, Copyright (c) The Khronos Group Inc. and others,
// licensed under the Apache License, Version 2.0. See LICENSE and NOTICE at the
// repository root, and hodow_cts/upstream/ for the exact upstream sources each ported
// file was derived from.
//
// Layout mirrors upstream so a file can be found from its C++ counterpart:
//   tcu/     <- framework/common, framework/delibs   (tcu::, de::)
//   vk/      <- external/vulkancts/framework/vulkan  (vk::)
//   vkt/     <- external/vulkancts/modules/vulkan    (vkt::)
//   eglw/    <- framework/egl/wrapper                (eglw::)
//   eglu/    <- framework/egl                        (eglu::)
//   glw/     <- framework/opengl/wrapper             (glw::)
//   glu/     <- framework/opengl                     (glu::)
//   gles31/  <- modules/gles31                       (deqp::gles31)
//
// `tcu`, `report` and `runner` are shared by both APIs; everything under them is one
// API's own.

pub mod color;
pub mod eglu;
pub mod eglw;
pub mod generated;
pub mod gles31;
pub mod glu;
pub mod glw;
pub mod report;
pub mod runner;
pub mod tcu;
pub mod vk;
pub mod vkt;

/// Builds the Vulkan test hierarchy, rooted at `dEQP-VK`.
///
/// Mirrors `createTestPackage` / `TestPackage::init` upstream: the root package name
/// is what makes the full case names identical to `deqp-vk`'s, which is what the
/// differential comparison and the upstream mustpass files both depend on.
pub fn create_test_hierarchy() -> vkt::TestCaseGroup {
    let mut root = vkt::TestCaseGroup::new("dEQP-VK");
    root.add_child(vkt::tests::api::create_tests());
    root.add_child(vkt::tests::binding_model::create_tests());
    root.add_child(vkt::tests::compute::create_tests());
    root.add_child(vkt::tests::memory::create_tests());
    root.add_child(vkt::tests::renderpass::create_tests());
    root.add_child(vkt::tests::transform_feedback::create_tests());
    root.add_child(vkt::tests::ycbcr::create_tests());
    // Upstream registers these as two sibling top-level groups rather than one.
    for group in vkt::tests::synchronization::single_queue_tests::create_tests() {
        root.add_child(group);
    }
    root
}

/// The flat, ordered list of every Vulkan case hodow_cts knows about.
pub fn all_cases() -> Vec<vkt::FlatCase> {
    tcu::flatten(create_test_hierarchy())
}

/// The flat, ordered list of every `dEQP-GLES31` case.
///
/// A separate list rather than a branch of one tree, because the two APIs' cases are
/// genuinely different types: a Vulkan case hands the runner an ahead-of-time program
/// collection and runs against a device, a GLES case compiles its own GLSL against a
/// current context. What matters is that the hierarchy walker, the name filter, the
/// report and the crash isolation are shared, and all of those are generic over the
/// case type.
pub fn all_gles31_cases() -> Vec<glu::FlatCase> {
    tcu::flatten(gles31::create_tests())
}

/// Every case name this binary knows, Vulkan first, in registration order.
///
/// This is what `--list` prints and what the case filters are applied to, so a caller
/// that only wants names never has to know which API a case belongs to.
pub fn all_case_names() -> Vec<String> {
    let mut names: Vec<String> = all_cases().into_iter().map(|c| c.full_name).collect();
    names.extend(all_gles31_cases().into_iter().map(|c| c.full_name));
    names
}
