// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fBooleanStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::state_query_util::{QueryType, require_context_version, verify_state_boolean};
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};

/// `isEnabledVerifiers`
const IS_ENABLED_VERIFIERS: [QueryType; 5] = [
    QueryType::IsEnabled,
    QueryType::Boolean,
    QueryType::Integer,
    QueryType::Integer64,
    QueryType::Float,
];

/// `IsEnabledStateTestCase::iterate`
fn is_enabled_state_case(
    case: &mut ApiCase<'_>,
    target_name: GLenum,
    initial: bool,
    verifier: QueryType,
    min_version: (i32, i32),
) {
    if !require_context_version(case, min_version.0, min_version.1) {
        return;
    }

    verify_state_boolean(case, target_name, initial, verifier);

    // SAFETY: a capability enum the query above already accepted.
    unsafe { case.gl().enable(target_name) };
    case.expect_error(glw::GL_NO_ERROR);

    verify_state_boolean(case, target_name, true, verifier);

    // SAFETY: as above.
    unsafe { case.gl().disable(target_name) };
    case.expect_error(glw::GL_NO_ERROR);

    verify_state_boolean(case, target_name, false, verifier);
}

/// `StateBoolean isEnableds[]`. `debug_output`'s initial value is upstream's
/// `isDebugContext`, which is always false here - this port never asks for a debug
/// context.
const IS_ENABLEDS: [(&str, GLenum, bool, (i32, i32)); 4] = [
    ("sample_mask", glw::GL_SAMPLE_MASK, false, (3, 1)),
    ("sample_shading", glw::GL_SAMPLE_SHADING, false, (3, 2)),
    ("debug_output", glw::GL_DEBUG_OUTPUT, false, (3, 2)),
    (
        "debug_output_synchronous",
        glw::GL_DEBUG_OUTPUT_SYNCHRONOUS,
        false,
        (3, 2),
    ),
];

/// `BooleanStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("boolean");

    for (name, target, initial, min_version) in IS_ENABLEDS {
        for verifier in IS_ENABLED_VERIFIERS {
            add_api_case(
                &mut group,
                format!("{name}_{}", verifier.suffix()),
                move |case: &mut ApiCase<'_>| {
                    is_enabled_state_case(case, target, initial, verifier, min_version);
                },
            );
        }
    }

    group
}
