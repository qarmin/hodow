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
    pub sources: Vec<(ShaderType, Vec<u8>)>,
    /// `glu::TransformFeedbackVaryings` - applied just before linking.
    pub transform_feedback_varyings: Vec<String>,
    /// `glu::TransformFeedbackMode` - `GL_SEPARATE_ATTRIBS` or `GL_INTERLEAVED_ATTRIBS`.
    pub transform_feedback_mode: GLenum,
    /// `glu::ProgramSeparable` - set as `GL_PROGRAM_SEPARABLE` before the link.
    pub separable: bool,
}

impl ProgramSources {
    /// `ProgramSources() << ShaderSource(type, source)`
    pub fn with(mut self, shader_type: ShaderType, source: impl Into<String>) -> Self {
        self.sources.push((shader_type, source.into().into_bytes()));
        self
    }

    /// The same for a source that is not necessarily UTF-8: GLSL is bytes, and a Khronos case deliberately feeds the compiler a stray one.
    pub fn with_bytes(mut self, shader_type: ShaderType, source: Vec<u8>) -> Self {
        self.sources.push((shader_type, source));
        self
    }

    /// `ProgramSources() << TransformFeedbackVaryings(...) << TransformFeedbackMode(m)`
    pub fn with_transform_feedback(mut self, varyings: &[String], mode: GLenum) -> Self {
        self.transform_feedback_varyings = varyings.to_vec();
        self.transform_feedback_mode = mode;
        self
    }

    /// `ProgramSources() << ProgramSeparable(true)`
    pub fn separable(mut self) -> Self {
        self.separable = true;
        self
    }

    /// `glu::ComputeSource`
    pub fn compute(source: impl Into<String>) -> Self {
        Self::default().with(ShaderType::Compute, source)
    }

    /// `glu::makeVtxFragSources`
    pub fn vtx_frag(vertex: impl Into<String>, fragment: impl Into<String>) -> Self {
        Self::default()
            .with(ShaderType::Vertex, vertex)
            .with(ShaderType::Fragment, fragment)
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
        Self::build(gl, sources, false)
    }

    /// The same, for a case whose expected outcome *is* a build failure - the driver's
    /// compile or link error is then the result, not a finding, and is logged at debug.
    pub fn new_expecting_build_failure(gl: &'gl glw::Functions, sources: &ProgramSources) -> Self {
        Self::build(gl, sources, true)
    }

    /// The same, for a caller that puts `build_failure_summary` into the case's own result
    /// message - warning about it here as well would print the driver's error twice.
    pub fn new_reporting_build_failure(gl: &'gl glw::Functions, sources: &ProgramSources) -> Self {
        Self::build(gl, sources, true)
    }

    /// Every shader source the driver is handed, to stderr, when `HODOW_CTS_DUMP_SHADERS`
    /// is set in the environment.
    ///
    /// Turning a failing case into a short standalone reproducer starts with the GLSL the
    /// driver actually compiled, and the GLES half builds that at run time with `format!`
    /// (deliberately, since a GL driver's compiler is part of what is under test), so
    /// unlike the Vulkan half there is no committed file to read it out of.
    fn dump_sources(sources: &ProgramSources) {
        if std::env::var_os("HODOW_CTS_DUMP_SHADERS").is_none() {
            return;
        }
        for (shader_type, source) in &sources.sources {
            eprintln!(
                "=== {shader_type:?} shader ===\n{}\n=== end ===",
                String::from_utf8_lossy(source)
            );
        }
    }

