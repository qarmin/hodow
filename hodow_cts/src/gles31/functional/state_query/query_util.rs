// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsStateQueryUtil.hpp / .cpp
//   (QueryType, QueriedState, queryState/queryIndexedState/..., verify*)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the slice of upstream's
// StateQueryUtil the ported ES 3.1 state_query cases actually use is here, and it
// lives inside that group's own directory rather than in `gls` - dropping the group
// from `functional/mod.rs` drops this with it.
//
// `tcu::ResultCollector` is `ApiCase` itself: it keeps running after a mismatch and
// keeps the first failure, which is the behaviour every verifier below relies on.

use crate::gls::state_query_util::Guarded;
use crate::glu::ApiCase;
use crate::glw::{self, GLenum, GLint, GLint64, GLuint};

/// `gls::StateQueryUtil::QueryType`, restricted to the entry points the ported cases
/// query through.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum QueryType {
    IsEnabled,
    Boolean,
    Integer,
    Integer64,
    Float,
    IndexedIsEnabled,
    IndexedBoolean,
    IndexedInteger,
    IndexedInteger64,
    IndexedBooleanVec4,
    IndexedIntegerVec4,
    IndexedInteger64Vec4,
    AttributeInteger,
    AttributeFloat,
    AttributePureInteger,
    AttributePureUnsignedInteger,
    ProgramInteger,
    PipelineInteger,
    FramebufferInteger,
}

impl QueryType {
    /// `getVerifierSuffix` - every ES 3.1 state-query file has a copy of this switch,
    /// all identical.
    pub fn suffix(self) -> &'static str {
        match self {
            Self::IsEnabled | Self::IndexedIsEnabled => "isenabled",
            Self::Boolean | Self::IndexedBoolean | Self::IndexedBooleanVec4 => "getboolean",
            Self::Integer
            | Self::IndexedInteger
            | Self::IndexedIntegerVec4
            | Self::AttributeInteger
            | Self::ProgramInteger
            | Self::PipelineInteger
            | Self::FramebufferInteger => "getinteger",
            Self::Integer64 | Self::IndexedInteger64 | Self::IndexedInteger64Vec4 => "getinteger64",
            Self::Float => "getfloat",
            Self::AttributeFloat => "getvertexattribfv",
            Self::AttributePureInteger => "getvertexattribiiv",
            Self::AttributePureUnsignedInteger => "getvertexattribiuiv",
        }
    }
}

/// `gls::StateQueryUtil::QueriedState` - what one query answered, in the type the
/// entry point that answered it uses. `None` from a query means it already failed the
/// case and nothing may be compared against it.
#[derive(Clone, Copy, Debug)]
pub enum QueriedState {
    Boolean(bool),
    Integer(GLint),
    Integer64(GLint64),
    Float(f32),
    BooleanVec4([bool; 4]),
    IntegerVec4([GLint; 4]),
    Integer64Vec4([GLint64; 4]),
    Unsigned(GLuint),
}

/// `checkError` - a query that raised an error answered nothing.
fn check_error(case: &mut ApiCase<'_>, message: &str) -> bool {
    // SAFETY: glGetError needs only a current context.
    let error = unsafe { case.gl().get_error() };
    if error != glw::GL_NO_ERROR {
        case.fail(format!("Got Error {}: {message}", glw::error_name(error)), "Got unexpected error");
        return false;
    }
    true
}

/// `verifyBooleanValidity` - a GLboolean that is neither GL_TRUE nor GL_FALSE.
fn verify_boolean_validity(case: &mut ApiCase<'_>, value: u8) -> bool {
    if value != glw::TRUE && value != glw::FALSE {
        case.fail(format!("Boolean value was not neither GL_TRUE nor GL_FALSE, got {value:#x}"), "Got invalid boolean value");
        return false;
    }
    true
}

fn verify_boolean_vec4_validity(case: &mut ApiCase<'_>, value: [u8; 4]) -> bool {
    if value.iter().any(|v| *v != glw::TRUE && *v != glw::FALSE) {
        case.fail(format!("Boolean vector was not valid, got {value:#x?}"), "Got invalid boolean value");
        return false;
    }
    true
}

