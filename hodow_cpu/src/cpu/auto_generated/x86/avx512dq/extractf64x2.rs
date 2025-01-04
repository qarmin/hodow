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
fn test_x86_avx512dq_mm256_extractf64x2_pd_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<0>(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<0>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_extractf64x2_pd_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_extractf64x2_pd::<1>(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extractf64x2_pd::<1>(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_extractf64x2_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_extractf64x2_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m256d_from([3.0, 4.0, 5.0, 6.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m256d_from([3.0, 4.0, 5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m256d_from([3.0, 4.0, 5.0, 6.0])));
        check_float_array_equality(&result, &[5.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m256d_from([3.0, 4.0, 5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_extractf64x2_pd::<1>(create_random__m128d(), create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let src = create__m128d_from([5.0, 6.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128d_to_f64_array(_mm256_mask_extractf64x2_pd::<0>(src, k, a));
        let plain = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(a));
        let src_lanes = unpack__m128d_to_f64_array(src);
        let expected: [f64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_extractf64x2_pd::<0>(src, k, a) vs _mm256_extractf64x2_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_extractf64x2_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_extractf64x2_pd_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<1>(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_extractf64x2_pd::<1>(create_random__mmask8(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128d_to_f64_array(_mm256_maskz_extractf64x2_pd::<0>(k, a));
        let plain = unpack__m128d_to_f64_array(_mm256_extractf64x2_pd::<0>(a));
        let expected: [f64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_extractf64x2_pd::<0>(k, a) vs _mm256_extractf64x2_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_extractf64x2_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_extractf64x2_pd_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<0>(create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<0>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<1>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<1>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_extractf64x2_pd_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<3>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_extractf64x2_pd::<3>(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_extractf64x2_pd::<3>(create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_extractf64x2_pd_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_extractf64x2_pd_imm_3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([0.0f64, -1.0f64]), create__mmask8_from(0b01010101), create__m512d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64, 14.0f64, 5.0f64, 16.0f64, 3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([100.0f64, 200.0f64]), create__mmask8_from(0b01010101), create__m512d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64, 510.0f64, 610.0f64, 710.0f64, 810.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([0.0, 0.0]), create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::NAN, f64::NAN]), create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MIN, f64::MIN]), create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(create__m128d_from([f64::MAX, f64::MAX]), create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<0>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0])));
        check_float_array_equality(&result, &[5.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<1>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<1>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<3>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0])));
        check_float_array_equality(&result, &[9.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<3>(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m512d_from([3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_extractf64x2_pd::<3>(create_random__m128d(), create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_imm_3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let src = create__m128d_from([9.0, 10.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128d_to_f64_array(_mm512_mask_extractf64x2_pd::<0>(src, k, a));
        let plain = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(a));
        let src_lanes = unpack__m128d_to_f64_array(src);
        let expected: [f64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_extractf64x2_pd::<0>(src, k, a) vs _mm512_extractf64x2_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_extractf64x2_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_extractf64x2_pd_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64])));
        check_float_array_equality(&result, &[100.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(create__mmask8_from(0b01010101), create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<0>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[3.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<1>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<1>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<3>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[7.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<3>(create__mmask8_from(0b01010101), create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_extractf64x2_pd::<3>(create_random__mmask8(), create_random__m512d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_imm_3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128d_to_f64_array(_mm512_maskz_extractf64x2_pd::<0>(k, a));
        let plain = unpack__m128d_to_f64_array(_mm512_extractf64x2_pd::<0>(a));
        let expected: [f64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_extractf64x2_pd::<0>(k, a) vs _mm512_extractf64x2_pd::<0>(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_extractf64x2_pd_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_extractf64x2_pd_vs_unmasked_impl() }
}
