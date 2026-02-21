//! OpenGL helper module for GPU testing.

#[cfg(feature = "gpu")]
mod context;

#[cfg(feature = "gpu")]
mod loader;

#[cfg(feature = "gpu")]
mod test_trait;

#[cfg(feature = "gpu")]
pub mod tests;

#[cfg(not(feature = "gpu"))]
mod stub;

// GPU feature enabled - export real implementations
#[cfg(feature = "gpu")]
pub use context::OpenGLMode;

#[cfg(feature = "gpu")]
pub use loader::init_gl;

#[cfg(feature = "gpu")]
pub use test_trait::{GLTest, GLVersion, GLTestResult};

#[cfg(feature = "gpu")]
pub fn init_opengl() -> Result<OpenGLMode, Box<dyn std::error::Error>> {
    let ctx = OpenGLMode::create()?;
    init_gl(&ctx)?;
    Ok(ctx)
}

#[cfg(feature = "gpu")]
pub fn available_opengl_modes() -> Vec<String> {
    vec!["default-headless".to_string()]
}

#[cfg(feature = "gpu")]
pub fn test_all_opengl() -> GLTestResult {
    tests::test_all_gl()
}

// GPU feature disabled - export stubs
#[cfg(not(feature = "gpu"))]
pub use stub::{available_opengl_modes, init_opengl, test_all_opengl, GLTestResult, OpenGLMode};
