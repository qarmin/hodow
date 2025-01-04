// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluContextInfo.hpp / .cpp  (glu::ContextInfo)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::collections::BTreeSet;

use crate::glw;

/// `glu::ContextInfo` - the strings and limits a `checkSupport` asks about.
pub struct ContextInfo {
    pub vendor: String,
    pub renderer: String,
    pub version: String,
    pub shading_language_version: String,
    pub extensions: BTreeSet<String>,
}

impl ContextInfo {
    /// `glu::ContextInfo::create`
    pub fn create(gl: &glw::Functions) -> Self {
        Self {
            vendor: string(gl, glw::GL_VENDOR),
            renderer: string(gl, glw::GL_RENDERER),
            version: string(gl, glw::GL_VERSION),
            shading_language_version: string(gl, glw::GL_SHADING_LANGUAGE_VERSION),
            extensions: query_extensions(gl),
        }
    }

    /// `glu::ContextInfo::isExtensionSupported`
    pub fn is_extension_supported(&self, name: &str) -> bool {
        self.extensions.contains(name)
    }

    /// `glu::ContextInfo::getInt`
    pub fn get_int(&self, gl: &glw::Functions, name: u32) -> i32 {
        let mut value = 0;
        // SAFETY: every use passes a limit glGetIntegerv defines as a single value, so
        // one i32 of output is enough; a name the driver rejects leaves it at 0.
        unsafe { gl.get_integerv(name, &mut value) };
        value
    }

    /// `glu::ContextInfo::isCompressedTextureFormatSupported` - queries
    /// `GL_NUM_COMPRESSED_TEXTURE_FORMATS`/`GL_COMPRESSED_TEXTURE_FORMATS` fresh on every
    /// call rather than caching them behind a lazily-evaluated `CachedValue` the way
    /// upstream's own `ContextInfo` does - nothing in this port asks often enough for the
    /// cache to earn its keep, and a fresh query can never answer for a stale context.
    /// `glu::Texture2D::new_compressed` (and its `TextureCube`/`Texture2DArray`
    /// siblings) call this before touching the driver at all, matching upstream's own
    /// compressed-texture constructor throwing `NotSupportedError` up front rather than
    /// letting `glCompressedTexImage2D` fail with a raw `GL_INVALID_ENUM`.
    pub fn is_compressed_texture_format_supported(&self, gl: &glw::Functions, format: glw::GLenum) -> bool {
        let mut count = 0;
        // SAFETY: GL_NUM_COMPRESSED_TEXTURE_FORMATS is a single integer.
        unsafe { gl.get_integerv(glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS, &mut count) };
        if count <= 0 {
            return false;
        }
        let mut formats = vec![0i32; count as usize];
        // SAFETY: `formats` holds exactly the `count` entries the driver just reported.
        unsafe { gl.get_integerv(glw::GL_COMPRESSED_TEXTURE_FORMATS, formats.as_mut_ptr()) };
        formats.iter().any(|&entry| entry as u32 == format)
    }
}

fn string(gl: &glw::Functions, name: u32) -> String {
    // SAFETY: glGetString returns a driver-owned static string, or null for a name it
    // does not know, which `string_from` handles.
    unsafe { glw::string_from(gl.get_string(name)) }
}

/// The extension list, through `glGetStringi` - the only form ES 3.0 and later
/// guarantee, since the monolithic `glGetString(GL_EXTENSIONS)` was removed.
///
/// Falls back to the old string when the indexed query answers nothing, which is what
/// an ES 2.0 context does.
pub fn query_extensions(gl: &glw::Functions) -> BTreeSet<String> {
    // An ES 2.0 context has no glGetStringi at all, and calling one that was never
    // loaded is a panic by design - so the presence of the entry point, not the error
    // it would raise, is what decides which query to use.
    if gl.get_stringi.is_none() {
        // SAFETY: as in `string` above.
        let joined = unsafe { glw::string_from(gl.get_string(glw::GL_EXTENSIONS)) };
        return joined.split_whitespace().map(str::to_string).collect();
    }

    let mut count = 0;
    // SAFETY: GL_NUM_EXTENSIONS is a single integer; an ES 2.0 context raises
    // GL_INVALID_ENUM and leaves it at 0, which the fallback below then covers.
    unsafe { gl.get_integerv(glw::GL_NUM_EXTENSIONS, &mut count) };

    if count > 0 {
        let extensions = (0..count)
            // SAFETY: indices below the reported count are in range by definition.
            .map(|index| unsafe { glw::string_from(gl.get_stringi(glw::GL_EXTENSIONS, index as u32)) })
            .filter(|name| !name.is_empty())
            .collect();
        // The failed query above may have left an error behind on an ES 2.0 context.
        crate::glu::drain_errors(gl);
        return extensions;
    }

    crate::glu::drain_errors(gl);
    // SAFETY: as in `string` above.
    let joined = unsafe { glw::string_from(gl.get_string(glw::GL_EXTENSIONS)) };
    joined.split_whitespace().map(str::to_string).collect()
}

