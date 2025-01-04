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
fn test_x86_avx_mm256_maskload_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256d_to_f64_array(_mm256_maskload_pd(ptr_mem_addr.0.as_ptr(), mask));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_pd(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskload_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskload_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskload_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128d_to_f64_array(_mm_maskload_pd(ptr_mem_addr.0.as_ptr(), mask));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_pd(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskload_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskload_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskload_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256_to_f32_array(_mm256_maskload_ps(ptr_mem_addr.0.as_ptr(), mask));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_ps(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskload_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskload_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskload_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128_to_f32_array(_mm_maskload_ps(ptr_mem_addr.0.as_ptr(), mask));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_ps(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskload_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskload_ps_impl() }
}
