use std::arch::powerpc64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_xl_len() -> Result<(), String> {
    unsafe {
        vec_xl_len(0 /* T */, 0usize);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_xl_len(0 /* T */, rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_xst_len() -> Result<(), String> {
    unsafe {
        vec_xst_len(0 /* T */, 0 /* Out */, 0usize);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_xst_len(0 /* T */, 0 /* Out */, rand::random::<usize>());
            }
        }
    }
    Ok(())
}
