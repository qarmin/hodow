// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFloatStateQueryTests.cpp
//   modules/glshared/glsStateQueryUtil.hpp (roundGLfloatToNearestIntegerHalf{Up,Down})
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Three verifiers as one enum, as in
// the `boolean` and `integers` groups.
//
// What makes this group different from `integers` is the conversion in the other
// direction, and it is where drivers get caught: a float state read through
// `glGetIntegerv` must be *expanded* from [-1, 1] onto the whole integer range, and a
// plain float state must be rounded to the nearest integer. Upstream allows ten bits
// of slack in the expansion (`FLOAT_EXPANSION_E`), which is what makes the check
// meaningful rather than exact.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::Random;

/// `FLOAT_EXPANSION_E` - ten bits of error allowed, which requires 22 accurate bits.
const FLOAT_EXPANSION_E: i64 = 0x03FF;

/// `expandGLFloatToInteger` - the [-1, 1] to full-integer-range mapping the
/// specification requires of `glGetIntegerv` on a normalised float state.
fn expand_gl_float_to_integer(f: f32) -> i64 {
    ((f64::from(f) * 4_294_967_295.0 - 1.0) / 2.0) as i64
}

fn clamp_to_glint(value: i64) -> i32 {
    value.clamp(i64::from(i32::MIN), i64::from(i32::MAX)) as i32
}

/// `roundGLfloatToNearestIntegerHalfUp`
fn round_half_up(value: f32) -> i32 {
    (value + 0.5).floor() as i32
}

/// `roundGLfloatToNearestIntegerHalfDown`
fn round_half_down(value: f32) -> i32 {
    (value - 0.5).ceil() as i32
}

