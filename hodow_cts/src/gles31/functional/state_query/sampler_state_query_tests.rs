// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSamplerStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `set_value` registers only the states that are new in ES 3.1 - the rest is already
// tested in gles3 - so it is 14 cases, not the 34 the state table might suggest.

use crate::gls::state_query_util::QueryType;
use crate::gls::texture_state_query_tests::{Setter, TesterType, add_sampler_param_test};
use crate::glu::TestCaseGroup;

/// `scalarVerifiers`
const SCALAR_VERIFIERS: [QueryType; 4] = [
    QueryType::SamplerParamInteger,
    QueryType::SamplerParamFloat,
    QueryType::SamplerParamPureInteger,
    QueryType::SamplerParamPureUnsignedInteger,
];

/// `nonPureVerifiers`
const NON_PURE_VERIFIERS: [QueryType; 2] = [QueryType::SamplerParamInteger, QueryType::SamplerParamFloat];

/// `vectorVerifiers`
const VECTOR_VERIFIERS: [QueryType; 4] = [
    QueryType::SamplerParamIntegerVec4,
    QueryType::SamplerParamFloatVec4,
    QueryType::SamplerParamPureIntegerVec4,
    QueryType::SamplerParamPureUnsignedIntegerVec4,
];

/// `getVerifierSuffix`
fn verifier_suffix(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::SamplerParamFloat | QueryType::SamplerParamFloatVec4 => "_float",
        QueryType::SamplerParamInteger | QueryType::SamplerParamIntegerVec4 => "_integer",
        QueryType::SamplerParamPureInteger | QueryType::SamplerParamPureIntegerVec4 => "_pure_int",
        QueryType::SamplerParamPureUnsignedInteger | QueryType::SamplerParamPureUnsignedIntegerVec4 => "_pure_uint",
        other => panic!("{other:?} is not a sampler-parameter verifier"),
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

/// `states`
const STATES: [(&str, TesterType, bool); 14] = [
    ("texture_wrap_s", TesterType::TextureWrapS, false),
    ("texture_wrap_t", TesterType::TextureWrapT, false),
    ("texture_wrap_r", TesterType::TextureWrapR, false),
    ("texture_mag_filter", TesterType::TextureMagFilter, false),
    ("texture_min_filter", TesterType::TextureMinFilter, false),
    ("texture_min_lod", TesterType::TextureMinLod, false),
    ("texture_max_lod", TesterType::TextureMaxLod, false),
    ("texture_compare_mode", TesterType::TextureCompareMode, false),
    ("texture_compare_func", TesterType::TextureCompareFunc, false),
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

/// `pureStates` - `texture_border_color` is already checked and
/// `texture_wrap_*_clamp_to_border` brings no additional coverage.
const PURE_STATES: [(&str, TesterType); 10] = [
    ("texture_wrap_s", TesterType::TextureWrapS),
    ("texture_wrap_t", TesterType::TextureWrapT),
    ("texture_wrap_r", TesterType::TextureWrapR),
    ("texture_mag_filter", TesterType::TextureMagFilter),
    ("texture_min_filter", TesterType::TextureMinFilter),
    ("texture_min_lod", TesterType::TextureMinLod),
    ("texture_max_lod", TesterType::TextureMaxLod),
    ("texture_compare_mode", TesterType::TextureCompareMode),
    ("texture_compare_func", TesterType::TextureCompareFunc),
    ("texture_srgb_decode", TesterType::TextureSrgbDecodeExt),
];

/// The query each pure setter checks its own writes with.
fn pure_setter_verifier(setter: Setter) -> QueryType {
    match setter {
        Setter::PureInt => QueryType::SamplerParamPureInteger,
        Setter::PureUint => QueryType::SamplerParamPureUnsignedInteger,
        Setter::Default => panic!("not a pure setter"),
    }
}

/// `SamplerStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sampler");

    // set_value
    {
        let mut target_group = TestCaseGroup::new("set_value");

        for (state_name, tester, new_in_gles31) in STATES {
            // already tested in gles3
            if !new_in_gles31 {
                continue;
            }

            // no need to cover for all getters if the only thing new is the param name
            let verifiers: &[QueryType] = if is_extended_param_query(tester) {
                &NON_PURE_VERIFIERS
            } else if is_vector_query(tester) {
                &VECTOR_VERIFIERS
            } else {
                &SCALAR_VERIFIERS
            };

            for &verifier in verifiers {
                add_sampler_param_test(
                    &mut target_group,
                    format!("{state_name}{}", verifier_suffix(verifier)),
                    verifier,
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
            add_sampler_param_test(
                &mut target_group,
                state_name.to_string(),
                pure_setter_verifier(setter),
                tester,
                setter,
            );
        }

        group.add_child(target_group);
    }

    group
}
