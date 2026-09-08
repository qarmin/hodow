use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b64_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b64_s32(1i32, 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b64_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b64_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b64_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b8_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b8_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b8_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b8_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b8_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b16_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b16_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b16_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b16_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b16_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b32_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b32_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b32_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b32_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b32_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b64_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b64_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b64_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b64_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b64_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b8_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b8_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b8_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b8_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b8_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b16_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b16_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b16_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b16_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b16_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b32_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b32_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b32_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b32_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b64_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b64_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b64_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b64_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b64_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b8_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b8_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b8_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b8_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b8_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b16_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b16_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b16_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b16_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b16_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b32_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b32_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b32_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b32_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b32_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilele_b64_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilele_b64_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilele_b64_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilele_b64_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilele_b64_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilele_b64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b8_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b8_s32(1i32, 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b8_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b8_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b8_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b16_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b16_s32(1i32, 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b16_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b16_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b16_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b32_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b32_s32(1i32, 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b32_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b32_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b32_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b64_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b64_s32(1i32, 2i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b64_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b64_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b64_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b8_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b8_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b8_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b8_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b8_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b16_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b16_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b16_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b16_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b16_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b32_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b32_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b32_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b32_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b32_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b64_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b64_s64(1i64, 2i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b64_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b64_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b64_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b8_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b8_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b8_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b8_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b8_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b16_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b16_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b16_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b16_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b16_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b32_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b32_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b32_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b32_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b64_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b64_u32(1u32, 2u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b64_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b64_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b64_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b8_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b8_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b8_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b8_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b8_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b16_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b16_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b16_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b16_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b16_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b32_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b32_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b32_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b32_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b32_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwhilelt_b64_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilelt_b64_u64(1u64, 2u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svwhilelt_b64_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilelt_b64_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwhilelt_b64_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwhilelt_b64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svwrffr_impl() -> Result<(), String> {
    unsafe {
        svwrffr(create_svbool_t());

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                svwrffr(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svwrffr() -> Result<(), String> {
    unsafe { test_aarch64_sve_svwrffr_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svzip1_b16(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svzip1_b16(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_b16(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svzip1_b32(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svzip1_b32(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_b32(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svzip1_b64(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svzip1_b64(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_b64(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svzip1_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svzip1_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_f32(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svzip1_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svzip1_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_f64(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svzip1_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svzip1_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svzip1_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svzip1_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svzip1_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svzip1_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svzip1_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svzip1_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svzip1_b8(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svzip1_b8(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1_b8(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1q_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svzip1q_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svzip1q_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1q_f32(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1q_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1q_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1q_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svzip1q_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svzip1q_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1q_f64(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1q_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1q_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1q_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svzip1q_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1q_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1q_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1q_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1q_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1q_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svzip1q_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1q_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1q_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1q_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1q_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1q_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svzip1q_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1q_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1q_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1q_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1q_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svzip1q_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svzip1q_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svzip1q_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svzip1q_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svzip1q_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svzip1q_s64_impl() }
}
