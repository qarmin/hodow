// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, sixth part (`glReadBuffer` to `glUniformMatrix2x4fv`): read and draw buffers, 3D textures, queries and buffer mapping. The four buffer mapping tests build the same scene (`MapScene`) and tear it down in one order, where upstream copies the setup into each and tears down in slightly different orders. `glMapBufferRange` is called through the global entry point upstream.

use super::Coverage;
use crate::generated::khr_api_coverage as data;
use crate::tcu::TestError;
use crate::{glu, glw};

const COMPRESSED_TEXTURE_SIZE: [glw::GLsizei; 14] = [8, 8, 16, 16, 8, 16, 8, 16, 8, 8, 8, 8, 16, 16];

const POSITION: [f32; 12] = [
    -0.5, -0.625, 0.5, 1.0, 0.125, 0.75, 0.625, 1.125, 0.875, -0.75, 1.125, 1.5,
];

/// The objects the buffer mapping tests set up.
struct MapScene {
    vbo: glw::GLuint,
    vao: glw::GLuint,
    tf_obj: glw::GLuint,
    buf_obj: glw::GLuint,
    tf_supported: bool,
}

impl Coverage<'_> {
    pub(super) fn run_func_gl30_objects(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glReadBuffer" => self.read_buffer(),
            "glDrawRangeElements" => self.draw_range_elements(),
            "glTexImage3D" => self.tex_image_3d(),
            "glTexSubImage3D" => self.tex_sub_image_3d(),
            "glCopyTexSubImage3D" => self.copy_tex_sub_image_3d(),
            "glCompressedTexImage3D" => self.compressed_tex_image_3d(false),
            "glCompressedTexSubImage3D" => self.compressed_tex_image_3d(true),
            "glGenQueries" => self.gen_queries(),
            "glDeleteQueries" => self.delete_queries(),
            "glIsQuery" => self.is_query(),
            "glBeginQuery" => self.begin_query(),
            "glEndQuery" => self.end_query(),
            "glGetQueryiv" => self.get_queryiv(),
            "glGetQueryObjectuiv" => self.get_query_objectuiv(),
            "glGetBufferPointerv" => self.get_buffer_pointerv(),
            "glMapBufferRange" => self.map_buffer_range(),
            "glUnmapBuffer" => self.unmap_buffer(),
            "glFlushMappedBufferRange" => self.flush_mapped_buffer_range(),
            "glDrawBuffers" => self.draw_buffers(),
            "glUniformMatrix2x4fv" => self.uniform_matrix_2x4fv(),
            _ => return None,
        })
    }

    /// `m_is_transform_feedback_obj_supported`, desktop branch.
    pub(super) fn transform_feedback_obj_supported(&self) -> bool {
        self.context.context_type().supports_core(4, 0)
            || self
                .context
                .context_info
                .is_extension_supported("GL_ARB_transform_feedback2")
    }

    /// `TestCoverageGLCallReadBuffer`
    fn read_buffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let (width, height) = (32, 32);
        let mut fbo: glw::GLuint = 0;
        let mut rbo_color = [0 as glw::GLuint; 4];
        let mut orig_read_buffer: glw::GLint = 0;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            gl.get_integerv(glw::GL_READ_BUFFER, &mut orig_read_buffer);
            glu::expect_no_error(gl, "getIntegerv")?;

            for read_buffer in data::EA_READ_BUFFER {
                gl.read_buffer(read_buffer);
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR && read_buffer <= glw::GL_BACK {
                    let mut draw_buffer: glw::GLint = 0;
                    gl.get_integerv(glw::GL_DRAW_BUFFER, &mut draw_buffer);
                    let config_is_double_buffered = draw_buffer as glw::GLenum == glw::GL_BACK;
                    // Calling glReadBuffer(GL_BACK) on a drawable without a back buffer is an expected error.
                    if !config_is_double_buffered && read_buffer == glw::GL_BACK && error == glw::GL_INVALID_OPERATION {
                        continue;
                    }
                    self.fail_msg("ReadBuffer", &format!("Invalid error {error} for 0x{read_buffer:x}."));
                    success = false;
                }
            }

            gl.gen_framebuffers(1, &mut fbo);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            gl.gen_renderbuffers(4, rbo_color.as_mut_ptr());
            glu::expect_no_error(gl, "genRenderbuffers")?;
            for (index, attachment) in [(0, glw::GL_COLOR_ATTACHMENT0), (1, glw::GL_COLOR_ATTACHMENT1)] {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_color[index]);
                glu::expect_no_error(gl, "bindRenderbuffer")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, width, height);
                glu::expect_no_error(gl, "renderbufferStorage")?;
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, rbo_color[index]);
                glu::expect_no_error(gl, "framebufferRenderbuffer")?;
            }

            let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                self.fail_msg(
                    "ReadBuffers",
                    &format!("Expected GL_FRAMEBUFFER_COMPLETE, got 0x{status:x}"),
                );
                return Ok(false);
            }

            for read_buffer in data::EA_READ_BUFFER {
                gl.read_buffer(read_buffer);
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR && read_buffer > glw::GL_BACK {
                    self.fail_msg(
                        "ReadBuffer",
                        &format!("Invalid error {error} for FBO 0x{read_buffer:x}."),
                    );
                    success = false;
                }
            }

            gl.delete_framebuffers(1, &fbo);
            glu::expect_no_error(gl, "deleteFramebuffers")?;

            gl.read_buffer(orig_read_buffer as glw::GLenum);
            glu::expect_no_error(gl, "readBuffer")?;

            gl.delete_framebuffers(1, &fbo);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
            gl.delete_renderbuffers(4, rbo_color.as_ptr());
            glu::expect_no_error(gl, "deleteRenderbuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDrawRangeElements`
    fn draw_range_elements(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let indices: [u16; 6] = [2, 1, 0, 2, 1, 0];
        let mut va: glw::GLuint = 0;

        // SAFETY: the client-side index array lives across the calls.
        unsafe {
            gl.gen_vertex_arrays(1, &mut va);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(va);
            glu::expect_no_error(gl, "bindVertexArray")?;

            let program = self.create_default_program(0)?;
            if program == -1 {
                self.fail_msg("DrawRangeElements", "Program create Failed");
                return Ok(false);
            }

            gl.draw_range_elements(
                glw::GL_TRIANGLES,
                0,
                5,
                3,
                glw::GL_UNSIGNED_SHORT,
                indices.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "drawRangeElements")?;
            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                success = false;
                self.fail_msg("DrawRangeElements", &format!("Incorrect error {error}"));
            }

            gl.draw_range_elements(
                glw::GL_TRIANGLES,
                2,
                1,
                3,
                glw::GL_UNSIGNED_SHORT,
                indices.as_ptr().cast(),
            );
            let error = gl.get_error();
            if error != glw::GL_INVALID_VALUE {
                success = false;
                self.fail_msg("DrawRangeElements", &format!("Incorrect error {error}"));
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
            gl.delete_vertex_arrays(1, &va);
            glu::expect_no_error(gl, "deleteVertexArrays")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallTexImage3D`
    fn tex_image_3d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];

        // SAFETY: a 1x1x1 upload reads at most 16 bytes of `buf`.
        unsafe {
            for target in data::EA_TEXTURE3_DTARGET {
                for (j, format) in data::EA_TEXTURE_FORMAT.into_iter().enumerate() {
                    let type_ = data::EA_TEXTURE_TYPE[j];

                    gl.tex_image_3d(
                        target,
                        0,
                        format as glw::GLint,
                        1,
                        1,
                        1,
                        0,
                        format,
                        type_,
                        buf.as_ptr().cast(),
                    );
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallTexImage3D",
                            &format!("Invalid enums : (0x{target:x}, 0x{format:x}, 0x{type_:x})"),
                        );
                        success = false;
                    }

                    gl.tex_image_3d(
                        target,
                        0,
                        format as glw::GLint,
                        1,
                        1,
                        1,
                        0,
                        format,
                        type_,
                        std::ptr::null(),
                    );
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallTexImage3D",
                            &format!("Invalid enums : (0x{target:x}, 0x{format:x}, 0x{type_:x})"),
                        );
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallTexSubImage3D`
    fn tex_sub_image_3d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];

        // SAFETY: the 1x1x1 transfers read at most 16 bytes of `buf`.
        unsafe {
            for (i, format) in data::EA_TEXTURE_FORMAT.into_iter().enumerate() {
                let type_ = data::EA_TEXTURE_TYPE[i];

                gl.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    format as glw::GLint,
                    1,
                    1,
                    1,
                    0,
                    format,
                    type_,
                    buf.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "texImage3D")?;
                gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    0,
                    0,
                    0,
                    1,
                    1,
                    1,
                    format,
                    type_,
                    buf.as_ptr().cast(),
                );
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg(
                        "CallTexSubImage3D",
                        &format!("Invalid enums : (0x{format:x}, 0x{type_:x})"),
                    );
                    success = false;
                }

                gl.tex_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    format as glw::GLint,
                    1,
                    1,
                    1,
                    0,
                    format,
                    type_,
                    std::ptr::null(),
                );
                glu::expect_no_error(gl, "texImage3D")?;
                gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    0,
                    0,
                    0,
                    1,
                    1,
                    1,
                    format,
                    type_,
                    buf.as_ptr().cast(),
                );
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg(
                        "CallTexSubImage3D",
                        &format!("Invalid enums : (0x{format:x}, 0x{type_:x})"),
                    );
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallCopyTexSubImage3D`
    fn copy_tex_sub_image_3d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];
        let color_buffer_format = self.guess_color_buffer_format()?;

        // SAFETY: the 1x1x1 upload reads at most 4 bytes of `buf`.
        unsafe {
            for target_format in Self::calc_target_formats(color_buffer_format) {
                gl.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    target_format as glw::GLint,
                    1,
                    1,
                    1,
                    0,
                    target_format,
                    glw::GL_UNSIGNED_BYTE,
                    buf.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "texImage3D")?;
                gl.copy_tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, 0, 0, 1, 1);
                glu::expect_no_error(gl, "copyTexSubImage3D")?;
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallCopyTexSubImage3D", &format!("Invalid enum : 0x{target_format:x}"));
                    success = false;
                }

                gl.tex_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    target_format as glw::GLint,
                    1,
                    1,
                    1,
                    0,
                    target_format,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                glu::expect_no_error(gl, "texImage3D")?;
                gl.copy_tex_sub_image_3d(glw::GL_TEXTURE_2D_ARRAY, 0, 0, 0, 0, 0, 0, 1, 1);
                glu::expect_no_error(gl, "copyTexSubImage3D")?;
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallCopyTexSubImage3D", &format!("Invalid enum : 0x{target_format:x}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallCompressedTexImage3D`, or with `sub_image` `TestCoverageGLCallCompressedTexSubImage3D`.
    fn compressed_tex_image_3d(&self, sub_image: bool) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];
        let test = if sub_image {
            "CallCompressedTexSubImage3D"
        } else {
            "CallCompressedTexImage3D"
        };
        let is_etc = |format: glw::GLenum| {
            (glw::GL_COMPRESSED_R11_EAC..=glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC).contains(&format)
        };
        let is_rgtc =
            |format: glw::GLenum| (glw::GL_COMPRESSED_RED_RGTC1..=glw::GL_COMPRESSED_SIGNED_RG_RGTC2).contains(&format);
        let etc_supported = self
            .context
            .context_info
            .is_extension_supported("GL_ARB_ES3_compatibility")
            || self.context.context_type().supports_core(4, 3);
        let rgtc_supported = self
            .context
            .context_info
            .is_extension_supported("GL_ARB_texture_compression_rgtc")
            || self.context.context_type().supports_core(3, 0);

        // SAFETY: `buf` covers the 8 or 16 bytes of one 4x4 block.
        unsafe {
            for target in data::EA_COMPRESSED_TEXTURE3_DTARGET {
                for (j, format) in data::EA_COMPRESSED_TEXTURE_FORMAT.into_iter().enumerate() {
                    if (is_etc(format) && !etc_supported) || (is_rgtc(format) && !rgtc_supported) {
                        continue;
                    }

                    gl.compressed_tex_image_3d(
                        target,
                        0,
                        format,
                        4,
                        4,
                        1,
                        0,
                        COMPRESSED_TEXTURE_SIZE[j],
                        buf.as_ptr().cast(),
                    );
                    if sub_image {
                        gl.compressed_tex_sub_image_3d(
                            target,
                            0,
                            0,
                            0,
                            0,
                            4,
                            4,
                            1,
                            format,
                            COMPRESSED_TEXTURE_SIZE[j],
                            buf.as_ptr().cast(),
                        );
                        if gl.get_error() == glw::GL_INVALID_ENUM {
                            self.fail_msg(test, &format!("Invalid enums : (0x{target:x}, 0x{format:x})"));
                            success = false;
                        }
                    } else {
                        if gl.get_error() == glw::GL_INVALID_ENUM {
                            self.fail_msg(test, &format!("Invalid enums : (0x{target:x}, 0x{format:x})"));
                            success = false;
                        }

                        gl.compressed_tex_image_3d(
                            target,
                            0,
                            format,
                            4,
                            4,
                            1,
                            0,
                            COMPRESSED_TEXTURE_SIZE[j],
                            std::ptr::null(),
                        );
                        if gl.get_error() == glw::GL_INVALID_ENUM {
                            self.fail_msg(test, &format!("Invalid enums : (0x{target:x}, 0x{format:x})"));
                            success = false;
                        }
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenQueries`
    fn gen_queries(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GenQueries", "Failed.");
                success = false;
            }
            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDeleteQueries`
    fn delete_queries(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GenQueries", "Failed to create a query object.");
                success = false;
            }
            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DeleteQueries", "Failed to deleate a query object.");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsQuery`
    fn is_query(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsQuery", "Failed to create a query object.");
                success = false;
            }

            if gl.is_query(0) == glw::TRUE {
                self.fail_msg("IsQuery", "Failed on id 0.");
                success = false;
            }

            if gl.is_query(q[0]) == glw::TRUE {
                self.fail_msg("IsQuery", &format!("Failed on id {}.", q[0]));
                success = false;
            }

            gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, q[0]);
            glu::expect_no_error(gl, "beginQuery")?;

            if gl.is_query(q[0]) == glw::FALSE {
                self.fail_msg("IsQuery", &format!("Failed on id {}.", q[0]));
                success = false;
            }

            gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            glu::expect_no_error(gl, "endQuery")?;

            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBeginQuery`
    fn begin_query(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];
        let mut result: glw::GLuint = 0;

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BeginQuery", "Failed to create a query object.");
                success = false;
            }

            gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, q[0]);
            glu::expect_no_error(gl, "beginQuery")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("BeginQuery", "Failed to begin query.");
                success = false;
            }

            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "clear")?;

            gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            glu::expect_no_error(gl, "endQuery")?;

            gl.finish();
            glu::expect_no_error(gl, "finish")?;

            gl.get_query_objectuiv(q[0], glw::GL_QUERY_RESULT, &mut result);
            glu::expect_no_error(gl, "getQueryObjectuiv")?;

            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallEndQuery`
    fn end_query(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];
        let mut result: glw::GLuint = 0;

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("EndQuery", "Failed to create a query object.");
                success = false;
            }

            gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, q[0]);
            glu::expect_no_error(gl, "beginQuery")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("EndQuery", "Failed to begin query.");
                success = false;
            }

            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "clear")?;

            let _ = gl.get_error();

            gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            glu::expect_no_error(gl, "endQuery")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("EndQuery", "Failed to end query.");
                success = false;
            }

            gl.get_query_objectuiv(q[0], glw::GL_QUERY_RESULT, &mut result);
            glu::expect_no_error(gl, "getQueryObjectuiv")?;

            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetQueryiv`
    fn get_queryiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];
        let mut iresult: glw::GLint = 0;
        let mut uresult: glw::GLuint = 0;

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetQueryiv", "Failed to create a query object.");
                success = false;
            }

            gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, q[0]);
            glu::expect_no_error(gl, "beginQuery")?;

            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "clear")?;

            let _ = gl.get_error();

            gl.get_queryiv(glw::GL_ANY_SAMPLES_PASSED, glw::GL_CURRENT_QUERY, &mut iresult);
            glu::expect_no_error(gl, "getQueryiv")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetQueryiv", "Failed to get active query object.");
                success = false;
            }

            gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            glu::expect_no_error(gl, "endQuery")?;

            gl.get_query_objectuiv(q[0], glw::GL_QUERY_RESULT, &mut uresult);
            glu::expect_no_error(gl, "getQueryObjectuiv")?;

            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetQueryObjectuiv`
    fn get_query_objectuiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut q = [0 as glw::GLuint; 2];
        let mut result: glw::GLuint = 0;

        // SAFETY: `q` holds the two names generated and deleted.
        unsafe {
            gl.gen_queries(2, q.as_mut_ptr());
            glu::expect_no_error(gl, "genQueries")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetQueryiv", "Failed to create a query object.");
                success = false;
            }

            gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, q[0]);
            glu::expect_no_error(gl, "beginQuery")?;

            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "clear")?;

            gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            glu::expect_no_error(gl, "endQuery")?;

            let _ = gl.get_error();

            gl.get_query_objectuiv(q[0], glw::GL_QUERY_RESULT, &mut result);
            glu::expect_no_error(gl, "getQueryObjectuiv")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetQueryObjectuiv", "Failed to get query result.");
                success = false;
            }

            gl.delete_queries(2, q.as_ptr());
            glu::expect_no_error(gl, "deleteQueries")?;
        }

        Ok(success)
    }

    /// The setup the four buffer mapping tests share, up to and including the transform feedback buffer's `bufferData`.
    fn map_scene_setup(&self) -> Result<MapScene, TestError> {
        let gl = self.gl;
        let mut scene = MapScene {
            vbo: 0,
            vao: 0,
            tf_obj: 0,
            buf_obj: 0,
            tf_supported: self.transform_feedback_obj_supported(),
        };

        // SAFETY: `POSITION` covers the bytes uploaded; the attribute pointer is an offset into the bound buffer.
        unsafe {
            gl.gen_buffers(1, &mut scene.vbo);
            glu::expect_no_error(gl, "glGenBuffers")?;
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, scene.vbo);
            glu::expect_no_error(gl, "glBindBuffer")?;
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&POSITION) as glw::GLsizeiptr,
                POSITION.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "glBufferData")?;

            gl.gen_vertex_arrays(1, &mut scene.vao);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(scene.vao);
            glu::expect_no_error(gl, "bindVertexArray")?;
            gl.enable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "enableVertexAttribArray")?;
            gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            glu::expect_no_error(gl, "vertexAttribPointer")?;

            if scene.tf_supported {
                gl.gen_transform_feedbacks(1, &mut scene.tf_obj);
                glu::expect_no_error(gl, "genTransformFeedbacks")?;
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, scene.tf_obj);
                glu::expect_no_error(gl, "bindTransformFeedback")?;
            }

            gl.gen_buffers(1, &mut scene.buf_obj);
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, scene.buf_obj);
            glu::expect_no_error(gl, "bindBufferBase")?;
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                4096,
                std::ptr::null(),
                glw::GL_DYNAMIC_READ,
            );
            glu::expect_no_error(gl, "bufferData")?;
        }

        Ok(scene)
    }

    /// The teardown the four buffer mapping tests share.
    fn map_scene_teardown(&self, scene: &MapScene) -> Result<(), TestError> {
        let gl = self.gl;

        // SAFETY: only names generated by `map_scene_setup` are deleted.
        unsafe {
            gl.delete_buffers(1, &scene.buf_obj);
            glu::expect_no_error(gl, "deleteBuffers")?;
            if scene.tf_supported {
                gl.delete_transform_feedbacks(1, &scene.tf_obj);
                glu::expect_no_error(gl, "deleteTransformFeedbacks")?;
            }
            gl.disable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "glDisableVertexAttribArray")?;
            if scene.vbo != 0 {
                gl.delete_buffers(1, &scene.vbo);
                glu::expect_no_error(gl, "glDeleteBuffers")?;
            }
            if scene.vao != 0 {
                gl.delete_vertex_arrays(1, &scene.vao);
                glu::expect_no_error(gl, "glDeleteVertexArrays")?;
            }
        }

        Ok(())
    }

    /// `TestCoverageGLCallGetBufferPointerv`
    fn get_buffer_pointerv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let scene = self.map_scene_setup()?;

        // SAFETY: the mapping is released before the buffer is deleted.
        unsafe {
            let mut mapped = gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 4096, glw::GL_MAP_READ_BIT);
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetBufferPointerv", "Setup Failed.");
                success = false;
            }

            gl.get_buffer_pointerv(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                glw::GL_BUFFER_MAP_POINTER,
                &mut mapped,
            );
            glu::expect_no_error(gl, "getBufferPointerv")?;
            if mapped.is_null() || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetBufferPointerv", "Failed.");
                success = false;
            }

            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            glu::expect_no_error(gl, "unmapBuffer")?;
        }

        self.map_scene_teardown(&scene)?;
        Ok(success)
    }

    /// `TestCoverageGLCallMapBufferRange`
    fn map_buffer_range(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let scene = self.map_scene_setup()?;

        // SAFETY: the mapping is released before the buffer is deleted.
        unsafe {
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("MapBufferRange", "Setup Failed.");
                success = false;
            }

            let mapped = gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 4096, glw::GL_MAP_READ_BIT);
            if mapped.is_null() || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("MapBufferRange", "Failed.");
                success = false;
            }

            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            glu::expect_no_error(gl, "unmapBuffer")?;
        }

        self.map_scene_teardown(&scene)?;
        Ok(success)
    }

    /// `TestCoverageGLCallUnmapBuffer`
    fn unmap_buffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let scene = self.map_scene_setup()?;

        // SAFETY: the mapping is released before the buffer is deleted.
        unsafe {
            let mapped = gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 4096, glw::GL_MAP_READ_BIT);
            if gl.get_error() != glw::GL_NO_ERROR || mapped.is_null() {
                self.fail_msg("UnmapBuffer", "Setup Failed.");
                success = false;
            }

            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            glu::expect_no_error(gl, "unmapBuffer")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("UnmapBuffer", "Failed.");
                success = false;
            }
        }

        self.map_scene_teardown(&scene)?;
        Ok(success)
    }

    /// `TestCoverageGLCallFlushMappedBufferRange`
    fn flush_mapped_buffer_range(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let scene = self.map_scene_setup()?;

        // SAFETY: the mapping is released before the buffer is deleted.
        unsafe {
            let mapped = gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                4096,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
            );
            if gl.get_error() != glw::GL_NO_ERROR || mapped.is_null() {
                self.fail_msg("FlushMappedBufferRange", "Setup Failed.");
                success = false;
            }

            gl.flush_mapped_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 4096);
            glu::expect_no_error(gl, "flushMappedBufferRange")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("FlushMappedBufferRange", "Failed.");
                success = false;
            }

            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            glu::expect_no_error(gl, "unmapBuffer")?;
        }

        self.map_scene_teardown(&scene)?;
        Ok(success)
    }

    /// `TestCoverageGLCallDrawBuffers`
    fn draw_buffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let (width, height) = (32, 32);
        let mut fbo: glw::GLuint = 0;
        let mut rbo_color = [0 as glw::GLuint; 4];
        let mut draw_buffers = data::EA_DRAW_BUFFERS;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            gl.gen_framebuffers(1, &mut fbo);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            glu::expect_no_error(gl, "bindFramebuffer")?;
            gl.gen_renderbuffers(4, rbo_color.as_mut_ptr());
            glu::expect_no_error(gl, "genRenderbuffers")?;

            for (i, attachment) in draw_buffers.into_iter().enumerate() {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_color[i]);
                glu::expect_no_error(gl, "bindRenderbuffer")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, width, height);
                glu::expect_no_error(gl, "renderbufferStorage")?;
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, rbo_color[i]);
                glu::expect_no_error(gl, "framebufferRenderbuffer")?;
            }

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                self.fail_msg("DrawBuffers", "Expected GL_FRAMEBUFFER_COMPLETE.");
                gl.delete_framebuffers(1, &fbo);
                glu::expect_no_error(gl, "deleteFramebuffers")?;
                return Ok(false);
            }

            let dbuffer: glw::GLuint = 0;
            gl.draw_buffers(1, &dbuffer);
            glu::expect_no_error(gl, "drawBuffers")?;
            // Upstream overwrites the first entry of its list with this buffer, which is the one used below.
            draw_buffers[0] = dbuffer;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DrawBuffers", "Failed.");
                success = false;
            }

            gl.draw_buffers(4, draw_buffers.as_ptr());
            glu::expect_no_error(gl, "drawBuffers")?;
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DrawBuffers", "Failed on 4 concurrent buffers.");
                success = false;
            }

            gl.delete_framebuffers(1, &fbo);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
            gl.delete_renderbuffers(4, rbo_color.as_ptr());
            glu::expect_no_error(gl, "deleteRenderbuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallUniformMatrix2x4fv`
    fn uniform_matrix_2x4fv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let v = [1.0f32, 0.0, 0.0, 0.0, 1.0, 0.0];

        // SAFETY: `v` is one 2x3 matrix.
        unsafe {
            let program = self.create_default_program(0)?;

            gl.uniform_matrix_2x_3fv(0, 1, glw::FALSE, v.as_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("UniformMatrix2x4fv", "Failed.");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }
}
