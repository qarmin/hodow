use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqadd_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqadd_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqadd_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqadd_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_u8(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqadd_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqadd_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqadd_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqadd_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqadd_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqadd_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqadd_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svqadd_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqadd_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqadd_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqadd_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqsub_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqsub_n_s8(create_svint8_t_from(1i8), 2i8));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_n_s8(create_svint8_t_from(1i8), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_s8(create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqsub_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqsub_n_s16(create_svint16_t_from(1i16), 2i16));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_n_s16(create_svint16_t_from(1i16), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_s16(create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqsub_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqsub_n_s32(create_svint32_t_from(1i32), 2i32));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_n_s32(create_svint32_t_from(1i32), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_s32(create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqsub_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqsub_n_s64(create_svint64_t_from(1i64), 2i64));
        check_array_equality(&result, &[-1]).map_err(|e| format!("{e} | call: svqsub_n_s64(create_svint64_t_from(1i64), 2i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_s64(create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqsub_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svqsub_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqsub_n_u8(create_svuint8_t_from(1u8), 2u8));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svqsub_n_u8(create_svuint8_t_from(1u8), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_u8(create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqsub_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svqsub_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqsub_n_u16(create_svuint16_t_from(1u16), 2u16));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svqsub_n_u16(create_svuint16_t_from(1u16), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_u16(create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsub_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svqsub_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqsub_n_u32(create_svuint32_t_from(1u32), 2u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svqsub_n_u32(create_svuint32_t_from(1u32), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_u32(create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsub_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svqsub_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svqsub_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqsub_n_u64(create_svuint64_t_from(1u64), 2u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svqsub_n_u64(create_svuint64_t_from(1u64), 2u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqsub_n_u64(create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svqsub_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svqsub_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrbit_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-64]).map_err(|e| format!("{e} | call: svrbit_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s8_m(create_random_svint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrbit_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[64]).map_err(|e| format!("{e} | call: svrbit_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrbit_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[64]).map_err(|e| format!("{e} | call: svrbit_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrbit_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-16384]).map_err(|e| format!("{e} | call: svrbit_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrbit_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[16384]).map_err(|e| format!("{e} | call: svrbit_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrbit_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[16384]).map_err(|e| format!("{e} | call: svrbit_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrbit_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-1073741824]).map_err(|e| format!("{e} | call: svrbit_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrbit_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1073741824]).map_err(|e| format!("{e} | call: svrbit_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrbit_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1073741824]).map_err(|e| format!("{e} | call: svrbit_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrbit_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[-4611686018427387904]).map_err(|e| format!("{e} | call: svrbit_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrbit_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4611686018427387904]).map_err(|e| format!("{e} | call: svrbit_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrbit_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4611686018427387904]).map_err(|e| format!("{e} | call: svrbit_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrbit_u8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[192]).map_err(|e| format!("{e} | call: svrbit_u8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrbit_u8_x(create_svbool_t(), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[64]).map_err(|e| format!("{e} | call: svrbit_u8_x(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u8_x(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrbit_u8_z(create_svbool_t(), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[64]).map_err(|e| format!("{e} | call: svrbit_u8_z(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u8_z(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrbit_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[49152]).map_err(|e| format!("{e} | call: svrbit_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrbit_u16_x(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[16384]).map_err(|e| format!("{e} | call: svrbit_u16_x(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u16_x(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrbit_u16_z(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[16384]).map_err(|e| format!("{e} | call: svrbit_u16_z(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u16_z(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrbit_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3221225472]).map_err(|e| format!("{e} | call: svrbit_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrbit_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1073741824]).map_err(|e| format!("{e} | call: svrbit_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u32_x(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrbit_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1073741824]).map_err(|e| format!("{e} | call: svrbit_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u32_z(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrbit_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[13835058055282163712]).map_err(|e| format!("{e} | call: svrbit_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrbit_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[4611686018427387904]).map_err(|e| format!("{e} | call: svrbit_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u64_x(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrbit_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrbit_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[4611686018427387904]).map_err(|e| format!("{e} | call: svrbit_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrbit_u64_z(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrbit_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrbit_u64_z_impl() }
}
