use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_orc_b() -> Result<(), String> {
    unsafe {
        let _result = orc_b(0usize);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = orc_b(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_clmul() -> Result<(), String> {
    unsafe {
        let _result = clmul(0usize, 0usize);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clmul(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_clmulh() -> Result<(), String> {
    unsafe {
        let _result = clmulh(0usize, 0usize);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clmulh(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_clmulr() -> Result<(), String> {
    unsafe {
        let _result = clmulr(0usize, 0usize);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clmulr(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}
