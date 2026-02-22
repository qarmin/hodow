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

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
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

fn should_skip_test(name: &str) -> bool {
    SKIP_TESTS.get().map(|s| s.contains(name)).unwrap_or(false)
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

            #[cfg(feature = "gpu")]
            {
                match crate::opengl::gui::GuiRuntimeHandle::with_window(None, || fun()) {
                    Ok(_) => info!("{} passed", name),
                    Err(e) => {
                        // Convert error into string if possible
                        error!("{}({}) failed: {}", name, Self::get_name(), e);
                        errors += 1;
                    }
                }
            }

            #[cfg(not(feature = "gpu"))]
            {
                match fun() {
                    Ok(_) => info!("{} passed", name),
                    Err(e) => {
                        error!("{}({}) failed: {}", name, Self::get_name(), e);
                        errors += 1;
                    }
                }
            }


        }

        info!("___________________{} test passed", Self::get_name());
        Ok((run, skipped, errors))
    }
}

fn count_available_features() -> usize {
    let mut count = 0;
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            count += 1;
        }

        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            count += 1;
        }

        #[cfg(target_feature = "sse3")]
        if std::arch::is_x86_feature_detected!("sse3") {
            count += 1;
        }

        #[cfg(target_feature = "ssse3")]
        if std::arch::is_x86_feature_detected!("ssse3") {
            count += 1;
        }

        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            count += 1;
        }

        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            count += 1;
        }

        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            count += 1;
        }

        #[cfg(target_feature = "avx2")]
        if std::arch::is_x86_feature_detected!("avx2") {
            count += 1;
        }

        #[cfg(target_feature = "fma")]
        if std::arch::is_x86_feature_detected!("fma") {
            count += 1;
        }

        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            count += 1;
        }

        #[cfg(target_feature = "avx512bitalg")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            count += 1;
        }

        #[cfg(target_feature = "avx512cd")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            count += 1;
        }

        #[cfg(target_feature = "aes")]
        if std::arch::is_x86_feature_detected!("aes") {
            count += 1;
        }
    }
    count
}

pub fn test_all_extensions(progress_callback: Option<&ProgressCallback>) -> Result<TestStatistics, String> {
    reset_stop_flag();

    let total_features = count_available_features();
    let mut completed_features = 0;
    let mut features = Vec::new();

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        #[cfg(target_feature = "sse")]
        {
            if std::arch::is_x86_feature_detected!("sse") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::sse::SSE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::sse::SSE::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::sse::SSE::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            if std::arch::is_x86_feature_detected!("sse2") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::sse2::SSE2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::sse2::SSE2::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::sse2::SSE2::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse3")]
        {
            if std::arch::is_x86_feature_detected!("sse3") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::sse3::SSE3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::sse3::SSE3::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::sse3::SSE3::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "ssse3")]
        {
            if std::arch::is_x86_feature_detected!("ssse3") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::ssse3::SSSE3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::ssse3::SSSE3::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::ssse3::SSSE3::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            if std::arch::is_x86_feature_detected!("sse4.1") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::sse41::SSE41::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::sse41::SSE41::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::sse41::SSE41::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            if std::arch::is_x86_feature_detected!("sse4.2") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::sse42::SSE42::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::sse42::SSE42::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::sse42::SSE42::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx")]
        {
            if std::arch::is_x86_feature_detected!("avx") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx::AVX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx::AVX::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx::AVX::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx2")]
        {
            if std::arch::is_x86_feature_detected!("avx2") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx2::AVX2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx2::AVX2::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx2::AVX2::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "fma")]
        {
            if std::arch::is_x86_feature_detected!("fma") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::fma::FMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::fma::FMA::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::fma::FMA::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            if std::arch::is_x86_feature_detected!("avx512f") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx512f::AVX512F::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx512f::AVX512F::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx512f::AVX512F::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512bitalg")]
        {
            if std::arch::is_x86_feature_detected!("avx512bitalg") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx512bitalg::AVX512BITALG::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx512bitalg::AVX512BITALG::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx512bitalg::AVX512BITALG::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        // TODO, unstable - https://github.com/rust-lang/rust/issues/127356
        // #[cfg(target_feature = "avx512bf16")]
        // {
        //     if std::arch::is_x86_feature_detected!("avx512bf16") {
        //         if should_stop() {
        //             return Ok(TestStatistics { features, was_cancelled: true });
        //         }
        //         let (r, s, e) = crate::cpu::auto_generated::avx512bf16::AVX512BF16::test_with_progress(
        //             total_features,
        //             completed_features,
        //             crate::cpu::auto_generated::avx512bf16::AVX512BF16::get_tests().len(),
        //             progress_callback
        //         )?;
        //         features.push(FeatureStats {
        //             feature_name: crate::cpu::auto_generated::avx512bf16::AVX512BF16::get_name(),
        //             tests_run: r,
        //             tests_skipped: s,
        //             tests_errored: e,
        //         });
        //         completed_features += 1;
        //     }
        // }

        #[cfg(target_feature = "avx512cd")]
        {
            if std::arch::is_x86_feature_detected!("avx512cd") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx512cd::AVX512CD::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx512cd::AVX512CD::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx512cd::AVX512CD::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512ifma")]
        {
            if std::arch::is_x86_feature_detected!("avx512ifma") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx512ifma::AVX512IFMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx512ifma::AVX512IFMA::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx512ifma::AVX512IFMA::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512vbmi")]
        {
            if std::arch::is_x86_feature_detected!("avx512vbmi") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::avx512vbmi::AVX512VBMI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::avx512vbmi::AVX512VBMI::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::avx512vbmi::AVX512VBMI::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }

        #[cfg(target_feature = "aes")]
        {
            if std::arch::is_x86_feature_detected!("aes") {
                if should_stop() {
                    return Ok(TestStatistics { features, was_cancelled: true });
                }
                let (r, s, e) = crate::cpu::auto_generated::aes::AES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aes::AES::get_tests().len(),
                    progress_callback,
                )?;
                features.push(FeatureStats {
                    feature_name: crate::cpu::auto_generated::aes::AES::get_name(),
                    tests_run: r,
                    tests_skipped: s,
                    tests_errored: e,
                });
                completed_features += 1;
            }
        }
    }

    #[cfg(not(any(target_arch = "x86", target_arch = "x86_64")))]
    {
        info!("CPU extension tests are only available on x86/x86_64 architectures");
    }

    // To silence unused variable warning
    let _ = completed_features;
    let _ = total_features;

    Ok(TestStatistics {
        features,
        was_cancelled: should_stop(),
    })
}

pub fn available_modes() -> Vec<&'static str> {
    let mut modes = Vec::new();

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        if std::arch::is_x86_feature_detected!("sse") {
            modes.push("sse");
        }
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.push("sse2");
        }
        if std::arch::is_x86_feature_detected!("sse3") {
            modes.push("sse3");
        }
        if std::arch::is_x86_feature_detected!("ssse3") {
            modes.push("ssse3");
        }
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.push("sse4.1");
        }
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.push("sse4.2");
        }
        if std::arch::is_x86_feature_detected!("avx") {
            modes.push("avx");
        }
        if std::arch::is_x86_feature_detected!("avx2") {
            modes.push("avx2");
        }
        if std::arch::is_x86_feature_detected!("fma") {
            modes.push("fma");
        }
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.push("avx512f");
        }
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            modes.push("avx512bitalg");
        }
        // unstable
        // if std::arch::is_x86_feature_detected!("avx512bf16") {
        //     modes.push("avx512bf16");
        // }
        if std::arch::is_x86_feature_detected!("avx512cd") {
            modes.push("avx512cd");
        }
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            modes.push("avx512ifma");
        }
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            modes.push("avx512vbmi");
        }
        if std::arch::is_x86_feature_detected!("aes") {
            modes.push("aes");
        }
    }

    modes
}

