#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "fxsr")]
fn test_x86_fxsr_fxsave_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        _fxsave(ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_x86_fxsr_fxsave() -> Result<(), String> {
    unsafe { test_x86_fxsr_fxsave_impl() }
}
