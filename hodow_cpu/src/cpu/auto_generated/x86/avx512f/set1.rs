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
fn test_x86_avx512f_mm512_set1_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_set1_pd(1.0f64));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_set1_pd(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set1_pd(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set1_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set1_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set1_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_set1_ps(1.0f32));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_set1_ps(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set1_ps(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set1_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set1_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set1_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i8_array(_mm512_set1_epi8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set1_epi8(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set1_epi8(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set1_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set1_epi8_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set1_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_set1_epi16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set1_epi16(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set1_epi16(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set1_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set1_epi16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set1_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set1_epi32(1i32));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set1_epi32(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set1_epi32(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), 17i32));
        check_array_equality(&result, &[17, 2, 17, 4, 17, 6, 17, 8, 17, 10, 17, 12, 17, 14, 17, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), 17i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800, 1, 1000, 1, 1200, 1, 1400, 1, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, 2147483647, 1, -1, 1, 2147483647, 1, -1, 1, 2147483647, 1, -1, 1, 2147483647, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi32(create_random__m512i(), create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = 1i32;
        let src = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512i_to_i32_array(_mm512_mask_set1_epi32(src, k, a));
        let plain = unpack__m512i_to_i32_array(_mm512_set1_epi32(a));
        let src_lanes = unpack__m512i_to_i32_array(src);
        let expected: [i32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi32(src, k, a) vs _mm512_set1_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_set1_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_set1_epi32(create__mmask16_from(0b0101010101010101), 1i32));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_set1_epi32(create__mmask16_from(0b0101010101010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_set1_epi32(create_random__mmask16(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_set1_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = 1i32;
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512i_to_i32_array(_mm512_maskz_set1_epi32(k, a));
        let plain = unpack__m512i_to_i32_array(_mm512_set1_epi32(a));
        let expected: [i32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_set1_epi32(k, a) vs _mm512_set1_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_set1_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_set1_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), 9i32));
        check_array_equality(&result, &[9, 2, 9, 4, 9, 6, 9, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), 9i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 2147483647, 1, -1, 1, 2147483647, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi32(create_random__m256i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f,avx")]
fn test_x86_avx512f_mm256_mask_set1_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let a = 1i32;
        let src = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i32_array(_mm256_mask_set1_epi32(src, k, a));
        let plain = unpack__m256i_to_i32_array(_mm256_set1_epi32(a));
        let src_lanes = unpack__m256i_to_i32_array(src);
        let expected: [i32; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi32(src, k, a) vs _mm256_set1_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_set1_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_set1_epi32(create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_set1_epi32(create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_set1_epi32(create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f,avx")]
fn test_x86_avx512f_mm256_maskz_set1_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx")) {
            return Ok(Verdict::Skipped("avx not present"));
        }
    unsafe {
        let a = 1i32;
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i32_array(_mm256_maskz_set1_epi32(k, a));
        let plain = unpack__m256i_to_i32_array(_mm256_set1_epi32(a));
        let expected: [i32; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_set1_epi32(k, a) vs _mm256_set1_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_set1_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_set1_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 5i32));
        check_array_equality(&result, &[5, 2, 5, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, -1, 1, -3]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 200, 1, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 2147483647, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi32(create_random__m128i(), create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f,sse2")]
fn test_x86_avx512f_mm_mask_set1_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a = 1i32;
        let src = create__m128i_from_i32_array([2, 3, 4, 5]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i32_array(_mm_mask_set1_epi32(src, k, a));
        let plain = unpack__m128i_to_i32_array(_mm_set1_epi32(a));
        let src_lanes = unpack__m128i_to_i32_array(src);
        let expected: [i32; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi32(src, k, a) vs _mm_set1_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_set1_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_set1_epi32(create__mmask8_from(0b01010101), 1i32));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_set1_epi32(create__mmask8_from(0b01010101), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_set1_epi32(create_random__mmask8(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_set1_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_set1_epi32_impl() }
}

#[target_feature(enable = "avx512f,sse2")]
fn test_x86_avx512f_mm_maskz_set1_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a = 1i32;
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i32_array(_mm_maskz_set1_epi32(k, a));
        let plain = unpack__m128i_to_i32_array(_mm_set1_epi32(a));
        let expected: [i32; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_set1_epi32(k, a) vs _mm_set1_epi32(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_set1_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_set1_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_set1_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_set1_epi64(1i64));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_set1_epi64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_set1_epi64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_set1_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), 17i64));
        check_array_equality(&result, &[17, 17179869187, 17, 34359738375, 17, 51539607563, 17, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), 17i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 1, -1, 1, 9223372036854775807, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_set1_epi64(create_random__m512i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_set1_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = 1i64;
        let src = create__m512i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_mask_set1_epi64(src, k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_set1_epi64(a));
        let src_lanes = unpack__m512i_to_i64_array(src);
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_set1_epi64(src, k, a) vs _mm512_set1_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_set1_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_set1_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_set1_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_set1_epi64(create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_set1_epi64(create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_set1_epi64(create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_set1_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_set1_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = 1i64;
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_maskz_set1_epi64(k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_set1_epi64(a));
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_set1_epi64(k, a) vs _mm512_set1_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_set1_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_set1_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), 9i64));
        check_array_equality(&result, &[9, 17179869187, 9, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), 9i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -1, 1, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 200, 1, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -9223372036854775808, 1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_set1_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_set1_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_set1_epi64(create_random__m256i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_set1_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_set1_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_set1_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_set1_epi64(create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_set1_epi64(create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_set1_epi64(create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_set1_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 5i64));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 5i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_set1_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_set1_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_set1_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_set1_epi64(create_random__m128i(), create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_set1_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_set1_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_set1_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_set1_epi64(create__mmask8_from(0b01010101), 1i64));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_set1_epi64(create__mmask8_from(0b01010101), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_set1_epi64(create_random__mmask8(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_set1_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_set1_epi64_impl() }
}
