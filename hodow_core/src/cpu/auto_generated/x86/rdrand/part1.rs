#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_rdrand16_step() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let mut ref_val = 1u16;
        let result = _rdrand16_step(&mut ref_val);
        check_int_equality(result as i32, 1)?;
    }
    Ok(())
}

pub(super) fn test_rdrand32_step() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let mut ref_val = 1u32;
        let result = _rdrand32_step(&mut ref_val);
        check_int_equality(result as i32, 1)?;
    }
    Ok(())
}

pub(super) fn test_rdseed16_step() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let mut ref_val = 1u16;
        let result = _rdseed16_step(&mut ref_val);
        check_int_equality(result as i32, 1)?;
    }
    Ok(())
}

pub(super) fn test_rdseed32_step() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let mut ref_val = 1u32;
        let result = _rdseed32_step(&mut ref_val);
        check_int_equality(result as i32, 1)?;
    }
    Ok(())
}
