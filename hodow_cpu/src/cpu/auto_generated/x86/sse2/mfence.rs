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
fn test_x86_sse2_mm_mfence_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        _mm_mfence();

        crate::cpu::fuzz(&mut || {
            _mm_mfence();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_sse2_mm_mfence() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_mfence_impl() }
}
