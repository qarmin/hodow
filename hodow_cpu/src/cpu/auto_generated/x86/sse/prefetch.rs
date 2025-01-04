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
fn test_x86_sse_mm_prefetch_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<0>(ptr_p.0.as_ptr());
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_sse_mm_prefetch() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_prefetch_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_prefetch_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<1>(ptr_p.0.as_ptr());
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_sse_mm_prefetch_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_prefetch_imm_1_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_prefetch_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<7>(ptr_p.0.as_ptr());
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_sse_mm_prefetch_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_prefetch_imm_7_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_prefetch_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _mm_prefetch::<3>(ptr_p.0.as_ptr());
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_sse_mm_prefetch_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_prefetch_imm_3_impl() }
}
