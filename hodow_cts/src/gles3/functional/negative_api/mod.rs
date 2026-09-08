// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp (NegativeApiTestGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream registers six sub-groups
// here; only `texture` is not ported yet.

pub mod buffer;
pub mod fragment;
pub mod shader;
pub mod state;
pub mod vertex_array;

use crate::glu::TestCaseGroup;

/// `NegativeApiTestGroup::init`, in upstream's order.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative_api");
    group.add_child(buffer::create_tests());
    group.add_child(shader::create_tests());
    group.add_child(fragment::create_tests());
    group.add_child(vertex_array::create_tests());
    group.add_child(state::create_tests());
    group
}
