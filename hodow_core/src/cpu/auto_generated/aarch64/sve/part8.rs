use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svclasta_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclasta_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclasta_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclasta_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclasta_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclasta_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclasta_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclasta_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclasta_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclasta_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_f32_impl() -> Result<(), String> {
    unsafe {
        let _result = svclasta_n_f32(create_svbool_t(), 2.0f32, create_svfloat32_t_from(3.0f32));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_f32(create_svbool_t(), rand::random::<f32>(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_f64_impl() -> Result<(), String> {
    unsafe {
        let _result = svclasta_n_f64(create_svbool_t(), 2.0f64, create_svfloat64_t_from(3.0f64));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_f64(create_svbool_t(), rand::random::<f64>(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_s8(create_svbool_t(), 2i8, create_svint8_t_from(3i8));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_s8(create_svbool_t(), 2i8, create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_s8(create_svbool_t(), rand::random::<i8>(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_s16(create_svbool_t(), 2i16, create_svint16_t_from(3i16));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_s16(create_svbool_t(), 2i16, create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_s16(create_svbool_t(), rand::random::<i16>(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_s32(create_svbool_t(), 2i32, create_svint32_t_from(3i32));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_s32(create_svbool_t(), 2i32, create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_s32(create_svbool_t(), rand::random::<i32>(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_s64(create_svbool_t(), 2i64, create_svint64_t_from(3i64));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_s64(create_svbool_t(), 2i64, create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_s64(create_svbool_t(), rand::random::<i64>(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_u8(create_svbool_t(), 2u8, create_svuint8_t_from(3u8));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_u8(create_svbool_t(), 2u8, create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_u8(create_svbool_t(), rand::random::<u8>(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_u16(create_svbool_t(), 2u16, create_svuint16_t_from(3u16));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_u16(create_svbool_t(), 2u16, create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_u16(create_svbool_t(), rand::random::<u16>(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_u32(create_svbool_t(), 2u32, create_svuint32_t_from(3u32));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_u32(create_svbool_t(), 2u32, create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_u32(create_svbool_t(), rand::random::<u32>(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclasta_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = svclasta_n_u64(create_svbool_t(), 2u64, create_svuint64_t_from(3u64));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclasta_n_u64(create_svbool_t(), 2u64, create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclasta_n_u64(create_svbool_t(), rand::random::<u64>(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclasta_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclasta_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svclastb_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svclastb_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svclastb_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svclastb_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svclastb_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svclastb_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svclastb_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svclastb_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclastb_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclastb_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclastb_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclastb_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svclastb_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_f32_impl() -> Result<(), String> {
    unsafe {
        let _result = svclastb_n_f32(create_svbool_t(), 2.0f32, create_svfloat32_t_from(3.0f32));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_f32(create_svbool_t(), rand::random::<f32>(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_f64_impl() -> Result<(), String> {
    unsafe {
        let _result = svclastb_n_f64(create_svbool_t(), 2.0f64, create_svfloat64_t_from(3.0f64));

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_f64(create_svbool_t(), rand::random::<f64>(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_s8(create_svbool_t(), 2i8, create_svint8_t_from(3i8));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_s8(create_svbool_t(), 2i8, create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_s8(create_svbool_t(), rand::random::<i8>(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_s16(create_svbool_t(), 2i16, create_svint16_t_from(3i16));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_s16(create_svbool_t(), 2i16, create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_s16(create_svbool_t(), rand::random::<i16>(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_s32(create_svbool_t(), 2i32, create_svint32_t_from(3i32));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_s32(create_svbool_t(), 2i32, create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_s32(create_svbool_t(), rand::random::<i32>(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_s64(create_svbool_t(), 2i64, create_svint64_t_from(3i64));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_s64(create_svbool_t(), 2i64, create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_s64(create_svbool_t(), rand::random::<i64>(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_u8(create_svbool_t(), 2u8, create_svuint8_t_from(3u8));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_u8(create_svbool_t(), 2u8, create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_u8(create_svbool_t(), rand::random::<u8>(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_u16(create_svbool_t(), 2u16, create_svuint16_t_from(3u16));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_u16(create_svbool_t(), 2u16, create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_u16(create_svbool_t(), rand::random::<u16>(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_u32(create_svbool_t(), 2u32, create_svuint32_t_from(3u32));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_u32(create_svbool_t(), 2u32, create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_u32(create_svbool_t(), rand::random::<u32>(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclastb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = svclastb_n_u64(create_svbool_t(), 2u64, create_svuint64_t_from(3u64));
        check_int_equality(result as i32, 3).map_err(|e| format!("{e} | call: svclastb_n_u64(create_svbool_t(), 2u64, create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclastb_n_u64(create_svbool_t(), rand::random::<u64>(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclastb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclastb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcls_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svcls_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcls_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svcls_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcls_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[5]).map_err(|e| format!("{e} | call: svcls_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcls_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svcls_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcls_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svcls_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcls_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[13]).map_err(|e| format!("{e} | call: svcls_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcls_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[29]).map_err(|e| format!("{e} | call: svcls_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcls_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[29]).map_err(|e| format!("{e} | call: svcls_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcls_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[29]).map_err(|e| format!("{e} | call: svcls_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcls_s64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[61]).map_err(|e| format!("{e} | call: svcls_s64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcls_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[61]).map_err(|e| format!("{e} | call: svcls_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcls_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[61]).map_err(|e| format!("{e} | call: svcls_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcls_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcls_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcls_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclz_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svclz_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclz_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svclz_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclz_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svclz_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s8_z_impl() }
}
