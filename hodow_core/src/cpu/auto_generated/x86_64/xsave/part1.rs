use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_xsave_xsave64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsave64(ptr_mem_addr.0.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_x86_64_xsave_xsaveopt64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsaveopt64(ptr_mem_addr.0.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_x86_64_xsave_xsavec64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsavec64(ptr_mem_addr.0.as_mut_ptr(), save_mask);
    }
    Ok(())
}