    fn build(gl: &'gl glw::Functions, sources: &ProgramSources, build_failure_quiet: bool) -> Self {
        Self::dump_sources(sources);
        // SAFETY: every call is made with a current context, and each object handle is
        // one this function just created.
        unsafe {
            let program = gl.create_program();
            let mut shaders = Vec::with_capacity(sources.sources.len());
            let mut shader_info = Vec::with_capacity(sources.sources.len());

            for (shader_type, source) in &sources.sources {
                let shader = gl.create_shader(shader_type.gl_enum());
                shaders.push(shader);

                let bytes = source.as_slice();
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
                // Must precede the link: separability is baked in at link time.
                if sources.separable {
                    gl.program_parameteri(program, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
                }

                // Must precede the link, which is what bakes the capture list in.
                if !sources.transform_feedback_varyings.is_empty() {
                    let owned: Vec<std::ffi::CString> = sources
                        .transform_feedback_varyings
                        .iter()
                        .map(|name| std::ffi::CString::new(name.as_str()).expect("varying name holds a nul byte"))
                        .collect();
                    let pointers: Vec<*const glw::GLchar> = owned.iter().map(|name| name.as_ptr()).collect();
                    gl.transform_feedback_varyings(
                        program,
                        pointers.len() as GLint,
                        pointers.as_ptr(),
                        sources.transform_feedback_mode,
                    );
                }

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
            built.log(build_failure_quiet);
            built
        }
    }

    pub fn is_ok(&self) -> bool {
        self.program_info.ok && self.shader_info.iter().all(|(_, info)| info.ok)
    }

    pub fn program(&self) -> GLuint {
        self.program
    }

    /// `getShader(type)->getShader()` - the GL name of the first shader of this stage.
    pub fn shader(&self, shader_type: ShaderType) -> Option<GLuint> {
        self.shader_info
            .iter()
            .position(|(stage, _)| *stage == shader_type)
            .map(|index| self.shaders[index])
    }

    /// The driver's own reason for a failed build, on one line.
    ///
    /// A case result reaches the terminal and `--output`'s JSON one line at a time, while
    /// an info log is several and often ends in a blank one; without this the reason lives
    /// only in the log, so a report from someone else's board says a case failed but not
    /// why. The first failing stage is the one that matters - a later stage was handed
    /// whatever the earlier one produced.
    pub fn build_failure_summary(&self) -> Option<String> {
        for (shader_type, info) in &self.shader_info {
            if !info.ok {
                return Some(format!(
                    "{} shader failed to compile: {}",
                    shader_type.as_str(),
                    one_line(&info.info_log)
                ));
            }
        }
        if !self.program_info.ok {
            return Some(format!(
                "program failed to link: {}",
                one_line(&self.program_info.info_log)
            ));
        }
        None
    }

    /// `m_testCtx.getLog() << program` - upstream logs the whole program every time.
    ///
    /// Here a successful build is logged at debug and a failed one at warn, because a
    /// full-suite run would otherwise print every shader in the suite.
    ///
    /// `build_failure_quiet` drops that warn back to debug, for the two cases where the
    /// driver's error is not a finding of this run: a negative case - a `vector_illegal`
    /// conversion, a `negative` shader-library case - fails to build *by design*, and a
    /// caller that reports `build_failure_summary` itself would otherwise print it twice.
    fn log(&self, build_failure_quiet: bool) {
        let failure = |args: std::fmt::Arguments<'_>| {
            if build_failure_quiet {
                log::debug!("{args}");
            } else {
                log::warn!("{args}");
            }
        };

        for (shader_type, info) in &self.shader_info {
            if !info.ok {
                failure(format_args!(
                    "{} shader failed to compile:\n{}",
                    shader_type.as_str(),
                    info.info_log.trim_end()
                ));
            } else if !info.info_log.trim().is_empty() {
                log::debug!(
                    "{} shader compiled with a message:\n{}",
                    shader_type.as_str(),
                    info.info_log.trim_end()
                );
            }
        }
        if !self.program_info.ok {
            failure(format_args!(
                "program failed to link:\n{}",
                self.program_info.info_log.trim_end()
            ));
        } else if !self.program_info.info_log.trim().is_empty() {
            log::debug!(
                "program linked with a message:\n{}",
                self.program_info.info_log.trim_end()
            );
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

/// How much of an info log `build_failure_summary` keeps. A driver that reports every
/// error in the shader can run to kilobytes, and the whole point of the summary is to fit
/// on the result line; the full text is still logged at debug.
const MAX_SUMMARY_CHARS: usize = 300;

fn one_line(info_log: &str) -> String {
    let joined = info_log
        .lines()
        .map(str::trim)
        .filter(|line| !line.is_empty())
        .collect::<Vec<_>>()
        .join("; ");

    match joined.char_indices().nth(MAX_SUMMARY_CHARS) {
        Some((cut, _)) => format!("{}...", &joined[..cut]),
        None => joined,
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
