// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fIntegerStateQueryTests.cpp
//   modules/glshared/glsStateQueryUtil.cpp (verifyStateInteger, for the binding cases)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's four verifier classes
// (and its four `QueryType`s, which carry the same suffixes) are one enum here,
// exactly as in the GLES2 sibling - ES 3.0 adds `_getinteger64` to ES 2.0's three.
//
// Two verification paths live here because upstream has two. The `StateVerifier` one
// is used by most cases. The *binding* cases use `gls::StateQueryUtil`'s
// `verifyStateInteger` instead, which differs in two ways that matter: it rejects a
// GLboolean that is neither GL_TRUE nor GL_FALSE, and it compares a float against the
// rounded-down/up pair of the reference rather than for equality.

use std::ffi::CString;

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLchar, GLenum, GLsizei, GLuint};
use crate::tcu::Random;

/// Three vendor enumerants upstream's generated `glwEnums.inl` does not carry, so the
/// generated `glw` does not either. Values from the extension specifications
/// (`GL_NV_sRGB_formats`, `GL_NV_bgr`).
const GL_SLUMINANCE_NV: i32 = 0x8C46;
const GL_SLUMINANCE_ALPHA_NV: i32 = 0x8C44;
const GL_BGR_NV: i32 = 0x80E0;

const TEST_VERT_SOURCE: &str = "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";
const TEST_FRAG_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

/// Upstream's four `StateVerifier` subclasses, which are also its four `QueryType`s.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Verifier {
    GetBoolean,
    GetInteger,
    GetInteger64,
    GetFloat,
}

/// All four, which is what almost every case is registered for.
const NORMAL_VERIFIERS: [Verifier; 4] = [
    Verifier::GetBoolean,
    Verifier::GetInteger,
    Verifier::GetInteger64,
    Verifier::GetFloat,
];
/// The three an implementation-defined limit is checked through: the limit's own value
/// has its own test elsewhere, so here only the conversions are interesting.
const LIMIT_VERIFIERS: [Verifier; 3] = [Verifier::GetBoolean, Verifier::GetInteger64, Verifier::GetFloat];

