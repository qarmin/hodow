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

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[8592441345, 17182818307, 25773228037, 34363670535, 42954145801, 51544653835, 60135194637, 68725768207]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__m512i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64), ((14u64) as i64), ((5u64) as i64), ((16u64) as i64), ((3u64) as i64)]), create__m512i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64), ((24u64) as i64), ((15u64) as i64), ((26u64) as i64), ((13u64) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615, 2, 18446744073709551613, 4, 18446744073709551611, 6, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__m512i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64), ((14u64) as i64), ((5u64) as i64), ((16u64) as i64), ((3u64) as i64)]), create__m512i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64), ((24u64) as i64), ((15u64) as i64), ((26u64) as i64), ((13u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__m512i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64), ((510u64) as i64), ((610u64) as i64), ((710u64) as i64), ((810u64) as i64)]), create__m512i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64), ((520u64) as i64), ((620u64) as i64), ((720u64) as i64), ((820u64) as i64)])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__m512i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64), ((510u64) as i64), ((610u64) as i64), ((710u64) as i64), ((810u64) as i64)]), create__m512i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64), ((520u64) as i64), ((620u64) as i64), ((720u64) as i64), ((820u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 4503599627370493, 0, 4503599627370493, 0, 4503599627370493, 0, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934592, 17179869186, 25769803780, 34359738374, 42949672968, 51539607562, 60129542156, 68719476750]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_madd52hi_epu64(create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[8592441345, 17179869187, 25773228037, 34359738375, 42954145801, 51539607563, 60135194637, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64), ((14u64) as i64), ((5u64) as i64), ((16u64) as i64), ((3u64) as i64)]), create__m512i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64), ((24u64) as i64), ((15u64) as i64), ((26u64) as i64), ((13u64) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615, 2, 18446744073709551613, 4, 18446744073709551611, 6, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64), ((14u64) as i64), ((5u64) as i64), ((16u64) as i64), ((3u64) as i64)]), create__m512i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64), ((24u64) as i64), ((15u64) as i64), ((26u64) as i64), ((13u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64), ((510u64) as i64), ((610u64) as i64), ((710u64) as i64), ((810u64) as i64)]), create__m512i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64), ((520u64) as i64), ((620u64) as i64), ((720u64) as i64), ((820u64) as i64)])));
        check_array_equality(&result, &[100, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64), ((510u64) as i64), ((610u64) as i64), ((710u64) as i64), ((810u64) as i64)]), create__m512i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64), ((520u64) as i64), ((620u64) as i64), ((720u64) as i64), ((820u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615, 0, 18446744073709551615, 0, 18446744073709551615, 0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934592, 0, 25769803780, 0, 42949672968, 0, 60129542156, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_madd52hi_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_madd52hi_epu64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_mask_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_mask_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[8592441345, 0, 25773228037, 0, 42954145801, 0, 60135194637, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__m512i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64), ((14u64) as i64), ((5u64) as i64), ((16u64) as i64), ((3u64) as i64)]), create__m512i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64), ((24u64) as i64), ((15u64) as i64), ((26u64) as i64), ((13u64) as i64)])));
        check_array_equality(&result, &[0, 0, 2, 0, 4, 0, 6, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__m512i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64), ((14u64) as i64), ((5u64) as i64), ((16u64) as i64), ((3u64) as i64)]), create__m512i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64), ((24u64) as i64), ((15u64) as i64), ((26u64) as i64), ((13u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__m512i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64), ((510u64) as i64), ((610u64) as i64), ((710u64) as i64), ((810u64) as i64)]), create__m512i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64), ((520u64) as i64), ((620u64) as i64), ((720u64) as i64), ((820u64) as i64)])));
        check_array_equality(&result, &[100, 0, 300, 0, 500, 0, 700, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__m512i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64), ((510u64) as i64), ((610u64) as i64), ((710u64) as i64), ((810u64) as i64)]), create__m512i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64), ((520u64) as i64), ((620u64) as i64), ((720u64) as i64), ((820u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 0, 4503599627370493, 0, 4503599627370493, 0, 4503599627370493, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 0, 4503599627370493, 0, 4503599627370493, 0, 4503599627370493, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934592, 0, 25769803780, 0, 42949672968, 0, 60129542156, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[18446744073709551615, 0, 18446744073709551615, 0, 18446744073709551615, 0, 18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m512i(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let b = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let c = create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_u64_array(_mm512_maskz_madd52hi_epu64(k, a, b, c));
        let plain = unpack__m512i_to_u64_array(_mm512_madd52hi_epu64(a, b, c));
        let expected: [u64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_madd52hi_epu64(k, a, b, c) vs _mm512_madd52hi_epu64(a, b, c)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm512_maskz_madd52hi_epu64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[8590671873, 17180852227, 25771065349, 34361311239]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__m256i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64)]), create__m256i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615, 2, 18446744073709551613]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__m256i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64)]), create__m256i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__m256i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64)]), create__m256i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64)])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__m256i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64)]), create__m256i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 4503599627370493, 4503599627370493, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 4503599627370493, 0, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934592, 17179869186, 25769803780, 34359738374]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm256_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_madd52hi_epu64(create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[8590671873, 17179869187, 25771065349, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64)]), create__m256i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615, 2, 18446744073709551613]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64)]), create__m256i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64)]), create__m256i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64)])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64)]), create__m256i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 18446744073709551615, 4503599627370493, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615, 0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934592, 0, 25769803780, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615, 18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_madd52hi_epu64(create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_madd52hi_epu64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_mask_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_mask_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[8590671873, 0, 25771065349, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__m256i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64)]), create__m256i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64)])));
        check_array_equality(&result, &[0, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64)]), create__m256i_from([((10u64) as i64), ((9u64) as i64), ((12u64) as i64), ((7u64) as i64)]), create__m256i_from([((20u64) as i64), ((19u64) as i64), ((22u64) as i64), ((17u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__m256i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64)]), create__m256i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64)])));
        check_array_equality(&result, &[100, 0, 300, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64)]), create__m256i_from([((110u64) as i64), ((210u64) as i64), ((310u64) as i64), ((410u64) as i64)]), create__m256i_from([((120u64) as i64), ((220u64) as i64), ((320u64) as i64), ((420u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 0, 4503599627370493, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__m256i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 0, 4503599627370493, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934592, 0, 25769803780, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551615, 0, 18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m256i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m256i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m256i(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let b = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let c = create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_u64_array(_mm256_maskz_madd52hi_epu64(k, a, b, c));
        let plain = unpack__m256i_to_u64_array(_mm256_madd52hi_epu64(a, b, c));
        let expected: [u64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_madd52hi_epu64(k, a, b, c) vs _mm256_madd52hi_epu64(a, b, c)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm256_maskz_madd52hi_epu64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[8590180353, 17180262403]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__m128i_from_i64_array([((10u64) as i64), ((9u64) as i64)]), create__m128i_from_i64_array([((20u64) as i64), ((19u64) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__m128i_from_i64_array([((10u64) as i64), ((9u64) as i64)]), create__m128i_from_i64_array([((20u64) as i64), ((19u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__m128i_from_i64_array([((110u64) as i64), ((210u64) as i64)]), create__m128i_from_i64_array([((120u64) as i64), ((220u64) as i64)])));
        check_array_equality(&result, &[100, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__m128i_from_i64_array([((110u64) as i64), ((210u64) as i64)]), create__m128i_from_i64_array([((120u64) as i64), ((220u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 4503599627370493]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934592, 17179869186]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_madd52hi_epu64(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[8590180353, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((10u64) as i64), ((9u64) as i64)]), create__m128i_from_i64_array([((20u64) as i64), ((19u64) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((10u64) as i64), ((9u64) as i64)]), create__m128i_from_i64_array([((20u64) as i64), ((19u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((110u64) as i64), ((210u64) as i64)]), create__m128i_from_i64_array([((120u64) as i64), ((220u64) as i64)])));
        check_array_equality(&result, &[100, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((110u64) as i64), ((210u64) as i64)]), create__m128i_from_i64_array([((120u64) as i64), ((220u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934592, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_madd52hi_epu64(create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_madd52hi_epu64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_mask_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_mask_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[8590180353, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__m128i_from_i64_array([((10u64) as i64), ((9u64) as i64)]), create__m128i_from_i64_array([((20u64) as i64), ((19u64) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((0u64) as i64), ((18446744073709551615u64) as i64)]), create__m128i_from_i64_array([((10u64) as i64), ((9u64) as i64)]), create__m128i_from_i64_array([((20u64) as i64), ((19u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__m128i_from_i64_array([((110u64) as i64), ((210u64) as i64)]), create__m128i_from_i64_array([((120u64) as i64), ((220u64) as i64)])));
        check_array_equality(&result, &[100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((100u64) as i64), ((200u64) as i64)]), create__m128i_from_i64_array([((110u64) as i64), ((210u64) as i64)]), create__m128i_from_i64_array([((120u64) as i64), ((220u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]), create__m128i_from_i64_array([((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[4503599627370493, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934592, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([((u64::MAX) as i64), ((u64::MAX) as i64)]), create__m128i_from_i64_array([((u64::MIN) as i64), ((u64::MIN) as i64)]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_madd52hi_epu64(create_random__mmask8(), create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512ifma")]
fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let b = create__m128i_from_i32_array([5, 6, 7, 8]);
        let c = create__m128i_from_i32_array([9, 10, 11, 12]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_u64_array(_mm_maskz_madd52hi_epu64(k, a, b, c));
        let plain = unpack__m128i_to_u64_array(_mm_madd52hi_epu64(a, b, c));
        let expected: [u64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_madd52hi_epu64(k, a, b, c) vs _mm_madd52hi_epu64(a, b, c)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512ifma_mm_maskz_madd52hi_epu64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512ifma_mm_maskz_madd52hi_epu64_vs_unmasked_impl() }
}
