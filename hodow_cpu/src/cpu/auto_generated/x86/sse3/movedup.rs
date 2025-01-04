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

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_normal2_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_normal3_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_movedup_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_movedup_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_movedup_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movedup_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse3_mm_movedup_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse3_mm_movedup_pd_boundary_mixed_impl() }
}
