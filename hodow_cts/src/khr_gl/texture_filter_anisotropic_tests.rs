// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTextureFilterAnisotropicTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `queries` case is ported: the `drawing` case of upstream's group is not in any KHR-GL mustpass list. Every KHR-GL context is a desktop core context, so the `isContextTypeGLCore` branch of `verifyGet` is unconditional.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLboolean, GLdouble, GLfloat, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `TextureFilterAnisotropicQueriesTestCase`
struct QueriesTestCase;

impl QueriesTestCase {
    /// `verifyTexParameters`
    fn verify_tex_parameters(gl: &glw::Functions) -> Result<bool, TestError> {
        let mut i_value: GLint = 0;
        gl_call!(
            gl,
            "getTexParameteriv",
            gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &mut i_value)
        );

        if i_value != 1 {
            log::info!("GetTexParameteriv failed. Expected value: 1, Queried value: {i_value}");
            return Ok(false);
        }

        let mut f_value: GLfloat = 0.0;
        gl_call!(
            gl,
            "getTexParameterfv",
            gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &mut f_value)
        );

        if f_value != 1.0 {
            // Upstream prints the integer value here.
            log::info!("GetTexParameterfv failed. Expected value: 1.0, Queried value: {i_value}");
            return Ok(false);
        }

        i_value = 2;
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, i_value)
        );
        gl_call!(
            gl,
            "getTexParameteriv",
            gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &mut i_value)
        );

        if i_value != 2 {
            log::info!("texParameteri failed. Expected value: 2, Queried value: {i_value}");
            return Ok(false);
        }

        f_value = 1.5;
        gl_call!(
            gl,
            "texParameterf",
            gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, f_value)
        );
        gl_call!(
            gl,
            "getTexParameterfv",
            gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &mut f_value)
        );

        if f_value != 1.5 {
            log::info!("texParameterf failed. Expected value: 1.5, Queried value: {f_value}");
            return Ok(false);
        }

        i_value = 1;
        gl_call!(
            gl,
            "texParameteriv",
            gl.tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &i_value)
        );
        gl_call!(
            gl,
            "getTexParameteriv",
            gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &mut i_value)
        );

        if i_value != 1 {
            log::info!("texParameteriv failed. Expected value: 1, Queried value: {i_value}");
            return Ok(false);
        }

        f_value = 2.0;
        gl_call!(
            gl,
            "texParameterfv",
            gl.tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &f_value)
        );
        gl_call!(
            gl,
            "getTexParameterfv",
            gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &mut f_value)
        );

        if f_value != 2.0 {
            log::info!("texParameterfv failed. Expected value: 2.0, Queried value: {f_value}");
            return Ok(false);
        }

        f_value = 0.9;
        // SAFETY: a plain call with a pointer to a live float.
        unsafe { gl.tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_ANISOTROPY_EXT, &f_value) };
        // SAFETY: glGetError needs only a current context.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_INVALID_VALUE {
            log::info!(
                "texParameterfv failed for values less then 1.0f. Expected INVALID_VALUE error. Generated error: {}",
                glw::error_name(error)
            );
            return Ok(false);
        }

        Ok(true)
    }

    /// `verifyGet`
    fn verify_get(gl: &glw::Functions) -> Result<bool, TestError> {
        let mut b_value: GLboolean = 0;
        let mut i_value: GLint = 0;
        let mut f_value: GLfloat = 0.0;
        let mut d_value: GLdouble = 0.0;

        gl_call!(
            gl,
            "getBooleanv",
            gl.get_booleanv(glw::GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, &mut b_value)
        );
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, &mut i_value)
        );
        gl_call!(
            gl,
            "getFloatv",
            gl.get_floatv(glw::GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, &mut f_value)
        );
        gl_call!(
            gl,
            "getDoublev",
            gl.get_doublev(glw::GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, &mut d_value)
        );

        Ok(true)
    }

    fn run(gl: &glw::Functions, texture: &mut GLuint) -> Result<bool, TestError> {
        gl_call!(gl, "genTextures", gl.gen_textures(1, texture));
        gl_call!(gl, "bindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, *texture));
        gl_call!(
            gl,
            "texImage",
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                16,
                16,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null()
            )
        );

        Ok(Self::verify_tex_parameters(gl)? && Self::verify_get(gl)?)
    }
}

impl TestCase for QueriesTestCase {
    fn name(&self) -> &str {
        "queries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports_core(4, 6)
            && !context
                .context_info
                .is_extension_supported("GL_EXT_texture_filter_anisotropic")
            && !context
                .context_info
                .is_extension_supported("GL_ARB_texture_filter_anisotropic")
        {
            return Err(TestError::NotSupported(
                "texture filter anisotropic functionality not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut texture: GLuint = 0;

        let passed = Self::run(gl, &mut texture)?;

        if texture != 0 {
            gl_call!(gl, "deleteTextures", gl.delete_textures(1, &texture));
        }

        Ok(if passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureFilterAnisotropicTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_filter_anisotropic");
    group.add_child(Box::new(QueriesTestCase) as Box<dyn TestCase>);
    group
}
