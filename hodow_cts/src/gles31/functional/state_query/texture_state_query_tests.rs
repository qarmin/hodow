// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// What ES 3.1 adds on top of the ES 3.0 file: four texture targets (multisample,
// multisample array, buffer, cube array), five states (`DEPTH_STENCIL_TEXTURE_MODE`,
// `TEXTURE_SRGB_DECODE_EXT`, `TEXTURE_BORDER_COLOR` and the three
// `TEXTURE_WRAP_*_CLAMP_TO_BORDER` re-checks), and the pure-integer getters and
// setters. An *old* target only gets the *new* states, since the rest is already
// covered in gles3 - which is why `texture_2d` here is 16 cases, not 32.

use crate::gls::state_query_util::QueryType;
use crate::gls::texture_state_query_tests::{
    Setter, TesterType, add_is_texture_test, add_tex_param_test, is_legal_tester_for_target,
};
use crate::glu::TestCaseGroup;
use crate::glw::{self, GLenum};

/// `scalarVerifiers`
const SCALAR_VERIFIERS: [QueryType; 4] = [
    QueryType::TextureParamInteger,
    QueryType::TextureParamFloat,
    QueryType::TextureParamPureInteger,
    QueryType::TextureParamPureUnsignedInteger,
];

/// `nonPureVerifiers`
const NON_PURE_VERIFIERS: [QueryType; 2] = [QueryType::TextureParamInteger, QueryType::TextureParamFloat];

/// `vec4Verifiers`
const VEC4_VERIFIERS: [QueryType; 4] = [
    QueryType::TextureParamIntegerVec4,
    QueryType::TextureParamFloatVec4,
    QueryType::TextureParamPureIntegerVec4,
    QueryType::TextureParamPureUnsignedIntegerVec4,
];

/// `getVerifierSuffix`
fn verifier_suffix(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::TextureParamFloat | QueryType::TextureParamFloatVec4 => "_float",
        QueryType::TextureParamInteger | QueryType::TextureParamIntegerVec4 => "_integer",
        QueryType::TextureParamPureInteger | QueryType::TextureParamPureIntegerVec4 => "_pure_int",
        QueryType::TextureParamPureUnsignedInteger | QueryType::TextureParamPureUnsignedIntegerVec4 => "_pure_uint",
        other => panic!("{other:?} is not a texture-parameter verifier"),
    }
}

/// `isIsVectorQuery`
fn is_vector_query(tester: TesterType) -> bool {
    tester == TesterType::TextureBorderColor
}

/// `isExtendedParamQuery`
fn is_extended_param_query(tester: TesterType) -> bool {
    matches!(
        tester,
        TesterType::TextureWrapSClampToBorder
            | TesterType::TextureWrapTClampToBorder
            | TesterType::TextureWrapRClampToBorder
    )
}

/// `textureTargets`
const TEXTURE_TARGETS: [(&str, GLenum, bool); 8] = [
    ("texture_2d", glw::GL_TEXTURE_2D, false),
    ("texture_3d", glw::GL_TEXTURE_3D, false),
    ("texture_2d_array", glw::GL_TEXTURE_2D_ARRAY, false),
    ("texture_cube_map", glw::GL_TEXTURE_CUBE_MAP, false),
    ("texture_2d_multisample", glw::GL_TEXTURE_2D_MULTISAMPLE, true),
    // GL_OES_texture_storage_multisample_2d_array
    (
        "texture_2d_multisample_array",
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        true,
    ),
    // GL_EXT_texture_buffer
    ("texture_buffer", glw::GL_TEXTURE_BUFFER, true),
    // GL_EXT_texture_cube_map_array
    ("texture_cube_array", glw::GL_TEXTURE_CUBE_MAP_ARRAY, true),
];

