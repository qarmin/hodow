#![allow(dead_code)]
#![allow(unused_imports)]

use std::fmt::Debug;

use log::{error, info};
use once_cell::sync::OnceCell;

#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "aes"))]
mod aes;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx"))]
mod avx;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx2"))]
mod avx2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512bf16"))]
mod avx512bf16;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512bitalg"))]
mod avx512bitalg;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512cd"))]
mod avx512cd;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512f"))]
mod avx512f;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512ifma"))]
mod avx512ifma;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512vbmi"))]
mod avx512vbmi;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "fma"))]
mod fma;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "kl"))]
mod kl;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse"))]
mod sse1;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse2"))]
mod sse2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse3"))]
mod sse3;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4.1"))]
mod sse4_1;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4.2"))]
mod sse4_2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "ssse3"))]
mod ssse3;

#[cfg(miri)]
pub const DEFAULT_TEST_ITERATIONS: usize = 20;
#[cfg(not(miri))]
#[allow(dead_code)]
pub const DEFAULT_TEST_ITERATIONS: usize = 100;

static ITERATIONS: OnceCell<usize> = OnceCell::new();

pub fn set_iterations(n: usize) {
    let _ = ITERATIONS.set(n);
}

pub fn get_iterations() -> usize {
    *ITERATIONS.get().unwrap_or(&DEFAULT_TEST_ITERATIONS)
}

pub type TestFunction = dyn Fn() -> Result<(), String>;

#[allow(dead_code)]
pub trait ExtensionTest {
    fn get_name() -> &'static str;
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)];
    fn test() -> Result<(), String> {
        info!("Checking {} support", Self::get_name());
        for (fun, name) in Self::get_tests() {
            info!("Running {}", name);
            match fun() {
                Ok(_) => info!("{} passed", name),
                Err(e) => error!("{} failed: {}", name, e),
            }
        }
        info!("___________________{} test passed", Self::get_name());
        Ok(())
    }
}

pub fn test_all_extensions() -> Result<(), String> {
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        #[cfg(target_feature = "sse")]
        {
            if std::arch::is_x86_feature_detected!("sse") {
                crate::cpu::sse1::SSE1::test()?;
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            if std::arch::is_x86_feature_detected!("sse2") {
                crate::cpu::sse2::SSE2::test()?;
            }
        }

        #[cfg(target_feature = "sse3")]
        {
            if std::arch::is_x86_feature_detected!("sse3") {
                crate::cpu::sse3::SSE3::test()?;
            }
        }

        #[cfg(target_feature = "ssse3")]
        {
            if std::arch::is_x86_feature_detected!("ssse3") {
                crate::cpu::ssse3::SSSE3::test()?;
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            if std::arch::is_x86_feature_detected!("sse4.1") {
                crate::cpu::sse4_1::SSE41::test()?;
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            if std::arch::is_x86_feature_detected!("sse4.2") {
                crate::cpu::sse4_2::SSE42::test()?;
            }
        }

        #[cfg(target_feature = "avx")]
        {
            if std::arch::is_x86_feature_detected!("avx") {
                crate::cpu::avx::AVX::test()?;
            }
        }

        #[cfg(target_feature = "avx2")]
        {
            if std::arch::is_x86_feature_detected!("avx2") {
                crate::cpu::avx2::AVX2::test()?;
            }
        }

        #[cfg(target_feature = "fma")]
        {
            if std::arch::is_x86_feature_detected!("fma") {
                crate::cpu::fma::FMA::test()?;
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            if std::arch::is_x86_feature_detected!("avx512f") {
                crate::cpu::avx512f::AVX512F::test()?;
            }
        }

        #[cfg(target_feature = "avx512bitalg")]
        {
            if std::arch::is_x86_feature_detected!("avx512bitalg") {
                crate::cpu::avx512bitalg::AVX512BITALG::test()?;
            }
        }

        #[cfg(target_feature = "avx512bf16")]
        {
            if std::arch::is_x86_feature_detected!("avx512bf16") {
                crate::cpu::avx512bf16::AVX512BF16::test()?;
            }
        }

        #[cfg(target_feature = "avx512cd")]
        {
            if std::arch::is_x86_feature_detected!("avx512cd") {
                crate::cpu::avx512cd::AVX512CD::test()?;
            }
        }

        #[cfg(target_feature = "avx512ifma")]
        {
            if std::arch::is_x86_feature_detected!("avx512ifma") {
                crate::cpu::avx512ifma::AVX512IFMA::test()?;
            }
        }

        #[cfg(target_feature = "avx512vbmi")]
        {
            if std::arch::is_x86_feature_detected!("avx512vbmi") {
                crate::cpu::avx512vbmi::AVX512VBMI::test()?;
            }
        }

        #[cfg(target_feature = "aes")]
        {
            if std::arch::is_x86_feature_detected!("aes") {
                crate::cpu::aes::AES::test()?;
            }
        }

        #[cfg(target_feature = "kl")]
        {
            if std::arch::is_x86_feature_detected!("kl") {
                crate::cpu::kl::KL::test()?;
            }
        }
    }

    #[cfg(not(any(target_arch = "x86", target_arch = "x86_64")))]
    {
        info!("CPU extension tests are only available on x86/x86_64 architectures");
    }

    Ok(())
}

#[allow(dead_code)]
fn check_f32_array_equality(a: &[f32], b: &[f32]) -> Result<(), String> {
    if a.len() != b.len() {
        return Err(format!("Arrays have different lengths: {} and {}", a.len(), b.len()));
    }

    for i in 0..a.len() {
        if a[i].is_infinite() && !b[i].is_infinite() {
            return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
        } else if a[i].is_nan() && !b[i].is_nan() {
            return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
        } else if (a[i] - b[i]).abs() > 0.001 {
            return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
        }
    }

    Ok(())
}

#[allow(dead_code)]
fn check_f64_array_equality(a: &[f64], b: &[f64]) -> Result<(), String> {
    if a.len() != b.len() {
        return Err(format!("Arrays have different lengths: {} and {}", a.len(), b.len()));
    }

    for i in 0..a.len() {
        if a[i].is_infinite() && !b[i].is_infinite() {
            return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
        } else if a[i].is_nan() && !b[i].is_nan() {
            return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
        } else if (a[i] - b[i]).abs() > 0.001 {
            return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
        }
    }

    Ok(())
}

fn check_int_array_equality<T: PartialEq + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
    if a.len() != b.len() {
        return Err(format!("Arrays have different lengths: {} and {}", a.len(), b.len()));
    }

    for i in 0..a.len() {
        if a[i] != b[i] {
            return Err(format!("Got {a:?}, expected {b:?}"));
        }
    }

    Ok(())
}

#[allow(dead_code)]
pub const DEFAULT_FLOAT_DIFF: f32 = 0.001;
#[allow(dead_code)]
fn check_float_equality(a: f32, b: f32, max_diff: f32) -> Result<(), String> {
    if a.is_infinite() && !b.is_infinite() {
        return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
    } else if a.is_nan() && !b.is_nan() {
        return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
    } else if (a - b).abs() > max_diff {
        return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
    }

    Ok(())
}
pub fn check_int_equality<T: PartialEq + Debug>(a: T, b: T) -> Result<(), String> {
    if a != b {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}
#[allow(unused)]
pub fn check_int_equality_with_error(a: i32, b: i32, error: i32) -> Result<(), String> {
    if (a != b) && ((a > b && a - error > b) || (a < b && a + error < b)) {
        return Err(format!("Got {a:?}, expected {b:?}"));
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
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            modes.push("avx512bf16");
        }
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
