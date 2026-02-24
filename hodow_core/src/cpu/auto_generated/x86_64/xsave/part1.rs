use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_xsave64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsave64(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xrstor64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let rs_mask = 2u64;
        _xrstor64(ptr_mem_addr.as_ptr(), rs_mask);
    }
    Ok(())
}

pub(super) fn test_xsaveopt64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsaveopt64(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xsavec64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsavec64(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xsaves64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsaves64(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xrstors64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let rs_mask = 2u64;
        _xrstors64(ptr_mem_addr.as_ptr(), rs_mask);
    }
    Ok(())
}
