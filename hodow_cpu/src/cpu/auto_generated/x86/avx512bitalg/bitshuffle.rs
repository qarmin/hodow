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
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]));
        check_int_equality(result, 17216961135462248174).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]));
        check_int_equality(result, 3535325708058361856).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 17294086455919964160).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "_mm512_bitshuffle_epi64_mask(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_bitshuffle_epi64_mask(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_bitshuffle_epi64_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]));
        check_int_equality(result, 4919131752989213764).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]));
        check_int_equality(result, 1229482698272145408).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 6148914691236517205).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 5764695485306654720).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 6148914691236517205).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 6148914691236517205).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_bitshuffle_epi64_mask(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let b = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let c = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let masked = _mm512_mask_bitshuffle_epi64_mask(k, b, c);
        let plain = _mm512_bitshuffle_epi64_mask(b, c);
        check_int_equality(masked, k & plain).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_bitshuffle_epi64_mask(k, b, c) vs _mm512_bitshuffle_epi64_mask(b, c)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm512_mask_bitshuffle_epi64_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 4008636142).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]));
        check_int_equality(result, 572522496).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 4026593280).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "_mm256_bitshuffle_epi64_mask(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_bitshuffle_epi64_mask(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_bitshuffle_epi64_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1145324612).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 1431655765).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 1342197760).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 1431655765).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 1431655765).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_bitshuffle_epi64_mask(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let b = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let c = create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let masked = _mm256_mask_bitshuffle_epi64_mask(k, b, c);
        let plain = _mm256_bitshuffle_epi64_mask(b, c);
        check_int_equality(masked, k & plain).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_bitshuffle_epi64_mask(k, b, c) vs _mm256_bitshuffle_epi64_mask(b, c)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm256_mask_bitshuffle_epi64_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result, 61166).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 61440).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_bitshuffle_epi64_mask(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_bitshuffle_epi64_mask(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_bitshuffle_epi64_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result, 17476).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal2_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_normal3_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, 21845).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 20480).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 21845).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 21845).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_bitshuffle_epi64_mask(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bitalg")]
fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let b = create__m128i_from_i32_array([1, 2, 3, 4]);
        let c = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = _mm_mask_bitshuffle_epi64_mask(k, b, c);
        let plain = _mm_bitshuffle_epi64_mask(b, c);
        check_int_equality(masked, k & plain).map_err(|e| crate::cpu::with_call(e, "_mm_mask_bitshuffle_epi64_mask(k, b, c) vs _mm_bitshuffle_epi64_mask(b, c)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bitalg_mm_mask_bitshuffle_epi64_mask_vs_unmasked_impl() }
}
