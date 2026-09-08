use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_impl() -> Result<(), String> {
    unsafe {
        let result = _bextri_u64::<0>(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextri_u64::<0>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextri_u64::<0>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_tbm_bextri_u64() -> Result<(), String> {
    unsafe { test_x86_64_tbm_bextri_u64_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _bextri_u64::<0>(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextri_u64::<0>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextri_u64::<0>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_tbm_bextri_u64_imm_0() -> Result<(), String> {
    unsafe { test_x86_64_tbm_bextri_u64_imm_0_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _bextri_u64::<1>(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextri_u64::<1>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextri_u64::<1>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_tbm_bextri_u64_imm_1() -> Result<(), String> {
    unsafe { test_x86_64_tbm_bextri_u64_imm_1_impl() }
}
