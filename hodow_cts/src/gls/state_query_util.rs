// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsStateQueryUtil.hpp / .cpp
//   (StateQueryMemoryWriteGuard, QueryType, QueriedState, queryState/queryIndexedState/..., verify*)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::ApiCase;
use crate::glw::{self, GLenum, GLint, GLint64, GLuint};

/// The byte every guarded query buffer starts out filled with.
const WRITE_GUARD_VALUE: u8 = 0xDE;

/// Types a `glGet*v` may write. The bound exists so `Guarded` cannot be instantiated
/// for something where filling every byte with `0xDE` would not be a valid value.
///
/// # Safety
/// Every bit pattern must be a valid value of the type, and it must contain no
/// padding - which holds for the GL scalar types and arrays of them.
pub unsafe trait QueryValue: Copy + PartialEq {}

// SAFETY: all plain-old-data GL query outputs.
unsafe impl QueryValue for u8 {}
unsafe impl QueryValue for i32 {}
unsafe impl QueryValue for f32 {}
unsafe impl QueryValue for u32 {}
unsafe impl QueryValue for i64 {}
unsafe impl<T: QueryValue, const N: usize> QueryValue for [T; N] {}
// SAFETY: `glGetVertexAttribPointerv`'s output. The pointer is only ever compared, never
// dereferenced, so a guard byte pattern in it is as valid as any other address.
unsafe impl QueryValue for *mut std::ffi::c_void {}

/// `gls::StateQueryUtil::StateQueryMemoryWriteGuard` - a query output buffer with a
/// copy of itself on each side.
///
/// The whole thing starts filled with `0xDE`, so afterwards three questions can be
/// asked that a plain output variable cannot answer: did the driver write anything at
/// all, did it write *before* the buffer, and did it write *past* it. All three are
/// real driver bugs and all three are silent without this.
#[repr(C)]
pub struct Guarded<T: QueryValue> {
    preguard: T,
    value: T,
    postguard: T,
}

impl<T: QueryValue> Guarded<T> {
    pub fn new() -> Self {
        // SAFETY: `QueryValue`'s contract is that every bit pattern is valid and the
        // type has no padding, so filling all three fields byte-wise initialises them.
        let mut guard = std::mem::MaybeUninit::<Self>::uninit();
        unsafe {
            std::ptr::write_bytes(guard.as_mut_ptr(), WRITE_GUARD_VALUE, 1);
            guard.assume_init()
        }
    }

    /// The pointer to hand to `glGet*v` - the middle field, so an overrun in either
    /// direction lands in a guard.
    pub fn as_mut_ptr(&mut self) -> *mut T {
        &raw mut self.value
    }

    pub fn value(&self) -> T {
        self.value
    }

    /// `isUndefined` - the driver wrote nothing at all.
    pub fn is_undefined(&self) -> bool {
        self.is_all_guard_bytes(&self.value)
    }

    /// `isPreguardContaminated`
    pub fn is_preguard_contaminated(&self) -> bool {
        !self.is_all_guard_bytes(&self.preguard)
    }

    /// `isPostguardContaminated`
    pub fn is_postguard_contaminated(&self) -> bool {
        !self.is_all_guard_bytes(&self.postguard)
    }

    fn is_all_guard_bytes(&self, field: &T) -> bool {
        // SAFETY: reading a `QueryValue` as bytes is sound - it is plain data of a
        // known size with no padding.
        let bytes = unsafe { std::slice::from_raw_parts((field as *const T).cast::<u8>(), size_of::<T>()) };
        bytes.iter().all(|byte| *byte == WRITE_GUARD_VALUE)
    }

    /// `verifyValidity` - returns false when the value cannot be trusted, in which
    /// case the caller must not compare it against anything.
    pub fn verify_validity(&self, case: &mut ApiCase<'_>) -> bool {
        if self.is_undefined() {
            case.fail(
                "// ERROR: Get* did not return a value".to_string(),
                "Get* did not return a value",
            );
            return false;
        }
        if self.is_preguard_contaminated() {
            case.fail(
                "// ERROR: Get* wrote over bounds (before)".to_string(),
                "Get* wrote over bounds",
            );
            return false;
        }
        if self.is_postguard_contaminated() {
            case.fail(
                "// ERROR: Get* wrote over bounds (after)".to_string(),
                "Get* wrote over bounds",
            );
            return false;
        }
        true
    }
}

