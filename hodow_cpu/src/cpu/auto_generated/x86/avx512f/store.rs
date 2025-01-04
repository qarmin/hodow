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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_store_mask16_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__mmask16_from(0b0101010101010101); 32]);
        let a = create__mmask16_from(0b0101010101010101);
        _store_mask16(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u16; 32]>());
        check_array_equality(&result, &[21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845]).map_err(|e| crate::cpu::with_call(e, "_store_mask16(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_store_mask16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_store_mask16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_si512_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_si512(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_si512_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_si512_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 3, 4, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, -1, 2, -3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 200, 300, 400, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        _mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi32(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[12884901890, 21474836484, 30064771078, 38654705672, 47244640266, 55834574860, 64424509454, 73014444048]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]);
        _mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, 0, -1, -9223372036854775808, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[12884901890, 21474836484, 30064771078, 38654705672, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([0, -1, 2, -3]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, -1, 2, -3, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([100, 200, 300, 400]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 200, 300, 400, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([0, 0, 0, 0]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([-1, -1, -1, -1]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, -1, -1, -1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_store_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m256i_from([i64::MIN, i64::MAX, 0, -1]);
        _mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, 0, -1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_store_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_store_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[12884901890, 21474836484, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([0, -1]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, -1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([100, 200]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 200, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([0, 0]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 0, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([-1, -1]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, -1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_store_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MAX]);
        _mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_store_epi64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_store_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_store_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let a = create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_ps(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_store_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        _mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, -0.0, 1.1125369292536007e-308]).map_err(|e| crate::cpu::with_call(e, "_mm512_store_pd(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_store_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_store_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 1, 4, 1, 6, 1, 8, 1, 10, 1, 12, 1, 14, 1, 16, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 2, 1, 4, 1, 6, 1, 0, 1, 2, 1, 4, 1, 6, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 1, 300, 1, 500, 1, 700, 1, 900, 1, 1100, 1, 1300, 1, 1500, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, 0, 1, -2147483648, 1, 0, 1, -2147483648, 1, 0, 1, -2147483648, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[12884901890, 1, 30064771078, 1, 47244640266, 1, 64424509454, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 2, 1, 4, 1, 6, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 1, 300, 1, 500, 1, 700, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 0, 1, 0, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, 1, -1, 1, -1, 1, -1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]);
        _mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 0, 1, -9223372036854775808, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0, 1.0, 10.0, 1.0, 12.0, 1.0, 14.0, 1.0, 16.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 0.0, 1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 1.0, 300.0, 1.0, 500.0, 1.0, 700.0, 1.0, 900.0, 1.0, 1100.0, 1.0, 1300.0, 1.0, 1500.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let a = create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, 1.0, -0.0, 1.0, f32::INFINITY, 1.0, -0.0, 1.0, f32::INFINITY, 1.0, -0.0, 1.0, f32::INFINITY, 1.0, -0.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 300.0, 1.0, 500.0, 1.0, 700.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, -1.7976931348623157e308, 1.0, -1.7976931348623157e308, 1.0, -1.7976931348623157e308, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.7976931348623157e308, 1.0, 1.7976931348623157e308, 1.0, 1.7976931348623157e308, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, f64::NAN, 1.0, f64::NAN, 1.0, f64::NAN, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_store_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        _mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, -0.0, 1.0, f64::INFINITY, 1.0, -0.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_store_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_store_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 1, 4, 1, 6, 1, 8, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 2, 1, 4, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 1, 300, 1, 500, 1, 700, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, 1, -1, 1, -1, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        _mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, 0, 1, -2147483648, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[12884901890, 1, 30064771078, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([0, -1, 2, -3]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 2, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([100, 200, 300, 400]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 1, 300, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, -9223372036854775808, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 1, 9223372036854775807, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([0, 0, 0, 0]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 0, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([-1, -1, -1, -1]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, 1, -1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256i_from([i64::MIN, i64::MAX, 0, -1]);
        _mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 0, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 8.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 2.0, 1.0, 4.0, 1.0, 6.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 1.0, 300.0, 1.0, 500.0, 1.0, 700.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, 1.0, -0.0, 1.0, f32::INFINITY, 1.0, -0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([2.0, 3.0, 4.0, 5.0]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 4.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 300.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, -1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([0.0, 0.0, 0.0, 0.0]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_store_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        _mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, -0.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_store_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_store_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([0, -1, 2, -3]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([100, 200, 300, 400]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[100, 1, 300, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, -2147483648, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[2147483647, 1, 2147483647, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([0, 0, 0, 0]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([-1, -1, -1, -1]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-1, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        _mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i32; 16]>());
        check_array_equality(&result, &[-2147483648, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi32(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([2, 3, 4, 5]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[12884901890, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([0, -1]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([100, 200]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[100, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[9223372036854775807, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([0, 0]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[0, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([-1, -1]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i64_array([i64::MIN, i64::MAX]);
        _mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[-9223372036854775808, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_epi64(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 1.0, 4.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 1.0, 300.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, 1.0, -3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 1.0, 3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, 1.0, f32::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, 1.0, -0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ps(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let mask = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_pd(ptr_mem_addr.0.as_mut_ptr(), mask, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[-3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[3.4028235e38, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_ss_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        _mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f32; 16]>());
        check_float_array_equality(&result, &[f32::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_ss(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[100.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::NAN, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_store_sd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let k = create__mmask8_from(0b01010101);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[f64; 8]>());
        check_float_array_equality(&result, &[f64::INFINITY, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_store_sd(ptr_mem_addr.0.as_mut_ptr(), k, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_store_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_store_sd_boundary_mixed_impl() }
}
