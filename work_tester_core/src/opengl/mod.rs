//! OpenGL helper module for GPU testing.

mod context;

mod loader;

mod test_trait;

pub mod tests;

// Export real implementations (no feature gating inside this module)
pub use context::OpenGLMode;

pub use loader::init_gl;

pub use test_trait::{GLTest, GLVersion, GLTestResult};

pub fn init_opengl() -> Result<OpenGLMode, Box<dyn std::error::Error>> {
    let ctx = OpenGLMode::create()?;
    init_gl(&ctx)?;
    Ok(ctx)
}

pub fn available_opengl_modes() -> Vec<String> {
    vec!["default-headless".to_string()]
}

pub fn test_all_opengl() -> GLTestResult {
    tests::test_all_gl()
}
