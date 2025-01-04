// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 4.0 and 4.3 entry points that have a body upstream (the transform feedback object calls and `glInvalidate*Framebuffer`); `glProgramParameteri` is in `functions_gl32.rs`, the rest of the 4.x list is "not implemented yet" stubs upstream and is not listed here. `glIsTransformFeedback` is called through the global entry point upstream and through the function table here.

use super::Coverage;
use crate::tcu::TestError;
use crate::{glu, glw};

const EA_INVALIDATE_FRAMEBUFFER: [glw::GLenum; 3] =
    [glw::GL_FRAMEBUFFER, glw::GL_DRAW_FRAMEBUFFER, glw::GL_READ_FRAMEBUFFER];

impl Coverage<'_> {
    pub(super) fn run_func_gl40(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glBindTransformFeedback" => self.bind_transform_feedback(),
            "glDeleteTransformFeedbacks" => self.delete_transform_feedbacks(),
            "glGenTransformFeedbacks" => self.gen_transform_feedbacks(),
            "glIsTransformFeedback" => self.is_transform_feedback(),
            "glPauseTransformFeedback" => self.pause_transform_feedback(),
            "glResumeTransformFeedback" => self.resume_transform_feedback(),
            "glInvalidateFramebuffer" => self.invalidate_framebuffer(),
            "glInvalidateSubFramebuffer" => self.invalidate_sub_framebuffer(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallInvalidateFramebuffer`
    fn invalidate_framebuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut max: glw::GLint = 0;
        let mut f: glw::GLuint = 0;

        // SAFETY: a zero-length attachment list may be null; the one-element list is a local.
        unsafe {
            for target in EA_INVALIDATE_FRAMEBUFFER {
                gl.invalidate_framebuffer(target, 0, std::ptr::null());
                if gl.get_error() != glw::GL_NO_ERROR {
                    self.fail_msg("InvalidateFramebuffer", "Failed.");
                    success = false;
                    break;
                }
            }

            gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max);
            glu::expect_no_error(gl, "getIntegerv")?;

            let _ = gl.get_error();

            let attachment: glw::GLenum = glw::GL_COLOR_ATTACHMENT0.wrapping_add(max as glw::GLenum);

            gl.gen_framebuffers(1, &mut f);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, f);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            gl.invalidate_framebuffer(glw::GL_FRAMEBUFFER, 1, &attachment);

            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("InvalidateFramebuffer", "Failed.");
                success = false;
            }

            gl.delete_framebuffers(1, &f);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallInvalidateSubFramebuffer`
    fn invalidate_sub_framebuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: a zero-length attachment list may be null.
        unsafe {
            for target in EA_INVALIDATE_FRAMEBUFFER {
                gl.invalidate_sub_framebuffer(target, 0, std::ptr::null(), 0, 0, 1, 1);
                if gl.get_error() != glw::GL_NO_ERROR {
                    self.fail_msg("InvalidateSubFramebuffer", "Failed.");
                    success = false;
                    break;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindTransformFeedback`
    fn bind_transform_feedback(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(1)?;

            if program == -1 {
                self.fail_msg("BeginTransformFeedback", "Program create Failed");
                return Ok(false);
            }

            gl.gen_transform_feedbacks(1, &mut tobj);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindTransformFeedback", "Failed to create transform feedback object.");
                success = false;
            }

            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BindTransformFeedback", "Failed.");
                success = false;
            }

            gl.delete_transform_feedbacks(1, &tobj);
            glu::expect_no_error(gl, "deleteTransformFeedbacks")?;

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDeleteTransformFeedbacks`
    fn delete_transform_feedbacks(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj = [0 as glw::GLuint; 2];

        // SAFETY: `tobj` holds the two names generated and deleted.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(1)?;

            if program == -1 {
                self.fail_msg("DeleteTransformFeedbacks", "Program create Failed");
                return Ok(false);
            }

            gl.gen_transform_feedbacks(2, tobj.as_mut_ptr());

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg(
                    "DeleteTransformFeedbacks",
                    "Failed to create transform feedback object.",
                );
                success = false;
            }

            gl.delete_transform_feedbacks(2, tobj.as_ptr());

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DeleteTransformFeedbacks", "Failed.");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenTransformFeedbacks`
    fn gen_transform_feedbacks(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj = [0 as glw::GLuint; 2];

        // SAFETY: `tobj` holds the two names generated and deleted.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(1)?;

            if program == -1 {
                self.fail_msg("GenTransformFeedbacks", "Program create Failed");
                return Ok(false);
            }

            gl.gen_transform_feedbacks(2, tobj.as_mut_ptr());

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GenTransformFeedbacks", "Failed.");
                success = false;
            }

            gl.delete_transform_feedbacks(2, tobj.as_ptr());
            glu::expect_no_error(gl, "deleteTransformFeedbacks")?;

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsTransformFeedback`
    fn is_transform_feedback(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(1)?;

            if program == -1 {
                self.fail_msg("IsTransformFeedback", "Program create Failed");
                return Ok(false);
            }

            gl.gen_transform_feedbacks(1, &mut tobj);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsTransformFeedback", "Failed to create transform feedback object.");
                success = false;
            }

            if gl.is_transform_feedback(tobj) != glw::FALSE || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsTransformFeedback", "Failed.");
                success = false;
            }

            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);
            glu::expect_no_error(gl, "bindTransformFeedback")?;

            if gl.is_transform_feedback(tobj) != glw::TRUE || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsTransformFeedback", "Failed.");
                success = false;
            }

            gl.delete_transform_feedbacks(1, &tobj);
            glu::expect_no_error(gl, "deleteTransformFeedbacks")?;

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallPauseTransformFeedback`
    fn pause_transform_feedback(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj: glw::GLuint = 0;
        let mut tbufobj: glw::GLuint = 0;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(1)?;

            if program == -1 {
                self.fail_msg("PauseTransformFeedback", "Program create Failed");
                return Ok(false);
            }

            gl.gen_transform_feedbacks(1, &mut tobj);
            glu::expect_no_error(gl, "genTransformFeedbacks")?;
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);
            glu::expect_no_error(gl, "bindTransformFeedback")?;
            gl.gen_buffers(1, &mut tbufobj);
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tbufobj);
            glu::expect_no_error(gl, "bindBufferBase")?;

            gl.begin_transform_feedback(glw::GL_TRIANGLES);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("PauseTransformFeedback", "Failed to start transform feedback.");
                success = false;
            }

            gl.pause_transform_feedback();

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("PauseTransformFeedback", "Failed.");
                success = false;
            }

            gl.end_transform_feedback();
            glu::expect_no_error(gl, "endTransformFeedback")?;

            gl.delete_buffers(1, &tbufobj);
            glu::expect_no_error(gl, "deleteBuffers")?;
            gl.delete_transform_feedbacks(1, &tobj);
            glu::expect_no_error(gl, "deleteTransformFeedbacks")?;
            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallResumeTransformFeedback`
    fn resume_transform_feedback(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tobj: glw::GLuint = 0;
        let mut tbufobj: glw::GLuint = 0;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(1)?;

            if program == -1 {
                self.fail_msg("ResumeTransformFeedback", "Program create Failed");
                return Ok(false);
            }

            gl.gen_transform_feedbacks(1, &mut tobj);
            glu::expect_no_error(gl, "genTransformFeedbacks")?;
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tobj);
            glu::expect_no_error(gl, "bindTransformFeedback")?;
            gl.gen_buffers(1, &mut tbufobj);
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tbufobj);
            glu::expect_no_error(gl, "bindBufferBase")?;

            gl.begin_transform_feedback(glw::GL_TRIANGLES);
            glu::expect_no_error(gl, "beginTransformFeedback")?;

            gl.pause_transform_feedback();

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("ResumeTransformFeedback", "Failed to start transform feedback.");
                success = false;
            }

            gl.resume_transform_feedback();

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("ResumeTransformFeedback", "Failed.");
                success = false;
            }

            gl.end_transform_feedback();
            glu::expect_no_error(gl, "endTransformFeedback")?;

            gl.delete_buffers(1, &tbufobj);
            glu::expect_no_error(gl, "deleteBuffers")?;
            gl.delete_transform_feedbacks(1, &tobj);
            glu::expect_no_error(gl, "deleteTransformFeedbacks")?;
            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }
}
