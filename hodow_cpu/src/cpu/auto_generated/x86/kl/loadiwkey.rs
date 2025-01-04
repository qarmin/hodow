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
fn test_x86_kl_mm_loadiwkey_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_normal2_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_normal3_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_boundary_min_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_boundary_max_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_boundary_zero_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_boundary_allones_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_boundary_mixed_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_asym_min_max_impl() }
}

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_loadiwkey_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        _mm_loadiwkey(0u32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_kl_mm_loadiwkey_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_loadiwkey_asym_max_min_impl() }
}
