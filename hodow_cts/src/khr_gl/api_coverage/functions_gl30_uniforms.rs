// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, third part (`glUniform*` to `glViewport`): the 19 uniform tests are one body that calls the function with no program in use and wants `GL_INVALID_OPERATION` (`expect_invalid_operation`); the generic vertex attribute calls follow.

use super::Coverage;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_uniforms(&self, name: &str) -> Option<Result<bool, TestError>> {
        let gl = self.gl;
        let ints = [1, 2, 3, 4, 5, 6, 7, 8];
        let floats = [
            1.0f32, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
        ];
        // SAFETY (every closure below): no program is in use, so each call fails before reading its arrays, which cover what the call is told about anyway.
        Some(match name {
            "glUniform1i" => self.expect_invalid_operation("CallUniform1i", || unsafe { gl.uniform_1i(0, 1) }),
            "glUniform2i" => self.expect_invalid_operation("CallUniform2i", || unsafe { gl.uniform_2i(0, 1, 2) }),
            "glUniform3i" => self.expect_invalid_operation("CallUniform3i", || unsafe { gl.uniform_3i(0, 1, 2, 3) }),
            "glUniform4i" => self.expect_invalid_operation("CallUniform4i", || unsafe { gl.uniform_4i(0, 1, 2, 3, 4) }),
            "glUniform1f" => self.expect_invalid_operation("CallUniform1f", || unsafe { gl.uniform_1f(0, 1.0) }),
            "glUniform2f" => self.expect_invalid_operation("CallUniform2f", || unsafe { gl.uniform_2f(0, 1.0, 2.0) }),
            "glUniform3f" => {
                self.expect_invalid_operation("CallUniform3f", || unsafe { gl.uniform_3f(0, 1.0, 2.0, 3.0) })
            }
            "glUniform4f" => {
                self.expect_invalid_operation("CallUniform4f", || unsafe { gl.uniform_4f(0, 1.0, 2.0, 3.0, 4.0) })
            }
            "glUniform1iv" => {
                self.expect_invalid_operation("CallUniform1iv", || unsafe { gl.uniform_1iv(0, 2, ints.as_ptr()) })
            }
            "glUniform2iv" => {
                self.expect_invalid_operation("CallUniform2iv", || unsafe { gl.uniform_2iv(0, 2, ints.as_ptr()) })
            }
            "glUniform3iv" => {
                self.expect_invalid_operation("CallUniform3iv", || unsafe { gl.uniform_3iv(0, 2, ints.as_ptr()) })
            }
            "glUniform4iv" => {
                self.expect_invalid_operation("CallUniform4iv", || unsafe { gl.uniform_4iv(0, 2, ints.as_ptr()) })
            }
            "glUniform1fv" => {
                self.expect_invalid_operation("CallUniform1fv", || unsafe { gl.uniform_1fv(0, 2, floats.as_ptr()) })
            }
            "glUniform2fv" => {
                self.expect_invalid_operation("CallUniform2fv", || unsafe { gl.uniform_2fv(0, 2, floats.as_ptr()) })
            }
            "glUniform3fv" => {
                self.expect_invalid_operation("CallUniform3fv", || unsafe { gl.uniform_3fv(0, 2, floats.as_ptr()) })
            }
            "glUniform4fv" => {
                self.expect_invalid_operation("CallUniform4fv", || unsafe { gl.uniform_4fv(0, 2, floats.as_ptr()) })
            }
            "glUniformMatrix2fv" => self.expect_invalid_operation("CallUniformMatrix2fv", || unsafe {
                gl.uniform_matrix_2fv(0, 1, glw::FALSE, floats.as_ptr())
            }),
            "glUniformMatrix3fv" => self.expect_invalid_operation("CallUniformMatrix3fv", || unsafe {
                gl.uniform_matrix_3fv(0, 1, glw::FALSE, floats.as_ptr())
            }),
            "glUniformMatrix4fv" => self.expect_invalid_operation("CallUniformMatrix4fv", || unsafe {
                gl.uniform_matrix_4fv(0, 1, glw::FALSE, floats.as_ptr())
            }),
            "glUseProgram" => self.use_program(),
            "glValidateProgram" => self.validate_program(),
            "glVertexAttrib1f" => self.vertex_attrib_ok("vertexAttrib1f", || unsafe { gl.vertex_attrib_1f(0, 1.0) }),
            "glVertexAttrib2f" => {
                self.vertex_attrib_ok("vertexAttrib2f", || unsafe { gl.vertex_attrib_2f(0, 1.0, 2.0) })
            }
            "glVertexAttrib3f" => {
                self.vertex_attrib_ok("vertexAttrib3f", || unsafe { gl.vertex_attrib_3f(0, 1.0, 2.0, 3.0) })
            }
            "glVertexAttrib4f" => self.vertex_attrib_ok("vertexAttrib4f", || unsafe {
                gl.vertex_attrib_4f(0, 1.0, 2.0, 3.0, 4.0)
            }),
            "glVertexAttrib1fv" => self.vertex_attrib_ok("vertexAttrib1fv", || unsafe {
                gl.vertex_attrib_1fv(0, floats.as_ptr())
            }),
            "glVertexAttrib2fv" => self.vertex_attrib_ok("vertexAttrib2fv", || unsafe {
                gl.vertex_attrib_2fv(0, floats.as_ptr())
            }),
            "glVertexAttrib3fv" => self.vertex_attrib_ok("vertexAttrib3fv", || unsafe {
                gl.vertex_attrib_3fv(0, floats.as_ptr())
            }),
            "glVertexAttrib4fv" => self.vertex_attrib_ok("vertexAttrib4fv", || unsafe {
                gl.vertex_attrib_4fv(0, floats.as_ptr())
            }),
            "glVertexAttribPointer" => self.vertex_attrib_pointer(),
            "glViewport" => self.vertex_attrib_ok("viewport", || unsafe { gl.viewport(0, 0, 50, 50) }),
            _ => return None,
        })
    }

    /// The uniform tests: the call, then `GL_INVALID_OPERATION`.
    pub(super) fn expect_invalid_operation(&self, test: &str, call: impl FnOnce()) -> Result<bool, TestError> {
        call();
        // SAFETY: getError takes no arguments.
        if unsafe { self.gl.get_error() } != glw::GL_INVALID_OPERATION {
            self.fail_msg(test, "GL_INVALID_OPERATION not returned");
            return Ok(false);
        }
        Ok(true)
    }

    /// The tests that make one call and want no error.
    fn vertex_attrib_ok(&self, message: &str, call: impl FnOnce()) -> Result<bool, TestError> {
        call();
        glu::expect_no_error(self.gl, message)?;
        Ok(true)
    }

    /// `TestCoverageGLCallUseProgram`
    fn use_program(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain handles.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.use_program(program);
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CallUseProgram", "GL_INVALID_OPERATION not returned");
                success = false;
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallValidateProgram`
    fn validate_program(&self) -> Result<bool, TestError> {
        let gl = self.gl;

        // SAFETY: plain handles.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            gl.validate_program(program);
            glu::expect_no_error(gl, "validateProgram")?;
            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallVertexAttribPointer`
    fn vertex_attrib_pointer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let buf = [1.0f32];
        let mut vbo: glw::GLuint = 0;
        let mut vao: glw::GLuint = 0;

        // SAFETY: `buf` covers the 4 bytes uploaded; the attribute pointer is an offset into the bound buffer.
        unsafe {
            gl.gen_buffers(1, &mut vbo);
            glu::expect_no_error(gl, "glGenBuffers")?;
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo);
            glu::expect_no_error(gl, "glBindBuffer")?;
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&buf) as glw::GLsizeiptr,
                buf.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "glBufferData")?;

            gl.gen_vertex_arrays(1, &mut vao);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(vao);
            glu::expect_no_error(gl, "bindVertexArray")?;

            gl.vertex_attrib_pointer(0, 1, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            glu::expect_no_error(gl, "vertexAttribPointer")?;

            if vbo != 0 {
                gl.delete_buffers(1, &vbo);
                glu::expect_no_error(gl, "glDeleteBuffers")?;
            }
            if vao != 0 {
                gl.delete_vertex_arrays(1, &vao);
                glu::expect_no_error(gl, "glDeleteVertexArrays")?;
            }
        }

        Ok(true)
    }
}
