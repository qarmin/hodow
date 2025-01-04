// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp (FboTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's ten sub-groups, in its order: api, completeness, render, color, depth,
// stencil, blit, msaa, multiview, invalidate. `api`, `completeness`, `render`, `color` (partly, see its header), `depth`, `stencil` and
// `multiview` are ported (`depth`/`stencil` through `fbo_test_case`/`fbo_test_util`, the
// `FboTestCase` port) - the rest render and compare against a reference image. `multiview` is the one
// exception in that list that needed no reference image at all (an analytical
// left-half/right-half colour check), which is why it could be ported despite living
// among the render-dependent siblings.

pub mod colorbuffer_tests;
pub mod completeness_tests;
pub mod depthbuffer_tests;
pub mod fbo_api_tests;
pub mod fbo_test_case;
pub mod fbo_test_util;
pub mod invalidate_tests;
pub mod multisample_tests;
pub mod multiview_tests;
pub mod render_tests;
pub mod stencilbuffer_tests;

use crate::glu::TestCaseGroup;

/// `FboTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fbo");
    group.add_child(fbo_api_tests::create_tests());
    group.add_child(completeness_tests::create_tests());
    group.add_child(render_tests::create_tests());
    group.add_child(colorbuffer_tests::create_tests());
    group.add_child(depthbuffer_tests::create_tests());
    group.add_child(stencilbuffer_tests::create_tests());
    group.add_child(super::framebuffer_blit_tests::create_tests());
    group.add_child(multisample_tests::create_tests());
    group.add_child(multiview_tests::create_tests());
    group.add_child(invalidate_tests::create_tests());
    group
}
