use std::arch::x86::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_xsave() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsave(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xrstor() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let rs_mask = 2u64;
        _xrstor(ptr_mem_addr.as_ptr(), rs_mask);
    }
    Ok(())
}

pub(super) fn test_xsetbv() -> Result<(), String> {
    unsafe {
        _xsetbv(1u32, 2u64);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _xsetbv(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_xgetbv() -> Result<(), String> {
    unsafe {
        let result = _xgetbv(1u32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsaveopt(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xsavec() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsavec(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xsaves() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        let save_mask = 2u64;
        _xsaves(ptr_mem_addr.as_mut_ptr(), save_mask);
    }
    Ok(())
}

pub(super) fn test_xrstors() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        let rs_mask = 2u64;
        _xrstors(ptr_mem_addr.as_ptr(), rs_mask);
    }
    Ok(())
}
