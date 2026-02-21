//! Stubbed OpenGL support when the `gpu` feature is not enabled.
//! These types are intentionally minimal and return errors at runtime.

use std::fmt;

#[derive(Debug)]
pub struct OpenGLMode(());

#[derive(Debug)]
pub enum OpenGLError {
    FeatureDisabled,
}

impl fmt::Display for OpenGLError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            OpenGLError::FeatureDisabled => write!(f, "OpenGL feature disabled at compile time"),
        }
    }
}

impl std::error::Error for OpenGLError {}

/// Attempt to initialize OpenGL. Returns an error because GPU support is disabled.
pub fn init_opengl() -> Result<OpenGLMode, OpenGLError> {
    Err(OpenGLError::FeatureDisabled)
}

/// Return a (possibly empty) list of available OpenGL modes/implementations.
pub fn available_opengl_modes() -> Vec<String> {
    Vec::new()
}

pub type GLTestResult = Result<(usize, usize, usize), String>;

pub fn test_all_opengl() -> GLTestResult {
    Err("OpenGL feature disabled at compile time".to_string())
}