/// `queryState`
pub fn query_state(case: &mut ApiCase<'_>, query_type: QueryType, target: GLenum) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::IsEnabled => {
            // SAFETY: a plain enum query.
            let value = unsafe { gl.is_enabled(target) };
            if !check_error(case, "glIsEnabled") || !verify_boolean_validity(case, value) {
                return None;
            }
            Some(QueriedState::Boolean(value == glw::TRUE))
        }
        QueryType::Boolean => {
            let mut value = Guarded::<u8>::new();
            // SAFETY: one GLboolean out, guarded on both sides.
            unsafe { gl.get_booleanv(target, value.as_mut_ptr()) };
            if !check_error(case, "glGetBooleanv") || !value.verify_validity(case) || !verify_boolean_validity(case, value.value()) {
                return None;
            }
            Some(QueriedState::Boolean(value.value() == glw::TRUE))
        }
        QueryType::Integer => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_integerv(target, value.as_mut_ptr()) };
            if !check_error(case, "glGetIntegerv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        QueryType::Integer64 => {
            let mut value = Guarded::<GLint64>::new();
            // SAFETY: one GLint64 out.
            unsafe { gl.get_integer_64v(target, value.as_mut_ptr()) };
            if !check_error(case, "glGetInteger64v") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer64(value.value()))
        }
        QueryType::Float => {
            let mut value = Guarded::<f32>::new();
            // SAFETY: one GLfloat out.
            unsafe { gl.get_floatv(target, value.as_mut_ptr()) };
            if !check_error(case, "glGetFloatv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Float(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not a non-indexed query"), "Invalid verifier");
            None
        }
    }
}

/// `queryIndexedState`
pub fn query_indexed_state(case: &mut ApiCase<'_>, query_type: QueryType, target: GLenum, index: GLuint) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::IndexedIsEnabled => {
            // SAFETY: an indexed enum query.
            let value = unsafe { gl.is_enabledi(target, index) };
            if !check_error(case, "glIsEnabledi") || !verify_boolean_validity(case, value) {
                return None;
            }
            Some(QueriedState::Boolean(value == glw::TRUE))
        }
        QueryType::IndexedBoolean => {
            let mut value = Guarded::<u8>::new();
            // SAFETY: one GLboolean out.
            unsafe { gl.get_booleani_v(target, index, value.as_mut_ptr()) };
            if !check_error(case, "glGetBooleani_v") || !value.verify_validity(case) || !verify_boolean_validity(case, value.value()) {
                return None;
            }
            Some(QueriedState::Boolean(value.value() == glw::TRUE))
        }
        QueryType::IndexedInteger => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_integeri_v(target, index, value.as_mut_ptr()) };
            if !check_error(case, "glGetIntegeri_v") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        QueryType::IndexedInteger64 => {
            let mut value = Guarded::<GLint64>::new();
            // SAFETY: one GLint64 out.
            unsafe { gl.get_integer_64i_v(target, index, value.as_mut_ptr()) };
            if !check_error(case, "glGetInteger64i_v") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer64(value.value()))
        }
        QueryType::IndexedBooleanVec4 => {
            let mut value = Guarded::<[u8; 4]>::new();
            // SAFETY: four GLbooleans out, which is this state's width.
            unsafe { gl.get_booleani_v(target, index, value.as_mut_ptr().cast::<u8>()) };
            if !check_error(case, "glGetBooleani_v") || !value.verify_validity(case) || !verify_boolean_vec4_validity(case, value.value()) {
                return None;
            }
            Some(QueriedState::BooleanVec4(value.value().map(|v| v == glw::TRUE)))
        }
        QueryType::IndexedIntegerVec4 => {
            let mut value = Guarded::<[GLint; 4]>::new();
            // SAFETY: four GLints out.
            unsafe { gl.get_integeri_v(target, index, value.as_mut_ptr().cast::<GLint>()) };
            if !check_error(case, "glGetIntegeri_v") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::IntegerVec4(value.value()))
        }
        QueryType::IndexedInteger64Vec4 => {
            let mut value = Guarded::<[GLint64; 4]>::new();
            // SAFETY: four GLint64s out.
            unsafe { gl.get_integer_64i_v(target, index, value.as_mut_ptr().cast::<GLint64>()) };
            if !check_error(case, "glGetInteger64i_v") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer64Vec4(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not an indexed query"), "Invalid verifier");
            None
        }
    }
}

