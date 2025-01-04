use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_64_sse_mm_cvtsi64_ss_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi64_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse_mm_cvtsi64_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse_mm_cvtsi64_ss_boundary_mixed_impl() }
}
