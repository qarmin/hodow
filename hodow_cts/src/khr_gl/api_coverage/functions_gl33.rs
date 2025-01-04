// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 3.3 entry points: the sampler object calls; everything else of the 3.3 list (`glBindFragDataLocationIndexed`, the `Iiv`/`Iuiv` sampler forms, the 64-bit query reads and the `glVertexP*`/`glTexCoordP*`/... packed attribute calls) is a "not implemented yet" stub upstream and is not listed here.

use super::Coverage;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl33(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glGenSamplers" => self.gen_samplers(),
            "glDeleteSamplers" => self.delete_samplers(),
            "glIsSampler" => self.is_sampler(),
            "glBindSampler" => self.bind_sampler(),
            "glSamplerParameteri" => self.sampler_parameteri(),
            "glSamplerParameteriv" => self.sampler_parameteriv(),
            "glSamplerParameterf" => self.sampler_parameterf(),
            "glSamplerParameterfv" => self.sampler_parameterfv(),
            "glGetSamplerParameteriv" => self.get_sampler_parameteriv(),
            "glGetSamplerParameterfv" => self.get_sampler_parameterfv(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallGenSamplers`
    fn gen_samplers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler = [0 as glw::GLuint; 2];

        // SAFETY: `sampler` holds the two names generated and deleted.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(2, sampler.as_mut_ptr());

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GenSamplers", "Failed.");
                success = false;
            }

            gl.delete_samplers(2, sampler.as_ptr());
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDeleteSamplers`
    fn delete_samplers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler = [0 as glw::GLuint; 2];

        // SAFETY: `sampler` holds the two names generated and deleted.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(2, sampler.as_mut_ptr());

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DeleteSamplers", "Could not create a sampler.");
                success = false;
            }

            gl.delete_samplers(2, sampler.as_ptr());

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DeleteSamplers", "Failed.");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsSampler`
    fn is_sampler(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsSampler", "Could not create a sampler.");
                success = false;
            }

            if gl.is_sampler(sampler) != glw::TRUE || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsSampler", "Failed.");
                success = false;
            }

            gl.bind_sampler(0, sampler);
            glu::expect_no_error(gl, "bindSampler")?;

            if gl.is_sampler(sampler) != glw::TRUE || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsSampler", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindSampler`
    fn bind_sampler(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindSampler", "Could not create a sampler.");
                success = false;
            }

            gl.bind_sampler(0, sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindSampler", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallSamplerParameteri`
    fn sampler_parameteri(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameteri", "Could not create a sampler.");
                success = false;
            }

            gl.sampler_parameteri(sampler, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as glw::GLint);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameteri", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallSamplerParameteriv`
    fn sampler_parameteriv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;
        let param = glw::GL_REPEAT as glw::GLint;

        // SAFETY: `param` is the one integer a wrap mode takes.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameteriv", "Could not create a sampler.");
                success = false;
            }

            gl.sampler_parameteriv(sampler, glw::GL_TEXTURE_WRAP_S, &param);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameteriv", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallSamplerParameterf`
    fn sampler_parameterf(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;
        let parami = glw::GL_MIRRORED_REPEAT as glw::GLint;

        // SAFETY: one name generated and deleted.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameterf", "Could not create a sampler.");
                success = false;
            }

            gl.sampler_parameterf(sampler, glw::GL_TEXTURE_WRAP_R, parami as glw::GLfloat);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameterf", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallSamplerParameterfv`
    fn sampler_parameterfv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;
        let parami = glw::GL_NEAREST as glw::GLint;
        let param = parami as glw::GLfloat;

        // SAFETY: `param` is the one float a filter takes.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameterfv", "Could not create a sampler.");
                success = false;
            }

            gl.sampler_parameterfv(sampler, glw::GL_TEXTURE_MIN_FILTER, &param);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("SamplerParameterfv", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetSamplerParameteriv`
    fn get_sampler_parameteriv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;
        let mut param: glw::GLint = 0;

        // SAFETY: one integer out.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetSamplerParameteriv", "Could not create a sampler.");
                success = false;
            }

            gl.get_sampler_parameteriv(sampler, glw::GL_TEXTURE_MAG_FILTER, &mut param);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetSamplerParameteriv", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetSamplerParameterfv`
    fn get_sampler_parameterfv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut sampler: glw::GLuint = 0;
        let mut param: glw::GLfloat = 0.0;

        // SAFETY: one float out.
        unsafe {
            let _ = gl.get_error();

            gl.gen_samplers(1, &mut sampler);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetSamplerParameterfv", "Could not create a sampler.");
                success = false;
            }

            gl.get_sampler_parameterfv(sampler, glw::GL_TEXTURE_COMPARE_FUNC, &mut param);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetSamplerParameterfv", "Failed.");
                success = false;
            }

            gl.delete_samplers(1, &sampler);
            glu::expect_no_error(gl, "deleteSamplers")?;
        }

        Ok(success)
    }
}
