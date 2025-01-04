// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/egl/wrapper  (eglw::Library, eglw::DefaultLibrary)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The entry-point table is generated - see src/generated/eglw.rs. What is here is the
// dynamic loading upstream's `DefaultLibrary` does: libEGL and libGLESv2 are opened at
// run time, so the binary links against neither and needs no -dev package installed.

use std::collections::BTreeSet;
use std::ffi::{CString, c_void};

pub use crate::generated::eglw::*;

/// Names to try for libEGL, in order. The versioned soname is what a runtime package
/// installs; the bare one only exists with a -dev package, so it is the fallback.
#[cfg(not(windows))]
const EGL_LIBRARIES: &[&str] = &["libEGL.so.1", "libEGL.so"];
/// Windows has no EGL of its own: `libEGL.dll` comes from ANGLE (next to the binary, or in a browser's directory), `EGL.dll` from a few vendor drivers.
#[cfg(windows)]
const EGL_LIBRARIES: &[&str] = &["libEGL.dll", "EGL.dll"];

/// Same for the GLES client library. Core ES entry points are looked up here before
/// `eglGetProcAddress` is tried: a driver is only required to answer that for
/// extensions, and several return null for core functions.
#[cfg(not(windows))]
const GLES_LIBRARIES: &[&str] = &["libGLESv2.so.2", "libGLESv2.so"];
#[cfg(windows)]
const GLES_LIBRARIES: &[&str] = &["libGLESv2.dll", "GLESv2.dll"];

/// The API could not be loaded at all - no libEGL, or one without the core entry
/// points. Distinct from every test outcome: nothing was run.
#[derive(Debug)]
pub struct LoadError(pub String);

impl std::fmt::Display for LoadError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl std::error::Error for LoadError {}

/// `eglw::DefaultLibrary` - libEGL opened at run time, with its entry points loaded.
pub struct Library {
    egl_lib: libloading::Library,
    gles_lib: Option<libloading::Library>,
    pub egl: Functions,
}

impl Library {
    pub fn open() -> Result<Self, LoadError> {
        let egl_lib = open_any(EGL_LIBRARIES).map_err(|tried| {
            LoadError(format!(
                "no EGL library could be opened (tried {}). Install a driver's EGL \
                 runtime, or on a desktop `mesa-utils`/`libegl1`; on Windows put ANGLE's libEGL.dll and libGLESv2.dll next to the binary.",
                tried.join(", ")
            ))
        })?;

        let mut egl = Functions::default();
        egl.load_core(&mut |name| dlsym(&egl_lib, name));

        // Without these there is no way to reach a display at all, so a library that
        // does not export them is not an EGL library whatever its name says.
        for (present, name) in [
            (egl.get_display.is_some(), "eglGetDisplay"),
            (egl.initialize.is_some(), "eglInitialize"),
            (egl.choose_config.is_some(), "eglChooseConfig"),
            (egl.create_context.is_some(), "eglCreateContext"),
        ] {
            if !present {
                return Err(LoadError(format!(
                    "the EGL library that was opened does not export {name}"
                )));
            }
        }

        // Extension entry points are only reachable through eglGetProcAddress, and the
        // client extension strings are not known until a display exists - upstream
        // loads them unconditionally too, leaving a null field for whatever is absent.
        let mut library = Self {
            egl_lib,
            gles_lib: open_any(GLES_LIBRARIES).ok(),
            egl,
        };
        let mut egl = std::mem::take(&mut library.egl);
        egl.load_extensions(&mut |name| library.proc_address(name));
        library.egl = egl;

        Ok(library)
    }

    /// Looks one GL or EGL entry point up: the client library first, then
    /// `eglGetProcAddress`.
    pub fn get_proc(&self, name: &str) -> *const c_void {
        if let Some(lib) = &self.gles_lib {
            let symbol = dlsym(lib, name);
            if !symbol.is_null() {
                return symbol;
            }
        }
        let symbol = dlsym(&self.egl_lib, name);
        if !symbol.is_null() {
            return symbol;
        }
        self.proc_address(name)
    }

