use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b64_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b64_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b64_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b64_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b64_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b8_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b8_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b8_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b8_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b8_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b16_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b16_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b16_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b16_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b16_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b32_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b32_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b32_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b32_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b64_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b64_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b64_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b64_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b64_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b8_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b8_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b8_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b8_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b8_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b16_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b16_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b16_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b16_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b16_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b32_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b32_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b32_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b32_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b32_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilege_b64_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilege_b64_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilege_b64_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilege_b64_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilege_b64_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilege_b64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b8_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b8_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b16_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b16_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b32_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b32_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_s32(1i32, 2i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b64_s32(1i32, 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b64_s32(rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b8_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b8_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b16_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b16_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b32_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b32_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_s64(1i64, 2i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b64_s64(1i64, 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b64_s64(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b8_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b8_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b16_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b16_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b32_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b32_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_u32(1u32, 2u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b64_u32(1u32, 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b64_u32(rand::random::<u32>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b8_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b8_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b8_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b8_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b8_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b16_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b16_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b16_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b16_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b16_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b16_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b32_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b32_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b32_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b32_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b32_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svwhilegt_b64_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svwhilegt_b64_u64(1u64, 2u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svwhilegt_b64_u64(1u64, 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svwhilegt_b64_u64(rand::random::<u64>(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svwhilegt_b64_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svwhilegt_b64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svxar_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-127]).map_err(|e| format!("{e} | call: svxar_n_s8::<1>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_s8::<1>(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svxar_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-32767]).map_err(|e| format!("{e} | call: svxar_n_s16::<1>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_s16::<1>(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svxar_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-2147483647]).map_err(|e| format!("{e} | call: svxar_n_s32::<1>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_s32::<1>(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svxar_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-9223372036854775807]).map_err(|e| format!("{e} | call: svxar_n_s64::<1>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_s64::<1>(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svxar_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[129]).map_err(|e| format!("{e} | call: svxar_n_u8::<1>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_u8::<1>(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svxar_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[32769]).map_err(|e| format!("{e} | call: svxar_n_u16::<1>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_u16::<1>(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svxar_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2147483649]).map_err(|e| format!("{e} | call: svxar_n_u32::<1>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_u32::<1>(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svxar_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svxar_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[9223372036854775809]).map_err(|e| format!("{e} | call: svxar_n_u64::<1>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svxar_n_u64::<1>(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svxar_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svxar_n_u64_impl() }
}
