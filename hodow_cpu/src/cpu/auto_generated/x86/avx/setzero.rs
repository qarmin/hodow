#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setzero_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_setzero_pd());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setzero_pd()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setzero_pd();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setzero_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setzero_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setzero_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_setzero_ps());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setzero_ps()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setzero_ps();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setzero_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setzero_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_setzero_si256_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_setzero_si256());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_setzero_si256()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_setzero_si256();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_setzero_si256() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_setzero_si256_impl() }
}
