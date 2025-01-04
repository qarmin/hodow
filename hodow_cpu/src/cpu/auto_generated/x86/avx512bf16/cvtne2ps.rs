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
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[16544, 16576, 16608, 16640, 16256, 16384, 16448, 16512]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_array_equality(&result, &[16672, 16656, 16704, 16608, 0, 49024, 16384, 49216]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_array_equality(&result, &[17116, 17234, 17307, 17357, 17096, 17224, 17302, 17352]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 65408, 32768, 0, 32640, 65408, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_cvtne2ps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtne2ps_pbh(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtne2ps_pbh(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]), create__m128_from([13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[16720, 2, 16752, 4, 16656, 6, 16688, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([9.0, 10.0, 11.0, 12.0]), create__m128_from([13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_array_equality(&result, &[16672, 2, 16704, 4, 0, 6, 16384, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_array_equality(&result, &[17116, 2, 17307, 4, 17096, 6, 17302, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 2, 32704, 4, 32704, 6, 32704, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 2, 32768, 4, 32640, 6, 32768, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 65408, 6, 65408, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 32640, 6, 32640, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtne2ps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtne2ps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[16544, 0, 16608, 0, 16256, 0, 16448, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_array_equality(&result, &[16672, 0, 16704, 0, 0, 0, 16384, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_array_equality(&result, &[17116, 0, 17307, 0, 17096, 0, 17302, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 0, 32704, 0, 32704, 0, 32704, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 0, 32768, 0, 32640, 0, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128bh_to_u16_array(_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtne2ps_pbh(create__mmask8_from(0b01010101), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtne2ps_pbh(create_random__mmask8(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[16656, 16672, 16688, 16704, 16720, 16736, 16752, 16768, 16256, 16384, 16448, 16512, 16544, 16576, 16608, 16640]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_array_equality(&result, &[16672, 16656, 16704, 16608, 16736, 16544, 16768, 16448, 0, 49024, 16384, 49216, 16512, 49312, 16576, 49376]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_array_equality(&result, &[17116, 17234, 17307, 17357, 17407, 17432, 17458, 17482, 17096, 17224, 17302, 17352, 17402, 17430, 17455, 17480]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_cvtne2ps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtne2ps_pbh(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtne2ps_pbh(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]), create__m256_from([25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[16840, 2, 16856, 4, 16872, 6, 16888, 8, 16776, 10, 16792, 12, 16808, 14, 16824, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]), create__m256_from([25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_array_equality(&result, &[16672, 2, 16704, 4, 16736, 6, 16768, 8, 0, 10, 16384, 12, 16512, 14, 16576, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_array_equality(&result, &[17116, 2, 17307, 4, 17407, 6, 17458, 8, 17096, 10, 17302, 12, 17402, 14, 17455, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8, 65408, 10, 65408, 12, 65408, 14, 65408, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8, 32640, 10, 32640, 12, 32640, 14, 32640, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 2, 32704, 4, 32704, 6, 32704, 8, 32704, 10, 32704, 12, 32704, 14, 32704, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 2, 32768, 4, 32640, 6, 32768, 8, 32640, 10, 32768, 12, 32640, 14, 32768, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8, 65408, 10, 65408, 12, 65408, 14, 65408, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8, 32640, 10, 32640, 12, 32640, 14, 32640, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtne2ps_pbh(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtne2ps_pbh(create_random__m256bh(), create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[16656, 0, 16688, 0, 16720, 0, 16752, 0, 16256, 0, 16448, 0, 16544, 0, 16608, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_array_equality(&result, &[16672, 0, 16704, 0, 16736, 0, 16768, 0, 0, 0, 16384, 0, 16512, 0, 16576, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32])));
        check_array_equality(&result, &[17116, 0, 17307, 0, 17407, 0, 17458, 0, 17096, 0, 17302, 0, 17402, 0, 17455, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256bh_to_u16_array(_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtne2ps_pbh(create__mmask16_from(0b0101010101010101), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtne2ps_pbh(create_random__mmask16(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[16776, 16784, 16792, 16800, 16808, 16816, 16824, 16832, 16840, 16848, 16856, 16864, 16872, 16880, 16888, 16896, 16256, 16384, 16448, 16512, 16544, 16576, 16608, 16640, 16656, 16672, 16688, 16704, 16720, 16736, 16752, 16768]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_array_equality(&result, &[16672, 16656, 16704, 16608, 16736, 16544, 16768, 16448, 16672, 16656, 16704, 16608, 16736, 16544, 16768, 16448, 0, 49024, 16384, 49216, 16512, 49312, 16576, 49376, 0, 49024, 16384, 49216, 16512, 49312, 16576, 49376]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_array_equality(&result, &[17116, 17234, 17307, 17357, 17407, 17432, 17458, 17482, 17508, 17532, 17547, 17559, 17572, 17584, 17597, 17609, 17096, 17224, 17302, 17352, 17402, 17430, 17455, 17480, 17505, 17530, 17546, 17558, 17570, 17583, 17596, 17608]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704, 32704]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0, 32640, 65408, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_cvtne2ps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 65408, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640, 32640]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtne2ps_pbh(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtne2ps_pbh(create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]), create__m512_from([49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0, 64.0])));
        check_array_equality(&result, &[16964, 2, 16972, 4, 16980, 6, 16988, 8, 16996, 10, 17004, 12, 17012, 14, 17020, 16, 16900, 18, 16908, 20, 16916, 22, 16924, 24, 16932, 26, 16940, 28, 16948, 30, 16956, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0]), create__m512_from([49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0, 64.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_array_equality(&result, &[16672, 2, 16704, 4, 16736, 6, 16768, 8, 16672, 10, 16704, 12, 16736, 14, 16768, 16, 0, 18, 16384, 20, 16512, 22, 16576, 24, 0, 26, 16384, 28, 16512, 30, 16576, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_array_equality(&result, &[17116, 2, 17307, 4, 17407, 6, 17458, 8, 17508, 10, 17547, 12, 17572, 14, 17597, 16, 17096, 18, 17302, 20, 17402, 22, 17455, 24, 17505, 26, 17546, 28, 17570, 30, 17596, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8, 65408, 10, 65408, 12, 65408, 14, 65408, 16, 65408, 18, 65408, 20, 65408, 22, 65408, 24, 65408, 26, 65408, 28, 65408, 30, 65408, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8, 32640, 10, 32640, 12, 32640, 14, 32640, 16, 32640, 18, 32640, 20, 32640, 22, 32640, 24, 32640, 26, 32640, 28, 32640, 30, 32640, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 2, 0, 4, 0, 6, 0, 8, 0, 10, 0, 12, 0, 14, 0, 16, 0, 18, 0, 20, 0, 22, 0, 24, 0, 26, 0, 28, 0, 30, 0, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 2, 32704, 4, 32704, 6, 32704, 8, 32704, 10, 32704, 12, 32704, 14, 32704, 16, 32704, 18, 32704, 20, 32704, 22, 32704, 24, 32704, 26, 32704, 28, 32704, 30, 32704, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 2, 32768, 4, 32640, 6, 32768, 8, 32640, 10, 32768, 12, 32640, 14, 32768, 16, 32640, 18, 32768, 20, 32640, 22, 32768, 24, 32640, 26, 32768, 28, 32640, 30, 32768, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 2, 32640, 4, 32640, 6, 32640, 8, 32640, 10, 32640, 12, 32640, 14, 32640, 16, 65408, 18, 65408, 20, 65408, 22, 65408, 24, 65408, 26, 65408, 28, 65408, 30, 65408, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 2, 65408, 4, 65408, 6, 65408, 8, 65408, 10, 65408, 12, 65408, 14, 65408, 16, 32640, 18, 32640, 20, 32640, 22, 32640, 24, 32640, 26, 32640, 28, 32640, 30, 32640, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtne2ps_pbh(create__m512bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtne2ps_pbh(create_random__m512bh(), create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtne2ps_pbh_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0])));
        check_array_equality(&result, &[16776, 0, 16792, 0, 16808, 0, 16824, 0, 16840, 0, 16856, 0, 16872, 0, 16888, 0, 16256, 0, 16448, 0, 16544, 0, 16608, 0, 16656, 0, 16688, 0, 16720, 0, 16752, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m512_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32])));
        check_array_equality(&result, &[16672, 0, 16704, 0, 16736, 0, 16768, 0, 16672, 0, 16704, 0, 16736, 0, 16768, 0, 0, 0, 16384, 0, 16512, 0, 16576, 0, 0, 0, 16384, 0, 16512, 0, 16576, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m512_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32, 10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32])));
        check_array_equality(&result, &[17116, 0, 17307, 0, 17407, 0, 17458, 0, 17508, 0, 17547, 0, 17572, 0, 17597, 0, 17096, 0, 17302, 0, 17402, 0, 17455, 0, 17505, 0, 17546, 0, 17570, 0, 17596, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__m512_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32, 910.0f32, 1010.0f32, 1110.0f32, 1210.0f32, 1310.0f32, 1410.0f32, 1510.0f32, 1610.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0, 32704, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0, 32640, 0, 32768, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512bh_to_u16_array(_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 65408, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0, 32640, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtne2ps_pbh(create__mmask32_from(0x55555555u32), create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtne2ps_pbh(create_random__mmask32(), create_random__m512(), create_random__m512());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtne2ps_pbh_asym_max_min_impl() }
}
