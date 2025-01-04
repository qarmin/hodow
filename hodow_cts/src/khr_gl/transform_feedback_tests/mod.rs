// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A `throw 0` of upstream (reported as an internal error) is a `TestError::Fail("Error")`: there is no separate internal-error verdict here. The case classes derived from `CaptureVertexInterleaved` are one `capture::Capture` engine driven by the flags the overriding classes differ in.
//
// All 21 cases are ported (written without compiling); `create_tests` holds them in upstream order.

use std::ffi::CString;

use crate::glu::{TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        crate::glu::expect_no_error($gl, $name)?;
    }};
}

mod api_errors;
mod capture;
mod draw_xfb;
mod geometry_shaders;
mod get_xfb_varying;
mod instanced_geometry;
mod limits_linking;

/// `throw 0`
fn internal_error<T>() -> Result<T, TestError> {
    Err(TestError::Fail("Error".to_string()))
}

/// The pass-or-fail tail every case of this group ends with.
fn verdict(is_ok: bool) -> TestOutcome {
    if is_ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// What `Utilities::buildProgram` takes besides the context: one source slot per stage.
#[derive(Default, Clone, Copy)]
pub(super) struct Sources<'s> {
    pub(super) geometry: Option<&'s str>,
    pub(super) tess_control: Option<&'s str>,
    pub(super) tess_evaluation: Option<&'s str>,
    pub(super) vertex: Option<&'s str>,
    pub(super) fragment: Option<&'s str>,
}

/// `Utilities::buildProgram` without the optional parameters: shaders detached after a successful link.
pub(super) fn build_program(gl: &glw::Functions, sources: &Sources, varyings: &[&str], mode: GLenum) -> GLuint {
    build_program_with(gl, sources, varyings, mode, false, None)
}

/// `Utilities::buildProgram`: the program name, or 0 when anything failed (`linking_status` then holds the link status when it got that far).
pub(super) fn build_program_with(
    gl: &glw::Functions,
    sources: &Sources,
    varyings: &[&str],
    mode: GLenum,
    do_not_detach: bool,
    linking_status: Option<&mut GLint>,
) -> GLuint {
    let mut program = 0;
    let mut shader_ids = [0 as GLuint; 5];

    let attempt = build_program_inner(
        gl,
        sources,
        varyings,
        mode,
        do_not_detach,
        linking_status,
        &mut program,
        &mut shader_ids,
    );

    if attempt.is_err() && program != 0 {
        // SAFETY: the program was created by the attempt and is deleted once.
        unsafe { gl.delete_program(program) };
        program = 0;
    }

    for shader_id in shader_ids {
        if shader_id != 0 {
            // SAFETY: the shader was created by the attempt and is deleted once.
            unsafe { gl.delete_shader(shader_id) };
        }
    }

    program
}

fn build_program_inner(
    gl: &glw::Functions,
    sources: &Sources,
    varyings: &[&str],
    mode: GLenum,
    do_not_detach: bool,
    linking_status: Option<&mut GLint>,
    program: &mut GLuint,
    shader_ids: &mut [GLuint; 5],
) -> Result<(), TestError> {
    let shaders = [
        (sources.geometry, glw::GL_GEOMETRY_SHADER),
        (sources.tess_control, glw::GL_TESS_CONTROL_SHADER),
        (sources.tess_evaluation, glw::GL_TESS_EVALUATION_SHADER),
        (sources.vertex, glw::GL_VERTEX_SHADER),
        (sources.fragment, glw::GL_FRAGMENT_SHADER),
    ];

    // SAFETY: plain object creation.
    *program = unsafe { gl.create_program() };
    crate::glu::expect_no_error(gl, "glCreateProgram call failed.")?;

    for (i, (source, shader_type)) in shaders.into_iter().enumerate() {
        let Some(source) = source else { continue };

        // SAFETY: plain object creation.
        shader_ids[i] = unsafe { gl.create_shader(shader_type) };
        crate::glu::expect_no_error(gl, "glCreateShader call failed.")?;
        gl_call!(
            gl,
            "glAttachShader call failed.",
            gl.attach_shader(*program, shader_ids[i])
        );

        let c_source = CString::new(source).map_err(|_| TestError::Fail("Shader source contains a NUL".to_string()))?;
        let source_ptr = c_source.as_ptr();
        gl_call!(
            gl,
            "glShaderSource call failed.",
            gl.shader_source(shader_ids[i], 1, &source_ptr, std::ptr::null())
        );
        gl_call!(gl, "glCompileShader call failed.", gl.compile_shader(shader_ids[i]));

        let mut status = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glGetShaderiv call failed.",
            gl.get_shaderiv(shader_ids[i], glw::GL_COMPILE_STATUS, &mut status)
        );

        if status == glw::GL_FALSE as GLint {
            let mut log_size: GLint = 0;
            gl_call!(
                gl,
                "glGetShaderiv call failed.",
                gl.get_shaderiv(shader_ids[i], glw::GL_INFO_LOG_LENGTH, &mut log_size)
            );
            let mut log_text = vec![0u8; log_size.max(1) as usize];
            gl_call!(
                gl,
                "glGetShaderInfoLog call failed.",
                gl.get_shader_info_log(
                    shader_ids[i],
                    log_size,
                    std::ptr::null_mut(),
                    log_text.as_mut_ptr().cast()
                )
            );
            log::info!(
                "Shader compilation has failed.\nShader type: 0x{shader_type:X}\nShader compilation error log:\n{}\nShader source code:\n{source}\n",
                text_of(&log_text)
            );
            return internal_error();
        }
    }

    if !varyings.is_empty() {
        let names: Vec<CString> = varyings
            .iter()
            .map(|name| CString::new(*name).expect("varying names have no NUL"))
            .collect();
        let pointers: Vec<_> = names.iter().map(|name| name.as_ptr()).collect();
        gl_call!(
            gl,
            "glTransformFeedbackVaryings call failed.",
            gl.transform_feedback_varyings(*program, pointers.len() as GLsizei, pointers.as_ptr(), mode)
        );
    }

    gl_call!(
        gl,
        "glTransformFeedbackVaryings call failed.",
        gl.link_program(*program)
    );

    let mut status = glw::GL_FALSE as GLint;
    // SAFETY: one integer of output is given.
    unsafe { gl.get_programiv(*program, glw::GL_LINK_STATUS, &mut status) };

    if let Some(linking_status) = linking_status {
        *linking_status = status;
    }

    if status == glw::GL_TRUE as GLint {
        if !do_not_detach {
            for shader_id in *shader_ids {
                if shader_id != 0 {
                    gl_call!(gl, "glDetachShader call failed.", gl.detach_shader(*program, shader_id));
                }
            }
        }
        return Ok(());
    }

    let mut log_size: GLint = 0;
    gl_call!(
        gl,
        "glGetProgramiv call failed.",
        gl.get_programiv(*program, glw::GL_INFO_LOG_LENGTH, &mut log_size)
    );
    let mut log_text = vec![0u8; log_size.max(1) as usize];
    gl_call!(
        gl,
        "glGetProgramInfoLog call failed.",
        gl.get_program_info_log(*program, log_size, std::ptr::null_mut(), log_text.as_mut_ptr().cast())
    );
    log::info!("Program linkage has failed due to:\n{}\n", text_of(&log_text));
    internal_error()
}

