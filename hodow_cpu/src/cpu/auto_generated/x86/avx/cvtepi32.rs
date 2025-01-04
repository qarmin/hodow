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
fn test_x86_avx_mm256_cvtepi32_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_cvtepi32_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi32_pd(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi32_pd(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_cvtepi32_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_cvtepi32_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_cvtepi32_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cvtepi32_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi32_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi32_ps(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_cvtepi32_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_cvtepi32_ps_impl() }
}
