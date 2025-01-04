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

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8));
        check_array_equality(&result, &[9, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), 1i8));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), 1i8));
        check_array_equality(&result, &[1, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), 1i8));
        check_array_equality(&result, &[1, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), 1i8));
        check_array_equality(&result, &[1, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), 1i8));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), 1i8));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), 1i8));
        check_array_equality(&result, &[1, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<0>(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), 1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<0>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8));
        check_array_equality(&result, &[1, 9, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<1>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<31>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 9]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<31>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<31>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_imm_31_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 9, 3, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<7>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_imm_7_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi8_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_insert_epi8::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8));
        check_array_equality(&result, &[1, 0, 0, 0, 2, 0, 0, 0, 9, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi8::<8>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi8::<8>(create_random__m256i(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi8_imm_8_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[9, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), 1i16));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), 1i16));
        check_array_equality(&result, &[1, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16));
        check_array_equality(&result, &[1, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16));
        check_array_equality(&result, &[1, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), 1i16));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), 1i16));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16));
        check_array_equality(&result, &[1, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1, -32768, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<0>(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<0>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[1, 9, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<1>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<15>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 9]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<15>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<15>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_imm_15() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_imm_15_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi16_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_insert_epi16::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 9, 5, 0, 6, 0, 7, 0, 8, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi16::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi16::<7>(create_random__m256i(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi16_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi16_imm_7_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), 1i32));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), 1i32));
        check_array_equality(&result, &[1, 200, 300, 400, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32));
        check_array_equality(&result, &[1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32));
        check_array_equality(&result, &[1, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), 1i32));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), 1i32));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), 1i32));
        check_array_equality(&result, &[1, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<0>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[1, 9, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<1>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 9]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<7>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<7>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_imm_7_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_insert_epi32_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi32::<3>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[1, 2, 3, 9, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi32::<3>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi32::<3>(create_random__m256i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_insert_epi32_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_insert_epi32_imm_3_impl() }
}
