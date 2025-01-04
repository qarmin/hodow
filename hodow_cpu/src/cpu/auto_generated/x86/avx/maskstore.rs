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
fn test_x86_avx_mm256_maskstore_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([10.0, 11.0, 12.0, 13.0]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([0.0, 0.0, 0.0, 0.0]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        _mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([6.0, 7.0]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_maskstore_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_maskstore_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_maskstore_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([6.0, 7.0, 8.0, 9.0]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_maskstore_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_maskstore_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_maskstore_ps_boundary_mixed_impl() }
}
