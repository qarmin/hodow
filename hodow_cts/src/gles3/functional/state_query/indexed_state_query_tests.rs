// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fIndexedStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// All fourteen upstream cases are here. The nine blend/color-mask ones need
// `gls::StateQueryUtil`'s indexed `QueryType` / `verifyStateIndexed*`, which is not
// in `gls`; the slice they use is at the bottom of this file, local to it.

use std::ffi::CString;

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_case, add_api_cases};
use crate::glw::{self, GLchar, GLenum, GLint, GLuint};

const TRANSFORM_FEEDBACK_TEST_VERT_SOURCE: &str = "#version 300 es\nout highp vec4 anotherOutput;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    anotherOutput = vec4(0.0);\n}\n";
const TRANSFORM_FEEDBACK_TEST_FRAG_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

const UNIFORM_TEST_VERT_SOURCE: &str = "#version 300 es\nuniform highp vec4 input1;\nuniform highp vec4 input2;\nvoid main (void)\n{\n    gl_Position = input1 + input2;\n}\n";
const UNIFORM_TEST_FRAG_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

/// `glShaderSource` with an owned source, since GL only borrows the pointer.
fn shader_source(case: &ApiCase<'_>, shader: GLuint, source: &str) {
    let owned = CString::new(source).expect("no interior nul");
    let pointer: *const GLchar = owned.as_ptr();
    // SAFETY: one live null-terminated string for the duration of the call; a null
    // `length` means "null-terminated".
    unsafe { case.gl().shader_source(shader, 1, &raw const pointer, std::ptr::null()) };
}

