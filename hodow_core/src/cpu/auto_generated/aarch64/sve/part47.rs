use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svtrn1q_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svtrn1q_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svtrn1q_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svtrn1q_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svtrn1q_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svtrn1q_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn1q_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svtrn1q_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn1q_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn1q_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn1q_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn1q_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svtrn2_b16(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svtrn2_b16(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_b16(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_b16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_b32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svtrn2_b32(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svtrn2_b32(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_b32(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_b32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_b32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_b64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svtrn2_b64(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svtrn2_b64(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_b64(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_b64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_b64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtrn2_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svtrn2_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_f32(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtrn2_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svtrn2_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_f64(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svtrn2_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svtrn2_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svtrn2_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svtrn2_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svtrn2_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svtrn2_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svtrn2_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svtrn2_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2_b8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svtrn2_b8(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svtrn2_b8(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2_b8(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2_b8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2_b8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtrn2q_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svtrn2q_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_f32(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtrn2q_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svtrn2q_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_f64(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svtrn2q_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_s8(create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svtrn2q_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_s16(create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svtrn2q_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_s32(create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svtrn2q_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_s64(create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svtrn2q_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svtrn2q_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_u16(create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svtrn2q_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_u32(create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtrn2q_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svtrn2q_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svtrn2q_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtrn2q_u64(create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtrn2q_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtrn2q_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtsmul_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtsmul_f32(create_svfloat32_t_from(1.0f32), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svtsmul_f32(create_svfloat32_t_from(1.0f32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtsmul_f32(create_random_svfloat32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtsmul_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtsmul_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtsmul_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtsmul_f64(create_svfloat64_t_from(1.0f64), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svtsmul_f64(create_svfloat64_t_from(1.0f64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtsmul_f64(create_random_svfloat64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtsmul_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtsmul_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtssel_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtssel_f32(create_svfloat32_t_from(1.0f32), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| format!("{e} | call: svtssel_f32(create_svfloat32_t_from(1.0f32), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtssel_f32(create_random_svfloat32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtssel_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtssel_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtssel_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtssel_f64(create_svfloat64_t_from(1.0f64), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| format!("{e} | call: svtssel_f64(create_svfloat64_t_from(1.0f64), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svtssel_f64(create_random_svfloat64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svtssel_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svtssel_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svundef_f32());
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svundef_f32()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_f32();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svundef_f64());
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svundef_f64()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_f64();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svundef_s8());
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svundef_s8()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_s8();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svundef_s16());
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svundef_s16()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_s16();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svundef_s32());
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svundef_s32()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_s32();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svundef_s64());
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svundef_s64()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_s64();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svundef_u8());
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svundef_u8()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_u8();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svundef_u16());
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svundef_u16()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_u16();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svundef_u32());
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svundef_u32()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_u32();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svundef_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svundef_u64());
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svundef_u64()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svundef_u64();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svundef_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svundef_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_lane_s32::<0>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svusdot_lane_s32::<0>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svusdot_lane_s32::<0>(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svusdot_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svusdot_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svusdot_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svusdot_s32(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svusdot_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svusdot_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_n_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[25]).map_err(|e| format!("{e} | call: svusdot_n_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svusdot_n_s32(create_random_svint32_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svusdot_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svusdot_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusmmla_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusmmla_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[49]).map_err(|e| format!("{e} | call: svusmmla_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svusmmla_s32(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svusmmla_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svusmmla_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svuzp1_b16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svuzp1_b16(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svuzp1_b16(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svuzp1_b16(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svuzp1_b16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svuzp1_b16_impl() }
}
