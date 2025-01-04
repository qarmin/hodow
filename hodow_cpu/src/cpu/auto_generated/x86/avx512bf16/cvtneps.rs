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

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[16256, 16384, 16448, 16512, 16544, 16576, 16608, 16640]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, 49024, 16384, 49216, 16512, 49312, 16576, 49376]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_array_equality(&result, &[17096, 17224, 17302, 17352, 17402, 17430, 17455, 17480]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_cvtneps_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 65408, 32768, 0, 32640, 65408, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtneps_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtneps_pbh(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[16656, 2, 16688, 4, 16720, 6, 16752, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, 2, 16384, 4, 16512, 6, 16576, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_array_equality(&result, &[17096, 2, 17302, 4, 17402, 6, 17455, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 2, 32704, 4, 32704, 6, 32704, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 2, 32768, 4, 32640, 6, 32768, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[16256, 0, 16448, 0, 16544, 0, 16608, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, 0, 16384, 0, 16512, 0, 16576, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32])));
        check_array_equality(&result, &[17096, 0, 17302, 0, 17402, 0, 17455, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 0, 32704, 0, 32704, 0, 32704, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 0, 32768, 0, 32640, 0, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[16256, 16384, 16448, 16512, 16544, 16576, 16608, 16640, 16656, 16672, 16688, 16704, 16720, 16736, 16752, 16768]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, 49024, 16384, 49216, 16512, 49312, 16576, 49376, 0, 49024, 16384, 49216, 16512, 49312, 16576, 49376]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_array_equality(&result, &[17096, 17224, 17302, 17352, 17402, 17430, 17455, 17480, 17505, 17530, 17546, 17558, 17570, 17583, 17596, 17608]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_cvtneps_pbh(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtneps_pbh(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtneps_pbh(create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[16776, 2, 16792, 4, 16808, 6, 16824, 8, 16840, 10, 16856, 12, 16872, 14, 16888, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, 2, 16384, 4, 16512, 6, 16576, 8, 0, 10, 16384, 12, 16512, 14, 16576, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_array_equality(&result, &[17096, 2, 17302, 4, 17402, 6, 17455, 8, 17505, 10, 17546, 12, 17570, 14, 17596, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8, 65408, 10, 65408, 12, 65408, 14, 65408, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8, 32640, 10, 32640, 12, 32640, 14, 32640, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 2, 32704, 4, 32704, 6, 32704, 8, 32704, 10, 32704, 12, 32704, 14, 32704, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 2, 32768, 4, 32640, 6, 32768, 8, 32640, 10, 32768, 12, 32640, 14, 32768, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtneps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtneps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[16256, 0, 16448, 0, 16544, 0, 16608, 0, 16656, 0, 16688, 0, 16720, 0, 16752, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32])));
        check_array_equality(&result, &[0, 0, 16384, 0, 16512, 0, 16576, 0, 0, 0, 16384, 0, 16512, 0, 16576, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32])));
        check_array_equality(&result, &[17096, 0, 17302, 0, 17402, 0, 17455, 0, 17505, 0, 17546, 0, 17570, 0, 17596, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtneps_pbh(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtneps_pbh(create_random__mmask16(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[16256, 16384, 16448, 16512, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 49024, 16384, 49216, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[17096, 17224, 17302, 17352, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 32704, 32704, 32704, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtneps_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 65408, 32768, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtneps_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtneps_pbh(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[16656, 2, 16688, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 2, 16384, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[17096, 2, 17302, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 2, 32704, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 2, 32768, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtneps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[16256, 0, 16448, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 0, 16384, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[17096, 0, 17302, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 0, 32704, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 0, 32768, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtneps_pbh_boundary_mixed_impl() }
}
