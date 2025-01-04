// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFunctionalTests.cpp (TextureTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's seven sub-groups, in its order: filtering, format, specification, multisample,
// gather, texture_buffer, border_clamp. Ported whole: `multisample`, `gather`,
// `texture_buffer`, `format` (unsized, sized.cube_array, buffer; cube arrays through raw GL), `filtering`.
// `specification` (cube array cases, host-side reference) is ported whole. `border_clamp` is ported whole too
// (`border_clamp_tests`, with its helpers and the CLAMP_TO_BORDER reference sampling in `border_clamp_util`).

pub mod border_clamp_tests;
pub mod border_clamp_util;
pub mod filtering;
pub mod gather_tests;
pub mod texture_buffer_tests;
pub mod texture_format_tests;
pub mod texture_multisample_tests;
pub mod texture_specification_tests;

use crate::glu::TestCaseGroup;

/// `TextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");
    group.add_child(filtering::create_tests());
    group.add_child(texture_format_tests::create_tests());
    group.add_child(texture_specification_tests::create_tests());
    group.add_child(texture_multisample_tests::create_tests());
    group.add_child(gather_tests::create_tests());
    group.add_child(texture_buffer_tests::create_tests());
    group.add_child(border_clamp_tests::create_tests());
    group
}
