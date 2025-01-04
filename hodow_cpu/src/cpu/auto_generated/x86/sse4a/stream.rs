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

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_sd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_stream_sd(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_sd(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_stream_ss_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm_stream_ss(ptr_p.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_p);
        let result = core::ptr::read(ptr_p.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_ss(ptr_p.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_stream_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_stream_ss_boundary_mixed_impl() }
}