/// `TransformFeedbackCase::test` - `body` is `testTransformFeedback`, and gets the
/// three transform feedback names (the two generated plus the default, index 2).
fn with_transform_feedback(case: &mut ApiCase<'_>, body: impl FnOnce(&mut ApiCase<'_>, [GLuint; 3])) {
    let gl = case.gl();

    // SAFETY: fresh shader names.
    let shader_vert = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    let shader_frag = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };

    shader_source(case, shader_vert, TRANSFORM_FEEDBACK_TEST_VERT_SOURCE);
    shader_source(case, shader_frag, TRANSFORM_FEEDBACK_TEST_FRAG_SOURCE);

    // SAFETY: both sources were just set.
    unsafe {
        gl.compile_shader(shader_vert);
        gl.compile_shader(shader_frag);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a fresh program name; both shaders are live.
    let shader_prog = unsafe { gl.create_program() };
    let varyings: Vec<CString> = ["gl_Position", "anotherOutput"]
        .into_iter()
        .map(|name| CString::new(name).expect("no interior nul"))
        .collect();
    let varying_ptrs: Vec<*const GLchar> = varyings.iter().map(|name| name.as_ptr()).collect();
    // SAFETY: two live null-terminated varying names for the duration of the call.
    unsafe {
        gl.attach_shader(shader_prog, shader_vert);
        gl.attach_shader(shader_prog, shader_frag);
        gl.transform_feedback_varyings(shader_prog, 2, varying_ptrs.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS);
        gl.link_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);

    let mut transform_feedbacks = [0u32; 3];
    // SAFETY: two names out; the third slot holds the default object.
    unsafe { gl.gen_transform_feedbacks(2, transform_feedbacks.as_mut_ptr()) };
    transform_feedbacks[2] = 0;
    // SAFETY: the object was just generated.
    unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedbacks[0]) };
    case.expect_error(glw::GL_NO_ERROR);

    body(case, transform_feedbacks);

    // SAFETY: every name here is this case's own.
    unsafe {
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        gl.delete_transform_feedbacks(2, transform_feedbacks.as_ptr());
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `TransformFeedbackBufferBindingCase`
fn transform_feedback_buffer_binding(case: &mut ApiCase<'_>) {
    with_transform_feedback(case, |case, _| {
        let gl = case.gl();
        const FEEDBACK_INDEX: [GLuint; 2] = [0, 1];

        let mut feedback_buffers = [0u32; 2];
        // SAFETY: two fresh buffer names, deleted below.
        unsafe { gl.gen_buffers(2, feedback_buffers.as_mut_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        for ndx in 0..2 {
            // SAFETY: a null data pointer only allocates.
            unsafe {
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buffers[ndx]);
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    16,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_READ,
                );
                gl.bind_buffer_base(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    FEEDBACK_INDEX[ndx],
                    feedback_buffers[ndx],
                );
            }
            case.expect_error(glw::GL_NO_ERROR);
        }

        for ndx in 0..2 {
            let mut bound_buffer = Guarded::<GLint>::new();
            // SAFETY: one GLint out, guarded on both sides.
            unsafe {
                gl.get_integeri_v(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
                    FEEDBACK_INDEX[ndx],
                    bound_buffer.as_mut_ptr(),
                );
            }
            // Upstream ignores the return here and compares anyway.
            bound_buffer.verify_validity(case);
            let got = bound_buffer.value();
            case.check_int_equals(got, feedback_buffers[ndx] as i32);
        }

        // SAFETY: the names are this case's own.
        unsafe { gl.delete_buffers(2, feedback_buffers.as_ptr()) };
    });
}

/// `TransformFeedbackBufferBufferCase`
fn transform_feedback_buffer_start_size(case: &mut ApiCase<'_>) {
    with_transform_feedback(case, |case, _| {
        let gl = case.gl();
        const FEEDBACK_POSITION_INDEX: GLuint = 0;
        const FEEDBACK_OUTPUT_INDEX: GLuint = 1;
        const RANGE_BUFFER_OFFSET: i64 = 4;
        const RANGE_BUFFER_SIZE: i64 = 8;

        let mut feedback_buffers = [0u32; 2];
        // SAFETY: two fresh buffer names, deleted below.
        unsafe { gl.gen_buffers(2, feedback_buffers.as_mut_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: a null data pointer only allocates.
        unsafe {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buffers[0]);
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                16,
                std::ptr::null(),
                glw::GL_DYNAMIC_READ,
            );
            gl.bind_buffer_base(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                FEEDBACK_POSITION_INDEX,
                feedback_buffers[0],
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: the range is inside the 16-byte allocation.
        unsafe {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buffers[1]);
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                16,
                std::ptr::null(),
                glw::GL_DYNAMIC_READ,
            );
            gl.bind_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                FEEDBACK_OUTPUT_INDEX,
                feedback_buffers[1],
                RANGE_BUFFER_OFFSET as isize,
                RANGE_BUFFER_SIZE as isize,
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        let requirements: [(GLuint, GLenum, i64); 4] = [
            (FEEDBACK_POSITION_INDEX, glw::GL_TRANSFORM_FEEDBACK_BUFFER_START, 0),
            (FEEDBACK_POSITION_INDEX, glw::GL_TRANSFORM_FEEDBACK_BUFFER_SIZE, 0),
            (
                FEEDBACK_OUTPUT_INDEX,
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_START,
                RANGE_BUFFER_OFFSET,
            ),
            (
                FEEDBACK_OUTPUT_INDEX,
                glw::GL_TRANSFORM_FEEDBACK_BUFFER_SIZE,
                RANGE_BUFFER_SIZE,
            ),
        ];

        for (index, pname, value) in requirements {
            let mut state = Guarded::<i64>::new();
            // SAFETY: one GLint64 out, guarded on both sides.
            unsafe { gl.get_integer_64i_v(pname, index, state.as_mut_ptr()) };
            if state.verify_validity(case) && state.value() != value {
                case.fail(format!("expected {value}; got {}", state.value()), "got invalid value");
            }
        }

        // SAFETY: the names are this case's own.
        unsafe { gl.delete_buffers(2, feedback_buffers.as_ptr()) };
    });
}

/// `TransformFeedbackSwitchingBufferCase`
fn transform_feedback_switching_buffer(case: &mut ApiCase<'_>) {
    with_transform_feedback(case, |case, transform_feedbacks| {
        let gl = case.gl();

        let mut feedback_buffers = [0u32; 3];
        // SAFETY: three fresh buffer names, deleted below.
        unsafe { gl.gen_buffers(3, feedback_buffers.as_mut_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        for i in 0..3 {
            // SAFETY: the object was generated by `with_transform_feedback`.
            unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedbacks[i]) };
            case.expect_error(glw::GL_NO_ERROR);

            let mut value = 0;
            // SAFETY: one GLint out.
            unsafe { gl.get_integeri_v(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut value) };
            case.expect_error(glw::GL_NO_ERROR);
            case.check_int_equals(value, 0);

            // SAFETY: the buffer name is this case's own.
            unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, feedback_buffers[i]) };
            case.expect_error(glw::GL_NO_ERROR);

            // glBindBufferBase should also set the generic binding point.
            // SAFETY: one GLint out.
            unsafe { gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, &mut value) };
            case.expect_error(glw::GL_NO_ERROR);
            case.check_int_equals(value, feedback_buffers[i] as i32);
        }

        for i in 0..3 {
            // glBindTransformFeedback should change the indexed binding points, but
            // not the generic one.
            // SAFETY: as above.
            unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedbacks[i]) };
            case.expect_error(glw::GL_NO_ERROR);

            let mut value = 0;
            // SAFETY: one GLint out.
            unsafe { gl.get_integeri_v(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut value) };
            case.expect_error(glw::GL_NO_ERROR);
            case.check_int_equals(value, feedback_buffers[i] as i32);

            // SAFETY: one GLint out.
            unsafe { gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, &mut value) };
            case.expect_error(glw::GL_NO_ERROR);
            case.check_int_equals(value, feedback_buffers[2] as i32);
        }

        // SAFETY: as above.
        unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedbacks[0]) };
        case.expect_error(glw::GL_NO_ERROR);
        // SAFETY: the names are this case's own.
        unsafe { gl.delete_buffers(3, feedback_buffers.as_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        // After deleting buffers the bound state should be changed but unbound state
        // should be unchanged.
        let mut value = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integeri_v(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut value) };
        case.expect_error(glw::GL_NO_ERROR);
        case.check_int_equals(value, 0);
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, &mut value) };
        case.expect_error(glw::GL_NO_ERROR);
        case.check_int_equals(value, 0);

        for i in 1..3 {
            // SAFETY: as above.
            unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedbacks[i]) };
            case.expect_error(glw::GL_NO_ERROR);
            // SAFETY: one GLint out.
            unsafe { gl.get_integeri_v(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut value) };
            case.expect_error(glw::GL_NO_ERROR);
            case.check_int_equals(value, feedback_buffers[i] as i32);
            // SAFETY: one GLint out.
            unsafe { gl.get_integerv(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, &mut value) };
            case.expect_error(glw::GL_NO_ERROR);
            case.check_int_equals(value, 0);
        }
    });
}

