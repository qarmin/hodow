use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcmla_u8::<90>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svcmla_u8::<90>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_u8::<90>(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcmla_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcmla_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcmla_u16::<90>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svcmla_u16::<90>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_u16::<90>(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcmla_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcmla_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcmla_u32::<90>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svcmla_u32::<90>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_u32::<90>(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcmla_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcmla_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcmla_u64::<90>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[7]).map_err(|e| format!("{e} | call: svcmla_u64::<90>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_u64::<90>(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcmla_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcmla_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtlt_f64_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvtlt_f64_f32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svcvtlt_f64_f32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtlt_f64_f32_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtlt_f64_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtlt_f64_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtlt_f64_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvtlt_f64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svcvtlt_f64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtlt_f64_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtlt_f64_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtlt_f64_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtnt_f32_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtnt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svcvtnt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtnt_f32_f64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtnt_f32_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtnt_f32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtnt_f32_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtnt_f32_f64_x(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svcvtnt_f32_f64_x(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtnt_f32_f64_x(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtnt_f32_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtnt_f32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtx_f32_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtx_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svcvtx_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtx_f32_f64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtx_f32_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtx_f32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtx_f32_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtx_f32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svcvtx_f32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtx_f32_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtx_f32_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtx_f32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtx_f32_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtx_f32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svcvtx_f32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtx_f32_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtx_f32_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtx_f32_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtxnt_f32_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtxnt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svcvtxnt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtxnt_f32_f64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtxnt_f32_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtxnt_f32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcvtxnt_f32_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvtxnt_f32_f64_x(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svcvtxnt_f32_f64_x(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvtxnt_f32_f64_x(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svcvtxnt_f32_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svcvtxnt_f32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(sveor3_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: sveor3_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(sveor3_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: sveor3_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(sveor3_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: sveor3_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(sveor3_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: sveor3_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(sveor3_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: sveor3_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(sveor3_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: sveor3_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveor3_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: sveor3_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveor3_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: sveor3_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor3_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: sveor3_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveor3_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: sveor3_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_u8(create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor3_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: sveor3_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveor3_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: sveor3_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_u16(create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor3_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: sveor3_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveor3_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: sveor3_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor3_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: sveor3_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveor3_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveor3_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0u64; 1]).map_err(|e| format!("{e} | call: sveor3_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveor3_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveor3_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveor3_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(sveorbt_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(sveorbt_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(sveorbt_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(sveorbt_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(sveorbt_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(sveorbt_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveorbt_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(sveorbt_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveorbt_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_u8(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(sveorbt_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_u8(create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveorbt_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_u16(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(sveorbt_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_u16(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_u16(create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveorbt_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_u32(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(sveorbt_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_u32(create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveorbt_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_u64(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveorbt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(sveorbt_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveorbt_n_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveorbt_n_u64(create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveorbt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveorbt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveortb_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(sveortb_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveortb_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveortb_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveortb_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveortb_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveortb_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(sveortb_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveortb_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveortb_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveortb_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveortb_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveortb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(sveortb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveortb_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveortb_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveortb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveortb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveortb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(sveortb_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveortb_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveortb_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveortb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveortb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_sveortb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(sveortb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: sveortb_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sveortb_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_sveortb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_sveortb_s32_impl() }
}
