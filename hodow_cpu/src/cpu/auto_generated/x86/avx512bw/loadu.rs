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

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_loadu_epi16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_loadu_epi16(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_loadu_epi16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_loadu_epi16(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_loadu_epi16(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_loadu_epi16(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_loadu_epi8(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_loadu_epi8(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_loadu_epi8(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_loadu_epi8(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_loadu_epi8(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_loadu_epi8(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800, 1, 1000, 1, 1200, 1, 1400, 1, 1600, 1, 1800, 1, 2000, 1, 2200, 1, 2400, 1, 2600, 1, 2800, 1, 3000, 1, 3200]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m512i_to_i16_array(_mm512_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0, 17, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128, -28, 72, -84, 16, 116, -40, 60, -96, 4, 104, -52, 48, -108, -8, 92, -64, 36, -120, -20, 80, -76, 24, 124, -32, 68, -88, 12, 112, -44, 56, -100, 0]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -56, 1, -112, 1, 88, 1, 32, 1, -24, 1, -80, 1, 120, 1, 64, 1, 8, 1, -48, 1, -104, 1, 96, 1, 40, 1, -16, 1, -72, 1, -128, 1, 72, 1, 16, 1, -40, 1, -96, 1, 104, 1, 48, 1, -8, 1, -64, 1, -120, 1, 80, 1, 24, 1, -32, 1, -88, 1, 112, 1, 56, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_loadu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m512i_to_i8_array(_mm512_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800, 1, 1000, 1, 1200, 1, 1400, 1, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768, 1, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767, 1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1, 1, 32767, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m256i_to_i16_array(_mm256_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -56, 1, -112, 1, 88, 1, 32, 1, -24, 1, -80, 1, 120, 1, 64, 1, 8, 1, -48, 1, -104, 1, 96, 1, 40, 1, -16, 1, -72, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_loadu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m256i_to_i8_array(_mm256_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[5, 0, 5, 0, 5, 0, 5, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -32768, 1, -32768, 1, -32768, 1, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 32767, 1, 32767, 1, 32767, 1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 32767, 1, -1, 1, 32767, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi16(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_loadu_epi16_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i16; 32]);
        let result = unpack__m128i_to_i16_array(_mm_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_loadu_epi16(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_loadu_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_loadu_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[5, 0, 5, 0, 5, 0, 5, 0, 5, 0, 5, 0, 5, 0, 5, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -56, 1, -112, 1, 88, 1, 32, 1, -24, 1, -80, 1, 120, 1, 64]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128, 1, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127, 1, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1, 1, 127, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_loadu_epi8(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_loadu_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_loadu_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_loadu_epi8_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let result = unpack__m128i_to_i8_array(_mm_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_loadu_epi8(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_loadu_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_loadu_epi8_impl() }
}
