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

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([5, 6, 7, 8]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([0, -1, 2, -3]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_normal2_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([100, 200, 300, 400]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_normal3_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_boundary_min_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_boundary_max_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([0, 0, 0, 0]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_boundary_zero_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_boundary_allones_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesenc128kl_u8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let input = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let ptr_handle = crate::cpu::common::Aligned64([5u8; 64]);
        let result = _mm_aesenc128kl_u8(ptr_output.0.as_mut_ptr(), input, ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesenc128kl_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesenc128kl_u8_boundary_mixed_impl() }
}
