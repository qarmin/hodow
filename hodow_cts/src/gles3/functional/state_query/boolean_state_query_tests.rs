// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBooleanStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's five verifier classes
// are one enum here, exactly as in the GLES2 sibling - ES 3.0 adds
// `GetInteger64Verifier` (`_getinteger64`) to the four ES 2.0 has.

use std::ffi::CString;

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLchar, GLenum, GLsizei, GLuint};

const TRANSFORM_FEEDBACK_TEST_VERT_SOURCE: &str = "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";
const TRANSFORM_FEEDBACK_TEST_FRAG_SOURCE: &str =
    "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

/// Upstream's five `StateVerifier` subclasses.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Verifier {
    IsEnabled,
    GetBoolean,
    GetInteger,
    GetInteger64,
    GetFloat,
}

/// The verifiers a state that can be enabled is checked through.
const IS_ENABLED_VERIFIERS: [Verifier; 5] = [
    Verifier::IsEnabled,
    Verifier::GetBoolean,
    Verifier::GetInteger,
    Verifier::GetInteger64,
    Verifier::GetFloat,
];
/// The verifiers everything else is checked through - `glIsEnabled` only answers for
/// enables, so it is not in this list.
const NORMAL_VERIFIERS: [Verifier; 4] = [Verifier::GetBoolean, Verifier::GetInteger, Verifier::GetInteger64, Verifier::GetFloat];

impl Verifier {
    /// `StateVerifier::getTestNamePostfix`
    fn postfix(self) -> &'static str {
        match self {
            Self::IsEnabled => "_isenabled",
            Self::GetBoolean => "_getboolean",
            Self::GetInteger => "_getinteger",
            Self::GetInteger64 => "_getinteger64",
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
                        format!("expected {}, got {state}", if reference { "GL_TRUE" } else { "GL_FALSE" }),
                        "Got invalid boolean value",
                    );
                }
            }
            Self::GetBoolean => {
                let mut state = Guarded::<u8>::new();
                // SAFETY: one GLboolean out, guarded on both sides.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = if reference { glw::TRUE } else { glw::FALSE };
                if state.value() != expected {
                    case.fail(
                        format!("expected {}, got {}", if reference { "GL_TRUE" } else { "GL_FALSE" }, state.value()),
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
                    case.fail(format!("expected {expected}, got {}", state.value()), "Got invalid integer value");
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: as above, for one GLint64.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = i64::from(reference);
                if state.value() != expected {
                    case.fail(format!("expected {expected}, got {}", state.value()), "Got invalid integer value");
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
                    case.fail(format!("expected {expected}; got {}", state.value()), "Got invalid float value");
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
                // SAFETY: four GLbooleans, the width of GL_COLOR_WRITEMASK.
                unsafe { gl.get_booleanv(name, state.as_mut_ptr().cast::<u8>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(|r| if r { glw::TRUE } else { glw::FALSE });
                if state.value() != expected {
                    case.fail(format!("expected {expected:?}, got {:?}", state.value()), "Got invalid boolean value");
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
                    case.fail(format!("expected {expected:?}, got {:?}", state.value()), "Got invalid integer value");
                }
            }
            Self::GetInteger64 => {
                let mut state = Guarded::<[i64; 4]>::new();
                // SAFETY: as above, for four GLint64s.
                unsafe { gl.get_integer_64v(name, state.as_mut_ptr().cast::<i64>()) };
                if !state.verify_validity(case) {
                    return;
                }
                let expected = reference.map(i64::from);
                if state.value() != expected {
                    case.fail(format!("expected {expected:?}, got {:?}", state.value()), "Got invalid boolean value");
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
                    case.fail(format!("expected {expected:?}, got {:?}", state.value()), "Got invalid float value");
                }
            }
        }
    }
}

/// `IsEnabledStateTestCase`
fn is_enabled_state(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, initial: bool) {
    let gl = case.gl();

    verifier.verify_boolean(case, target, initial);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: `target` is one of the enables listed in `create_tests`.
    unsafe { gl.enable(target) };
    case.expect_error(glw::GL_NO_ERROR);
    verifier.verify_boolean(case, target, true);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
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

    // SAFETY: as above.
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

    // SAFETY: as above.
    unsafe { gl.sample_coverage(1.0, glw::FALSE) };
    verifier.verify_boolean(case, glw::GL_SAMPLE_COVERAGE_INVERT, false);
    case.expect_error(glw::GL_NO_ERROR);
}

/// `InitialBooleanTestCase`
fn initial_boolean(case: &mut ApiCase<'_>, verifier: Verifier, target: GLenum, reference: bool) {
    verifier.verify_boolean(case, target, reference);
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

/// `glShaderSource` with an owned source, since GL only borrows the pointer.
fn shader_source(case: &ApiCase<'_>, shader: GLuint, source: &str) {
    let owned = CString::new(source).expect("no interior nul");
    let pointer: *const GLchar = owned.as_ptr();
    // SAFETY: one live null-terminated string for the duration of the call; a null
    // `length` means "null-terminated".
    unsafe { case.gl().shader_source(shader, 1 as GLsizei, &raw const pointer, std::ptr::null()) };
}

/// `TransformFeedbackTestCase::test` - the whole scaffolding around
/// `testTransformFeedback`, which is `body` here.
fn with_transform_feedback(case: &mut ApiCase<'_>, body: impl FnOnce(&mut ApiCase<'_>)) {
    let gl = case.gl();

    let mut transform_feedback = 0;
    // SAFETY: the name is this case's own and is deleted below.
    unsafe { gl.gen_transform_feedbacks(1, &mut transform_feedback) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a fresh shader name.
    let shader_vert = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    shader_source(case, shader_vert, TRANSFORM_FEEDBACK_TEST_VERT_SOURCE);
    // SAFETY: the source was just set.
    unsafe { gl.compile_shader(shader_vert) };
    case.expect_error(glw::GL_NO_ERROR);
    let mut compile_status = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_shaderiv(shader_vert, glw::GL_COMPILE_STATUS, &mut compile_status) };
    case.check_booleans(compile_status, glw::TRUE);

    // SAFETY: as above.
    let shader_frag = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
    shader_source(case, shader_frag, TRANSFORM_FEEDBACK_TEST_FRAG_SOURCE);
    // SAFETY: as above.
    unsafe { gl.compile_shader(shader_frag) };
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.get_shaderiv(shader_frag, glw::GL_COMPILE_STATUS, &mut compile_status) };
    case.check_booleans(compile_status, glw::TRUE);

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

    // SAFETY: the transform feedback object was just generated.
    unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, transform_feedback) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut feedback_buffer = 0;
    // SAFETY: a fresh buffer name bound to the feedback binding point at index 0.
    unsafe {
        gl.gen_buffers(1, &mut feedback_buffer);
        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buffer);
        gl.buffer_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 16, std::ptr::null(), glw::GL_DYNAMIC_READ);
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, feedback_buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the program linked successfully.
    unsafe { gl.use_program(shader_prog) };

    body(case);

    // SAFETY: every name here is this case's own.
    unsafe {
        gl.use_program(0);
        gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        gl.delete_transform_feedbacks(1, &transform_feedback);
        gl.delete_buffers(1, &feedback_buffer);
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `TransformFeedbackBasicTestCase`
fn transform_feedback(case: &mut ApiCase<'_>, verifier: Verifier) {
    with_transform_feedback(case, |case| {
        let gl = case.gl();

        // SAFETY: a linked program with a recorded varying is current.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false);
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: transform feedback is active.
        unsafe { gl.pause_transform_feedback() };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, true);
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: transform feedback is paused.
        unsafe { gl.resume_transform_feedback() };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false);
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: transform feedback is active.
        unsafe { gl.end_transform_feedback() };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, false);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false);
        case.expect_error(glw::GL_NO_ERROR);
    });
}

