// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassFragmentDensityMapTests.cpp
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultiviewPerViewTests.cpp
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp (the performance_counters_by_region group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case trees of `fragment_density_map`, `multiview_per_view` and
// `performance_counters_by_region` are registered from the mustpass names (`exotic_cases/*.txt`, one file per parent group, written by
// `scripts/gen_renderpass_exotic_lists.py`) with the first support check of upstream (the extension): NotSupported without it, NotPorted with it.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const RENDERPASS1: &str = include_str!("exotic_cases/renderpass1.txt");
const RENDERPASS2: &str = include_str!("exotic_cases/renderpass2.txt");
const DYNAMIC_PRIMARY: &str = include_str!("exotic_cases/dynamic_rendering.primary_cmd_buff.txt");
const DYNAMIC_PARTIAL_SECONDARY: &str = include_str!("exotic_cases/dynamic_rendering.partial_secondary_cmd_buff.txt");
const DYNAMIC_COMPLETE_SECONDARY: &str = include_str!("exotic_cases/dynamic_rendering.complete_secondary_cmd_buff.txt");
const DYNAMIC_GPL: &str = include_str!("exotic_cases/dynamic_rendering.graphics_pipeline_library.txt");
const GPL_LOCAL_READ: &str = include_str!("exotic_cases/gpl_local_read.txt");

/// The groups of the three families that exist under the parent group `parent` (`renderpass1`, `renderpass2` or `dynamic_rendering.<variant>`)
pub fn create_exotic_groups(parent: &str) -> Vec<TestCaseGroup> {
    let names = match parent {
        "renderpass1" => RENDERPASS1,
        "renderpass2" => RENDERPASS2,
        "dynamic_rendering.primary_cmd_buff" => DYNAMIC_PRIMARY,
        "dynamic_rendering.partial_secondary_cmd_buff" => DYNAMIC_PARTIAL_SECONDARY,
        "dynamic_rendering.complete_secondary_cmd_buff" => DYNAMIC_COMPLETE_SECONDARY,
        "dynamic_rendering.graphics_pipeline_library" => DYNAMIC_GPL,
        _ => return Vec::new(),
    };

    let family = |prefix: &str| -> String {
        names
            .lines()
            .filter(|line| line.split('.').next() == Some(prefix))
            .map(|line| format!("{line}\n"))
            .collect()
    };
    let sub_family = |prefix: &str| -> String {
        let mut lines = String::new();
        for line in names.lines() {
            if let Some(rest) = line.strip_prefix(prefix) {
                lines.push_str(rest);
                lines.push('\n');
            }
        }
        lines
    };

    let mut groups = Vec::new();

    let fdm = family("fragment_density_map");
    if !fdm.is_empty() {
        groups.extend(build_gated_groups(
            &fdm,
            &["VK_EXT_fragment_density_map"],
            "the VK_EXT_fragment_density_map tests",
        ));
    }

    let render_areas = sub_family("multiview_per_view.render_areas.");
    let viewports = sub_family("multiview_per_view.viewports.");
    if !render_areas.is_empty() || !viewports.is_empty() {
        let mut per_view = TestCaseGroup::new("multiview_per_view");
        if !render_areas.is_empty() {
            let lines: String = render_areas
                .lines()
                .map(|line| format!("render_areas.{line}\n"))
                .collect();
            for group in build_gated_groups(
                &lines,
                &["VK_QCOM_multiview_per_view_render_areas"],
                "the VK_QCOM_multiview_per_view_render_areas tests",
            ) {
                per_view.add_child(group);
            }
        }
        if !viewports.is_empty() {
            let lines: String = viewports.lines().map(|line| format!("viewports.{line}\n")).collect();
            for group in build_gated_groups(&lines, &["VK_KHR_multiview"], "the multiview per view viewports tests") {
                per_view.add_child(group);
            }
        }
        groups.push(per_view);
    }

    let performance_counters = family("performance_counters_by_region");
    if !performance_counters.is_empty() {
        groups.extend(build_gated_groups(
            &performance_counters,
            &["VK_ARM_performance_counters_by_region"],
            "the VK_ARM_performance_counters_by_region tests",
        ));
    }

    groups
}

/// The `local_read` group of the `graphics_pipeline_library` variant, from the mustpass names: `create_graphics_pipeline` of this port does not carry
/// the attachment location and input index infos a library needs, so the cases need the two extensions and then report NotPorted.
pub fn create_gpl_local_read_groups() -> Vec<TestCaseGroup> {
    build_gated_groups(
        GPL_LOCAL_READ,
        &[
            "VK_KHR_dynamic_rendering_local_read",
            "VK_EXT_graphics_pipeline_library",
        ],
        "the local read tests with graphics pipeline libraries",
    )
}
