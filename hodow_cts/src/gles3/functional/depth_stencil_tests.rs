// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fDepthStencilTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's es3f copy of this file is byte-identical to the es2f one apart from the
// header comment, the namespace and the single line that asks the `QuadRenderer` for
// GLSL ES 3.00 instead of 1.00, so the port lives in `gles2::functional` and this is the
// ES 3.0 entry point. `diff modules/gles{2,3}/functional/es{2,3}fDepthStencilTests.cpp`
// before a re-sync: if the two ever grow apart, this has to become a real port.

use crate::gls::fragment_op_util::QuadRendererGlslVersion;
use crate::glu::TestCaseGroup;

/// `DepthStencilTests::init`
pub fn create_tests() -> TestCaseGroup {
    crate::gles2::functional::depth_stencil_tests::create_tests(QuadRendererGlslVersion::Es300)
}
