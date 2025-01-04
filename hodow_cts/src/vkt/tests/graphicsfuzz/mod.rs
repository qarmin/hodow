// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/amber/vktAmberGraphicsFuzzTests.cpp (the graphicsfuzz Amber scripts under data/vulkan/amber/graphicsfuzz)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. There is no Amber interpreter here: `scripts/gen_graphicsfuzz_manifest.py` reads the scripts
// that are one fragment shader, uniform buffers and a probed full-framebuffer rectangle and writes them into `shaders/manifest/graphicsfuzz.toml`;
// the rest (push constants, samplers, the histogram comparison of a variant against a reference frame, device properties) are skipped there.

pub mod amber_tests;
pub mod compute_tests;

use crate::vkt::TestCaseGroup;

/// `createGraphicsFuzzTests` - the `graphicsfuzz` group.
pub fn create_tests() -> TestCaseGroup {
    amber_tests::create_graphicsfuzz_tests()
}