/// `UniformBufferCase::test` - `body` is `testUniformBuffers`, and gets the program.
fn with_uniform_program(case: &mut ApiCase<'_>, body: impl FnOnce(&mut ApiCase<'_>, GLuint)) {
    let gl = case.gl();

    // SAFETY: fresh shader names.
    let shader_vert = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    let shader_frag = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };

    shader_source(case, shader_vert, UNIFORM_TEST_VERT_SOURCE);
    shader_source(case, shader_frag, UNIFORM_TEST_FRAG_SOURCE);

    // SAFETY: both sources were just set.
    unsafe {
        gl.compile_shader(shader_vert);
        gl.compile_shader(shader_frag);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a fresh program name; both shaders are live.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
        gl.use_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);

    body(case, program);

    // SAFETY: every name here is this case's own.
    unsafe {
        gl.use_program(0);
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `glGetUniformIndices` for the two uniforms both uniform cases use.
fn uniform_indices(case: &ApiCase<'_>, program: GLuint) -> [GLuint; 2] {
    let names: Vec<CString> = ["input1", "input2"]
        .into_iter()
        .map(|n| CString::new(n).expect("no interior nul"))
        .collect();
    let name_ptrs: Vec<*const GLchar> = names.iter().map(|n| n.as_ptr()).collect();
    let mut indices = [0u32; 2];
    // SAFETY: two live null-terminated names in, two GLuints out.
    unsafe {
        case.gl()
            .get_uniform_indices(program, 2, name_ptrs.as_ptr(), indices.as_mut_ptr())
    };
    indices
}

/// `UniformBufferBindingCase`
fn uniform_buffer_binding(case: &mut ApiCase<'_>) {
    with_uniform_program(case, |case, program| {
        let indices = uniform_indices(case, program);
        let gl = case.gl();

        let mut buffers = [0u32; 2];
        // SAFETY: two fresh buffer names, deleted below.
        unsafe { gl.gen_buffers(2, buffers.as_mut_ptr()) };

        for ndx in 0..2 {
            // SAFETY: a null data pointer only allocates.
            unsafe {
                gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buffers[ndx]);
                gl.buffer_data(glw::GL_UNIFORM_BUFFER, 32, std::ptr::null(), glw::GL_DYNAMIC_DRAW);
                gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, indices[ndx], buffers[ndx]);
            }
            case.expect_error(glw::GL_NO_ERROR);
        }

        for ndx in 0..2 {
            let mut bound_buffer = Guarded::<GLint>::new();
            // SAFETY: one GLint out, guarded on both sides.
            unsafe { gl.get_integeri_v(glw::GL_UNIFORM_BUFFER_BINDING, indices[ndx], bound_buffer.as_mut_ptr()) };
            if bound_buffer.verify_validity(case) {
                let got = bound_buffer.value();
                case.check_int_equals(got, buffers[ndx] as i32);
            }
            case.expect_error(glw::GL_NO_ERROR);
        }

        // SAFETY: the names are this case's own.
        unsafe { gl.delete_buffers(2, buffers.as_ptr()) };
    });
}

