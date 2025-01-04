// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `deinit` of every case is the `Drop` of the GL objects that case created; a TCU_FAIL is a `TestError::Fail` the `?` propagates; `m_has_test_passed` is a local `bool`. glw has no `glGetInteger64v`, so the 64-bit comparison of `min_maxes` is left out.
//
// All 28 cases are ported (written without compiling): `min_maxes`, `name_getters`, the functional cases `FunctionalTest1_2` to `FunctionalTest18_19` and `NegativeTest1` to `NegativeTest12`.

use std::ffi::CString;

use crate::glu::{TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        crate::glu::expect_no_error($gl, $name)?;
    }};
}

mod api;
mod functional_basic;
mod functional_binary;
mod functional_misc;
mod functional_pipeline;
mod functional_reset;
mod functional_resources;
mod functional_sets;
mod functional_stages;
mod negative_compile;
mod negative_scope;
mod utils;

/// `Utils::_shader_stage`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum ShaderStage {
    Vertex,
    TessellationControl,
    TessellationEvaluation,
    Geometry,
    Fragment,
}

impl ShaderStage {
    pub(super) const ALL: [ShaderStage; 5] = [
        Self::Vertex,
        Self::TessellationControl,
        Self::TessellationEvaluation,
        Self::Geometry,
        Self::Fragment,
    ];

    /// `Utils::getGLenumForShaderStage`
    pub(super) fn gl_enum(self) -> GLenum {
        match self {
            Self::Vertex => glw::GL_VERTEX_SHADER,
            Self::TessellationControl => glw::GL_TESS_CONTROL_SHADER,
            Self::TessellationEvaluation => glw::GL_TESS_EVALUATION_SHADER,
            Self::Geometry => glw::GL_GEOMETRY_SHADER,
            Self::Fragment => glw::GL_FRAGMENT_SHADER,
        }
    }
}

/// `TCU_FAIL`
pub(super) fn fail<T>(message: &str) -> Result<T, TestError> {
    Err(TestError::Fail(message.to_string()))
}

/// The `GL_ARB_shader_subroutine` check every case starts its `iterate` with.
pub(super) fn check_subroutine_support(context: &crate::glu::Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_ARB_shader_subroutine") {
        return Err(TestError::NotSupported(
            "GL_ARB_shader_subroutine is not supported.".to_string(),
        ));
    }
    Ok(())
}

/// `m_testCtx.setTestResult(QP_TEST_RESULT_PASS / QP_TEST_RESULT_FAIL, ...)` from `m_has_test_passed`.
pub(super) fn verdict(has_test_passed: bool) -> TestOutcome {
    if has_test_passed {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// `glGetError`
pub(super) fn get_error(gl: &glw::Functions) -> GLenum {
    // SAFETY: glGetError needs nothing but a current context.
    unsafe { gl.get_error() }
}

/// `glShaderSource` of a single string.
pub(super) fn shader_source(gl: &glw::Functions, id: GLuint, body: &str) -> Result<(), TestError> {
    let source = CString::new(body).map_err(|_| TestError::Fail("Shader source contains a NUL".to_string()))?;
    let source_ptr = source.as_ptr();
    gl_call!(
        gl,
        "glShaderSource() call failed.",
        gl.shader_source(id, 1, &source_ptr, std::ptr::null())
    );
    Ok(())
}

/// `glCompileShader` followed by `GL_COMPILE_STATUS`.
pub(super) fn compile_status(gl: &glw::Functions, id: GLuint) -> Result<bool, TestError> {
    let mut status = glw::GL_FALSE as GLint;
    gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(id));
    gl_call!(
        gl,
        "glGetShaderiv() call failed.",
        gl.get_shaderiv(id, glw::GL_COMPILE_STATUS, &mut status)
    );
    Ok(status == glw::GL_TRUE as GLint)
}

/// `glLinkProgram` followed by `GL_LINK_STATUS`.
pub(super) fn link_status(gl: &glw::Functions, id: GLuint) -> Result<bool, TestError> {
    let mut status = glw::GL_FALSE as GLint;
    gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(id));
    gl_call!(
        gl,
        "glGetProgramiv() call failed.",
        gl.get_programiv(id, glw::GL_LINK_STATUS, &mut status)
    );
    Ok(status == glw::GL_TRUE as GLint)
}

