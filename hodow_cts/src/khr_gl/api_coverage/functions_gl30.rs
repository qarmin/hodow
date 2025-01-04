// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points: `run_func_gl30` chains the dispatchers of `functions_gl30_*.rs`, which hold the tests in upstream's order (state, textures, shaders and programs, queries and buffers, framebuffers and vertex arrays).

use super::Coverage;
use crate::tcu::TestError;

impl Coverage<'_> {
    pub(super) fn run_func_gl30(&self, name: &str) -> Option<Result<bool, TestError>> {
        self.run_func_gl30_state(name)
            .or_else(|| self.run_func_gl30_params(name))
            .or_else(|| self.run_func_gl30_uniforms(name))
            .or_else(|| self.run_func_gl30_fbo(name))
            .or_else(|| self.run_func_gl30_shaders(name))
            .or_else(|| self.run_func_gl30_objects(name))
            .or_else(|| self.run_func_gl30_feedback(name))
            .or_else(|| self.run_func_gl30_vertex(name))
    }
}
