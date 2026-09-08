use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_n_u64(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_wide_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_wide_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_wide_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_wide_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_wide_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_wide_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_wide_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_wide_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_wide_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_wide_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_wide_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_wide_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_wide_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_wide_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_wide_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_wide_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_wide_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_wide_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpne_wide_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpne_wide_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcmpne_wide_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpne_wide_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpne_wide_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpne_wide_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpuo_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpuo_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpuo_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpuo_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpuo_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpuo_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpuo_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpuo_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpuo_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpuo_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpuo_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpuo_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpuo_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpuo_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpuo_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpuo_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpuo_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpuo_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcnot_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svcnot_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s8_m(create_random_svint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcnot_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svcnot_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcnot_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svcnot_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcnot_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svcnot_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcnot_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svcnot_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcnot_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svcnot_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcnot_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcnot_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcnot_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcnot_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcnot_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcnot_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcnot_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svcnot_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcnot_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svcnot_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcnot_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svcnot_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcnot_u8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svcnot_u8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcnot_u8_x(create_svbool_t(), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svcnot_u8_x(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u8_x(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcnot_u8_z(create_svbool_t(), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svcnot_u8_z(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u8_z(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcnot_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svcnot_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcnot_u16_x(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svcnot_u16_x(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u16_x(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcnot_u16_z(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svcnot_u16_z(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u16_z(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnot_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svcnot_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnot_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svcnot_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u32_x(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnot_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svcnot_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u32_z(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcnot_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svcnot_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcnot_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svcnot_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u64_x(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnot_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcnot_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: svcnot_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnot_u64_z(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnot_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnot_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnt_f32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcnt_f32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_f32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnt_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnt_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcnt_f64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcnt_f64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_f64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcnt_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcnt_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcnt_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcnt_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcnt_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcnt_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcnt_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcnt_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcnt_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcnt_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnt_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcnt_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcnt_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcnt_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svcnt_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcnt_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcnt_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcnt_s32_x_impl() }
}
