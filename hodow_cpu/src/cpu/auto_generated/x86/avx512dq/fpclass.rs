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
fn test_x86_avx512dq_mm_fpclass_pd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<1>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<1>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<1>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<255>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<255>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<255>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<31>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<31>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<31>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_pd_mask::<32>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_pd_mask::<32>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_pd_mask::<32>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_pd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_pd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<1>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<255>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<255>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<255>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<31>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<31>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<31>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<32>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<32>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_pd_mask::<32>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm_mask_fpclass_pd_mask::<0>(k1, a);
        let plain = _mm_fpclass_pd_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_pd_mask::<0>(k1, a) vs _mm_fpclass_pd_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_pd_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_pd_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<1>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<255>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<255>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<31>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<31>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_pd_mask::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_pd_mask::<32>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_pd_mask::<32>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_pd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_pd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<1>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<255>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<255>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<255>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<31>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<31>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<31>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_pd_mask::<32>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<32>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_pd_mask::<32>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm256_mask_fpclass_pd_mask::<0>(k1, a);
        let plain = _mm256_fpclass_pd_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_pd_mask::<0>(k1, a) vs _mm256_fpclass_pd_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_pd_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_pd_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<1>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<255>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<255>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<255>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<31>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<31>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<31>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_pd_mask::<32>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_pd_mask::<32>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_pd_mask::<32>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_pd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_pd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<1>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<255>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<255>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<255>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<31>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<31>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<31>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_pd_mask::<32>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<32>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_pd_mask::<32>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm512_mask_fpclass_pd_mask::<0>(k1, a);
        let plain = _mm512_fpclass_pd_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_pd_mask::<0>(k1, a) vs _mm512_fpclass_pd_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_pd_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_pd_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<1>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<255>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<31>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_fpclass_ps_mask::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ps_mask::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ps_mask::<32>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ps_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ps_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<1>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<255>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<255>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<255>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<31>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<31>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<31>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<32>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<32>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ps_mask::<32>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm_mask_fpclass_ps_mask::<0>(k1, a);
        let plain = _mm_fpclass_ps_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ps_mask::<0>(k1, a) vs _mm_fpclass_ps_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ps_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ps_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<0>(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<0>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<1>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<1>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<255>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<255>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<255>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<31>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<31>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<31>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_fpclass_ps_mask::<32>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_fpclass_ps_mask::<32>(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fpclass_ps_mask::<32>(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_fpclass_ps_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_fpclass_ps_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<1>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<1>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<255>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<255>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<255>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<31>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<31>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<31>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = _mm256_mask_fpclass_ps_mask::<32>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<32>(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_fpclass_ps_mask::<32>(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm256_mask_fpclass_ps_mask::<0>(k1, a);
        let plain = _mm256_fpclass_ps_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_fpclass_ps_mask::<0>(k1, a) vs _mm256_fpclass_ps_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_fpclass_ps_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_fpclass_ps_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<0>(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<0>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<1>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<1>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<255>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<255>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<255>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<31>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<31>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<31>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_fpclass_ps_mask::<32>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_fpclass_ps_mask::<32>(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_fpclass_ps_mask::<32>(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_fpclass_ps_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_fpclass_ps_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<0>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<1>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<1>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<1>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<255>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<255>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<255>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<31>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<31>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<31>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm512_mask_fpclass_ps_mask::<32>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<32>(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_fpclass_ps_mask::<32>(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let k1 = create__mmask16_from(0b0101010101010101);
        let masked = _mm512_mask_fpclass_ps_mask::<0>(k1, a);
        let plain = _mm512_fpclass_ps_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_fpclass_ps_mask::<0>(k1, a) vs _mm512_fpclass_ps_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_fpclass_ps_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_fpclass_ps_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<1>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<1>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<1>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<255>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<255>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<255>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<31>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<31>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<31>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_sd_mask::<32>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_sd_mask::<32>(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_sd_mask::<32>(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_sd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_sd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<1>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<1>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<255>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<255>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<255>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<31>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<31>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<31>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<32>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<32>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_sd_mask::<32>(create_random__mmask8(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm_mask_fpclass_sd_mask::<0>(k1, a);
        let plain = _mm_fpclass_sd_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_sd_mask::<0>(k1, a) vs _mm_fpclass_sd_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_sd_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_sd_mask_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<1>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<255>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<255>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<31>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<31>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_fpclass_ss_mask::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_fpclass_ss_mask::<32>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fpclass_ss_mask::<32>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_fpclass_ss_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_fpclass_ss_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<1>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<1>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_255_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<255>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<255>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<255>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_255_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_31_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<31>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<31>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<31>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_31_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<32>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<32>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_fpclass_ss_mask::<32>(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_imm_32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k1 = create__mmask8_from(0b01010101);
        let masked = _mm_mask_fpclass_ss_mask::<0>(k1, a);
        let plain = _mm_fpclass_ss_mask::<0>(a);
        check_int_equality(masked, k1 & plain).map_err(|e| crate::cpu::with_call(e, "_mm_mask_fpclass_ss_mask::<0>(k1, a) vs _mm_fpclass_ss_mask::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_mask_fpclass_ss_mask_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_mask_fpclass_ss_mask_vs_unmasked_impl() }
}
