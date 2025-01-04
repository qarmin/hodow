use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi64_si128(1i64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_si128(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_si128(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_si128() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi64_sd_boundary_mixed_impl() }
}
