// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFunctionalTests.cpp (TextureTestGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's children, in its order: format, size, wrap, filtering, mipmap,
// specification, completeness, vertex, unit. Ported so far: see the `pub mod` list.

pub mod completeness;
pub mod filtering;
pub mod format;
pub mod mipmap;
pub mod size;
pub mod specification;
pub mod unit;
pub mod vertex;
pub mod wrap;

use crate::glu::TestCaseGroup;

/// `TextureTestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");
    group.add_child(format::create_tests());
    group.add_child(size::create_tests());
    group.add_child(wrap::create_tests());
    group.add_child(filtering::create_tests());
    group.add_child(mipmap::create_tests());
    group.add_child(specification::create_tests());
    group.add_child(completeness::create_tests());
    group.add_child(vertex::create_tests());
    group.add_child(unit::create_tests());
    group
}
