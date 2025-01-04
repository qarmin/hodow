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

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 255, 255, 2, 0, 253, 255, 4, 0, 251, 255, 6, 0, 249, 255, 0, 0, 255, 255, 2, 0, 253, 255, 4, 0, 251, 255, 6, 0, 249, 255]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[100, 0, 200, 0, 44, 1, 144, 1, 244, 1, 88, 2, 188, 2, 32, 3, 132, 3, 232, 3, 76, 4, 176, 4, 20, 5, 120, 5, 220, 5, 64, 6]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128, 0, 128]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127, 255, 127]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 128, 255, 127, 0, 0, 255, 255, 0, 128, 255, 127, 0, 0, 255, 255, 0, 128, 255, 127, 0, 0, 255, 255, 0, 128, 255, 127, 0, 0, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu8_epi16(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_cvtepu8_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 0, 0, 0, 18, 0, 0, 0, 19, 0, 0, 0, 20, 0, 0, 0, 21, 0, 0, 0, 22, 0, 0, 0, 23, 0, 0, 0, 24, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 9, -3, 12, -5, 7, -7, 14, -1, 5, -3, 16, -5, 3, -7, 10, -1, 9, -3, 12, -5, 7, -7, 14, -1, 5, -3, 16, -5, 3, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[110, 200, 210, 400, 54, 600, 154, 800, 254, 1000, 98, 1200, 198, 1400, 42, 1600, 142, 1800, 242, 2000, 86, 2200, 186, 2400, 30, 2600, 130, 2800, 230, 3000, 74, 3200]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu8_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu8_epi16(create_random__m512i(), create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_cvtepu8_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_cvtepu8_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 255, 0, 2, 0, 253, 0, 4, 0, 251, 0, 6, 0, 249, 0, 0, 0, 255, 0, 2, 0, 253, 0, 4, 0, 251, 0, 6, 0, 249, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[100, 0, 200, 0, 44, 0, 144, 0, 244, 0, 88, 0, 188, 0, 32, 0, 132, 0, 232, 0, 76, 0, 176, 0, 20, 0, 120, 0, 220, 0, 64, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu8_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu8_epi16(create_random__mmask32(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_cvtepu8_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 0, 0, 0, 10, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 9, -3, 12, -5, 7, -7, 14, -1, 5, -3, 16, -5, 3, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 210, 400, 54, 600, 154, 800, 254, 1000, 98, 1200, 198, 1400, 42, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767, 255, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1, 255, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1, 0, 32767, 255, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768, 255, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu8_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu8_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_cvtepu8_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_cvtepu8_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 255, 0, 2, 0, 253, 0, 4, 0, 251, 0, 6, 0, 249, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 200, 0, 44, 0, 144, 0, 244, 0, 88, 0, 188, 0, 32, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu8_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu8_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_cvtepu8_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 6, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 9, -3, 12, -5, 7, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 210, 400, 54, 600, 154, 800]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 32767, 255, 32767, 255, 32767, 255, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, -1, 255, -1, 255, -1, 255, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 32767, 255, -1, 0, 32767, 255, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, -32768, 255, -32768, 255, -32768, 255, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 32767, 0, 32767, 0, 32767, 0, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu8_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu8_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_cvtepu8_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_cvtepu8_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 255, 0, 2, 0, 253, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 200, 0, 44, 0, 144, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[255, 0, 255, 0, 255, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 255, 0, 0, 0, 255, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu8_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu8_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_cvtepu8_epi16_boundary_mixed_impl() }
}
