use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_cvtmask64_u64() -> Result<(), String> {
    unsafe {
        let result = _cvtmask64_u64(create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result as i32, 1431655765)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _cvtmask64_u64(create_random__mmask64());
            }
        }
    }
    Ok(())
}

pub(super) fn test_cvtu64_mask64() -> Result<(), String> {
    unsafe {
        let result = _cvtu64_mask64(1u64);
        check_int_equality(result as i32, 1)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _cvtu64_mask64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}
