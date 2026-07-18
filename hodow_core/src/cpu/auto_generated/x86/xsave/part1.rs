#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_xsave() -> Result<(), String> {
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

pub(super) fn test_xgetbv() -> Result<(), String> {
    if cfg!(miri) {
        return Ok(());
    }
    unsafe {
        let result = _xgetbv(1u32);
        check_int_equality(result as i32, 674)?;

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

pub(super) fn test_xsaveopt() -> Result<(), String> {
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

pub(super) fn test_xsavec() -> Result<(), String> {
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
