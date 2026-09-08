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
        let result = _xgetbv(1u32);
        check_int_equality(result as i32, 674).map_err(|e| format!("{e} | call: _xgetbv(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _xgetbv(rand::random::<u32>());
            }
        }
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
