// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassCustomResolveTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `custom_resolve` groups need VK_EXT_custom_resolve, which vulkanalia does not have: the case
// trees are registered with upstream's first support check (the extension) and the bodies are not ported, so a device without it ends in
// NotSupported as under deqp-vk and one with it in NotPorted. The names are the mustpass list of the pinned revision (`custom_resolve_cases/*.txt`,
// one file per parent group).

use super::group_params::{GroupParams, RenderingType};
use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const RENDERPASS1: &str = include_str!("custom_resolve_cases/renderpass1.txt");
const RENDERPASS2: &str = include_str!("custom_resolve_cases/renderpass2.txt");
const DYNAMIC_PRIMARY: &str = include_str!("custom_resolve_cases/dynamic_rendering.primary_cmd_buff.txt");
const DYNAMIC_PARTIAL_SECONDARY: &str =
    include_str!("custom_resolve_cases/dynamic_rendering.partial_secondary_cmd_buff.txt");

/// `createCustomResolveTests` for the `renderpass1` / `renderpass2` groups; `None` for any other name
pub fn create_custom_resolve_tests_for_render_pass(group_name: &str) -> Option<TestCaseGroup> {
    match group_name {
        "renderpass1" => Some(gated(RENDERPASS1)),
        "renderpass2" => Some(gated(RENDERPASS2)),
        _ => None,
    }
}

/// `createCustomResolveTests` for a dynamic rendering variant; `None` for the complete secondary variant (upstream has no cases there)
pub fn create_custom_resolve_tests_for_dynamic_rendering(group_params: GroupParams) -> Option<TestCaseGroup> {
    if group_params.rendering_type != RenderingType::DynamicRendering {
        return None;
    }
    if !group_params.use_secondary_cmd_buffer {
        Some(gated(DYNAMIC_PRIMARY))
    } else if !group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
        Some(gated(DYNAMIC_PARTIAL_SECONDARY))
    } else {
        None
    }
}

fn gated(names: &str) -> TestCaseGroup {
    let lines: String = names.lines().map(|line| format!("custom_resolve.{line}\n")).collect();
    build_gated_groups(&lines, &["VK_EXT_custom_resolve"], "the VK_EXT_custom_resolve tests")
        .into_iter()
        .next()
        .expect("the case list names the custom_resolve group")
}
