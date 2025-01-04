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

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 1, 0, 2, 0, 1, 0, 2, 0, 2, 0, 3, 0, 1, 0, 2, 0, 2, 0, 3, 0, 2, 0, 3, 0, 3, 0, 4, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 16, 1, 15, 1, 15, 2, 14, 0, 16, 1, 15, 1, 15, 2, 14, 0, 16, 1, 15, 1, 15, 2, 14, 0, 16, 1, 15, 1, 15, 2, 14]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[3, 3, 4, 3, 6, 4, 6, 3, 4, 6, 4, 4, 4, 6, 7, 3, 5, 4, 7, 6, 4, 4, 7, 4, 5, 4, 5, 6, 6, 7, 5, 3]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi16(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 1, 0, 2, 0, 1, 0, 2, 0, 2, 0, 3, 0, 1, 0, 2, 0, 2, 0, 3, 0, 2, 0, 3, 0, 3, 0, 4, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200])));
        check_array_equality(&result, &[3, 0, 4, 0, 6, 0, 6, 0, 4, 0, 4, 0, 4, 0, 7, 0, 5, 0, 7, 0, 4, 0, 7, 0, 5, 0, 5, 0, 6, 0, 5, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi16(create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m512i_to_i16_array(_mm512_maskz_popcnt_epi16(k, a));
        let plain = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(a));
        let expected: [i16; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi16(k, a) vs _mm512_popcnt_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[2, 0, 2, 0, 3, 0, 2, 0, 3, 0, 3, 0, 4, 0, 2, 0, 3, 0, 3, 0, 4, 0, 3, 0, 4, 0, 4, 0, 5, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[5, 200, 5, 400, 8, 600, 5, 800, 6, 1000, 5, 1200, 6, 1400, 7, 1600, 7, 1800, 8, 2000, 6, 2200, 4, 2400, 7, 2600, 6, 2800, 8, 3000, 5, 3200]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m512i_to_i16_array(_mm512_mask_popcnt_epi16(src, k, a));
        let plain = unpack__m512i_to_i16_array(_mm512_popcnt_epi16(a));
        let src_lanes = unpack__m512i_to_i16_array(src);
        let expected: [i16; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi16(src, k, a) vs _mm512_popcnt_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 1, 0, 2, 0, 1, 0, 2, 0, 2, 0, 3, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 16, 1, 15, 1, 15, 2, 14, 0, 16, 1, 15, 1, 15, 2, 14]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[3, 3, 4, 3, 6, 4, 6, 3, 4, 6, 4, 4, 4, 6, 7, 3]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16, 1, 15, 0, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 1, 0, 2, 0, 1, 0, 2, 0, 2, 0, 3, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[3, 0, 4, 0, 6, 0, 6, 0, 4, 0, 4, 0, 4, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0, 15, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0, 16, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi16(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m256i_to_i16_array(_mm256_maskz_popcnt_epi16(k, a));
        let plain = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(a));
        let expected: [i16; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi16(k, a) vs _mm256_popcnt_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 0, 2, 0, 3, 0, 2, 0, 3, 0, 3, 0, 4, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[5, 200, 5, 400, 8, 600, 5, 800, 6, 1000, 5, 1200, 6, 1400, 7, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767, 15, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1, 16, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1, 1, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768, 15, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m256i_to_i16_array(_mm256_mask_popcnt_epi16(src, k, a));
        let plain = unpack__m256i_to_i16_array(_mm256_popcnt_epi16(a));
        let src_lanes = unpack__m256i_to_i16_array(src);
        let expected: [i16; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi16(src, k, a) vs _mm256_popcnt_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0, 2, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 16, 1, 15, 1, 15, 2, 14]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[3, 3, 4, 3, 6, 4, 6, 3]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 15, 15, 15, 15, 15, 15, 15]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 15, 0, 16, 1, 15, 0, 16]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0, 2, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[3, 0, 4, 0, 6, 0, 6, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 0, 15, 0, 15, 0, 15, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, 0, 16, 0, 16, 0, 16, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i16_array(_mm_maskz_popcnt_epi16(k, a));
        let plain = unpack__m128i_to_i16_array(_mm_popcnt_epi16(a));
        let expected: [i16; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi16(k, a) vs _mm_popcnt_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 0, 2, 0, 3, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[5, 200, 5, 400, 8, 600, 5, 800]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, -32768, 1, -32768, 1, -32768, 1, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, 32767, 15, 32767, 15, 32767, 15, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[16, -1, 16, -1, 16, -1, 16, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1, 1, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[15, -32768, 15, -32768, 15, -32768, 15, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, 32767, 1, 32767, 1, 32767, 1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i16_array(_mm_mask_popcnt_epi16(src, k, a));
        let plain = unpack__m128i_to_i16_array(_mm_popcnt_epi16(a));
        let src_lanes = unpack__m128i_to_i16_array(src);
        let expected: [i16; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi16(src, k, a) vs _mm_popcnt_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0])));
        check_array_equality(&result, &[3, 3, 3, 2, 5, 3, 5, 1, 2, 4, 3, 3, 2, 4, 5, 1, 3, 1, 4, 3, 3, 3, 6, 2, 3, 2, 3, 4, 3, 4, 3, 1, 4, 2, 4, 1, 4, 4, 4, 2, 1, 3, 4, 2, 3, 5, 4, 2, 2, 2, 5, 2, 4, 2, 5, 3, 2, 3, 2, 3, 4, 3, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi8(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0])));
        check_array_equality(&result, &[3, 0, 3, 0, 5, 0, 5, 0, 2, 0, 3, 0, 2, 0, 5, 0, 3, 0, 4, 0, 3, 0, 6, 0, 3, 0, 3, 0, 3, 0, 3, 0, 4, 0, 4, 0, 4, 0, 4, 0, 1, 0, 4, 0, 3, 0, 4, 0, 2, 0, 5, 0, 4, 0, 5, 0, 2, 0, 2, 0, 4, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi8(create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let masked = unpack__m512i_to_i8_array(_mm512_maskz_popcnt_epi8(k, a));
        let plain = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(a));
        let expected: [i8; 64] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi8(k, a) vs _mm512_popcnt_epi8(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_maskz_popcnt_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10])));
        check_array_equality(&result, &[5, -56, 4, -112, 7, 88, 4, 32, 4, -24, 4, -80, 4, 120, 5, 64, 5, 8, 5, -48, 5, -104, 2, 96, 5, 40, 4, -16, 5, -72, 3, -128, 6, 72, 5, 16, 6, -40, 3, -96, 3, 104, 5, 48, 5, -8, 4, -64, 4, -120, 6, 80, 6, 24, 3, -32, 4, -88, 3, 112, 6, 56, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118, -18, 82, -74, 26, 126, -30, 70, -86, 14, 114, -42, 58, -98, 2, 102, -54, 46, -110, -10, 90, -66, 34, -122, -22, 78, -78, 22, 122, -34, 66, -90, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let masked = unpack__m512i_to_i8_array(_mm512_mask_popcnt_epi8(src, k, a));
        let plain = unpack__m512i_to_i8_array(_mm512_popcnt_epi8(a));
        let src_lanes = unpack__m512i_to_i8_array(src);
        let expected: [i8; 64] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi8(src, k, a) vs _mm512_popcnt_epi8(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_popcnt_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_popcnt_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128])));
        check_array_equality(&result, &[3, 3, 3, 2, 5, 3, 5, 1, 2, 4, 3, 3, 2, 4, 5, 1, 3, 1, 4, 3, 3, 3, 6, 2, 3, 2, 3, 4, 3, 4, 3, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi8(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128])));
        check_array_equality(&result, &[3, 0, 3, 0, 5, 0, 5, 0, 2, 0, 3, 0, 2, 0, 5, 0, 3, 0, 4, 0, 3, 0, 6, 0, 3, 0, 3, 0, 3, 0, 3, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi8(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m256i_to_i8_array(_mm256_maskz_popcnt_epi8(k, a));
        let plain = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(a));
        let expected: [i8; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi8(k, a) vs _mm256_popcnt_epi8(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_maskz_popcnt_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[5, -56, 4, -112, 7, 88, 4, 32, 4, -24, 4, -80, 4, 120, 5, 64, 5, 8, 5, -48, 5, -104, 2, 96, 5, 40, 4, -16, 5, -72, 3, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m256i_to_i8_array(_mm256_mask_popcnt_epi8(src, k, a));
        let plain = unpack__m256i_to_i8_array(_mm256_popcnt_epi8(a));
        let src_lanes = unpack__m256i_to_i8_array(src);
        let expected: [i8; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi8(src, k, a) vs _mm256_popcnt_epi8(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_popcnt_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_popcnt_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 8, 1, 7, 1, 7, 2, 6, 0, 8, 1, 7, 1, 7, 2, 6]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[3, 3, 3, 2, 5, 3, 5, 1, 2, 4, 3, 3, 2, 4, 5, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8, 1, 7, 0, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi8(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_array_equality(&result, &[3, 0, 3, 0, 5, 0, 5, 0, 2, 0, 3, 0, 2, 0, 5, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi8(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m128i_to_i8_array(_mm_maskz_popcnt_epi8(k, a));
        let plain = unpack__m128i_to_i8_array(_mm_popcnt_epi8(a));
        let expected: [i8; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi8(k, a) vs _mm_popcnt_epi8(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_maskz_popcnt_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_maskz_popcnt_epi8_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[5, -56, 4, -112, 7, 88, 4, 32, 4, -24, 4, -80, 4, 120, 5, 64]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127, 7, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1, 8, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1, 1, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128, 7, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m128i_to_i8_array(_mm_mask_popcnt_epi8(src, k, a));
        let plain = unpack__m128i_to_i8_array(_mm_popcnt_epi8(a));
        let src_lanes = unpack__m128i_to_i8_array(src);
        let expected: [i8; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi8(src, k, a) vs _mm_popcnt_epi8(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_popcnt_epi8_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_popcnt_epi8_vs_unmasked_impl() }
}