/// `UniformBufferBufferCase::GetAlignment` - `None` means the case cannot continue.
fn get_alignment(case: &mut ApiCase<'_>) -> Option<GLint> {
    let gl = case.gl();
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe { gl.get_integerv(glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT, state.as_mut_ptr()) };

    if !state.verify_validity(case) {
        return None;
    }
    if state.value() <= 256 {
        return Some(state.value());
    }

    case.fail(
        "UNIFORM_BUFFER_OFFSET_ALIGNMENT has a maximum value of 256".to_string(),
        "invalid UNIFORM_BUFFER_OFFSET_ALIGNMENT value",
    );
    None
}

/// `UniformBufferBufferCase`
fn uniform_buffer_start_size(case: &mut ApiCase<'_>) {
    with_uniform_program(case, |case, program| {
        let indices = uniform_indices(case, program);

        let Some(alignment) = get_alignment(case) else {
            return;
        };
        log::debug!("Alignment is {alignment}");

        let range_buffer_offset = alignment;
        let range_buffer_size = alignment * 2;
        // The + 8 has no special meaning; it only makes the total differ from the range.
        let range_buffer_total_size = range_buffer_offset + range_buffer_size + 8;

        let gl = case.gl();
        let mut buffers = [0u32; 2];
        // SAFETY: two fresh buffer names, deleted below.
        unsafe { gl.gen_buffers(2, buffers.as_mut_ptr()) };

        // SAFETY: a null data pointer only allocates.
        unsafe {
            gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buffers[0]);
            gl.buffer_data(glw::GL_UNIFORM_BUFFER, 32, std::ptr::null(), glw::GL_DYNAMIC_DRAW);
            gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, indices[0], buffers[0]);
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: the range is inside the allocation and aligned as the driver asked.
        unsafe {
            gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buffers[1]);
            gl.buffer_data(
                glw::GL_UNIFORM_BUFFER,
                range_buffer_total_size as isize,
                std::ptr::null(),
                glw::GL_DYNAMIC_DRAW,
            );
            gl.bind_buffer_range(
                glw::GL_UNIFORM_BUFFER,
                indices[1],
                buffers[1],
                range_buffer_offset as isize,
                range_buffer_size as isize,
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        let requirements: [(GLuint, GLenum, i64); 4] = [
            (indices[0], glw::GL_UNIFORM_BUFFER_START, 0),
            (indices[0], glw::GL_UNIFORM_BUFFER_SIZE, 0),
            (indices[1], glw::GL_UNIFORM_BUFFER_START, i64::from(range_buffer_offset)),
            (indices[1], glw::GL_UNIFORM_BUFFER_SIZE, i64::from(range_buffer_size)),
        ];

        for (index, pname, value) in requirements {
            let mut state = Guarded::<i64>::new();
            // SAFETY: one GLint64 out, guarded on both sides.
            unsafe { gl.get_integer_64i_v(pname, index, state.as_mut_ptr()) };
            if state.verify_validity(case) && state.value() != value {
                case.fail(format!("expected {value}; got {}", state.value()), "got invalid value");
            }
            case.expect_error(glw::GL_NO_ERROR);
        }

        // SAFETY: the names are this case's own.
        unsafe { gl.delete_buffers(2, buffers.as_ptr()) };
    });
}

// ---------------------------------------------------------------------------------
// The `gls::StateQueryUtil` slice the remaining nine cases need, kept local because it
// reports through this file's own `ResultCollector`-style helper rather than through
// `gls::state_query_util`'s `ApiCase`. Everything else state-query now goes through the
// shared module.
// ---------------------------------------------------------------------------------

/// `gls::StateQueryUtil::QueryType`, restricted to the indexed entry points this
/// file queries through.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Verifier {
    IsEnabled,
    Integer,
    Integer64,
    IntegerVec4,
    Integer64Vec4,
}

impl Verifier {
    /// `getVerifierSuffix` - note the VEC4 forms share the scalar suffix upstream.
    fn suffix(self) -> &'static str {
        match self {
            Self::IsEnabled => "isenabledi",
            Self::Integer | Self::IntegerVec4 => "getintegeri_v",
            Self::Integer64 | Self::Integer64Vec4 => "getinteger64i_v",
        }
    }
}

