#![cfg(feature = "gpu")]

use crate::opengl::context::OpenGLMode;
use std::error::Error;

/// Initialize/load GL function pointers using `glow` and the provided context.
pub fn init_gl(_mode: &OpenGLMode) -> Result<(), Box<dyn Error>> {
    // We intentionally keep this minimal: actual loader needs a function pointer
    // retrieval closure from the underlying context. Integrate as needed.
    // For now, return Ok so compile-time linking is exercised without heavy logic.
    Ok(())
}

