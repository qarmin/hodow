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
fn test_x86_avx512f_mm512_permutex_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 8589934593, 42949672969, 42949672969, 42949672969, 42949672969]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 0, 0, 4, 4, 4, 4]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 100, 100, 100, 500, 500, 500, 500]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<0>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[17179869187, 8589934593, 8589934593, 8589934593, 51539607563, 42949672969, 42949672969, 42949672969]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<1>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[34359738375, 34359738375, 34359738375, 34359738375, 68719476751, 68719476751, 68719476751, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<255>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<63>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[34359738375, 34359738375, 34359738375, 8589934593, 68719476751, 68719476751, 68719476751, 42949672969]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<63>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<63>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_epi64_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<64>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 17179869187, 42949672969, 42949672969, 42949672969, 51539607563]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_epi64::<64>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_epi64::<64>(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[77309411345, 17179869187, 77309411345, 34359738375, 111669149721, 51539607563, 111669149721, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 10, -3, 14, -5, 14, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 110, 400, 510, 600, 510, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, -1, -9223372036854775808, 9223372036854775807, -9223372036854775808, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[85899345939, 17179869187, 77309411345, 34359738375, 120259084315, 51539607563, 111669149721, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<1>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[103079215127, 17179869187, 103079215127, 34359738375, 137438953503, 51539607563, 137438953503, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<255>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<63>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[103079215127, 17179869187, 103079215127, 34359738375, 137438953503, 51539607563, 137438953503, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<63>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<63>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<64>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[77309411345, 17179869187, 77309411345, 34359738375, 111669149721, 51539607563, 111669149721, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<64>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_epi64::<64>(create_random__m512i(), create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_mask_permutex_epi64::<0>(src, k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(a));
        let src_lanes = unpack__m512i_to_i64_array(src);
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_epi64::<0>(src, k, a) vs _mm512_permutex_epi64::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934593, 0, 8589934593, 0, 42949672969, 0, 42949672969, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 0, 0, 4, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 0, 100, 0, 500, 0, 500, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<1>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[17179869187, 0, 8589934593, 0, 51539607563, 0, 42949672969, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<1>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<1>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<255>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[34359738375, 0, 34359738375, 0, 68719476751, 0, 68719476751, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<255>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<255>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_63_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<63>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[34359738375, 0, 34359738375, 0, 68719476751, 0, 68719476751, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<63>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<63>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<64>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934593, 0, 8589934593, 0, 42949672969, 0, 42949672969, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<64>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_epi64::<64>(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_maskz_permutex_epi64::<0>(k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_permutex_epi64::<0>(a));
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_epi64::<0>(k, a) vs _mm512_permutex_epi64::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 100, 100, 100]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[17179869187, 8589934593, 8589934593, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<1>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[34359738375, 34359738375, 34359738375, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<255>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<63>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[34359738375, 34359738375, 34359738375, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<63>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<63>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_epi64_imm_64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<64>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_epi64::<64>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_epi64::<64>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[42949672969, 17179869187, 42949672969, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, -1, 10, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200, 110, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[51539607563, 17179869187, 42949672969, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<1>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[68719476751, 17179869187, 68719476751, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<255>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<63>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[68719476751, 17179869187, 68719476751, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<63>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<63>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<64>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[42949672969, 17179869187, 42949672969, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<64>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_epi64::<64>(create_random__m256i(), create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i64_array(_mm256_mask_permutex_epi64::<0>(src, k, a));
        let plain = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(a));
        let src_lanes = unpack__m256i_to_i64_array(src);
        let expected: [i64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_epi64::<0>(src, k, a) vs _mm256_permutex_epi64::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 0, 8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 0, 100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0, 9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<0>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[17179869187, 0, 8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<1>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<255>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[34359738375, 0, 34359738375, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<255>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<255>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_63_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<63>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[34359738375, 0, 34359738375, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<63>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<63>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_63() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_imm_63_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<64>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 0, 8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<64>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_epi64::<64>(create_random__mmask8(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_imm_64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_imm_64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i64_array(_mm256_maskz_permutex_epi64::<0>(k, a));
        let plain = unpack__m256i_to_i64_array(_mm256_permutex_epi64::<0>(a));
        let expected: [i64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_epi64::<0>(k, a) vs _mm256_permutex_epi64::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 5.0, 5.0, 5.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 4.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 100.0, 100.0, 100.0, 500.0, 500.0, 500.0, 500.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0, 6.0, 5.0, 5.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<1>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<255>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 4.0, 4.0, 8.0, 8.0, 8.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<255>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<255>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<31>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 2.0, 1.0, 8.0, 8.0, 6.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<31>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<31>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_imm_31_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_permutex_pd_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_permutex_pd::<32>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 1.0, 5.0, 5.0, 7.0, 5.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_permutex_pd::<32>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_permutex_pd::<32>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_permutex_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_permutex_pd_imm_32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 9.0, 4.0, 13.0, 6.0, 13.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0, 10.0, -3.0, 14.0, -5.0, 14.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0, 110.0, 400.0, 510.0, 600.0, 510.0, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, f64::INFINITY, 1.1125369292536007e-308, f64::INFINITY, -f64::INFINITY, f64::INFINITY, 1.1125369292536007e-308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<0>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[10.0, 2.0, 9.0, 4.0, 14.0, 6.0, 13.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<1>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<255>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[12.0, 2.0, 12.0, 4.0, 16.0, 6.0, 16.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<255>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<255>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<31>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[12.0, 2.0, 10.0, 4.0, 16.0, 6.0, 14.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<31>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<31>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_imm_31_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<32>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_float_array_equality(&result, &[9.0, 2.0, 11.0, 4.0, 13.0, 6.0, 15.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<32>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_permutex_pd::<32>(create_random__m512d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_imm_32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_permutex_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let src = create__m512d_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512d_to_f64_array(_mm512_mask_permutex_pd::<0>(src, k, a));
        let plain = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(a));
        let src_lanes = unpack__m512d_to_f64_array(src);
        let expected: [f64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_permutex_pd::<0>(src, k, a) vs _mm512_permutex_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_permutex_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_permutex_pd_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 5.0, 0.0, 5.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 4.0, 0.0, 4.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0, 100.0, 0.0, 500.0, 0.0, 500.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0, f64::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[2.0, 0.0, 1.0, 0.0, 6.0, 0.0, 5.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<1>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<255>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[4.0, 0.0, 4.0, 0.0, 8.0, 0.0, 8.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<255>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<255>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<31>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[4.0, 0.0, 2.0, 0.0, 8.0, 0.0, 6.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<31>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<31>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_imm_31_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<32>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<32>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_permutex_pd::<32>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_imm_32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_permutex_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512d_to_f64_array(_mm512_maskz_permutex_pd::<0>(k, a));
        let plain = unpack__m512d_to_f64_array(_mm512_permutex_pd::<0>(a));
        let expected: [f64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_permutex_pd::<0>(k, a) vs _mm512_permutex_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_permutex_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_permutex_pd_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 100.0, 100.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<1>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 4.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<255>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 4.0, 2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<31>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_imm_31_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_permutex_pd_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_permutex_pd::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.0, 3.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutex_pd::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutex_pd::<32>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_permutex_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_permutex_pd_imm_32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 5.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0, 10.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0, 110.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY, f64::INFINITY, 1.1125369292536007e-308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308, -1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<0>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[6.0, 2.0, 5.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<1>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[8.0, 2.0, 8.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<255>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[8.0, 2.0, 6.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<31>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_imm_31_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 7.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_permutex_pd::<32>(create_random__m256d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_imm_32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_permutex_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let src = create__m256d_from([5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256d_to_f64_array(_mm256_mask_permutex_pd::<0>(src, k, a));
        let plain = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(a));
        let src_lanes = unpack__m256d_to_f64_array(src);
        let expected: [f64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_permutex_pd::<0>(src, k, a) vs _mm256_permutex_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_permutex_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_permutex_pd_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0, 100.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0, -1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0, 1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0, f64::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0, f64::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<1>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_255_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<255>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 0.0, 4.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<255>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<255>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_imm_255_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_31_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<31>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 0.0, 2.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<31>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<31>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_imm_31_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<32>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<32>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_permutex_pd::<32>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_imm_32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_permutex_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256d_to_f64_array(_mm256_maskz_permutex_pd::<0>(k, a));
        let plain = unpack__m256d_to_f64_array(_mm256_permutex_pd::<0>(a));
        let expected: [f64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_permutex_pd::<0>(k, a) vs _mm256_permutex_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_permutex_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_permutex_pd_vs_unmasked_impl() }
}
