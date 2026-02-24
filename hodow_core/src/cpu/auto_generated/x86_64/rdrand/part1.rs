use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_rdrand64_step() -> Result<(), String> {
    unsafe {
        let mut ref_val = 1u64;
        let result = _rdrand64_step(&mut ref_val);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_rdseed64_step() -> Result<(), String> {
    unsafe {
        let mut ref_val = 1u64;
        let result = _rdseed64_step(&mut ref_val);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}
