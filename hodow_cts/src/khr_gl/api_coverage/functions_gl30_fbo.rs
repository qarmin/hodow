// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, fourth part (`glIsRenderbuffer` to `glGenerateMipmap`): renderbuffers and framebuffers. The 4.5 branches of `glBindRenderbuffer` and the ES-only ones are unreachable on the 3.0 context this file is used for and are left out. `glIsRenderbuffer` is called through the global entry point upstream.

use super::Coverage;
use crate::generated::khr_api_coverage as data;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_fbo(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glIsRenderbuffer" => self.is_renderbuffer(),
            "glBindRenderbuffer" => self.bind_renderbuffer(),
            "glDeleteRenderbuffers" => self.delete_renderbuffers(),
            "glGenRenderbuffers" => self.gen_renderbuffers(),
            "glRenderbufferStorage" => self.renderbuffer_storage(),
            "glGetRenderbufferParameteriv" => self.get_renderbuffer_parameteriv(),
            "glIsFramebuffer" => self.is_framebuffer(),
            "glBindFramebuffer" => self.bind_framebuffer(),
            "glDeleteFramebuffers" => self.delete_framebuffers(),
            "glGenFramebuffers" => self.gen_framebuffers(),
            "glCheckFramebufferStatus" => self.check_framebuffer_status(),
            "glFramebufferTexture2D" => self.framebuffer_texture_2d(),
            "glFramebufferRenderbuffer" => self.framebuffer_renderbuffer(),
            "glGetFramebufferAttachmentParameteriv" => self.get_framebuffer_attachment_parameteriv(),
            "glGenerateMipmap" => self.generate_mipmap(),
            _ => return None,
        })
    }

    /// The attachments the framebuffer tests visit: `maxColorAttachments` is 1 upstream, so a colour attachment beyond the first is skipped.
    fn visited_attachments() -> impl Iterator<Item = glw::GLenum> {
        const MAX_COLOR_ATTACHMENTS: i64 = 1;
        data::EA_FRAME_BUFFER_ATTACHMENTS.into_iter().filter(|&attachment| {
            let skipped = attachment as i64 - data::EA_FRAME_BUFFER_ATTACHMENTS[0] as i64 >= MAX_COLOR_ATTACHMENTS
                && attachment != glw::GL_DEPTH_ATTACHMENT
                && attachment != glw::GL_STENCIL_ATTACHMENT;
            !skipped
        })
    }

    /// `TestCoverageGLCallIsRenderbuffer`
    fn is_renderbuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain name.
        unsafe {
            gl.is_renderbuffer(0);
        }
        glu::expect_no_error(gl, "isRenderbuffer")?;
        Ok(true)
    }

    /// `TestCoverageGLCallBindRenderbuffer`
    fn bind_renderbuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: binding the zero renderbuffer.
        Ok(self.scan_invalid_enum(
            "CallBindRenderBuffer",
            &data::EA_RENDER_BUFFER_TARGETS,
            |target| unsafe { gl.bind_renderbuffer(target, 0) },
        ))
    }

    /// `TestCoverageGLCallDeleteRenderbuffers`
    fn delete_renderbuffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [2 as glw::GLuint];

        // SAFETY: the name is only bound and deleted.
        unsafe {
            while gl.is_renderbuffer(buf[0]) != glw::FALSE {
                buf[0] += 1;
            }

            for target in data::EA_RENDER_BUFFER_TARGETS {
                gl.bind_renderbuffer(target, buf[0]);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallDeleteRenderBuffer", &format!("Invalid enum : 0x{target:x}"));
                    success = false;
                }
                gl.delete_renderbuffers(1, buf.as_ptr());
                glu::expect_no_error(gl, "deleteRenderbuffers")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenRenderbuffers`
    fn gen_renderbuffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLuint; 2];

        // SAFETY: `buf` holds the two names generated and deleted.
        unsafe {
            gl.gen_renderbuffers(2, buf.as_mut_ptr());
            glu::expect_no_error(gl, "genRenderbuffers")?;
            gl.delete_renderbuffers(2, buf.as_ptr());
            glu::expect_no_error(gl, "deleteRenderbuffers")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallRenderbufferStorage`
    fn renderbuffer_storage(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut r: glw::GLuint = 0;
        let mut f: glw::GLuint = 0;

        // SAFETY: names are generated before use and deleted after.
        unsafe {
            gl.gen_renderbuffers(1, &mut r);
            glu::expect_no_error(gl, "genRenderbuffers")?;
            gl.gen_framebuffers(1, &mut f);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, r);
            glu::expect_no_error(gl, "bindRenderbuffer")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, f);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            for target in data::EA_RENDER_BUFFER_TARGETS {
                for format in data::EA_RENDER_BUFFER_FORMATS {
                    gl.renderbuffer_storage(target, format, 1, 1);
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallBindRenderBuffer",
                            &format!("Invalid enums : (0x{target:x}, 0x{format:x})"),
                        );
                        success = false;
                    }
                }
            }

            gl.delete_renderbuffers(1, &r);
            glu::expect_no_error(gl, "deleteRenderbuffers")?;
            gl.delete_framebuffers(1, &f);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetRenderbufferParameteriv`
    fn get_renderbuffer_parameteriv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLint; 10];

        // SAFETY: `buf` is larger than any renderbuffer parameter.
        unsafe {
            for target in data::EA_RENDER_BUFFER_TARGETS {
                for pname in data::EA_GET_RENDER_BUFFER_PARAMETER {
                    gl.get_renderbuffer_parameteriv(target, pname, buf.as_mut_ptr());
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallBindRenderBuffer",
                            &format!("Invalid enums : (0x{target:x}, 0x{pname:x})"),
                        );
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsFramebuffer`
    fn is_framebuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain name.
        unsafe {
            gl.is_framebuffer(0);
        }
        glu::expect_no_error(gl, "isFramebuffer")?;
        Ok(true)
    }

    /// `TestCoverageGLCallBindFramebuffer`
    fn bind_framebuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: binding the default framebuffer.
        Ok(
            self.scan_invalid_enum("CallBindFrameBuffer", &data::EA_FRAME_BUFFER_TARGETS, |target| unsafe {
                gl.bind_framebuffer(target, 0)
            }),
        )
    }

    /// `TestCoverageGLCallDeleteFramebuffers`
    fn delete_framebuffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [2 as glw::GLuint];

        // SAFETY: the name is only bound and deleted.
        unsafe {
            for target in data::EA_FRAME_BUFFER_TARGETS {
                gl.bind_framebuffer(target, buf[0]);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallDeleteFrameBuffer", &format!("Invalid enum : 0x{target:x}"));
                    success = false;
                }
                gl.delete_framebuffers(1, buf.as_ptr());
                glu::expect_no_error(gl, "deleteFramebuffers")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenFramebuffers`
    fn gen_framebuffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLuint; 2];

        // SAFETY: `buf` holds the two names generated and deleted.
        unsafe {
            gl.gen_framebuffers(2, buf.as_mut_ptr());
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.delete_framebuffers(2, buf.as_ptr());
            glu::expect_no_error(gl, "deleteFramebuffers")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallCheckFramebufferStatus`
    fn check_framebuffer_status(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(self.scan_invalid_enum(
            "CallCheckFrameBufferStatus",
            &data::EA_FRAME_BUFFER_TARGETS,
            |target| unsafe {
                gl.check_framebuffer_status(target);
            },
        ))
    }

    /// `TestCoverageGLCallFramebufferTexture2D`
    fn framebuffer_texture_2d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut fb: glw::GLuint = 0;

        // SAFETY: plain handles; a framebuffer object must be bound.
        unsafe {
            gl.gen_framebuffers(1, &mut fb);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fb);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            for target in data::EA_FRAME_BUFFER_TARGETS {
                for attachment in Self::visited_attachments() {
                    gl.framebuffer_texture_2d(target, attachment, glw::GL_TEXTURE_2D, 0, 0);
                    let error = gl.get_error();
                    if error == glw::GL_INVALID_OPERATION {
                        self.fail_msg(
                            "CallFramebufferTexture2D",
                            &format!("Invalid operation : (0x{target:x}, 0x{attachment:x})"),
                        );
                        success = false;
                    }
                    if error == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallFramebufferTexture2D",
                            &format!("Invalid enum : (0x{target:x}, 0x{attachment:x})"),
                        );
                        success = false;
                    }
                }
            }

            gl.delete_framebuffers(1, &fb);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallFramebufferRenderbuffer`
    fn framebuffer_renderbuffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut fb: glw::GLuint = 0;

        // SAFETY: plain handles; a framebuffer object must be bound.
        unsafe {
            gl.gen_framebuffers(1, &mut fb);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fb);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            for target in data::EA_FRAME_BUFFER_TARGETS {
                for renderbuffer_target in data::EA_RENDER_BUFFER_TARGETS {
                    for attachment in Self::visited_attachments() {
                        gl.framebuffer_renderbuffer(target, attachment, renderbuffer_target, 0);
                        if gl.get_error() == glw::GL_INVALID_ENUM {
                            self.fail_msg(
                                "CallFramebufferRenderbuffer3DOES",
                                &format!("Invalid enum : (0x{target:x}, 0x{renderbuffer_target:x}, 0x{attachment:x})"),
                            );
                            success = false;
                        }
                    }
                }
            }

            gl.delete_framebuffers(1, &fb);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetFramebufferAttachmentParameteriv`
    fn get_framebuffer_attachment_parameteriv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLint; 10];
        let mut tex: glw::GLuint = 0;
        let mut fb: glw::GLuint = 0;

        // SAFETY: `buf` is larger than any attachment parameter; names are generated before use and deleted after.
        unsafe {
            gl.gen_textures(1, &mut tex);
            glu::expect_no_error(gl, "genTextures")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, tex);
            glu::expect_no_error(gl, "bindTexture")?;
            gl.gen_framebuffers(1, &mut fb);
            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fb);
            glu::expect_no_error(gl, "bindFramebuffer")?;

            for target in data::EA_FRAME_BUFFER_TARGETS {
                for attachment in Self::visited_attachments() {
                    gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, tex, 0);
                    glu::expect_no_error(gl, "framebufferTexture2D")?;

                    for pname in data::EA_GET_FRAMEBUFFER_ATTACHMENT_PARAMETER {
                        gl.get_framebuffer_attachment_parameteriv(target, attachment, pname, buf.as_mut_ptr());
                        let error = gl.get_error();
                        if error == glw::GL_INVALID_OPERATION {
                            self.fail_msg(
                                "CallGetFramebufferAttachmentParameteriv",
                                &format!("Invalid operation : (0x{target:x}, 0x{attachment:x}, 0x{pname:x})"),
                            );
                            success = false;
                        }
                        if error == glw::GL_INVALID_ENUM {
                            self.fail_msg(
                                "CallGetFramebufferAttachmentParameteriv",
                                &format!("Invalid enum : (0x{target:x}, 0x{attachment:x}, 0x{pname:x})"),
                            );
                            success = false;
                        }
                    }

                    gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, 0, 0);
                    glu::expect_no_error(gl, "framebufferTexture2D")?;
                }
            }

            gl.delete_framebuffers(1, &fb);
            glu::expect_no_error(gl, "deleteFramebuffers")?;
            gl.delete_textures(1, &tex);
            glu::expect_no_error(gl, "deleteTextures")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenerateMipmap`
    fn generate_mipmap(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut tex: glw::GLuint = 0;
        let buf = [0u8; 16];

        // SAFETY: the 2x2 RGBA8 upload reads the 16 bytes of `buf`.
        unsafe {
            gl.gen_textures(1, &mut tex);
            glu::expect_no_error(gl, "genTextures")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, tex);
            glu::expect_no_error(gl, "bindTexture")?;
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA as glw::GLint,
                2,
                2,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                buf.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "texImage2D")?;

            gl.generate_mipmap(glw::GL_TEXTURE_2D);
            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                self.fail_msg("CallGenerateMipmap", &format!("Error generated {error:x}"));
                success = false;
            }

            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            glu::expect_no_error(gl, "bindTexture")?;
            gl.delete_textures(1, &tex);
            glu::expect_no_error(gl, "deleteTextures")?;
        }

        Ok(success)
    }
}