/// `verifyStateIndexedBoolean`
fn verify_indexed_boolean(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, expected: bool, verifier: Verifier) {
    match verifier {
        Verifier::IsEnabled => {
            // SAFETY: a plain enum/index query.
            let value = unsafe { case.gl().is_enabledi(target, index) };
            if value != glw::TRUE && value != glw::FALSE {
                case.fail(
                    format!("Boolean value was not GL_TRUE or GL_FALSE, got {value:#x}"),
                    "Got invalid boolean value",
                );
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            let got = value != glw::FALSE;
            if got != expected {
                case.fail(format!("Expected {expected}, got {got}"), "Got invalid state value");
            }
        }
        Verifier::Integer => {
            let mut state = Guarded::<GLint>::new();
            // SAFETY: one GLint out, guarded on both sides.
            unsafe { case.gl().get_integeri_v(target, index, state.as_mut_ptr()) };
            if !state.verify_validity(case) {
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            let got = state.value() != 0;
            if got != expected {
                case.fail(
                    format!("Expected {expected}, got {}", state.value()),
                    "Got invalid state value",
                );
            }
        }
        Verifier::Integer64 => {
            let mut state = Guarded::<i64>::new();
            // SAFETY: one GLint64 out, guarded on both sides.
            unsafe { case.gl().get_integer_64i_v(target, index, state.as_mut_ptr()) };
            if !state.verify_validity(case) {
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            let got = state.value() != 0;
            if got != expected {
                case.fail(
                    format!("Expected {expected}, got {}", state.value()),
                    "Got invalid state value",
                );
            }
        }
        Verifier::IntegerVec4 | Verifier::Integer64Vec4 => {
            case.fail(
                "vec4 verifier used for a scalar boolean".to_string(),
                "Invalid verifier",
            );
        }
    }
}

/// `verifyStateIndexedBooleanVec4`
fn verify_indexed_boolean_vec4(
    case: &mut ApiCase<'_>,
    target: GLenum,
    index: GLuint,
    expected: [bool; 4],
    verifier: Verifier,
) {
    match verifier {
        Verifier::IntegerVec4 => {
            let mut state = Guarded::<[GLint; 4]>::new();
            // SAFETY: four GLints out, guarded on both sides.
            unsafe {
                case.gl()
                    .get_integeri_v(target, index, state.as_mut_ptr().cast::<GLint>())
            };
            if !state.verify_validity(case) {
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            let got = state.value().map(|v| v != 0);
            if got != expected {
                case.fail(format!("Expected {expected:?}, got {got:?}"), "Got invalid state value");
            }
        }
        Verifier::Integer64Vec4 => {
            let mut state = Guarded::<[i64; 4]>::new();
            // SAFETY: four GLint64s out, guarded on both sides.
            unsafe {
                case.gl()
                    .get_integer_64i_v(target, index, state.as_mut_ptr().cast::<glw::GLint64>())
            };
            if !state.verify_validity(case) {
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            let got = state.value().map(|v| v != 0);
            if got != expected {
                case.fail(format!("Expected {expected:?}, got {got:?}"), "Got invalid state value");
            }
        }
        _ => case.fail(
            "scalar verifier used for a vec4 boolean".to_string(),
            "Invalid verifier",
        ),
    }
}

/// `verifyStateIndexedInteger`
fn verify_indexed_integer(case: &mut ApiCase<'_>, target: GLenum, index: GLuint, expected: GLint, verifier: Verifier) {
    match verifier {
        Verifier::Integer => {
            let mut state = Guarded::<GLint>::new();
            // SAFETY: one GLint out, guarded on both sides.
            unsafe { case.gl().get_integeri_v(target, index, state.as_mut_ptr()) };
            if !state.verify_validity(case) {
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            if state.value() != expected {
                case.fail(
                    format!("Expected {expected}, got {}", state.value()),
                    "Got invalid state value",
                );
            }
        }
        Verifier::Integer64 => {
            let mut state = Guarded::<i64>::new();
            // SAFETY: one GLint64 out, guarded on both sides.
            unsafe { case.gl().get_integer_64i_v(target, index, state.as_mut_ptr()) };
            if !state.verify_validity(case) {
                return;
            }
            case.expect_error(glw::GL_NO_ERROR);
            if state.value() != i64::from(expected) {
                case.fail(
                    format!("Expected {expected}, got {}", state.value()),
                    "Got invalid state value",
                );
            }
        }
        _ => case.fail("wrong verifier for an indexed integer".to_string(), "Invalid verifier"),
    }
}

/// `isExtensionSupported` - the two extensions upstream special-cases are also core
/// in ES 3.2.
fn require_extension(case: &mut ApiCase<'_>, extension: &str) -> bool {
    if case.context().context_type().supports(3, 2) {
        return true;
    }
    if case.context().context_info.is_extension_supported(extension) {
        return true;
    }
    case.not_supported(format!("Extension {extension} not supported."));
    false
}

/// `EnableBlendCase::init` + `iterate`
fn enable_blend_case(case: &mut ApiCase<'_>, verifier: Verifier) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean(case, glw::GL_BLEND, ndx as GLuint, false, verifier);
        }
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().enable(glw::GL_BLEND) };
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean(case, glw::GL_BLEND, ndx as GLuint, true, verifier);
        }
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            set_blend_indexed(case, ndx);
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean(case, glw::GL_BLEND, ndx as GLuint, ndx % 2 == 0, verifier);
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            set_blend_indexed(case, ndx);
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().enable(glw::GL_BLEND) };
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean(case, glw::GL_BLEND, ndx as GLuint, true, verifier);
        }
    }
}