/// `queryAttributeState`
pub fn query_attribute_state(case: &mut ApiCase<'_>, query_type: QueryType, target: GLenum, index: GLuint) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::AttributeInteger => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_vertex_attribiv(index, target, value.as_mut_ptr()) };
            if !check_error(case, "glGetVertexAttribiv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        QueryType::AttributeFloat => {
            let mut value = Guarded::<f32>::new();
            // SAFETY: one GLfloat out.
            unsafe { gl.get_vertex_attribfv(index, target, value.as_mut_ptr()) };
            if !check_error(case, "glGetVertexAttribfv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Float(value.value()))
        }
        QueryType::AttributePureInteger => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_vertex_attrib_iiv(index, target, value.as_mut_ptr()) };
            if !check_error(case, "glGetVertexAttribIiv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        QueryType::AttributePureUnsignedInteger => {
            let mut value = Guarded::<GLuint>::new();
            // SAFETY: one GLuint out.
            unsafe { gl.get_vertex_attrib_iuiv(index, target, value.as_mut_ptr()) };
            if !check_error(case, "glGetVertexAttribIuiv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Unsigned(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not an attribute query"), "Invalid verifier");
            None
        }
    }
}

/// `queryProgramState`
pub fn query_program_state(case: &mut ApiCase<'_>, query_type: QueryType, program: GLuint, target: GLenum) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::ProgramInteger => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_programiv(program, target, value.as_mut_ptr()) };
            if !check_error(case, "glGetProgramiv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not a program query"), "Invalid verifier");
            None
        }
    }
}

/// `queryPipelineState`
pub fn query_pipeline_state(case: &mut ApiCase<'_>, query_type: QueryType, pipeline: GLuint, target: GLenum) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::PipelineInteger => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_program_pipelineiv(pipeline, target, value.as_mut_ptr()) };
            if !check_error(case, "glGetProgramPipelineiv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not a pipeline query"), "Invalid verifier");
            None
        }
    }
}

/// `queryFramebufferState`
pub fn query_framebuffer_state(case: &mut ApiCase<'_>, query_type: QueryType, target: GLenum, pname: GLenum) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::FramebufferInteger => {
            let mut value = Guarded::<GLint>::new();
            // SAFETY: one GLint out.
            unsafe { gl.get_framebuffer_parameteriv(target, pname, value.as_mut_ptr()) };
            if !check_error(case, "glGetFramebufferParameteriv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Integer(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not a framebuffer query"), "Invalid verifier");
            None
        }
    }
}

/// `deInt32ToFloatRoundToNegInf` / `deInt32ToFloatRoundToPosInf` - an integer state
/// read back as a float is only required to land between the two nearest floats.
#[expect(clippy::cast_precision_loss, reason = "the rounding is the point")]
fn int_to_float_range(value: i32) -> (f32, f32) {
    let exact = value as f32;
    #[expect(clippy::cast_possible_truncation, reason = "comparing the round trip, upstream does the same")]
    let round_trip = exact as i64;
    if round_trip == i64::from(value) {
        (exact, exact)
    } else if round_trip > i64::from(value) {
        (f32::from_bits(exact.to_bits() - 1), exact)
    } else {
        (exact, f32::from_bits(exact.to_bits() + 1))
    }
}

