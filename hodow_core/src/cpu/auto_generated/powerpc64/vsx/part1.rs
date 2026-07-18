use std::arch::powerpc64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_xl_len() -> Result<(), String> {
    unsafe {
        vec_xl_len(0 /* T */, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_xl_len(0 /* T */, rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_xst_len() -> Result<(), String> {
    unsafe {
        vec_xst_len(0 /* T */, 0 /* Out */, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_xst_len(0 /* T */, 0 /* Out */, rand::random::<usize>());
            }
        }
    }
    Ok(())
}
