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
fn test_x86_avx512f_mm512_cvtepu16_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 65535, 65535, 2, 0, 65533, 65535, 4, 0, 65531, 65535, 6, 0, 65529, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 200, 0, 300, 0, 400, 0, 500, 0, 600, 0, 700, 0, 800, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768, 0, 32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 32767, 65535, 32767, 65535, 32767, 65535, 32767, 65535, 32767, 65535, 32767, 65535, 32767, 65535, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 32768, 65535, 32767, 0, 0, 65535, 65535, 0, 32768, 65535, 32767, 0, 0, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[17, 2, 18, 4, 19, 6, 20, 8, 21, 10, 22, 12, 23, 14, 24, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 9, -3, 12, -5, 7, -7, 14, -1, 5, -3, 16, -5, 3, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 210, 400, 310, 600, 410, 800, 510, 1000, 610, 1200, 710, 1400, 810, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 2147483647, 65535, 2147483647, 65535, 2147483647, 65535, 2147483647, 65535, 2147483647, 65535, 2147483647, 65535, 2147483647, 65535, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[65535, -1, 65535, -1, 65535, -1, 65535, -1, 65535, -1, 65535, -1, 65535, -1, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 65535, -1, 0, 2147483647, 65535, -1, 0, 2147483647, 65535, -1, 0, 2147483647, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, -2147483648, 65535, -2147483648, 65535, -2147483648, 65535, -2147483648, 65535, -2147483648, 65535, -2147483648, 65535, -2147483648, 65535, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi32(create_random__m512i(), create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 65535, 0, 2, 0, 65533, 0, 4, 0, 65531, 0, 6, 0, 65529, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 200, 0, 300, 0, 400, 0, 500, 0, 600, 0, 700, 0, 800, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 65535, 0, 0, 0, 65535, 0, 0, 0, 65535, 0, 0, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi32(create_random__mmask16(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 2, 10, 4, 11, 6, 12, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, -1, 9, -3, 12, -5, 7, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200, 210, 400, 310, 600, 410, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 2147483647, 65535, 2147483647, 65535, 2147483647, 65535, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[65535, -1, 65535, -1, 65535, -1, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 65535, -1, 0, 2147483647, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, -2147483648, 65535, -2147483648, 65535, -2147483648, 65535, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi32(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 65535, 0, 2, 0, 65533, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 0, 200, 0, 300, 0, 400, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 65535, 0, 0, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 6, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, -1, 9, -3]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200, 210, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -2147483648, 0, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 2147483647, 65535, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[65535, -1, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2147483647, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, -2147483648, 65535, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 0, 200, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0, 0, 0, 200, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 32768, 0, 0, 0, 32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 32767, 65535, 65535, 65535, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 32768, 65535, 65535, 65535, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtepu16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtepu16_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 17179869187, 18, 34359738375, 19, 51539607563, 20, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[10, -1, 0, -3, 9, -5, 0, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[110, 200, 0, 400, 210, 600, 0, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 9223372036854775807, 65535, 9223372036854775807, 65535, 9223372036854775807, 65535, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, -1, 65535, -1, 65535, -1, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1, 65535, 9223372036854775807, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, -9223372036854775808, 65535, -9223372036854775808, 65535, -9223372036854775808, 65535, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtepu16_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtepu16_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_cvtepu16_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_cvtepu16_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0, 0, 0, 200, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, 0, 65535, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_cvtepu16_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 17179869187, 10, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[10, -1, 0, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[110, 200, 0, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808, 0, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 9223372036854775807, 65535, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, -1, 65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, -9223372036854775808, 65535, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtepu16_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtepu16_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_cvtepu16_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_cvtepu16_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, 0, 65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_cvtepu16_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[10, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[110, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_cvtepu16_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtepu16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtepu16_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_cvtepu16_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_cvtepu16_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[65535, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtepu16_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtepu16_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_cvtepu16_epi64_boundary_mixed_impl() }
}
