// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fIntegerStateQueryTests.cpp
//   modules/glshared/glsStateQueryUtil.cpp (verifyStateInteger, for the binding cases)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's three verifier classes
// are one enum, as in the `boolean` group; every case is registered once per verifier
// under upstream's `_getboolean`, `_getinteger`, `_getfloat` suffixes.
//
// Two verification paths live here because upstream has two. The `StateVerifier` one
// is used by most cases. The seven *binding* cases use
// `gls::StateQueryUtil::verifyStateInteger` instead, which differs in two ways that
// matter: it rejects a `GLboolean` that is neither GL_TRUE nor GL_FALSE, and it
// compares a float against the rounded-down/up pair of the reference rather than for
// equality. Collapsing the two would change what those seven cases accept.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::Random;

/// Three vendor enumerants upstream's generated `glwEnums.inl` does not carry, so the
/// generated `glw` does not either. Values from the extension specifications
/// (`GL_NV_sRGB_formats`, `GL_NV_bgr`) - the cases below only ever compare against
/// them, and only on a driver that advertises the extension.
const GL_SLUMINANCE_NV: i32 = 0x8C46;
const GL_SLUMINANCE_ALPHA_NV: i32 = 0x8C44;
const GL_BGR_NV: i32 = 0x80E0;

/// Upstream's three `StateVerifier` subclasses, which are also its three `QueryType`s.
#[derive(Clone, Copy, PartialEq, Eq)]
#[expect(clippy::enum_variant_names, reason = "named after upstream's getBoolean/getInteger/getFloat verifiers")]
enum Verifier {
    GetBoolean,
    GetInteger,
    GetFloat,
}

/// All three, which is what almost every case is registered for.
const NORMAL_VERIFIERS: [Verifier; 3] = [Verifier::GetBoolean, Verifier::GetInteger, Verifier::GetFloat];
/// The two an implementation-defined limit is checked through: the limit's own value
/// has its own test elsewhere, so here only the conversions are interesting.
const LIMIT_VERIFIERS: [Verifier; 2] = [Verifier::GetBoolean, Verifier::GetFloat];

