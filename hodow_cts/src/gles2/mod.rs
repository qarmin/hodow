// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2  (deqp::gles2)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

#[cfg(feature = "gles")]
pub mod functional;

use crate::glu::TestCaseGroup;
#[cfg(feature = "gles")]
use crate::glu::info_tests;

/// `TestPackage::init` for `dEQP-GLES2` - the root group's children, in upstream's
/// order (`info`, then `functional`; `capability`, `accuracy`, `performance` and
/// `stress` are not ported).
pub fn create_tests() -> TestCaseGroup {
    #[allow(unused_mut)]
    let mut root = TestCaseGroup::new("dEQP-GLES2");
    #[cfg(feature = "gles")]
    {
        root.add_child(info_tests::create_tests());
        root.add_child(functional::create_tests());
    }
    root
}
