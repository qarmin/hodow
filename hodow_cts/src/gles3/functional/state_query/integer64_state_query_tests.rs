// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fInteger64StateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's three verifier classes
// are one enum here, as in the sibling groups.
//
// Upstream's own note: the values are deliberately *not* checked through an
// integer64 verifier, because `implementation_limits` already does that.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum, GLint};

#[derive(Clone, Copy, PartialEq, Eq)]
#[expect(
    clippy::enum_variant_names,
    reason = "named after upstream's getBoolean/getInteger/getInteger64/getFloat verifiers"
)]
enum Verifier {
    GetBoolean,
    GetInteger,
    GetFloat,
}

const VERIFIERS: [Verifier; 3] = [Verifier::GetBoolean, Verifier::GetInteger, Verifier::GetFloat];

impl Verifier {
    fn postfix(self) -> &'static str {
        match self {
            Self::GetBoolean => "_getboolean",
            Self::GetInteger => "_getinteger",
            Self::GetFloat => "_getfloat",
        }
    }

    /// `verifyUnsignedInteger64GreaterOrEqual`
    fn verify_unsigned_integer64_greater_or_equal(self, case: &mut ApiCase<'_>, name: GLenum, reference: u64) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out, guarded on both sides.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                // Non-zero could be anything greater than the reference, which is fine.
                if state.value() == glw::TRUE {
                    return;
                }
                if state.value() == glw::FALSE {
                    if reference > 0 {
                        case.fail("expected GL_TRUE".to_string(), "Got invalid boolean value");
                    }
                } else {
                    case.fail("expected GL_TRUE or GL_FALSE".to_string(), "Got invalid boolean value");
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<GLint>::new();
                // SAFETY: one GLint out, guarded on both sides.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                // A reference beyond GLint's range says nothing after the conversion.
                if reference > i32::MAX as u64 {
                    return;
                }
                if (state.value() as u32) < reference as u32 {
                    case.fail(
                        format!("expected greater or equal to {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out, guarded on both sides.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() < reference as f32 {
                    case.fail(
                        format!(
                            "expected greater or equal to {}; got {}",
                            reference as f32,
                            state.value()
                        ),
                        "Got invalid float value",
                    );
                }
            }
        }
    }
}

/// `ConstantMinimumValue64TestCase`
fn constant_minimum_value64(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, min_value: u64) {
    verifier.verify_unsigned_integer64_greater_or_equal(case, target, min_value);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `MaxCombinedStageUniformComponentsCase`
fn max_combined_stage_uniform_components(
    case: &mut ApiCase<'_>,
    verifier: Verifier,
    target: GLenum,
    target_max_uniform_blocks: GLenum,
    target_max_uniform_components: GLenum,
) {
    let gl = case.gl();

    let mut uniform_block_size = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_MAX_UNIFORM_BLOCK_SIZE, &mut uniform_block_size) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut max_uniform_blocks = 0;
    let mut max_uniform_components = 0;
    // SAFETY: one GLint out each.
    unsafe {
        gl.get_integerv(target_max_uniform_blocks, &mut max_uniform_blocks);
        gl.get_integerv(target_max_uniform_components, &mut max_uniform_components);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // MAX_stage_UNIFORM_BLOCKS * MAX_UNIFORM_BLOCK_SIZE / 4 + MAX_stage_UNIFORM_COMPONENTS
    let min_combined_uniform_components =
        (max_uniform_blocks as u64) * (uniform_block_size as u64) / 4 + (max_uniform_components as u64);

    verifier.verify_unsigned_integer64_greater_or_equal(case, target, min_combined_uniform_components);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `Integer64StateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("integers64");

    const IMPLEMENTATION_LIMITS: [(&str, GLenum, u64); 3] = [
        ("max_element_index", glw::GL_MAX_ELEMENT_INDEX, 0x00FF_FFFF),
        ("max_server_wait_timeout", glw::GL_MAX_SERVER_WAIT_TIMEOUT, 0),
        ("max_uniform_block_size", glw::GL_MAX_UNIFORM_BLOCK_SIZE, 16384),
    ];

    for (name, target, min_value) in IMPLEMENTATION_LIMITS {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                constant_minimum_value64(case, verifier, target, min_value);
            });
        }
    }

    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("max_combined_vertex_uniform_components{}", verifier.postfix()),
            move |case| {
                max_combined_stage_uniform_components(
                    case,
                    verifier,
                    glw::GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
                    glw::GL_MAX_VERTEX_UNIFORM_BLOCKS,
                    glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS,
                );
            },
        );
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("max_combined_fragment_uniform_components{}", verifier.postfix()),
            move |case| {
                max_combined_stage_uniform_components(
                    case,
                    verifier,
                    glw::GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
                    glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS,
                    glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
                );
            },
        );
    }

    group
}
