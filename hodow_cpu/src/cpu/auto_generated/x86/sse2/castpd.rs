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
fn test_x86_sse2_mm_castpd_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castpd_ps(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 1.875, 0.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_ps(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_ps(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_ps_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, -1074790400]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 1079574528, 0, 1080623104]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-1, -1048577, -1, -1048577]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[-1, 2146435071, -1, 2146435071]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 2146959360, 0, 2146959360]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castpd_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castpd_si128(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 2146435072, 0, -1048576]).map_err(|e| crate::cpu::with_call(e, "_mm_castpd_si128(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castpd_si128(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castpd_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castpd_si128_boundary_mixed_impl() }
}
