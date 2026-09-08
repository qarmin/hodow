#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_arm_shared_crc_crc32b() -> Result<(), String> {
    unsafe {
        let result = __crc32b(1u32, 2u8);
        check_int_equality(result as i32, -1727442502).map_err(|e| format!("{e} | call: __crc32b(1u32, 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32b(rand::random::<u32>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_crc_crc32cb() -> Result<(), String> {
    unsafe {
        let result = __crc32cb(1u32, 2u8);
        check_int_equality(result as i32, 324072436).map_err(|e| format!("{e} | call: __crc32cb(1u32, 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cb(rand::random::<u32>(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_crc_crc32cd() -> Result<(), String> {
    unsafe {
        let result = __crc32cd(1u32, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __crc32cd(1u32, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cd(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_crc_crc32ch() -> Result<(), String> {
    unsafe {
        let result = __crc32ch(1u32, 2u16);
        check_int_equality(result as i32, 887597209).map_err(|e| format!("{e} | call: __crc32ch(1u32, 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32ch(rand::random::<u32>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_crc_crc32cw() -> Result<(), String> {
    unsafe {
        let result = __crc32cw(1u32, 2u32);
        check_int_equality(result as i32, 1646430521).map_err(|e| format!("{e} | call: __crc32cw(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32cw(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_crc_crc32d() -> Result<(), String> {
    unsafe {
        let result = __crc32d(1u32, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __crc32d(1u32, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32d(rand::random::<u32>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_crc_crc32h() -> Result<(), String> {
    unsafe {
        let result = __crc32h(1u32, 2u16);
        check_int_equality(result as i32, 724390851).map_err(|e| format!("{e} | call: __crc32h(1u32, 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32h(rand::random::<u32>(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_arm_shared_crc_crc32w() -> Result<(), String> {
    unsafe {
        let result = __crc32w(1u32, 2u32);
        check_int_equality(result as i32, 313896942).map_err(|e| format!("{e} | call: __crc32w(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __crc32w(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}