/// The `glEnablei`/`glDisablei` row upstream writes out twice, verbatim.
fn set_blend_indexed(case: &mut ApiCase<'_>, ndx: GLint) {
    // SAFETY: a plain enum/index setter.
    unsafe {
        if ndx % 2 == 0 {
            case.gl().enablei(glw::GL_BLEND, ndx as GLuint);
        } else {
            case.gl().disablei(glw::GL_BLEND, ndx as GLuint);
        }
    }
}

/// `ColorMaskCase::init` + `iterate`
fn color_mask_case(case: &mut ApiCase<'_>, verifier: Verifier) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean_vec4(case, glw::GL_COLOR_WRITEMASK, ndx as GLuint, [true; 4], verifier);
        }
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().color_mask(glw::FALSE, glw::TRUE, glw::TRUE, glw::FALSE) };
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean_vec4(
                case,
                glw::GL_COLOR_WRITEMASK,
                ndx as GLuint,
                [false, true, true, false],
                verifier,
            );
        }
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            set_color_maski(case, ndx);
        }
        for ndx in 0..max_draw_buffers {
            let expected = if ndx % 2 == 0 {
                [true, false, true, false]
            } else {
                [false, true, false, true]
            };
            verify_indexed_boolean_vec4(case, glw::GL_COLOR_WRITEMASK, ndx as GLuint, expected, verifier);
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            set_color_maski(case, ndx);
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().color_mask(glw::FALSE, glw::TRUE, glw::TRUE, glw::FALSE) };
        for ndx in 0..max_draw_buffers {
            verify_indexed_boolean_vec4(
                case,
                glw::GL_COLOR_WRITEMASK,
                ndx as GLuint,
                [false, true, true, false],
                verifier,
            );
        }
    }
}

/// The `glColorMaski` row upstream writes out twice, verbatim.
fn set_color_maski(case: &mut ApiCase<'_>, ndx: GLint) {
    let even = ndx % 2 == 0;
    let a = if even { glw::TRUE } else { glw::FALSE };
    let b = if even { glw::FALSE } else { glw::TRUE };
    // SAFETY: a plain index/state setter.
    unsafe { case.gl().color_maski(ndx as GLuint, a, b, a, b) };
}

const BLEND_FUNCS: [GLenum; 15] = [
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

const BLEND_EQUATIONS: [GLenum; 5] = [
    glw::GL_FUNC_ADD,
    glw::GL_FUNC_SUBTRACT,
    glw::GL_FUNC_REVERSE_SUBTRACT,
    glw::GL_MIN,
    glw::GL_MAX,
];

const BLEND_EQUATION_ADVANCED: [GLenum; 15] = [
    glw::GL_MULTIPLY,
    glw::GL_SCREEN,
    glw::GL_OVERLAY,
    glw::GL_DARKEN,
    glw::GL_LIGHTEN,
    glw::GL_COLORDODGE,
    glw::GL_COLORBURN,
    glw::GL_HARDLIGHT,
    glw::GL_SOFTLIGHT,
    glw::GL_DIFFERENCE,
    glw::GL_EXCLUSION,
    glw::GL_HSL_HUE,
    glw::GL_HSL_SATURATION,
    glw::GL_HSL_COLOR,
    glw::GL_HSL_LUMINOSITY,
];

fn func_at(ndx: GLint, offset: usize) -> GLenum {
    BLEND_FUNCS[(ndx as usize + offset) % BLEND_FUNCS.len()]
}

fn equation_at(ndx: GLint, offset: usize) -> GLenum {
    BLEND_EQUATIONS[(ndx as usize + offset) % BLEND_EQUATIONS.len()]
}

fn advanced_at(ndx: GLint) -> GLenum {
    BLEND_EQUATION_ADVANCED[ndx as usize % BLEND_EQUATION_ADVANCED.len()]
}

/// The four `GL_BLEND_{SRC,DST}_{RGB,ALPHA}` verifications upstream writes as four
/// separate loops.
fn verify_blend_funcs(case: &mut ApiCase<'_>, max_draw_buffers: GLint, expected: [GLenum; 4], verifier: Verifier) {
    for (target, value) in [
        (glw::GL_BLEND_SRC_RGB, expected[0]),
        (glw::GL_BLEND_DST_RGB, expected[1]),
        (glw::GL_BLEND_SRC_ALPHA, expected[2]),
        (glw::GL_BLEND_DST_ALPHA, expected[3]),
    ] {
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(case, target, ndx as GLuint, value as GLint, verifier);
        }
    }
}

