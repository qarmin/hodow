use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_riscv_shared_p_smaqasu() -> Result<(), String> {
    unsafe {
        let _result = smaqasu(0usize, 0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = smaqasu(rand::random::<u64>() as usize, rand::random::<u64>() as usize, rand::random::<u64>() as usize);
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kaddh() -> Result<(), String> {
    unsafe {
        let _result = kaddh(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kaddh(rand::random::<u64>() as usize, rand::random::<u64>() as usize);
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ksubh() -> Result<(), String> {
    unsafe {
        let _result = ksubh(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ksubh(rand::random::<u64>() as usize, rand::random::<u64>() as usize);
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukaddh() -> Result<(), String> {
    unsafe {
        let _result = ukaddh(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukaddh(rand::random::<u64>() as usize, rand::random::<u64>() as usize);
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_uksubh() -> Result<(), String> {
    unsafe {
        let _result = uksubh(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = uksubh(rand::random::<u64>() as usize, rand::random::<u64>() as usize);
            }
        }
    }
    Ok(())
}
