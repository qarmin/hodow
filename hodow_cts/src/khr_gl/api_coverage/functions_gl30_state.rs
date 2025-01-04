// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, first part (`glActiveTexture` to `glGetBooleanv`): state, blending, buffer objects, programs and shaders as objects. A test that loops over an `ea_*` enum list and fails on `GL_INVALID_ENUM` goes through `Coverage::scan_invalid_enum`. The compressed palette formats exist on ES only, so `glCompressedTexImage2D` and `glCompressedTexSubImage2D` have an empty loop here.

use std::ffi::CString;

use super::Coverage;
use crate::generated::khr_api_coverage as data;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_state(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glActiveTexture" => self.active_texture(),
            "glAttachShader" => self.attach_shader(),
            "glBindAttribLocation" => self.bind_attrib_location(),
            "glBindBuffer" => self.bind_buffer(),
            "glBindTexture" => self.bind_texture(),
            "glBlendColor" => self.blend_color(),
            "glBlendEquation" => self.blend_equation(),
            "glBlendEquationSeparate" => self.blend_equation_separate(),
            "glBlendFunc" => self.blend_func(),
            "glBlendFuncSeparate" => self.blend_func_separate(),
            "glBufferData" => self.buffer_data(),
            "glBufferSubData" => self.buffer_sub_data(),
            "glClear" => self.clear(),
            "glClearColor" => self.clear_color(),
            "glClearStencil" => self.clear_stencil(),
            "glColorMask" => self.color_mask(),
            "glCompressedTexImage2D" | "glCompressedTexSubImage2D" => Ok(true),
            "glCopyTexImage2D" => self.copy_tex_image_2d(),
            "glCopyTexSubImage2D" => self.copy_tex_sub_image_2d(),
            "glCreateProgram" | "glDeleteProgram" => self.create_program(),
            "glCreateShader" | "glDeleteShader" => self.create_shader(),
            "glCullFace" => self.cull_face(),
            "glDeleteBuffers" => self.delete_buffers(),
            "glDeleteTextures" => self.delete_textures(),
            "glDetachShader" => self.detach_shader(),
            "glDepthFunc" => self.depth_func(),
            "glDepthMask" => self.depth_mask(),
            "glDisable" => self.disable(),
            "glDisableVertexAttribArray" | "glEnableVertexAttribArray" => self.enable_disable_vertex_attrib_array(),
            "glDrawArrays" => self.draw_arrays(),
            "glDrawElements" => self.draw_elements(),
            "glEnable" => self.enable(),
            "glFinish" => self.finish(),
            "glFlush" => self.flush(),
            "glFrontFace" => self.front_face(),
            "glGetActiveAttrib" => self.get_active_attrib(),
            "glGetActiveUniform" => self.get_active_uniform(),
            "glGetAttachedShaders" => self.get_attached_shaders(),
            "glGetAttribLocation" => self.get_attrib_location(),
            "glGetBooleanv" => self.get_booleanv(),
            _ => return None,
        })
    }

    /// The colour buffer format `TestCoverageGLGuessColorBufferFormat` reports on a desktop context.
    pub(super) fn guess_color_buffer_format(&self) -> Result<glw::GLenum, TestError> {
        let bits = [
            self.read_buffer_bits(glw::GL_RED_BITS)?,
            self.read_buffer_bits(glw::GL_GREEN_BITS)?,
            self.read_buffer_bits(glw::GL_BLUE_BITS)?,
            self.read_buffer_bits(glw::GL_ALPHA_BITS)?,
        ];

        Ok(if bits[3] != 0 {
            glw::GL_RGBA
        } else if bits[2] != 0 {
            glw::GL_RGB
        } else if bits[1] != 0 {
            glw::GL_RG
        } else if bits[0] != 0 {
            glw::GL_RED
        } else {
            glw::GL_NONE
        })
    }

    /// `glcts::getReadbufferBits` for the colour sizes, desktop branch of `getBits`.
    pub(super) fn read_buffer_bits(&self, bits: glw::GLenum) -> Result<glw::GLint, TestError> {
        let gl = self.gl;
        let mut fbo: glw::GLint = 0;
        let mut color_attachment: glw::GLint = 0;
        let mut value: glw::GLint = 0;

        // SAFETY: each query writes one integer.
        unsafe {
            gl.get_integerv(glw::GL_READ_FRAMEBUFFER_BINDING, &mut fbo);
            glu::expect_no_error(gl, "getIntegerv")?;
            gl.get_integerv(glw::GL_READ_BUFFER, &mut color_attachment);
            glu::expect_no_error(gl, "getIntegerv")?;

            let color_attachment = match color_attachment as glw::GLenum {
                glw::GL_BACK => glw::GL_BACK_LEFT,
                glw::GL_FRONT => glw::GL_FRONT_LEFT,
                other => other,
            };
            let size_pname = match bits {
                glw::GL_RED_BITS => glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
                glw::GL_GREEN_BITS => glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
                glw::GL_BLUE_BITS => glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
                _ => glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
            };
            gl.get_framebuffer_attachment_parameteriv(
                glw::GL_READ_FRAMEBUFFER,
                color_attachment,
                size_pname,
                &mut value,
            );
            glu::expect_no_error(gl, "getFramebufferAttachmentParameteriv")?;
        }

        Ok(value)
    }

    /// `TestCoverageGLCalcTargetFormats`, desktop branch.
    pub(super) fn calc_target_formats(color_buffer_format: glw::GLenum) -> Vec<glw::GLenum> {
        match color_buffer_format {
            glw::GL_RED => vec![glw::GL_RED],
            glw::GL_RG => vec![glw::GL_RED, glw::GL_RG],
            glw::GL_RGB => vec![glw::GL_RED, glw::GL_RG, glw::GL_RGB],
            glw::GL_RGBA => vec![glw::GL_RED, glw::GL_RG, glw::GL_RGB, glw::GL_RGBA],
            _ => Vec::new(),
        }
    }

    /// The loop shared by the tests that call one function per enum and fail on `GL_INVALID_ENUM`.
    pub(super) fn scan_invalid_enum(
        &self,
        test: &str,
        values: &[glw::GLenum],
        mut call: impl FnMut(glw::GLenum),
    ) -> bool {
        let mut success = true;
        for &value in values {
            call(value);
            // SAFETY: getError takes no arguments.
            if unsafe { self.gl.get_error() } == glw::GL_INVALID_ENUM {
                self.fail_msg(test, &format!("Invalid enum : 0x{value:x}"));
                success = false;
            }
        }
        success
    }

    /// `TestCoverageGLCallActiveTexture`
    fn active_texture(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut num_units: glw::GLint = 0;

        // SAFETY: one integer out; activeTexture takes a plain enum.
        unsafe {
            gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut num_units);
            glu::expect_no_error(gl, "getIntegerv")?;
            if num_units > 32 {
                num_units = 32;
            }

            for i in 0..num_units {
                gl.active_texture(glw::GL_TEXTURE0 + i as glw::GLenum);
                glu::expect_no_error(gl, "activeTexture")?;
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallActiveTexture", &format!("Invalid enum : GL_TEXTURE{i}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallAttachShader`
    fn attach_shader(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLuint; 2];

        // SAFETY: only object names are passed.
        unsafe {
            let mut i: glw::GLuint = 1;
            while i < 0x7fffffff {
                let is_object = gl.is_program(i) != glw::FALSE || gl.is_shader(i) != glw::FALSE;
                glu::expect_no_error(gl, "isShader")?;
                if !is_object {
                    break;
                }
                i += 1;
            }
            buf[0] = i;

            i += 1;
            while i < 0x7fffffff {
                let is_object = gl.is_program(i) != glw::FALSE || gl.is_shader(i) != glw::FALSE;
                glu::expect_no_error(gl, "isShader")?;
                if !is_object {
                    break;
                }
                i += 1;
            }
            buf[1] = i;

            gl.attach_shader(buf[0], buf[1]);
            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("CallAttachShader", "glAttachShader : did not return GL_INVALID_VALUE");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindAttribLocation`
    fn bind_attrib_location(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut max_attribs: glw::GLint = 0;

        // SAFETY: the attribute names are NUL-terminated.
        unsafe {
            gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_attribs);
            glu::expect_no_error(gl, "getIntegerv")?;

            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            for i in 0..max_attribs {
                let name = CString::new(format!("attrib{i}")).expect("no NUL in the name");
                gl.bind_attrib_location(program, i as glw::GLuint, name.as_ptr());
                if gl.get_error() != glw::GL_NO_ERROR {
                    self.fail_msg(
                        "CallBindAttribLocation",
                        &format!("glBindAttribLocation : failed on attrib {i}"),
                    );
                    success = false;
                }
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBindBuffer`
    fn bind_buffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: binding the zero buffer.
        Ok(
            self.scan_invalid_enum("CallBindBuffer", &data::EA_BUFFER_OBJECT_TARGETS, |target| unsafe {
                gl.bind_buffer(target, 0)
            }),
        )
    }

    /// `TestCoverageGLCallBindTexture`
    fn bind_texture(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: binding the zero texture.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        }
        glu::expect_no_error(gl, "bindTexture")?;
        Ok(true)
    }

    /// `TestCoverageGLCallBlendColor`
    fn blend_color(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.enable(glw::GL_BLEND);
            glu::expect_no_error(gl, "enable")?;
            gl.blend_color(-0.5, 0.2, 2.5, 0.5);
            glu::expect_no_error(gl, "blendColor")?;
        }
        Ok(true)
    }

    /// `TestCoverageGLCallBlendEquation`
    fn blend_equation(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.enable(glw::GL_BLEND);
            glu::expect_no_error(gl, "enable")?;
        }
        Ok(
            self.scan_invalid_enum("CallBlendEquation", &data::EA_BLEND_EQUATION, |mode| unsafe {
                gl.blend_equation(mode)
            }),
        )
    }

    /// `TestCoverageGLCallBlendEquationSeparate`
    fn blend_equation_separate(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain values.
        unsafe {
            gl.enable(glw::GL_BLEND);
            glu::expect_no_error(gl, "enable")?;
            for mode_rgb in data::EA_BLEND_EQUATION_SEPARATE1 {
                for mode_alpha in data::EA_BLEND_EQUATION_SEPARATE2 {
                    gl.blend_equation_separate(mode_rgb, mode_alpha);
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallBlendEquationSeparate",
                            &format!("Invalid enums : (0x{mode_rgb:x}, 0x{mode_alpha:x})"),
                        );
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBlendFunc`
    fn blend_func(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain values.
        unsafe {
            gl.enable(glw::GL_BLEND);
            glu::expect_no_error(gl, "enable")?;
            for sfactor in data::EA_BLEND_FUNC1 {
                for dfactor in data::EA_BLEND_FUNC2 {
                    gl.blend_func(sfactor, dfactor);
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallBlendEquationSeparate",
                            &format!("Invalid enums : (0x{sfactor:x}, 0x{dfactor:x})"),
                        );
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBlendFuncSeparate`
    fn blend_func_separate(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain values.
        unsafe {
            gl.enable(glw::GL_BLEND);
            glu::expect_no_error(gl, "enable")?;
            for src_rgb in data::EA_BLEND_FUNC_SEPARATE1 {
                for dst_rgb in data::EA_BLEND_FUNC_SEPARATE2 {
                    for src_alpha in data::EA_BLEND_FUNC_SEPARATE3 {
                        for dst_alpha in data::EA_BLEND_FUNC_SEPARATE4 {
                            gl.blend_func_separate(src_rgb, dst_rgb, src_alpha, dst_alpha);
                            if gl.get_error() == glw::GL_INVALID_ENUM {
                                self.fail_msg("CallBlendEquationSeparate", &format!("Invalid enums : (0x{src_rgb:x}, 0x{dst_rgb:x}, 0x{src_alpha:x}, 0x{dst_alpha:x})"));
                                success = false;
                            }
                        }
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBufferData`
    fn buffer_data(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf: glw::GLuint = 2;
        let dummy_data = [1.0f32, 2.0, 3.0];

        // SAFETY: the data pointer covers at least the 3 bytes uploaded.
        unsafe {
            gl.gen_buffers(1, &mut buf);
            glu::expect_no_error(gl, "genBuffers")?;
            for target in data::EA_BUFFER_OBJECT_TARGETS {
                for usage in data::EA_BUFFER_OBJECT_USAGES {
                    gl.bind_buffer(target, buf);
                    glu::expect_no_error(gl, "bindBuffer")?;
                    gl.buffer_data(target, 3, dummy_data.as_ptr().cast(), usage);
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallBufferData",
                            &format!("Invalid enums : (0x{target:x}, 0x{usage:x})"),
                        );
                        success = false;
                    }
                }
            }
            gl.delete_buffers(1, &buf);
            glu::expect_no_error(gl, "deleteBuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallBufferSubData`
    fn buffer_sub_data(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf: glw::GLuint = 2;
        let dummy_data = [1.0f32, 2.0, 3.0];

        // SAFETY: the data pointer covers at least the 3 bytes uploaded.
        unsafe {
            gl.gen_buffers(1, &mut buf);
            glu::expect_no_error(gl, "genBuffers")?;
            for target in data::EA_BUFFER_OBJECT_TARGETS {
                for usage in data::EA_BUFFER_OBJECT_USAGES {
                    gl.bind_buffer(target, buf);
                    glu::expect_no_error(gl, "bindBuffer")?;
                    gl.buffer_data(target, 3, dummy_data.as_ptr().cast(), usage);
                    glu::expect_no_error(gl, "bufferData")?;
                    gl.buffer_sub_data(target, 0, 3, dummy_data.as_ptr().cast());
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallBufferData",
                            &format!("Invalid enums : (0x{target:x}, 0x{usage:x})"),
                        );
                        success = false;
                    }
                }
            }
            gl.delete_buffers(1, &buf);
            glu::expect_no_error(gl, "deleteBuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallClear`
    fn clear(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain mask.
        Ok(
            self.scan_invalid_enum("CallClear", &data::EA_CLEAR_BUFFER_MASK, |mask| unsafe {
                gl.clear(mask)
            }),
        )
    }

    /// `TestCoverageGLCallClearColor`
    fn clear_color(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
        }
        glu::expect_no_error(gl, "clearColor")?;
        Ok(true)
    }

    /// `TestCoverageGLCallClearStencil`
    fn clear_stencil(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain value.
        unsafe {
            gl.clear_stencil(0);
        }
        glu::expect_no_error(gl, "clearStencil")?;
        Ok(true)
    }

    /// `TestCoverageGLCallColorMask`
    fn color_mask(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.color_mask(glw::FALSE, glw::FALSE, glw::FALSE, glw::TRUE);
        }
        glu::expect_no_error(gl, "colorMask")?;
        Ok(true)
    }

    /// `TestCoverageGLCallCopyTexImage2D`
    fn copy_tex_image_2d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let color_buffer_format = self.guess_color_buffer_format()?;

        // SAFETY: copies from the read framebuffer into the bound texture.
        unsafe {
            for target_format in Self::calc_target_formats(color_buffer_format) {
                gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, target_format, 0, 0, 1, 1, 0);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallCopyTexImage2D", &format!("Invalid enum : 0x{target_format:x}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallCopyTexSubImage2D`
    fn copy_tex_sub_image_2d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];
        let color_buffer_format = self.guess_color_buffer_format()?;

        // SAFETY: the 1x1 upload reads at most 4 bytes of `buf`.
        unsafe {
            for target_format in Self::calc_target_formats(color_buffer_format) {
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    target_format as glw::GLint,
                    1,
                    1,
                    0,
                    target_format,
                    glw::GL_UNSIGNED_BYTE,
                    buf.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "texImage2D")?;
                gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, 1, 1);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallCopyTexSubImage2D", &format!("Invalid enum : 0x{target_format:x}"));
                    success = false;
                }

                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    target_format as glw::GLint,
                    1,
                    1,
                    0,
                    target_format,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                glu::expect_no_error(gl, "texImage2D")?;
                gl.copy_tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 0, 0, 1, 1);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallCopyTexSubImage2D", &format!("Invalid enum : 0x{target_format:x}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallCreateProgram` (`glDeleteProgram`'s test is the same body)
    fn create_program(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain handles.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }
        Ok(true)
    }

    /// `TestCoverageGLCallCreateShader` (`glDeleteShader`'s test differs only in the message)
    fn create_shader(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain handles.
        unsafe {
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallCreateShader", &format!("Invalid enum : 0x{shader_type:x}"));
                    success = false;
                }
                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallCullFace`
    fn cull_face(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(
            self.scan_invalid_enum("CallCullFace", &data::EA_CULL_FACE_MODE, |mode| unsafe {
                gl.cull_face(mode)
            }),
        )
    }

    /// `TestCoverageGLCallDeleteBuffers`
    fn delete_buffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: the name is only bound and deleted.
        unsafe {
            for target in data::EA_BUFFER_OBJECT_TARGETS {
                let buf = [2 as glw::GLuint];
                gl.bind_buffer(target, buf[0]);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallDeleteBuffers", &format!("Invalid enum : 0x{target:x}"));
                    success = false;
                }
                gl.delete_buffers(1, buf.as_ptr());
                glu::expect_no_error(gl, "deleteBuffers")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDeleteTextures`
    fn delete_textures(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [2 as glw::GLuint];

        // SAFETY: the name is only bound and deleted.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, buf[0]);
            if gl.get_error() == glw::GL_INVALID_ENUM {
                self.fail_msg("CallDeleteBuffers", "Invalid enum : GL_TEXTURE_2D");
                success = false;
            }
            gl.delete_textures(1, buf.as_ptr());
            glu::expect_no_error(gl, "deleteTextures")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDetachShader`
    fn detach_shader(&self) -> Result<bool, TestError> {
        let gl = self.gl;

        // SAFETY: plain handles.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                glu::expect_no_error(gl, "createShader")?;
                gl.attach_shader(program, shader);
                glu::expect_no_error(gl, "attachShader")?;
                gl.detach_shader(program, shader);
                glu::expect_no_error(gl, "detachShader")?;
                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallDepthFunc`
    fn depth_func(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(
            self.scan_invalid_enum("CallDepthFunc", &data::EA_DEPTH_FUNCTION, |func| unsafe {
                gl.depth_func(func)
            }),
        )
    }

    /// `TestCoverageGLCallDepthMask`
    fn depth_mask(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain value.
        unsafe {
            gl.depth_mask(glw::FALSE);
        }
        glu::expect_no_error(gl, "depthMask")?;
        Ok(true)
    }

    /// `TestCoverageGLCallDisable`
    fn disable(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(self.scan_invalid_enum("CallDisable", &data::EA_ENABLE, |cap| unsafe { gl.disable(cap) }))
    }

    /// `TestCoverageGLCallDisableVertexAttribArray` (`glEnableVertexAttribArray`'s test is the same body)
    fn enable_disable_vertex_attrib_array(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: attribute 0 exists on every context.
        unsafe {
            gl.enable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "enableVertexAttribArray")?;
            gl.disable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "disableVertexAttribArray")?;
        }
        Ok(true)
    }

    /// `TestCoverageGLCallDrawArrays`
    fn draw_arrays(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: mirrors upstream, which draws one vertex from whatever is bound.
        Ok(
            self.scan_invalid_enum("CallDrawArrays", &data::EA_PRIMITIVES, |mode| unsafe {
                gl.draw_arrays(mode, 0, 1)
            }),
        )
    }

    /// `TestCoverageGLCallDrawElements`
    fn draw_elements(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: the client-side index arrays live across the calls.
        unsafe {
            for mode in data::EA_PRIMITIVES {
                let indices_byte = [0u8];
                gl.draw_elements(mode, 1, glw::GL_UNSIGNED_BYTE, indices_byte.as_ptr().cast());
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallDrawElements", &format!("Invalid enum : 0x{mode:x}"));
                    success = false;
                }

                let indices_short = [0u16];
                gl.draw_elements(mode, 1, glw::GL_UNSIGNED_SHORT, indices_short.as_ptr().cast());
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallDrawElements", &format!("Invalid enum : 0x{mode:x}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallEnable`
    fn enable(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(self.scan_invalid_enum("CallEnable", &data::EA_ENABLE, |cap| unsafe { gl.enable(cap) }))
    }

    /// `TestCoverageGLCallFinish`
    fn finish(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: no arguments.
        unsafe {
            gl.finish();
        }
        glu::expect_no_error(gl, "finish")?;
        Ok(true)
    }

    /// `TestCoverageGLCallFlush`
    fn flush(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: no arguments.
        unsafe {
            gl.flush();
        }
        glu::expect_no_error(gl, "flush")?;
        Ok(true)
    }

    /// `TestCoverageGLCallFrontFace`
    fn front_face(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(
            self.scan_invalid_enum("CallFrontFace", &data::EA_FRONT_FACE_DIRECTION, |mode| unsafe {
                gl.front_face(mode)
            }),
        )
    }

    /// `TestCoverageGLCallGetActiveAttrib`
    fn get_active_attrib(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut length: glw::GLsizei = 0;
        let mut size: glw::GLint = 0;
        let mut type_: glw::GLenum = 0;
        let mut name = [0 as glw::GLchar; 256];

        // SAFETY: `name` has the 256 characters the call is told about.
        unsafe {
            gl.get_active_attrib(0, 0, 256, &mut length, &mut size, &mut type_, name.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("CallGetActiveAttrib", "Unexpected getActiveAttrib result");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetActiveUniform`
    fn get_active_uniform(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut length: glw::GLsizei = 0;
        let mut size: glw::GLint = 0;
        let mut type_: glw::GLenum = 0;
        let mut name = [0 as glw::GLchar; 256];

        // SAFETY: `name` has the 256 characters the call is told about.
        unsafe {
            gl.get_active_uniform(0, 0, 256, &mut length, &mut size, &mut type_, name.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("CallGetActiveUniform", "Unexpected getActiveUniform result");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetAttachedShaders`
    fn get_attached_shaders(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut count: glw::GLsizei = 0;
        let mut shaders = [0 as glw::GLuint; 10];

        // SAFETY: `shaders` has the 10 slots the call is told about.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            gl.get_attached_shaders(program, 10, &mut count, shaders.as_mut_ptr());
            glu::expect_no_error(gl, "getAttachedShaders")?;
            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallGetAttribLocation`
    fn get_attrib_location(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: the name is NUL-terminated.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_attrib_location(program, c"attrib".as_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CallGetAttribLocation", "GL_INVALID_OPERATION not returned.");
                success = false;
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetBooleanv`
    fn get_booleanv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLboolean; 10];
        let buf_ptr = buf.as_mut_ptr();
        // SAFETY: no listed state returns more than the 10 booleans of `buf`.
        Ok(
            self.scan_invalid_enum("CallGetBooleanv", &data::EA_GET_BOOLEAN, |pname| unsafe {
                gl.get_booleanv(pname, buf_ptr)
            }),
        )
    }
}