pub fn list_all_functions() -> Vec<String> {
    let mut functions = Vec::new();

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        macro_rules! collect_tests {
            ($ext:path) => {
                for (_, name) in <$ext>::get_tests() {
                    functions.push(name.to_string());
                }
            };
        }

        #[cfg(target_feature = "sse")]
        collect_tests!(crate::cpu::auto_generated::sse::SSE);

        #[cfg(target_feature = "sse2")]
        collect_tests!(crate::cpu::auto_generated::sse2::SSE2);

        #[cfg(target_feature = "sse3")]
        collect_tests!(crate::cpu::auto_generated::sse3::SSE3);

        #[cfg(target_feature = "ssse3")]
        collect_tests!(crate::cpu::auto_generated::ssse3::SSSE3);

        #[cfg(target_feature = "sse4.1")]
        collect_tests!(crate::cpu::auto_generated::sse41::SSE41);

        #[cfg(target_feature = "sse4.2")]
        collect_tests!(crate::cpu::auto_generated::sse42::SSE42);

        #[cfg(target_feature = "avx")]
        collect_tests!(crate::cpu::auto_generated::avx::AVX);

        #[cfg(target_feature = "avx2")]
        collect_tests!(crate::cpu::auto_generated::avx2::AVX2);

        #[cfg(target_feature = "fma")]
        collect_tests!(crate::cpu::auto_generated::fma::FMA);

        #[cfg(target_feature = "avx512f")]
        collect_tests!(crate::cpu::auto_generated::avx512f::AVX512F);

        #[cfg(target_feature = "avx512bitalg")]
        collect_tests!(crate::cpu::auto_generated::avx512bitalg::AVX512BITALG);

        #[cfg(target_feature = "avx512cd")]
        collect_tests!(crate::cpu::auto_generated::avx512cd::AVX512CD);

        // #[cfg(target_feature = "avx512ifma")]
        // collect_tests!(crate::cpu::auto_generated::avx512ifma::AVX512IFMA);

        // #[cfg(target_feature = "avx512vbmi")]
        // collect_tests!(crate::cpu::auto_generated::avx512vbmi::AVX512VBMI);

        #[cfg(target_feature = "aes")]
        collect_tests!(crate::cpu::auto_generated::aes::AES);
    }

    functions
}
