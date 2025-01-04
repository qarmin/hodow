// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 1.0-3.0 entry points, fifth part (`glCompileShader` to `glShaderSource`): shader objects. A desktop context always has a shader compiler (`compilerPresent` is true), so the "compiler not present" branches are left out.

use super::Coverage;
use crate::generated::khr_api_coverage as data;
use crate::tcu::TestError;
use crate::{glu, glw};

impl Coverage<'_> {
    pub(super) fn run_func_gl30_shaders(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glCompileShader" => self.compile_shader(),
            "glGetShaderiv" => self.get_shaderiv(),
            "glGetShaderInfoLog" => self.get_shader_info_log(),
            "glGetShaderSource" => self.get_shader_source(),
            "glShaderSource" => self.shader_source(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallCompileShader`
    fn compile_shader(&self) -> Result<bool, TestError> {
        let gl = self.gl;

        // SAFETY: plain handles.
        unsafe {
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                glu::expect_no_error(gl, "createShader")?;
                gl.compile_shader(shader);
                glu::expect_no_error(gl, "compileShader")?;
                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
        }

        Ok(true)
    }

    /// `TestCoverageGLCallGetShaderiv`
    fn get_shaderiv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut buf = [0 as glw::GLint; 10];

        // SAFETY: `buf` is larger than any shader parameter.
        unsafe {
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                glu::expect_no_error(gl, "createShader")?;

                for pname in data::EA_GET_SHADER_STATUS {
                    gl.get_shaderiv(shader, pname, buf.as_mut_ptr());
                    if gl.get_error() == glw::GL_INVALID_ENUM {
                        self.fail_msg(
                            "CallGetShaderiv",
                            &format!("Invalid enum : (0x{shader_type:x}, 0x{pname:x})"),
                        );
                        success = false;
                    }
                }

                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetShaderInfoLog`
    fn get_shader_info_log(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut infolog = [0 as glw::GLchar; 1024];
        let mut length: glw::GLsizei = 0;

        // SAFETY: `infolog` has the 1024 characters the call is told about.
        unsafe {
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                glu::expect_no_error(gl, "createShader")?;
                gl.get_shader_info_log(shader, 1024, &mut length, infolog.as_mut_ptr());
                glu::expect_no_error(gl, "getShaderInfoLog")?;
                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
        }

        Ok(true)
    }

    /// `TestCoverageGLCallGetShaderSource`
    fn get_shader_source(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut infolog = [0 as glw::GLchar; 1024];
        let mut length: glw::GLsizei = 0;

        // SAFETY: `infolog` has the 1024 characters the call is told about.
        unsafe {
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                glu::expect_no_error(gl, "createShader")?;
                gl.get_shader_source(shader, 1024, &mut length, infolog.as_mut_ptr());
                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
        }

        Ok(true)
    }

    /// `TestCoverageGLCallShaderSource`
    fn shader_source(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let buf = c"int main {}\n".as_ptr();
        let buf_size: [glw::GLint; 1] = [c"int main {}\n".to_bytes().len() as glw::GLint];

        // SAFETY: one NUL-terminated string with its length.
        unsafe {
            for shader_type in data::EA_SHADER_TYPES {
                let shader = gl.create_shader(shader_type);
                glu::expect_no_error(gl, "createShader")?;
                gl.shader_source(shader, 1, &buf, buf_size.as_ptr());
                gl.delete_shader(shader);
                glu::expect_no_error(gl, "deleteShader")?;
            }
        }

        Ok(true)
    }
}