/// `BlendFuncCase::init` + `iterate`
fn blend_func_case(case: &mut ApiCase<'_>, verifier: Verifier) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [glw::GL_ONE, glw::GL_ZERO, glw::GL_ONE, glw::GL_ZERO],
            verifier,
        );
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_func(glw::GL_SRC_ALPHA, glw::GL_DST_ALPHA) };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
            ],
            verifier,
        );
    }
    {
        case.section("After setting common separate");
        // SAFETY: a plain state setter.
        unsafe {
            case.gl().blend_func_separate(
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            )
        };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            ],
            verifier,
        );
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_funci(ndx as GLuint, func_at(ndx, 0), func_at(ndx, 1)) };
        }
        for ndx in 0..max_draw_buffers {
            for (target, value) in [
                (glw::GL_BLEND_SRC_RGB, func_at(ndx, 0)),
                (glw::GL_BLEND_DST_RGB, func_at(ndx, 1)),
                (glw::GL_BLEND_SRC_ALPHA, func_at(ndx, 0)),
                (glw::GL_BLEND_DST_ALPHA, func_at(ndx, 1)),
            ] {
                verify_indexed_integer(case, target, ndx as GLuint, value as GLint, verifier);
            }
        }
    }
    {
        case.section("After setting indexed separate");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl().blend_func_separatei(
                    ndx as GLuint,
                    func_at(ndx, 3),
                    func_at(ndx, 2),
                    func_at(ndx, 1),
                    func_at(ndx, 0),
                )
            };
        }
        for ndx in 0..max_draw_buffers {
            for (target, value) in [
                (glw::GL_BLEND_SRC_RGB, func_at(ndx, 3)),
                (glw::GL_BLEND_DST_RGB, func_at(ndx, 2)),
                (glw::GL_BLEND_SRC_ALPHA, func_at(ndx, 1)),
                (glw::GL_BLEND_DST_ALPHA, func_at(ndx, 0)),
            ] {
                verify_indexed_integer(case, target, ndx as GLuint, value as GLint, verifier);
            }
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_funci(ndx as GLuint, func_at(ndx, 0), func_at(ndx, 1)) };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_func(glw::GL_SRC_ALPHA, glw::GL_DST_ALPHA) };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
            ],
            verifier,
        );
    }
    {
        case.section("After resetting indexed with common separate");
        // SAFETY: a plain state setter. Upstream sets the common separate func both
        // before and after the indexed loop; kept as-is.
        unsafe {
            case.gl().blend_func_separate(
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            )
        };
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl().blend_func_separatei(
                    ndx as GLuint,
                    func_at(ndx, 3),
                    func_at(ndx, 2),
                    func_at(ndx, 1),
                    func_at(ndx, 0),
                )
            };
        }
        // SAFETY: a plain state setter.
        unsafe {
            case.gl().blend_func_separate(
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            )
        };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            ],
            verifier,
        );
    }
}

/// The two `GL_BLEND_EQUATION_{RGB,ALPHA}` loops upstream writes out separately.
fn verify_blend_equations(
    case: &mut ApiCase<'_>,
    max_draw_buffers: GLint,
    rgb: GLenum,
    alpha: GLenum,
    verifier: Verifier,
) {
    for ndx in 0..max_draw_buffers {
        verify_indexed_integer(case, glw::GL_BLEND_EQUATION_RGB, ndx as GLuint, rgb as GLint, verifier);
    }
    for ndx in 0..max_draw_buffers {
        verify_indexed_integer(
            case,
            glw::GL_BLEND_EQUATION_ALPHA,
            ndx as GLuint,
            alpha as GLint,
            verifier,
        );
    }
}

