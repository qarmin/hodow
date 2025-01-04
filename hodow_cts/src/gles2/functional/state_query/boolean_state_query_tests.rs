// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fBooleanStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's four verifier classes
// are one enum here - they differ only in which `glGet*` they call and how the same
// boolean is spelled in that type, which is exactly what a match arm expresses. Every
// case is still registered once per verifier, under upstream's `_isenabled`,
// `_getboolean`, `_getinteger`, `_getfloat` suffixes.
//
// The point of the group: the same piece of state has to read back consistently
// through every query entry point the API offers. A driver that keeps its own shadow
// copy per getter - and embedded drivers do - disagrees with itself here.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};

/// Upstream's four `StateVerifier` subclasses.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Verifier {
    IsEnabled,
    GetBoolean,
    GetInteger,
    GetFloat,
}

/// The verifiers a state that can be enabled is checked through.
const IS_ENABLED_VERIFIERS: [Verifier; 4] = [
    Verifier::IsEnabled,
    Verifier::GetBoolean,
    Verifier::GetInteger,
    Verifier::GetFloat,
];
/// The verifiers everything else is checked through - `glIsEnabled` only answers for
/// enables, so it is not in this list.
const NORMAL_VERIFIERS: [Verifier; 3] = [Verifier::GetBoolean, Verifier::GetInteger, Verifier::GetFloat];

