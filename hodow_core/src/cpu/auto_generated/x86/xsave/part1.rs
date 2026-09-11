#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "xsave")]
fn test_x86_xsave_xsave_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsave(ptr_mem_addr.0.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_x86_xsave_xsave() -> Result<(), String> {
    unsafe { test_x86_xsave_xsave_impl() }
}

#[target_feature(enable = "xsave")]
fn test_x86_xsave_xgetbv_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let _result = _xgetbv(0u32);
    }
    Ok(())
}

pub(super) fn test_x86_xsave_xgetbv() -> Result<(), String> {
    unsafe { test_x86_xsave_xgetbv_impl() }
}

#[target_feature(enable = "xsave")]
fn test_x86_xsave_xsaveopt_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("xsaveopt")) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsaveopt(ptr_mem_addr.0.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_x86_xsave_xsaveopt() -> Result<(), String> {
    unsafe { test_x86_xsave_xsaveopt_impl() }
}

#[target_feature(enable = "xsave")]
fn test_x86_xsave_xsavec_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
        if !(std::arch::is_x86_feature_detected!("xsavec")) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsavec(ptr_mem_addr.0.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_x86_xsave_xsavec() -> Result<(), String> {
    unsafe { test_x86_xsave_xsavec_impl() }
}
