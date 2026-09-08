use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_aarch64_crc_crc32cd() -> Result<(), String> {
    unsafe {
        let result = __crc32cd(1u32, 2u64);
        check_int_equality(result as i32, -616265879).map_err(|e| format!("{e} | call: __crc32cd(1u32, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cd(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_crc_crc32d() -> Result<(), String> {
    unsafe {
        let result = __crc32d(1u32, 2u64);
        check_int_equality(result as i32, -1903228957).map_err(|e| format!("{e} | call: __crc32d(1u32, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32d(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}
