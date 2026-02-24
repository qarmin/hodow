use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_addcarry_u64() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u64;
        let b = 3u64;
        let mut ref_out = 4u64;
        let result = _addcarry_u64(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_addcarryx_u64() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u64;
        let b = 3u64;
        let mut ref_out = 4u64;
        let result = _addcarryx_u64(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_subborrow_u64() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u64;
        let b = 3u64;
        let mut ref_out = 4u64;
        let result = _subborrow_u64(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 1)?;
    }
    Ok(())
}
