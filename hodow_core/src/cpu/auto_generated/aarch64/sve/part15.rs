use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svcvt_f64_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_f64_u32_x(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_f64_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_f64_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svcvt_f64_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_f64_u32_z(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_f64_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_f64_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svcvt_s32_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s32_f32_m(create_random_svint32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s32_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s32_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_s32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s32_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s32_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s32_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_s32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s32_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s32_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s32_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svcvt_s64_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s64_f64_m(create_random_svint64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s64_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s64_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_s64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s64_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s64_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s64_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_s64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s64_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s64_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s64_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svcvt_u32_f32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u32_f32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u32_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u32_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_u32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u32_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u32_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u32_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_u32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u32_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u32_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u32_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svcvt_u64_f64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u64_f64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u64_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u64_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_u64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u64_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u64_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u64_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_u64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u64_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u64_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u64_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f64_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcvt_s32_f64_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s32_f64_m(create_random_svint32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s32_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcvt_s32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s32_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s32_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcvt_s32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s32_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s32_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s32_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f32_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svcvt_s64_f32_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s64_f32_m(create_random_svint64_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s64_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s64_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_s64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s64_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s64_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s64_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_s64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_s64_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_s64_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_s64_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f64_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svcvt_u32_f64_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u32_f64_m(create_random_svuint32_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u32_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svcvt_u32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u32_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u32_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svcvt_u32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u32_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u32_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u32_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f32_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svcvt_u64_f32_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u64_f32_m(create_random_svuint64_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u64_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u64_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_u64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u64_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u64_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u64_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svcvt_u64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcvt_u64_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcvt_u64_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcvt_u64_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdiv_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[0.6666667]).map_err(|e| format!("{e} | call: svdiv_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdiv_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[0.6666667]).map_err(|e| format!("{e} | call: svdiv_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdiv_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[0.6666667]).map_err(|e| format!("{e} | call: svdiv_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdiv_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[0.6666667]).map_err(|e| format!("{e} | call: svdiv_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdiv_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[0.6666667]).map_err(|e| format!("{e} | call: svdiv_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdiv_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[0.6666667]).map_err(|e| format!("{e} | call: svdiv_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdiv_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[0.6666666666666666]).map_err(|e| format!("{e} | call: svdiv_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdiv_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_float_array_equality(&result, &[0.6666666666666666]).map_err(|e| format!("{e} | call: svdiv_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdiv_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[0.6666666666666666]).map_err(|e| format!("{e} | call: svdiv_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdiv_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_float_array_equality(&result, &[0.6666666666666666]).map_err(|e| format!("{e} | call: svdiv_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdiv_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[0.6666666666666666]).map_err(|e| format!("{e} | call: svdiv_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdiv_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_float_array_equality(&result, &[0.6666666666666666]).map_err(|e| format!("{e} | call: svdiv_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdiv_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svdiv_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdiv_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svdiv_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdiv_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svdiv_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdiv_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svdiv_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdiv_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svdiv_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdiv_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svdiv_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdiv_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svdiv_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdiv_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svdiv_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdiv_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svdiv_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdiv_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svdiv_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdiv_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svdiv_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdiv_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdiv_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svdiv_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svdiv_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svdiv_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svdiv_n_s64_z_impl() }
}
