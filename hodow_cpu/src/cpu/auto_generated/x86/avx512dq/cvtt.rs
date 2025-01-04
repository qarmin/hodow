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

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundpd_epi64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundpd_epi64::<8>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtt_roundpd_epi64::<4>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundpd_epi64::<4>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundpd_epi64::<4>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epi64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundpd_epi64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundpd_epi64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epi64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epi64::<4>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epi64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundpd_epi64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundpd_epi64::<8>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtt_roundpd_epi64::<4>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundpd_epi64::<4>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundpd_epi64::<4>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epi64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundps_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtt_roundps_epi64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundps_epi64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundps_epi64::<8>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundps_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundps_epi64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_cvtt_roundps_epi64::<4>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundps_epi64::<4>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundps_epi64::<4>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundps_epi64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundps_epi64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -3, 5, -5, 7, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -9223372036854775808, 3, -9223372036854775808, 5, -9223372036854775808, 7, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, 9223372036854775807, 5, 9223372036854775807, 7, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, -1, 3, -1, 5, -1, 7, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 9223372036854775807, 3, -1, 5, 9223372036854775807, 7, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<8>(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_cvtt_roundps_epi64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epi64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epi64::<4>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epi64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtt_roundps_epi64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundps_epi64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundps_epi64::<8>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_cvtt_roundps_epi64::<4>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundps_epi64::<4>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundps_epi64::<4>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundps_epi64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundpd_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvtt_roundpd_epu64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundpd_epu64::<8>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundpd_epu64::<8>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundpd_epu64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvtt_roundpd_epu64::<4>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundpd_epu64::<4>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundpd_epu64::<4>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundpd_epu64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundpd_epu64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613, 5, 18446744073709551611, 7, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundpd_epu64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundpd_epu64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512d_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundpd_epu64::<4>(create_random__m512i(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundpd_epu64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvtt_roundpd_epu64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundpd_epu64::<8>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundpd_epu64::<8>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvtt_roundpd_epu64::<4>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundpd_epu64::<4>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundpd_epu64::<4>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundpd_epu64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundps_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvtt_roundps_epu64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundps_epu64::<8>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundps_epu64::<8>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundps_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_cvtt_roundps_epu64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_cvtt_roundps_epu64::<4>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtt_roundps_epu64::<4>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtt_roundps_epu64::<4>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_cvtt_roundps_epu64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_cvtt_roundps_epu64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551613, 5, 18446744073709551611, 7, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((18446744073709551615u64) as i64), ((2u64) as i64), ((18446744073709551613u64) as i64), ((4u64) as i64), ((18446744073709551611u64) as i64), ((6u64) as i64), ((18446744073709551609u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 200, 3, 400, 5, 600, 7, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((100u64) as i64), ((200u64) as i64), ((300u64) as i64), ((400u64) as i64), ((500u64) as i64), ((600u64) as i64), ((700u64) as i64), ((800u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64), ((u64::MIN) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64), ((0u64) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 18446744073709551615, 3, 18446744073709551615, 5, 18446744073709551615, 7, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<8>(create__m512i_from([((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64), ((u64::MIN) as i64), ((u64::MAX) as i64), ((0u64) as i64), ((u64::MAX) as i64)]), create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<8>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_mask_cvtt_roundps_epu64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_array_equality(&result, &[17, 17179869187, 19, 34359738375, 21, 51539607563, 23, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtt_roundps_epu64::<4>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtt_roundps_epu64::<4>(create_random__m512i(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_cvtt_roundps_epu64_imm_4_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epu64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvtt_roundps_epu64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundps_epu64::<8>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundps_epu64::<8>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epu64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundps_epu64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epu64_imm_4_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m512i_to_u64_array(_mm512_maskz_cvtt_roundps_epu64::<4>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtt_roundps_epu64::<4>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtt_roundps_epu64::<4>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_cvtt_roundps_epu64_imm_4() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_cvtt_roundps_epu64_imm_4_impl() }
}
