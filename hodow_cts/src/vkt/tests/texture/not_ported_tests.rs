// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureTests.cpp (explicit_lod)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written for hodow_cts. The `explicit_lod` group is registered from the mustpass names (`not_ported_cases/*.txt`, written by
// `scripts/gen_not_ported_lists.py`) and reports NotPorted: the sample verifier is not ported.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const EXPLICIT_LOD: &str = include_str!("not_ported_cases/explicit_lod.txt");

/// `texture.explicit_lod`
pub fn create_explicit_lod_group() -> TestCaseGroup {
    let lines: String = EXPLICIT_LOD
        .lines()
        .map(|line| format!("explicit_lod.{line}\n"))
        .collect();
    build_gated_groups(&lines, &[], "the explicit LOD texture tests")
        .into_iter()
        .next()
        .expect("the case list names the explicit_lod group")
}
