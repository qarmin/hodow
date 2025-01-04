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

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128i_from_i32_array([6, 7, 8, 9]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([0, -1, 2, -3]);
        let a = create__m128i_from_i32_array([10, 9, 12, 7]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 9, 1, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([100, 200, 300, 400]);
        let a = create__m128i_from_i32_array([110, 210, 310, 410]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256i_from_i32_array([10, 11, 12, 13, 14, 15, 16, 17]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        let a = create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 9, 1, 7, 1, 5, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        let a = create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, 1, -1, -2147483648, 1, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let a = create__m128i_from_i32_array([6, 7, 8, 9]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([0, -1]);
        let a = create__m128i_from_i64_array([10, 9]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 9, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([100, 200]);
        let a = create__m128i_from_i64_array([110, 210]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        let a = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([0, 0]);
        let a = create__m128i_from_i64_array([0, 0]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([-1, -1]);
        let a = create__m128i_from_i64_array([-1, -1]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, -1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MIN, i64::MAX]);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MAX]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        let a = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskstore_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        _mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskstore_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskstore_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let a = create__m256i_from_i32_array([10, 11, 12, 13, 14, 15, 16, 17]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([0, -1, 2, -3]);
        let a = create__m256i_from([10, 9, 12, 7]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 9, 1, 7, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([100, 200, 300, 400]);
        let a = create__m256i_from([110, 210, 310, 410]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        let a = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        let a = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([0, 0, 0, 0]);
        let a = create__m256i_from([0, 0, 0, 0]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([-1, -1, -1, -1]);
        let a = create__m256i_from([-1, -1, -1, -1]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, -1, -1, -1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MIN, i64::MAX, 0, -1]);
        let a = create__m256i_from([i64::MIN, i64::MAX, 0, -1]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 1, -1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        let a = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskstore_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        let a = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        _mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskstore_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskstore_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskstore_epi64_asym_max_min_impl() }
}
