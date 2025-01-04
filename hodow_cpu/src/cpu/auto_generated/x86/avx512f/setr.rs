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
fn test_x86_avx512f_mm512_setr_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_setr_epi32(1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_setr_epi32(1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_setr_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_setr_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_setr_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_setr_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_setr_epi64(1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_setr_epi64(1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_setr_epi64(rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_setr_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_setr_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_setr_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_setr_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_setr_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_setr_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_setr_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_setr_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64, 5.0f64, 6.0f64, 7.0f64, 8.0f64));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_setr_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64, 5.0f64, 6.0f64, 7.0f64, 8.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_setr_pd(rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_setr_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_setr_pd_impl() }
}
