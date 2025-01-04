// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp (TextureTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's children, in its order: format, size, wrap, filtering, mipmap, swizzle,
// shadow, specification, vertex, unit, compressed. Ported so far: see the `pub mod` list.

pub mod compressed;
pub mod etc1_cases;
pub mod filtering;
pub mod format;
pub mod mipmap;
pub mod shadow;
pub mod spec_shaders;
pub mod specification;
pub mod storage_base_level;
pub mod swizzle;
pub mod unit;
pub mod vertex;
pub mod wrap;

use crate::glu::{GlslVersion, TestCaseGroup};

/// `TextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");
    group.add_child(format::create_tests());
    // `es3fTextureSizeTests.cpp` is `es2fTextureSizeTests.cpp` with GLSL ES 3.00 and seamless cube maps.
    group.add_child(crate::gles2::functional::texture::size::create_tests_for(
        GlslVersion::Es300,
        true,
    ));
    group.add_child(wrap::create_tests());
    group.add_child(filtering::create_tests());
    group.add_child(mipmap::create_tests());
    group.add_child(swizzle::create_tests());
    group.add_child(shadow::create_tests());
    group.add_child(specification::create_tests());
    group.add_child(vertex::create_tests());
    group.add_child(unit::create_tests());
    group.add_child(compressed::create_tests());
    group
}
