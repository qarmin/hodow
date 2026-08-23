#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_bmi2_mulx_u32() -> Result<(), String> {
    unsafe {
        let a = 1u32;
        let b = 2u32;
        let mut ref_hi = 3u32;
        let result = _mulx_u32(a, b, &mut ref_hi);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: _mulx_u32(a, b, &mut ref_hi)"))?;
    }
    Ok(())
}

pub(super) fn test_x86_bmi2_bzhi_u32() -> Result<(), String> {
    unsafe {
        let result = _bzhi_u32(1u32, 2u32);
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _bzhi_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bzhi_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_bmi2_pdep_u32() -> Result<(), String> {
    unsafe {
        let result = _pdep_u32(1u32, 2u32);
        check_int_equality(result as i32, 2).map_err(|e| format!("{e} | call: _pdep_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _pdep_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_bmi2_pext_u32() -> Result<(), String> {
    unsafe {
        let result = _pext_u32(1u32, 2u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _pext_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _pext_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}
