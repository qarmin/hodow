use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrdffr_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrdffr());
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svrdffr()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrdffr();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrdffr() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrdffr_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrdffr_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svrdffr_z(create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svrdffr_z(create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrdffr_z(create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrdffr_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrdffr_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpe_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrecpe_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[0.9980469]).map_err(|e| format!("{e} | call: svrecpe_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpe_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpe_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpe_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpe_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrecpe_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[0.998046875]).map_err(|e| format!("{e} | call: svrecpe_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpe_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpe_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpe_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecps_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrecps_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svrecps_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecps_f32(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecps_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecps_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecps_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrecps_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svrecps_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecps_f64(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecps_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecps_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpx_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrecpx_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrecpx_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpx_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpx_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpx_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpx_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrecpx_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrecpx_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpx_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpx_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpx_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpx_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrecpx_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrecpx_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpx_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpx_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpx_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpx_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrecpx_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrecpx_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpx_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpx_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpx_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpx_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrecpx_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrecpx_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpx_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpx_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpx_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrecpx_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrecpx_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svrecpx_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrecpx_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrecpx_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrecpx_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svreinterpret_f32_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[1.875]).map_err(|e| format!("{e} | call: svreinterpret_f32_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s8(create_svint8_t_from(1i8)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_s8(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_s8(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s16(create_svint16_t_from(1i16)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s32(create_svint32_t_from(1i32)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_s64(create_svint64_t_from(1i64)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u8(create_svuint8_t_from(1u8)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u16(create_svuint16_t_from(1u16)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u32(create_svuint32_t_from(1u32)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f32_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svreinterpret_f32_u64(create_svuint64_t_from(1u64)));
        check_float_array_equality(&result, &[0.0f32; 1]).map_err(|e| format!("{e} | call: svreinterpret_f32_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f32_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f32_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f32_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[0.007812501848093234]).map_err(|e| format!("{e} | call: svreinterpret_f64_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| format!("{e} | call: svreinterpret_f64_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s8(create_svint8_t_from(1i8)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_s8(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_s8(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s16(create_svint16_t_from(1i16)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s32(create_svint32_t_from(1i32)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_s64(create_svint64_t_from(1i64)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u8(create_svuint8_t_from(1u8)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u16(create_svuint16_t_from(1u16)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u32(create_svuint32_t_from(1u32)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_f64_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svreinterpret_f64_u64(create_svuint64_t_from(1u64)));
        check_float_array_equality(&result, &[0.0f64; 1]).map_err(|e| format!("{e} | call: svreinterpret_f64_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_f64_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_f64_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_f64_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[63]).map_err(|e| format!("{e} | call: svreinterpret_s8_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[63]).map_err(|e| format!("{e} | call: svreinterpret_s8_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_s8_s8(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_s8(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svreinterpret_s8_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svreinterpret_s8_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svreinterpret_s8_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_s8_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svreinterpret_s8_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u32(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svreinterpret_s8_u32(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_u32(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s8_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svreinterpret_s8_u64(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svreinterpret_s8_u64(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s8_u64(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s8_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s8_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_f32(create_svfloat32_t_from(1.0f32)));
        check_array_equality(&result, &[16256]).map_err(|e| format!("{e} | call: svreinterpret_s16_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_f64(create_svfloat64_t_from(1.0f64)));
        check_array_equality(&result, &[16368]).map_err(|e| format!("{e} | call: svreinterpret_s16_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s8(create_svint8_t_from(1i8)));
        check_array_equality(&result, &[257]).map_err(|e| format!("{e} | call: svreinterpret_s16_s8(create_svint8_t_from(1i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_s8(create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s16(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_s16_s16(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_s16(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s32(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svreinterpret_s16_s32(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_s32(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_s64(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svreinterpret_s16_s64(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_s64(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[257]).map_err(|e| format!("{e} | call: svreinterpret_s16_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svreinterpret_s16_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svreinterpret_s16_u16(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svreinterpret_s16_u16(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svreinterpret_s16_u16(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svreinterpret_s16_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svreinterpret_s16_u16_impl() }
}
