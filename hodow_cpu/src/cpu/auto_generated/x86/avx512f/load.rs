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
fn test_x86_avx512f_load_mask16_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__mmask16_from(0b0101010101010101); 32]);
        let result = _load_mask16(ptr_mem_addr.0.as_ptr());
        check_int_equality(result, 21845).map_err(|e| crate::cpu::with_call(e, "_load_mask16(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_load_mask16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_load_mask16_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_load_si512_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1]);
        let result = unpack__m512i_to_i32_array(_mm512_load_si512(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_load_si512(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_load_si512() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_load_si512_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_load_epi32(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_load_epi32(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_load_epi32(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_load_epi32(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_load_epi32(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_load_epi32(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_load_epi64(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_load_epi64(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_load_epi64(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_load_epi64(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_load_epi64(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_load_epi64(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_load_ps(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_load_ps(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_load_pd(ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_load_pd(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[17, 2, 17, 4, 17, 6, 17, 8, 17, 10, 17, 12, 17, 14, 17, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7, 1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800, 1, 1000, 1, 1200, 1, 1400, 1, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2147483647, 1, -1, 1, 2147483647, 1, -1, 1, 2147483647, 1, -1, 1, 2147483647, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m512i_to_i32_array(_mm512_maskz_load_epi32(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_load_epi32(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[17, 17179869187, 17, 34359738375, 17, 51539607563, 17, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808, 1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807, 1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 9223372036854775807, 1, -1, 1, 9223372036854775807, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m512i_to_i64_array(_mm512_maskz_load_epi64(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_load_epi64(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([17.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[17.0, 2.0, 17.0, 4.0, 17.0, 6.0, 17.0, 8.0, 17.0, 10.0, 17.0, 12.0, 17.0, 14.0, 17.0, 16.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32, 0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -3.0, 1.0, -5.0, 1.0, -7.0, 1.0, -1.0, 1.0, -3.0, 1.0, -5.0, 1.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32, 900.0f32, 1000.0f32, 1100.0f32, 1200.0f32, 1300.0f32, 1400.0f32, 1500.0f32, 1600.0f32]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0, 1.0, 400.0, 1.0, 600.0, 1.0, 800.0, 1.0, 1000.0, 1.0, 1200.0, 1.0, 1400.0, 1.0, 1600.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, 1.0, 5.877472e-39, 1.0, -f32::INFINITY, 1.0, 5.877472e-39, 1.0, -f32::INFINITY, 1.0, 5.877472e-39, 1.0, -f32::INFINITY, 1.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m512_to_f32_array(_mm512_maskz_load_ps(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_load_ps(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[9.0, 2.0, 9.0, 4.0, 9.0, 6.0, 9.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64, 4.0f64, -5.0f64, 6.0f64, -7.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -3.0, 1.0, -5.0, 1.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64, 500.0f64, 600.0f64, 700.0f64, 800.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0, 1.0, 400.0, 1.0, 600.0, 1.0, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308, 1.0, -1.7976931348623157e308, 1.0, -1.7976931348623157e308, 1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308, 1.0, 1.7976931348623157e308, 1.0, 1.7976931348623157e308, 1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f64::NAN, 1.0, f64::NAN, 1.0, f64::NAN, 1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_load_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m512d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0, f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, 1.0, 1.1125369292536007e-308, 1.0, -f64::INFINITY, 1.0, 1.1125369292536007e-308]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_load_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_load_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m512d_to_f64_array(_mm512_maskz_load_pd(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_load_pd(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[9, 2, 9, 4, 9, 6, 9, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3, 1, -5, 1, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400, 1, 600, 1, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648, 1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647, 1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1, 1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2147483647, 1, -1, 1, 2147483647, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m256i_to_i32_array(_mm256_maskz_load_epi32(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_load_epi32(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[9, 17179869187, 9, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([0, -1, 2, -3]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([100, 200, 300, 400]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -9223372036854775808, 1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 9223372036854775807, 1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([-1, -1, -1, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256i_from([i64::MIN, i64::MAX, 0, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 9223372036854775807, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m256i_to_i64_array(_mm256_maskz_load_epi64(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_load_epi64(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([9.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[9.0, 2.0, 9.0, 4.0, 9.0, 6.0, 9.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -3.0, 1.0, -5.0, 1.0, -7.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0, 1.0, 400.0, 1.0, 600.0, 1.0, 800.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38, 1.0, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38, 1.0, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN, 1.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, 1.0, 5.877472e-39, 1.0, -f32::INFINITY, 1.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m256_to_f32_array(_mm256_maskz_load_ps(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_load_ps(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[5.0, 2.0, 5.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0, 1.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308, 1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308, 1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([0.0, 0.0, 0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f64::NAN, 1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_load_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY, 1.0, 1.1125369292536007e-308]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_load_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_load_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m256d_to_f64_array(_mm256_maskz_load_pd(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_load_pd(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[5, 2, 5, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, -1, 2, -3]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -3]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([100, 200, 300, 400]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200, 1, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -2147483648, 1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2147483647, 1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([0, 0, 0, 0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2147483647, 1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi32(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_load_epi32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let result = unpack__m128i_to_i32_array(_mm_maskz_load_epi32(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_load_epi32(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_load_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_load_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[5, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([0, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([100, 200]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([0, 0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([-1, -1]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128i_from_i64_array([i64::MIN, i64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_epi64(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_load_epi64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let result = unpack__m128i_to_i64_array(_mm_maskz_load_epi64(k, ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_load_epi64(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_load_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_load_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[5.0, 2.0, 5.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0, 1.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0, 1.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, 1.0, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 1.0, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f32::NAN, 1.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ps_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, 1.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ps(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_maskz_load_ps(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_load_ps(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_load_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([3.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([0.0f64, -1.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([100.0f64, 200.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([f64::MIN, f64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([f64::MAX, f64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([f64::NAN, f64::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_pd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let src = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_pd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_load_pd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_maskz_load_pd(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_load_pd(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_load_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_load_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([5.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[5.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([0.0, 0.0, 0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_ss_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_ss(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_load_ss_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_maskz_load_ss(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_load_ss(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_load_ss() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_load_ss_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([3.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[3.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([0.0f64, -1.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([100.0f64, 200.0f64]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([f64::MIN, f64::MIN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([f64::MAX, f64::MAX]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([0.0, 0.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([f64::NAN, f64::NAN]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_load_sd_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let src = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_load_sd(src, k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_load_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_load_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_load_sd_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_maskz_load_sd(k, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_load_sd(k, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_load_sd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_load_sd_impl() }
}
