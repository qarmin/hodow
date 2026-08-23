use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_abm_lzcnt_u64() -> Result<(), String> {
    unsafe {
        let result = _lzcnt_u64(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _lzcnt_u64(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _lzcnt_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_abm_popcnt64() -> Result<(), String> {
    unsafe {
        let result = _popcnt64(1i64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _popcnt64(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _popcnt64(rand::random::<i64>());
            }
        }
    }
    Ok(())
}
