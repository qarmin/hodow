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
        mode.display.get_proc_address(&cstr) as *const _
    });

    // Verify basic GL is loaded
    unsafe {
        let version = gl::GetString(gl::VERSION);
        if version.is_null() {
            return Err("Failed to get OpenGL version".into());
        }
        let version_str = std::ffi::CStr::from_ptr(version as *const c_char);
        log::info!("OpenGL version: {}", version_str.to_string_lossy());
    }

    Ok(())
}
