use std::error::Error;
use std::os::raw::c_char;

use crate::opengl::context::OpenGLMode;

/// Initialize/load GL function pointers using `gl` crate.
pub fn init_gl(mode: &OpenGLMode) -> Result<(), Box<dyn Error>> {
    use glutin::prelude::*;

    // Load OpenGL function pointers
    gl::load_with(|s| {
        let cstr = std::ffi::CString::new(s).expect("a GL symbol name has no NUL");
        mode.display.get_proc_address(cstr.as_c_str()) as *const _
    });

    // Verify basic GL is loaded
    unsafe {
        let version = gl::GetString(gl::VERSION);
        if version.is_null() {
            let ds = mode.display.version_string();
            return Err(format!("Failed to get OpenGL version (display reported: {ds})").into());
        }
        let version_str = std::ffi::CStr::from_ptr(version as *const c_char);
        log::info!("OpenGL version: {}", version_str.to_string_lossy());
        log_gl_identity();

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
        let cstr = std::ffi::CString::new(s).expect("a GL symbol name has no NUL");
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
        log_gl_identity();

        // Also log shading language version for shader compatibility
        let shading = gl::GetString(gl::SHADING_LANGUAGE_VERSION);
        if !shading.is_null() {
            let shading_str = std::ffi::CStr::from_ptr(shading as *const c_char);
            log::info!("GLSL version: {}", shading_str.to_string_lossy());
        }
    }

    Ok(())
}

/// Which GPU and driver answered; without it a log from someone else's machine cannot be attributed.
///
/// # Safety
/// Requires a current GL context with loaded function pointers.
unsafe fn log_gl_identity() {
    for (label, name) in [("renderer", gl::RENDERER), ("vendor", gl::VENDOR)] {
        let ptr = unsafe { gl::GetString(name) };
        if !ptr.is_null() {
            log::info!(
                "OpenGL {label}: {}",
                unsafe { std::ffi::CStr::from_ptr(ptr as *const c_char) }.to_string_lossy()
            );
        }
    }
}