impl<T: QueryValue> Default for Guarded<T> {
    fn default() -> Self {
        Self::new()
    }
}

/// `gls::StateQueryUtil::QueryType`, restricted to the entry points the ported cases
/// query through.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum QueryType {
    IsEnabled,
    Boolean,
    Integer,
    Integer64,
    Float,
    Pointer,
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
    IsTexture,
    TextureParamInteger,
    TextureParamFloat,
    TextureParamPureInteger,
    TextureParamPureUnsignedInteger,
    TextureParamIntegerVec4,
    TextureParamFloatVec4,
    TextureParamPureIntegerVec4,
    TextureParamPureUnsignedIntegerVec4,
    SamplerParamInteger,
    SamplerParamFloat,
    SamplerParamPureInteger,
    SamplerParamPureUnsignedInteger,
    SamplerParamIntegerVec4,
    SamplerParamFloatVec4,
    SamplerParamPureIntegerVec4,
    SamplerParamPureUnsignedIntegerVec4,
    TextureLevelInteger,
    TextureLevelFloat,
}

impl QueryType {
    /// `getVerifierSuffix` - every ES 3.1 state-query file has a copy of this switch,
    /// all identical.
    ///
    /// The texture/sampler-parameter verifiers are the exception: ES 3.0 spells them
    /// after the entry point (`_gettexparameteri`) and ES 3.1 after the data type
    /// (`_integer`, `_pure_int`), so those four files carry their own table and this
    /// returns the ES 3.1 spelling for the variants only ES 3.1 has.
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
            Self::Pointer => "getpointer",
            Self::AttributeFloat => "getvertexattribfv",
            Self::AttributePureInteger => "getvertexattribiiv",
            Self::AttributePureUnsignedInteger => "getvertexattribiuiv",
            Self::IsTexture => "istexture",
            Self::TextureParamInteger => "gettexparameteri",
            Self::TextureParamFloat => "gettexparameterf",
            Self::SamplerParamInteger => "getsamplerparameteri",
            Self::SamplerParamFloat => "getsamplerparameterf",
            Self::TextureParamIntegerVec4 | Self::SamplerParamIntegerVec4 | Self::TextureLevelInteger => "integer",
            Self::TextureParamFloatVec4 | Self::SamplerParamFloatVec4 | Self::TextureLevelFloat => "float",
            Self::TextureParamPureInteger
            | Self::TextureParamPureIntegerVec4
            | Self::SamplerParamPureInteger
            | Self::SamplerParamPureIntegerVec4 => "pure_int",
            Self::TextureParamPureUnsignedInteger
            | Self::TextureParamPureUnsignedIntegerVec4
            | Self::SamplerParamPureUnsignedInteger
            | Self::SamplerParamPureUnsignedIntegerVec4 => "pure_uint",
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
    FloatVec4([f32; 4]),
    UnsignedVec4([GLuint; 4]),
    Unsigned(GLuint),
    Pointer(*mut std::ffi::c_void),
}

/// `checkError` - a query that raised an error answered nothing.
fn check_error(case: &mut ApiCase<'_>, message: &str) -> bool {
    // SAFETY: glGetError needs only a current context.
    let error = unsafe { case.gl().get_error() };
    if error != glw::GL_NO_ERROR {
        case.fail(
            format!("Got Error {}: {message}", glw::error_name(error)),
            "Got unexpected error",
        );
        return false;
    }
    true
}

/// `verifyBooleanValidity` - a GLboolean that is neither GL_TRUE nor GL_FALSE.
fn verify_boolean_validity(case: &mut ApiCase<'_>, value: u8) -> bool {
    if value != glw::TRUE && value != glw::FALSE {
        case.fail(
            format!("Boolean value was not neither GL_TRUE nor GL_FALSE, got {value:#x}"),
            "Got invalid boolean value",
        );
        return false;
    }
    true
}

