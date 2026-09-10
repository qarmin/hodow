// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp  (BufferTests::init)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `BufferMapTests` is not ported - it
// needs `gls::BufferTestUtil`'s map-based writer/verifier, which this tree does not have.

pub mod buffer_copy_tests;
pub mod buffer_write_tests;

use crate::glu::TestCaseGroup;

pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer");
    group.add_child(buffer_write_tests::create_tests());
    group.add_child(buffer_copy_tests::create_tests());
    group
}
