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
fn test_x86_avx_mm256_broadcast_ss_impl() -> Result<Verdict, String> {
    unsafe {
        let ref_f = 1.0f32;
        let result = unpack__m256_to_f32_array(_mm256_broadcast_ss(&ref_f));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_broadcast_ss(&ref_f)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_broadcast_ss() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_broadcast_ss_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_broadcast_ss_impl() -> Result<Verdict, String> {
    unsafe {
        let ref_f = 1.0f32;
        let result = unpack__m128_to_f32_array(_mm_broadcast_ss(&ref_f));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_broadcast_ss(&ref_f)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_broadcast_ss() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_broadcast_ss_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_broadcast_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let ref_f = 1.0f64;
        let result = unpack__m256d_to_f64_array(_mm256_broadcast_sd(&ref_f));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_broadcast_sd(&ref_f)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_broadcast_sd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_broadcast_sd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_broadcast_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ref_a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256_to_f32_array(_mm256_broadcast_ps(&ref_a));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_broadcast_ps(&ref_a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_broadcast_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_broadcast_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_broadcast_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let ref_a = create__m128d_from([1.0, 2.0]);
        let result = unpack__m256d_to_f64_array(_mm256_broadcast_pd(&ref_a));
        check_float_array_equality(&result, &[1.0, 2.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_broadcast_pd(&ref_a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_broadcast_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_broadcast_pd_impl() }
}
