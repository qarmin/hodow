use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_u32_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u32_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u32_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svreinterpret_u32_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svreinterpret_u32_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u32_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u32_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[4575657222473777152]).map_err(|e| format!("{e} | call: svreinterpret_u64_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[4607182418800017408]).map_err(|e| format!("{e} | call: svreinterpret_u64_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[72340172838076673]).map_err(|e| format!("{e} | call: svreinterpret_u64_s8(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_s8(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[281479271743489]).map_err(|e| format!("{e} | call: svreinterpret_u64_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[4294967297]).map_err(|e| format!("{e} | call: svreinterpret_u64_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_u64_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[72340172838076673]).map_err(|e| format!("{e} | call: svreinterpret_u64_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[281479271743489]).map_err(|e| format!("{e} | call: svreinterpret_u64_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[4294967297]).map_err(|e| format!("{e} | call: svreinterpret_u64_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_u64_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svreinterpret_u64_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_u64_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_u64_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_u64_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_u64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b16(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_b16(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_b16(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b32(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_b32(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_b32(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b64(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_b64(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_b64(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrev_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrev_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrev_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrev_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svrev_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_s8(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_s8(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrev_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrev_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrev_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svrev_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrev_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrev_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrev_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrev_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrev_b8(create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svrev_b8(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrev_b8(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrev_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrev_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrevb_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[768]).map_err(|e| format!("{e} | call: svrevb_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrevb_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[512]).map_err(|e| format!("{e} | call: svrevb_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrevb_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[512]).map_err(|e| format!("{e} | call: svrevb_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevb_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[50331648]).map_err(|e| format!("{e} | call: svrevb_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevb_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[33554432]).map_err(|e| format!("{e} | call: svrevb_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevb_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[33554432]).map_err(|e| format!("{e} | call: svrevb_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevb_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[216172782113783808]).map_err(|e| format!("{e} | call: svrevb_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevb_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| format!("{e} | call: svrevb_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevb_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| format!("{e} | call: svrevb_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrevb_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[768]).map_err(|e| format!("{e} | call: svrevb_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrevb_u16_x(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[512]).map_err(|e| format!("{e} | call: svrevb_u16_x(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u16_x(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrevb_u16_z(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[512]).map_err(|e| format!("{e} | call: svrevb_u16_z(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u16_z(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevb_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[50331648]).map_err(|e| format!("{e} | call: svrevb_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevb_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[33554432]).map_err(|e| format!("{e} | call: svrevb_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u32_x(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevb_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[33554432]).map_err(|e| format!("{e} | call: svrevb_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u32_z(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevb_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[216172782113783808]).map_err(|e| format!("{e} | call: svrevb_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevb_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| format!("{e} | call: svrevb_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u64_x(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevb_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| format!("{e} | call: svrevb_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevb_u64_z(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevb_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevb_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevh_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[196608]).map_err(|e| format!("{e} | call: svrevh_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevh_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[131072]).map_err(|e| format!("{e} | call: svrevh_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevh_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[131072]).map_err(|e| format!("{e} | call: svrevh_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevh_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[844424930131968]).map_err(|e| format!("{e} | call: svrevh_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevh_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[562949953421312]).map_err(|e| format!("{e} | call: svrevh_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevh_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[562949953421312]).map_err(|e| format!("{e} | call: svrevh_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_s64_z_impl() }
}
