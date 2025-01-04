// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, seventh part: transform feedback (`glBeginTransformFeedback` to `glGetTransformFeedbackVarying`).

use super::Coverage;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_feedback(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glBeginTransformFeedback" => self.begin_end_transform_feedback(false),
            "glEndTransformFeedback" => self.begin_end_transform_feedback(true),
            "glBindBufferRange" => self.bind_buffer_range(),
            "glBindBufferBase" => self.bind_buffer_base(),
            "glTransformFeedbackVaryings" => self.transform_feedback_varyings(),
            "glGetTransformFeedbackVarying" => self.get_transform_feedback_varying(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallBeginTransformFeedback`, or with `end` `TestCoverageGLCallEndTransformFeedback`, which also checks the error of the end call.
    fn begin_end_transform_feedback(&self, end: bool) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let test = if end {
            "EndTransformFeedback"
        } else {
            "BeginTransformFeedback"
        };
        let mut tobj: glw::GLuint = 0;
        let mut tbufobj: glw::GLuint = 0;
        let tf_supported = self.transform_feedback_obj_supported();

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            let program = self.create_default_program(1)?;
            if program == -1 {
                self.fail_msg(test, "Program create Failed");
                return Ok(false);
            }

            if tf_supported {
                gl.gen_transform_feedbacks(1, &mut tobj);
                glu::expect_no_error(gl, "genTransformFeedbacks")?;
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);
                glu::expect_no_error(gl, "bindTransformFeedback")?;
            }

            gl.gen_buffers(1, &mut tbufobj);
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tbufobj);
            glu::expect_no_error(gl, "bindBufferBase")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg(test, "Failed to create transform feedback buffer.");
                success = false;
            }

            gl.begin_transform_feedback(glw::GL_TRIANGLES);
            glu::expect_no_error(gl, "beginTransformFeedback")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg(test, if end { "Failed to start." } else { "Failed." });
                success = false;
            }

            gl.end_transform_feedback();
            glu::expect_no_error(gl, "endTransformFeedback")?;
            if end && gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg(test, "Failed.");
                success = false;
            }

            gl.delete_buffers(1, &tbufobj);
            glu::expect_no_error(gl, "deleteBuffers")?;
            if tf_supported {
                gl.delete_transform_feedbacks(1, &tobj);
                glu::expect_no_error(gl, "deleteTransformFeedbacks")?;
            }
            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindBufferRange`
    fn bind_buffer_range(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj: glw::GLuint = 0;
        let mut tbufobj: glw::GLuint = 0;
        let data = [0u8; 16];
        let tf_supported = self.transform_feedback_obj_supported();

        // SAFETY: `data` covers the 16 bytes uploaded.
        unsafe {
            if tf_supported {
                gl.gen_transform_feedbacks(1, &mut tobj);
                glu::expect_no_error(gl, "genTransformFeedbacks")?;
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);
                glu::expect_no_error(gl, "bindTransformFeedback")?;
            }

            gl.gen_buffers(1, &mut tbufobj);
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tbufobj);
            glu::expect_no_error(gl, "bindBufferBase")?;
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                16,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_READ,
            );
            glu::expect_no_error(gl, "bufferData")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindBufferRange", "Failed to create transform feedback buffer.");
                success = false;
            }

            gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, tbufobj, 0, 4);
            glu::expect_no_error(gl, "bindBufferRange")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindBufferRange", "Failed.");
                success = false;
            }

            gl.delete_buffers(1, &tbufobj);
            glu::expect_no_error(gl, "deleteBuffers")?;
            if tf_supported {
                gl.delete_transform_feedbacks(1, &tobj);
                glu::expect_no_error(gl, "deleteTransformFeedbacks")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindBufferBase`
    fn bind_buffer_base(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj: glw::GLuint = 0;
        let mut tbufobj: glw::GLuint = 0;
        let tf_supported = self.transform_feedback_obj_supported();

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            if tf_supported {
                gl.gen_transform_feedbacks(1, &mut tobj);
                glu::expect_no_error(gl, "genTransformFeedbacks")?;
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);
                glu::expect_no_error(gl, "bindTransformFeedback")?;
            }

            gl.gen_buffers(1, &mut tbufobj);
            glu::expect_no_error(gl, "genBuffers")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindBufferBase", "Failed to create transform feedback buffer.");
                success = false;
            }

            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tbufobj);
            glu::expect_no_error(gl, "bindBufferBase")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindBufferBase", "Failed.");
                success = false;
            }

            gl.delete_buffers(1, &tbufobj);
            glu::expect_no_error(gl, "deleteBuffers")?;
            if tf_supported {
                gl.delete_transform_feedbacks(1, &tobj);
                glu::expect_no_error(gl, "deleteTransformFeedbacks")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallTransformFeedbackVaryings`
    fn transform_feedback_varyings(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let ptex = c"texCoords".as_ptr();

        // SAFETY: one NUL-terminated name; program 0 is rejected.
        unsafe {
            gl.transform_feedback_varyings(0, 1, &ptex, glw::GL_SEPARATE_ATTRIBS);
            let err = gl.get_error();
            if err != glw::GL_INVALID_OPERATION && err != glw::GL_INVALID_VALUE {
                self.fail_msg("TransformFeedbackVaryings", "Failed.");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetTransformFeedbackVarying`
    fn get_transform_feedback_varying(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut length: glw::GLsizei = 0;
        let mut size: glw::GLint = 0;
        let mut type_: glw::GLenum = 0;
        let mut name = [0 as glw::GLchar; 32];

        // SAFETY: `name` has the 32 characters the call is told about.
        unsafe {
            let program = self.create_default_program(1)?;
            if program == -1 {
                self.fail_msg("GetTransformFeedbackVarying", "Program create Failed");
                return Ok(false);
            }

            gl.get_transform_feedback_varying(
                program as glw::GLuint,
                0,
                32,
                &mut length,
                &mut size,
                &mut type_,
                name.as_mut_ptr(),
            );
            glu::expect_no_error(gl, "getTransformFeedbackVarying")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetTransformFeedbackVarying", "Failed.");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }
}
