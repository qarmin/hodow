//! OpenGL helper module for GPU testing.
//!
//! This module is only compiled when the `gpu` feature is enabled in Cargo.
//! It provides a minimal `OpenGLMode` wrapper and utilities to create a headless
//! GL context and load function pointers. Implementations are intentionally
//! small — expand as needed for more tests.

#[cfg(feature = "gpu")]
mod context;

#[cfg(feature = "gpu")]
mod loader;

#[cfg(feature = "gpu")]
pub use context::OpenGLMode;

#[cfg(feature = "gpu")]
pub use loader::init_gl;

#[cfg(feature = "gpu")]
pub fn init_opengl() -> Result<OpenGLMode, Box<dyn std::error::Error>> {
    let ctx = OpenGLMode::create()?;
    // Load GL functions
    init_gl(&ctx)?;
    Ok(ctx)
}

#[cfg(feature = "gpu")]
pub fn available_opengl_modes() -> Vec<String> {
    // For now we return a single default mode name; extend to enumerate adapters if needed.
    vec!["default-headless".to_string()]
}

