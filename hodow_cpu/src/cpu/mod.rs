#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]
#![allow(unused)]

use std::collections::HashSet;
use std::sync::OnceLock;
use std::sync::atomic::{AtomicBool, Ordering};

use log::{error, info};

#[cfg(feature = "cpu_suite")]
pub mod auto_generated;
#[cfg(not(feature = "cpu_suite"))]
#[path = "no_suite.rs"]
pub mod auto_generated;
pub(crate) mod common;

pub use auto_generated::coverage::{coverage, coverage_source, drop_reasons};
pub use auto_generated::registry::{
    available_modes, count_available_features, extension_status, list_all_functions, test_all_extensions,
};
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
    /// Of `tests_run`, the ones that asserted nothing - see [`Verdict::Unverified`].
    pub tests_unverified: usize,
    /// Of `tests_unverified`, the ones that observed a value `capture_expected.py` can turn
    /// into a real expectation. The rest have no checkable result at all and stay unverified
    /// on every machine, so a report that lumps the two together suggests a fix that does not
    /// exist for them.
    pub tests_capturable: usize,
    /// One `test(feature): message` line per failed test, for the end-of-run summary.
    pub failures: Vec<String>,
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

    pub fn total_unverified(&self) -> usize {
        self.features.iter().map(|f| f.tests_unverified).sum()
    }

    pub fn failures(&self) -> impl Iterator<Item = &str> {
        self.features.iter().flat_map(|f| f.failures.iter().map(String::as_str))
    }

    pub fn total_capturable(&self) -> usize {
        self.features.iter().map(|f| f.tests_capturable).sum()
    }
}

pub type ProgressCallback = dyn Fn(&TestProgress) + Send + Sync;

#[cfg(miri)]
pub const DEFAULT_TEST_ITERATIONS: usize = 0;
#[cfg(not(miri))]
#[allow(dead_code)]
pub const DEFAULT_TEST_ITERATIONS: usize = 0;

static ITERATIONS: OnceLock<usize> = OnceLock::new();
static SKIP_TESTS: OnceLock<HashSet<String>> = OnceLock::new();
/// When set, only tests whose names appear in this set will be run.
static ONLY_TESTS: OnceLock<HashSet<String>> = OnceLock::new();
/// When set, only features whose names appear in this set will be run.
static ONLY_FEATURES: OnceLock<HashSet<String>> = OnceLock::new();
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

/// Combined `-t`/`-e`/`-s` filter check for callers that only have a flat
/// `(test_name, feature, fn)` list (e.g. the isolated-subprocess and stress runners), which
/// can't go through `ExtensionTest::test_with_progress`'s per-extension dispatch.
pub fn should_skip_test_or_feature(name: &str, feature: &str) -> bool {
    should_skip_test(name) || should_skip_feature(feature)
}

pub fn request_stop() {
    STOP_REQUESTED.store(true, Ordering::Relaxed);
}

pub fn should_stop() -> bool {
    STOP_REQUESTED.load(Ordering::Relaxed)
}

/// The fuzz loop every generated test ends with; one copy here instead of one per test.
pub fn fuzz(body: &mut dyn FnMut()) {
    let total_iters = get_iterations();
    if crate::get_fuzzing() && total_iters > 0 {
        log::info!("Starting fuzzing");
        for i in 0..total_iters {
            if i % 1000 == 0 && should_stop() {
                log::info!("Fuzzing stopped at iteration {}", i);
                break;
            }
            body();
        }
    }
}

/// The failure path of every generated check, kept out of line so it is not repeated per test.
#[cold]
#[inline(never)]
pub fn with_call(error: String, call: &str) -> String {
    format!("{error} | call: {call}")
}

pub fn reset_stop_flag() {
    STOP_REQUESTED.store(false, Ordering::Relaxed);
}

/// What a test established, beyond "it did not fail".
///
/// A test with no captured expected value used to assert against a zero placeholder, which
/// is not a verdict in either direction: it invented failures wherever the correct answer is
/// non-zero (every TBM intrinsic on an Excavator) and, worse, invented passes wherever the
/// correct answer happens to be zero - and the report could not tell those apart from a real
/// comparison against hardware. `data/cpu/expected/<arch>/<ext>.txt` cannot disambiguate them
/// either, since `capture_expected.py` only ever records a *mismatch*, so a genuinely-zero
/// result is never written down and looks exactly like one that was never run anywhere.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Verdict {
    /// The result was compared against a value captured on real hardware.
    Checked,
    /// The call ran without crashing, but its result was compared against nothing.
    /// `Some(value)` is what it returned, formatted so `capture_expected.py` can turn it into
    /// an expectation; `None` is a test that has no value to check at all (a `()` return, or
    /// `skip_result_check` in `function_policy.toml` - a machine-identity fact like `__cpuid`,
    /// where no captured constant could ever be valid on another machine).
    Unverified(Option<String>),
    /// The body returned before executing anything: a feature guard beyond the group's own
    /// base feature said no (`_xsavec` on an XSAVE-only CPU), or Miri cannot run the
    /// intrinsic. This used to be an `Ok(())`, i.e. a reported pass for a test that never ran.
    Skipped(&'static str),
}

