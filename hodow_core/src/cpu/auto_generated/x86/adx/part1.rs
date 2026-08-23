#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_adx_addcarry_u32() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u32;
        let b = 3u32;
        let mut ref_out = 4u32;
        let result = _addcarry_u32(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_x86_adx_addcarryx_u32() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u32;
        let b = 3u32;
        let mut ref_out = 4u32;
        let result = _addcarryx_u32(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 0)?;
    }
    Ok(())
}

pub(super) fn test_x86_adx_subborrow_u32() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u32;
        let b = 3u32;
        let mut ref_out = 4u32;
        let result = _subborrow_u32(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 1)?;
    }
    Ok(())
}