/// `states`
const STATES: [(&str, TesterType, bool); 23] = [
    ("texture_swizzle_r", TesterType::TextureSwizzleR, false),
    ("texture_swizzle_g", TesterType::TextureSwizzleG, false),
    ("texture_swizzle_b", TesterType::TextureSwizzleB, false),
    ("texture_swizzle_a", TesterType::TextureSwizzleA, false),
    ("texture_wrap_s", TesterType::TextureWrapS, false),
    ("texture_wrap_t", TesterType::TextureWrapT, false),
    ("texture_wrap_r", TesterType::TextureWrapR, false),
    ("texture_mag_filter", TesterType::TextureMagFilter, false),
    ("texture_min_filter", TesterType::TextureMinFilter, false),
    ("texture_min_lod", TesterType::TextureMinLod, false),
    ("texture_max_lod", TesterType::TextureMaxLod, false),
    ("texture_base_level", TesterType::TextureBaseLevel, false),
    ("texture_max_level", TesterType::TextureMaxLevel, false),
    ("texture_compare_mode", TesterType::TextureCompareMode, false),
    ("texture_compare_func", TesterType::TextureCompareFunc, false),
    ("texture_immutable_levels", TesterType::TextureImmutableLevels, false),
    ("texture_immutable_format", TesterType::TextureImmutableFormat, false),
    ("depth_stencil_mode", TesterType::DepthStencilTextureMode, true),
    ("texture_srgb_decode", TesterType::TextureSrgbDecodeExt, true),
    ("texture_border_color", TesterType::TextureBorderColor, true),
    (
        "texture_wrap_s_clamp_to_border",
        TesterType::TextureWrapSClampToBorder,
        true,
    ),
    (
        "texture_wrap_t_clamp_to_border",
        TesterType::TextureWrapTClampToBorder,
        true,
    ),
    (
        "texture_wrap_r_clamp_to_border",
        TesterType::TextureWrapRClampToBorder,
        true,
    ),
];

/// `pureSetters`
const PURE_SETTERS: [(&str, Setter); 2] = [("set_pure_int", Setter::PureInt), ("set_pure_uint", Setter::PureUint)];

/// `pureStates` - `texture_immutable_levels`/`texture_immutable_format` are not
/// settable, `texture_border_color` is already checked and
/// `texture_wrap_*_clamp_to_border` brings no additional coverage, so none of them are
/// here.
const PURE_STATES: [(&str, TesterType); 17] = [
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
    ("depth_stencil_mode", TesterType::DepthStencilTextureMode),
    ("texture_srgb_decode", TesterType::TextureSrgbDecodeExt),
];

/// The query each pure setter checks its own writes with.
fn pure_setter_verifier(setter: Setter) -> QueryType {
    match setter {
        Setter::PureInt => QueryType::TextureParamPureInteger,
        Setter::PureUint => QueryType::TextureParamPureUnsignedInteger,
        Setter::Default => panic!("not a pure setter"),
    }
}

/// `TextureStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");

    for (target_name, target, target_new_in_gles31) in TEXTURE_TARGETS {
        let mut target_group = TestCaseGroup::new(target_name);

        if target_new_in_gles31 {
            add_is_texture_test(&mut target_group, "is_texture".to_string(), target);
        }

        for (state_name, tester, state_new_in_gles31) in STATES {
            if !is_legal_tester_for_target(target, tester) {
                continue;
            }

            // for old targets, check only new states
            if !target_new_in_gles31 && !state_new_in_gles31 {
                continue;
            }

            // no need to cover for all getters if the only thing new is the param name
            let verifiers: &[QueryType] = if is_extended_param_query(tester) {
                &NON_PURE_VERIFIERS
            } else if is_vector_query(tester) {
                &VEC4_VERIFIERS
            } else {
                &SCALAR_VERIFIERS
            };

            for &verifier in verifiers {
                add_tex_param_test(
                    &mut target_group,
                    format!("{state_name}{}", verifier_suffix(verifier)),
                    verifier,
                    target,
                    tester,
                    Setter::Default,
                );
            }
        }

        group.add_child(target_group);
    }

    // set_pure_uint
    // set_pure_int
    for (setter_name, setter) in PURE_SETTERS {
        let mut target_group = TestCaseGroup::new(setter_name);

        for (state_name, tester) in PURE_STATES {
            // need 3d texture to test R wrap
            let target = if tester == TesterType::TextureWrapR {
                glw::GL_TEXTURE_3D
            } else {
                glw::GL_TEXTURE_2D
            };

            add_tex_param_test(
                &mut target_group,
                state_name.to_string(),
                pure_setter_verifier(setter),
                target,
                tester,
                setter,
            );
        }

        group.add_child(target_group);
    }

    group
}
