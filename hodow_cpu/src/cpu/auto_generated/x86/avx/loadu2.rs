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
fn test_x86_avx_mm256_loadu2_m128_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_loadu2_m128(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr()));
        check_float_array_equality(&result, &[2.0, 2.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_loadu2_m128(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_loadu2_m128() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_loadu2_m128_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_loadu2_m128d_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_loadu2_m128d(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr()));
        check_float_array_equality(&result, &[2.0, 2.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_loadu2_m128d(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_loadu2_m128d() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_loadu2_m128d_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_loadu2_m128i_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let result = unpack__m256i_to_i32_array(_mm256_loadu2_m128i(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr()));
        check_array_equality(&result, &[5, 6, 7, 8, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm256_loadu2_m128i(ptr_hiaddr.0.as_ptr(), ptr_loaddr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_loadu2_m128i() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_loadu2_m128i_impl() }
}