/// `glGetProgramStageiv` of one pname.
pub(super) fn program_stage(gl: &glw::Functions, program: GLuint, stage: GLenum, pname: GLenum) -> GLint {
    let mut value: GLint = 0;
    // SAFETY: one integer of output is given.
    unsafe { gl.get_program_stageiv(program, stage, pname, &mut value) };
    value
}

/// A program object and the shader objects `Utils::buildProgram` made for it; upstream leaves their deletion to `deinit`.
pub(super) struct BuiltProgram<'gl> {
    gl: &'gl glw::Functions,
    pub(super) program: GLuint,
    pub(super) shaders: Vec<GLuint>,
}

impl Drop for BuiltProgram<'_> {
    fn drop(&mut self) {
        // SAFETY: the names were created by `build_program` and are deleted once.
        unsafe {
            for &shader in &self.shaders {
                self.gl.delete_shader(shader);
            }
            self.gl.delete_program(self.program);
        }
    }
}

/// `Utils::buildProgram` over the stages given, in that order; `None` when a shader failed to compile or the program to link.
pub(super) fn build_program<'gl>(
    gl: &'gl glw::Functions,
    sources: &[(ShaderStage, &str)],
    xfb_varyings: Option<&[&str]>,
) -> Result<Option<BuiltProgram<'gl>>, TestError> {
    // SAFETY: plain object creation.
    let program = unsafe { gl.create_program() };
    let mut built = BuiltProgram {
        gl,
        program,
        shaders: Vec::new(),
    };
    crate::glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

    for &(stage, body) in sources {
        // SAFETY: plain object creation.
        let shader = unsafe { gl.create_shader(stage.gl_enum()) };
        built.shaders.push(shader);
        crate::glu::expect_no_error(gl, "glCreateShader() call failed.")?;
        gl_call!(gl, "glAttachShader() call failed.", gl.attach_shader(program, shader));
        shader_source(gl, shader, body)?;
    }

    for &shader in &built.shaders {
        if !compile_status(gl, shader)? {
            return Ok(None);
        }
    }

    if let Some(varyings) = xfb_varyings {
        let names: Vec<CString> = varyings
            .iter()
            .map(|name| CString::new(*name).expect("varying names have no NUL"))
            .collect();
        let pointers: Vec<_> = names.iter().map(|name| name.as_ptr()).collect();
        gl_call!(
            gl,
            "glTransformFeedbackVaryings() call failed.",
            gl.transform_feedback_varyings(
                program,
                pointers.len() as glw::GLsizei,
                pointers.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS
            )
        );
    }

    if !link_status(gl, program)? {
        return Ok(None);
    }

    Ok(Some(built))
}

/// `ShaderSubroutineTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_subroutine");
    group.add_child(Box::new(api::MinMaxes) as Box<dyn TestCase>);
    group.add_child(Box::new(api::NameGetters) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_basic::TwoSubroutinesSingleUniform) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_basic::FourSubroutinesTwoUniforms) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_sets::EightSubroutinesFourUniforms) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_sets::StaticSubroutineCall) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_sets::ArrayedSubroutineUniforms) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_misc::ThreeTypesOneFunction) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_misc::ArraysOfArraysOfUniforms) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_misc::GlobalsSamplingOutputDiscardFunctionCalls) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_resources::SsboAtomicImageLoadStore) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_pipeline::SubroutinesWithSeparateShaderObjects) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_binary::StructureParametersProgramBinary) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_reset::SubroutineUniformReset) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_stages::SameNamesDifferentTypesInAllStages) as Box<dyn TestCase>);
    group.add_child(Box::new(functional_stages::ControlFlowAndReturnedValues) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_scope::SubroutineErrors) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_scope::SubroutineUniformScope) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_scope::MissingSubroutineKeyword) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::IncompatibleWithSubroutineType) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::UniformWithoutMatchingSubroutines) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::DuplicateFunctionOneBeingSubroutine) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::Recursion) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::SubroutineWithoutBody) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::NotAssignableOrComparable) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::FunctionOverloadingForbidden) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::UniformsInSamplingAtomicImageFunctions) as Box<dyn TestCase>);
    group.add_child(Box::new(negative_compile::NotAllowedAsVariablesConstructorsArguments) as Box<dyn TestCase>);
    group
}