    fn proc_address(&self, name: &str) -> *const c_void {
        let Some(get_proc_address) = self.egl.get_proc_address else {
            return std::ptr::null();
        };
        let Ok(cname) = CString::new(name) else {
            return std::ptr::null();
        };
        // SAFETY: the pointer came from the library's own export table and the name is
        // a valid C string that outlives the call.
        let function = unsafe { get_proc_address(cname.as_ptr()) };
        function.map_or(std::ptr::null(), |f| f as *const c_void)
    }

    /// The client extensions, i.e. `eglQueryString(EGL_NO_DISPLAY, EGL_EXTENSIONS)`.
    ///
    /// This is the query that says whether a platform extension - the surfaceless and
    /// device platforms this tool depends on to run without a screen - can be used at
    /// all, and it is the one query that is legal before a display exists.
    pub fn client_extensions(&self) -> BTreeSet<String> {
        let Some(query_string) = self.egl.query_string else {
            return BTreeSet::new();
        };
        // SAFETY: EGL_NO_DISPLAY with EGL_EXTENSIONS is explicitly allowed by EGL 1.5
        // and by EGL_EXT_client_extensions; an older driver answers null, which
        // `split_extensions` handles.
        unsafe { split_extensions(query_string(EGL_NO_DISPLAY, EGL_EXTENSIONS as i32)) }
    }
}

/// Splits a space-separated extension string the driver owns.
///
/// Returns an empty set for null, which is what an EGL implementation without
/// `EGL_EXT_client_extensions` answers.
///
/// # Safety
/// `ptr` must be null or a null-terminated string that stays valid for the call.
pub unsafe fn split_extensions(ptr: *const std::ffi::c_char) -> BTreeSet<String> {
    if ptr.is_null() {
        return BTreeSet::new();
    }
    // SAFETY: the caller passes a driver-owned null-terminated string.
    let text = unsafe { std::ffi::CStr::from_ptr(ptr) }.to_string_lossy().into_owned();
    text.split_whitespace().map(str::to_string).collect()
}

fn open_any(names: &[&str]) -> Result<libloading::Library, Vec<String>> {
    for name in names {
        // SAFETY: opening a shared library runs its initialisers, which is exactly
        // what is wanted here; there is no way to do this without `unsafe`.
        if let Ok(library) = unsafe { libloading::Library::new(*name) } {
            log::debug!("opened {name}");
            return Ok(library);
        }
    }
    Err(names.iter().map(|n| (*n).to_string()).collect())
}

fn dlsym(library: &libloading::Library, name: &str) -> *const c_void {
    let Ok(cname) = CString::new(name) else {
        return std::ptr::null();
    };
    // SAFETY: the symbol is read as an opaque function pointer and only ever called
    // back through the generated table, which knows its real signature.
    match unsafe { library.get::<unsafe extern "C" fn()>(cname.as_bytes_with_nul()) } {
        Ok(symbol) => (*symbol) as *const c_void,
        Err(_) => std::ptr::null(),
    }
}

/// `eglu::getErrorStr`
pub fn error_name(error: EGLint) -> &'static str {
    match error as u32 {
        EGL_SUCCESS => "EGL_SUCCESS",
        EGL_NOT_INITIALIZED => "EGL_NOT_INITIALIZED",
        EGL_BAD_ACCESS => "EGL_BAD_ACCESS",
        EGL_BAD_ALLOC => "EGL_BAD_ALLOC",
        EGL_BAD_ATTRIBUTE => "EGL_BAD_ATTRIBUTE",
        EGL_BAD_CONTEXT => "EGL_BAD_CONTEXT",
        EGL_BAD_CONFIG => "EGL_BAD_CONFIG",
        EGL_BAD_CURRENT_SURFACE => "EGL_BAD_CURRENT_SURFACE",
        EGL_BAD_DISPLAY => "EGL_BAD_DISPLAY",
        EGL_BAD_SURFACE => "EGL_BAD_SURFACE",
        EGL_BAD_MATCH => "EGL_BAD_MATCH",
        EGL_BAD_PARAMETER => "EGL_BAD_PARAMETER",
        EGL_BAD_NATIVE_PIXMAP => "EGL_BAD_NATIVE_PIXMAP",
        EGL_BAD_NATIVE_WINDOW => "EGL_BAD_NATIVE_WINDOW",
        EGL_CONTEXT_LOST => "EGL_CONTEXT_LOST",
        _ => "unknown EGL error",
    }
}
