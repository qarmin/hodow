use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "rdrand")]
fn test_x86_64_rdrand_rdrand64_step_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ref_val = 1u64;
        let result = _rdrand64_step(&mut ref_val);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _rdrand64_step(&mut ref_val)"))?;
    }
    Ok(())
}

pub(super) fn test_x86_64_rdrand_rdrand64_step() -> Result<(), String> {
    unsafe { test_x86_64_rdrand_rdrand64_step_impl() }
}

#[target_feature(enable = "rdrand")]
fn test_x86_64_rdrand_rdseed64_step_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("rdseed")) {
            return Ok(());
        }
    unsafe {
        let mut ref_val = 1u64;
        let result = _rdseed64_step(&mut ref_val);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _rdseed64_step(&mut ref_val)"))?;
    }
    Ok(())
}

pub(super) fn test_x86_64_rdrand_rdseed64_step() -> Result<(), String> {
    unsafe { test_x86_64_rdrand_rdseed64_step_impl() }
}
