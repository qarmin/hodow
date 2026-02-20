#![allow(incomplete_features)]
#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]

use once_cell::sync::OnceCell;

pub mod cpu;

// Re-export main API
pub use cpu::{
    available_modes, get_iterations, list_all_functions, request_stop, reset_stop_flag, set_iterations, set_skip_tests, should_stop, test_all_extensions, ExtensionTest,
    FeatureStats, ProgressCallback, TestFunction, TestProgress, TestStatistics,
};

// FUZZING state management (przeniesione z main.rs)
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
