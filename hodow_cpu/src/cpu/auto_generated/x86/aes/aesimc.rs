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

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[185403662, 370807324, 488053522, 741614648]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, -1, 370807324, -370807325]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_normal2_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[-1578997426, 1507840668, 49174936, 1241739946]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_normal3_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1106762476, 1106762476, 1106762476, 1106762476]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_boundary_min_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1106762477, -1106762477, -1106762477, -1106762477]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_boundary_max_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_boundary_zero_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_boundary_allones_impl() }
}

#[target_feature(enable = "aes")]
fn test_x86_aes_mm_aesimc_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_aesimc_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1106762476, -1106762477, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_aesimc_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_aesimc_si128(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_aes_mm_aesimc_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_aes_mm_aesimc_si128_boundary_mixed_impl() }
}
