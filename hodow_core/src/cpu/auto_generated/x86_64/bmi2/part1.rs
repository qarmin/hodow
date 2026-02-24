use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mulx_u64() -> Result<(), String> {
    unsafe {
        let a = 1u64;
        let b = 2u64;
        let mut ref_hi = 3u64;
        let result = _mulx_u64(a, b, &mut ref_hi);
        check_int_equality(result as i32, 2)?;
    }
    Ok(())
}

pub(super) fn test_bzhi_u64() -> Result<(), String> {
    unsafe {
        let result = _bzhi_u64(1u64, 2u32);
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bzhi_u64(rand::random::<u64>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_pdep_u64() -> Result<(), String> {
    unsafe {
        let result = _pdep_u64(1u64, 2u64);
        check_int_equality(result as i32, 2)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _pdep_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_pext_u64() -> Result<(), String> {
    unsafe {
        let result = _pext_u64(1u64, 2u64);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _pext_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}