/// `BlendEquationCase::init` + `iterate`
fn blend_equation_case(case: &mut ApiCase<'_>, verifier: Verifier) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        verify_blend_equations(case, max_draw_buffers, glw::GL_FUNC_ADD, glw::GL_FUNC_ADD, verifier);
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_FUNC_SUBTRACT) };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
    {
        case.section("After setting common separate");
        // SAFETY: a plain state setter.
        unsafe {
            case.gl()
                .blend_equation_separate(glw::GL_FUNC_REVERSE_SUBTRACT, glw::GL_FUNC_SUBTRACT)
        };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_REVERSE_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, equation_at(ndx, 0)) };
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_RGB,
                ndx as GLuint,
                equation_at(ndx, 0) as GLint,
                verifier,
            );
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_ALPHA,
                ndx as GLuint,
                equation_at(ndx, 0) as GLint,
                verifier,
            );
        }
    }
    {
        case.section("After setting indexed separate");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl()
                    .blend_equation_separatei(ndx as GLuint, equation_at(ndx, 0), equation_at(ndx, 1))
            };
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_RGB,
                ndx as GLuint,
                equation_at(ndx, 0) as GLint,
                verifier,
            );
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_ALPHA,
                ndx as GLuint,
                equation_at(ndx, 1) as GLint,
                verifier,
            );
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, equation_at(ndx, 0)) };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_FUNC_SUBTRACT) };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
    {
        case.section("After resetting indexed with common separate");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl()
                    .blend_equation_separatei(ndx as GLuint, equation_at(ndx, 0), equation_at(ndx, 1))
            };
        }
        // SAFETY: a plain state setter.
        unsafe {
            case.gl()
                .blend_equation_separate(glw::GL_FUNC_REVERSE_SUBTRACT, glw::GL_FUNC_SUBTRACT)
        };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_REVERSE_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
}

/// `BlendEquationAdvancedCase::init` + `iterate`
fn blend_equation_advanced_case(case: &mut ApiCase<'_>, verifier: Verifier) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }
    if !require_extension(case, "GL_KHR_blend_equation_advanced") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_SCREEN) };
        verify_blend_equations(case, max_draw_buffers, glw::GL_SCREEN, glw::GL_SCREEN, verifier);
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, advanced_at(ndx)) };
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_RGB,
                ndx as GLuint,
                advanced_at(ndx) as GLint,
                verifier,
            );
        }
        for ndx in 0..max_draw_buffers {
            verify_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_ALPHA,
                ndx as GLuint,
                advanced_at(ndx) as GLint,
                verifier,
            );
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, advanced_at(ndx)) };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_MULTIPLY) };
        verify_blend_equations(case, max_draw_buffers, glw::GL_MULTIPLY, glw::GL_MULTIPLY, verifier);
    }
    {
        case.section("After resetting indexed separate with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl()
                    .blend_equation_separatei(ndx as GLuint, equation_at(ndx, 0), equation_at(ndx, 1))
            };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_LIGHTEN) };
        verify_blend_equations(case, max_draw_buffers, glw::GL_LIGHTEN, glw::GL_LIGHTEN, verifier);
    }
}

/// `IndexedStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indexed");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("transform_feedback_buffer_binding", transform_feedback_buffer_binding),
        (
            "transform_feedback_buffer_start_size",
            transform_feedback_buffer_start_size,
        ),
        (
            "transform_feedback_switching_buffer",
            transform_feedback_switching_buffer,
        ),
        ("uniform_buffer_binding", uniform_buffer_binding),
        ("uniform_buffer_start_size", uniform_buffer_start_size),
    ];
    add_api_cases(&mut group, cases);

    const VERIFIERS: [Verifier; 2] = [Verifier::Integer, Verifier::Integer64];
    const VEC4_VERIFIERS: [Verifier; 2] = [Verifier::IntegerVec4, Verifier::Integer64Vec4];

    add_api_case(&mut group, "blend_isenabledi", |case: &mut ApiCase<'_>| {
        enable_blend_case(case, Verifier::IsEnabled);
    });
    for verifier in VEC4_VERIFIERS {
        add_api_case(
            &mut group,
            format!("color_mask_{}", verifier.suffix()),
            move |case: &mut ApiCase<'_>| {
                color_mask_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("blend_func_{}", verifier.suffix()),
            move |case: &mut ApiCase<'_>| {
                blend_func_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("blend_equation_{}", verifier.suffix()),
            move |case: &mut ApiCase<'_>| {
                blend_equation_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("blend_equation_advanced_{}", verifier.suffix()),
            move |case: &mut ApiCase<'_>| blend_equation_advanced_case(case, verifier),
        );
    }

    group
}
