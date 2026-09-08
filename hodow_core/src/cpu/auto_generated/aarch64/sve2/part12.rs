use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svminp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svminp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminp_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svminp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svminp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svminp_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svminp_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svminp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svminp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svminp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svminp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svminp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svminp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svminp_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svminp_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svminp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svminp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svminp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svminp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svminp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svminp_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svminp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svminp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svminp_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svminp_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svminp_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmla_lane_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmla_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmla_lane_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmla_lane_s16::<0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmla_lane_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmla_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmla_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmla_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmla_lane_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmla_lane_s32::<0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmla_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmla_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmla_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmla_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmla_lane_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmla_lane_s64::<0>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmla_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmla_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmla_lane_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmla_lane_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmla_lane_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmla_lane_u16::<0>(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmla_lane_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmla_lane_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmla_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmla_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmla_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmla_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmla_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmla_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmla_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmla_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmla_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmla_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmla_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmla_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_n_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_n_s64(create_random_svint64_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlalb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_u16(create_random_svuint16_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmlalb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_n_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_n_u16(create_random_svuint16_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_u32(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_n_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_n_u32(create_random_svuint32_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_u64(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalb_n_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalb_n_u64(create_random_svuint64_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_lane_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_lane_s32::<0>(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_lane_s32::<0>(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_lane_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_lane_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_lane_s64::<0>(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_lane_s64::<0>(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_lane_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_lane_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_lane_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmlalt_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_lane_u32::<0>(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_lane_u32::<0>(create_random_svuint32_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_lane_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_lane_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmlalt_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_lane_u64::<0>(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_lane_u64::<0>(create_random_svuint64_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_lane_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_lane_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlalt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_s16(create_random_svint16_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmlalt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_n_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_n_s16(create_random_svint16_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_s32(create_random_svint32_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmlalt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_n_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_n_s32(create_random_svint32_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svmlalt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmlalt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svmlalt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmlalt_s64(create_random_svint64_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svmlalt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svmlalt_s64_impl() }
}
