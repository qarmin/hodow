// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, last part (`glVertexAttribIPointer` to `glIsVertexArray`): integer vertex attributes, `glClearBuffer*`, `glGetStringi`, `glBlitFramebuffer` and vertex arrays. `glRenderbufferStorageMultisample` and `glFramebufferTextureLayer` are "not implemented yet" stubs upstream and are not listed here; `glIsVertexArray` is called through the global entry point upstream.

use super::Coverage;
use crate::generated::khr_api_coverage as data;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_vertex(&self, name: &str) -> Option<Result<bool, TestError>> {
        let gl = self.gl;
        let ints = [1, 2, 3, 4];
        let uints = [1u32, 2, 3, 4];
        // SAFETY (every closure below): the arrays cover what the call reads.
        Some(match name {
            "glVertexAttribIPointer" => self.vertex_attrib_i_pointer(),
            "glGetVertexAttribIiv" => {
                let mut buf = [0 as glw::GLint; 10];
                let buf_ptr = buf.as_mut_ptr();
                Ok(
                    self.scan_invalid_enum("CallGetVertexAttribIiv", &data::EA_GET_VERTEX_ATTRIB, |pname| unsafe {
                        gl.get_vertex_attrib_iiv(1, pname, buf_ptr)
                    }),
                )
            }
            "glGetVertexAttribIuiv" => {
                let mut buf = [0 as glw::GLuint; 10];
                let buf_ptr = buf.as_mut_ptr();
                Ok(
                    self.scan_invalid_enum("CallGetVertexAttribIuiv", &data::EA_GET_VERTEX_ATTRIB, |pname| unsafe {
                        gl.get_vertex_attrib_iuiv(1, pname, buf_ptr)
                    }),
                )
            }
            "glVertexAttribI4i" => {
                self.expect_no_error_call("VertexAttribI4i", || unsafe { gl.vertex_attrib_i_4i(0, 1, 2, 3, 4) })
            }
            "glVertexAttribI4iv" => self.expect_no_error_call("VertexAttribI4iv", || unsafe {
                gl.vertex_attrib_i_4iv(0, ints.as_ptr())
            }),
            "glVertexAttribI4ui" => {
                self.expect_no_error_call("VertexAttribI4ui", || unsafe { gl.vertex_attrib_i_4ui(0, 1, 2, 3, 4) })
            }
            "glVertexAttribI4uiv" => self.expect_no_error_call("VertexAttribI4uiv", || unsafe {
                gl.vertex_attrib_i_4uiv(0, uints.as_ptr())
            }),
            "glGetUniformuiv" => self.get_uniformuiv(),
            "glGetFragDataLocation" => self.get_frag_data_location(),
            "glUniform2ui" => self.expect_invalid_operation("CallUniform2ui", || unsafe { gl.uniform_2ui(0, 1, 2) }),
            "glUniform2uiv" => {
                self.expect_invalid_operation("CallUniform2uiv", || unsafe { gl.uniform_2uiv(0, 2, uints.as_ptr()) })
            }
            "glClearBufferiv" => self.expect_no_error_call("ClearBufferiv", || unsafe {
                gl.clear_bufferiv(glw::GL_STENCIL, 0, [0 as glw::GLint; 4].as_ptr())
            }),
            "glClearBufferuiv" => self.expect_no_error_call("ClearBufferuiv", || unsafe {
                gl.clear_bufferuiv(glw::GL_COLOR, 0, [0 as glw::GLuint; 4].as_ptr())
            }),
            "glClearBufferfv" => self.expect_no_error_call("ClearBufferfv", || unsafe {
                gl.clear_bufferfv(glw::GL_DEPTH, 0, [0.0f32].as_ptr())
            }),
            "glClearBufferfi" => self.expect_no_error_call("ClearBufferfi", || unsafe {
                gl.clear_bufferfi(glw::GL_DEPTH_STENCIL, 0, 0.0, 0)
            }),
            "glGetStringi" => self.get_stringi(),
            "glBlitFramebuffer" => self.blit_framebuffer(),
            "glBindVertexArray" => self.bind_vertex_array(),
            "glDeleteVertexArrays" => self.delete_vertex_arrays(),
            "glGenVertexArrays" => self.gen_vertex_arrays(),
            "glIsVertexArray" => self.is_vertex_array(),
            _ => return None,
        })
    }

    /// The tests that make one call and want `GL_NO_ERROR`, reported as a failed test rather than thrown.
    fn expect_no_error_call(&self, test: &str, call: impl FnOnce()) -> Result<bool, TestError> {
        call();
        // SAFETY: getError takes no arguments.
        if unsafe { self.gl.get_error() } != glw::GL_NO_ERROR {
            self.fail_msg(test, "Failed.");
            return Ok(false);
        }
        Ok(true)
    }

    /// `TestCoverageGLCallVertexAttribIPointer`
    fn vertex_attrib_i_pointer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
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

            gl.vertex_attrib_i_pointer(0, 1, glw::GL_INT, 0, std::ptr::null());
            glu::expect_no_error(gl, "vertexAttribIPointer")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("VertexAttribIPointer", "Failed.");
                success = false;
            }

            gl.vertex_attrib_i_pointer(0, 1, glw::GL_FLOAT, 0, std::ptr::null());
            if gl.get_error() != glw::GL_INVALID_ENUM {
                self.fail_msg("VertexAttribIPointer", "Failed.");
                success = false;
            }

            if vbo != 0 {
                gl.delete_buffers(1, &vbo);
                glu::expect_no_error(gl, "glDeleteBuffers")?;
            }
            if vao != 0 {
                gl.delete_vertex_arrays(1, &vao);
                glu::expect_no_error(gl, "glDeleteVertexArrays")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetUniformuiv`
    fn get_uniformuiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLuint; 10];

        // SAFETY: the program is unlinked, so the call fails before writing.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_uniformuiv(program, 0, buf.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("GetUniformuiv", "GL_INVALID_OPERATION not returned.");
                success = false;
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetFragDataLocation`
    fn get_frag_data_location(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: the name is NUL-terminated.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_frag_data_location(program, c"fragData".as_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("GetFragDataLocation", "GL_INVALID_OPERATION not returned.");
                success = false;
            }

            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetStringi`
    fn get_stringi(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut count: glw::GLint = 0;

        // SAFETY: the returned strings are read only after a null check.
        unsafe {
            let _ = gl.get_error();

            gl.get_integerv(glw::GL_NUM_EXTENSIONS, &mut count);
            let max = count;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetStringi", "Get NUM_EXTENSIONS failed.");
                return Ok(false);
            }

            for i in (0..max).rev() {
                let pstr = gl.get_stringi(glw::GL_EXTENSIONS, i as glw::GLuint);
                if gl.get_error() != glw::GL_NO_ERROR || pstr.is_null() || *pstr == 0 {
                    self.fail_msg("GetStringi", "Get EXTENSION failed.");
                    return Ok(false);
                }
            }

            let _ = gl.get_stringi(glw::GL_EXTENSIONS, max as glw::GLuint);
            if gl.get_error() != glw::GL_INVALID_VALUE {
                success = false;
                self.fail_msg("GetStringi", "Get EXTENSION with invalid index succeeded.");
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBlitFramebuffer` (the default framebuffer is name 0; the ES 3.0 overlap branch is not reached on desktop)
    fn blit_framebuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let (width, height) = (32, 32);
        let mut fbo: glw::GLuint = 0;
        let mut rbo_color: glw::GLuint = 0;
        let mut rbo_depth: glw::GLuint = 0;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            gl.gen_framebuffers(1, &mut fbo);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            gl.gen_renderbuffers(1, &mut rbo_color);
            glu::expect_no_error(gl, "genRenderbuffers")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_color);
            glu::expect_no_error(gl, "bindRenderbuffer")?;
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, width, height);
            glu::expect_no_error(gl, "renderbufferStorage")?;
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo_color,
            );
            glu::expect_no_error(gl, "framebufferRenderbuffer")?;

            gl.gen_renderbuffers(1, &mut rbo_depth);
            glu::expect_no_error(gl, "genRenderbuffers")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_depth);
            glu::expect_no_error(gl, "bindRenderbuffer")?;
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, width, height);
            glu::expect_no_error(gl, "renderbufferStorage")?;
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                rbo_depth,
            );
            glu::expect_no_error(gl, "framebufferRenderbuffer")?;
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                rbo_depth,
            );
            glu::expect_no_error(gl, "framebufferRenderbuffer")?;

            let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                self.fail_msg(
                    "BlitFramebuffer",
                    &format!("Expected GL_FRAMEBUFFER_COMPLETE, got 0x{status:x}"),
                );
                return Ok(false);
            }

            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            gl.blit_framebuffer(0, 0, width, height, 0, 0, width, height, 0, glw::GL_NEAREST);
            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                self.fail_msg("BlitFramebuffer", &format!("Expected GL_NO_ERROR, got 0x{error:x} (1)"));
                success = false;
            }

            gl.blit_framebuffer(
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height,
                glw::GL_COLOR_BUFFER_BIT | glw::GL_MAP_INVALIDATE_BUFFER_BIT,
                glw::GL_NEAREST,
            );
            let error = gl.get_error();
            if error != glw::GL_INVALID_VALUE {
                self.fail_msg(
                    "BlitFramebuffer",
                    &format!("Expected GL_INVALID_VALUE, got 0x{error:x} (2)"),
                );
                success = false;
            }

            gl.blit_framebuffer(
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height,
                glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                glw::GL_LINEAR,
            );
            let error = gl.get_error();
            if error != glw::GL_INVALID_OPERATION {
                self.fail_msg(
                    "BlitFramebuffer",
                    &format!("Expected GL_INVALID_OPERATION, got 0x{error:x} (3)"),
                );
                success = false;
            }

            // Overlapping blits are allowed with desktop GL.
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            glu::expect_no_error(gl, "bindFramebuffer")?;
            gl.blit_framebuffer(
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_NEAREST,
            );
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BlitFramebuffer", "Failed!");
                success = false;
            }

            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo);
            glu::expect_no_error(gl, "bindFramebuffer")?;
            gl.blit_framebuffer(
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_NEAREST,
            );
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BlitFramebuffer", "Failed!");
                success = false;
            }

            gl.delete_framebuffers(1, &fbo);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
            gl.delete_renderbuffers(1, &rbo_color);
            glu::expect_no_error(gl, "deleteRenderbuffers")?;
            gl.delete_renderbuffers(1, &rbo_depth);
            glu::expect_no_error(gl, "deleteRenderbuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindVertexArray`
    fn bind_vertex_array(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut va: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            gl.gen_vertex_arrays(1, &mut va);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(va);
            if gl.get_error() != glw::GL_NO_ERROR {
                success = false;
                self.fail_msg("BindVertexArray", "Failed");
            }
            gl.delete_vertex_arrays(1, &va);
            glu::expect_no_error(gl, "deleteVertexArrays")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDeleteVertexArrays`
    fn delete_vertex_arrays(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut va: glw::GLuint = 0;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            gl.gen_vertex_arrays(1, &mut va);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.delete_vertex_arrays(1, &va);
            glu::expect_no_error(gl, "deleteVertexArrays")?;

            gl.gen_vertex_arrays(1, &mut va);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(va);
            glu::expect_no_error(gl, "bindVertexArray")?;
            gl.delete_vertex_arrays(1, &va);
            if gl.get_error() != glw::GL_NO_ERROR {
                success = false;
                self.fail_msg("DeleteVertexArray", "Failed");
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenVertexArrays`
    fn gen_vertex_arrays(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut va = [0 as glw::GLuint; 3];

        // SAFETY: `va` holds the three names generated and deleted.
        unsafe {
            gl.gen_vertex_arrays(3, va.as_mut_ptr());
            if va.contains(&0) || gl.get_error() != glw::GL_NO_ERROR {
                success = false;
                self.fail_msg("GenVertexArrays", "Failed");
            }
            gl.delete_vertex_arrays(3, va.as_ptr());
            glu::expect_no_error(gl, "deleteVertexArrays")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsVertexArray`
    fn is_vertex_array(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut va: glw::GLuint = 0;

        // SAFETY: one name generated and deleted.
        unsafe {
            gl.gen_vertex_arrays(1, &mut va);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(va);
            glu::expect_no_error(gl, "bindVertexArray")?;

            if gl.is_vertex_array(va) != glw::TRUE {
                success = false;
                self.fail_msg("IsVertexArray", "Failed - TRUE");
            }
            if gl.is_vertex_array(va + 1) != glw::FALSE {
                success = false;
                self.fail_msg("IsVertexArray", "Failed - ");
            }

            gl.delete_vertex_arrays(1, &va);
            glu::expect_no_error(gl, "deleteVertexArrays")?;
        }

        Ok(success)
    }
}
