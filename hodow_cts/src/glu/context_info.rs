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
