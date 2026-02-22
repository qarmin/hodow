#![cfg(feature = "gpu")]

use crate::opengl::context::OpenGLMode;
use std::error::Error;
use std::os::raw::c_char;

/// Initialize/load GL function pointers using `gl` crate.
pub fn init_gl(mode: &OpenGLMode) -> Result<(), Box<dyn Error>> {
    use glutin::prelude::*;

    // Load OpenGL function pointers
    gl::load_with(|s| {
        let cstr = std::ffi::CString::new(s).unwrap();
        mode.display.get_proc_address(cstr.as_c_str()) as *const _
    });

    // Verify basic GL is loaded
    unsafe {
        let version = gl::GetString(gl::VERSION);
        if version.is_null() {
            let ds = mode.display.version_string();
            return Err(format!("Failed to get OpenGL version (display reported: {})", ds).into());
        }
        let version_str = std::ffi::CStr::from_ptr(version as *const c_char);
        log::info!("OpenGL version: {}", version_str.to_string_lossy());

        // Also log shading language version for shader compatibility
        let shading = gl::GetString(gl::SHADING_LANGUAGE_VERSION);
        if shading.is_null() {
            log::warn!("GL_SHADING_LANGUAGE_VERSION returned null");
        } else {
            let shading_str = std::ffi::CStr::from_ptr(shading as *const c_char);
            log::info!("GLSL version: {}", shading_str.to_string_lossy());
        }
    }

    Ok(())
}

/// Load GL function pointers from a glutin Display (used by new GUI module)
pub fn load_gl_functions<D>(display: &D) -> Result<(), Box<dyn Error>>
where
    D: glutin::display::GlDisplay,
{
    use glutin::prelude::*;

    // Load OpenGL function pointers
    gl::load_with(|s| {
        let cstr = std::ffi::CString::new(s).unwrap();
        display.get_proc_address(cstr.as_c_str()) as *const _
    });

    // Verify basic GL is loaded
    unsafe {
        let version = gl::GetString(gl::VERSION);
        if version.is_null() {
            return Err("Failed to get OpenGL version".into());
        }
        let version_str = std::ffi::CStr::from_ptr(version as *const c_char);
        log::info!("OpenGL version: {}", version_str.to_string_lossy());

        // Also log shading language version for shader compatibility
        let shading = gl::GetString(gl::SHADING_LANGUAGE_VERSION);
        if !shading.is_null() {
            let shading_str = std::ffi::CStr::from_ptr(shading as *const c_char);
            log::info!("GLSL version: {}", shading_str.to_string_lossy());
        }
    }

    Ok(())
}
