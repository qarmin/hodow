// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/wrapper  (glw::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The entry-point table itself is generated - see src/generated/glw.rs. This module
// is the hand-written part: the error enum and the string helpers that every ported
// test needs and that no registry describes.

pub use crate::generated::glw::*;

/// `glu::getErrorStr` - the GL error name, for a message a person will read.
pub fn error_name(error: GLenum) -> &'static str {
    match error {
        GL_NO_ERROR => "GL_NO_ERROR",
        GL_INVALID_ENUM => "GL_INVALID_ENUM",
        GL_INVALID_VALUE => "GL_INVALID_VALUE",
        GL_INVALID_OPERATION => "GL_INVALID_OPERATION",
        GL_INVALID_FRAMEBUFFER_OPERATION => "GL_INVALID_FRAMEBUFFER_OPERATION",
        GL_OUT_OF_MEMORY => "GL_OUT_OF_MEMORY",
        GL_STACK_OVERFLOW => "GL_STACK_OVERFLOW",
        GL_STACK_UNDERFLOW => "GL_STACK_UNDERFLOW",
        GL_CONTEXT_LOST => "GL_CONTEXT_LOST",
        _ => "unknown GL error",
    }
}

/// Reads a null-terminated string the driver owns.
///
/// # Safety
/// `ptr` must be null or point to a null-terminated string that stays valid for the
/// duration of the call - which is what `glGetString` and `glGetStringi` return.
pub unsafe fn string_from(ptr: *const GLubyte) -> String {
    if ptr.is_null() {
        return String::new();
    }
    unsafe { std::ffi::CStr::from_ptr(ptr.cast::<std::ffi::c_char>()) }.to_string_lossy().into_owned()
}