impl Verifier {
    /// `StateVerifier::getTestNamePostfix`
    fn postfix(self) -> &'static str {
        match self {
            Self::IsEnabled => "_isenabled",
            Self::GetBoolean => "_getboolean",
            Self::GetInteger => "_getinteger",
            Self::GetFloat => "_getfloat",
        }
    }

    /// `verifyBoolean`
    fn verify_boolean(self, case: &mut ApiCase<'_>, name: GLenum, reference: bool) {
        let gl = case.gl();
        match self {
            Self::IsEnabled => {
                // SAFETY: `name` is an enable this case owns; glIsEnabled writes nothing.
                let state = unsafe { gl.is_enabled(name) };
                let expected = if reference { glw::TRUE } else { glw::FALSE };
                if state != expected {
                    case.fail(
                        format!(
                            "expected {}, got {state}",
                            if reference { "GL_TRUE" } else { "GL_FALSE" }
                        ),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: the guarded buffer is one GLboolean, which is what this
                // pname writes; the guards on each side catch an overrun.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = if reference { glw::TRUE } else { glw::FALSE };
                if state.value() != expected {
                    case.fail(
                        format!(
                            "expected {}, got {}",
                            if reference { "GL_TRUE" } else { "GL_FALSE" },
                            state.value()
                        ),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: as above, for one GLint.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = i32::from(reference);
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected}, got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: as above, for one GLfloat.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = if reference { 1.0 } else { 0.0 };
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected}; got {}", state.value()),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyBoolean4`
    fn verify_boolean4(self, case: &mut ApiCase<'_>, name: GLenum, reference: [bool; 4]) {
        let gl = case.gl();
        match self {
            // Upstream asserts here: this verifier is only ever registered for the
            // enable states, which have no vector form.
            Self::IsEnabled => unreachable!("glIsEnabled has no four-component form"),
            Self::GetBoolean => {
                let mut state = Guarded::<[u8; 4]>::new();
                // SAFETY: the guarded buffer is four GLbooleans, the width of
                // GL_COLOR_WRITEMASK.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(|r| if r { glw::TRUE } else { glw::FALSE });
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected:?}, got {:?}", state.value()),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<[i32; 4]>::new();
                // SAFETY: as above, for four GLints.
                unsafe { gl.get_integerv(name, state.as_mut_ptr().cast::<i32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(i32::from);
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected:?}, got {:?}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<[f32; 4]>::new();
                // SAFETY: as above, for four GLfloats.
                unsafe { gl.get_floatv(name, state.as_mut_ptr().cast::<f32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(|r| if r { 1.0f32 } else { 0.0f32 });
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected:?}, got {:?}", state.value()),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyBooleanAnything` - the value is implementation-defined, so only that a
    /// value was written at all is checked.
    fn verify_boolean_anything(self, case: &mut ApiCase<'_>, name: GLenum) {
        let gl = case.gl();
        match self {
            Self::IsEnabled => unreachable!("glIsEnabled is not used for an implementation-defined boolean"),
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                state.verify_validity(case);
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                state.verify_validity(case);
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                state.verify_validity(case);
            }
        }
    }
}

/// `IsEnabledStateTestCase`
fn is_enabled_state(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, initial: bool) {
    let gl = case.gl();

    // The initial value.
    verifier.verify_boolean(case, target, initial);
    case.expect_error(glw::GL_NO_ERROR);

    // And that it follows glEnable/glDisable.
    // SAFETY: `target` is one of the enables listed in `create_tests`.
    unsafe { gl.enable(target) };
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_boolean(case, target, true);
    case.expect_error(glw::GL_NO_ERROR);

    unsafe { gl.disable(target) };
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_boolean(case, target, false);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `DepthWriteMaskTestCase`
fn depth_write_mask(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_boolean(case, glw::GL_DEPTH_WRITEMASK, true);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a state setter with a valid argument.
    unsafe { gl.depth_mask(glw::FALSE) };
    verifier.verify_boolean(case, glw::GL_DEPTH_WRITEMASK, false);
    case.expect_error(glw::GL_NO_ERROR);

    unsafe { gl.depth_mask(glw::TRUE) };
    verifier.verify_boolean(case, glw::GL_DEPTH_WRITEMASK, true);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `SampleCoverageInvertTestCase`
fn sample_coverage_invert(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_boolean(case, glw::GL_SAMPLE_COVERAGE_INVERT, false);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.sample_coverage(1.0, glw::TRUE) };
    verifier.verify_boolean(case, glw::GL_SAMPLE_COVERAGE_INVERT, true);
    case.expect_error(glw::GL_NO_ERROR);

    unsafe { gl.sample_coverage(1.0, glw::FALSE) };
    verifier.verify_boolean(case, glw::GL_SAMPLE_COVERAGE_INVERT, false);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ShaderCompilerTestCase` - whether there is a shader compiler is
/// implementation-defined, so only that the query answers at all is checked.
fn shader_compiler(case: &mut ApiCase<'_>, verifier: Verifier) {
    verifier.verify_boolean_anything(case, glw::GL_SHADER_COMPILER);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ColorMaskTestCase` - every one of the sixteen mask combinations.
fn color_mask(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_boolean4(case, glw::GL_COLOR_WRITEMASK, [true; 4]);
    case.expect_error(glw::GL_NO_ERROR);

    for mask in 0..16u32 {
        // Upstream lists the sixteen masks out longhand, most significant component
        // first; this generates the same sequence.
        let bits = [mask & 0x8 == 0, mask & 0x4 == 0, mask & 0x2 == 0, mask & 0x1 == 0];
        let as_gl = bits.map(|b| if b { glw::TRUE } else { glw::FALSE });

        // SAFETY: a state setter with valid arguments.
        unsafe { gl.color_mask(as_gl[0], as_gl[1], as_gl[2], as_gl[3]) };
        verifier.verify_boolean4(case, glw::GL_COLOR_WRITEMASK, bits);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `BooleanStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("boolean");

    // The states that can be enabled, with their initial value.
    let is_enableds: &[(&str, GLenum, bool)] = &[
        ("cull_face", glw::GL_CULL_FACE, false),
        ("polygon_offset_fill", glw::GL_POLYGON_OFFSET_FILL, false),
        ("sample_alpha_to_coverage", glw::GL_SAMPLE_ALPHA_TO_COVERAGE, false),
        ("sample_coverage", glw::GL_SAMPLE_COVERAGE, false),
        ("scissor_test", glw::GL_SCISSOR_TEST, false),
        ("stencil_test", glw::GL_STENCIL_TEST, false),
        ("depth_test", glw::GL_DEPTH_TEST, false),
        ("blend", glw::GL_BLEND, false),
        ("dither", glw::GL_DITHER, true),
    ];

    for (name, target, initial) in is_enableds {
        for verifier in IS_ENABLED_VERIFIERS {
            let (target, initial) = (*target, *initial);
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                is_enabled_state(case, verifier, target, initial);
            });
        }
    }

    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("sample_coverage_invert{}", verifier.postfix()),
            move |case| {
                sample_coverage_invert(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("color_writemask{}", verifier.postfix()),
            move |case| {
                color_mask(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("depth_writemask{}", verifier.postfix()),
            move |case| {
                depth_write_mask(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("shader_compiler{}", verifier.postfix()),
            move |case| {
                shader_compiler(case, verifier);
            },
        );
    }

    group
}
