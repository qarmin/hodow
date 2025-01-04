// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree is registered with upstream's first support check and the bodies are not ported (except the
// `headless` cases of `surface_tests.rs`, `swapchain_tests.rs` and `maintenance1_*_tests.rs`), so a device without the extensions ends in NotSupported as under deqp-vk and one with them in NotPorted. The names are the mustpass list of the pinned
// revision (`scripts/gen_gated_groups.py` writes `cases.txt`).

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups_with;

mod array_wsi_tests;
mod compression_swapchain_tests;
pub mod incremental_present_tests;
mod maintenance1_present_fence_tests;
mod maintenance1_release_images_tests;
mod maintenance1_tests;
mod surface_extra_tests;
mod surface_tests;
pub mod swapchain_render_tests;
mod swapchain_tests;

/// `api.frame_boundary.wsi.headless`, which needs this group's swapchain device
pub fn frame_boundary_headless_case() -> Box<dyn crate::vkt::TestCase> {
    swapchain_tests::create_frame_boundary_headless_case()
}

/// `api.image_compression_control.swapchain.headless.*`, which need this group's swapchain device
pub fn compression_swapchain_cases() -> std::collections::HashMap<String, Box<dyn crate::vkt::TestCase>> {
    compression_swapchain_tests::create_headless_compression_swapchain_cases()
}

/// `api.array.oversized_array.wsi.headless.*`, which need this group's swapchain device
pub fn array_wsi_cases() -> std::collections::HashMap<String, Box<dyn crate::vkt::TestCase>> {
    array_wsi_tests::create_headless_array_cases()
}

const CASE_NAMES: &str = include_str!("cases.txt");

/// The `wsi` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("wsi");
    let mut ported = surface_tests::create_headless_surface_cases();
    ported.extend(swapchain_tests::create_headless_swapchain_cases());
    ported.extend(maintenance1_tests::create_headless_maintenance1_cases());
    ported.extend(incremental_present_tests::create_headless_incremental_present_cases());
    ported.extend(surface_extra_tests::create_headless_surface_extra_cases());
    ported.extend(swapchain_render_tests::create_headless_render_cases());
    for child in build_gated_groups_with(CASE_NAMES, &["VK_KHR_swapchain"], "the WSI tests", &mut |path| {
        ported.remove(path)
    }) {
        group.add_child(child);
    }
    group
}