impl Verifier {
    fn postfix(self) -> &'static str {
        match self {
            Self::GetBoolean => "_getboolean",
            Self::GetInteger => "_getinteger",
            Self::GetInteger64 => "_getinteger64",
            Self::GetFloat => "_getfloat",
        }
    }

    /// `verifyInteger`
    fn verify_integer(self, case: &mut ApiCase<'_>, name: GLenum, reference: i32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out, with a guard on each side.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = if reference != 0 { glw::TRUE } else { glw::FALSE };
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected}; got {}", state.value()),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(
                        format!("expected {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != i64::from(reference) {
                    case.fail(
                        format!("expected {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                // Every reference an integer case uses has an exact float
                // representation, which is what upstream asserts here.
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(
                    clippy::cast_precision_loss,
                    reason = "upstream asserts the reference is exactly representable"
                )]
                let expected = reference as f32;
                if state.value() != expected {
                    case.fail(
                        format!("expected {expected}; got {}", state.value()),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyInteger4Mask`
    fn verify_integer4_mask(self, case: &mut ApiCase<'_>, name: GLenum, reference: [i32; 4], enable: [bool; 4]) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<[u8; 4]>::new();
                // SAFETY: four GLbooleans out, which is this state's width.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(|r| if r != 0 { glw::TRUE } else { glw::FALSE });
                let value = state.value();
                if (0..4).any(|i| enable[i] && value[i] != expected[i]) {
                    case.fail(
                        format!("expected {expected:?} (mask {enable:?}); got {value:?}"),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<[i32; 4]>::new();
                // SAFETY: four GLints out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr().cast::<i32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if (0..4).any(|i| enable[i] && value[i] != reference[i]) {
                    case.fail(
                        format!("expected {reference:?} (mask {enable:?}); got {value:?}"),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<[i64; 4]>::new();
                // SAFETY: four GLint64s out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr().cast::<i64>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(i64::from);
                let value = state.value();
                if (0..4).any(|i| enable[i] && value[i] != expected[i]) {
                    case.fail(
                        format!("expected {expected:?} (mask {enable:?}); got {value:?}"),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<[f32; 4]>::new();
                // SAFETY: four GLfloats out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr().cast::<f32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(clippy::cast_precision_loss, reason = "as in verify_integer")]
                let expected = reference.map(|r| r as f32);
                let value = state.value();
                if (0..4).any(|i| enable[i] && value[i] != expected[i]) {
                    case.fail(
                        format!("expected {expected:?} (mask {enable:?}); got {value:?}"),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyInteger4`
    fn verify_integer4(self, case: &mut ApiCase<'_>, name: GLenum, reference: [i32; 4]) {
        self.verify_integer4_mask(case, name, reference, [true; 4]);
    }

    /// `verifyIntegerGreaterOrEqual`
    fn verify_integer_greater_or_equal(self, case: &mut ApiCase<'_>, name: GLenum, reference: i32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                // GL_TRUE means non-zero, which may be anything at or above the
                // reference; GL_FALSE means zero, which is only enough when nothing
                // was required.
                if state.value() == glw::FALSE && reference > 0 {
                    case.fail(
                        format!("expected GL_TRUE (>= {reference}); got GL_FALSE"),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() < reference {
                    case.fail(
                        format!("expected at least {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() < i64::from(reference) {
                    case.fail(
                        format!("expected at least {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(clippy::cast_precision_loss, reason = "as in verify_integer")]
                let expected = reference as f32;
                if state.value() < expected {
                    case.fail(
                        format!("expected at least {expected}; got {}", state.value()),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyUnsignedIntegerGreaterOrEqual`
    fn verify_unsigned_integer_greater_or_equal(self, case: &mut ApiCase<'_>, name: GLenum, reference: u32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() == glw::FALSE && reference > 0 {
                    case.fail(
                        format!("expected GL_TRUE (>= {reference}); got GL_FALSE"),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if (state.value() as u32) < reference {
                    case.fail(
                        format!("expected at least {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                // Upstream narrows the queried value to GLuint before comparing.
                if (state.value() as u32) < reference {
                    case.fail(
                        format!("expected at least {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(clippy::cast_precision_loss, reason = "as in verify_integer")]
                let expected = reference as f32;
                if state.value() < expected {
                    case.fail(
                        format!("expected at least {expected}; got {}", state.value()),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyIntegerLessOrEqual`
    fn verify_integer_less_or_equal(self, case: &mut ApiCase<'_>, name: GLenum, reference: i32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if value == glw::TRUE {
                    return;
                }
                if value == glw::FALSE {
                    // Zero is only too large when the reference is negative.
                    if reference < 0 {
                        case.fail("expected GL_TRUE".to_string(), "Got invalid boolean value");
                    }
                } else {
                    case.fail("expected GL_TRUE or GL_FALSE".to_string(), "Got invalid boolean value");
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() > reference {
                    case.fail(
                        format!("expected at most {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() > i64::from(reference) {
                    case.fail(
                        format!("expected at most {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(clippy::cast_precision_loss, reason = "as in verify_integer")]
                let expected = reference as f32;
                if state.value() > expected {
                    case.fail(
                        format!("expected at most {expected}; got {}", state.value()),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyIntegerGreaterOrEqual2` - a two-component minimum, for
    /// GL_MAX_VIEWPORT_DIMS.
    fn verify_integer_greater_or_equal2(self, case: &mut ApiCase<'_>, name: GLenum, reference: [i32; 2]) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<[u8; 2]>::new();
                // SAFETY: two GLbooleans out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                for ndx in 0..2 {
                    if value[ndx] == glw::FALSE && reference[ndx] > 0 {
                        case.fail(
                            format!("expected GL_TRUE (>= {}) at {ndx}; got GL_FALSE", reference[ndx]),
                            "Got invalid boolean value",
                        );
                    }
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<[i32; 2]>::new();
                // SAFETY: two GLints out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr().cast::<i32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if value[0] < reference[0] || value[1] < reference[1] {
                    case.fail(
                        format!("expected at least {reference:?}; got {value:?}"),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<[i64; 2]>::new();
                // SAFETY: two GLint64s out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr().cast::<i64>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if value[0] < i64::from(reference[0]) || value[1] < i64::from(reference[1]) {
                    case.fail(
                        format!("expected at least {reference:?}; got {value:?}"),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<[f32; 2]>::new();
                // SAFETY: two GLfloats out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr().cast::<f32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                #[expect(clippy::cast_precision_loss, reason = "as in verify_integer")]
                let expected = reference.map(|r| r as f32);
                let value = state.value();
                if value[0] < expected[0] || value[1] < expected[1] {
                    case.fail(
                        format!("expected at least {expected:?}; got {value:?}"),
                        "Got invalid float value",
                    );
                }
            }
        }
    }

    /// `verifyIntegerAnyOf`
    fn verify_integer_any_of(self, case: &mut ApiCase<'_>, name: GLenum, references: &[i32]) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if references
                    .iter()
                    .any(|r| value == if *r != 0 { glw::TRUE } else { glw::FALSE })
                {
                    return;
                }
                case.fail(
                    format!("got {value}, which is none of {references:?}"),
                    "Got invalid boolean value",
                );
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if references.contains(&value) {
                    return;
                }
                case.fail(
                    format!("got {value}, which is none of {references:?}"),
                    "Got invalid integer value",
                );
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if references.iter().any(|r| value == i64::from(*r)) {
                    return;
                }
                case.fail(
                    format!("got {value}, which is none of {references:?}"),
                    "Got invalid integer value",
                );
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                #[expect(clippy::cast_precision_loss, reason = "as in verify_integer")]
                if references.iter().any(|r| value == *r as f32) {
                    return;
                }
                case.fail(
                    format!("got {value}, which is none of {references:?}"),
                    "Got invalid float value",
                );
            }
        }
    }

    /// `verifyStencilMaskInitial` - the initial mask has all the bits the framebuffer
    /// actually has, and nothing is required of the rest.
    fn verify_stencil_mask_initial(self, case: &mut ApiCase<'_>, name: GLenum, stencil_bits: i32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                // With no stencil bits the mask may read either way.
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if stencil_bits > 0 && state.value() != glw::TRUE {
                    case.fail(
                        format!("expected GL_TRUE; got {}", state.value()),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let reference = (1i32 << stencil_bits) - 1;
                if (state.value() & reference) != reference {
                    case.fail(
                        format!(
                            "expected the least significant {stencil_bits} bit(s) to be set; got {}",
                            state.value()
                        ),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let reference = (1i64 << stencil_bits) - 1;
                if (state.value() & reference) != reference {
                    case.fail(
                        format!(
                            "expected the least significant {stencil_bits} bit(s) to be set; got {}",
                            state.value()
                        ),
                        "Got invalid mask value",
                    );
                }
            }
            // Checking individual mask bits through a float makes no sense, so
            // upstream only asks for the minimum value.
            Self::GetFloat => {
                let reference = (1i32 << stencil_bits) - 1;
                self.verify_integer_greater_or_equal(case, name, reference);
            }
        }
    }

    /// `gls::StateQueryUtil::verifyStateInteger` - the binding cases' check. Unlike
    /// `verify_integer` it rejects a boolean that is neither GL_TRUE nor GL_FALSE, and
    /// accepts a float anywhere between the reference rounded down and rounded up.
    fn verify_state_integer(self, case: &mut ApiCase<'_>, name: GLenum, reference: i32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let value = state.value();
                if value != glw::TRUE && value != glw::FALSE {
                    case.fail(
                        format!("expected GL_TRUE or GL_FALSE; got {value}"),
                        "Got invalid boolean value",
                    );
                    return;
                }
                if (value == glw::TRUE) != (reference != 0) {
                    case.fail(
                        format!(
                            "expected {}; got {value}",
                            if reference != 0 { "GL_TRUE" } else { "GL_FALSE" }
                        ),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(
                        format!("expected {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != i64::from(reference) {
                    case.fail(
                        format!("expected {reference}; got {}", state.value()),
                        "Got invalid integer value",
                    );
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                // `deInt32ToFloatRoundToNegInf` / `...PosInf`: a reference that has no
                // exact float representation may be reported as either neighbour.
                #[expect(
                    clippy::cast_precision_loss,
                    reason = "the rounding is the point - both neighbours are accepted"
                )]
                let (min, max) = {
                    let exact = reference as f32;
                    if exact as i32 == reference {
                        (exact, exact)
                    } else if exact > reference as f32 {
                        (f32::from_bits(exact.to_bits() - 1), exact)
                    } else {
                        (exact, f32::from_bits(exact.to_bits() + 1))
                    }
                };
                let value = state.value();
                if value < min || value > max || value.is_nan() {
                    case.fail(
                        format!("expected {min}..={max}; got {value}"),
                        "Got invalid float value",
                    );
                }
            }
        }
    }
}

// --- the cases ---------------------------------------------------------------------

/// `ConstantMinimumValueTestCase`
fn constant_minimum_value(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, min_value: u32) {
    verifier.verify_unsigned_integer_greater_or_equal(case, target, min_value);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ConstantMaximumValueTestCase`
fn constant_maximum_value(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, max_value: i32) {
    verifier.verify_integer_less_or_equal(case, target, max_value);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `SampleBuffersTestCase`
fn sample_buffers(case: &mut ApiCase<'_>, verifier: Verifier) {
    let expected = i32::from(case.context().render_context.render_target().num_samples > 1);
    verifier.verify_integer(case, glw::GL_SAMPLE_BUFFERS, expected);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `SamplesTestCase`
fn samples(case: &mut ApiCase<'_>, verifier: Verifier) {
    let num_samples = case.context().render_context.render_target().num_samples;
    if num_samples > 1 {
        verifier.verify_integer(case, glw::GL_SAMPLES, num_samples);
    } else {
        // Not multisampled: the spec allows either.
        verifier.verify_integer_any_of(case, glw::GL_SAMPLES, &[0, 1]);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `HintTestCase`
fn hint(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    let gl = case.gl();

    verifier.verify_integer(case, target, glw::GL_DONT_CARE as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for value in [glw::GL_NICEST, glw::GL_FASTEST, glw::GL_DONT_CARE] {
        // SAFETY: a state setter with valid arguments.
        unsafe { gl.hint(target, value) };
        verifier.verify_integer(case, target, value as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `DepthFuncTestCase`
fn depth_func(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_integer(case, glw::GL_DEPTH_FUNC, glw::GL_LESS as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for func in [
        glw::GL_NEVER,
        glw::GL_ALWAYS,
        glw::GL_LESS,
        glw::GL_LEQUAL,
        glw::GL_EQUAL,
        glw::GL_GREATER,
        glw::GL_GEQUAL,
        glw::GL_NOTEQUAL,
    ] {
        // SAFETY: as above.
        unsafe { gl.depth_func(func) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_DEPTH_FUNC, func as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `CullFaceTestCase`
fn cull_face(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_integer(case, glw::GL_CULL_FACE_MODE, glw::GL_BACK as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for face in [glw::GL_FRONT, glw::GL_BACK, glw::GL_FRONT_AND_BACK] {
        // SAFETY: as above.
        unsafe { gl.cull_face(face) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_CULL_FACE_MODE, face as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `FrontFaceTestCase`
fn front_face(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_integer(case, glw::GL_FRONT_FACE, glw::GL_CCW as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for face in [glw::GL_CW, glw::GL_CCW] {
        // SAFETY: as above.
        unsafe { gl.front_face(face) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_FRONT_FACE, face as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ViewPortTestCase` - 120 random viewports.
fn viewport(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let target = case.context().render_context.render_target();
    let mut rnd = Random::new(0x00ab_cdef);

    let mut max_viewport_dimensions = [0i32; 2];
    // SAFETY: GL_MAX_VIEWPORT_DIMS writes two integers.
    unsafe { gl.get_integerv(glw::GL_MAX_VIEWPORT_DIMS, max_viewport_dimensions.as_mut_ptr()) };

    // With a viewport-array extension the origin is clamped to the bounds range
    // instead of being stored verbatim, so the expected value differs.
    let info = &case.context().context_info;
    let has_viewport_array = info.is_extension_supported("GL_OES_viewport_array")
        || info.is_extension_supported("GL_NV_viewport_array")
        || info.is_extension_supported("GL_ARB_viewport_array");
    let mut viewport_bounds_range = [0.0f32; 2];
    if has_viewport_array {
        // SAFETY: GL_VIEWPORT_BOUNDS_RANGE writes two floats, and the extension that
        // defines it is present.
        unsafe { gl.get_floatv(glw::GL_VIEWPORT_BOUNDS_RANGE, viewport_bounds_range.as_mut_ptr()) };
    }

    verifier.verify_integer4(case, glw::GL_VIEWPORT, [0, 0, target.width, target.height]);
    case.expect_error(glw::GL_NO_ERROR);

    for _ in 0..120 {
        let x = rnd.get_int(-64000, 64000);
        let y = rnd.get_int(-64000, 64000);
        let width = rnd.get_int(0, max_viewport_dimensions[0]);
        let height = rnd.get_int(0, max_viewport_dimensions[1]);

        // SAFETY: a state setter; the values are within the queried maxima.
        unsafe { gl.viewport(x, y, width, height) };

        if has_viewport_array {
            let low = viewport_bounds_range[0].floor() as i32;
            let high = viewport_bounds_range[1].floor() as i32;
            verifier.verify_integer4(
                case,
                glw::GL_VIEWPORT,
                [x.clamp(low, high), y.clamp(low, high), width, height],
            );
        } else {
            verifier.verify_integer4(case, glw::GL_VIEWPORT, [x, y, width, height]);
        }
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ScissorBoxTestCase` - 120 random boxes. Upstream only checks the origin of the
/// initial value, since the initial extents are the framebuffer's.
fn scissor_box(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    verifier.verify_integer4_mask(case, glw::GL_SCISSOR_BOX, [0, 0, 0, 0], [true, true, false, false]);
    case.expect_error(glw::GL_NO_ERROR);

    for _ in 0..120 {
        let left = rnd.get_int(-64000, 64000);
        let bottom = rnd.get_int(-64000, 64000);
        let width = rnd.get_int(0, 64000);
        let height = rnd.get_int(0, 64000);

        // SAFETY: a state setter with non-negative extents.
        unsafe { gl.scissor(left, bottom, width, height) };
        verifier.verify_integer4(case, glw::GL_SCISSOR_BOX, [left, bottom, width, height]);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `MaxViewportDimsTestCase`
fn max_viewport_dims(case: &mut ApiCase<'_>, verifier: Verifier) {
    let target = case.context().render_context.render_target();
    verifier.verify_integer_greater_or_equal2(case, glw::GL_MAX_VIEWPORT_DIMS, [target.width, target.height]);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `StencilRefTestCase`
fn stencil_ref(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    let gl = case.gl();
    verifier.verify_integer(case, target, 0);
    case.expect_error(glw::GL_NO_ERROR);

    let stencil_bits = case.context().render_context.render_target().stencil_bits;
    for bit in 0..stencil_bits {
        let reference = 1 << bit;
        // The mask must not affect the reference value, which is what the second call
        // checks.
        // SAFETY: a state setter with valid arguments.
        unsafe { gl.stencil_func(glw::GL_ALWAYS, reference, 0) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, reference);
        case.expect_error(glw::GL_NO_ERROR);

        unsafe { gl.stencil_func(glw::GL_ALWAYS, reference, reference as u32) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilRefSeparateTestCase`
fn stencil_ref_separate(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, face: GLenum) {
    let gl = case.gl();
    verifier.verify_integer(case, target, 0);
    case.expect_error(glw::GL_NO_ERROR);

    let stencil_bits = case.context().render_context.render_target().stencil_bits;
    for bit in 0..stencil_bits {
        let reference = 1 << bit;
        // SAFETY: as above.
        unsafe { gl.stencil_func_separate(face, glw::GL_ALWAYS, reference, 0) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, reference);
        case.expect_error(glw::GL_NO_ERROR);

        unsafe { gl.stencil_func_separate(face, glw::GL_ALWAYS, reference, reference as u32) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// The eight stencil operations, and which argument of `glStencilOp` each queried
/// state corresponds to.
fn set_stencil_op(case: &ApiCase<'_>, state: GLenum, value: GLenum, face: Option<GLenum>) {
    let gl = case.gl();
    let (sfail, dpfail, dppass) = match state {
        glw::GL_STENCIL_FAIL | glw::GL_STENCIL_BACK_FAIL => (value, glw::GL_KEEP, glw::GL_KEEP),
        glw::GL_STENCIL_PASS_DEPTH_FAIL | glw::GL_STENCIL_BACK_PASS_DEPTH_FAIL => (glw::GL_KEEP, value, glw::GL_KEEP),
        glw::GL_STENCIL_PASS_DEPTH_PASS | glw::GL_STENCIL_BACK_PASS_DEPTH_PASS => (glw::GL_KEEP, glw::GL_KEEP, value),
        other => unreachable!("{other:#x} is not a stencil-operation state"),
    };
    // SAFETY: a state setter with valid arguments.
    unsafe {
        match face {
            Some(face) => gl.stencil_op_separate(face, sfail, dpfail, dppass),
            None => gl.stencil_op(sfail, dpfail, dppass),
        }
    }
}

/// `StencilOpTestCase` / `StencilOpSeparateTestCase`
fn stencil_op(case: &mut ApiCase<'_>, verifier: Verifier, state: GLenum, face: Option<GLenum>) {
    verifier.verify_integer(case, state, glw::GL_KEEP as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for value in [
        glw::GL_KEEP,
        glw::GL_ZERO,
        glw::GL_REPLACE,
        glw::GL_INCR,
        glw::GL_DECR,
        glw::GL_INVERT,
        glw::GL_INCR_WRAP,
        glw::GL_DECR_WRAP,
    ] {
        set_stencil_op(case, state, value, face);
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, state, value as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// The eight stencil functions.
const STENCIL_FUNC_VALUES: [GLenum; 8] = [
    glw::GL_NEVER,
    glw::GL_ALWAYS,
    glw::GL_LESS,
    glw::GL_LEQUAL,
    glw::GL_EQUAL,
    glw::GL_GEQUAL,
    glw::GL_GREATER,
    glw::GL_NOTEQUAL,
];

/// `StencilFuncTestCase` - `glStencilFunc` sets both faces, so both states follow.
fn stencil_func(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_integer(case, glw::GL_STENCIL_FUNC, glw::GL_ALWAYS as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for func in STENCIL_FUNC_VALUES {
        // SAFETY: a state setter with valid arguments.
        unsafe { gl.stencil_func(func, 0, 0) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_STENCIL_FUNC, func as i32);
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_STENCIL_BACK_FUNC, func as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilFuncSeparateTestCase`
fn stencil_func_separate(case: &mut ApiCase<'_>, verifier: Verifier, state: GLenum, face: GLenum) {
    let gl = case.gl();
    verifier.verify_integer(case, state, glw::GL_ALWAYS as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for func in STENCIL_FUNC_VALUES {
        // SAFETY: as above.
        unsafe { gl.stencil_func_separate(face, func, 0, 0) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, state, func as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilMaskTestCase` - the *comparison* mask, set through `glStencilFunc`.
fn stencil_mask(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    let gl = case.gl();
    let stencil_bits = case.context().render_context.render_target().stencil_bits;

    verifier.verify_stencil_mask_initial(case, target, stencil_bits);
    case.expect_error(glw::GL_NO_ERROR);

    for bit in 0..stencil_bits {
        let mask = 1u32 << bit;
        // SAFETY: a state setter with valid arguments.
        unsafe { gl.stencil_func(glw::GL_ALWAYS, 0, mask) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, mask as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilMaskSeparateTestCase`
fn stencil_mask_separate(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, face: GLenum) {
    let gl = case.gl();
    let stencil_bits = case.context().render_context.render_target().stencil_bits;

    verifier.verify_stencil_mask_initial(case, target, stencil_bits);
    case.expect_error(glw::GL_NO_ERROR);

    for bit in 0..stencil_bits {
        let mask = 1u32 << bit;
        // SAFETY: as above.
        unsafe { gl.stencil_func_separate(face, glw::GL_ALWAYS, 0, mask) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, mask as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilWriteMaskTestCase` - the *write* mask, set through `glStencilMask`.
fn stencil_write_mask(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    let gl = case.gl();
    let stencil_bits = case.context().render_context.render_target().stencil_bits;

    for bit in 0..stencil_bits {
        let mask = 1u32 << bit;
        // SAFETY: a state setter.
        unsafe { gl.stencil_mask(mask) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, mask as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilWriteMaskSeparateTestCase`
fn stencil_write_mask_separate(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, face: GLenum) {
    let gl = case.gl();
    let stencil_bits = case.context().render_context.render_target().stencil_bits;

    for bit in 0..stencil_bits {
        let mask = 1u32 << bit;
        // SAFETY: as above.
        unsafe { gl.stencil_mask_separate(face, mask) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, mask as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `PixelStoreTestCase` - 120 random values, unlike the alignment states below.
fn pixel_store(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, initial_value: i32) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    verifier.verify_integer(case, target, initial_value);
    case.expect_error(glw::GL_NO_ERROR);

    for _ in 0..120 {
        let reference = rnd.get_int(0, 64000);
        // SAFETY: a state setter with a non-negative value.
        unsafe { gl.pixel_storei(target, reference) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `PixelStoreAlignTestCase`
fn pixel_store_align(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    let gl = case.gl();
    verifier.verify_integer(case, target, 4);
    case.expect_error(glw::GL_NO_ERROR);

    for alignment in [1, 2, 4, 8] {
        // SAFETY: a state setter with one of the four legal alignments.
        unsafe { gl.pixel_storei(target, alignment) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, alignment);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// The fifteen blend functions. Upstream does not skip GL_SRC_ALPHA_SATURATE for the
/// destination states here, unlike its ES 2.0 sibling - reproduced as written.
const BLEND_FUNC_VALUES: [GLenum; 15] = [
    glw::GL_ZERO,
    glw::GL_ONE,
    glw::GL_SRC_COLOR,
    glw::GL_ONE_MINUS_SRC_COLOR,
    glw::GL_DST_COLOR,
    glw::GL_ONE_MINUS_DST_COLOR,
    glw::GL_SRC_ALPHA,
    glw::GL_ONE_MINUS_SRC_ALPHA,
    glw::GL_DST_ALPHA,
    glw::GL_ONE_MINUS_DST_ALPHA,
    glw::GL_CONSTANT_COLOR,
    glw::GL_ONE_MINUS_CONSTANT_COLOR,
    glw::GL_CONSTANT_ALPHA,
    glw::GL_ONE_MINUS_CONSTANT_ALPHA,
    glw::GL_SRC_ALPHA_SATURATE,
];

/// `BlendFuncTestCase` / `BlendFuncSeparateTestCase`
fn blend_func(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, initial: GLenum, separate: bool) {
    let gl = case.gl();
    verifier.verify_integer(case, target, initial as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for func in BLEND_FUNC_VALUES {
        // SAFETY: a state setter with valid arguments.
        unsafe {
            if separate {
                match target {
                    glw::GL_BLEND_SRC_RGB => gl.blend_func_separate(func, glw::GL_ZERO, glw::GL_ZERO, glw::GL_ZERO),
                    glw::GL_BLEND_DST_RGB => gl.blend_func_separate(glw::GL_ZERO, func, glw::GL_ZERO, glw::GL_ZERO),
                    glw::GL_BLEND_SRC_ALPHA => gl.blend_func_separate(glw::GL_ZERO, glw::GL_ZERO, func, glw::GL_ZERO),
                    glw::GL_BLEND_DST_ALPHA => gl.blend_func_separate(glw::GL_ZERO, glw::GL_ZERO, glw::GL_ZERO, func),
                    other => unreachable!("{other:#x} is not a blend-function state"),
                }
            } else {
                match target {
                    glw::GL_BLEND_SRC_RGB | glw::GL_BLEND_SRC_ALPHA => gl.blend_func(func, glw::GL_ZERO),
                    glw::GL_BLEND_DST_RGB | glw::GL_BLEND_DST_ALPHA => gl.blend_func(glw::GL_ZERO, func),
                    other => unreachable!("{other:#x} is not a blend-function state"),
                }
            }
        }
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, func as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `BlendEquationTestCase` / `BlendEquationSeparateTestCase` - ES 3.0 adds GL_MIN and
/// GL_MAX to the three equations ES 2.0 has.
fn blend_equation(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, initial: GLenum, separate: bool) {
    let gl = case.gl();
    verifier.verify_integer(case, target, initial as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for equation in [
        glw::GL_FUNC_ADD,
        glw::GL_FUNC_SUBTRACT,
        glw::GL_FUNC_REVERSE_SUBTRACT,
        glw::GL_MIN,
        glw::GL_MAX,
    ] {
        // SAFETY: as above.
        unsafe {
            if separate {
                match target {
                    glw::GL_BLEND_EQUATION_RGB => gl.blend_equation_separate(equation, glw::GL_FUNC_ADD),
                    glw::GL_BLEND_EQUATION_ALPHA => gl.blend_equation_separate(glw::GL_FUNC_ADD, equation),
                    other => unreachable!("{other:#x} is not a blend-equation state"),
                }
            } else {
                gl.blend_equation(equation);
            }
        }
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, target, equation as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ImplementationArrayTestCase` - a list whose length is itself a queryable state.
fn implementation_array(
    case: &mut ApiCase<'_>,
    verifier: Verifier,
    target: GLenum,
    length_target: GLenum,
    min_value: i32,
) {
    let gl = case.gl();
    verifier.verify_integer_greater_or_equal(case, length_target, min_value);
    case.expect_error(glw::GL_NO_ERROR);

    let mut length = 0;
    // SAFETY: the length target writes one integer.
    unsafe { gl.get_integerv(length_target, &mut length) };
    case.expect_error(glw::GL_NO_ERROR);

    if length > 0 {
        let mut values = vec![0i32; length as usize];
        // SAFETY: the buffer holds as many entries as the driver just reported.
        unsafe { gl.get_integerv(target, values.as_mut_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `StencilClearValueTestCase`
fn stencil_clear_value(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_integer(case, glw::GL_STENCIL_CLEAR_VALUE, 0);
    case.expect_error(glw::GL_NO_ERROR);

    let stencil_bits = case.context().render_context.render_target().stencil_bits;
    for bit in 0..stencil_bits {
        let reference = 1 << bit;
        // SAFETY: a state setter.
        unsafe { gl.clear_stencil(reference) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_STENCIL_CLEAR_VALUE, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ActiveTextureTestCase`
fn active_texture(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_integer(case, glw::GL_ACTIVE_TEXTURE, glw::GL_TEXTURE0 as i32);
    case.expect_error(glw::GL_NO_ERROR);

    let mut texture_units = 0;
    // SAFETY: the limit writes one integer.
    unsafe { gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut texture_units) };
    case.expect_error(glw::GL_NO_ERROR);

    for ndx in 0..texture_units as u32 {
        // SAFETY: the unit is below the queried maximum.
        unsafe { gl.active_texture(glw::GL_TEXTURE0 + ndx) };
        case.expect_error(glw::GL_NO_ERROR);
        verifier.verify_integer(case, glw::GL_ACTIVE_TEXTURE, (glw::GL_TEXTURE0 + ndx) as i32);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ImplementationColorReadTestCase`
fn implementation_color_read(case: &mut ApiCase<'_>, verifier: Verifier) {
    // The set the specification defines, plus whatever the advertised extensions add.
    let mut valid_types = vec![
        glw::GL_UNSIGNED_BYTE as i32,
        glw::GL_BYTE as i32,
        glw::GL_UNSIGNED_SHORT as i32,
        glw::GL_SHORT as i32,
        glw::GL_UNSIGNED_INT as i32,
        glw::GL_INT as i32,
        glw::GL_HALF_FLOAT as i32,
        glw::GL_FLOAT as i32,
        glw::GL_UNSIGNED_SHORT_5_6_5 as i32,
        glw::GL_UNSIGNED_SHORT_4_4_4_4 as i32,
        glw::GL_UNSIGNED_SHORT_5_5_5_1 as i32,
        glw::GL_UNSIGNED_INT_2_10_10_10_REV as i32,
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV as i32,
    ];
    let mut valid_formats = vec![
        glw::GL_RGBA as i32,
        glw::GL_RGBA_INTEGER as i32,
        glw::GL_RGB as i32,
        glw::GL_RGB_INTEGER as i32,
        glw::GL_RG as i32,
        glw::GL_RG_INTEGER as i32,
        glw::GL_RED as i32,
        glw::GL_RED_INTEGER as i32,
    ];

    let info = &case.context().context_info;
    if info.is_extension_supported("GL_EXT_texture_format_BGRA8888")
        || info.is_extension_supported("GL_APPLE_texture_format_BGRA8888")
    {
        valid_formats.push(glw::GL_BGRA as i32);
    }
    if info.is_extension_supported("GL_EXT_read_format_bgra") {
        valid_formats.push(glw::GL_BGRA as i32);
        valid_types.push(glw::GL_UNSIGNED_SHORT_4_4_4_4_REV as i32);
        valid_types.push(glw::GL_UNSIGNED_SHORT_1_5_5_5_REV as i32);
    }
    if info.is_extension_supported("GL_IMG_read_format") {
        valid_formats.push(glw::GL_BGRA as i32);
        valid_types.push(glw::GL_UNSIGNED_SHORT_4_4_4_4_REV as i32);
    }
    if info.is_extension_supported("GL_NV_sRGB_formats") {
        valid_formats.push(GL_SLUMINANCE_NV);
        valid_formats.push(GL_SLUMINANCE_ALPHA_NV);
    }
    if info.is_extension_supported("GL_NV_bgr") {
        valid_formats.push(GL_BGR_NV);
    }

    verifier.verify_integer_any_of(case, glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &valid_types);
    verifier.verify_integer_any_of(case, glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &valid_formats);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ReadBufferCase` - the ES path throughout: the default read buffer is GL_BACK.
fn read_buffer(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let color_attachment = glw::GL_BACK;

    verifier.verify_integer_any_of(
        case,
        glw::GL_READ_BUFFER,
        &[color_attachment as i32, glw::GL_BACK as i32, glw::GL_NONE as i32],
    );
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a state setter with a legal read buffer for the default framebuffer.
    unsafe { gl.read_buffer(glw::GL_NONE) };
    verifier.verify_integer(case, glw::GL_READ_BUFFER, glw::GL_NONE as i32);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.read_buffer(color_attachment) };
    verifier.verify_integer(case, glw::GL_READ_BUFFER, color_attachment as i32);
    case.expect_error(glw::GL_NO_ERROR);

    let mut framebuffer = 0;
    // SAFETY: a fresh framebuffer name, deleted below.
    unsafe { gl.gen_framebuffers(1, &mut framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut renderbuffer = 0;
    // SAFETY: a fresh renderbuffer name, deleted below.
    unsafe { gl.gen_renderbuffers(1, &mut renderbuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the renderbuffer was just generated.
    unsafe { gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a colour-renderable sized format and a legal size.
    unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 128, 128) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, framebuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_renderbuffer(
            glw::GL_READ_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            renderbuffer,
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_integer(case, glw::GL_READ_BUFFER, glw::GL_COLOR_ATTACHMENT0 as i32);

    // Deleting the bound read framebuffer returns the default one, and with it the
    // default read buffer.
    // SAFETY: as above.
    unsafe {
        gl.delete_framebuffers(1, &framebuffer);
        gl.delete_renderbuffers(1, &renderbuffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_integer(case, glw::GL_READ_BUFFER, color_attachment as i32);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `DrawBufferCase`
fn draw_buffer(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    verifier.verify_integer_any_of(
        case,
        glw::GL_DRAW_BUFFER0,
        &[glw::GL_FRONT as i32, glw::GL_BACK as i32, glw::GL_NONE as i32],
    );
    case.expect_error(glw::GL_NO_ERROR);

    let mut bufs = glw::GL_NONE;
    // SAFETY: one buffer enum, which is the count passed.
    unsafe { gl.draw_buffers(1, &bufs) };
    verifier.verify_integer(case, glw::GL_DRAW_BUFFER0, glw::GL_NONE as i32);
    case.expect_error(glw::GL_NO_ERROR);

    bufs = glw::GL_BACK;
    // SAFETY: as above.
    unsafe { gl.draw_buffers(1, &bufs) };
    let valid_draw0 = [glw::GL_FRONT_LEFT as i32, glw::GL_BACK as i32];
    verifier.verify_integer_any_of(case, glw::GL_DRAW_BUFFER0, &valid_draw0);
    case.expect_error(glw::GL_NO_ERROR);

    let mut framebuffer = 0;
    // SAFETY: a fresh framebuffer name, deleted below.
    unsafe { gl.gen_framebuffers(1, &mut framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut renderbuffers = [0u32; 2];
    // SAFETY: two fresh renderbuffer names into a two-element array.
    unsafe { gl.gen_renderbuffers(2, renderbuffers.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);

    for renderbuffer in renderbuffers {
        // SAFETY: the name was just generated; a colour-renderable sized format.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 128, 128);
        }
        case.expect_error(glw::GL_NO_ERROR);
    }

    // SAFETY: every name here is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.framebuffer_renderbuffer(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            renderbuffers[0],
        );
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe {
        gl.framebuffer_renderbuffer(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT1,
            glw::GL_RENDERBUFFER,
            renderbuffers[1],
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    // Only the initial draw buffer for fragment colour zero is defined.
    verifier.verify_integer(case, glw::GL_DRAW_BUFFER0, glw::GL_COLOR_ATTACHMENT0 as i32);

    let buf_targets = [glw::GL_NONE, glw::GL_COLOR_ATTACHMENT1];
    // SAFETY: two buffer enums into a two-element list.
    unsafe { gl.draw_buffers(2, buf_targets.as_ptr()) };
    verifier.verify_integer(case, glw::GL_DRAW_BUFFER0, glw::GL_NONE as i32);
    verifier.verify_integer(case, glw::GL_DRAW_BUFFER1, glw::GL_COLOR_ATTACHMENT1 as i32);

    // SAFETY: as above.
    unsafe {
        gl.delete_framebuffers(1, &framebuffer);
        gl.delete_renderbuffers(2, renderbuffers.as_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_integer_any_of(case, glw::GL_DRAW_BUFFER0, &valid_draw0);
    case.expect_error(glw::GL_NO_ERROR);
}

// --- the binding cases -------------------------------------------------------------

/// `glShaderSource` with an owned source, since GL only borrows the pointer.
fn shader_source(case: &ApiCase<'_>, shader: GLuint, source: &str) {
    let owned = CString::new(source).expect("no interior nul");
    let pointer: *const GLchar = owned.as_ptr();
    // SAFETY: one live null-terminated string for the duration of the call; a null
    // `length` means "null-terminated".
    unsafe {
        case.gl()
            .shader_source(shader, 1 as GLsizei, &raw const pointer, std::ptr::null())
    };
}

/// `BufferBindingTestCase`
fn buffer_binding(case: &mut ApiCase<'_>, verifier: Verifier, binding_target: GLenum, buffer_target: GLenum) {
    let gl = case.gl();
    verifier.verify_state_integer(case, binding_target, 0);

    let mut buffer = 0;
    // SAFETY: every handle here is this case's own.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(buffer_target, buffer);
    }
    verifier.verify_state_integer(case, binding_target, buffer as i32);

    // SAFETY: as above.
    unsafe { gl.delete_buffers(1, &buffer) };
    verifier.verify_state_integer(case, binding_target, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ElementArrayBufferBindingTestCase` - the binding is per-VAO, which is the point.
fn element_array_buffer_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    case.section("Test with default VAO");
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, 0);

    let mut buffer = 0;
    // SAFETY: every handle here is this case's own.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buffer);
    }
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, buffer as i32);

    // SAFETY: as above.
    unsafe { gl.delete_buffers(1, &buffer) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, 0);

    case.section("Test with VAO");
    let mut vaos = [0u32; 2];
    let mut buffers = [0u32; 2];
    // SAFETY: two names into each two-element array.
    unsafe {
        gl.gen_vertex_arrays(2, vaos.as_mut_ptr());
        gl.gen_buffers(2, buffers.as_mut_ptr());
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the name was just generated.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, 0);

    // SAFETY: as above.
    unsafe { gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buffers[0]) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, buffers[0] as i32);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[1]) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, 0);

    // SAFETY: as above.
    unsafe { gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buffers[1]) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, buffers[1] as i32);

    // The first VAO kept its own binding.
    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, buffers[0] as i32);

    // Deleting clears the binding from the bound VAO ...
    // SAFETY: as above.
    unsafe { gl.delete_buffers(2, buffers.as_ptr()) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, 0);

    // ... but upstream expects the *unbound* VAO to still name the deleted buffer.
    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[1]) };
    verifier.verify_state_integer(case, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, buffers[1] as i32);

    // SAFETY: as above.
    unsafe { gl.delete_vertex_arrays(2, vaos.as_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `TransformFeedbackBindingTestCase`
fn transform_feedback_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    case.section("Initial");
    verifier.verify_state_integer(case, glw::GL_TRANSFORM_FEEDBACK_BINDING, 0);

    let mut transform_feedback = 0;
    // SAFETY: a fresh name, deleted below.
    unsafe { gl.gen_transform_feedbacks(1, &mut transform_feedback) };
    case.expect_error(glw::GL_NO_ERROR);

    case.section("Vertex Shader");
    // SAFETY: a fresh shader name.
    let shader_vert = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    shader_source(case, shader_vert, TEST_VERT_SOURCE);
    // SAFETY: the source was just set.
    unsafe { gl.compile_shader(shader_vert) };
    case.expect_error(glw::GL_NO_ERROR);
    let mut compile_status = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_shaderiv(shader_vert, glw::GL_COMPILE_STATUS, &mut compile_status) };
    case.check_booleans(compile_status, glw::TRUE);

    case.section("Fragment Shader");
    // SAFETY: as above.
    let shader_frag = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
    shader_source(case, shader_frag, TEST_FRAG_SOURCE);
    // SAFETY: as above.
    unsafe { gl.compile_shader(shader_frag) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_shaderiv(shader_frag, glw::GL_COMPILE_STATUS, &mut compile_status) };
    case.check_booleans(compile_status, glw::TRUE);

    case.section("Create and bind program");
    // SAFETY: a fresh program name, and both shaders are live.
    let shader_prog = unsafe { gl.create_program() };
    let varying = CString::new("gl_Position").expect("no interior nul");
    let varying_ptr: *const GLchar = varying.as_ptr();
    // SAFETY: one live null-terminated varying name for the duration of the call.
    unsafe {
        gl.attach_shader(shader_prog, shader_vert);
        gl.attach_shader(shader_prog, shader_frag);
        gl.transform_feedback_varyings(shader_prog, 1, &raw const varying_ptr, glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
    let mut link_status = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_programiv(shader_prog, glw::GL_LINK_STATUS, &mut link_status) };
    case.check_booleans(link_status, glw::TRUE);

    // SAFETY: the object was just generated.
    unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedback) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut feedback_buffer = 0;
    // SAFETY: a fresh buffer bound to the feedback binding point at index 0.
    unsafe {
        gl.gen_buffers(1, &mut feedback_buffer);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buffer);
        gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            16,
            std::ptr::null(),
            glw::GL_DYNAMIC_READ,
        );
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, feedback_buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the program linked successfully.
    unsafe { gl.use_program(shader_prog) };

    verifier.verify_state_integer(case, glw::GL_TRANSFORM_FEEDBACK_BINDING, transform_feedback as i32);

    // SAFETY: every name here is this case's own.
    unsafe {
        gl.use_program(0);
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        gl.delete_transform_feedbacks(1, &transform_feedback);
    }

    verifier.verify_state_integer(case, glw::GL_TRANSFORM_FEEDBACK_BINDING, 0);

    // SAFETY: as above.
    unsafe {
        gl.delete_buffers(1, &feedback_buffer);
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `CurrentProgramBindingTestCase` - built by hand rather than through
/// `glu::ShaderProgram`, because upstream checks the binding *while the program is
/// deleted but still in use*.
fn current_program_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();

    case.section("Initial");
    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, 0);

    case.section("Vertex Shader");
    // SAFETY: a fresh shader name.
    let shader_vert = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    shader_source(case, shader_vert, TEST_VERT_SOURCE);
    // SAFETY: the source was just set.
    unsafe { gl.compile_shader(shader_vert) };
    case.expect_error(glw::GL_NO_ERROR);
    let mut compile_status = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_shaderiv(shader_vert, glw::GL_COMPILE_STATUS, &mut compile_status) };
    case.check_booleans(compile_status, glw::TRUE);

    case.section("Fragment Shader");
    // SAFETY: as above.
    let shader_frag = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
    shader_source(case, shader_frag, TEST_FRAG_SOURCE);
    // SAFETY: as above.
    unsafe { gl.compile_shader(shader_frag) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_shaderiv(shader_frag, glw::GL_COMPILE_STATUS, &mut compile_status) };
    case.check_booleans(compile_status, glw::TRUE);

    case.section("Create and bind program");
    // SAFETY: a fresh program name, and both shaders are live.
    let shader_prog = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(shader_prog, shader_vert);
        gl.attach_shader(shader_prog, shader_frag);
        gl.link_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
    let mut link_status = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_programiv(shader_prog, glw::GL_LINK_STATUS, &mut link_status) };
    case.check_booleans(link_status, glw::TRUE);

    // SAFETY: the program linked successfully.
    unsafe { gl.use_program(shader_prog) };
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, shader_prog as i32);

    case.section("Delete program while in use");
    // A deleted-but-current program keeps naming itself until it is unbound, which is
    // the quirk this case exists for.
    // SAFETY: every name here is this case's own.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, shader_prog as i32);

    case.section("Unbind program");
    // SAFETY: unbinding is always legal.
    unsafe { gl.use_program(0) };
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, 0);
}

/// `VertexArrayBindingTestCase`
fn vertex_array_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_state_integer(case, glw::GL_VERTEX_ARRAY_BINDING, 0);

    let mut vao = 0;
    // SAFETY: a fresh name, deleted below.
    unsafe { gl.gen_vertex_arrays(1, &mut vao) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the name was just generated.
    unsafe { gl.bind_vertex_array(vao) };
    verifier.verify_state_integer(case, glw::GL_VERTEX_ARRAY_BINDING, vao as i32);

    // SAFETY: as above.
    unsafe { gl.delete_vertex_arrays(1, &vao) };
    verifier.verify_state_integer(case, glw::GL_VERTEX_ARRAY_BINDING, 0);
}

/// `RenderbufferBindingTestCase`
fn renderbuffer_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_state_integer(case, glw::GL_RENDERBUFFER_BINDING, 0);

    let mut renderbuffer = 0;
    // SAFETY: a fresh name, deleted below.
    unsafe {
        gl.gen_renderbuffers(1, &mut renderbuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
    }
    verifier.verify_state_integer(case, glw::GL_RENDERBUFFER_BINDING, renderbuffer as i32);

    // SAFETY: as above.
    unsafe { gl.delete_renderbuffers(1, &renderbuffer) };
    verifier.verify_state_integer(case, glw::GL_RENDERBUFFER_BINDING, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `SamplerObjectBindingTestCase` - the binding is per texture unit.
fn sampler_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_state_integer(case, glw::GL_SAMPLER_BINDING, 0);

    case.section("Single unit");
    let mut sampler = 0;
    // SAFETY: a fresh name, deleted below.
    unsafe {
        gl.gen_samplers(1, &mut sampler);
        gl.bind_sampler(0, sampler);
    }
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_state_integer(case, glw::GL_SAMPLER_BINDING, sampler as i32);

    // SAFETY: as above.
    unsafe { gl.delete_samplers(1, &sampler) };
    verifier.verify_state_integer(case, glw::GL_SAMPLER_BINDING, 0);

    case.section("Multiple units");
    let mut sampler_a = 0;
    let mut sampler_b = 0;
    // SAFETY: two fresh names, deleted below.
    unsafe {
        gl.gen_samplers(1, &mut sampler_a);
        gl.gen_samplers(1, &mut sampler_b);
        gl.bind_sampler(1, sampler_a);
        gl.bind_sampler(2, sampler_b);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // Unit 0 has no sampler bound, and it is still the active one.
    verifier.verify_state_integer(case, glw::GL_SAMPLER_BINDING, 0);

    // SAFETY: a unit that exists in every ES 3.0 implementation.
    unsafe { gl.active_texture(glw::GL_TEXTURE1) };
    verifier.verify_state_integer(case, glw::GL_SAMPLER_BINDING, sampler_a as i32);

    // SAFETY: as above.
    unsafe { gl.active_texture(glw::GL_TEXTURE2) };
    verifier.verify_state_integer(case, glw::GL_SAMPLER_BINDING, sampler_b as i32);

    // SAFETY: both names are this case's own.
    unsafe {
        gl.delete_samplers(1, &sampler_b);
        gl.delete_samplers(1, &sampler_a);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `TextureBindingTestCase`
fn texture_binding(case: &mut ApiCase<'_>, verifier: Verifier, binding_target: GLenum, texture_type: GLenum) {
    let gl = case.gl();
    verifier.verify_state_integer(case, binding_target, 0);

    let mut texture = 0;
    // SAFETY: a fresh name, deleted below.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(texture_type, texture);
    }
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_state_integer(case, binding_target, texture as i32);

    // SAFETY: as above.
    unsafe { gl.delete_textures(1, &texture) };
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_state_integer(case, binding_target, 0);
}

/// `FrameBufferBindingTestCase` - ES 3.0 has separate draw and read bindings, and
/// GL_FRAMEBUFFER_BINDING is an alias of the draw one.
fn framebuffer_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_state_integer(case, glw::GL_DRAW_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_READ_FRAMEBUFFER_BINDING, 0);

    let mut framebuffer = 0;
    // SAFETY: a fresh name, deleted below.
    unsafe { gl.gen_framebuffers(1, &mut framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: GL_FRAMEBUFFER binds both the draw and the read binding.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_state_integer(case, glw::GL_DRAW_FRAMEBUFFER_BINDING, framebuffer as i32);
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, framebuffer as i32);
    verifier.verify_state_integer(case, glw::GL_READ_FRAMEBUFFER_BINDING, framebuffer as i32);

    // SAFETY: unbinding is always legal.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_state_integer(case, glw::GL_DRAW_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_READ_FRAMEBUFFER_BINDING, 0);

    // SAFETY: the name is this case's own.
    unsafe { gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_state_integer(case, glw::GL_DRAW_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_READ_FRAMEBUFFER_BINDING, framebuffer as i32);

    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_state_integer(case, glw::GL_DRAW_FRAMEBUFFER_BINDING, framebuffer as i32);
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, framebuffer as i32);
    verifier.verify_state_integer(case, glw::GL_READ_FRAMEBUFFER_BINDING, framebuffer as i32);

    // Deleting a bound framebuffer unbinds it from both binding points.
    // SAFETY: as above.
    unsafe { gl.delete_framebuffers(1, &framebuffer) };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_state_integer(case, glw::GL_DRAW_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);
    verifier.verify_state_integer(case, glw::GL_READ_FRAMEBUFFER_BINDING, 0);
}

/// `IntegerStateQueryTests::init`, in upstream's order and under upstream's names.
#[expect(
    clippy::too_many_lines,
    reason = "one statement per upstream registration, kept in upstream's order"
)]
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("integers");

    // The limits with a specification-mandated minimum. Their own value is checked by
    // `implementation_limits`, so only the boolean, integer64 and float conversions
    // run here. The framebuffer bit-depth entries are `skipForGl`, which never
    // applies in an ES-only port.
    let implementation_min_limits: &[(&str, GLenum, u32)] = &[
        ("subpixel_bits", glw::GL_SUBPIXEL_BITS, 4),
        ("max_3d_texture_size", glw::GL_MAX_3D_TEXTURE_SIZE, 256),
        ("max_texture_size", glw::GL_MAX_TEXTURE_SIZE, 2048),
        ("max_array_texture_layers", glw::GL_MAX_ARRAY_TEXTURE_LAYERS, 256),
        ("max_cube_map_texture_size", glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE, 2048),
        ("max_renderbuffer_size", glw::GL_MAX_RENDERBUFFER_SIZE, 2048),
        ("max_draw_buffers", glw::GL_MAX_DRAW_BUFFERS, 4),
        ("max_color_attachments", glw::GL_MAX_COLOR_ATTACHMENTS, 4),
        ("max_elements_indices", glw::GL_MAX_ELEMENTS_INDICES, 0),
        ("max_elements_vertices", glw::GL_MAX_ELEMENTS_VERTICES, 0),
        ("num_extensions", glw::GL_NUM_EXTENSIONS, 0),
        ("major_version", glw::GL_MAJOR_VERSION, 3),
        ("minor_version", glw::GL_MINOR_VERSION, 0),
        ("max_vertex_attribs", glw::GL_MAX_VERTEX_ATTRIBS, 16),
        (
            "max_vertex_uniform_components",
            glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS,
            1024,
        ),
        ("max_vertex_uniform_vectors", glw::GL_MAX_VERTEX_UNIFORM_VECTORS, 256),
        ("max_vertex_uniform_blocks", glw::GL_MAX_VERTEX_UNIFORM_BLOCKS, 12),
        ("max_vertex_output_components", glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS, 64),
        (
            "max_vertex_texture_image_units",
            glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
            16,
        ),
        (
            "max_fragment_uniform_components",
            glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
            896,
        ),
        (
            "max_fragment_uniform_vectors",
            glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
            224,
        ),
        ("max_fragment_uniform_blocks", glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS, 12),
        (
            "max_fragment_input_components",
            glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS,
            60,
        ),
        ("max_texture_image_units", glw::GL_MAX_TEXTURE_IMAGE_UNITS, 16),
        ("max_program_texel_offset", glw::GL_MAX_PROGRAM_TEXEL_OFFSET, 7),
        ("max_uniform_buffer_bindings", glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, 24),
        ("max_combined_uniform_blocks", glw::GL_MAX_COMBINED_UNIFORM_BLOCKS, 24),
        ("max_varying_components", glw::GL_MAX_VARYING_COMPONENTS, 60),
        ("max_varying_vectors", glw::GL_MAX_VARYING_VECTORS, 15),
        (
            "max_combined_texture_image_units",
            glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
            32,
        ),
        (
            "max_transform_feedback_interleaved_components",
            glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
            64,
        ),
        (
            "max_transform_feedback_separate_attribs",
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
            4,
        ),
        (
            "max_transform_feedback_separate_components",
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
            4,
        ),
        ("max_samples", glw::GL_MAX_SAMPLES, 4),
        ("red_bits", glw::GL_RED_BITS, 0),
        ("green_bits", glw::GL_GREEN_BITS, 0),
        ("blue_bits", glw::GL_BLUE_BITS, 0),
        ("alpha_bits", glw::GL_ALPHA_BITS, 0),
        ("depth_bits", glw::GL_DEPTH_BITS, 0),
        ("stencil_bits", glw::GL_STENCIL_BITS, 0),
    ];
    for (name, target, min_value) in implementation_min_limits {
        let (target, min_value) = (*target, *min_value);
        for verifier in LIMIT_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                constant_minimum_value(case, verifier, target, min_value);
            });
        }
    }

    // The two limits with a mandated *maximum*. Upstream's second entry describes a
    // minimum but registers a maximum of 256, which is reproduced as written.
    let implementation_max_limits: &[(&str, GLenum, i32)] = &[
        ("min_program_texel_offset", glw::GL_MIN_PROGRAM_TEXEL_OFFSET, -8),
        (
            "uniform_buffer_offset_alignment",
            glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT,
            256,
        ),
    ];
    for (name, target, max_value) in implementation_max_limits {
        let (target, max_value) = (*target, *max_value);
        for verifier in LIMIT_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                constant_maximum_value(case, verifier, target, max_value);
            });
        }
    }

    for verifier in LIMIT_VERIFIERS {
        add_api_case(
            &mut group,
            format!("sample_buffers{}", verifier.postfix()),
            move |case| sample_buffers(case, verifier),
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("samples{}", verifier.postfix()), move |case| {
            samples(case, verifier)
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("generate_mipmap_hint{}", verifier.postfix()),
            move |case| {
                hint(case, verifier, glw::GL_GENERATE_MIPMAP_HINT);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("fragment_shader_derivative_hint{}", verifier.postfix()),
            move |case| {
                hint(case, verifier, glw::GL_FRAGMENT_SHADER_DERIVATIVE_HINT);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("depth_func{}", verifier.postfix()), move |case| {
            depth_func(case, verifier)
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("cull_face_mode{}", verifier.postfix()),
            move |case| cull_face(case, verifier),
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("front_face_mode{}", verifier.postfix()),
            move |case| front_face(case, verifier),
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("viewport{}", verifier.postfix()), move |case| {
            viewport(case, verifier)
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("scissor_box{}", verifier.postfix()), move |case| {
            scissor_box(case, verifier)
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("max_viewport_dims{}", verifier.postfix()),
            move |case| {
                max_viewport_dims(case, verifier);
            },
        );
    }

    // Stencil reference values.
    for (name, target) in [
        ("stencil_ref", glw::GL_STENCIL_REF),
        ("stencil_back_ref", glw::GL_STENCIL_BACK_REF),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_ref(case, verifier, target)
            });
        }
    }
    for (name, target, face) in [
        ("stencil_ref_separate", glw::GL_STENCIL_REF, glw::GL_FRONT),
        ("stencil_ref_separate_both", glw::GL_STENCIL_REF, glw::GL_FRONT_AND_BACK),
        ("stencil_back_ref_separate", glw::GL_STENCIL_BACK_REF, glw::GL_BACK),
        (
            "stencil_back_ref_separate_both",
            glw::GL_STENCIL_BACK_REF,
            glw::GL_FRONT_AND_BACK,
        ),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_ref_separate(case, verifier, target, face);
            });
        }
    }

    // Stencil operations - front and back, then each of the separate forms.
    let stencil_ops: &[(&str, GLenum, GLenum)] = &[
        ("fail", glw::GL_STENCIL_FAIL, glw::GL_STENCIL_BACK_FAIL),
        (
            "depth_fail",
            glw::GL_STENCIL_PASS_DEPTH_FAIL,
            glw::GL_STENCIL_BACK_PASS_DEPTH_FAIL,
        ),
        (
            "depth_pass",
            glw::GL_STENCIL_PASS_DEPTH_PASS,
            glw::GL_STENCIL_BACK_PASS_DEPTH_PASS,
        ),
    ];
    for (name, front, back) in stencil_ops {
        let (front, back) = (*front, *back);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("stencil_{name}{}", verifier.postfix()),
                move |case| {
                    stencil_op(case, verifier, front, None);
                },
            );
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("stencil_back_{name}{}", verifier.postfix()),
                move |case| {
                    stencil_op(case, verifier, back, None);
                },
            );
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("stencil_{name}_separate_both{}", verifier.postfix()),
                move |case| {
                    stencil_op(case, verifier, front, Some(glw::GL_FRONT_AND_BACK));
                },
            );
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("stencil_back_{name}_separate_both{}", verifier.postfix()),
                move |case| {
                    stencil_op(case, verifier, back, Some(glw::GL_FRONT_AND_BACK));
                },
            );
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("stencil_{name}_separate{}", verifier.postfix()),
                move |case| {
                    stencil_op(case, verifier, front, Some(glw::GL_FRONT));
                },
            );
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("stencil_back_{name}_separate{}", verifier.postfix()),
                move |case| {
                    stencil_op(case, verifier, back, Some(glw::GL_BACK));
                },
            );
        }
    }

    // Stencil functions.
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("stencil_func{}", verifier.postfix()), move |case| {
            stencil_func(case, verifier)
        });
    }
    for (name, target, face) in [
        ("stencil_func_separate", glw::GL_STENCIL_FUNC, glw::GL_FRONT),
        (
            "stencil_func_separate_both",
            glw::GL_STENCIL_FUNC,
            glw::GL_FRONT_AND_BACK,
        ),
        ("stencil_back_func_separate", glw::GL_STENCIL_BACK_FUNC, glw::GL_BACK),
        (
            "stencil_back_func_separate_both",
            glw::GL_STENCIL_BACK_FUNC,
            glw::GL_FRONT_AND_BACK,
        ),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_func_separate(case, verifier, target, face);
            });
        }
    }

    // Stencil comparison masks.
    for (name, target) in [
        ("stencil_value_mask", glw::GL_STENCIL_VALUE_MASK),
        ("stencil_back_value_mask", glw::GL_STENCIL_BACK_VALUE_MASK),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_mask(case, verifier, target)
            });
        }
    }
    for (name, target, face) in [
        ("stencil_value_mask_separate", glw::GL_STENCIL_VALUE_MASK, glw::GL_FRONT),
        (
            "stencil_value_mask_separate_both",
            glw::GL_STENCIL_VALUE_MASK,
            glw::GL_FRONT_AND_BACK,
        ),
        (
            "stencil_back_value_mask_separate",
            glw::GL_STENCIL_BACK_VALUE_MASK,
            glw::GL_BACK,
        ),
        (
            "stencil_back_value_mask_separate_both",
            glw::GL_STENCIL_BACK_VALUE_MASK,
            glw::GL_FRONT_AND_BACK,
        ),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_mask_separate(case, verifier, target, face);
            });
        }
    }

    // Stencil write masks.
    for (name, target) in [
        ("stencil_writemask", glw::GL_STENCIL_WRITEMASK),
        ("stencil_back_writemask", glw::GL_STENCIL_BACK_WRITEMASK),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_write_mask(case, verifier, target);
            });
        }
    }
    for (name, target, face) in [
        ("stencil_writemask_separate", glw::GL_STENCIL_WRITEMASK, glw::GL_FRONT),
        (
            "stencil_writemask_separate_both",
            glw::GL_STENCIL_WRITEMASK,
            glw::GL_FRONT_AND_BACK,
        ),
        (
            "stencil_back_writemask_separate",
            glw::GL_STENCIL_BACK_WRITEMASK,
            glw::GL_BACK,
        ),
        (
            "stencil_back_writemask_separate_both",
            glw::GL_STENCIL_BACK_WRITEMASK,
            glw::GL_FRONT_AND_BACK,
        ),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_write_mask_separate(case, verifier, target, face);
            });
        }
    }

    // The pixel-store states with an initial value of zero.
    let pixel_store_states: &[(&str, GLenum, i32)] = &[
        ("unpack_image_height", glw::GL_UNPACK_IMAGE_HEIGHT, 0),
        ("unpack_skip_images", glw::GL_UNPACK_SKIP_IMAGES, 0),
        ("unpack_row_length", glw::GL_UNPACK_ROW_LENGTH, 0),
        ("unpack_skip_rows", glw::GL_UNPACK_SKIP_ROWS, 0),
        ("unpack_skip_pixels", glw::GL_UNPACK_SKIP_PIXELS, 0),
        ("pack_row_length", glw::GL_PACK_ROW_LENGTH, 0),
        ("pack_skip_rows", glw::GL_PACK_SKIP_ROWS, 0),
        ("pack_skip_pixels", glw::GL_PACK_SKIP_PIXELS, 0),
    ];
    for (name, target, initial_value) in pixel_store_states {
        let (target, initial_value) = (*target, *initial_value);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                pixel_store(case, verifier, target, initial_value);
            });
        }
    }

    // Pixel store alignment.
    for (name, target) in [
        ("unpack_alignment", glw::GL_UNPACK_ALIGNMENT),
        ("pack_alignment", glw::GL_PACK_ALIGNMENT),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                pixel_store_align(case, verifier, target);
            });
        }
    }

    // Blend functions, plain and separate.
    let blend_states: &[(&str, GLenum, GLenum)] = &[
        ("blend_src_rgb", glw::GL_BLEND_SRC_RGB, glw::GL_ONE),
        ("blend_src_alpha", glw::GL_BLEND_SRC_ALPHA, glw::GL_ONE),
        ("blend_dst_rgb", glw::GL_BLEND_DST_RGB, glw::GL_ZERO),
        ("blend_dst_alpha", glw::GL_BLEND_DST_ALPHA, glw::GL_ZERO),
    ];
    for (name, target, initial) in blend_states {
        let (target, initial) = (*target, *initial);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                blend_func(case, verifier, target, initial, false);
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("{name}_separate{}", verifier.postfix()),
                move |case| {
                    blend_func(case, verifier, target, initial, true);
                },
            );
        }
    }

    // Blend equations, plain and separate.
    let blend_equation_states: &[(&str, GLenum, GLenum)] = &[
        ("blend_equation_rgb", glw::GL_BLEND_EQUATION_RGB, glw::GL_FUNC_ADD),
        ("blend_equation_alpha", glw::GL_BLEND_EQUATION_ALPHA, glw::GL_FUNC_ADD),
    ];
    for (name, target, initial) in blend_equation_states {
        let (target, initial) = (*target, *initial);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                blend_equation(case, verifier, target, initial, false);
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(
                &mut group,
                format!("{name}_separate{}", verifier.postfix()),
                move |case| {
                    blend_equation(case, verifier, target, initial, true);
                },
            );
        }
    }

    // The implementation-defined format lists.
    let implementation_arrays: &[(&str, GLenum, GLenum, i32)] = &[
        (
            "compressed_texture_formats",
            glw::GL_COMPRESSED_TEXTURE_FORMATS,
            glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS,
            10,
        ),
        (
            "program_binary_formats",
            glw::GL_PROGRAM_BINARY_FORMATS,
            glw::GL_NUM_PROGRAM_BINARY_FORMATS,
            0,
        ),
        (
            "shader_binary_formats",
            glw::GL_SHADER_BINARY_FORMATS,
            glw::GL_NUM_SHADER_BINARY_FORMATS,
            0,
        ),
    ];
    for (name, target, length_target, min_length) in implementation_arrays {
        let (target, length_target, min_length) = (*target, *length_target, *min_length);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                implementation_array(case, verifier, target, length_target, min_length);
            });
        }
    }

    // The bindings, which use `verifyStateInteger` rather than a `StateVerifier`.
    let buffer_bindings: &[(&str, GLenum, GLenum)] = &[
        (
            "array_buffer_binding",
            glw::GL_ARRAY_BUFFER_BINDING,
            glw::GL_ARRAY_BUFFER,
        ),
        (
            "uniform_buffer_binding",
            glw::GL_UNIFORM_BUFFER_BINDING,
            glw::GL_UNIFORM_BUFFER,
        ),
        (
            "pixel_pack_buffer_binding",
            glw::GL_PIXEL_PACK_BUFFER_BINDING,
            glw::GL_PIXEL_PACK_BUFFER,
        ),
        (
            "pixel_unpack_buffer_binding",
            glw::GL_PIXEL_UNPACK_BUFFER_BINDING,
            glw::GL_PIXEL_UNPACK_BUFFER,
        ),
        (
            "transform_feedback_buffer_binding",
            glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
        ),
        (
            "copy_read_buffer_binding",
            glw::GL_COPY_READ_BUFFER_BINDING,
            glw::GL_COPY_READ_BUFFER,
        ),
        (
            "copy_write_buffer_binding",
            glw::GL_COPY_WRITE_BUFFER_BINDING,
            glw::GL_COPY_WRITE_BUFFER,
        ),
    ];
    for (name, binding_target, buffer_target) in buffer_bindings {
        let (binding_target, buffer_target) = (*binding_target, *buffer_target);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                buffer_binding(case, verifier, binding_target, buffer_target);
            });
        }
    }

    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("element_array_buffer_binding{}", verifier.postfix()),
            move |case| {
                element_array_buffer_binding(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("transform_feedback_binding{}", verifier.postfix()),
            move |case| {
                transform_feedback_binding(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("current_program_binding{}", verifier.postfix()),
            move |case| {
                current_program_binding(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("vertex_array_binding{}", verifier.postfix()),
            move |case| {
                vertex_array_binding(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("stencil_clear_value{}", verifier.postfix()),
            move |case| {
                stencil_clear_value(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("active_texture{}", verifier.postfix()),
            move |case| active_texture(case, verifier),
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("renderbuffer_binding{}", verifier.postfix()),
            move |case| {
                renderbuffer_binding(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("sampler_binding{}", verifier.postfix()),
            move |case| sampler_binding(case, verifier),
        );
    }

    let texture_bindings: &[(&str, GLenum, GLenum)] = &[
        ("texture_binding_2d", glw::GL_TEXTURE_BINDING_2D, glw::GL_TEXTURE_2D),
        ("texture_binding_3d", glw::GL_TEXTURE_BINDING_3D, glw::GL_TEXTURE_3D),
        (
            "texture_binding_2d_array",
            glw::GL_TEXTURE_BINDING_2D_ARRAY,
            glw::GL_TEXTURE_2D_ARRAY,
        ),
        (
            "texture_binding_cube_map",
            glw::GL_TEXTURE_BINDING_CUBE_MAP,
            glw::GL_TEXTURE_CUBE_MAP,
        ),
    ];
    for (name, binding_target, texture_type) in texture_bindings {
        let (binding_target, texture_type) = (*binding_target, *texture_type);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                texture_binding(case, verifier, binding_target, texture_type);
            });
        }
    }

    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("framebuffer_binding{}", verifier.postfix()),
            move |case| {
                framebuffer_binding(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(
            &mut group,
            format!("implementation_color_read{}", verifier.postfix()),
            move |case| {
                implementation_color_read(case, verifier);
            },
        );
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("read_buffer{}", verifier.postfix()), move |case| {
            read_buffer(case, verifier)
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("draw_buffer{}", verifier.postfix()), move |case| {
            draw_buffer(case, verifier)
        });
    }

    group
}
