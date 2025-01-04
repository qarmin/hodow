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
fn test_x86_avx512bw_mm512_broadcastw_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastw_epi16(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 10, -3, 10, -5, 10, -7, 10, -1, 10, -3, 10, -5, 10, -7, 10, -1, 10, -3, 10, -5, 10, -7, 10, -1, 10, -3, 10, -5, 10, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 110, 400, 110, 600, 110, 800, 110, 1000, 110, 1200, 110, 1400, 110, 1600, 110, 1800, 110, 2000, 110, 2200, 110, 2400, 110, 2600, 110, 2800, 110, 3000, 110, 3200]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastw_epi16(create_random__m512i(), create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m512i_to_i16_array(_mm512_mask_broadcastw_epi16(src, k, a));
        let plain = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(a));
        let src_lanes = unpack__m512i_to_i16_array(src);
        let expected: [i16; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastw_epi16(src, k, a) vs _mm512_broadcastw_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_broadcastw_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_broadcastw_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(create__mmask32_from(0x55555555u32), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastw_epi16(create_random__mmask32(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = unpack__m512i_to_i16_array(_mm512_maskz_broadcastw_epi16(k, a));
        let plain = unpack__m512i_to_i16_array(_mm512_broadcastw_epi16(a));
        let expected: [i16; 32] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastw_epi16(k, a) vs _mm512_broadcastw_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_broadcastw_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_broadcastw_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 10, -3, 10, -5, 10, -7, 10, -1, 10, -3, 10, -5, 10, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 110, 400, 110, 600, 110, 800, 110, 1000, 110, 1200, 110, 1400, 110, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1, -32768, 32767, -32768, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastw_epi16(create_random__m256i(), create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw,avx2")]
fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m256i_to_i16_array(_mm256_mask_broadcastw_epi16(src, k, a));
        let plain = unpack__m256i_to_i16_array(_mm256_broadcastw_epi16(a));
        let src_lanes = unpack__m256i_to_i16_array(src);
        let expected: [i16; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastw_epi16(src, k, a) vs _mm256_broadcastw_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_broadcastw_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_broadcastw_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0, 100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastw_epi16(create_random__mmask16(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw,avx2")]
fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m256i_to_i16_array(_mm256_maskz_broadcastw_epi16(k, a));
        let plain = unpack__m256i_to_i16_array(_mm256_broadcastw_epi16(a));
        let expected: [i16; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastw_epi16(k, a) vs _mm256_broadcastw_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_broadcastw_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_broadcastw_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 5, 0, 5, 0, 5, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 10, -3, 10, -5, 10, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 110, 400, 110, 600, 110, 800]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, -32768, -1, -32768, 32767, -32768, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, 32767, -32768, 32767, -32768, 32767, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, -32768, 32767, -32768, 32767, -32768, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastw_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw,avx2")]
fn test_x86_avx512bw_mm_mask_broadcastw_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i16_array(_mm_mask_broadcastw_epi16(src, k, a));
        let plain = unpack__m128i_to_i16_array(_mm_broadcastw_epi16(a));
        let src_lanes = unpack__m128i_to_i16_array(src);
        let expected: [i16; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastw_epi16(src, k, a) vs _mm_broadcastw_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_broadcastw_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_broadcastw_epi16_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 100, 0, 100, 0, 100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 0, 32767, 0, 32767, 0, 32767, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 0, -32768, 0, -32768, 0, -32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(create__mmask8_from(0b01010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastw_epi16(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw,avx2")]
fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i16_array(_mm_maskz_broadcastw_epi16(k, a));
        let plain = unpack__m128i_to_i16_array(_mm_broadcastw_epi16(a));
        let expected: [i16; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastw_epi16(k, a) vs _mm_broadcastw_epi16(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_broadcastw_epi16_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_broadcastw_epi16_vs_unmasked_impl() }
}
