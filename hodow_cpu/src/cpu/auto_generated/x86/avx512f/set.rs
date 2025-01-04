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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_set_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8, 17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8, 33i8, 34i8, 35i8, 36i8, 37i8, 38i8, 39i8, 40i8, 41i8, 42i8, 43i8, 44i8, 45i8, 46i8, 47i8, 48i8, 49i8, 50i8, 51i8, 52i8, 53i8, 54i8, 55i8, 56i8, 57i8, 58i8, 59i8, 60i8, 61i8, 62i8, 63i8, 64i8));
        check_array_equality(&result, &[64, 63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8, 17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8, 33i8, 34i8, 35i8, 36i8, 37i8, 38i8, 39i8, 40i8, 41i8, 42i8, 43i8, 44i8, 45i8, 46i8, 47i8, 48i8, 49i8, 50i8, 51i8, 52i8, 53i8, 54i8, 55i8, 56i8, 57i8, 58i8, 59i8, 60i8, 61i8, 62i8, 63i8, 64i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set_epi8(rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_set_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16, 17i16, 18i16, 19i16, 20i16, 21i16, 22i16, 23i16, 24i16, 25i16, 26i16, 27i16, 28i16, 29i16, 30i16, 31i16, 32i16));
        check_array_equality(&result, &[32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16, 17i16, 18i16, 19i16, 20i16, 21i16, 22i16, 23i16, 24i16, 25i16, 26i16, 27i16, 28i16, 29i16, 30i16, 31i16, 32i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set_epi16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_set_epi64(1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64));
        check_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set_epi64(1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set_epi64(rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_set_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32));
        check_float_array_equality(&result, &[16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_set_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set_epi32(1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32));
        check_array_equality(&result, &[16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set_epi32(1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_set_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64, 5.0f64, 6.0f64, 7.0f64, 8.0f64));
        check_float_array_equality(&result, &[8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_set_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64, 5.0f64, 6.0f64, 7.0f64, 8.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set_pd(rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set_pd_impl() }
}
