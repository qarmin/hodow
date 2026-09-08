#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_impl() -> Result<(), String> {
    unsafe {
        let result = _bextri_u32::<0>(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextri_u32::<0>(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextri_u32::<0>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_bextri_u32() -> Result<(), String> {
    unsafe { test_x86_tbm_bextri_u32_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_imm_0_impl() -> Result<(), String> {
    unsafe {
        let result = _bextri_u32::<0>(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextri_u32::<0>(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextri_u32::<0>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_bextri_u32_imm_0() -> Result<(), String> {
    unsafe { test_x86_tbm_bextri_u32_imm_0_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_imm_1_impl() -> Result<(), String> {
    unsafe {
        let result = _bextri_u32::<1>(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _bextri_u32::<1>(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _bextri_u32::<1>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_bextri_u32_imm_1() -> Result<(), String> {
    unsafe { test_x86_tbm_bextri_u32_imm_1_impl() }
}
