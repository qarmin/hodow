// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderTextureFunctionTests.cpp
//   external/vulkancts/modules/vulkan/glsl/vktGlslBuiltinPrecisionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written for hodow_cts. The `texture_functions`, `texture_gather` and `builtin.precision*` case trees are registered from the
// mustpass names (`not_ported_cases/*.txt`, written by `scripts/gen_not_ported_lists.py`) and report NotPorted: the bodies are not ported.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

const TEXTURE_FUNCTIONS: &str = include_str!("not_ported_cases/texture_functions.txt");
const TEXTURE_GATHER: &str = include_str!("not_ported_cases/texture_gather.txt");
const BUILTIN_PRECISION: &str = include_str!("not_ported_cases/builtin_precision.txt");

/// The sub-groups of `glsl.texture_functions` that are not ported
pub fn create_texture_function_groups() -> Vec<TestCaseGroup> {
    build_gated_groups(TEXTURE_FUNCTIONS, &[], "the texture function tests")
}

/// `glsl.texture_gather`
pub fn create_texture_gather_group() -> TestCaseGroup {
    let lines: String = TEXTURE_GATHER
        .lines()
        .map(|line| format!("texture_gather.{line}\n"))
        .collect();
    build_gated_groups(&lines, &[], "the texture gather tests")
        .into_iter()
        .next()
        .expect("the case list names the texture_gather group")
}

/// The `precision*` sub-groups of `glsl.builtin`
pub fn create_builtin_precision_groups() -> Vec<TestCaseGroup> {
    build_gated_groups(BUILTIN_PRECISION, &[], "the builtin function precision tests")
}
