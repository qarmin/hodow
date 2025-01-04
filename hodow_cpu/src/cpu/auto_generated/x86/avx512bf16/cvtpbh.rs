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
fn test_x86_avx512bf16_mm512_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_cvtpbh_ps(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 1.83671e-40, 2.75506e-40, 3.67342e-40, 4.59177e-40, 5.51013e-40, 6.42848e-40, 7.34684e-40, 8.2652e-40, 9.18355e-40, 1.01019e-39, 1.102026e-39, 1.193861e-39, 1.285697e-39, 1.377532e-39, 1.469368e-39]).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtpbh_ps(create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtpbh_ps(create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_float_array_equality(&result, &[1.561203e-39, 2.0, 1.744874e-39, 4.0, 1.928545e-39, 6.0, 2.112216e-39, 8.0, 2.295887e-39, 10.0, 2.479558e-39, 12.0, 2.66323e-39, 14.0, 2.8469e-39, 16.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, -1.0, 2.75506e-40, -3.0, 4.59177e-40, -5.0, 6.42848e-40, -7.0, 8.2652e-40, -1.0, 1.01019e-39, -3.0, 1.193861e-39, -5.0, 1.377532e-39, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 200.0, 2.75506e-40, 400.0, 4.59177e-40, 600.0, 6.42848e-40, 800.0, 8.2652e-40, 1000.0, 1.01019e-39, 1200.0, 1.193861e-39, 1400.0, 1.377532e-39, 1600.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, -3.4028235e38, 2.75506e-40, -3.4028235e38, 4.59177e-40, -3.4028235e38, 6.42848e-40, -3.4028235e38, 8.2652e-40, -3.4028235e38, 1.01019e-39, -3.4028235e38, 1.193861e-39, -3.4028235e38, 1.377532e-39, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 3.4028235e38, 2.75506e-40, 3.4028235e38, 4.59177e-40, 3.4028235e38, 6.42848e-40, 3.4028235e38, 8.2652e-40, 3.4028235e38, 1.01019e-39, 3.4028235e38, 1.193861e-39, 3.4028235e38, 1.377532e-39, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 0.0, 2.75506e-40, 0.0, 4.59177e-40, 0.0, 6.42848e-40, 0.0, 8.2652e-40, 0.0, 1.01019e-39, 0.0, 1.193861e-39, 0.0, 1.377532e-39, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, f32::NAN, 2.75506e-40, f32::NAN, 4.59177e-40, f32::NAN, 6.42848e-40, f32::NAN, 8.2652e-40, f32::NAN, 1.01019e-39, f32::NAN, 1.193861e-39, f32::NAN, 1.377532e-39, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_mask_cvtpbh_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, -f32::INFINITY, 2.75506e-40, 5.877472e-39, 4.59177e-40, -f32::INFINITY, 6.42848e-40, 5.877472e-39, 8.2652e-40, -f32::INFINITY, 1.01019e-39, 5.877472e-39, 1.193861e-39, -f32::INFINITY, 1.377532e-39, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_cvtpbh_ps(create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_cvtpbh_ps(create_random__m512(), create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_mask_cvtpbh_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm512_maskz_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_maskz_cvtpbh_ps(create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[9.1835e-41, 0.0, 2.75506e-40, 0.0, 4.59177e-40, 0.0, 6.42848e-40, 0.0, 8.2652e-40, 0.0, 1.01019e-39, 0.0, 1.193861e-39, 0.0, 1.377532e-39, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_cvtpbh_ps(create__mmask16_from(0b0101010101010101), create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_cvtpbh_ps(create_random__mmask16(), create_random__m256bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm512_maskz_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm512_maskz_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 1.83671e-40, 2.75506e-40, 3.67342e-40, 4.59177e-40, 5.51013e-40, 6.42848e-40, 7.34684e-40]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtpbh_ps(create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[8.2652e-40, 2.0, 1.01019e-39, 4.0, 1.193861e-39, 6.0, 1.377532e-39, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__mmask8_from(0b01010101), create__m128bh_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -1.0, 2.75506e-40, -3.0, 4.59177e-40, -5.0, 6.42848e-40, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 200.0, 2.75506e-40, 400.0, 4.59177e-40, 600.0, 6.42848e-40, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -3.4028235e38, 2.75506e-40, -3.4028235e38, 4.59177e-40, -3.4028235e38, 6.42848e-40, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 3.4028235e38, 2.75506e-40, 3.4028235e38, 4.59177e-40, 3.4028235e38, 6.42848e-40, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 0.0, 2.75506e-40, 0.0, 4.59177e-40, 0.0, 6.42848e-40, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, f32::NAN, 2.75506e-40, f32::NAN, 4.59177e-40, f32::NAN, 6.42848e-40, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_mask_cvtpbh_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -f32::INFINITY, 2.75506e-40, 5.877472e-39, 4.59177e-40, -f32::INFINITY, 6.42848e-40, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_cvtpbh_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_cvtpbh_ps(create_random__m256(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_mask_cvtpbh_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm256_maskz_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 0.0, 2.75506e-40, 0.0, 4.59177e-40, 0.0, 6.42848e-40, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm256_maskz_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm256_maskz_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 1.83671e-40, 2.75506e-40, 3.67342e-40]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtpbh_ps(create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_float_array_equality(&result, &[4.59177e-40, 2.0, 6.42848e-40, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -1.0, 2.75506e-40, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal2_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 200.0, 2.75506e-40, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_normal3_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -3.4028235e38, 2.75506e-40, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 3.4028235e38, 2.75506e-40, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 0.0, 2.75506e-40, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, f32::NAN, 2.75506e-40, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, -f32::INFINITY, 2.75506e-40, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_cvtpbh_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_mask_cvtpbh_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bf16")]
fn test_x86_avx512bf16_mm_maskz_cvtpbh_ps_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[9.1835e-41, 0.0, 2.75506e-40, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bf16_mm_maskz_cvtpbh_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bf16_mm_maskz_cvtpbh_ps_impl() }
}
