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
    available_modes, get_iterations, list_all_functions, request_stop, reset_stop_flag, set_iterations, set_skip_tests, should_stop, test_all_extensions, ExtensionTest,
    FeatureStats, ProgressCallback, TestFunction, TestProgress, TestStatistics,
};

// Re-export OpenGL API only when the `gpu` feature is enabled
#[cfg(feature = "gpu")]
pub use opengl::{available_opengl_modes, init_opengl, test_all_opengl, GLTestResult, OpenGLMode};

// Re-export GUI API when `gpu` feature enabled (GUI is part of gpu feature)
#[cfg(feature = "gpu")]
pub use opengl::gui::{create_window_for_test, close_window, init_gui_runtime, GuiBackend, GuiRuntimeHandle, WindowSpec};

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
