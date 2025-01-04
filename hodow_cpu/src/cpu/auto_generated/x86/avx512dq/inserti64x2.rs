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
fn test_x86_avx512dq_mm256_inserti64x2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 12, 7, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 410, 500, 600, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<0>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_inserti64x2_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_inserti64x2::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4, 9, 10, 11, 12]).map_err(|e| crate::cpu::with_call(e, "_mm256_inserti64x2::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_inserti64x2::<1>(create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_inserti64x2_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_inserti64x2_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 18, 3, 4, 13, 14, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[20, 19, 2, -3, 14, 5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[120, 220, 300, 400, 510, 610, 700, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, -2147483648, -2147483648, 2147483647, 2147483647, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 2147483647, 2147483647, -2147483648, -2147483648, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<0>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_mask_inserti64x2_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_inserti64x2::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[9, 10, 3, 4, 17, 18, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_inserti64x2::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_inserti64x2::<1>(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_mask_inserti64x2_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_mask_inserti64x2_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[9, 10, 0, 0, 5, 6, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 0, 0, 4, -5, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 0, 0, 500, 600, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0, -2147483648, -2147483648, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0, 2147483647, 2147483647, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0, -1, -1, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, 0, -2147483648, 2147483647, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0, -2147483648, -2147483648, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0, 2147483647, 2147483647, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_maskz_inserti64x2_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_inserti64x2::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 0, 0, 9, 10, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_inserti64x2::<1>(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_inserti64x2::<1>(create_random__mmask8(), create_random__m256i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_maskz_inserti64x2_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_maskz_inserti64x2_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 18, 19, 20, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 12, 7, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 410, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<0>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[1, 2, 3, 4, 17, 18, 19, 20, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<1>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_inserti64x2_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_inserti64x2::<3>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 17, 18, 19, 20]).map_err(|e| crate::cpu::with_call(e, "_mm512_inserti64x2::<3>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_inserti64x2::<3>(create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_inserti64x2_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_inserti64x2_imm_3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[33, 34, 3, 4, 21, 22, 7, 8, 25, 26, 11, 12, 29, 30, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[20, 19, 2, -3, 14, 5, 6, -7, 10, 9, 2, -3, 14, 5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[120, 220, 300, 400, 510, 610, 700, 800, 910, 1010, 1100, 1200, 1310, 1410, 1500, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, -2147483648, -2147483648, 2147483647, 2147483647, -2147483648, -2147483648, 2147483647, 2147483647, -2147483648, -2147483648, 2147483647, 2147483647, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 2147483647, 2147483647, -2147483648, -2147483648, 2147483647, 2147483647, -2147483648, -2147483648, 2147483647, 2147483647, -2147483648, -2147483648, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<0>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[17, 18, 3, 4, 33, 34, 7, 8, 25, 26, 11, 12, 29, 30, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<1>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_mask_inserti64x2_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_inserti64x2::<3>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36])));
        check_array_equality(&result, &[17, 18, 3, 4, 21, 22, 7, 8, 25, 26, 11, 12, 33, 34, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_inserti64x2::<3>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m128i_from_i32_array([33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_inserti64x2::<3>(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_mask_inserti64x2_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_mask_inserti64x2_imm_3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[17, 18, 0, 0, 5, 6, 0, 0, 9, 10, 0, 0, 13, 14, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 0, 0, 4, -5, 0, 0, 0, -1, 0, 0, 4, -5, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_normal2_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 0, 0, 500, 600, 0, 0, 900, 1000, 0, 0, 1300, 1400, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_normal3_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0, -2147483648, -2147483648, 0, 0, -2147483648, -2147483648, 0, 0, -2147483648, -2147483648, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0, 2147483647, 2147483647, 0, 0, 2147483647, 2147483647, 0, 0, 2147483647, 2147483647, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_zero_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_allones_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, 0, -2147483648, 2147483647, 0, 0, -2147483648, 2147483647, 0, 0, -2147483648, 2147483647, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 0, 0, -2147483648, -2147483648, 0, 0, -2147483648, -2147483648, 0, 0, -2147483648, -2147483648, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_asym_min_max_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, 0, 0, 2147483647, 2147483647, 0, 0, 2147483647, 2147483647, 0, 0, 2147483647, 2147483647, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<0>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_asym_max_min_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<1>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[1, 2, 0, 0, 17, 18, 0, 0, 9, 10, 0, 0, 13, 14, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<1>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<1>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_imm_1_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_maskz_inserti64x2_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_inserti64x2::<3>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[1, 2, 0, 0, 5, 6, 0, 0, 9, 10, 0, 0, 17, 18, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_inserti64x2::<3>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_inserti64x2::<3>(create_random__mmask8(), create_random__m512i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_maskz_inserti64x2_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_maskz_inserti64x2_imm_3_impl() }
}
