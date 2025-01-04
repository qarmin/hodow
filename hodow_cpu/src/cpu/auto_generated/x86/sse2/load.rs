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

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_load_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let result = unpack__m128i_to_i32_array(_mm_load_si128(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_load_si128(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_load_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_load_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_load_pd(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_load_pd(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_load_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_load_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_load_sd(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_load_sd(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_load_sd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_load_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_load_pd1_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_load_pd1(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_load_pd1(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_load_pd1() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_load_pd1_impl() }
}