/// `verifyBoolean`
pub fn verify_boolean(case: &mut ApiCase<'_>, state: QueriedState, expected: bool) {
    match state {
        QueriedState::Boolean(value) => {
            if value != expected {
                case.fail(format!("Expected {expected}, got {value}"), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            let reference = i32::from(expected);
            if value != reference {
                case.fail(format!("Expected {reference}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            let reference = i64::from(expected);
            if value != reference {
                case.fail(format!("Expected {reference}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            let reference = if expected { 1.0 } else { 0.0 };
            if value != reference {
                case.fail(format!("Expected {reference}, got {value}"), "Got invalid float value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyInteger`
pub fn verify_integer(case: &mut ApiCase<'_>, state: QueriedState, expected: i32) {
    match state {
        QueriedState::Boolean(value) => {
            let reference = expected != 0;
            if value != reference {
                case.fail(format!("Expected {reference}, got {value}"), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            if value != expected {
                case.fail(format!("Expected {expected}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            if value != i64::from(expected) {
                case.fail(format!("Expected {expected}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            let (min, max) = int_to_float_range(expected);
            if value < min || value > max || value.is_nan() {
                case.fail(format!("Expected in range [{min}, {max}], got {value}"), "Got invalid float value");
            }
        }
        QueriedState::Unsigned(value) => {
            #[expect(clippy::cast_sign_loss, reason = "upstream casts the reference to GLuint here too")]
            let reference = expected as GLuint;
            if value != reference {
                case.fail(format!("Expected {reference}, got {value}"), "Got invalid unsigned integer value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyIntegerMin`
pub fn verify_integer_min(case: &mut ApiCase<'_>, state: QueriedState, min_value: i32) {
    match state {
        QueriedState::Boolean(value) => {
            if min_value > 0 && !value {
                case.fail("Expected GL_TRUE, got GL_FALSE".to_string(), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            if value < min_value {
                case.fail(format!("Expected greater or equal to {min_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            if value < i64::from(min_value) {
                case.fail(format!("Expected greater or equal to {min_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            let (min, _) = int_to_float_range(min_value);
            if value < min || value.is_nan() {
                case.fail(format!("Expected greater or equal to {min_value}, got {value}"), "Got invalid float value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyIntegerMax`
pub fn verify_integer_max(case: &mut ApiCase<'_>, state: QueriedState, max_value: i32) {
    match state {
        QueriedState::Boolean(value) => {
            if max_value < 0 && !value {
                case.fail("Expected GL_TRUE, got GL_FALSE".to_string(), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            if value > max_value {
                case.fail(format!("Expected less or equal to {max_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            if value > i64::from(max_value) {
                case.fail(format!("Expected less or equal to {max_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            let (_, max) = int_to_float_range(max_value);
            if value > max || value.is_nan() {
                case.fail(format!("Expected less or equal to {max_value}, got {value}"), "Got invalid float value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyFloat`
pub fn verify_float(case: &mut ApiCase<'_>, state: QueriedState, expected: f32) {
    match state {
        QueriedState::Boolean(value) => {
            let reference = expected != 0.0;
            if value != reference {
                case.fail(format!("Expected {reference}, got {value}"), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            let min = expected.floor();
            let max = expected.ceil();
            #[expect(clippy::cast_precision_loss, reason = "a state value that far out of range is already a failure")]
            let as_float = value as f32;
            if as_float < min || as_float > max {
                case.fail(format!("Expected in range [{min}, {max}], got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            let min = expected.floor();
            let max = expected.ceil();
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min || as_float > max {
                case.fail(format!("Expected in range [{min}, {max}], got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            if value != expected {
                case.fail(format!("Expected {expected}, got {value}"), "Got invalid float value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyFloatMin`
pub fn verify_float_min(case: &mut ApiCase<'_>, state: QueriedState, min_value: f32) {
    match state {
        QueriedState::Boolean(value) => {
            if min_value > 0.0 && !value {
                case.fail("Expected GL_TRUE, got GL_FALSE".to_string(), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min_value.floor() {
                case.fail(format!("Expected greater or equal to {min_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min_value.floor() {
                case.fail(format!("Expected greater or equal to {min_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            if value < min_value || value.is_nan() {
                case.fail(format!("Expected greater or equal to {min_value}, got {value}"), "Got invalid float value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyFloatMax`
pub fn verify_float_max(case: &mut ApiCase<'_>, state: QueriedState, max_value: f32) {
    match state {
        QueriedState::Boolean(value) => {
            if max_value < 0.0 && !value {
                case.fail("Expected GL_TRUE, got GL_FALSE".to_string(), "Got invalid boolean value");
            }
        }
        QueriedState::Integer(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float > max_value.ceil() {
                case.fail(format!("Expected less or equal to {max_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float > max_value.ceil() {
                case.fail(format!("Expected less or equal to {max_value}, got {value}"), "Got invalid integer value");
            }
        }
        QueriedState::Float(value) => {
            if value > max_value || value.is_nan() {
                case.fail(format!("Expected less or equal to {max_value}, got {value}"), "Got invalid float value");
            }
        }
        _ => case.fail(format!("{state:?} is not a scalar state"), "Got invalid value"),
    }
}

/// `verifyIntegerVec4`
pub fn verify_integer_vec4(case: &mut ApiCase<'_>, state: QueriedState, expected: [GLint; 4]) {
    match state {
        QueriedState::IntegerVec4(value) => {
            if value != expected {
                case.fail(format!("Expected {expected:?}, got {value:?}"), "Got invalid integer value");
            }
        }
        QueriedState::Integer64Vec4(value) => {
            let reference = expected.map(i64::from);
            if value != reference {
                case.fail(format!("Expected {reference:?}, got {value:?}"), "Got invalid integer value");
            }
        }
        QueriedState::BooleanVec4(value) => {
            let reference = expected.map(|v| v != 0);
            if value != reference {
                case.fail(format!("Expected {reference:?}, got {value:?}"), "Got invalid boolean value");
            }
        }
        _ => case.fail(format!("{state:?} is not a vec4 state"), "Got invalid value"),
    }
}

/// `verifyBooleanVec4`
pub fn verify_boolean_vec4(case: &mut ApiCase<'_>, state: QueriedState, expected: [bool; 4]) {
    verify_integer_vec4(case, state, expected.map(i32::from));
}

/// `verifyStateBoolean`
pub fn verify_state_boolean(case: &mut ApiCase<'_>, target: GLenum, reference: bool, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_boolean(case, state, reference);
    }
}

/// `verifyStateInteger`
pub fn verify_state_integer(case: &mut ApiCase<'_>, target: GLenum, reference: i32, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateIntegerMin`
pub fn verify_state_integer_min(case: &mut ApiCase<'_>, target: GLenum, min_value: i32, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_integer_min(case, state, min_value);
    }
}

/// `verifyStateIntegerMax`
pub fn verify_state_integer_max(case: &mut ApiCase<'_>, target: GLenum, max_value: i32, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_integer_max(case, state, max_value);
    }
}

/// `verifyStateFloat`
pub fn verify_state_float(case: &mut ApiCase<'_>, target: GLenum, reference: f32, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_float(case, state, reference);
    }
}

/// `verifyStateFloatMin`
pub fn verify_state_float_min(case: &mut ApiCase<'_>, target: GLenum, min_value: f32, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_float_min(case, state, min_value);
    }
}

/// `verifyStateFloatMax`
pub fn verify_state_float_max(case: &mut ApiCase<'_>, target: GLenum, max_value: f32, query_type: QueryType) {
    if let Some(state) = query_state(case, query_type, target) {
        verify_float_max(case, state, max_value);
    }
}

/// `verifyStateIndexedBoolean`
pub fn verify_state_indexed_boolean(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, reference: bool, query_type: QueryType) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_boolean(case, state, reference);
    }
}

/// `verifyStateIndexedInteger`
pub fn verify_state_indexed_integer(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, reference: i32, query_type: QueryType) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateIndexedIntegerMin`
pub fn verify_state_indexed_integer_min(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, min_value: i32, query_type: QueryType) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_integer_min(case, state, min_value);
    }
}

/// `verifyStateIndexedBooleanVec4`
pub fn verify_state_indexed_boolean_vec4(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, reference: [bool; 4], query_type: QueryType) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_boolean_vec4(case, state, reference);
    }
}

/// `verifyStateAttributeInteger`
pub fn verify_state_attribute_integer(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, reference: i32, query_type: QueryType) {
    if let Some(state) = query_attribute_state(case, query_type, target, index) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateProgramInteger`
pub fn verify_state_program_integer(case: &mut ApiCase<'_>, program: GLuint, pname: GLenum, reference: i32, query_type: QueryType) {
    if let Some(state) = query_program_state(case, query_type, program, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStatePipelineInteger`
pub fn verify_state_pipeline_integer(case: &mut ApiCase<'_>, pipeline: GLuint, pname: GLenum, reference: i32, query_type: QueryType) {
    if let Some(state) = query_pipeline_state(case, query_type, pipeline, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateFramebufferInteger`
pub fn verify_state_framebuffer_integer(case: &mut ApiCase<'_>, target: GLenum, pname: GLenum, reference: i32, query_type: QueryType) {
    if let Some(state) = query_framebuffer_state(case, query_type, target, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateFramebufferIntegerMin`
pub fn verify_state_framebuffer_integer_min(case: &mut ApiCase<'_>, target: GLenum, pname: GLenum, min_value: i32, query_type: QueryType) {
    if let Some(state) = query_framebuffer_state(case, query_type, target, pname) {
        verify_integer_min(case, state, min_value);
    }
}

/// `TCU_CHECK_AND_THROW(NotSupportedError, contextSupports(...))` - every ES 3.1
/// state-query case that also exists in ES 3.2 guards itself with this.
pub fn require_context_version(case: &mut ApiCase<'_>, major: i32, minor: i32) -> bool {
    if case.context().context_type().supports(major, minor) {
        return true;
    }
    case.not_supported("This test requires a higher context version.");
    false
}
