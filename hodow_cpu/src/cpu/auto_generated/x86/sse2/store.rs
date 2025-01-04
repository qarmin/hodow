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
fn test_x86_sse2_mm_store_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([5, 6, 7, 8]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[5, 6, 7, 8, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, -1, 2, -3, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 200, 300, 400, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        _mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_store_si128(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_sd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_sd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 200.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_store_pd1_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_store_pd1(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_store_pd1_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_store_pd1_boundary_mixed_impl() }
}
