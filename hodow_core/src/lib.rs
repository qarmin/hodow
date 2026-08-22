#![allow(incomplete_features)]
#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]

use std::sync::OnceLock;

pub mod cpu;

#[cfg(feature = "gpu")]
pub mod opengl;

#[cfg(feature = "vulkan")]
pub mod vulkan;

// Re-export main API
pub use cpu::{
    ExtensionTest, FeatureStats, ProgressCallback, TestFunction, TestProgress, TestStatistics, all_tests, available_modes, get_iterations, list_all_functions, request_stop,
    reset_stop_flag, set_iterations, set_only_features, set_only_tests, set_skip_tests, should_skip_feature, should_stop, test_all_extensions,
};
// Re-export OpenGL API only when the `gpu` feature is enabled
#[cfg(feature = "gpu")]
pub use opengl::memtest::{MemtestReport, run_memtest};
#[cfg(feature = "gpu")]
pub use opengl::{DisplayApiHint, GLTestResult, GlApiHint, GpuOptions, OpenGLMode, available_opengl_modes, init_opengl, test_all_opengl};

static FUZZING: OnceLock<bool> = OnceLock::new();

pub fn get_fuzzing() -> bool {
    // Fuzzing is enabled by default; reading it must not mutate the cell, otherwise a
    // later `set_fuzzing(false)` would be silently ignored (OnceLock only accepts the
    // first write) and concurrent readers could race on the initializing write.
    *FUZZING.get().unwrap_or(&true)
}

pub fn set_fuzzing(enabled: bool) {
    let _ = FUZZING.set(enabled);
}

pub fn get_fuzzer() -> bool {
    get_fuzzing()
}