/// A plain function pointer: a registry of 100k+ trait objects costs a vtable and several
/// load-time relocations apiece.
pub type TestFunction = fn() -> Result<Verdict, String>;

pub type TestEntry = (&'static str, &'static str, TestFunction);

static EXTRA_TESTS: std::sync::OnceLock<fn() -> Vec<TestEntry>> = std::sync::OnceLock::new();

/// Registers a provider of tests that live outside this crate (the processing flows, which need `hodow_bench`).
/// Asked on every `all_tests()` call, so it can decide at run time whether to contribute anything. Parent and isolated
/// worker must register the same provider, or their test indices disagree.
pub fn set_extra_tests(provider: fn() -> Vec<TestEntry>) {
    let _ = EXTRA_TESTS.set(provider);
}

/// The generated instruction tests plus whatever the registered provider adds, as a flat `(name, feature, fn)` list.
pub fn all_tests() -> Vec<TestEntry> {
    let mut tests = auto_generated::registry::all_tests();
    if let Some(provider) = EXTRA_TESTS.get() {
        tests.extend(provider());
    }
    tests
}

/// One row of `extension_status()`.
pub struct ExtensionStatus {
    pub arch: &'static str,
    pub ext: &'static str,
    pub test_count: usize,
    /// Detected on this machine at runtime.
    pub supported: bool,
    /// Whether a runtime check exists at all. `false` for extensions with no
    /// `is_*_feature_detected!` string (`UNSUPPORTED_FEATURES` in the generator, e.g. `rdtsc`,
    /// `cpuid`) - compiled in but never run anywhere, which is not the same as "this CPU
    /// lacks it".
    pub detectable: bool,
    /// Left out of this binary by a Cargo feature (`avx512`); `test_count` is 0 then, and
    /// `supported` still says whether this machine has it.
    pub compiled_out: bool,
}

/// One intrinsic stdarch declares that this binary has no test for, and why.
pub struct DroppedFunction {
    pub name: &'static str,
    /// Short slug the report groups by, e.g. `unstable-type` or `excluded:privileged`.
    pub reason: &'static str,
    /// The full explanation, for a `-v` listing.
    pub detail: &'static str,
}

/// One row of [`coverage`]: how much of an extension stdarch declares became a test here.
///
/// Every architecture is present, not only the one this binary was compiled for - the counts
/// come from the generator, which reads all of stdarch, so "what would ARM32 NEON coverage
/// look like" is answerable from an x86 build.
pub struct ExtensionCoverage {
    pub arch: &'static str,
    pub ext: &'static str,
    /// Functions stdarch declares in this group.
    pub discovered: usize,
    /// Of those, ones a test was generated for.
    pub generated: usize,
    /// Test functions that produced (one function expands into several scenarios).
    pub tests: usize,
    pub dropped: &'static [DroppedFunction],
}

#[allow(dead_code)]
pub trait ExtensionTest {
    fn get_name() -> &'static str;
    fn get_tests() -> &'static [(TestFunction, &'static str)];

    fn test() -> Result<FeatureStats, String> {
        Self::test_with_progress(1, 0, Self::get_tests().len(), None)
    }

    fn test_with_progress(
        total_features: usize,
        completed_features: usize,
        total_tests: usize,
        progress_callback: Option<&ProgressCallback>,
    ) -> Result<FeatureStats, String> {
        info!("Checking {} support", Self::get_name());
        let mut run = 0usize;
        let mut skipped = 0usize;
        let mut errors = 0usize;
        let mut unverified = 0usize;
        let mut capturable = 0usize;
        let mut failures: Vec<String> = Vec::new();
        let stats = |run, skipped, errors, unverified, capturable, failures: Vec<String>| FeatureStats {
            feature_name: Self::get_name(),
            tests_run: run,
            tests_skipped: skipped,
            tests_errored: errors,
            tests_unverified: unverified,
            tests_capturable: capturable,
            failures,
        };

        let tests = Self::get_tests();

        for (idx, (fun, name)) in tests.iter().enumerate() {
            if should_stop() {
                info!("Stop requested, halting {} tests", Self::get_name());
                return Ok(stats(run, skipped, errors, unverified, capturable, failures));
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
                Ok(Verdict::Checked) => info!("{} passed", name),
                Ok(Verdict::Unverified(value)) => {
                    unverified += 1;
                    match value {
                        Some(v) => {
                            capturable += 1;
                            info!(
                                "{}({}) unverified: nothing to compare against, got {}",
                                name,
                                Self::get_name(),
                                v
                            );
                        }
                        None => info!("{}({}) unverified: no checkable result", name, Self::get_name()),
                    }
                }
                Ok(Verdict::Skipped(why)) => {
                    run -= 1;
                    skipped += 1;
                    info!("{} skipped: {}", name, why);
                }
                Err(e) => {
                    error!("{}({}) failed: {}", name, Self::get_name(), e);
                    failures.push(format!("{}({}): {}", name, Self::get_name(), e));
                    errors += 1;
                }
            }
        }

        info!("___________________{} test passed", Self::get_name());
        Ok(stats(run, skipped, errors, unverified, capturable, failures))
    }
}
