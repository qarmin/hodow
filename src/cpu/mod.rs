use log::{error, info};

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::sse1::SSE1;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::sse2::SSE2;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::sse3::SSE3;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::ssse3::SSSE3;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::sse4_1::SSE41;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::sse4_2::SSE42;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::avx::AVX;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::avx2::AVX2;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
use crate::cpu::fma::FMA;

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod sse1;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod sse2;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod sse3;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod ssse3;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod sse4_1;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod sse4_2;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod avx;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod avx2;
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod fma;

#[cfg(miri)]
pub const DEFAULT_TEST_ITERATIONS: usize = 20;
#[cfg(not(miri))]
#[allow(dead_code)]
pub const DEFAULT_TEST_ITERATIONS: usize = 100;

#[allow(dead_code)]
pub trait ExtensionTest {
    fn get_name() -> &'static str;
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)];
    fn test() -> Result<(), String> {
        info!("Checking {} support", Self::get_name());
        for (fun, name) in Self::get_tests() {
            info!("Running {}", name);
            match fun() {
                Ok(_) => info!("{} passed", name),
                Err(e) => error!("{} failed: {}", name, e),
            }
        }
        info!("{} test passed", Self::get_name());
        Ok(())
    }
}

pub fn test_all_extensions() -> Result<(), String> {
    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        if std::arch::is_x86_feature_detected!("sse") {
            SSE1::test()?;
        }

        if std::arch::is_x86_feature_detected!("sse2") {
            SSE2::test()?;
        }

        if std::arch::is_x86_feature_detected!("sse3") {
            SSE3::test()?;
        }

        if std::arch::is_x86_feature_detected!("ssse3") {
            SSSE3::test()?;
        }

        if std::arch::is_x86_feature_detected!("sse4.1") {
            SSE41::test()?;
        }

        if std::arch::is_x86_feature_detected!("sse4.2") {
            SSE42::test()?;
        }

        if std::arch::is_x86_feature_detected!("avx") {
            AVX::test()?;
        }

        if std::arch::is_x86_feature_detected!("avx2") {
            AVX2::test()?;
        }

        if std::arch::is_x86_feature_detected!("fma") {
            FMA::test()?;
        }
    }

    #[cfg(not(any(target_arch = "x86", target_arch = "x86_64")))]
    {
        info!("CPU extension tests are only available on x86/x86_64 architectures");
    }

    Ok(())
}

#[allow(dead_code)]
fn check_array_equality(a: &[f32], b: &[f32]) -> Result<(), String> {
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
#[allow(unused)]
pub fn check_int_equality(a: i32, b: i32) -> Result<(), String> {
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