// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fSamplerStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::QueryType;
use crate::gls::texture_state_query_tests::{Setter, TesterType, add_sampler_param_test};
use crate::glu::TestCaseGroup;

/// `verifiers`
const VERIFIERS: [QueryType; 2] = [QueryType::SamplerParamInteger, QueryType::SamplerParamFloat];

/// `states`
const STATES: [(&str, TesterType); 9] = [
    ("sampler_texture_wrap_s", TesterType::TextureWrapS),
    ("sampler_texture_wrap_t", TesterType::TextureWrapT),
    ("sampler_texture_wrap_r", TesterType::TextureWrapR),
    ("sampler_texture_mag_filter", TesterType::TextureMagFilter),
    ("sampler_texture_min_filter", TesterType::TextureMinFilter),
    ("sampler_texture_min_lod", TesterType::TextureMinLod),
    ("sampler_texture_max_lod", TesterType::TextureMaxLod),
    ("sampler_texture_compare_mode", TesterType::TextureCompareMode),
    ("sampler_texture_compare_func", TesterType::TextureCompareFunc),
];

/// `getVerifierSuffix`
fn verifier_suffix(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::SamplerParamInteger => "_getsamplerparameteri",
        QueryType::SamplerParamFloat => "_getsamplerparameterf",
        other => panic!("{other:?} is not a sampler-parameter verifier"),
    }
}

/// `SamplerStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sampler");

    for (state_name, tester) in STATES {
        for verifier in VERIFIERS {
            add_sampler_param_test(
                &mut group,
                format!("{state_name}{}", verifier_suffix(verifier)),
                verifier,
                tester,
                Setter::Default,
            );
        }
    }

    group
}