impl Verifier {
    fn postfix(self) -> &'static str {
        match self {
            Self::GetBoolean => "_getboolean",
            Self::GetInteger => "_getinteger",
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
                    case.fail(format!("expected {expected}; got {}", state.value()), "Got invalid boolean value");
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
                    case.fail(format!("expected {reference}; got {}", state.value()), "Got invalid integer value");
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
                #[expect(clippy::cast_precision_loss, reason = "upstream asserts the reference is exactly representable")]
                let expected = reference as f32;
                if state.value() != expected {
                    case.fail(format!("expected {expected}; got {}", state.value()), "Got invalid float value");
                }
            }
        }
    }

    /// `verifyInteger4Mask` - a four-component state where some components are not
    /// checked (the viewport's width and height are, its origin may be clamped).
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
                    case.fail(format!("expected {expected:?} (mask {enable:?}); got {value:?}"), "Got invalid boolean value");
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
                    case.fail(format!("expected {reference:?} (mask {enable:?}); got {value:?}"), "Got invalid integer value");
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
                    case.fail(format!("expected {expected:?} (mask {enable:?}); got {value:?}"), "Got invalid float value");
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
                    case.fail(format!("expected GL_TRUE (>= {reference}); got GL_FALSE"), "Got invalid boolean value");
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
                    case.fail(format!("expected at least {reference}; got {}", state.value()), "Got invalid integer value");
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
                    case.fail(format!("expected at least {expected}; got {}", state.value()), "Got invalid float value");
                }
            }
        }
    }

    /// `verifyUnsignedIntegerGreaterOrEqual` - the same, for a limit whose reference
    /// does not fit a signed comparison.
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
                    case.fail(format!("expected GL_TRUE (>= {reference}); got GL_FALSE"), "Got invalid boolean value");
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
                    case.fail(format!("expected at least {reference}; got {}", state.value()), "Got invalid integer value");
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
                    case.fail(format!("expected at least {expected}; got {}", state.value()), "Got invalid float value");
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
                        case.fail(format!("expected GL_TRUE (>= {}) at {ndx}; got GL_FALSE", reference[ndx]), "Got invalid boolean value");
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
                    case.fail(format!("expected at least {reference:?}; got {value:?}"), "Got invalid integer value");
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
                    case.fail(format!("expected at least {expected:?}; got {value:?}"), "Got invalid float value");
                }
            }
        }
    }

    /// `verifyIntegerAnyOf` - the state is implementation-defined but must be one of
    /// a known set.
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
                if references.iter().any(|r| value == if *r != 0 { glw::TRUE } else { glw::FALSE }) {
                    return;
                }
                case.fail(format!("got {value}, which is none of {references:?}"), "Got invalid boolean value");
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
                case.fail(format!("got {value}, which is none of {references:?}"), "Got invalid integer value");
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
                case.fail(format!("got {value}, which is none of {references:?}"), "Got invalid float value");
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
                    case.fail(format!("expected GL_TRUE; got {}", state.value()), "Got invalid boolean value");
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
                        format!("expected the least significant {stencil_bits} bit(s) to be set; got {}", state.value()),
                        "Got invalid integer value",
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
                    case.fail(format!("expected GL_TRUE or GL_FALSE; got {value}"), "Got invalid boolean value");
                    return;
                }
                if (value == glw::TRUE) != (reference != 0) {
                    case.fail(
                        format!("expected {}; got {value}", if reference != 0 { "GL_TRUE" } else { "GL_FALSE" }),
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
                    case.fail(format!("expected {reference}; got {}", state.value()), "Got invalid integer value");
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
                #[expect(clippy::cast_precision_loss, reason = "the rounding is the point - both neighbours are accepted")]
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
                    case.fail(format!("expected {min}..={max}; got {value}"), "Got invalid float value");
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
    let has_viewport_array = info.is_extension_supported("GL_OES_viewport_array") || info.is_extension_supported("GL_NV_viewport_array");
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
            verifier.verify_integer4(case, glw::GL_VIEWPORT, [x.clamp(low, high), y.clamp(low, high), width, height]);
        } else {
            verifier.verify_integer4(case, glw::GL_VIEWPORT, [x, y, width, height]);
        }
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ScissorBoxTestCase` - 120 random boxes.
fn scissor_box(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let target = case.context().render_context.render_target();
    let mut rnd = Random::new(0x00ab_cdef);

    verifier.verify_integer4(case, glw::GL_SCISSOR_BOX, [0, 0, target.width, target.height]);
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

/// The fifteen blend functions.
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
        // GL_SRC_ALPHA_SATURATE is only allowed as a source factor.
        if func == glw::GL_SRC_ALPHA_SATURATE && !(target == glw::GL_BLEND_SRC_RGB || target == glw::GL_BLEND_SRC_ALPHA) {
            continue;
        }

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

/// `BlendEquationTestCase` / `BlendEquationSeparateTestCase`
fn blend_equation(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, initial: GLenum, separate: bool) {
    let gl = case.gl();
    verifier.verify_integer(case, target, initial as i32);
    case.expect_error(glw::GL_NO_ERROR);

    for equation in [glw::GL_FUNC_ADD, glw::GL_FUNC_SUBTRACT, glw::GL_FUNC_REVERSE_SUBTRACT] {
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
fn implementation_array(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, length_target: GLenum, min_value: i32) {
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
        glw::GL_UNSIGNED_SHORT_4_4_4_4 as i32,
        glw::GL_UNSIGNED_SHORT_5_5_5_1 as i32,
        glw::GL_UNSIGNED_SHORT_5_6_5 as i32,
    ];
    let mut valid_formats = vec![glw::GL_RGBA as i32, glw::GL_RGB as i32, glw::GL_ALPHA as i32];

    let info = &case.context().context_info;
    if info.is_extension_supported("GL_EXT_texture_format_BGRA8888") || info.is_extension_supported("GL_APPLE_texture_format_BGRA8888") {
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
    if info.is_extension_supported("GL_EXT_texture_rg") {
        valid_formats.push(glw::GL_RED as i32);
        valid_formats.push(glw::GL_RG as i32);
    }

    verifier.verify_integer_any_of(case, glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &valid_types);
    verifier.verify_integer_any_of(case, glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &valid_formats);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `BufferComponentSizeCase` - the framebuffer's own bit depths.
fn buffer_component_size(case: &mut ApiCase<'_>, verifier: Verifier) {
    let target = case.context().render_context.render_target();

    verifier.verify_integer_greater_or_equal(case, glw::GL_RED_BITS, target.red_bits);
    verifier.verify_integer_greater_or_equal(case, glw::GL_BLUE_BITS, target.blue_bits);
    verifier.verify_integer_greater_or_equal(case, glw::GL_GREEN_BITS, target.green_bits);
    verifier.verify_integer_greater_or_equal(case, glw::GL_ALPHA_BITS, target.alpha_bits);
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_integer_greater_or_equal(case, glw::GL_DEPTH_BITS, target.depth_bits);
    verifier.verify_integer_greater_or_equal(case, glw::GL_STENCIL_BITS, target.stencil_bits);
    case.expect_error(glw::GL_NO_ERROR);
}

// --- the binding cases -------------------------------------------------------------

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

    unsafe { gl.delete_buffers(1, &buffer) };
    verifier.verify_state_integer(case, binding_target, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `CurrentProgramBindingTestCase`
fn current_program_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    const VERTEX_SOURCE: &str = "void main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";
    const FRAGMENT_SOURCE: &str = "void main (void)\n{\n    gl_FragColor = vec4(0.0);\n}\n";

    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, 0);

    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, FRAGMENT_SOURCE));
    if !program.is_ok() {
        case.fail("the program did not build".to_string(), "Failed to build program");
        return;
    }

    // SAFETY: the handle is this case's own.
    unsafe { gl.use_program(program.program()) };
    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, program.program() as i32);

    unsafe { gl.use_program(0) };
    verifier.verify_state_integer(case, glw::GL_CURRENT_PROGRAM, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `RenderbufferBindingTestCase`
fn renderbuffer_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_state_integer(case, glw::GL_RENDERBUFFER_BINDING, 0);

    let mut renderbuffer = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_renderbuffers(1, &mut renderbuffer);
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
    }
    verifier.verify_state_integer(case, glw::GL_RENDERBUFFER_BINDING, renderbuffer as i32);

    unsafe { gl.delete_renderbuffers(1, &renderbuffer) };
    verifier.verify_state_integer(case, glw::GL_RENDERBUFFER_BINDING, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `TextureBindingTestCase`
fn texture_binding(case: &mut ApiCase<'_>, verifier: Verifier, binding_target: GLenum, texture_type: GLenum) {
    let gl = case.gl();
    verifier.verify_state_integer(case, binding_target, 0);

    let mut texture = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(texture_type, texture);
    }
    verifier.verify_state_integer(case, binding_target, texture as i32);

    unsafe { gl.delete_textures(1, &texture) };
    verifier.verify_state_integer(case, binding_target, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `FrameBufferBindingTestCase`
fn framebuffer_binding(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);

    let mut framebuffer = 0;
    // SAFETY: as above.
    unsafe {
        gl.gen_framebuffers(1, &mut framebuffer);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
    }
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, framebuffer as i32);

    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);

    // Deleting the framebuffer while it is bound unbinds it, which is the point.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
        gl.delete_framebuffers(1, &framebuffer);
    }
    verifier.verify_state_integer(case, glw::GL_FRAMEBUFFER_BINDING, 0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `IntegerStateQueryTests::init`, in upstream's order and under upstream's names.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("integers");

    // The limits with a specification-mandated minimum. Their own value is checked by
    // `implementation_limits`, so only the boolean and float conversions run here.
    let implementation_min_limits: &[(&str, GLenum, u32)] = &[
        ("subpixel_bits", glw::GL_SUBPIXEL_BITS, 4),
        ("max_texture_size", glw::GL_MAX_TEXTURE_SIZE, 64),
        ("max_cube_map_texture_size", glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE, 16),
        ("max_vertex_attribs", glw::GL_MAX_VERTEX_ATTRIBS, 8),
        ("max_vertex_uniform_vectors", glw::GL_MAX_VERTEX_UNIFORM_VECTORS, 128),
        ("max_varying_vectors", glw::GL_MAX_VARYING_VECTORS, 8),
        ("max_combined_texture_image_units", glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, 8),
        ("max_vertex_texture_image_units", glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, 0),
        ("max_texture_image_units", glw::GL_MAX_TEXTURE_IMAGE_UNITS, 8),
        ("max_fragment_uniform_vectors", glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS, 16),
        ("max_renderbuffer_size", glw::GL_MAX_RENDERBUFFER_SIZE, 1),
    ];
    for (name, target, min_value) in implementation_min_limits {
        for verifier in LIMIT_VERIFIERS {
            let (target, min_value) = (*target, *min_value);
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                constant_minimum_value(case, verifier, target, min_value);
            });
        }
    }

    for verifier in LIMIT_VERIFIERS {
        add_api_case(&mut group, format!("sample_buffers{}", verifier.postfix()), move |case| sample_buffers(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("samples{}", verifier.postfix()), move |case| samples(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("generate_mipmap_hint{}", verifier.postfix()), move |case| {
            hint(case, verifier, glw::GL_GENERATE_MIPMAP_HINT);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("depth_func{}", verifier.postfix()), move |case| depth_func(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("cull_face_mode{}", verifier.postfix()), move |case| cull_face(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("front_face_mode{}", verifier.postfix()), move |case| front_face(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("viewport{}", verifier.postfix()), move |case| viewport(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("scissor_box{}", verifier.postfix()), move |case| scissor_box(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("max_viewport_dims{}", verifier.postfix()), move |case| {
            max_viewport_dims(case, verifier)
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("buffer_component_size{}", verifier.postfix()), move |case| {
            buffer_component_size(case, verifier);
        });
    }

    // Stencil reference values.
    for (name, target) in [("stencil_ref", glw::GL_STENCIL_REF), ("stencil_back_ref", glw::GL_STENCIL_BACK_REF)] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| stencil_ref(case, verifier, target));
        }
    }
    for (name, target, face) in [
        ("stencil_ref_separate", glw::GL_STENCIL_REF, glw::GL_FRONT),
        ("stencil_ref_separate_both", glw::GL_STENCIL_REF, glw::GL_FRONT_AND_BACK),
        ("stencil_back_ref_separate", glw::GL_STENCIL_BACK_REF, glw::GL_BACK),
        ("stencil_back_ref_separate_both", glw::GL_STENCIL_BACK_REF, glw::GL_FRONT_AND_BACK),
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
        ("depth_fail", glw::GL_STENCIL_PASS_DEPTH_FAIL, glw::GL_STENCIL_BACK_PASS_DEPTH_FAIL),
        ("depth_pass", glw::GL_STENCIL_PASS_DEPTH_PASS, glw::GL_STENCIL_BACK_PASS_DEPTH_PASS),
    ];
    for (name, front, back) in stencil_ops {
        let (front, back) = (*front, *back);
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("stencil_{name}{}", verifier.postfix()), move |case| {
                stencil_op(case, verifier, front, None);
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("stencil_back_{name}{}", verifier.postfix()), move |case| {
                stencil_op(case, verifier, back, None);
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("stencil_{name}_separate_both{}", verifier.postfix()), move |case| {
                stencil_op(case, verifier, front, Some(glw::GL_FRONT_AND_BACK));
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("stencil_back_{name}_separate_both{}", verifier.postfix()), move |case| {
                stencil_op(case, verifier, back, Some(glw::GL_FRONT_AND_BACK));
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("stencil_{name}_separate{}", verifier.postfix()), move |case| {
                stencil_op(case, verifier, front, Some(glw::GL_FRONT));
            });
        }
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("stencil_back_{name}_separate{}", verifier.postfix()), move |case| {
                stencil_op(case, verifier, back, Some(glw::GL_BACK));
            });
        }
    }

    // Stencil functions.
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("stencil_func{}", verifier.postfix()), move |case| stencil_func(case, verifier));
    }
    for (name, target, face) in [
        ("stencil_func_separate", glw::GL_STENCIL_FUNC, glw::GL_FRONT),
        ("stencil_func_separate_both", glw::GL_STENCIL_FUNC, glw::GL_FRONT_AND_BACK),
        ("stencil_back_func_separate", glw::GL_STENCIL_BACK_FUNC, glw::GL_BACK),
        ("stencil_back_func_separate_both", glw::GL_STENCIL_BACK_FUNC, glw::GL_FRONT_AND_BACK),
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
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| stencil_mask(case, verifier, target));
        }
    }
    for (name, target, face) in [
        ("stencil_value_mask_separate", glw::GL_STENCIL_VALUE_MASK, glw::GL_FRONT),
        ("stencil_value_mask_separate_both", glw::GL_STENCIL_VALUE_MASK, glw::GL_FRONT_AND_BACK),
        ("stencil_back_value_mask_separate", glw::GL_STENCIL_BACK_VALUE_MASK, glw::GL_BACK),
        ("stencil_back_value_mask_separate_both", glw::GL_STENCIL_BACK_VALUE_MASK, glw::GL_FRONT_AND_BACK),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_mask_separate(case, verifier, target, face);
            });
        }
    }

    // Stencil write masks.
    for (name, target) in [("stencil_writemask", glw::GL_STENCIL_WRITEMASK), ("stencil_back_writemask", glw::GL_STENCIL_BACK_WRITEMASK)] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_write_mask(case, verifier, target);
            });
        }
    }
    for (name, target, face) in [
        ("stencil_writemask_separate", glw::GL_STENCIL_WRITEMASK, glw::GL_FRONT),
        ("stencil_writemask_separate_both", glw::GL_STENCIL_WRITEMASK, glw::GL_FRONT_AND_BACK),
        ("stencil_back_writemask_separate", glw::GL_STENCIL_BACK_WRITEMASK, glw::GL_BACK),
        ("stencil_back_writemask_separate_both", glw::GL_STENCIL_BACK_WRITEMASK, glw::GL_FRONT_AND_BACK),
    ] {
        for verifier in NORMAL_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                stencil_write_mask_separate(case, verifier, target, face);
            });
        }
    }

    // Pixel store alignment.
    for (name, target) in [("unpack_alignment", glw::GL_UNPACK_ALIGNMENT), ("pack_alignment", glw::GL_PACK_ALIGNMENT)] {
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
            add_api_case(&mut group, format!("{name}_separate{}", verifier.postfix()), move |case| {
                blend_func(case, verifier, target, initial, true);
            });
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
            add_api_case(&mut group, format!("{name}_separate{}", verifier.postfix()), move |case| {
                blend_equation(case, verifier, target, initial, true);
            });
        }
    }

    // The implementation-defined format lists.
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("compressed_texture_formats{}", verifier.postfix()), move |case| {
            implementation_array(case, verifier, glw::GL_COMPRESSED_TEXTURE_FORMATS, glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS, 0);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("shader_binary_formats{}", verifier.postfix()), move |case| {
            implementation_array(case, verifier, glw::GL_SHADER_BINARY_FORMATS, glw::GL_NUM_SHADER_BINARY_FORMATS, 0);
        });
    }

    // The bindings, which use `verifyStateInteger` rather than a `StateVerifier`.
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("array_buffer_binding{}", verifier.postfix()), move |case| {
            buffer_binding(case, verifier, glw::GL_ARRAY_BUFFER_BINDING, glw::GL_ARRAY_BUFFER);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("element_array_buffer_binding{}", verifier.postfix()), move |case| {
            buffer_binding(case, verifier, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, glw::GL_ELEMENT_ARRAY_BUFFER);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("current_program_binding{}", verifier.postfix()), move |case| {
            current_program_binding(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("stencil_clear_value{}", verifier.postfix()), move |case| {
            stencil_clear_value(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("active_texture{}", verifier.postfix()), move |case| active_texture(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("renderbuffer_binding{}", verifier.postfix()), move |case| {
            renderbuffer_binding(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("texture_binding_2d{}", verifier.postfix()), move |case| {
            texture_binding(case, verifier, glw::GL_TEXTURE_BINDING_2D, glw::GL_TEXTURE_2D);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("texture_binding_cube_map{}", verifier.postfix()), move |case| {
            texture_binding(case, verifier, glw::GL_TEXTURE_BINDING_CUBE_MAP, glw::GL_TEXTURE_CUBE_MAP);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("framebuffer_binding{}", verifier.postfix()), move |case| {
            framebuffer_binding(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("implementation_color_read{}", verifier.postfix()), move |case| {
            implementation_color_read(case, verifier);
        });
    }

    group
}
