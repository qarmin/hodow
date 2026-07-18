use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_bextri_u64() -> Result<(), String> {
    unsafe {
        let result = _bextri_u64::<0>(1u64);
        check_int_equality(result as i32, 0)?;

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

pub(super) fn test_blcfill_u64() -> Result<(), String> {
    unsafe {
        let result = _blcfill_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcfill_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_blci_u64() -> Result<(), String> {
    unsafe {
        let result = _blci_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blci_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_blcic_u64() -> Result<(), String> {
    unsafe {
        let result = _blcic_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcic_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_blcmsk_u64() -> Result<(), String> {
    unsafe {
        let result = _blcmsk_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcmsk_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_blcs_u64() -> Result<(), String> {
    unsafe {
        let result = _blcs_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blcs_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_blsfill_u64() -> Result<(), String> {
    unsafe {
        let result = _blsfill_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blsfill_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_blsic_u64() -> Result<(), String> {
    unsafe {
        let result = _blsic_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _blsic_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_t1mskc_u64() -> Result<(), String> {
    unsafe {
        let result = _t1mskc_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _t1mskc_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_tzmsk_u64() -> Result<(), String> {
    unsafe {
        let result = _tzmsk_u64(1u64);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tzmsk_u64(rand::random::<u64>());
            }
        }
    }
    Ok(())
}
