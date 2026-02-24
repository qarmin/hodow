#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_fxsave() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        _fxsave(ptr_mem_addr.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_fxrstor() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        _fxrstor(ptr_mem_addr.as_ptr());
    }
    Ok(())
}
