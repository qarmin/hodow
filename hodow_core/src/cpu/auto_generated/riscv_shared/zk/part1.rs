use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_riscv_shared_zk_xperm8() -> Result<(), String> {
    unsafe {
        let _result = xperm8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = xperm8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_xperm4() -> Result<(), String> {
    unsafe {
        let _result = xperm4(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = xperm4(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sha256sig0() -> Result<(), String> {
    unsafe {
        let result = sha256sig0(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha256sig0(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha256sig0(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sha256sig1() -> Result<(), String> {
    unsafe {
        let result = sha256sig1(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha256sig1(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha256sig1(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sha256sum0() -> Result<(), String> {
    unsafe {
        let result = sha256sum0(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha256sum0(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha256sum0(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sha256sum1() -> Result<(), String> {
    unsafe {
        let result = sha256sum1(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha256sum1(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha256sum1(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sm4ed() -> Result<(), String> {
    unsafe {
        let result = sm4ed::<0>(1u32, 2u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sm4ed::<0>(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sm4ed::<0>(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sm4ks() -> Result<(), String> {
    unsafe {
        let result = sm4ks::<0>(1u32, 2u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sm4ks::<0>(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sm4ks::<0>(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sm3p0() -> Result<(), String> {
    unsafe {
        let result = sm3p0(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sm3p0(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sm3p0(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_zk_sm3p1() -> Result<(), String> {
    unsafe {
        let result = sm3p1(1u32);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sm3p1(1u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sm3p1(rand::random::<u32>());
            }
        }
    }
    Ok(())
}