fn verify_boolean_vec4_validity(case: &mut ApiCase<'_>, value: [u8; 4]) -> bool {
    if value.iter().any(|v| *v != glw::TRUE && *v != glw::FALSE) {
        case.fail(
            format!("Boolean vector was not valid, got {value:#x?}"),
            "Got invalid boolean value",
        );
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
            if !check_error(case, "glGetBooleanv")
                || !value.verify_validity(case)
                || !verify_boolean_validity(case, value.value())
            {
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

/// `queryPointerState`
pub fn query_pointer_state(case: &mut ApiCase<'_>, query_type: QueryType, pname: GLenum) -> Option<QueriedState> {
    let gl = case.gl();
    match query_type {
        QueryType::Pointer => {
            let mut value = Guarded::<*mut std::ffi::c_void>::new();
            // SAFETY: one pointer-sized output, guarded on both sides. The pointer is
            // only ever compared, never dereferenced.
            unsafe { gl.get_pointerv(pname, value.as_mut_ptr()) };
            if !check_error(case, "glGetPointerv") || !value.verify_validity(case) {
                return None;
            }
            Some(QueriedState::Pointer(value.value()))
        }
        _ => {
            case.fail(format!("{query_type:?} is not a pointer query"), "Invalid verifier");
            None
        }
    }
}

/// `queryIndexedState`
pub fn query_indexed_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    target: GLenum,
    index: GLuint,
) -> Option<QueriedState> {
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
            if !check_error(case, "glGetBooleani_v")
                || !value.verify_validity(case)
                || !verify_boolean_validity(case, value.value())
            {
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
            if !check_error(case, "glGetBooleani_v")
                || !value.verify_validity(case)
                || !verify_boolean_vec4_validity(case, value.value())
            {
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
pub fn query_attribute_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    target: GLenum,
    index: GLuint,
) -> Option<QueriedState> {
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
pub fn query_program_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    program: GLuint,
    target: GLenum,
) -> Option<QueriedState> {
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
pub fn query_pipeline_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    pipeline: GLuint,
    target: GLenum,
) -> Option<QueriedState> {
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
pub fn query_framebuffer_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    target: GLenum,
    pname: GLenum,
) -> Option<QueriedState> {
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
    #[expect(
        clippy::cast_possible_truncation,
        reason = "comparing the round trip, upstream does the same"
    )]
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
                case.fail(
                    format!("Expected {reference}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64(value) => {
            let reference = i64::from(expected);
            if value != reference {
                case.fail(
                    format!("Expected {reference}, got {value}"),
                    "Got invalid integer value",
                );
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
                case.fail(
                    format!("Expected {reference}, got {value}"),
                    "Got invalid boolean value",
                );
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
                case.fail(
                    format!("Expected in range [{min}, {max}], got {value}"),
                    "Got invalid float value",
                );
            }
        }
        QueriedState::Unsigned(value) => {
            #[expect(clippy::cast_sign_loss, reason = "upstream casts the reference to GLuint here too")]
            let reference = expected as GLuint;
            if value != reference {
                case.fail(
                    format!("Expected {reference}, got {value}"),
                    "Got invalid unsigned integer value",
                );
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
                case.fail(
                    "Expected GL_TRUE, got GL_FALSE".to_string(),
                    "Got invalid boolean value",
                );
            }
        }
        QueriedState::Integer(value) => {
            if value < min_value {
                case.fail(
                    format!("Expected greater or equal to {min_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64(value) => {
            if value < i64::from(min_value) {
                case.fail(
                    format!("Expected greater or equal to {min_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Float(value) => {
            let (min, _) = int_to_float_range(min_value);
            if value < min || value.is_nan() {
                case.fail(
                    format!("Expected greater or equal to {min_value}, got {value}"),
                    "Got invalid float value",
                );
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
                case.fail(
                    "Expected GL_TRUE, got GL_FALSE".to_string(),
                    "Got invalid boolean value",
                );
            }
        }
        QueriedState::Integer(value) => {
            if value > max_value {
                case.fail(
                    format!("Expected less or equal to {max_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64(value) => {
            if value > i64::from(max_value) {
                case.fail(
                    format!("Expected less or equal to {max_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Float(value) => {
            let (_, max) = int_to_float_range(max_value);
            if value > max || value.is_nan() {
                case.fail(
                    format!("Expected less or equal to {max_value}, got {value}"),
                    "Got invalid float value",
                );
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
                case.fail(
                    format!("Expected {reference}, got {value}"),
                    "Got invalid boolean value",
                );
            }
        }
        QueriedState::Integer(value) => {
            let min = expected.floor();
            let max = expected.ceil();
            #[expect(
                clippy::cast_precision_loss,
                reason = "a state value that far out of range is already a failure"
            )]
            let as_float = value as f32;
            if as_float < min || as_float > max {
                case.fail(
                    format!("Expected in range [{min}, {max}], got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64(value) => {
            let min = expected.floor();
            let max = expected.ceil();
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min || as_float > max {
                case.fail(
                    format!("Expected in range [{min}, {max}], got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Unsigned(value) => {
            let min = expected.floor();
            let max = expected.ceil();
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min || as_float > max {
                case.fail(
                    format!("Expected in range [{min}, {max}], got {value}"),
                    "Got invalid unsigned integer value",
                );
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
                case.fail(
                    "Expected GL_TRUE, got GL_FALSE".to_string(),
                    "Got invalid boolean value",
                );
            }
        }
        QueriedState::Integer(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min_value.floor() {
                case.fail(
                    format!("Expected greater or equal to {min_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float < min_value.floor() {
                case.fail(
                    format!("Expected greater or equal to {min_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Float(value) => {
            if value < min_value || value.is_nan() {
                case.fail(
                    format!("Expected greater or equal to {min_value}, got {value}"),
                    "Got invalid float value",
                );
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
                case.fail(
                    "Expected GL_TRUE, got GL_FALSE".to_string(),
                    "Got invalid boolean value",
                );
            }
        }
        QueriedState::Integer(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float > max_value.ceil() {
                case.fail(
                    format!("Expected less or equal to {max_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64(value) => {
            #[expect(clippy::cast_precision_loss, reason = "as above")]
            let as_float = value as f32;
            if as_float > max_value.ceil() {
                case.fail(
                    format!("Expected less or equal to {max_value}, got {value}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Float(value) => {
            if value > max_value || value.is_nan() {
                case.fail(
                    format!("Expected less or equal to {max_value}, got {value}"),
                    "Got invalid float value",
                );
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
                case.fail(
                    format!("Expected {expected:?}, got {value:?}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::Integer64Vec4(value) => {
            let reference = expected.map(i64::from);
            if value != reference {
                case.fail(
                    format!("Expected {reference:?}, got {value:?}"),
                    "Got invalid integer value",
                );
            }
        }
        QueriedState::BooleanVec4(value) => {
            let reference = expected.map(|v| v != 0);
            if value != reference {
                case.fail(
                    format!("Expected {reference:?}, got {value:?}"),
                    "Got invalid boolean value",
                );
            }
        }
        _ => case.fail(format!("{state:?} is not a vec4 state"), "Got invalid value"),
    }
}

/// `verifyBooleanVec4`
pub fn verify_boolean_vec4(case: &mut ApiCase<'_>, state: QueriedState, expected: [bool; 4]) {
    verify_integer_vec4(case, state, expected.map(i32::from));
}

/// `verifyUnsignedIntegerVec4`
pub fn verify_unsigned_integer_vec4(case: &mut ApiCase<'_>, state: QueriedState, expected: [GLuint; 4]) {
    match state {
        QueriedState::UnsignedVec4(value) => {
            if value != expected {
                case.fail(
                    format!("Expected {expected:?}, got {value:?}"),
                    "Got invalid unsigned integer value",
                );
            }
        }
        _ => case.fail(format!("{state:?} is not an unsigned vec4 state"), "Got invalid value"),
    }
}

/// `roundGLfloatToNearestIntegerHalfUp` - x.5 rounds up.
pub fn round_half_up(value: f32) -> f32 {
    (value + 0.5).floor()
}

/// `roundGLfloatToNearestIntegerHalfDown` - x.5 rounds down.
pub fn round_half_down(value: f32) -> f32 {
    (value - 0.5).ceil()
}

/// Every range check in `verifyFloatVec4` and `verifyNormalizedI32Vec4` except the
/// exact float-to-float one is guarded by an `anyError` flag upstream declares `false`
/// and never assigns, so none of them can fail there. Kept as a *log* rather than
/// turned into a real comparison, because the values they would compare are not the
/// ones a conformant driver returns: `TEXTURE_BORDER_COLOR` read back through
/// `glGetTexParameteriv`/`glGetSamplerParameteriv` is the colour re-expanded over the
/// full integer range, not the colour rounded to an integer. Measured on llvmpipe, for
/// a border colour set to `(0.25, 1.0, 0.0, 0.77)`: `536870900, 2147483600, 0,
/// 1653562400`, against the `0, 1, 0, 1` these checks would demand. Making them fail
/// would disagree with every upstream run on hardware that is behaving correctly.
fn note_dead_range_check(component: usize, low: f32, high: f32, got: f32) {
    if got < low || got > high {
        log::debug!("// Note: component {component} is {got}, outside upstream's (unenforced) range [{low}, {high}]");
    }
}

/// `verifyFloatVec4`
pub fn verify_float_vec4(case: &mut ApiCase<'_>, state: QueriedState, expected: [f32; 4]) {
    let values = match state {
        QueriedState::FloatVec4(value) => {
            if value != expected {
                case.fail(
                    format!("Expected {expected:?}, got {value:?}"),
                    "Got invalid float value",
                );
            }
            return;
        }
        #[expect(clippy::cast_precision_loss, reason = "only logged, see note_dead_range_check")]
        QueriedState::IntegerVec4(value) => value.map(|v| v as f32),
        #[expect(clippy::cast_precision_loss, reason = "as above")]
        QueriedState::UnsignedVec4(value) => value.map(|v| v as f32),
        _ => {
            case.fail(format!("{state:?} is not a vec4 state"), "Got invalid value");
            return;
        }
    };

    for ndx in 0..4 {
        note_dead_range_check(
            ndx,
            round_half_down(expected[ndx]),
            round_half_up(expected[ndx]),
            values[ndx],
        );
    }
}

/// `normalizeI32Float`
#[expect(clippy::cast_precision_loss, reason = "upstream divides the same way")]
fn normalize_i32_float(value: GLint) -> f32 {
    (value as f32 / ((1u64 << 31) - 1) as f32).max(-1.0)
}

/// `verifyNormalizedI32Vec4` - the border color set through `glTexParameteriv`, read
/// back after the implementation normalised it into a float.
pub fn verify_normalized_i32_vec4(case: &mut ApiCase<'_>, state: QueriedState, expected: [GLint; 4]) {
    // normalization precision is irrelevant for these tests, we can use very large thresholds
    const NORMALIZATION_ERROR: f32 = 0.1;
    let reference = expected.map(normalize_i32_float);
    let valid_high = reference.map(|v| (v + NORMALIZATION_ERROR).min(1.0));
    let valid_low = reference.map(|v| (v - NORMALIZATION_ERROR).max(-1.0));

    match state {
        QueriedState::FloatVec4(value) => {
            for ndx in 0..4 {
                note_dead_range_check(ndx, valid_low[ndx], valid_high[ndx], value[ndx]);
            }
        }
        QueriedState::IntegerVec4(value) => {
            for ndx in 0..4 {
                #[expect(clippy::cast_precision_loss, reason = "only logged, see note_dead_range_check")]
                let as_float = value[ndx] as f32;
                note_dead_range_check(
                    ndx,
                    round_half_down(valid_high[ndx]),
                    round_half_up(valid_low[ndx]),
                    as_float,
                );
            }
        }
        _ => case.fail(format!("{state:?} is not a normalized vec4 state"), "Got invalid value"),
    }
}

/// `verifyPointer`
pub fn verify_pointer(case: &mut ApiCase<'_>, state: QueriedState, expected: *const std::ffi::c_void) {
    match state {
        QueriedState::Pointer(value) => {
            if value.cast_const() != expected {
                case.fail(
                    format!("Expected {expected:p}, got {value:p}"),
                    "Got invalid pointer value",
                );
            }
        }
        _ => case.fail(format!("{state:?} is not a pointer state"), "Got invalid value"),
    }
}

/// `verifyStatePointer`
pub fn verify_state_pointer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    expected: *const std::ffi::c_void,
    query_type: QueryType,
) {
    if let Some(state) = query_pointer_state(case, query_type, target) {
        verify_pointer(case, state, expected);
    }
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
pub fn verify_state_indexed_boolean(
    case: &mut ApiCase<'_>,
    target: GLenum,
    index: GLuint,
    reference: bool,
    query_type: QueryType,
) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_boolean(case, state, reference);
    }
}

/// `verifyStateIndexedInteger`
pub fn verify_state_indexed_integer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    index: GLuint,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateIndexedIntegerMin`
pub fn verify_state_indexed_integer_min(
    case: &mut ApiCase<'_>,
    target: GLenum,
    index: GLuint,
    min_value: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_integer_min(case, state, min_value);
    }
}

/// `verifyStateIndexedBooleanVec4`
pub fn verify_state_indexed_boolean_vec4(
    case: &mut ApiCase<'_>,
    target: GLenum,
    index: GLuint,
    reference: [bool; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_indexed_state(case, query_type, target, index) {
        verify_boolean_vec4(case, state, reference);
    }
}

/// `verifyStateAttributeInteger`
pub fn verify_state_attribute_integer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    index: GLuint,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_attribute_state(case, query_type, target, index) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateProgramInteger`
pub fn verify_state_program_integer(
    case: &mut ApiCase<'_>,
    program: GLuint,
    pname: GLenum,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_program_state(case, query_type, program, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStatePipelineInteger`
pub fn verify_state_pipeline_integer(
    case: &mut ApiCase<'_>,
    pipeline: GLuint,
    pname: GLenum,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_pipeline_state(case, query_type, pipeline, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateFramebufferInteger`
pub fn verify_state_framebuffer_integer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_framebuffer_state(case, query_type, target, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateFramebufferIntegerMin`
pub fn verify_state_framebuffer_integer_min(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    min_value: i32,
    query_type: QueryType,
) {
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

/// `queryTextureParamState`
pub fn query_texture_param_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    target: GLenum,
    pname: GLenum,
) -> Option<QueriedState> {
    // SAFETY: one output each, guarded on both sides; a texture is bound to `target`.
    unsafe {
        match query_type {
            QueryType::TextureParamInteger => {
                let mut value = Guarded::<GLint>::new();
                case.gl().get_tex_parameteriv(target, pname, value.as_mut_ptr());
                if !check_error(case, "glGetTexParameteriv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Integer(value.value()))
            }
            QueryType::TextureParamFloat => {
                let mut value = Guarded::<f32>::new();
                case.gl().get_tex_parameterfv(target, pname, value.as_mut_ptr());
                if !check_error(case, "glGetTexParameterfv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Float(value.value()))
            }
            QueryType::TextureParamPureInteger => {
                let mut value = Guarded::<GLint>::new();
                case.gl().get_tex_parameter_iiv(target, pname, value.as_mut_ptr());
                if !check_error(case, "GetTexParameterIiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Integer(value.value()))
            }
            QueryType::TextureParamPureUnsignedInteger => {
                let mut value = Guarded::<GLuint>::new();
                case.gl().get_tex_parameter_iuiv(target, pname, value.as_mut_ptr());
                if !check_error(case, "GetTexParameterIuiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Unsigned(value.value()))
            }
            QueryType::TextureParamIntegerVec4 => {
                let mut value = Guarded::<[GLint; 4]>::new();
                case.gl()
                    .get_tex_parameteriv(target, pname, value.as_mut_ptr().cast::<GLint>());
                if !check_error(case, "glGetTexParameteriv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::IntegerVec4(value.value()))
            }
            QueryType::TextureParamFloatVec4 => {
                let mut value = Guarded::<[f32; 4]>::new();
                case.gl()
                    .get_tex_parameterfv(target, pname, value.as_mut_ptr().cast::<f32>());
                if !check_error(case, "glGetTexParameterfv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::FloatVec4(value.value()))
            }
            QueryType::TextureParamPureIntegerVec4 => {
                let mut value = Guarded::<[GLint; 4]>::new();
                case.gl()
                    .get_tex_parameter_iiv(target, pname, value.as_mut_ptr().cast::<GLint>());
                if !check_error(case, "GetTexParameterIiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::IntegerVec4(value.value()))
            }
            QueryType::TextureParamPureUnsignedIntegerVec4 => {
                let mut value = Guarded::<[GLuint; 4]>::new();
                case.gl()
                    .get_tex_parameter_iuiv(target, pname, value.as_mut_ptr().cast::<GLuint>());
                if !check_error(case, "GetTexParameterIuiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::UnsignedVec4(value.value()))
            }
            other => panic!("{other:?} is not a texture-parameter query"),
        }
    }
}

/// `querySamplerParamState`
pub fn query_sampler_param_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    sampler: GLuint,
    pname: GLenum,
) -> Option<QueriedState> {
    // SAFETY: one output each, guarded on both sides; `sampler` is a live sampler name.
    unsafe {
        match query_type {
            QueryType::SamplerParamInteger => {
                let mut value = Guarded::<GLint>::new();
                case.gl().get_sampler_parameteriv(sampler, pname, value.as_mut_ptr());
                if !check_error(case, "glGetSamplerParameteriv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Integer(value.value()))
            }
            QueryType::SamplerParamFloat => {
                let mut value = Guarded::<f32>::new();
                case.gl().get_sampler_parameterfv(sampler, pname, value.as_mut_ptr());
                if !check_error(case, "glGetSamplerParameterfv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Float(value.value()))
            }
            QueryType::SamplerParamPureInteger => {
                let mut value = Guarded::<GLint>::new();
                case.gl().get_sampler_parameter_iiv(sampler, pname, value.as_mut_ptr());
                if !check_error(case, "GetSamplerParameterIiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Integer(value.value()))
            }
            QueryType::SamplerParamPureUnsignedInteger => {
                let mut value = Guarded::<GLuint>::new();
                case.gl().get_sampler_parameter_iuiv(sampler, pname, value.as_mut_ptr());
                if !check_error(case, "GetSamplerParameterIuiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Unsigned(value.value()))
            }
            QueryType::SamplerParamIntegerVec4 => {
                let mut value = Guarded::<[GLint; 4]>::new();
                case.gl()
                    .get_sampler_parameteriv(sampler, pname, value.as_mut_ptr().cast::<GLint>());
                if !check_error(case, "glGetSamplerParameteriv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::IntegerVec4(value.value()))
            }
            QueryType::SamplerParamFloatVec4 => {
                let mut value = Guarded::<[f32; 4]>::new();
                case.gl()
                    .get_sampler_parameterfv(sampler, pname, value.as_mut_ptr().cast::<f32>());
                if !check_error(case, "glGetSamplerParameterfv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::FloatVec4(value.value()))
            }
            QueryType::SamplerParamPureIntegerVec4 => {
                let mut value = Guarded::<[GLint; 4]>::new();
                case.gl()
                    .get_sampler_parameter_iiv(sampler, pname, value.as_mut_ptr().cast::<GLint>());
                if !check_error(case, "GetSamplerParameterIiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::IntegerVec4(value.value()))
            }
            QueryType::SamplerParamPureUnsignedIntegerVec4 => {
                let mut value = Guarded::<[GLuint; 4]>::new();
                case.gl()
                    .get_sampler_parameter_iuiv(sampler, pname, value.as_mut_ptr().cast::<GLuint>());
                if !check_error(case, "GetSamplerParameterIuiv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::UnsignedVec4(value.value()))
            }
            other => panic!("{other:?} is not a sampler-parameter query"),
        }
    }
}

/// `queryTextureLevelState`
pub fn query_texture_level_state(
    case: &mut ApiCase<'_>,
    query_type: QueryType,
    target: GLenum,
    level: GLint,
    pname: GLenum,
) -> Option<QueriedState> {
    // SAFETY: one output, guarded on both sides; a texture is bound to `target`.
    unsafe {
        match query_type {
            QueryType::TextureLevelInteger => {
                let mut value = Guarded::<GLint>::new();
                case.gl()
                    .get_tex_level_parameteriv(target, level, pname, value.as_mut_ptr());
                if !check_error(case, "glGetTexLevelParameteriv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Integer(value.value()))
            }
            QueryType::TextureLevelFloat => {
                let mut value = Guarded::<f32>::new();
                case.gl()
                    .get_tex_level_parameterfv(target, level, pname, value.as_mut_ptr());
                if !check_error(case, "glGetTexLevelParameterfv") || !value.verify_validity(case) {
                    return None;
                }
                Some(QueriedState::Float(value.value()))
            }
            other => panic!("{other:?} is not a texture-level query"),
        }
    }
}

/// `verifyStateTextureParamInteger`
pub fn verify_state_texture_param_integer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_texture_param_state(case, query_type, target, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateTextureParamFloat`
pub fn verify_state_texture_param_float(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: f32,
    query_type: QueryType,
) {
    if let Some(state) = query_texture_param_state(case, query_type, target, pname) {
        verify_float(case, state, reference);
    }
}

/// `verifyStateSamplerParamInteger`
pub fn verify_state_sampler_param_integer(
    case: &mut ApiCase<'_>,
    sampler: GLuint,
    pname: GLenum,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_sampler_param_state(case, query_type, sampler, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateTextureParamIntegerVec4`
pub fn verify_state_texture_param_integer_vec4(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: [GLint; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_texture_param_state(case, query_type, target, pname) {
        verify_integer_vec4(case, state, reference);
    }
}

/// `verifyStateTextureParamUnsignedIntegerVec4`
pub fn verify_state_texture_param_unsigned_integer_vec4(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: [GLuint; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_texture_param_state(case, query_type, target, pname) {
        verify_unsigned_integer_vec4(case, state, reference);
    }
}

/// `verifyStateTextureParamFloatVec4`
pub fn verify_state_texture_param_float_vec4(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: [f32; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_texture_param_state(case, query_type, target, pname) {
        verify_float_vec4(case, state, reference);
    }
}

/// `verifyStateTextureParamNormalizedI32Vec4`
pub fn verify_state_texture_param_normalized_i32_vec4(
    case: &mut ApiCase<'_>,
    target: GLenum,
    pname: GLenum,
    reference: [GLint; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_texture_param_state(case, query_type, target, pname) {
        verify_normalized_i32_vec4(case, state, reference);
    }
}

/// `verifyStateSamplerParamFloat`
pub fn verify_state_sampler_param_float(
    case: &mut ApiCase<'_>,
    sampler: GLuint,
    pname: GLenum,
    reference: f32,
    query_type: QueryType,
) {
    if let Some(state) = query_sampler_param_state(case, query_type, sampler, pname) {
        verify_float(case, state, reference);
    }
}

/// `verifyStateSamplerParamIntegerVec4`
pub fn verify_state_sampler_param_integer_vec4(
    case: &mut ApiCase<'_>,
    sampler: GLuint,
    pname: GLenum,
    reference: [GLint; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_sampler_param_state(case, query_type, sampler, pname) {
        verify_integer_vec4(case, state, reference);
    }
}

/// `verifyStateSamplerParamUnsignedIntegerVec4`
pub fn verify_state_sampler_param_unsigned_integer_vec4(
    case: &mut ApiCase<'_>,
    sampler: GLuint,
    pname: GLenum,
    reference: [GLuint; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_sampler_param_state(case, query_type, sampler, pname) {
        verify_unsigned_integer_vec4(case, state, reference);
    }
}

/// `verifyStateSamplerParamFloatVec4`
pub fn verify_state_sampler_param_float_vec4(
    case: &mut ApiCase<'_>,
    sampler: GLuint,
    pname: GLenum,
    reference: [f32; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_sampler_param_state(case, query_type, sampler, pname) {
        verify_float_vec4(case, state, reference);
    }
}

/// `verifyStateSamplerParamNormalizedI32Vec4`
pub fn verify_state_sampler_param_normalized_i32_vec4(
    case: &mut ApiCase<'_>,
    sampler: GLuint,
    pname: GLenum,
    reference: [GLint; 4],
    query_type: QueryType,
) {
    if let Some(state) = query_sampler_param_state(case, query_type, sampler, pname) {
        verify_normalized_i32_vec4(case, state, reference);
    }
}

/// `verifyStateTextureLevelInteger`
pub fn verify_state_texture_level_integer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    level: GLint,
    pname: GLenum,
    reference: i32,
    query_type: QueryType,
) {
    if let Some(state) = query_texture_level_state(case, query_type, target, level, pname) {
        verify_integer(case, state, reference);
    }
}

/// `verifyStateObjectBoolean` for `QUERY_ISTEXTURE`
pub fn verify_state_texture_object_boolean(case: &mut ApiCase<'_>, texture: GLuint, reference: bool) {
    // SAFETY: `glIsTexture` accepts any name, live or not.
    let value = unsafe { case.gl().is_texture(texture) };
    if !verify_boolean_validity(case, value) {
        return;
    }
    verify_boolean(case, QueriedState::Boolean(value == glw::TRUE), reference);
}
