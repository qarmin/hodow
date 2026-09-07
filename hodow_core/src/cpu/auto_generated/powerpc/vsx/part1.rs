use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_powerpc_vsx_vec_xxpermdi() -> Result<(), String> {
    unsafe {
        vec_xxpermdi::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_xxpermdi::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_powerpc_vsx_vec_mergee() -> Result<(), String> {
    unsafe {
        vec_mergee(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_mergee(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_powerpc_vsx_vec_mergeo() -> Result<(), String> {
    unsafe {
        vec_mergeo(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_mergeo(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}
