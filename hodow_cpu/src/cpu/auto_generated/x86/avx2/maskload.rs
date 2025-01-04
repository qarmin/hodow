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

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([0, -1, 2, -3]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([100, 200, 300, 400]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([0, 0, 0, 0]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([-1, -1, -1, -1]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]);
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 1, 0, 1, 0, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i32; 16]);
        let mask = create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]);
        let result = unpack__m256i_to_i32_array(_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 0, 0, 1, 1, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi32(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i32_array([2, 3, 4, 5]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([0, -1]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([100, 200]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MIN, i64::MIN]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MAX, i64::MAX]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([0, 0]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([-1, -1]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm_maskload_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m128i_from_i64_array([i64::MIN, i64::MAX]);
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm_maskload_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm_maskload_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from_i32_array([2, 3, 4, 5, 6, 7, 8, 9]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([0, -1, 2, -3]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([100, 200, 300, 400]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([0, 0, 0, 0]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([-1, -1, -1, -1]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_maskload_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let mask = create__m256i_from([i64::MIN, i64::MAX, 0, -1]);
        let result = unpack__m256i_to_i64_array(_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask));
        check_array_equality(&result, &[1, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskload_epi64(ptr_mem_addr.0.as_ptr(), mask)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_maskload_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_maskload_epi64_boundary_mixed_impl() }
}
