#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_bmi1_bextr_u32() -> Result<(), String> {
    unsafe {
        let result = _bextr_u32(1u32, 2u32, 3u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextr_u32(1u32, 2u32, 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextr_u32(rand::random::<u32>(), rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_bmi1_bextr2_u32() -> Result<(), String> {
    unsafe {
        let result = _bextr2_u32(1u32, 2u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextr2_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextr2_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}
