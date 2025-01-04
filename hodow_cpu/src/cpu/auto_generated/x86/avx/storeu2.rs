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
fn test_x86_avx_mm256_storeu2_m128_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([7.0, 8.0, 9.0, 10.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [3.0, 4.0, 5.0, 6.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([4.0, -5.0, 6.0, -7.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [0.0, -1.0, 2.0, -3.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([500.0, 600.0, 700.0, 800.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [100.0, 200.0, 300.0, 400.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([f32::NAN, f32::NAN, f32::NAN, f32::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [f32::NAN, f32::NAN, f32::NAN, f32::NAN, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f32; 16]);
        let a = create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([3.0, 4.0, 5.0, 6.0]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([5.0, 6.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [3.0, 4.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([2.0, -3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [0.0, -1.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([300.0, 400.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [100.0, 200.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([-1.7976931348623157e308, -1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [-1.7976931348623157e308, -1.7976931348623157e308, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([1.7976931348623157e308, 1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [1.7976931348623157e308, 1.7976931348623157e308, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([0.0, 0.0, 0.0, 0.0]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [0.0, 0.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([f64::NAN, f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [f64::NAN, f64::NAN, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128d_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([2.0f64; 8]);
        let a = create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        _mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[f64; 8]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[f64; 8]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([-0.0, 1.1125369292536007e-308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], [f64::INFINITY, -f64::INFINITY, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]);
        check_float_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_float_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128d(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128d_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128d_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([13, 14, 15, 16, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [9, 10, 11, 12, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([4, -5, 6, -7, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [0, -1, 2, -3, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([500, 600, 700, 800, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [100, 200, 300, 400, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([-2147483648, -2147483648, -2147483648, -2147483648, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [-2147483648, -2147483648, -2147483648, -2147483648, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([2147483647, 2147483647, 2147483647, 2147483647, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [2147483647, 2147483647, 2147483647, 2147483647, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [0, 0, 0, 0, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([-1, -1, -1, -1, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [-1, -1, -1, -1, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_storeu2_m128i_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_hiaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let mut ptr_loaddr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_hiaddr);
        let out_hiaddr = core::ptr::read(ptr_hiaddr.0.as_ptr().cast::<[i32; 16]>());
        let _ = core::hint::black_box(&mut ptr_loaddr);
        let out_loaddr = core::ptr::read(ptr_loaddr.0.as_ptr().cast::<[i32; 16]>());
        let result = (out_hiaddr, out_loaddr);
        let expected = ([-2147483648, 2147483647, 0, -1, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4], [-2147483648, 2147483647, 0, -1, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]);
        check_array_equality(&result.0, &expected.0).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "_mm256_storeu2_m128i(ptr_hiaddr.0.as_mut_ptr(), ptr_loaddr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_storeu2_m128i_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_storeu2_m128i_boundary_mixed_impl() }
}