#[derive(Clone, Copy, PartialEq, Eq)]
#[expect(clippy::enum_variant_names, reason = "named after upstream's getBoolean/getInteger/getFloat verifiers")]
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

    /// `verifyFloat`
    fn verify_float(self, case: &mut ApiCase<'_>, name: GLenum, reference: f32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out, guarded on both sides.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = if reference == 0.0 { glw::FALSE } else { glw::TRUE };
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
                // A float state read as an integer may round either way.
                let (min, max) = (round_half_down(reference), round_half_up(reference));
                if state.value() < min || state.value() > max {
                    case.fail(format!("expected {min}..={max}; got {}", state.value()), "Got invalid integer value");
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<f32>::new();
                // SAFETY: one GLfloat out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(format!("expected {reference}; got {}", state.value()), "Got invalid float value");
                }
            }
        }
    }

    /// `verifyFloatExpanded` - the reference is in [-1, 1], so an integer query must
    /// answer with it mapped onto the whole integer range.
    fn verify_float_expanded(self, case: &mut ApiCase<'_>, name: GLenum, reference: f32) {
        match self {
            // Nothing to expand: zero or not.
            Self::GetBoolean | Self::GetFloat => self.verify_float(case, name, reference),
            Self::GetInteger => {
                let gl = case.gl();
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expanded = expand_gl_float_to_integer(reference);
                let (min, max) = (clamp_to_glint(expanded - FLOAT_EXPANSION_E), clamp_to_glint(expanded + FLOAT_EXPANSION_E));
                if state.value() < min || state.value() > max {
                    case.fail(format!("expected {min}..={max}; got {}", state.value()), "Got invalid integer value");
                }
            }
        }
    }

    /// `verifyFloat2Expanded`
    fn verify_float2_expanded(self, case: &mut ApiCase<'_>, name: GLenum, reference: [f32; 2]) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<[u8; 2]>::new();
                // SAFETY: two GLbooleans out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(|r| if r == 0.0 { glw::FALSE } else { glw::TRUE });
                if state.value() != expected {
                    case.fail(format!("expected {expected:?}; got {:?}", state.value()), "Got invalid boolean value");
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
                for ndx in 0..2 {
                    let expanded = expand_gl_float_to_integer(reference[ndx]);
                    let (min, max) = (clamp_to_glint(expanded - FLOAT_EXPANSION_E), clamp_to_glint(expanded + FLOAT_EXPANSION_E));
                    if value[ndx] < min || value[ndx] > max {
                        case.fail(format!("expected {min}..={max} at {ndx}; got {}", value[ndx]), "Got invalid integer value");
                        return;
                    }
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<[f32; 2]>::new();
                // SAFETY: two GLfloats out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr().cast::<f32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(format!("expected {reference:?}; got {:?}", state.value()), "Got invalid float value");
                }
            }
        }
    }

    /// `verifyFloat4Color`
    fn verify_float4_color(self, case: &mut ApiCase<'_>, name: GLenum, reference: [f32; 4]) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<[u8; 4]>::new();
                // SAFETY: four GLbooleans out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(|r| if r == 0.0 { glw::FALSE } else { glw::TRUE });
                if state.value() != expected {
                    case.fail(format!("expected {expected:?}; got {:?}", state.value()), "Got invalid boolean value");
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
                for ndx in 0..4 {
                    let expanded = expand_gl_float_to_integer(reference[ndx]);
                    let (min, max) = (clamp_to_glint(expanded - FLOAT_EXPANSION_E), clamp_to_glint(expanded + FLOAT_EXPANSION_E));
                    if value[ndx] < min || value[ndx] > max {
                        case.fail(format!("expected {min}..={max} at {ndx}; got {}", value[ndx]), "Got invalid integer value");
                        return;
                    }
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<[f32; 4]>::new();
                // SAFETY: four GLfloats out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr().cast::<f32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(format!("expected {reference:?}; got {:?}", state.value()), "Got invalid float value");
                }
            }
        }
    }

    /// `verifyFloatRange` - the implementation's range must *contain* [min, max].
    fn verify_float_range(self, case: &mut ApiCase<'_>, name: GLenum, min: f32, max: f32) {
        let gl = case.gl();
        match self {
            Self::GetBoolean => {
                let mut state = Guarded::<[u8; 2]>::new();
                // SAFETY: two GLbooleans out.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let range = state.value();
                // A GL_FALSE low end means the range starts at zero, which only
                // contains the required range if that does not go below zero; likewise
                // for the high end.
                if range[0] == glw::FALSE && (max < 0.0 || min < 0.0) {
                    case.fail(format!("range low end reads GL_FALSE but {min}..{max} goes below zero"), "Got invalid boolean range");
                    return;
                }
                if range[1] == glw::FALSE && (max > 0.0 || min > 0.0) {
                    case.fail(format!("range high end reads GL_FALSE but {min}..{max} goes above zero"), "Got invalid boolean range");
                }
            }
            Self::GetInteger => {
                let mut state = Guarded::<[i32; 2]>::new();
                // SAFETY: two GLints out.
                unsafe { gl.get_integerv(name, state.as_mut_ptr().cast::<i32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let range = state.value();
                let wanted = [round_half_up(min), round_half_down(max)];
                if wanted[0] < range[0] || wanted[1] > range[1] {
                    case.fail(format!("expected a range containing {wanted:?}; got {range:?}"), "Got invalid integer range");
                }
            }
            Self::GetFloat => {
                let mut state = Guarded::<[f32; 2]>::new();
                // SAFETY: two GLfloats out.
                unsafe { gl.get_floatv(name, state.as_mut_ptr().cast::<f32>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let range = state.value();
                if range[0] > min || range[1] < max {
                    case.fail(format!("expected a range containing {min}..{max}; got {range:?}"), "Got invalid float range");
                }
            }
        }
    }
}

/// `DepthRangeCase`
fn depth_range(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    verifier.verify_float2_expanded(case, glw::GL_DEPTH_RANGE, [0.0, 1.0]);
    case.expect_error(glw::GL_NO_ERROR);

    for (near, far) in [(0.5, 1.0), (0.0, 0.5), (0.0, 0.0), (1.0, 1.0)] {
        // SAFETY: a state setter with in-range arguments.
        unsafe { gl.depth_rangef(near, far) };
        verifier.verify_float2_expanded(case, glw::GL_DEPTH_RANGE, [near, far]);
        case.expect_error(glw::GL_NO_ERROR);
    }

    for _ in 0..120 {
        let near = rnd.get_float_range(0.0, 1.0);
        let far = rnd.get_float_range(0.0, 1.0);
        // SAFETY: as above.
        unsafe { gl.depth_rangef(near, far) };
        verifier.verify_float2_expanded(case, glw::GL_DEPTH_RANGE, [near, far]);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `LineWidthCase`
fn line_width(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    let mut range = [1.0f32; 2];
    // SAFETY: GL_ALIASED_LINE_WIDTH_RANGE writes two floats.
    unsafe { gl.get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, range.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);

    verifier.verify_float(case, glw::GL_LINE_WIDTH, 1.0);
    case.expect_error(glw::GL_NO_ERROR);

    for _ in 0..120 {
        let reference = rnd.get_float_range(range[0], range[1]);
        // SAFETY: the width is inside the implementation's own range.
        unsafe { gl.line_width(reference) };
        verifier.verify_float(case, glw::GL_LINE_WIDTH, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `PolygonOffsetFactorCase` / `PolygonOffsetUnitsCase`
fn polygon_offset(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);
    let is_factor = target == glw::GL_POLYGON_OFFSET_FACTOR;

    verifier.verify_float(case, target, 0.0);
    case.expect_error(glw::GL_NO_ERROR);

    for value in [0.0f32, 0.5, -0.5, 1.5] {
        // SAFETY: a state setter; either argument may be any float.
        unsafe {
            if is_factor {
                gl.polygon_offset(value, 0.0);
            } else {
                gl.polygon_offset(0.0, value);
            }
        }
        verifier.verify_float(case, target, value);
        case.expect_error(glw::GL_NO_ERROR);
    }

    for _ in 0..120 {
        let reference = rnd.get_float_range(-64000.0, 64000.0);
        // SAFETY: as above.
        unsafe {
            if is_factor {
                gl.polygon_offset(reference, 0.0);
            } else {
                gl.polygon_offset(0.0, reference);
            }
        }
        verifier.verify_float(case, target, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `SampleCoverageCase`
fn sample_coverage(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    verifier.verify_float(case, glw::GL_SAMPLE_COVERAGE_VALUE, 1.0);
    case.expect_error(glw::GL_NO_ERROR);

    for value in [0.0f32, 0.5, 0.45, 0.55] {
        // SAFETY: a state setter with an in-range value.
        unsafe { gl.sample_coverage(value, glw::FALSE) };
        verifier.verify_float(case, glw::GL_SAMPLE_COVERAGE_VALUE, value);
        case.expect_error(glw::GL_NO_ERROR);
    }

    // Out-of-range values must be clamped rather than rejected.
    for value in [-1.0f32, -1.5, 1.45, 3.55] {
        // SAFETY: as above; the clamping is what is being checked.
        unsafe { gl.sample_coverage(value, glw::FALSE) };
        verifier.verify_float(case, glw::GL_SAMPLE_COVERAGE_VALUE, value.clamp(0.0, 1.0));
        case.expect_error(glw::GL_NO_ERROR);
    }

    for _ in 0..120 {
        let reference = rnd.get_float_range(0.0, 1.0);
        let invert = if rnd.get_bool() { glw::TRUE } else { glw::FALSE };
        // SAFETY: as above.
        unsafe { gl.sample_coverage(reference, invert) };
        verifier.verify_float(case, glw::GL_SAMPLE_COVERAGE_VALUE, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ColorClearCase`
fn color_clear(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    // \note upstream: the initial colour clear value check is temporarily removed,
    // because the framework alters it before the case runs.

    for value in [[0.5f32, 1.0, 0.5, 1.0], [0.0, 0.5, 0.0, 0.5], [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0]] {
        // SAFETY: a state setter with in-range components.
        unsafe { gl.clear_color(value[0], value[1], value[2], value[3]) };
        verifier.verify_float4_color(case, glw::GL_COLOR_CLEAR_VALUE, value);
        case.expect_error(glw::GL_NO_ERROR);
    }

    for _ in 0..120 {
        let value = [
            rnd.get_float_range(0.0, 1.0),
            rnd.get_float_range(0.0, 1.0),
            rnd.get_float_range(0.0, 1.0),
            rnd.get_float_range(0.0, 1.0),
        ];
        // SAFETY: as above.
        unsafe { gl.clear_color(value[0], value[1], value[2], value[3]) };
        verifier.verify_float4_color(case, glw::GL_COLOR_CLEAR_VALUE, value);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `DepthClearCase`
fn depth_clear(case: &mut ApiCase<'_>, verifier: Verifier) {
    let gl = case.gl();
    let mut rnd = Random::new(0x00ab_cdef);

    verifier.verify_float_expanded(case, glw::GL_DEPTH_CLEAR_VALUE, 1.0);
    case.expect_error(glw::GL_NO_ERROR);

    for _ in 0..120 {
        let reference = rnd.get_float_range(0.0, 1.0);
        // SAFETY: a state setter with an in-range value.
        unsafe { gl.clear_depthf(reference) };
        verifier.verify_float_expanded(case, glw::GL_DEPTH_CLEAR_VALUE, reference);
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `AliasedPointSizeRangeCase` / `AliasedLineWidthRangeCase`
fn aliased_range(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum) {
    verifier.verify_float_range(case, target, 1.0, 1.0);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `FloatStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("floats");

    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("depth_range{}", verifier.postfix()), move |case| depth_range(case, verifier));
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("line_width{}", verifier.postfix()), move |case| line_width(case, verifier));
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("polygon_offset_factor{}", verifier.postfix()), move |case| {
            polygon_offset(case, verifier, glw::GL_POLYGON_OFFSET_FACTOR);
        });
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("polygon_offset_units{}", verifier.postfix()), move |case| {
            polygon_offset(case, verifier, glw::GL_POLYGON_OFFSET_UNITS);
        });
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("sample_coverage_value{}", verifier.postfix()), move |case| {
            sample_coverage(case, verifier);
        });
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("color_clear_value{}", verifier.postfix()), move |case| color_clear(case, verifier));
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("depth_clear_value{}", verifier.postfix()), move |case| depth_clear(case, verifier));
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("aliased_point_size_range{}", verifier.postfix()), move |case| {
            aliased_range(case, verifier, glw::GL_ALIASED_POINT_SIZE_RANGE);
        });
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("aliased_line_width_range{}", verifier.postfix()), move |case| {
            aliased_range(case, verifier, glw::GL_ALIASED_LINE_WIDTH_RANGE);
        });
    }

    group
}
