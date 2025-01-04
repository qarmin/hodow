// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, second part (`glGetBufferParameteriv` to `glTexSubImage2D`): state queries, stencil, pixel store and texture images and parameters. The four `glTexParameter*` tests share one loop (`scan_tex_parameters`); the OES extension branches of upstream are empty lists on desktop and are left out.

use super::Coverage;
use crate::generated::khr_api_coverage as data;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_params(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glGetBufferParameteriv" => self.get_buffer_parameteriv(),
            "glGenBuffers" => self.gen_buffers(),
            "glGenTextures" => self.gen_textures(),
            "glGetFloatv" => self.get_floatv(),
            "glGetIntegerv" => self.get_integerv(),
            "glGetProgramiv" => self.get_programiv(),
            "glGetProgramInfoLog" => self.get_program_info_log(),
            "glGetString" => self.get_string(),
            "glGetTexParameteriv" => self.get_tex_parameteriv(),
            "glGetTexParameterfv" => self.get_tex_parameterfv(),
            "glGetUniformfv" => self.get_uniformfv(),
            "glGetUniformiv" => self.get_uniformiv(),
            "glGetUniformLocation" => self.get_uniform_location(),
            "glGetVertexAttribfv" => self.get_vertex_attribfv(),
            "glGetVertexAttribiv" => self.get_vertex_attribiv(),
            "glGetVertexAttribPointerv" => self.get_vertex_attrib_pointerv(),
            "glHint" => self.hint(),
            "glIsBuffer" => self.is_buffer(),
            "glIsEnabled" => self.is_enabled(),
            "glIsProgram" => self.is_program(),
            "glIsShader" => self.is_shader(),
            "glIsTexture" => self.is_texture(),
            "glLineWidth" => self.line_width(),
            "glLinkProgram" => self.link_program(),
            "glPixelStorei" => self.pixel_storei(),
            "glPolygonOffset" => self.polygon_offset(),
            "glReadPixels" => self.read_pixels(),
            "glSampleCoverage" => self.sample_coverage(),
            "glScissor" => self.scissor(),
            "glStencilFunc" => self.stencil_func(),
            "glStencilFuncSeparate" => self.stencil_func_separate(),
            "glStencilMask" => self.stencil_mask(),
            "glStencilMaskSeparate" => self.stencil_mask_separate(),
            "glStencilOp" => self.stencil_op(),
            "glStencilOpSeparate" => self.stencil_op_separate(),
            "glTexImage2D" => self.tex_image_2d(),
            "glTexParameteri" => self.scan_tex_parameters("CallTexParameteri", |target, pname, value| unsafe {
                self.gl.tex_parameteri(target, pname, value as glw::GLint)
            }),
            "glTexParameterf" => self.scan_tex_parameters("CallTexParameterf", |target, pname, value| unsafe {
                self.gl.tex_parameterf(target, pname, value as glw::GLfloat)
            }),
            "glTexParameteriv" => self.scan_tex_parameters("CallTexParameteriv", |target, pname, value| unsafe {
                let param = value as glw::GLint;
                self.gl.tex_parameteriv(target, pname, &param)
            }),
            "glTexParameterfv" => self.scan_tex_parameters("CallTexParameterfv", |target, pname, value| unsafe {
                let param = value as glw::GLfloat;
                self.gl.tex_parameterfv(target, pname, &param)
            }),
            "glTexSubImage2D" => self.tex_sub_image_2d(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallGetBufferParameteriv`
    fn get_buffer_parameteriv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLint; 10];

        // SAFETY: `buf` is larger than any buffer parameter.
        unsafe {
            for target in data::EA_BUFFER_OBJECT_TARGETS {
                let mut buffer: glw::GLuint = 0;
                gl.gen_buffers(1, &mut buffer);
                glu::expect_no_error(gl, "glGenBuffers")?;
                gl.bind_buffer(target, buffer);
                glu::expect_no_error(gl, "bindBuffer")?;

                for pname in data::EA_GET_BUFFER_PARAMETER {
                    gl.get_buffer_parameteriv(target, pname, buf.as_mut_ptr());
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallGetBufferParameteriv",
                            &format!("Invalid enums : (0x{target:x}, 0x{pname:x})"),
                        );
                        success = false;
                    }
                }

                gl.delete_buffers(1, &buffer);
                glu::expect_no_error(gl, "deleteBuffers")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGenBuffers`
    fn gen_buffers(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buffers = [0 as glw::GLuint; 10];

        // SAFETY: `buffers` holds the ten names generated and deleted.
        unsafe {
            gl.gen_buffers(10, buffers.as_mut_ptr());
            glu::expect_no_error(gl, "genBuffers")?;
            gl.delete_buffers(10, buffers.as_ptr());
            glu::expect_no_error(gl, "deleteBuffers")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallGenTextures`
    fn gen_textures(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buffers = [0 as glw::GLuint; 10];

        // SAFETY: `buffers` holds the ten names generated and deleted.
        unsafe {
            gl.gen_textures(10, buffers.as_mut_ptr());
            glu::expect_no_error(gl, "genTextures")?;
            gl.delete_textures(10, buffers.as_ptr());
            glu::expect_no_error(gl, "deleteTextures")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallGetFloatv`
    fn get_floatv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0.0f32; 10];
        let buf_ptr = buf.as_mut_ptr();
        // SAFETY: no listed state returns more than the 10 floats of `buf`.
        Ok(
            self.scan_invalid_enum("CallGetFloatv", &data::EA_GET_FLOAT, |pname| unsafe {
                gl.get_floatv(pname, buf_ptr)
            }),
        )
    }

    /// `TestCoverageGLCallGetIntegerv`
    fn get_integerv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLint; 256];
        let buf_ptr = buf.as_mut_ptr();

        // SAFETY: 256 integers is what upstream assumes to be enough for GL_COMPRESSED_TEXTURE_FORMATS.
        let success = self.scan_invalid_enum("CallGetIntegerv", &data::EA_GET_INTEGER, |pname| unsafe {
            gl.get_integerv(pname, buf_ptr)
        });

        // The ES 3 and OES lists of upstream are empty on desktop; only the version query is left.
        // SAFETY: a null result is checked for in `string_from`.
        let _ = unsafe { glw::string_from(gl.get_string(glw::GL_VERSION)) };
        glu::expect_no_error(gl, "getString")?;

        Ok(success)
    }

    /// `TestCoverageGLCallGetProgramiv`
    fn get_programiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLint; 10];
        let buf_ptr = buf.as_mut_ptr();

        // SAFETY: `buf` is larger than any program parameter.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            let success = self.scan_invalid_enum("CallGetProgramiv", &data::EA_GET_PROGRAM, |pname| {
                gl.get_programiv(program, pname, buf_ptr)
            });

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;

            Ok(success)
        }
    }

    /// `TestCoverageGLCallGetProgramInfoLog`
    fn get_program_info_log(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut infolog = [0 as glw::GLchar; 1024];
        let mut length: glw::GLsizei = 0;

        // SAFETY: `infolog` has the 1024 characters the call is told about.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            gl.get_program_info_log(program, 1024, &mut length, infolog.as_mut_ptr());
            glu::expect_no_error(gl, "getProgramInfoLog")?;
            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(true)
    }

    /// `TestCoverageGLCallGetString`
    fn get_string(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: the returned pointer is not read.
        Ok(
            self.scan_invalid_enum("CallGetString", &data::EA_GET_STRING, |name| unsafe {
                let _ = gl.get_string(name);
            }),
        )
    }

    /// `TestCoverageGLCallGetTexParameteriv`
    fn get_tex_parameteriv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLint; 10];
        let buf_ptr = buf.as_mut_ptr();
        // SAFETY: `buf` is larger than any texture parameter.
        Ok(
            self.scan_invalid_enum("CallGetTexParameteriv", &data::EA_GET_TEX_PARAMETER, |pname| unsafe {
                gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, pname, buf_ptr)
            }),
        )
    }

    /// `TestCoverageGLCallGetTexParameterfv`
    fn get_tex_parameterfv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0.0f32; 10];
        let buf_ptr = buf.as_mut_ptr();
        // SAFETY: `buf` is larger than any texture parameter.
        Ok(
            self.scan_invalid_enum("CallGetTexParameterfv", &data::EA_GET_TEX_PARAMETER, |pname| unsafe {
                gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, pname, buf_ptr)
            }),
        )
    }

    /// `TestCoverageGLCallGetUniformfv`
    fn get_uniformfv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0.0f32; 10];

        // SAFETY: the program is unlinked, so the call fails before writing.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_uniformfv(program, 0, buf.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CallGetUniformfv", "GL_INVALID_OPERATION not returned.");
                success = false;
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetUniformiv`
    fn get_uniformiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLint; 10];

        // SAFETY: the program is unlinked, so the call fails before writing.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_uniformiv(program, 0, buf.as_mut_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CallGetUniformiv", "GL_INVALID_OPERATION not returned.");
                success = false;
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetUniformLocation`
    fn get_uniform_location(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: the name is NUL-terminated.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;

            gl.get_uniform_location(program, c"uniform1".as_ptr());
            if gl.get_error() != glw::GL_INVALID_OPERATION {
                self.fail_msg("CallGetUniformLocation", "GL_INVALID_OPERATION not returned.");
                success = false;
            }

            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;

            while gl.get_error() != glw::GL_NO_ERROR {}
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetVertexAttribfv`
    fn get_vertex_attribfv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0.0f32; 10];
        let buf_ptr = buf.as_mut_ptr();
        // SAFETY: `buf` is larger than any vertex attribute parameter.
        Ok(
            self.scan_invalid_enum("CallGetVertexAttribfv", &data::EA_GET_VERTEX_ATTRIB, |pname| unsafe {
                gl.get_vertex_attribfv(1, pname, buf_ptr)
            }),
        )
    }

    /// `TestCoverageGLCallGetVertexAttribiv`
    fn get_vertex_attribiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf = [0 as glw::GLint; 10];
        let buf_ptr = buf.as_mut_ptr();
        // SAFETY: `buf` is larger than any vertex attribute parameter.
        Ok(
            self.scan_invalid_enum("CallGetVertexAttribiv", &data::EA_GET_VERTEX_ATTRIB, |pname| unsafe {
                gl.get_vertex_attribiv(1, pname, buf_ptr)
            }),
        )
    }

    /// `TestCoverageGLCallGetVertexAttribPointerv`
    fn get_vertex_attrib_pointerv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut buf: *mut std::ffi::c_void = std::ptr::null_mut();
        let buf_ptr: *mut *mut std::ffi::c_void = &mut buf;
        // SAFETY: one pointer out.
        Ok(self.scan_invalid_enum(
            "CallGetVertexAttribPointerv",
            &data::EA_GET_VERTEX_ATTRIB_POINTER,
            |pname| unsafe { gl.get_vertex_attrib_pointerv(1, pname, buf_ptr) },
        ))
    }

    /// `TestCoverageGLCallHint`
    fn hint(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain enums.
        unsafe {
            for target in data::EA_HINT_TARGET {
                for mode in data::EA_HINT_MODE {
                    gl.hint(target, mode);
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg("CallHint", &format!("Invalid enums : (0x{target:x}, 0x{mode:x})"));
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsBuffer`
    fn is_buffer(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain name.
        unsafe {
            gl.is_buffer(0);
        }
        glu::expect_no_error(gl, "isBuffer")?;
        Ok(true)
    }

    /// `TestCoverageGLCallIsEnabled`
    fn is_enabled(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain enum.
        Ok(self.scan_invalid_enum("CallIsEnabled", &data::EA_ENABLE, |cap| unsafe {
            gl.is_enabled(cap);
        }))
    }

    /// `TestCoverageGLCallIsProgram`
    fn is_program(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain name.
        unsafe {
            gl.is_program(0);
        }
        glu::expect_no_error(gl, "isProgram")?;
        Ok(true)
    }

    /// `TestCoverageGLCallIsShader`
    fn is_shader(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain name.
        unsafe {
            gl.is_shader(0);
        }
        glu::expect_no_error(gl, "isShader")?;
        Ok(true)
    }

    /// `TestCoverageGLCallIsTexture`
    fn is_texture(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain name.
        unsafe {
            gl.is_texture(0);
        }
        glu::expect_no_error(gl, "isTexture")?;
        Ok(true)
    }

    /// `TestCoverageGLCallLineWidth`
    fn line_width(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain value.
        unsafe {
            gl.line_width(1.0);
        }
        glu::expect_no_error(gl, "lineWidth")?;
        Ok(true)
    }

    /// `TestCoverageGLCallLinkProgram`
    fn link_program(&self) -> Result<bool, TestError> {
        let gl = self.gl;

        // SAFETY: plain handles.
        unsafe {
            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            gl.link_program(program);
            glu::expect_no_error(gl, "linkProgram")?;
            gl.use_program(0);
            glu::expect_no_error(gl, "useProgram")?;
            gl.delete_program(program);
            glu::expect_no_error(gl, "deleteProgram")?;

            while gl.get_error() != glw::GL_NO_ERROR {}
        }

        Ok(true)
    }

    /// `TestCoverageGLCallPixelStorei`
    fn pixel_storei(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain values.
        unsafe {
            for pname in data::EA_PIXEL_STORE {
                for param in [1, 2, 4] {
                    gl.pixel_storei(pname, param);
                    glu::expect_no_error(gl, "pixelStorei")?;
                }
                gl.pixel_storei(pname, 8);
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg("CallPixelStorei", &format!("Invalid enum : 0x{pname:x}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallPolygonOffset`
    fn polygon_offset(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.polygon_offset(1.0, 0.0);
        }
        glu::expect_no_error(gl, "polygonOffset")?;
        Ok(true)
    }

    /// `TestCoverageGLCallReadPixels` (the `m_is_context_ES` half reads the implementation format and is not reached on desktop)
    fn read_pixels(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut read_buf = [0u8; 64];

        // SAFETY: a 1x1 RGBA8 read needs 4 bytes.
        unsafe {
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                read_buf.as_mut_ptr().cast(),
            );
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("CallReadPixels", "Error occured during read pixel call");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallSampleCoverage`
    fn sample_coverage(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.sample_coverage(1.0, glw::FALSE);
        }
        glu::expect_no_error(gl, "sampleCoverage")?;
        Ok(true)
    }

    /// `TestCoverageGLCallScissor`
    fn scissor(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        unsafe {
            gl.scissor(0, 0, 1, 1);
        }
        glu::expect_no_error(gl, "scissor")?;
        Ok(true)
    }

    /// `TestCoverageGLCallStencilFunc`
    fn stencil_func(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        Ok(
            self.scan_invalid_enum("CallStencilFunc", &data::EA_STENCIL_FUNCTION, |func| unsafe {
                gl.stencil_func(func, 0, 0)
            }),
        )
    }

    /// `TestCoverageGLCallStencilFuncSeparate`
    fn stencil_func_separate(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain values.
        unsafe {
            for face in data::EA_FACE {
                for func in data::EA_STENCIL_FUNCTION {
                    gl.stencil_func_separate(face, func, 0, 0);
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg("CallStencilFunc", &format!("Invalid enums : (0x{face:x}, 0x{func:x})"));
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallStencilMask`
    fn stencil_mask(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain value.
        unsafe {
            gl.stencil_mask(0);
        }
        glu::expect_no_error(gl, "stencilMask")?;
        Ok(true)
    }

    /// `TestCoverageGLCallStencilMaskSeparate`
    fn stencil_mask_separate(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        // SAFETY: plain values.
        Ok(
            self.scan_invalid_enum("CallStencilFunc", &data::EA_FACE, |face| unsafe {
                gl.stencil_mask_separate(face, 0)
            }),
        )
    }

    /// `TestCoverageGLCallStencilOp`
    fn stencil_op(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain enums.
        unsafe {
            for sfail in data::EA_STENCIL_OP {
                for dpfail in data::EA_STENCIL_OP {
                    for dppass in data::EA_STENCIL_OP {
                        gl.stencil_op(sfail, dpfail, dppass);
                        if gl.get_error() == glw::GL_INVALID_ENUM {
                            self.fail_msg(
                                "CallStencilFunc",
                                &format!("Invalid enums : (0x{sfail:x}, 0x{dpfail:x}, 0x{dppass:x})"),
                            );
                            success = false;
                        }
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallStencilOpSeparate`
    fn stencil_op_separate(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain enums.
        unsafe {
            for face in data::EA_FACE {
                for sfail in data::EA_STENCIL_OP {
                    for dpfail in data::EA_STENCIL_OP {
                        for dppass in data::EA_STENCIL_OP {
                            gl.stencil_op_separate(face, sfail, dpfail, dppass);
                            if gl.get_error() == glw::GL_INVALID_ENUM {
                                self.fail_msg(
                                    "CallStencilFunc",
                                    &format!("Invalid enums : (0x{face:x}, 0x{sfail:x}, 0x{dpfail:x}, 0x{dppass:x})"),
                                );
                                success = false;
                            }
                        }
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallTexImage2D`
    fn tex_image_2d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];

        // SAFETY: a 1x1 upload reads at most 16 bytes of `buf`.
        unsafe {
            for target in data::EA_TEXTURE_TARGET {
                for (j, format) in data::EA_TEXTURE_FORMAT.into_iter().enumerate() {
                    let type_ = data::EA_TEXTURE_TYPE[j];

                    gl.tex_image_2d(
                        target,
                        0,
                        format as glw::GLint,
                        1,
                        1,
                        0,
                        format,
                        type_,
                        buf.as_ptr().cast(),
                    );
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallTexImage2D",
                            &format!("Invalid enums : (0x{target:x}, 0x{format:x}, 0x{type_:x})"),
                        );
                        success = false;
                    }

                    gl.tex_image_2d(
                        target,
                        0,
                        format as glw::GLint,
                        1,
                        1,
                        0,
                        format,
                        type_,
                        std::ptr::null(),
                    );
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallTexImage2D",
                            &format!("Invalid enums : (0x{target:x}, 0x{format:x}, 0x{type_:x})"),
                        );
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// The loop of `TestCoverageGLCallTexParameter{i,f,iv,fv}`: every texture parameter with the values that suit it.
    fn scan_tex_parameters(
        &self,
        test: &str,
        mut call: impl FnMut(glw::GLenum, glw::GLenum, glw::GLenum),
    ) -> Result<bool, TestError> {
        let mut success = true;

        for target in data::EA_TEXTURE_TARGET {
            for pname in data::EA_GET_TEX_PARAMETER {
                let values: &[glw::GLenum] = match pname {
                    glw::GL_TEXTURE_WRAP_S | glw::GL_TEXTURE_WRAP_T => &data::EA_TEXTURE_WRAP_MODE,
                    glw::GL_TEXTURE_MIN_FILTER => &data::EA_TEXTURE_MIN_FILTER,
                    glw::GL_TEXTURE_MAG_FILTER => &data::EA_TEXTURE_MAG_FILTER,
                    _ => &[],
                };
                for &value in values {
                    call(target, pname, value);
                    // SAFETY: getError takes no arguments.
                    if unsafe { self.gl.get_error() } == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            test,
                            &format!("Invalid enums : (0x{target:x}, 0x{pname:x}, 0x{value:x})"),
                        );
                        success = false;
                    }
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallTexSubImage2D`
    fn tex_sub_image_2d(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let buf = [0u8; 1000];

        // SAFETY: the 1x1 transfers read at most 16 bytes of `buf`.
        unsafe {
            for (i, format) in data::EA_TEXTURE_FORMAT.into_iter().enumerate() {
                let type_ = data::EA_TEXTURE_TYPE[i];

                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    format as glw::GLint,
                    1,
                    1,
                    0,
                    format,
                    type_,
                    buf.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "texImage2D")?;
                gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 1, 1, format, type_, buf.as_ptr().cast());
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg(
                        "CallTexSubImage2D",
                        &format!("Invalid enums : (0x{format:x}, 0x{type_:x})"),
                    );
                    success = false;
                }

                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    format as glw::GLint,
                    1,
                    1,
                    0,
                    format,
                    type_,
                    std::ptr::null(),
                );
                glu::expect_no_error(gl, "texImage2D")?;
                gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, 1, 1, format, type_, buf.as_ptr().cast());
                if gl.get_error() == glw::GL_INVALID_ENUM {
                    self.fail_msg(
                        "CallTexSubImage2D",
                        &format!("Invalid enums : (0x{format:x}, 0x{type_:x})"),
                    );
                    success = false;
                }
            }
        }

        Ok(success)
    }
}
