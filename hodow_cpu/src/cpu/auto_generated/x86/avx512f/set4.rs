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
fn test_x86_avx512f_mm512_set4_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set4_epi32(1i32, 2i32, 3i32, 4i32));
        check_array_equality(&result, &[4, 3, 2, 1, 4, 3, 2, 1, 4, 3, 2, 1, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set4_epi32(1i32, 2i32, 3i32, 4i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set4_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set4_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set4_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set4_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_set4_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32));
        check_float_array_equality(&result, &[4.0, 3.0, 2.0, 1.0, 4.0, 3.0, 2.0, 1.0, 4.0, 3.0, 2.0, 1.0, 4.0, 3.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_set4_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set4_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set4_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set4_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set4_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_set4_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64));
        check_float_array_equality(&result, &[4.0, 3.0, 2.0, 1.0, 4.0, 3.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_set4_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set4_pd(rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set4_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set4_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set4_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_set4_epi64(1i64, 2i64, 3i64, 4i64));
        check_array_equality(&result, &[4, 3, 2, 1, 4, 3, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set4_epi64(1i64, 2i64, 3i64, 4i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set4_epi64(rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set4_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set4_epi64_impl() }
}
