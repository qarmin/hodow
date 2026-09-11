// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod compute;
pub mod state_query;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(compute::create_tests());
    group.add_child(state_query::create_tests());
    group
}
