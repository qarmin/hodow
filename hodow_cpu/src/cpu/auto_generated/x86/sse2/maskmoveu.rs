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
fn test_x86_sse2_mm_maskmoveu_si128_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128i_from_i32_array([5, 6, 7, 8]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([9i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        let mask = create__m128i_from_i32_array([10, 9, 12, 7]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        let mask = create__m128i_from_i32_array([110, 210, 310, 410]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[1, 1, 1, 1, -56, 1, 1, 1, 1, 1, 1, 1, -112, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[1, 1, 1, -128, 1, 1, 1, -128, 1, 1, 1, -128, 1, 1, 1, -128, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[-1, -1, -1, 1, -1, -1, -1, 1, -1, -1, -1, 1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let mask = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[1, 1, 1, -128, -1, -1, -1, 1, 1, 1, 1, 1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_maskmoveu_si128_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i8; 64]>());
        check_array_equality(&result, &[1, 1, 1, 127, 1, 1, 1, 127, 1, 1, 1, 127, 1, 1, 1, 127, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskmoveu_si128(a, mask, ptr_mem_addr.0.as_mut_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_maskmoveu_si128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_maskmoveu_si128_asym_max_min_impl() }
}