/// `glu::IsES3Compatible` - `GL_MAJOR_VERSION` does not exist on ES 2, so a query that
/// leaves no error behind means the context is ES 3 or newer.
pub fn is_es3_compatible(gl: &glw::Functions) -> bool {
    let mut major_version: glw::GLint = 0;
    // SAFETY: one GLint out, and the error queries take nothing.
    unsafe {
        gl.get_error();
        gl.get_integerv(glw::GL_MAJOR_VERSION, &mut major_version);
        gl.get_error() == glw::GL_NO_ERROR
    }
}

// ES 2.0 feature probes - `glu::ES2ContextInfo`. Each one compiles a small program and
// reports whether the driver took it, since ES 2.0 leaves these optional and has no query.

const DEFAULT_VERTEX_SHADER: &str = "attribute highp vec4 a_position;\n\
    void main (void) {\n\
    \tgl_Position = a_position;\n\
    }\n";

const DEFAULT_FRAGMENT_SHADER: &str = "void main (void) {\n\
    \tgl_FragColor = vec4(1.0);\n\
    }\n";

const VERTEX_DYNAMIC_LOOPS_SUPPORTED: &str = "attribute highp vec4\ta_position;\n\
    uniform mediump float\ta, b;\n\
    void main (void) {\n\
    \tgl_Position = a_position;\n\
    \tint numIters = a < b ? int(3.0*b) : int(a_position.x);\n\
    \tfor (int i = 0; i < numIters; i++)\n\
    \t\tgl_Position += vec4(0.1);\n\
    }\n";

const FRAGMENT_DYNAMIC_LOOPS_SUPPORTED: &str = "varying mediump vec4\tv_color;\n\
    uniform mediump float\ta, b;\n\
    void main (void) {\n\
    \tgl_FragColor = v_color;\n\
    \tint numIters = a < b ? int(3.0*b) : int(v_color.x);\n\
    \tfor (int i = 0; i < numIters; i++)\n\
    \t\tgl_FragColor += vec4(0.1);\n\
    }\n";

/// `glu::TryCompileProgram`
fn try_compile_program(gl: &glw::Functions, vertex_source: &str, fragment_source: &str) -> bool {
    crate::glu::ShaderProgram::new(
        gl,
        &crate::glu::ProgramSources::vtx_frag(vertex_source, fragment_source),
    )
    .is_ok()
}

const VERTEX_UNIFORM_LOOPS_SUPPORTED: &str = "attribute highp vec4\ta_position;\n\
    uniform int\t\t\tu_numIters;\n\
    void main (void) {\n\
    \tgl_Position = a_position;\n\
    \tfor (int i = 0; i < u_numIters; i++)\n\
    \t\tgl_Position += vec4(0.1);\n\
    }\n";

const FRAGMENT_UNIFORM_LOOPS_SUPPORTED: &str = "varying mediump vec4\tv_color;\n\
    uniform int\t\t\tu_numIters;\n\
    void main (void) {\n\
    \tgl_FragColor = v_color;\n\
    \tfor (int i = 0; i < u_numIters; i++)\n\
    \t\tgl_FragColor += vec4(0.1);\n\
    }\n";

/// `ES2ContextInfo::isVertexDynamicLoopSupported`
pub fn is_vertex_dynamic_loop_supported(gl: &glw::Functions) -> bool {
    try_compile_program(gl, VERTEX_DYNAMIC_LOOPS_SUPPORTED, DEFAULT_FRAGMENT_SHADER)
}

/// `ES2ContextInfo::isVertexUniformLoopSupported`
pub fn is_vertex_uniform_loop_supported(gl: &glw::Functions) -> bool {
    try_compile_program(gl, VERTEX_UNIFORM_LOOPS_SUPPORTED, DEFAULT_FRAGMENT_SHADER)
}

/// `ES2ContextInfo::isFragmentUniformLoopSupported`
pub fn is_fragment_uniform_loop_supported(gl: &glw::Functions) -> bool {
    try_compile_program(gl, DEFAULT_VERTEX_SHADER, FRAGMENT_UNIFORM_LOOPS_SUPPORTED)
}

/// `ES2ContextInfo::isFragmentDynamicLoopSupported`
pub fn is_fragment_dynamic_loop_supported(gl: &glw::Functions) -> bool {
    try_compile_program(gl, DEFAULT_VERTEX_SHADER, FRAGMENT_DYNAMIC_LOOPS_SUPPORTED)
}
