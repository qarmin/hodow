// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFunctionalTests.cpp (FboTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's four sub-groups, in its order: `color` (`FboColorTests`), `no_attachments`,
// `completeness` and `srgb_write_control` (`FboSRGBWriteControlTests`). Ported: both
// no-attachment ones, all of `srgb_write_control`, and `color` (`tex2d` 3 cases, `texcubearray` 36).

pub mod color_cube_array_tests;
pub mod color_tests;
pub mod fbo_no_attachment_tests;
pub mod srgb_write_control_tests;

use crate::glu::TestCaseGroup;

/// `FboTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fbo");
    group.add_child(color_tests::create_tests());
    group.add_child(fbo_no_attachment_tests::create_tests());
    group.add_child(fbo_no_attachment_tests::create_completeness_tests());
    group.add_child(srgb_write_control_tests::create_tests());
    group
}
