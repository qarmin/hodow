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
fn test_x86_avx512bf16_mm_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_dpbf16_ps(create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_dpbf16_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_dpbf16_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]), create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_dpbf16_ps(create_random__mmask8(), create_random__m128(), create_random__m128bh(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let a = create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]);
        let b = create__m128bh_from([13, 14, 15, 16, 17, 18, 19, 20]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128_to_f32_array(_mm_maskz_dpbf16_ps(k, src, a, b));
        let plain = unpack__m128_to_f32_array(_mm_dpbf16_ps(src, a, b));
        let expected: [f32; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_dpbf16_ps(k, src, a, b) vs _mm_dpbf16_ps(src, a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_dpbf16_ps_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_dpbf16_ps_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_dpbf16_ps(create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_dpbf16_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_dpbf16_ps(create_random__m256(), create_random__mmask8(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(create__mmask8_from(0b01010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_dpbf16_ps(create_random__mmask8(), create_random__m256(), create_random__m256bh(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let a = create__m256bh_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]);
        let b = create__m256bh_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256_to_f32_array(_mm256_maskz_dpbf16_ps(k, src, a, b));
        let plain = unpack__m256_to_f32_array(_mm256_dpbf16_ps(src, a, b));
        let expected: [f32; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_dpbf16_ps(k, src, a, b) vs _mm256_dpbf16_ps(src, a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_dpbf16_ps_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_dpbf16_ps_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0, f32::INFINITY, -f32::INFINITY, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_dpbf16_ps(create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 1600.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, 0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_dpbf16_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_dpbf16_ps(create_random__m512(), create_random__mmask16(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80])));
        check_float_array_equality(&result, &[1.0, 0.0, 3.0, 0.0, 5.0, 0.0, 7.0, 0.0, 9.0, 0.0, 11.0, 0.0, 13.0, 0.0, 15.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]), create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0, 0.0, 0.0, 2.0, 0.0, 4.0, 0.0, 6.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[100.0, 0.0, 300.0, 0.0, 500.0, 0.0, 700.0, 0.0, 900.0, 0.0, 1100.0, 0.0, 1300.0, 0.0, 1500.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[-3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0, -3.4028235e38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0, 3.4028235e38, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0, f32::NAN, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0, f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(create__mmask16_from(0b0101010101010101), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512bh_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_dpbf16_ps(create_random__mmask16(), create_random__m512(), create_random__m512bh(), create_random__m512bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let a = create__m512bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]);
        let b = create__m512bh_from([49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512_to_f32_array(_mm512_maskz_dpbf16_ps(k, src, a, b));
        let plain = unpack__m512_to_f32_array(_mm512_dpbf16_ps(src, a, b));
        let expected: [f32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0.0 });
        check_float_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_dpbf16_ps(k, src, a, b) vs _mm512_dpbf16_ps(src, a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_dpbf16_ps_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_dpbf16_ps_vs_unmasked_impl() }
}
