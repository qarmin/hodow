// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fAttribLocationTests.cpp
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

/// `es3fAttribLocationTests.cpp`'s `types`. `mat2`/`mat2x2`, `mat3`/`mat3x3` and
/// `mat4`/`mat4x4` are the same GL enum under two GLSL spellings, and upstream tests
/// both - the case names differ, so both are registered.
const TYPES: [AttribType; 24] = [
    AttribType::new("float", 1, glw::GL_FLOAT),
    AttribType::new("vec2", 1, glw::GL_FLOAT_VEC2),
    AttribType::new("vec3", 1, glw::GL_FLOAT_VEC3),
    AttribType::new("vec4", 1, glw::GL_FLOAT_VEC4),
    AttribType::new("mat2", 2, glw::GL_FLOAT_MAT2),
    AttribType::new("mat3", 3, glw::GL_FLOAT_MAT3),
    AttribType::new("mat4", 4, glw::GL_FLOAT_MAT4),
    AttribType::new("int", 1, glw::GL_INT),
    AttribType::new("ivec2", 1, glw::GL_INT_VEC2),
    AttribType::new("ivec3", 1, glw::GL_INT_VEC3),
    AttribType::new("ivec4", 1, glw::GL_INT_VEC4),
    AttribType::new("uint", 1, glw::GL_UNSIGNED_INT),
    AttribType::new("uvec2", 1, glw::GL_UNSIGNED_INT_VEC2),
    AttribType::new("uvec3", 1, glw::GL_UNSIGNED_INT_VEC3),
    AttribType::new("uvec4", 1, glw::GL_UNSIGNED_INT_VEC4),
    AttribType::new("mat2x2", 2, glw::GL_FLOAT_MAT2),
    AttribType::new("mat2x3", 2, glw::GL_FLOAT_MAT2x3),
    AttribType::new("mat2x4", 2, glw::GL_FLOAT_MAT2x4),
    AttribType::new("mat3x2", 3, glw::GL_FLOAT_MAT3x2),
    AttribType::new("mat3x3", 3, glw::GL_FLOAT_MAT3),
    AttribType::new("mat3x4", 3, glw::GL_FLOAT_MAT3x4),
    AttribType::new("mat4x2", 4, glw::GL_FLOAT_MAT4x2),
    AttribType::new("mat4x3", 4, glw::GL_FLOAT_MAT4x3),
    AttribType::new("mat4x4", 4, glw::GL_FLOAT_MAT4),
];

/// `es2Types` - the aliasing group stays on the ES 2.0 subset, because aliasing needs
/// `#version 100` and an integer attribute cannot be declared there.
const ES2_TYPES: [AttribType; 7] = [
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

    // Use bind with the maximum number of attributes.
    let mut bind_max_group = TestCaseGroup::new("bind_max_attributes");
    add_type_cases(&mut bind_max_group, CaseKind::BindMax, &TYPES);
    root.add_child(bind_max_group);

    // Test binding aliasing locations.
    let mut aliasing_group = TestCaseGroup::new("bind_aliasing");
    for ty in ES2_TYPES {
        aliasing_group.add_child(case(CaseKind::BindAliasing(0), ty));

        if ty.location_size > 1 {
            aliasing_group.add_child(case(CaseKind::BindAliasing(1), ty));
        }

        aliasing_group.add_child(case(CaseKind::BindMaxAliasing, ty));
        aliasing_group.add_child(case(CaseKind::BindInactiveAliasing, ty));
    }
    root.add_child(aliasing_group);

    // Bind all but one attribute and leave a hole in the location space for it.
    let mut bind_hole_group = TestCaseGroup::new("bind_hole");
    add_type_cases(&mut bind_hole_group, CaseKind::BindHole, &TYPES);
    root.add_child(bind_hole_group);

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

    // Basic layout location tests.
    let mut layout_group = TestCaseGroup::new("layout");
    add_type_cases(&mut layout_group, CaseKind::Location, &TYPES);
    root.add_child(layout_group);

    let mut layout_max_group = TestCaseGroup::new("layout_max_attributes");
    add_type_cases(&mut layout_max_group, CaseKind::LocationMax, &TYPES);
    root.add_child(layout_max_group);

    let mut layout_hole_group = TestCaseGroup::new("layout_hole");
    add_type_cases(&mut layout_hole_group, CaseKind::LocationHole, &TYPES);
    root.add_child(layout_hole_group);

    // Basic mixed location tests.
    let mut mixed_group = TestCaseGroup::new("mixed");
    add_type_cases(&mut mixed_group, CaseKind::Mixed, &TYPES);
    root.add_child(mixed_group);

    let mut mixed_max_group = TestCaseGroup::new("mixed_max_attributes");
    add_type_cases(&mut mixed_max_group, CaseKind::MixedMax, &TYPES);
    root.add_child(mixed_max_group);

    // Test mixed binding at different stages.
    let mut mixed_time_group = TestCaseGroup::new("mixed_time");
    for kind in [
        CaseKind::PreAttachMixed,
        CaseKind::PreLinkMixed,
        CaseKind::PostLinkMixed,
        CaseKind::MixedRelink,
        CaseKind::MixedReattach,
    ] {
        mixed_time_group.add_child(case(kind, TYPES[3]));
    }
    root.add_child(mixed_time_group);

    let mut mixed_hole_group = TestCaseGroup::new("mixed_hole");
    add_type_cases(&mut mixed_hole_group, CaseKind::MixedHole, &TYPES);
    root.add_child(mixed_hole_group);

    // Test a hole in the location space that moves when relinking.
    let mut bind_relink_hole_group = TestCaseGroup::new("bind_relink_hole");
    add_type_cases(&mut bind_relink_hole_group, CaseKind::BindRelinkHole, &TYPES);
    root.add_child(bind_relink_hole_group);

    let mut mixed_relink_hole_group = TestCaseGroup::new("mixed_relink_hole");
    add_type_cases(&mut mixed_relink_hole_group, CaseKind::MixedRelinkHole, &TYPES);
    root.add_child(mixed_relink_hole_group);

    root
}
