//! OpenGL helper module for GPU testing.
use log::info;

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
    info!("Created OpenGL context");
    init_gl(&ctx)?;
    info!("Initialized OpenGL function pointers");
    Ok(ctx)
}

pub fn available_opengl_modes() -> Vec<String> {
    vec!["default-headless".to_string()]
}

pub fn test_all_opengl() -> GLTestResult {
    tests::test_all_gl()
}
