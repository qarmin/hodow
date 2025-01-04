// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::QueryType;
use crate::gls::texture_state_query_tests::{
    Setter, TesterType, add_is_texture_test, add_tex_param_test, is_legal_tester_for_target,
};
use crate::glu::TestCaseGroup;
use crate::glw::{self, GLenum};

/// `verifiers`
const VERIFIERS: [QueryType; 2] = [QueryType::TextureParamInteger, QueryType::TextureParamFloat];

/// `textureTargets`
const TEXTURE_TARGETS: [(&str, GLenum); 4] = [
    ("texture_2d", glw::GL_TEXTURE_2D),
    ("texture_3d", glw::GL_TEXTURE_3D),
    ("texture_2d_array", glw::GL_TEXTURE_2D_ARRAY),
    ("texture_cube_map", glw::GL_TEXTURE_CUBE_MAP),
];

/// `states`
const STATES: [(&str, TesterType); 17] = [
    ("texture_swizzle_r", TesterType::TextureSwizzleR),
    ("texture_swizzle_g", TesterType::TextureSwizzleG),
    ("texture_swizzle_b", TesterType::TextureSwizzleB),
    ("texture_swizzle_a", TesterType::TextureSwizzleA),
    ("texture_wrap_s", TesterType::TextureWrapS),
    ("texture_wrap_t", TesterType::TextureWrapT),
    ("texture_wrap_r", TesterType::TextureWrapR),
    ("texture_mag_filter", TesterType::TextureMagFilter),
    ("texture_min_filter", TesterType::TextureMinFilter),
    ("texture_min_lod", TesterType::TextureMinLod),
    ("texture_max_lod", TesterType::TextureMaxLod),
    ("texture_base_level", TesterType::TextureBaseLevel),
    ("texture_max_level", TesterType::TextureMaxLevel),
    ("texture_compare_mode", TesterType::TextureCompareMode),
    ("texture_compare_func", TesterType::TextureCompareFunc),
    ("texture_immutable_levels", TesterType::TextureImmutableLevels),
    ("texture_immutable_format", TesterType::TextureImmutableFormat),
];

/// `getVerifierSuffix`
fn verifier_suffix(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::TextureParamInteger => "_gettexparameteri",
        QueryType::TextureParamFloat => "_gettexparameterf",
        other => panic!("{other:?} is not a texture-parameter verifier"),
    }
}

/// `TextureStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");

    for (target_name, target) in TEXTURE_TARGETS {
        add_is_texture_test(&mut group, format!("{target_name}_is_texture"), target);

        for (state_name, tester) in STATES {
            if !is_legal_tester_for_target(target, tester) {
                continue;
            }

            for verifier in VERIFIERS {
                add_tex_param_test(
                    &mut group,
                    format!("{target_name}_{state_name}{}", verifier_suffix(verifier)),
                    verifier,
                    target,
                    tester,
                    Setter::Default,
                );
            }
        }
    }

    group
}
