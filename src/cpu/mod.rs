#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]

use std::collections::HashSet;

use log::{error, info};
use once_cell::sync::OnceCell;

#[macro_use]
mod test_macros;

pub(crate) mod common;
pub mod auto_generated;

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
#[allow(unused_imports)]
pub use auto_generated::*;

#[cfg(miri)]
pub const DEFAULT_TEST_ITERATIONS: usize = 0;
#[cfg(not(miri))]
#[allow(dead_code)]
pub const DEFAULT_TEST_ITERATIONS: usize = 0;

static ITERATIONS: OnceCell<usize> = OnceCell::new();
static SKIP_TESTS: OnceCell<HashSet<String>> = OnceCell::new();

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

pub type TestFunction = dyn Fn() -> Result<(), String>;

#[allow(dead_code)]
pub trait ExtensionTest {
    fn get_name() -> &'static str;
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)];
    fn test() -> Result<(usize, usize, usize), String> {
        info!("Checking {} support", Self::get_name());
        let mut run = 0usize;
        let mut skipped = 0usize;
        let mut errors = 0usize;
        for (fun, name) in Self::get_tests() {
            if should_skip_test(name) {
                info!("Skipping {}", name);
                skipped += 1;
                continue;
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

pub fn test_all_extensions() -> Result<(), String> {
    let mut stats: Vec<(&'static str, usize, usize, usize)> = Vec::new();

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        #[cfg(target_feature = "sse")]
        {
            if std::arch::is_x86_feature_detected!("sse") {
                let (r, s, e) = crate::cpu::auto_generated::sse::SSE::test()?;
                stats.push((crate::cpu::auto_generated::sse::SSE::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            if std::arch::is_x86_feature_detected!("sse2") {
                let (r, s, e) = crate::cpu::auto_generated::sse2::SSE2::test()?;
                stats.push((crate::cpu::auto_generated::sse2::SSE2::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "sse3")]
        {
            if std::arch::is_x86_feature_detected!("sse3") {
                let (r, s, e) = crate::cpu::auto_generated::sse3::SSE3::test()?;
                stats.push((crate::cpu::auto_generated::sse3::SSE3::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "ssse3")]
        {
            if std::arch::is_x86_feature_detected!("ssse3") {
                let (r, s, e) = crate::cpu::auto_generated::ssse3::SSSE3::test()?;
                stats.push((crate::cpu::auto_generated::ssse3::SSSE3::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            if std::arch::is_x86_feature_detected!("sse4.1") {
                let (r, s, e) = crate::cpu::auto_generated::sse41::SSE41::test()?;
                stats.push((crate::cpu::auto_generated::sse41::SSE41::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            if std::arch::is_x86_feature_detected!("sse4.2") {
                let (r, s, e) = crate::cpu::auto_generated::sse42::SSE42::test()?;
                stats.push((crate::cpu::auto_generated::sse42::SSE42::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "avx")]
        {
            if std::arch::is_x86_feature_detected!("avx") {
                let (r, s, e) = crate::cpu::auto_generated::avx::AVX::test()?;
                stats.push((crate::cpu::auto_generated::avx::AVX::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "avx2")]
        {
            if std::arch::is_x86_feature_detected!("avx2") {
                let (r, s, e) = crate::cpu::auto_generated::avx2::AVX2::test()?;
                stats.push((crate::cpu::auto_generated::avx2::AVX2::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "fma")]
        {
            if std::arch::is_x86_feature_detected!("fma") {
                let (r, s, e) = crate::cpu::auto_generated::fma::FMA::test()?;
                stats.push((crate::cpu::auto_generated::fma::FMA::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            if std::arch::is_x86_feature_detected!("avx512f") {
                let (r, s, e) = crate::cpu::auto_generated::avx512f::AVX512F::test()?;
                stats.push((crate::cpu::auto_generated::avx512f::AVX512F::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "avx512bitalg")]
        {
            if std::arch::is_x86_feature_detected!("avx512bitalg") {
                let (r, s, e) = crate::cpu::auto_generated::avx512bitalg::AVX512BITALG::test()?;
                stats.push((crate::cpu::auto_generated::avx512bitalg::AVX512BITALG::get_name(), r, s, e));
            }
        }

        // TODO, unstable - https://github.com/rust-lang/rust/issues/127356
        // #[cfg(target_feature = "avx512bf16")]
        // {
        //     if std::arch::is_x86_feature_detected!("avx512bf16") {
        //         let (r, s, e) = crate::cpu::auto_generated::avx512bf16::AVX512BF16::test()?;
        //         stats.push((crate::cpu::auto_generated::avx512bf16::AVX512BF16::get_name(), r, s, e));
        //     }
        // }

        #[cfg(target_feature = "avx512cd")]
        {
            if std::arch::is_x86_feature_detected!("avx512cd") {
                let (r, s, e) = crate::cpu::auto_generated::avx512cd::AVX512CD::test()?;
                stats.push((crate::cpu::auto_generated::avx512cd::AVX512CD::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "avx512ifma")]
        {
            if std::arch::is_x86_feature_detected!("avx512ifma") {
                let (r, s, e) = crate::cpu::auto_generated::avx512ifma::AVX512IFMA::test()?;
                stats.push((crate::cpu::auto_generated::avx512ifma::AVX512IFMA::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "avx512vbmi")]
        {
            if std::arch::is_x86_feature_detected!("avx512vbmi") {
                let (r, s, e) = crate::cpu::auto_generated::avx512vbmi::AVX512VBMI::test()?;
                stats.push((crate::cpu::auto_generated::avx512vbmi::AVX512VBMI::get_name(), r, s, e));
            }
        }

        #[cfg(target_feature = "aes")]
        {
            if std::arch::is_x86_feature_detected!("aes") {
                let (r, s, e) = crate::cpu::auto_generated::aes::AES::test()?;
                stats.push((crate::cpu::auto_generated::aes::AES::get_name(), r, s, e));
            }
        }
    }

    #[cfg(not(any(target_arch = "x86", target_arch = "x86_64")))]
    {
        info!("CPU extension tests are only available on x86/x86_64 architectures");
    }

    if !stats.is_empty() {
        let name_width = stats.iter().map(|(n, _, _, _)| n.len()).max().unwrap_or(0);
        println!("=== Test Statistics ===");
        println!("{:<width$}  {:>4}  {:>7}  {:>6}", "Feature", "Run", "Skipped", "Errors", width = name_width);
        println!("{}", "-".repeat(name_width + 24));
        let mut total_run = 0usize;
        let mut total_skipped = 0usize;
        let mut total_errors = 0usize;
        for (name, run, skipped, errors) in &stats {
            println!("{:<width$}  {:>4}  {:>7}  {:>6}", name, run, skipped, errors, width = name_width);
            total_run += run;
            total_skipped += skipped;
            total_errors += errors;
        }
        println!("{}", "-".repeat(name_width + 24));
        println!("{:<width$}  {:>4}  {:>7}  {:>6}", "TOTAL", total_run, total_skipped, total_errors, width = name_width);
    }

    Ok(())
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

/// Returns a list of all available test function names across all extensions
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

        #[cfg(target_feature = "avx512ifma")]
        collect_tests!(crate::cpu::auto_generated::avx512ifma::AVX512IFMA);

        #[cfg(target_feature = "avx512vbmi")]
        collect_tests!(crate::cpu::auto_generated::avx512vbmi::AVX512VBMI);

        #[cfg(target_feature = "aes")]
        collect_tests!(crate::cpu::auto_generated::aes::AES);
    }

    functions
}

/// Test a single function by name (e.g., "test_mm_add_ps")
pub fn test_single_function(name: &str) -> Result<(), String> {
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        macro_rules! try_test {
            ($ext:path) => {
                for (fun, test_name) in <$ext>::get_tests() {
                    if *test_name == name {
                        info!("Running single test: {}", name);
                        return fun();
                    }
                }
            };
        }

        #[cfg(target_feature = "sse")]
        try_test!(crate::cpu::auto_generated::sse::SSE);

        #[cfg(target_feature = "sse2")]
        try_test!(crate::cpu::auto_generated::sse2::SSE2);

        #[cfg(target_feature = "sse3")]
        try_test!(crate::cpu::auto_generated::sse3::SSE3);

        #[cfg(target_feature = "ssse3")]
        try_test!(crate::cpu::auto_generated::ssse3::SSSE3);

        #[cfg(target_feature = "sse4.1")]
        try_test!(crate::cpu::auto_generated::sse41::SSE41);

        #[cfg(target_feature = "sse4.2")]
        try_test!(crate::cpu::auto_generated::sse42::SSE42);

        #[cfg(target_feature = "avx")]
        try_test!(crate::cpu::auto_generated::avx::AVX);

        #[cfg(target_feature = "avx2")]
        try_test!(crate::cpu::auto_generated::avx2::AVX2);

        #[cfg(target_feature = "fma")]
        try_test!(crate::cpu::auto_generated::fma::FMA);

        #[cfg(target_feature = "avx512f")]
        try_test!(crate::cpu::auto_generated::avx512f::AVX512F);

        #[cfg(target_feature = "avx512bitalg")]
        try_test!(crate::cpu::auto_generated::avx512bitalg::AVX512BITALG);

        #[cfg(target_feature = "avx512cd")]
        try_test!(crate::cpu::auto_generated::avx512cd::AVX512CD);

        #[cfg(target_feature = "avx512ifma")]
        try_test!(crate::cpu::auto_generated::avx512ifma::AVX512IFMA);

        #[cfg(target_feature = "avx512vbmi")]
        try_test!(crate::cpu::auto_generated::avx512vbmi::AVX512VBMI);

        #[cfg(target_feature = "aes")]
        try_test!(crate::cpu::auto_generated::aes::AES);
    }

    Err(format!("Test function '{}' not found", name))
}

