#![allow(incomplete_features)]
#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]

use once_cell::sync::OnceCell;

pub mod cpu;

#[cfg(feature = "gpu")]
pub mod opengl;

// Re-export main API
pub use cpu::{
    ExtensionTest, FeatureStats, ProgressCallback, TestFunction, TestProgress, TestStatistics, available_modes, get_iterations, list_all_functions, request_stop, reset_stop_flag,
    set_iterations, set_only_tests, set_skip_tests, should_stop, test_all_extensions,
};
// Re-export OpenGL API only when the `gpu` feature is enabled
#[cfg(feature = "gpu")]
pub use opengl::{DisplayApiHint, GLTestResult, GlApiHint, GpuOptions, OpenGLMode, available_opengl_modes, init_opengl, test_all_opengl};

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
