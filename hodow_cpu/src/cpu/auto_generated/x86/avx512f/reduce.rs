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
fn test_x86_avx512f_mm512_reduce_add_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 136).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, -8).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 13600).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, -16).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -16).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -8).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 64).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 24).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 6400).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, -8).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -8).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 309237645376).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, -4).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 3600).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, -8).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -8).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, -4).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 137438953500).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 12).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 1600).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, -4).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -4).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 136.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, -8.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 13600.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 64.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, 24.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 6400.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 36.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, -4.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 3600.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, -f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_add_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_add_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_add_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_add_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_add_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_add_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 16.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, 12.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 1600.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, -f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_add_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_add_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_add_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 2004189184).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 2027025).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, -640614400).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 87249855438581265).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, -2628369621610135552).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 13537736917577).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 10500000000).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 20922790000000.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 2027025.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 2.0270252e22).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 40320.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 4.032e20).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_mul_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_mul_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_mul_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_mul_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_mul_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 105.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 10500000000.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_mul_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_mul_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_mul_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 16).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 1600).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 15).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 1500).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 68719476751).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 800).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 60129542157).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 700).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 16).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 1600).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 15).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 1500).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 68719476751).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]));
        check_int_equality(result, 800).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 60129542157).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]));
        check_int_equality(result, 700).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 16.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, 6.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 1600.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 15.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, 6.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 1500.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 8.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, 6.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 800.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_max_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_max_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_max_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_max_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_max_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_max_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 7.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, 6.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 700.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_max_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_max_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_max_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, -7).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, -7).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu32(create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289, 0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu32(create__mmask16_from(0b0101010101010101), create__m512i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_epu64(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_epu64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_epu64(create__mmask8_from(0b01010101), create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_epu64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, -7.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, -f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_ps(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, -0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_ps(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, -7.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_min_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_min_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, -f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_min_pd(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_min_pd(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_min_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_min_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_float_equality(result, -0.0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_min_pd(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_min_pd(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_min_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_and_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_and_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_and_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 36).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_and_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 31).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 2044).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 15).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 2044).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi32(create_random__mmask16(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 128849018895).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 1020).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_reduce_or_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_reduce_or_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_reduce_or_epi64(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_reduce_or_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_reduce_or_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 60129542157).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 1020).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_reduce_or_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_reduce_or_epi64(create_random__mmask8(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_reduce_or_epi64_boundary_mixed_impl() }
}
