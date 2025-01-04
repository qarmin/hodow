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

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([1, 2, 3, 4]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([0, -1, 2, -3]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_normal2_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([100, 200, 300, 400]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_normal3_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_boundary_min_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_boundary_max_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([0, 0, 0, 0]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([-1, -1, -1, -1]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si16(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si16(create_random__m128i());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi128_si16_boundary_mixed_impl() }
}
