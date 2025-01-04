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

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let result = unpack__m128i_to_i64_array(_mm_loadl_epi64(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_epi64(ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_epi64_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([1.0, 2.0]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([3.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([0.0f64, -1.0f64]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([100.0f64, 200.0f64]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([0.0, 0.0]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_loadl_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        let ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let result = unpack__m128d_to_f64_array(_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_loadl_pd(a, ptr_mem_addr.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_loadl_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_loadl_pd_boundary_mixed_impl() }
}
