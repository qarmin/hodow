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
fn test_x86_sse2_mm_set_epi64x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_set_epi64x(1i64, 2i64));
        check_array_equality(&result, &[2, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_set_epi64x(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_epi64x(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_epi64x() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_epi64x_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_set_epi32(1i32, 2i32, 3i32, 4i32));
        check_array_equality(&result, &[4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_set_epi32(1i32, 2i32, 3i32, 4i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_epi32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_set_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16));
        check_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_set_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_epi16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_epi16_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_set_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8));
        check_array_equality(&result, &[16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_set_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_epi8(rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_epi8_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set_sd(1.0f64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_set_sd(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_sd(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_sd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set_pd1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set_pd1(1.0f64));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_set_pd1(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_pd1(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_pd1() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_pd1_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_set_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_set_pd(1.0f64, 2.0f64));
        check_float_array_equality(&result, &[2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_set_pd(1.0f64, 2.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_set_pd(rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_set_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_set_pd_impl() }
}
