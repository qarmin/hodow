// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fLifetimeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream is a thin wrapper (74
// lines) around `gls::LifetimeTests::ES2Types`/`addTestCases`, both of which live in
// `hodow_cts/src/gls/lifetime_tests.rs` in this port (see that file's own header for
// why the framework is shared rather than duplicated per API, exactly as upstream
// shares it).

use crate::gls::lifetime_tests::{add_test_cases, es2_types};
use crate::glu::TestCaseGroup;

/// `TestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("lifetime");
    let types = es2_types();
    add_test_cases(&mut group, &types);
    group
}
