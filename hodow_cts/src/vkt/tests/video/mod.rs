// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/video/vktVideoTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree is registered with upstream's first support check and the bodies are not ported, so a
// device without the extensions ends in NotSupported as under deqp-vk and one with them in NotPorted. The names are the mustpass list of the pinned
// revision (`scripts/gen_gated_groups.py` writes `cases.txt`). Ported: `profiles.{decode,encode}.*` (`profiles_tests.rs`) `formats.*` (`formats_tests.rs`) and `capabilities.*` (`capabilities_tests.rs`: queue support and the non extended flags format support queries, the rest with upstream's `checkSupport`, then NotPorted).

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups_with;

mod capabilities_query_tests;
mod capabilities_tests;
mod formats_tests;
mod profiles_tests;

const CASE_NAMES: &str = include_str!("cases.txt");

/// The `video` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("video");
    let mut ported = profiles_tests::create_profiles_cases();
    ported.extend(formats_tests::create_formats_cases());
    ported.extend(capabilities_tests::create_capabilities_cases());
    for child in build_gated_groups_with(CASE_NAMES, &["VK_KHR_video_queue"], "the video tests", &mut |path| {
        ported.remove(path)
    }) {
        group.add_child(child);
    }
    group
}
