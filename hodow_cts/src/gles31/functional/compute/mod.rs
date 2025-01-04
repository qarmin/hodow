// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fComputeShaderBuiltinVarTests.cpp and siblings, via
//   the `compute` group in es31fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod basic_compute_shader_tests;
pub mod indirect_compute_dispatch_tests;

use crate::glu::TestCaseGroup;

pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("compute");
    group.add_child(basic_compute_shader_tests::create_tests());
    group.add_child(super::shader_shared_var_tests::create_tests());
    group.add_child(indirect_compute_dispatch_tests::create_tests());
    group
}
