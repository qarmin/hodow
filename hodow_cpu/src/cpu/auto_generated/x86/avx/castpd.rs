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
fn test_x86_avx_mm256_castpd_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castpd_ps(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.0, 1.875, 0.0, 2.0, 0.0, 2.125, 0.0, 2.25]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_ps(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_ps(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824, 0, 1074266112, 0, 1074790400]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_array_equality(&result, &[0, 0, 0, -1074790400, 0, 1073741824, 0, -1073217536]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_array_equality(&result, &[0, 1079574528, 0, 1080623104, 0, 1081262080, 0, 1081671680]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-1, -1048577, -1, -1048577, -1, -1048577, -1, -1048577]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_array_equality(&result, &[-1, 2146435071, -1, 2146435071, -1, 2146435071, -1, 2146435071]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 2146959360, 0, 2146959360, 0, 2146959360, 0, 2146959360]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castpd_si256_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_castpd_si256(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[0, 2146435072, 0, -1048576, 0, -2147483648, 0, 524288]).map_err(|e| crate::cpu::with_call(e, "_mm256_castpd_si256(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castpd_si256(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castpd_si256_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castpd_si256_boundary_mixed_impl() }
}
