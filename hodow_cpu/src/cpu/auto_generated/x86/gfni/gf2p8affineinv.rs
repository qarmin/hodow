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

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-128, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, -120, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10])));
        check_array_equality(&result, &[87, 110, -43, 32, -6, -31, -68, -77, -5, -103, -79, 51, 55, -87, -99, 75, 88, -111, 42, -126, -113, -53, -106, 45, 55, 41, 86, -126, -81, 77, -49, 74, 62, 93, -89, -79, 120, 119, 78, -40, 44, -54, 30, 97, -85, 1, 27, 102, -29, 117, 122, -60, 120, -48, -58, -66, 97, 7, 96, 47, 124, 3, 101, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-127, 1, 1, 1, -127, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, -127, 1, 1, 1, 1, 1, 1, 1, 9, 1, 1, 1, 9, 1, 1, 1, 1, 1, 1, 1, 9, 1, 1, 1, 1, 1, 1, 1, -119, 1, 1, 1, -127, 1, 1, 1, 9, 1, 1, 1, -127, 1, 1, 1, 9, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<1>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[127, -1, -1, -1, 127, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 127, -1, -1, -1, -1, -1, -1, -1, -9, -1, -1, -1, -9, -1, -1, -1, -1, -1, -1, -1, -9, -1, -1, -1, -1, -1, -1, -1, 119, -1, -1, -1, 127, -1, -1, -1, -9, -1, -1, -1, 127, -1, -1, -1, -9, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<255>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<7>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-121, 7, 7, 7, -121, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, -121, 7, 7, 7, 7, 7, 7, 7, 15, 7, 7, 7, 15, 7, 7, 7, 7, 7, 7, 7, 15, 7, 7, 7, 7, 7, 7, 7, -113, 7, 7, 7, -121, 7, 7, 7, 15, 7, 7, 7, -121, 7, 7, 7, 15, 7, 7, 7]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<7>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<7>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-120, 8, 8, 8, -120, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, -120, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, -128, 8, 8, 8, -120, 8, 8, 8, 0, 8, 8, 8, -120, 8, 8, 8, 0, 8, 8, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_gf2p8affineinv_epi64_epi8::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_gf2p8affineinv_epi64_epi8::<8>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-128, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, -120, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10])));
        check_array_equality(&result, &[87, 0, -43, 0, -6, 0, -68, 0, -5, 0, -79, 0, 55, 0, -99, 0, 88, 0, 42, 0, -113, 0, -106, 0, 55, 0, 86, 0, -81, 0, -49, 0, 62, 0, -89, 0, 120, 0, 78, 0, 44, 0, 30, 0, -85, 0, 27, 0, -29, 0, 122, 0, 120, 0, -58, 0, 97, 0, 96, 0, 124, 0, 101, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<1>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-127, 0, 1, 0, -127, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, -127, 0, 1, 0, 1, 0, 1, 0, 9, 0, 1, 0, 9, 0, 1, 0, 1, 0, 1, 0, 9, 0, 1, 0, 1, 0, 1, 0, -119, 0, 1, 0, -127, 0, 1, 0, 9, 0, 1, 0, -127, 0, 1, 0, 9, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<1>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<1>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<255>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[127, 0, -1, 0, 127, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 127, 0, -1, 0, -1, 0, -1, 0, -9, 0, -1, 0, -9, 0, -1, 0, -1, 0, -1, 0, -9, 0, -1, 0, -1, 0, -1, 0, 119, 0, -1, 0, 127, 0, -1, 0, -9, 0, -1, 0, 127, 0, -1, 0, -9, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<255>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<255>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<7>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-121, 0, 7, 0, -121, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, -121, 0, 7, 0, 7, 0, 7, 0, 15, 0, 7, 0, 15, 0, 7, 0, 7, 0, 7, 0, 15, 0, 7, 0, 7, 0, 7, 0, -113, 0, 7, 0, -121, 0, 7, 0, 15, 0, 7, 0, -121, 0, 7, 0, 15, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<7>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<7>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<8>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-120, 0, 8, 0, -120, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, -120, 0, 8, 0, 8, 0, 8, 0, 0, 0, 8, 0, 0, 0, 8, 0, 8, 0, 8, 0, 0, 0, 8, 0, 8, 0, 8, 0, -128, 0, 8, 0, -120, 0, 8, 0, 0, 0, 8, 0, -120, 0, 8, 0, 0, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<8>(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_gf2p8affineinv_epi64_epi8::<8>(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let x = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let a = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let masked = unpack__m512i_to_i8_array(_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(k, x, a));
        let plain = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(x, a));
        let expected: [i8; 64] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_gf2p8affineinv_epi64_epi8::<0>(k, x, a) vs _mm512_gf2p8affineinv_epi64_epi8::<0>(x, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-120, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, -120, 0, 0, 0, -120, 0, 0, 0, 8, 0, 0, 0, -120, 0, 0, 0, -128, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, -128, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]), create__m512i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0, 100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20])));
        check_array_equality(&result, &[-107, -56, 38, -112, -26, 88, 116, 32, -77, -24, -125, -80, 86, 120, 60, 64, 110, 8, 46, -48, 22, -104, -125, 96, 86, 40, -16, -16, -26, -72, 3, -128, 90, 72, 124, 16, -83, -40, 72, -96, 101, 104, 48, 48, -27, -8, -4, -64, -34, -120, 0, 80, 30, 24, -124, -32, 112, -88, -26, 112, -103, 56, -77, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]), create__m512i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0, 100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128, 8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128, 8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128, 8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127, -120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127, -120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127, -120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-119, 0, 1, 0, -127, 0, 1, 0, 1, 0, 1, 0, -127, 0, 1, 0, 1, 0, 1, 0, -119, 0, 1, 0, -119, 0, 1, 0, 9, 0, 1, 0, -119, 0, 1, 0, -127, 0, 1, 0, -127, 0, 1, 0, 9, 0, 1, 0, 1, 0, 1, 0, -127, 0, 1, 0, 1, 0, 1, 0, -127, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<1>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[119, 0, -1, 0, 127, 0, -1, 0, -1, 0, -1, 0, 127, 0, -1, 0, -1, 0, -1, 0, 119, 0, -1, 0, 119, 0, -1, 0, -9, 0, -1, 0, 119, 0, -1, 0, 127, 0, -1, 0, 127, 0, -1, 0, -9, 0, -1, 0, -1, 0, -1, 0, 127, 0, -1, 0, -1, 0, -1, 0, 127, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<255>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<7>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-113, 0, 7, 0, -121, 0, 7, 0, 7, 0, 7, 0, -121, 0, 7, 0, 7, 0, 7, 0, -113, 0, 7, 0, -113, 0, 7, 0, 15, 0, 7, 0, -113, 0, 7, 0, -121, 0, 7, 0, -121, 0, 7, 0, 15, 0, 7, 0, 7, 0, 7, 0, -121, 0, 7, 0, 7, 0, 7, 0, -121, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<7>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<7>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512bw+avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-128, 0, 8, 0, -120, 0, 8, 0, 8, 0, 8, 0, -120, 0, 8, 0, 8, 0, 8, 0, -128, 0, 8, 0, -128, 0, 8, 0, 0, 0, 8, 0, -128, 0, 8, 0, -120, 0, 8, 0, -120, 0, 8, 0, 0, 0, 8, 0, 8, 0, 8, 0, -120, 0, 8, 0, 8, 0, 8, 0, -120, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_gf2p8affineinv_epi64_epi8::<8>(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let x = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let a = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let src = create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let masked = unpack__m512i_to_i8_array(_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(src, k, x, a));
        let plain = unpack__m512i_to_i8_array(_mm512_gf2p8affineinv_epi64_epi8::<0>(x, a));
        let src_lanes = unpack__m512i_to_i8_array(src);
        let expected: [i8; 64] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_gf2p8affineinv_epi64_epi8::<0>(src, k, x, a) vs _mm512_gf2p8affineinv_epi64_epi8::<0>(x, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm512_mask_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-128, 0, 0, 0, 8, 0, 0, 0, -120, 0, 0, 0, -120, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, -120, 0, 0, 0, -128, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[87, 110, -43, 32, -6, -31, -68, -77, -5, -103, -79, 51, 55, -87, -99, 75, 88, -111, 42, -126, -113, -53, -106, 45, 55, 41, 86, -126, -81, 77, -49, 74]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-127, 1, 1, 1, 9, 1, 1, 1, -119, 1, 1, 1, -119, 1, 1, 1, 9, 1, 1, 1, 1, 1, 1, 1, -119, 1, 1, 1, -127, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<1>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[127, -1, -1, -1, -9, -1, -1, -1, 119, -1, -1, -1, 119, -1, -1, -1, -9, -1, -1, -1, -1, -1, -1, -1, 119, -1, -1, -1, 127, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<255>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-121, 7, 7, 7, 15, 7, 7, 7, -113, 7, 7, 7, -113, 7, 7, 7, 15, 7, 7, 7, 7, 7, 7, 7, -113, 7, 7, 7, -121, 7, 7, 7]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<7>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-120, 8, 8, 8, 0, 8, 8, 8, -128, 8, 8, 8, -128, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, -128, 8, 8, 8, -120, 8, 8, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_gf2p8affineinv_epi64_epi8::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_gf2p8affineinv_epi64_epi8::<8>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-128, 0, 0, 0, 8, 0, 0, 0, -120, 0, 0, 0, -120, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, -120, 0, 0, 0, -128, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[87, 0, -43, 0, -6, 0, -68, 0, -5, 0, -79, 0, 55, 0, -99, 0, 88, 0, 42, 0, -113, 0, -106, 0, 55, 0, 86, 0, -81, 0, -49, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<1>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-127, 0, 1, 0, 9, 0, 1, 0, -119, 0, 1, 0, -119, 0, 1, 0, 9, 0, 1, 0, 1, 0, 1, 0, -119, 0, 1, 0, -127, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<1>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<1>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<255>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[127, 0, -1, 0, -9, 0, -1, 0, 119, 0, -1, 0, 119, 0, -1, 0, -9, 0, -1, 0, -1, 0, -1, 0, 119, 0, -1, 0, 127, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<255>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<255>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<7>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-121, 0, 7, 0, 15, 0, 7, 0, -113, 0, 7, 0, -113, 0, 7, 0, 15, 0, 7, 0, 7, 0, 7, 0, -113, 0, 7, 0, -121, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<7>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<7>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<8>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-120, 0, 8, 0, 0, 0, 8, 0, -128, 0, 8, 0, -128, 0, 8, 0, 0, 0, 8, 0, 8, 0, 8, 0, -128, 0, 8, 0, -120, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<8>(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_gf2p8affineinv_epi64_epi8::<8>(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let x = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m256i_to_i8_array(_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(k, x, a));
        let plain = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(x, a));
        let expected: [i8; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_gf2p8affineinv_epi64_epi8::<0>(k, x, a) vs _mm256_gf2p8affineinv_epi64_epi8::<0>(x, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-120, 0, 0, 0, -128, 0, 0, 0, 0, 0, 0, 0, -120, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0, -128, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]), create__m256i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108])));
        check_array_equality(&result, &[-107, -56, 38, -112, -26, 88, 116, 32, -77, -24, -125, -80, 86, 120, 60, 64, 110, 8, 46, -48, 22, -104, -125, 96, 86, 40, -16, -16, -26, -72, 3, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]), create__m256i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128, 8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127, -120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-119, 0, 1, 0, -127, 0, 1, 0, 1, 0, 1, 0, -119, 0, 1, 0, -127, 0, 1, 0, 9, 0, 1, 0, -127, 0, 1, 0, 9, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<1>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[119, 0, -1, 0, 127, 0, -1, 0, -1, 0, -1, 0, 119, 0, -1, 0, 127, 0, -1, 0, -9, 0, -1, 0, 127, 0, -1, 0, -9, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<255>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-113, 0, 7, 0, -121, 0, 7, 0, 7, 0, 7, 0, -113, 0, 7, 0, -121, 0, 7, 0, 15, 0, 7, 0, -121, 0, 7, 0, 15, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<7>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-128, 0, 8, 0, -120, 0, 8, 0, 8, 0, 8, 0, -128, 0, 8, 0, -120, 0, 8, 0, 0, 0, 8, 0, -120, 0, 8, 0, 0, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_gf2p8affineinv_epi64_epi8::<8>(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let x = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m256i_to_i8_array(_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(src, k, x, a));
        let plain = unpack__m256i_to_i8_array(_mm256_gf2p8affineinv_epi64_epi8::<0>(x, a));
        let src_lanes = unpack__m256i_to_i8_array(src);
        let expected: [i8; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_gf2p8affineinv_epi64_epi8::<0>(src, k, x, a) vs _mm256_gf2p8affineinv_epi64_epi8::<0>(x, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm256_mask_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-128, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -42, -127, 115, 36, 0, 38, -42, 0, -42, -127, 115, 36, 0, 38, -42]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[87, 110, -43, 32, -6, -31, -68, -77, -5, -103, -79, 51, 55, -87, -99, 75]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85, -103, -52, 0, 85]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-127, 1, 1, 1, 9, 1, 1, 1, 1, 1, 1, 1, 9, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<1>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[127, -1, -1, -1, -9, -1, -1, -1, -1, -1, -1, -1, -9, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<255>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-121, 7, 7, 7, 15, 7, 7, 7, 7, 7, 7, 7, 15, 7, 7, 7]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<7>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-120, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_gf2p8affineinv_epi64_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_gf2p8affineinv_epi64_epi8::<8>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-128, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, -127, 0, 36, 0, 38, 0, 0, 0, -127, 0, 36, 0, 38, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[87, 0, -43, 0, -6, 0, -68, 0, -5, 0, -79, 0, 55, 0, -99, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0, -103, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<1>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-127, 0, 1, 0, 9, 0, 1, 0, 1, 0, 1, 0, 9, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<1>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<1>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<255>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[127, 0, -1, 0, -9, 0, -1, 0, -1, 0, -1, 0, -9, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<255>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<255>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<7>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-121, 0, 7, 0, 15, 0, 7, 0, 7, 0, 7, 0, 15, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<7>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<7>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<8>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[-120, 0, 8, 0, 0, 0, 8, 0, 8, 0, 8, 0, 0, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<8>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_gf2p8affineinv_epi64_epi8::<8>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let x = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m128i_to_i8_array(_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(k, x, a));
        let plain = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(x, a));
        let expected: [i8; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_gf2p8affineinv_epi64_epi8::<0>(k, x, a) vs _mm_gf2p8affineinv_epi64_epi8::<0>(x, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_maskz_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[8, 0, 0, 0, 0, 0, 0, 0, -128, 0, 0, 0, -120, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[90, -1, -6, -3, -16, -5, 95, -7, 90, -1, -6, -3, -16, -5, 95, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i8_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_normal2_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]), create__m128i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84])));
        check_array_equality(&result, &[-107, -56, 38, -112, -26, 88, 116, 32, -77, -24, -125, -80, 86, 120, 60, 64]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]), create__m128i_from_i8_array([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_normal3_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128, -1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1, -103, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8, -128, 8, -128, 8, -128, 8, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-120, 127, -120, 127, -120, 127, -120, 127, 0, 127, 0, 127, 0, 127, 0, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<0>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 0, 1, 0, 1, 0, 1, 0, -127, 0, 1, 0, -119, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<1>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_1_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[-9, 0, -1, 0, -1, 0, -1, 0, 127, 0, -1, 0, 119, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<255>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_255_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_7_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[15, 0, 7, 0, 7, 0, 7, 0, -121, 0, 7, 0, -113, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<7>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_7_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512bw") && std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512bw+avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[0, 0, 8, 0, 8, 0, 8, 0, -120, 0, 8, 0, -128, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_gf2p8affineinv_epi64_epi8::<8>(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_imm_8_impl() }
}

#[target_feature(enable = "gfni")]
fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let x = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m128i_from_i32_array([5, 6, 7, 8]);
        let src = create__m128i_from_i32_array([9, 10, 11, 12]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m128i_to_i8_array(_mm_mask_gf2p8affineinv_epi64_epi8::<0>(src, k, x, a));
        let plain = unpack__m128i_to_i8_array(_mm_gf2p8affineinv_epi64_epi8::<0>(x, a));
        let src_lanes = unpack__m128i_to_i8_array(src);
        let expected: [i8; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_gf2p8affineinv_epi64_epi8::<0>(src, k, x, a) vs _mm_gf2p8affineinv_epi64_epi8::<0>(x, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_gfni_mm_mask_gf2p8affineinv_epi64_epi8_vs_unmasked_impl() }
}
