// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderMultisampleInterpolationStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gles31::functional::state_query::query_util::{QueryType, verify_state_float_max, verify_state_float_min, verify_state_integer_min};
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw;

/// `verifiers[]` - this file names them `get_boolean` rather than `getboolean`, and
/// registers them in a different order from the other state-query files.
const VERIFIERS: [(&str, QueryType); 4] = [
    ("get_boolean", QueryType::Boolean),
    ("get_integer", QueryType::Integer),
    ("get_float", QueryType::Float),
    ("get_integer64", QueryType::Integer64),
];

/// `InterpolationOffsetCase::init` / `FragmentInterpolationOffsetBitsCase::init`
fn check_support(case: &mut ApiCase<'_>) -> bool {
    if case.context().context_type().supports(3, 2) {
        return true;
    }
    if case.context().context_info.is_extension_supported("GL_OES_shader_multisample_interpolation") {
        return true;
    }
    case.not_supported("Test requires GL_OES_shader_multisample_interpolation extension");
    false
}

/// `InterpolationOffsetCase::iterate`, `TEST_MIN_OFFSET`
fn min_interpolation_offset(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case) {
        return;
    }
    verify_state_float_max(case, glw::GL_MIN_FRAGMENT_INTERPOLATION_OFFSET, -0.5, verifier);
}

/// `InterpolationOffsetCase::iterate`, `TEST_MAX_OFFSET`
fn max_interpolation_offset(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case) {
        return;
    }

    let mut fragment_interpolation_offset_bits = 0.0f32;
    // SAFETY: one GLfloat out.
    unsafe { case.gl().get_floatv(glw::GL_FRAGMENT_INTERPOLATION_OFFSET_BITS, &raw mut fragment_interpolation_offset_bits) };
    case.expect_no_error("glGetIntegerv");

    let ulp = 1.0 / 2.0f32.powf(fragment_interpolation_offset_bits);
    verify_state_float_min(case, glw::GL_MAX_FRAGMENT_INTERPOLATION_OFFSET, 0.5 - ulp, verifier);
}

/// `FragmentInterpolationOffsetBitsCase::iterate`
fn fragment_interpolation_offset_bits(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case) {
        return;
    }
    verify_state_integer_min(case, glw::GL_FRAGMENT_INTERPOLATION_OFFSET_BITS, 4, verifier);
}

/// `ShaderMultisampleInterpolationStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample_interpolation");

    let mut min_group = TestCaseGroup::new("min_fragment_interpolation_offset");
    for (name, verifier) in VERIFIERS {
        add_api_case(&mut min_group, name, move |case: &mut ApiCase<'_>| min_interpolation_offset(case, verifier));
    }
    group.add_child(min_group);

    let mut max_group = TestCaseGroup::new("max_fragment_interpolation_offset");
    for (name, verifier) in VERIFIERS {
        add_api_case(&mut max_group, name, move |case: &mut ApiCase<'_>| max_interpolation_offset(case, verifier));
    }
    group.add_child(max_group);

    let mut bits_group = TestCaseGroup::new("fragment_interpolation_offset_bits");
    for (name, verifier) in VERIFIERS {
        add_api_case(&mut bits_group, name, move |case: &mut ApiCase<'_>| fragment_interpolation_offset_bits(case, verifier));
    }
    group.add_child(bits_group);

    group
}
