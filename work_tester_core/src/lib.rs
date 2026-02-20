#![allow(incomplete_features)]
#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]

use once_cell::sync::OnceCell;

pub mod cpu;

// Conditionally include the OpenGL module when the `gpu` feature is enabled.
// When disabled, provide lightweight stubs so downstream code can compile without the feature.
#[cfg(feature = "gpu")]
pub mod opengl;

#[cfg(not(feature = "gpu"))]
pub mod opengl {
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
}

// Re-export main API
pub use cpu::{
    available_modes, get_iterations, list_all_functions, request_stop, reset_stop_flag, set_iterations, set_skip_tests, should_stop, test_all_extensions, ExtensionTest,
    FeatureStats, ProgressCallback, TestFunction, TestProgress, TestStatistics,
};

// Re-export OpenGL API (either real or stubbed)
pub use opengl::{available_opengl_modes, init_opengl, OpenGLMode};

static FUZZING: OnceCell<bool> = OnceCell::new();

pub fn get_fuzzing() -> bool {
    if FUZZING.get().is_none() {
        FUZZING.set(true).unwrap();
    }
    *FUZZING.get().expect("FUZZING not initialized")
}

pub fn set_fuzzing(enabled: bool) {
    let _ = FUZZING.set(enabled);
}

pub fn get_fuzzer() -> bool {
    get_fuzzing()
}
