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
fn test_x86_sse2_mm_set1_epi64x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_set1_epi64x(1i64));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_set1_epi64x(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set1_epi64x(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set1_epi64x() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set1_epi64x_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set1_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_set1_epi32(1i32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_set1_epi32(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set1_epi32(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set1_epi32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set1_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_set1_epi16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_set1_epi16(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set1_epi16(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set1_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set1_epi16_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set1_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_set1_epi8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_set1_epi8(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set1_epi8(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set1_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set1_epi8_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set1_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set1_pd(1.0f64));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_set1_pd(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set1_pd(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set1_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set1_pd_impl() }
}
