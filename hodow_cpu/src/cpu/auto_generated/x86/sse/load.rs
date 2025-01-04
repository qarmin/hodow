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

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_load_ss_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_load_ss(ptr_p.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_load_ss(ptr_p.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_load_ss() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_load_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_load_ps1_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_load_ps1(ptr_p.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_load_ps1(ptr_p.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_load_ps1() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_load_ps1_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_load_ps_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1.0f32; 16]);
        let result = unpack__m128_to_f32_array(_mm_load_ps(ptr_p.0.as_ptr()));
        check_float_array_equality(&result, &[1.0, 1.0, 1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_load_ps(ptr_p.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_load_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_load_ps_impl() }
}
