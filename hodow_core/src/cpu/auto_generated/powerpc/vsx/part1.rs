use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_xxpermdi() -> Result<(), String> {
    unsafe {
        vec_xxpermdi::<0>(0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_xxpermdi::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mergee() -> Result<(), String> {
    unsafe {
        vec_mergee(0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mergee(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mergeo() -> Result<(), String> {
    unsafe {
        vec_mergeo(0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mergeo(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}
