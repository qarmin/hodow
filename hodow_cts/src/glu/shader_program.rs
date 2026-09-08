// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluShaderProgram.hpp / .cpp  (glu::Shader, glu::Program, glu::ShaderProgram)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Note what is *not* happening here, because it is the whole difference from the
// Vulkan half of this crate: the GLSL is handed to the driver as source. A GL driver
// consumes GLSL, so its compiler is part of what is under test and cannot be moved to
// generation time the way `compile_shaders.py` moves GLSL-to-SPIR-V for Vulkan.

use crate::glw::{self, GLenum, GLint, GLuint};

/// `glu::ShaderType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ShaderType {
    Vertex,
    Fragment,
    Geometry,
    TessControl,
    TessEvaluation,
    Compute,
}

impl ShaderType {
    pub fn gl_enum(self) -> GLenum {
        match self {
            Self::Vertex => glw::GL_VERTEX_SHADER,
            Self::Fragment => glw::GL_FRAGMENT_SHADER,
            Self::Geometry => glw::GL_GEOMETRY_SHADER,
            Self::TessControl => glw::GL_TESS_CONTROL_SHADER,
            Self::TessEvaluation => glw::GL_TESS_EVALUATION_SHADER,
            Self::Compute => glw::GL_COMPUTE_SHADER,
        }
    }

    pub fn as_str(self) -> &'static str {
        match self {
            Self::Vertex => "vertex",
            Self::Fragment => "fragment",
            Self::Geometry => "geometry",
            Self::TessControl => "tessellation control",
            Self::TessEvaluation => "tessellation evaluation",
            Self::Compute => "compute",
        }
    }
}

/// `glu::ProgramSources`
#[derive(Default)]
pub struct ProgramSources {
    pub sources: Vec<(ShaderType, String)>,
}

impl ProgramSources {
    /// `ProgramSources() << ShaderSource(type, source)`
    pub fn with(mut self, shader_type: ShaderType, source: impl Into<String>) -> Self {
        self.sources.push((shader_type, source.into()));
        self
    }

    /// `glu::ComputeSource`
    pub fn compute(source: impl Into<String>) -> Self {
        Self::default().with(ShaderType::Compute, source)
    }
}

/// One shader's or the program's compile/link outcome.
pub struct BuildInfo {
    pub ok: bool,
    pub info_log: String,
}

/// `glu::ShaderProgram` - compiled, linked, and deleted when it goes out of scope.
pub struct ShaderProgram<'gl> {
    gl: &'gl glw::Functions,
    program: GLuint,
    shaders: Vec<GLuint>,
    pub shader_info: Vec<(ShaderType, BuildInfo)>,
    pub program_info: BuildInfo,
}

impl<'gl> ShaderProgram<'gl> {
    pub fn new(gl: &'gl glw::Functions, sources: &ProgramSources) -> Self {
        // SAFETY: every call is made with a current context, and each object handle is
        // one this function just created.
        unsafe {
            let program = gl.create_program();
            let mut shaders = Vec::with_capacity(sources.sources.len());
            let mut shader_info = Vec::with_capacity(sources.sources.len());

            for (shader_type, source) in &sources.sources {
                let shader = gl.create_shader(shader_type.gl_enum());
                shaders.push(shader);

                let bytes = source.as_bytes();
                let pointer = bytes.as_ptr().cast::<glw::GLchar>();
                let length = bytes.len() as GLint;
                // The length is passed explicitly, so the source needs no trailing nul.
                gl.shader_source(shader, 1, &pointer, &length);
                gl.compile_shader(shader);

                let mut status = 0;
                gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status);
                let info_log = shader_info_log(gl, shader);
                shader_info.push((
                    *shader_type,
                    BuildInfo {
                        ok: status == glw::GL_TRUE as GLint,
                        info_log,
                    },
                ));

                if status == glw::GL_TRUE as GLint {
                    gl.attach_shader(program, shader);
                }
            }

            let compiled = shader_info.iter().all(|(_, info)| info.ok);
            let mut program_info = BuildInfo {
                ok: false,
                info_log: String::new(),
            };

            if compiled {
                gl.link_program(program);
                let mut status = 0;
                gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status);
                program_info = BuildInfo {
                    ok: status == glw::GL_TRUE as GLint,
                    info_log: program_info_log(gl, program),
                };
            }

            let built = Self {
                gl,
                program,
                shaders,
                shader_info,
                program_info,
            };
            built.log();
            built
        }
    }

    pub fn is_ok(&self) -> bool {
        self.program_info.ok && self.shader_info.iter().all(|(_, info)| info.ok)
    }

    pub fn program(&self) -> GLuint {
        self.program
    }

    /// `m_testCtx.getLog() << program` - upstream logs the whole program every time.
    ///
    /// Here a successful build is logged at debug and a failed one at warn, because a
    /// full-suite run would otherwise print every shader in the suite.
    fn log(&self) {
        for (shader_type, info) in &self.shader_info {
            if !info.ok {
                log::warn!("{} shader failed to compile:\n{}", shader_type.as_str(), info.info_log.trim_end());
            } else if !info.info_log.trim().is_empty() {
                log::debug!("{} shader compiled with a message:\n{}", shader_type.as_str(), info.info_log.trim_end());
            }
        }
        if !self.program_info.ok {
            log::warn!("program failed to link:\n{}", self.program_info.info_log.trim_end());
        } else if !self.program_info.info_log.trim().is_empty() {
            log::debug!("program linked with a message:\n{}", self.program_info.info_log.trim_end());
        }
    }
}

impl Drop for ShaderProgram<'_> {
    fn drop(&mut self) {
        // SAFETY: the handles are this program's own and are deleted exactly once.
        unsafe {
            for shader in &self.shaders {
                self.gl.delete_shader(*shader);
            }
            self.gl.delete_program(self.program);
        }
    }
}

fn shader_info_log(gl: &glw::Functions, shader: GLuint) -> String {
    let mut length = 0;
    // SAFETY: GL_INFO_LOG_LENGTH is a single integer, and the buffer below is sized
    // from what the driver reports.
    unsafe {
        gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length);
        if length <= 0 {
            return String::new();
        }
        let mut buffer = vec![0u8; length as usize];
        let mut written = 0;
        gl.get_shader_info_log(shader, length, &mut written, buffer.as_mut_ptr().cast::<glw::GLchar>());
        buffer.truncate(written.max(0) as usize);
        String::from_utf8_lossy(&buffer).into_owned()
    }
}

fn program_info_log(gl: &glw::Functions, program: GLuint) -> String {
    let mut length = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &mut length);
        if length <= 0 {
            return String::new();
        }
        let mut buffer = vec![0u8; length as usize];
        let mut written = 0;
        gl.get_program_info_log(program, length, &mut written, buffer.as_mut_ptr().cast::<glw::GLchar>());
        buffer.truncate(written.max(0) as usize);
        String::from_utf8_lossy(&buffer).into_owned()
    }
}
