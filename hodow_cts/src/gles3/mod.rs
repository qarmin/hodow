// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3  (deqp::gles3)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod functional;

use crate::glu::{TestCaseGroup, info_tests};

/// `TestPackage::init` for `dEQP-GLES3`.
pub fn create_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("dEQP-GLES3");
    root.add_child(info_tests::create_tests());
    root.add_child(functional::create_tests());
    root
}
