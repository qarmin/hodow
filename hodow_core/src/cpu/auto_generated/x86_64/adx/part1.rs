use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "adx")]
fn test_x86_64_adx_addcarry_u64_impl() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u64;
        let b = 3u64;
        let mut ref_out = 4u64;
        let result = _addcarry_u64(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _addcarry_u64(c_in, a, b, &mut ref_out)"))?;
    }
    Ok(())
}

pub(super) fn test_x86_64_adx_addcarry_u64() -> Result<(), String> {
    unsafe { test_x86_64_adx_addcarry_u64_impl() }
}

#[target_feature(enable = "adx")]
fn test_x86_64_adx_addcarryx_u64_impl() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u64;
        let b = 3u64;
        let mut ref_out = 4u64;
        let result = _addcarryx_u64(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _addcarryx_u64(c_in, a, b, &mut ref_out)"))?;
    }
    Ok(())
}

pub(super) fn test_x86_64_adx_addcarryx_u64() -> Result<(), String> {
    unsafe { test_x86_64_adx_addcarryx_u64_impl() }
}

#[target_feature(enable = "adx")]
fn test_x86_64_adx_subborrow_u64_impl() -> Result<(), String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u64;
        let b = 3u64;
        let mut ref_out = 4u64;
        let result = _subborrow_u64(c_in, a, b, &mut ref_out);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _subborrow_u64(c_in, a, b, &mut ref_out)"))?;
    }
    Ok(())
}

pub(super) fn test_x86_64_adx_subborrow_u64() -> Result<(), String> {
    unsafe { test_x86_64_adx_subborrow_u64_impl() }
}
