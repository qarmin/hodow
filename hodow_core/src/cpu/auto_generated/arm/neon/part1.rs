use std::arch::arm::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_neon_vsli_n_p64() -> Result<(), String> {
    unsafe {
        let _result = vsli_n_p64::<0>(0 /* poly64x1_t */, 0 /* poly64x1_t */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsli_n_p64::<0>(0 /* poly64x1_t */, 0 /* poly64x1_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_neon_vsliq_n_p64() -> Result<(), String> {
    unsafe {
        let _result = vsliq_n_p64::<0>(0 /* poly64x2_t */, 0 /* poly64x2_t */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsliq_n_p64::<0>(0 /* poly64x2_t */, 0 /* poly64x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_neon_vsri_n_p64() -> Result<(), String> {
    unsafe {
        let _result = vsri_n_p64::<0>(0 /* poly64x1_t */, 0 /* poly64x1_t */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsri_n_p64::<0>(0 /* poly64x1_t */, 0 /* poly64x1_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_neon_vsriq_n_p64() -> Result<(), String> {
    unsafe {
        let _result = vsriq_n_p64::<0>(0 /* poly64x2_t */, 0 /* poly64x2_t */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsriq_n_p64::<0>(0 /* poly64x2_t */, 0 /* poly64x2_t */);
            }
        }
    }
    Ok(())
}
