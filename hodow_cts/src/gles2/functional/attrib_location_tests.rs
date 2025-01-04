// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fAttribLocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The cases themselves are in
// `gls::attribute_location_tests`; this file is upstream's `createAttributeLocationTests`
// and nothing else.

use crate::gls::attribute_location_tests::{AttribType, CaseKind, add_type_cases, case};
use crate::glu::TestCaseGroup;
use crate::glw;

/// `es2fAttribLocationTests.cpp`'s `types`
const TYPES: [AttribType; 7] = [
    AttribType::new("float", 1, glw::GL_FLOAT),
    AttribType::new("vec2", 1, glw::GL_FLOAT_VEC2),
    AttribType::new("vec3", 1, glw::GL_FLOAT_VEC3),
    AttribType::new("vec4", 1, glw::GL_FLOAT_VEC4),
    AttribType::new("mat2", 2, glw::GL_FLOAT_MAT2),
    AttribType::new("mat3", 3, glw::GL_FLOAT_MAT3),
    AttribType::new("mat4", 4, glw::GL_FLOAT_MAT4),
];

/// `createAttributeLocationTests`
pub fn create_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("attribute_location");

    // Basic bind attribute tests.
    let mut bind_group = TestCaseGroup::new("bind");
    add_type_cases(&mut bind_group, CaseKind::Bind, &TYPES);
    root.add_child(bind_group);

    // Bind max number of attributes.
    let mut bind_max_group = TestCaseGroup::new("bind_max_attributes");
    add_type_cases(&mut bind_max_group, CaseKind::BindMax, &TYPES);
    root.add_child(bind_max_group);

    // Test aliasing.
    let mut aliasing_group = TestCaseGroup::new("bind_aliasing");
    for ty in TYPES {
        // Simple aliasing cases.
        aliasing_group.add_child(case(CaseKind::BindAliasing(0), ty));

        // For types which occupy more than one location, alias the second location.
        if ty.location_size > 1 {
            aliasing_group.add_child(case(CaseKind::BindAliasing(1), ty));
        }

        // Use more than the maximum number of attributes with conditional aliasing.
        aliasing_group.add_child(case(CaseKind::BindMaxAliasing, ty));

        // Use more than the maximum number of attributes with inactive attributes.
        aliasing_group.add_child(case(CaseKind::BindInactiveAliasing, ty));
    }
    root.add_child(aliasing_group);

    // Bind all but one attribute and leave a hole in the location space for it.
    let mut hole_group = TestCaseGroup::new("bind_hole");
    add_type_cases(&mut hole_group, CaseKind::BindHole, &TYPES);
    root.add_child(hole_group);

    // Test binding at different stages.
    let mut bind_time_group = TestCaseGroup::new("bind_time");
    for kind in [
        CaseKind::PreAttachBind,
        CaseKind::PreLinkBind,
        CaseKind::PostLinkBind,
        CaseKind::BindRelink,
        CaseKind::BindReattach,
    ] {
        bind_time_group.add_child(case(kind, TYPES[3]));
    }
    root.add_child(bind_time_group);

    // Test relinking with a moving hole in the attribute location space.
    let mut relink_hole_group = TestCaseGroup::new("bind_relink_hole");
    add_type_cases(&mut relink_hole_group, CaseKind::BindRelinkHole, &TYPES);
    root.add_child(relink_hole_group);

    root
}
