use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_s64(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_u8(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_u16(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_u32(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_n_u64(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_n_u8(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_n_u16(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmplt_wide_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmplt_wide_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmplt_wide_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmplt_wide_n_u32(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmplt_wide_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmplt_wide_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_s64(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_u8(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_u16(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_u32(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_u32_impl() }
}
