#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]
#![allow(unused)]

use std::collections::HashSet;
use std::sync::atomic::{AtomicBool, Ordering};

use log::{error, info};
use once_cell::sync::OnceCell;

pub mod auto_generated;
pub(crate) mod common;

pub use auto_generated::registry::{all_tests, available_modes, count_available_features, list_all_functions, test_all_extensions};
#[allow(unused_imports)]
pub use auto_generated::*;

#[derive(Debug, Clone)]
pub struct TestProgress {
    pub total_features: usize,
    pub completed_features: usize,
    pub current_feature: &'static str,
    pub total_tests_in_feature: usize,
    pub completed_tests_in_feature: usize,
    pub current_test: &'static str,
    pub fuzzing_iteration: usize,
    pub total_fuzzing_iterations: usize,
}

#[derive(Debug, Clone)]
pub struct FeatureStats {
    pub feature_name: &'static str,
    pub tests_run: usize,
    pub tests_skipped: usize,
    pub tests_errored: usize,
}

#[derive(Debug, Clone)]
pub struct TestStatistics {
    pub features: Vec<FeatureStats>,
    pub was_cancelled: bool,
}

impl TestStatistics {
    pub fn total_run(&self) -> usize {
        self.features.iter().map(|f| f.tests_run).sum()
    }

    pub fn total_skipped(&self) -> usize {
        self.features.iter().map(|f| f.tests_skipped).sum()
    }

    pub fn total_errors(&self) -> usize {
        self.features.iter().map(|f| f.tests_errored).sum()
    }
}

pub type ProgressCallback = dyn Fn(&TestProgress) + Send + Sync;

#[cfg(miri)]
pub const DEFAULT_TEST_ITERATIONS: usize = 0;
#[cfg(not(miri))]
#[allow(dead_code)]
pub const DEFAULT_TEST_ITERATIONS: usize = 0;

static ITERATIONS: OnceCell<usize> = OnceCell::new();
static SKIP_TESTS: OnceCell<HashSet<String>> = OnceCell::new();
/// When set, only tests whose names appear in this set will be run.
static ONLY_TESTS: OnceCell<HashSet<String>> = OnceCell::new();
/// When set, only features whose names appear in this set will be run.
static ONLY_FEATURES: OnceCell<HashSet<String>> = OnceCell::new();
static STOP_REQUESTED: AtomicBool = AtomicBool::new(false);

pub fn set_iterations(n: usize) {
    let _ = ITERATIONS.set(n);
}

pub fn get_iterations() -> usize {
    *ITERATIONS.get().unwrap_or(&DEFAULT_TEST_ITERATIONS)
}

pub fn set_skip_tests(tests: Vec<String>) {
    let _ = SKIP_TESTS.set(tests.into_iter().collect());
}

/// When called, only the listed tests will be executed; all others are skipped.
pub fn set_only_tests(tests: Vec<String>) {
    let _ = ONLY_TESTS.set(tests.into_iter().collect());
}

/// When called, only the listed features will be executed; all others are skipped.
pub fn set_only_features(features: Vec<String>) {
    let _ = ONLY_FEATURES.set(features.into_iter().collect());
}

fn should_skip_test(name: &str) -> bool {
    // If an allow-list is set, skip everything not in it
    if let Some(only) = ONLY_TESTS.get()
        && !only.contains(name)
    {
        return true;
    }
    SKIP_TESTS.get().map(|s| s.contains(name)).unwrap_or(false)
}

pub fn should_skip_feature(name: &str) -> bool {
    // If an allow-list is set, skip everything not in it
    if let Some(only) = ONLY_FEATURES.get()
        && !only.contains(name)
    {
        return true;
    }
    false
}

pub fn request_stop() {
    STOP_REQUESTED.store(true, Ordering::Relaxed);
}

pub fn should_stop() -> bool {
    STOP_REQUESTED.load(Ordering::Relaxed)
}

pub fn reset_stop_flag() {
    STOP_REQUESTED.store(false, Ordering::Relaxed);
}

pub type TestFunction = (dyn Fn() -> Result<(), String> + Send + Sync + 'static);

#[allow(dead_code)]
pub trait ExtensionTest {
    fn get_name() -> &'static str;
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)];

    fn test() -> Result<(usize, usize, usize), String> {
        Self::test_with_progress(1, 0, Self::get_tests().len(), None)
    }

    fn test_with_progress(
        total_features: usize,
        completed_features: usize,
        total_tests: usize,
        progress_callback: Option<&ProgressCallback>,
    ) -> Result<(usize, usize, usize), String> {
        info!("Checking {} support", Self::get_name());
        let mut run = 0usize;
        let mut skipped = 0usize;
        let mut errors = 0usize;

        let tests = Self::get_tests();

        for (idx, (fun, name)) in tests.iter().enumerate() {
            if should_stop() {
                info!("Stop requested, halting {} tests", Self::get_name());
                return Ok((run, skipped, errors));
            }

            if should_skip_test(name) {
                skipped += 1;
                continue;
            }

            if let Some(callback) = progress_callback {
                callback(&TestProgress {
                    total_features,
                    completed_features,
                    current_feature: Self::get_name(),
                    total_tests_in_feature: total_tests,
                    completed_tests_in_feature: idx,
                    current_test: name,
                    fuzzing_iteration: 0,
                    total_fuzzing_iterations: 0,
                });
            }

            run += 1;
            info!("Running {}", name);

            match fun() {
                Ok(_) => info!("{} passed", name),
                Err(e) => {
                    error!("{}({}) failed: {}", name, Self::get_name(), e);
                    errors += 1;
                }
            }
        }

        info!("___________________{} test passed", Self::get_name());
        Ok((run, skipped, errors))
    }
}