/// The text of a NUL-terminated byte buffer.
fn text_of(buffer: &[u8]) -> String {
    let end = buffer.iter().position(|&byte| byte == 0).unwrap_or(buffer.len());
    String::from_utf8_lossy(&buffer[..end]).into_owned()
}

/// `Utilities::preprocessCode`
pub(super) fn preprocess_code(source: &str, key: &str, value: &str) -> String {
    source.replace(key, value)
}

/// `Utilities::itoa`
pub(super) fn itoa(i: GLint) -> String {
    i.to_string()
}

/// `Utilities::ftoa`
pub(super) fn ftoa(f: f32) -> String {
    f.to_string()
}

/// `gl3cts::TransformFeedback::Tests::Tests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback");
    group.add_child(Box::new(api_errors::ApiErrors) as Box<dyn TestCase>);
    group.add_child(Box::new(limits_linking::LinkingErrors) as Box<dyn TestCase>);
    group.add_child(Box::new(limits_linking::Limits) as Box<dyn TestCase>);
    use capture::Variant::{Capture, Discard, Query};
    let capture_cases = [
        ("capture_vertex_interleaved_test", false, false, Capture),
        ("capture_geometry_interleaved_test", true, false, Capture),
        ("capture_vertex_separate_test", false, true, Capture),
        ("capture_geometry_separate_test", true, true, Capture),
    ];
    for (name, geometry, separate, variant) in capture_cases {
        group.add_child(Box::new(capture::CaptureCase {
            name,
            geometry,
            separate,
            variant,
        }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(get_xfb_varying::CheckGetXFBVarying) as Box<dyn TestCase>);
    let query_discard_cases = [
        ("query_vertex_interleaved_test", false, false, Query),
        ("query_geometry_interleaved_test", true, false, Query),
        ("query_vertex_separate_test", false, true, Query),
        ("query_geometry_separate_test", true, true, Query),
        ("discard_vertex_test", false, false, Discard),
        ("discard_geometry_test", true, false, Discard),
    ];
    for (name, geometry, separate, variant) in query_discard_cases {
        group.add_child(Box::new(capture::CaptureCase {
            name,
            geometry,
            separate,
            variant,
        }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(draw_xfb::DrawXfb) as Box<dyn TestCase>);
    group.add_child(Box::new(draw_xfb::DrawXfbFeedback) as Box<dyn TestCase>);
    group.add_child(Box::new(draw_xfb::DrawXfbStream) as Box<dyn TestCase>);
    group.add_child(Box::new(draw_xfb::CaptureSpecialInterleaved) as Box<dyn TestCase>);
    group.add_child(Box::new(instanced_geometry::DrawXfbInstanced) as Box<dyn TestCase>);
    group.add_child(Box::new(instanced_geometry::DrawXfbStreamInstanced) as Box<dyn TestCase>);
    group.add_child(Box::new(instanced_geometry::Geometry) as Box<dyn TestCase>);
    group
}