/// `TransformFeedbackImplicitResumeTestCase` - `EndTransformFeedback` performs an
/// implicit `ResumeTransformFeedback`.
fn transform_feedback_implicit_resume(case: &mut ApiCase<'_>, verifier: Verifier) {
    with_transform_feedback(case, |case| {
        let gl = case.gl();

        // SAFETY: as in `transform_feedback`.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false);
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: transform feedback is active.
        unsafe { gl.pause_transform_feedback() };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, true);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, true);
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: ending while paused is legal and resumes implicitly.
        unsafe { gl.end_transform_feedback() };
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, false);
        verifier.verify_boolean(case, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false);
        case.expect_error(glw::GL_NO_ERROR);
    });
}

/// `BooleanStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("boolean");

    // The states that can be enabled, with their initial value.
    const IS_ENABLEDS: [(&str, GLenum, bool); 11] = [
        ("primitive_restart_fixed_index", glw::GL_PRIMITIVE_RESTART_FIXED_INDEX, false),
        ("rasterizer_discard", glw::GL_RASTERIZER_DISCARD, false),
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

    for (name, target, initial) in IS_ENABLEDS {
        for verifier in IS_ENABLED_VERIFIERS {
            add_api_case(&mut group, format!("{name}{}", verifier.postfix()), move |case| {
                is_enabled_state(case, verifier, target, initial);
            });
        }
    }

    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("color_writemask{}", verifier.postfix()), move |case| color_mask(case, verifier));
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("depth_writemask{}", verifier.postfix()), move |case| {
            depth_write_mask(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("sample_coverage_invert{}", verifier.postfix()), move |case| {
            sample_coverage_invert(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("shader_compiler{}", verifier.postfix()), move |case| {
            initial_boolean(case, verifier, glw::GL_SHADER_COMPILER, true);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("transform_feedback_active_initial{}", verifier.postfix()), move |case| {
            initial_boolean(case, verifier, glw::GL_TRANSFORM_FEEDBACK_ACTIVE, false);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("transform_feedback_paused_initial{}", verifier.postfix()), move |case| {
            initial_boolean(case, verifier, glw::GL_TRANSFORM_FEEDBACK_PAUSED, false);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("transform_feedback{}", verifier.postfix()), move |case| {
            transform_feedback(case, verifier);
        });
    }
    for verifier in NORMAL_VERIFIERS {
        add_api_case(&mut group, format!("transform_feedback_implicit_resume{}", verifier.postfix()), move |case| {
            transform_feedback_implicit_resume(case, verifier);
        });
    }

    group
}
