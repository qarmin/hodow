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
fn test_x86_kl_mm_encodekey128_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([2, 3, 4, 5]);
        let mut ptr_handle = crate::cpu::common::Aligned64([6u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([0, -1, 2, -3]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_normal2_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([100, 200, 300, 400]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_normal3_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_boundary_min_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_boundary_max_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([0, 0, 0, 0]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_boundary_zero_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_boundary_allones_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_encodekey128_u32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let key_params = 1u32;
        let key = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let mut ptr_handle = crate::cpu::common::Aligned64([2u8; 64]);
        let result = _mm_encodekey128_u32(key_params, key, ptr_handle.0.as_mut_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_encodekey128_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_encodekey128_u32_boundary_mixed_impl() }
}
