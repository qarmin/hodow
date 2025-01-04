// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 3.1 entry points; `glTexBuffer`, `glPrimitiveRestartIndex` and `glGetActiveUniformName` are "not implemented yet" stubs upstream and are not listed here.

use super::Coverage;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl31(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glDrawArraysInstanced" => self.draw_arrays_instanced(),
            "glDrawElementsInstanced" => self.draw_elements_instanced(),
            "glCopyBufferSubData" => self.copy_buffer_sub_data(),
            "glGetUniformIndices" => self.get_uniform_indices(),
            "glGetActiveUniformsiv" => self.get_active_uniformsiv(),
            "glGetUniformBlockIndex" => self.get_uniform_block_index(),
            "glGetActiveUniformBlockiv" => self.get_active_uniform_blockiv(),
            "glGetActiveUniformBlockName" => self.get_active_uniform_block_name(),
            "glUniformBlockBinding" => self.uniform_block_binding(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallDrawArraysInstanced`
    fn draw_arrays_instanced(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: an invalid mode is rejected before any vertex is fetched.
        unsafe {
            let _ = gl.get_error();

            gl.draw_arrays_instanced(glw::GL_POINTS.wrapping_sub(1), 0, 3, 4);

            if gl.get_error() != glw::GL_INVALID_ENUM {
                self.fail_msg("DrawArraysInstanced", "Failed");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDrawElementsInstanced`
    fn draw_elements_instanced(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: an invalid mode is rejected before the null index pointer is read.
        unsafe {
            let _ = gl.get_error();

            gl.draw_elements_instanced(
                glw::GL_POINTS.wrapping_sub(1),
                3,
                glw::GL_UNSIGNED_INT,
                std::ptr::null(),
                4,
            );

            if gl.get_error() != glw::GL_INVALID_ENUM {
                self.fail_msg("DrawElementsInstanced", "Failed");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallCopyBufferSubData`
    fn copy_buffer_sub_data(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut cb = [0 as glw::GLuint; 2];
        let rdata = [0u8; 64];
        let wdata = [0u8; 64];

        // SAFETY: both data pointers cover the 64 bytes handed to bufferData; `cb` holds the two generated names.
        unsafe {
            let _ = gl.get_error();

            gl.copy_buffer_sub_data(glw::GL_PIXEL_UNPACK_BUFFER, glw::GL_PIXEL_PACK_BUFFER, 0, 0, 64);

            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CopyBufferSubData", "Failed (1)");
                success = false;
            }

            gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 0, 0, 64);

            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CopyBufferSubData", "Failed (2)");
                success = false;
            }

            gl.gen_buffers(2, cb.as_mut_ptr());
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, cb[0]);
            glu::expect_no_error(gl, "bindBuffer")?;
            gl.buffer_data(
                glw::GL_COPY_READ_BUFFER,
                64,
                rdata.as_ptr().cast(),
                glw::GL_DYNAMIC_READ,
            );
            glu::expect_no_error(gl, "bufferData")?;
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, cb[1]);
            glu::expect_no_error(gl, "bindBuffer")?;
            gl.buffer_data(
                glw::GL_COPY_WRITE_BUFFER,
                64,
                wdata.as_ptr().cast(),
                glw::GL_STATIC_COPY,
            );
            glu::expect_no_error(gl, "bufferData")?;

            gl.copy_buffer_sub_data(glw::GL_COPY_READ_BUFFER, glw::GL_COPY_WRITE_BUFFER, 8, 8, 32);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("CopyBufferSubData", "Failed (3)");
                success = false;
            }

            gl.delete_buffers(2, cb.as_ptr());
            glu::expect_no_error(gl, "deleteBuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetUniformIndices`
    fn get_uniform_indices(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let uname = c"dummy".as_ptr();
        let mut uindex: glw::GLuint = 0;

        // SAFETY: `uname` is one NUL-terminated name and `uindex` receives one index.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("GetUniformIndices", "Program create Failed");
                return Ok(false);
            }

            gl.get_uniform_indices(program as glw::GLuint, 1, &uname, &mut uindex);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetUniformIndices", "Failed (2)");
                success = false;
            }
            if uindex != glw::GL_INVALID_INDEX {
                self.fail_msg("GetUniformIndices", "Failed (3)");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetActiveUniformsiv`
    fn get_active_uniformsiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let uindex: glw::GLuint = 0;
        let mut data: glw::GLint = 0;

        // SAFETY: one index in, one integer out.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("GetActiveUniformsiv", "Program create Failed");
                return Ok(false);
            }

            gl.get_active_uniformsiv(program as glw::GLuint, 1, &uindex, glw::GL_UNIFORM_TYPE, &mut data);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetActiveUniformsiv", "Failed (2)");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetUniformBlockIndex`
    fn get_uniform_block_index(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: the name is NUL-terminated.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("GetUniformBlockIndex", "Program create Failed");
                return Ok(false);
            }

            let uindex = gl.get_uniform_block_index(program as glw::GLuint, c"dummy".as_ptr());
            glu::expect_no_error(gl, "getUniformBlockIndex")?;

            if uindex != glw::GL_INVALID_INDEX {
                self.fail_msg("GetUniformBlockIndex", "Failed");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetActiveUniformBlockiv`
    fn get_active_uniform_blockiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut data: glw::GLint = 0;

        // SAFETY: one integer out.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("GetActiveUniformBlockiv", "Program create Failed");
                return Ok(false);
            }

            gl.get_active_uniform_blockiv(program as glw::GLuint, 0, glw::GL_UNIFORM_BLOCK_DATA_SIZE, &mut data);

            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("GetActiveUniformBlockiv", "Failed");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetActiveUniformBlockName`
    fn get_active_uniform_block_name(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut name = [0 as glw::GLchar; 256];
        let mut length: glw::GLsizei = 0;

        // SAFETY: `name` has the 256 characters the call is told about.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("GetActiveUniformBlockName", "Program create Failed");
                return Ok(false);
            }

            gl.get_active_uniform_block_name(program as glw::GLuint, 0, 256, &mut length, name.as_mut_ptr());

            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("GetActiveUniformBlockName", "Failed");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallUniformBlockBinding`
    fn uniform_block_binding(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain handles and integers.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("UniformBlockBinding", "Program create Failed");
                return Ok(false);
            }

            gl.uniform_block_binding(program as glw::GLuint, 0, 0);

            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("UniformBlockBinding", "Failed");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }
}
