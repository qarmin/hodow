use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_riscv64_zk_aes64es() -> Result<(), String> {
    unsafe {
        let result = aes64es(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64es(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64es(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_aes64esm() -> Result<(), String> {
    unsafe {
        let result = aes64esm(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64esm(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64esm(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_aes64ds() -> Result<(), String> {
    unsafe {
        let result = aes64ds(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64ds(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64ds(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_aes64dsm() -> Result<(), String> {
    unsafe {
        let result = aes64dsm(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64dsm(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64dsm(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_aes64ks1i() -> Result<(), String> {
    unsafe {
        let result = aes64ks1i::<0>(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64ks1i::<0>(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64ks1i::<0>(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_aes64ks2() -> Result<(), String> {
    unsafe {
        let result = aes64ks2(1u64, 2u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64ks2(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64ks2(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_aes64im() -> Result<(), String> {
    unsafe {
        let result = aes64im(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: aes64im(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = aes64im(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_sha512sig0() -> Result<(), String> {
    unsafe {
        let result = sha512sig0(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha512sig0(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha512sig0(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_sha512sig1() -> Result<(), String> {
    unsafe {
        let result = sha512sig1(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha512sig1(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha512sig1(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_sha512sum0() -> Result<(), String> {
    unsafe {
        let result = sha512sum0(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha512sum0(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha512sum0(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv64_zk_sha512sum1() -> Result<(), String> {
    unsafe {
        let result = sha512sum1(1u64);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: sha512sum1(1u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sha512sum1(rand::random::<u64>());
            }
        }
    }
    Ok(())
}
