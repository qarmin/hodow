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

#[target_feature(enable = "rdrand")]
fn test_x86_rdrand_rdrand16_step_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ref_val = 1u16;
        let result = retry_hw_rng(10, || _rdrand16_step(&mut ref_val));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "retry_hw_rng(10, || _rdrand16_step(&mut ref_val))"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_rdrand_rdrand16_step() -> Result<Verdict, String> {
    unsafe { test_x86_rdrand_rdrand16_step_impl() }
}
