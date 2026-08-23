#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_tbm_bextri_u32() -> Result<(), String> {
    unsafe {
        let result = _bextri_u32::<0>(1u32);
        check_int_equality(result as i32, 0)?;

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

pub(super) fn test_x86_tbm_blcfill_u32() -> Result<(), String> {
    unsafe {
        let result = _blcfill_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcfill_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_blci_u32() -> Result<(), String> {
    unsafe {
        let result = _blci_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blci_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_blcic_u32() -> Result<(), String> {
    unsafe {
        let result = _blcic_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcic_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_blcmsk_u32() -> Result<(), String> {
    unsafe {
        let result = _blcmsk_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcmsk_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_blcs_u32() -> Result<(), String> {
    unsafe {
        let result = _blcs_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcs_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_blsfill_u32() -> Result<(), String> {
    unsafe {
        let result = _blsfill_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blsfill_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_blsic_u32() -> Result<(), String> {
    unsafe {
        let result = _blsic_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blsic_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_t1mskc_u32() -> Result<(), String> {
    unsafe {
        let result = _t1mskc_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _t1mskc_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_tbm_tzmsk_u32() -> Result<(), String> {
    unsafe {
        let result = _tzmsk_u32(1u32);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tzmsk_u32(rand::random::<u32>());
            }
        }
    }
    Ok(())
}
