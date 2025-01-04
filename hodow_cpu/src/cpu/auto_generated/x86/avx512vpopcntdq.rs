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

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 32, 1, 31, 1, 31, 2, 30, 0, 32, 1, 31, 1, 31, 2, 30]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[3, 3, 4, 3, 6, 4, 6, 3, 4, 6, 4, 4, 4, 6, 7, 3]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 31, 0, 32, 1, 31, 0, 32, 1, 31, 0, 32, 1, 31, 0, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 2, 0, 2, 0, 3, 0, 2, 0, 3, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600])));
        check_array_equality(&result, &[3, 0, 4, 0, 6, 0, 6, 0, 4, 0, 4, 0, 4, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 0, 31, 0, 31, 0, 31, 0, 31, 0, 31, 0, 31, 0, 31, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[32, 0, 32, 0, 32, 0, 32, 0, 32, 0, 32, 0, 32, 0, 32, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512i_to_i32_array(_mm512_maskz_popcnt_epi32(k, a));
        let plain = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(a));
        let expected: [i32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi32(k, a) vs _mm512_popcnt_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[2, 2, 3, 4, 3, 6, 4, 8, 3, 10, 4, 12, 4, 14, 5, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7, 2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[5, 200, 5, 400, 8, 600, 5, 800, 6, 1000, 5, 1200, 6, 1400, 7, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 2147483647, 31, 2147483647, 31, 2147483647, 31, 2147483647, 31, 2147483647, 31, 2147483647, 31, 2147483647, 31, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[32, -1, 32, -1, 32, -1, 32, -1, 32, -1, 32, -1, 32, -1, 32, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 2147483647, 0, -1, 1, 2147483647, 0, -1, 1, 2147483647, 0, -1, 1, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, -2147483648, 31, -2147483648, 31, -2147483648, 31, -2147483648, 31, -2147483648, 31, -2147483648, 31, -2147483648, 31, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512i_to_i32_array(_mm512_mask_popcnt_epi32(src, k, a));
        let plain = unpack__m512i_to_i32_array(_mm512_popcnt_epi32(a));
        let src_lanes = unpack__m512i_to_i32_array(src);
        let expected: [i32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi32(src, k, a) vs _mm512_popcnt_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 2, 1, 2, 2, 3, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 32, 1, 31, 1, 31, 2, 30]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[3, 3, 4, 3, 6, 4, 6, 3]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 31, 31, 31, 31, 31, 31, 31]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[32, 32, 32, 32, 32, 32, 32, 32]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 31, 0, 32, 1, 31, 0, 32]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi32(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 2, 0, 2, 0, 3, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[3, 0, 4, 0, 6, 0, 6, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 0, 31, 0, 31, 0, 31, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[32, 0, 32, 0, 32, 0, 32, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi32(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i32_array(_mm256_maskz_popcnt_epi32(k, a));
        let plain = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(a));
        let expected: [i32; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi32(k, a) vs _mm256_popcnt_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 2, 3, 4, 3, 6, 4, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[5, 200, 5, 400, 8, 600, 5, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 2147483647, 31, 2147483647, 31, 2147483647, 31, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[32, -1, 32, -1, 32, -1, 32, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 2147483647, 0, -1, 1, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, -2147483648, 31, -2147483648, 31, -2147483648, 31, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i32_array(_mm256_mask_popcnt_epi32(src, k, a));
        let plain = unpack__m256i_to_i32_array(_mm256_popcnt_epi32(a));
        let src_lanes = unpack__m256i_to_i32_array(src);
        let expected: [i32; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi32(src, k, a) vs _mm256_popcnt_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 2, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 32, 1, 31]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[3, 3, 4, 3]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 31, 31, 31]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[32, 32, 32, 32]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 31, 0, 32]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 0, 31, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[32, 0, 32, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi32(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i32_array(_mm_maskz_popcnt_epi32(k, a));
        let plain = unpack__m128i_to_i32_array(_mm_popcnt_epi32(a));
        let expected: [i32; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi32(k, a) vs _mm_popcnt_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[2, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[2, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[5, 200, 5, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, 2147483647, 31, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[32, -1, 32, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[31, -2147483648, 31, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i32_array(_mm_mask_popcnt_epi32(src, k, a));
        let plain = unpack__m128i_to_i32_array(_mm_popcnt_epi32(a));
        let src_lanes = unpack__m128i_to_i32_array(src);
        let expected: [i32; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi32(src, k, a) vs _mm_popcnt_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 3, 4, 4, 4, 5, 6, 5]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 64, 1, 63, 1, 63, 2, 62]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[3, 3, 4, 3, 6, 4, 6, 3]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 63, 63, 63, 63, 63, 63, 63]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[64, 64, 64, 64, 64, 64, 64, 64]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[1, 63, 0, 64, 1, 63, 0, 64]).map_err(|e| crate::cpu::with_call(e, "_mm512_popcnt_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_popcnt_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 0, 4, 0, 4, 0, 6, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[3, 0, 4, 0, 6, 0, 6, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 0, 63, 0, 63, 0, 63, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[64, 0, 64, 0, 64, 0, 64, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0, 1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_popcnt_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_maskz_popcnt_epi64(k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(a));
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_popcnt_epi64(k, a) vs _mm512_popcnt_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[4, 17179869187, 6, 34359738375, 6, 51539607563, 8, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 2, -3, 3, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[5, 200, 5, 400, 8, 600, 5, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 9223372036854775807, 63, 9223372036854775807, 63, 9223372036854775807, 63, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[64, -1, 64, -1, 64, -1, 64, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[1, 9223372036854775807, 0, -1, 1, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, -9223372036854775808, 63, -9223372036854775808, 63, -9223372036854775808, 63, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_popcnt_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_mask_popcnt_epi64(src, k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_popcnt_epi64(a));
        let src_lanes = unpack__m512i_to_i64_array(src);
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_popcnt_epi64(src, k, a) vs _mm512_popcnt_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 64, 1, 63]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([100, 200, 300, 400])));
        check_array_equality(&result, &[3, 3, 4, 3]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 63, 63, 63]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[64, 64, 64, 64]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[1, 63, 0, 64]).map_err(|e| crate::cpu::with_call(e, "_mm256_popcnt_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_popcnt_epi64(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400])));
        check_array_equality(&result, &[3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 0, 63, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[64, 0, 64, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_popcnt_epi64(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i64_array(_mm256_maskz_popcnt_epi64(k, a));
        let plain = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(a));
        let expected: [i64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_popcnt_epi64(k, a) vs _mm256_popcnt_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4, 17179869187, 6, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7])));
        check_array_equality(&result, &[2, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410])));
        check_array_equality(&result, &[5, 200, 5, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, -9223372036854775808, 1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 9223372036854775807, 63, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[64, -1, 64, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[1, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, -9223372036854775808, 63, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_popcnt_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i64_array(_mm256_mask_popcnt_epi64(src, k, a));
        let plain = unpack__m256i_to_i64_array(_mm256_popcnt_epi64(a));
        let src_lanes = unpack__m256i_to_i64_array(src);
        let expected: [i64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_popcnt_epi64(src, k, a) vs _mm256_popcnt_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 3]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 64]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[3, 3]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 63]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[64, 64]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[1, 63]).map_err(|e| crate::cpu::with_call(e, "_mm_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_popcnt_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[3, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[64, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_popcnt_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i64_array(_mm_maskz_popcnt_epi64(k, a));
        let plain = unpack__m128i_to_i64_array(_mm_popcnt_epi64(a));
        let expected: [i64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_popcnt_epi64(k, a) vs _mm_popcnt_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[2, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[5, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[64, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[63, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_popcnt_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512vpopcntdq")]
fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i64_array(_mm_mask_popcnt_epi64(src, k, a));
        let plain = unpack__m128i_to_i64_array(_mm_popcnt_epi64(a));
        let src_lanes = unpack__m128i_to_i64_array(src);
        let expected: [i64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_popcnt_epi64(src, k, a) vs _mm_popcnt_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_vs_unmasked_impl() }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct AVX512VPOPCNTDQ;

impl ExtensionTest for AVX512VPOPCNTDQ {
    fn get_name() -> &'static str {
        "x86::AVX512VPOPCNTDQ"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm512_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_vs_unmasked, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi32_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_min_max, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_min_max"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_max_min, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_asym_max_min"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_vs_unmasked, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi32_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm256_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_vs_unmasked, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi32_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_min_max, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_min_max"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_max_min, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_asym_max_min"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_vs_unmasked, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi32_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32, "test_x86_avx512vpopcntdq_mm_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_vs_unmasked, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi32_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal2, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal2"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal3, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_normal3"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_min, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_min"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_max, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_max"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_zero, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_allones, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_mixed, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_min_max, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_min_max"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_max_min, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_asym_max_min"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_vs_unmasked, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi32_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm512_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_vs_unmasked, "test_x86_avx512vpopcntdq_mm512_maskz_popcnt_epi64_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_min_max, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_min_max"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_max_min, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_asym_max_min"),
            (test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_vs_unmasked, "test_x86_avx512vpopcntdq_mm512_mask_popcnt_epi64_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm256_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_vs_unmasked, "test_x86_avx512vpopcntdq_mm256_maskz_popcnt_epi64_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_min_max, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_min_max"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_max_min, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_asym_max_min"),
            (test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_vs_unmasked, "test_x86_avx512vpopcntdq_mm256_mask_popcnt_epi64_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64, "test_x86_avx512vpopcntdq_mm_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_vs_unmasked, "test_x86_avx512vpopcntdq_mm_maskz_popcnt_epi64_vs_unmasked"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal2, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal2"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal3, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_normal3"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_min, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_min"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_max, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_max"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_zero, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_zero"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_allones, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_allones"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_mixed, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_boundary_mixed"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_min_max, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_min_max"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_max_min, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_asym_max_min"),
            (test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_vs_unmasked, "test_x86_avx512vpopcntdq_mm_mask_popcnt_epi64_vs_unmasked"),
        ]
    }
}
