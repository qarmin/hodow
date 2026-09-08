use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevh_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[196608]).map_err(|e| format!("{e} | call: svrevh_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevh_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[131072]).map_err(|e| format!("{e} | call: svrevh_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_u32_x(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevh_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[131072]).map_err(|e| format!("{e} | call: svrevh_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_u32_z(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevh_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[844424930131968]).map_err(|e| format!("{e} | call: svrevh_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevh_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[562949953421312]).map_err(|e| format!("{e} | call: svrevh_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_u64_x(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevh_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevh_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[562949953421312]).map_err(|e| format!("{e} | call: svrevh_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevh_u64_z(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevh_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevh_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevw_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[12884901888]).map_err(|e| format!("{e} | call: svrevw_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevw_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevw_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevw_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevw_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| format!("{e} | call: svrevw_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevw_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevw_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevw_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevw_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| format!("{e} | call: svrevw_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevw_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevw_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevw_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevw_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[12884901888]).map_err(|e| format!("{e} | call: svrevw_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevw_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevw_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevw_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevw_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| format!("{e} | call: svrevw_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevw_u64_x(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevw_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevw_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevw_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevw_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[8589934592]).map_err(|e| format!("{e} | call: svrevw_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrevw_u64_z(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrevw_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrevw_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinta_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrinta_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrinta_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinta_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinta_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinta_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinta_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrinta_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinta_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinta_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinta_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinta_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinta_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrinta_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinta_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinta_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinta_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinta_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinta_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrinta_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrinta_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinta_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinta_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinta_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinta_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrinta_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinta_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinta_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinta_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinta_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinta_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrinta_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinta_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinta_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinta_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinta_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinti_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrinti_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrinti_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinti_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinti_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinti_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinti_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrinti_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinti_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinti_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinti_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinti_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinti_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrinti_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinti_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinti_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinti_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinti_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinti_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrinti_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrinti_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinti_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinti_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinti_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinti_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrinti_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinti_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinti_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinti_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinti_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrinti_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrinti_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrinti_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrinti_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrinti_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrinti_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintm_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintm_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintm_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintm_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintm_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintm_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintm_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintm_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintm_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintm_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintm_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintm_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintm_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintm_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintm_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintm_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintm_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintm_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintm_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintm_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintm_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintm_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintm_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintm_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintm_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintm_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintm_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintm_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintm_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintm_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintm_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintm_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintm_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintm_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintm_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintm_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintn_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintn_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintn_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintn_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintn_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintn_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintn_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintn_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintn_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintn_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintn_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintn_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintn_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintn_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintn_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintn_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintn_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintn_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintn_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintn_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintn_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintn_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintn_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintn_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintn_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintn_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintn_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintn_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintn_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintn_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintn_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintn_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintn_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintn_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintn_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintn_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintp_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintp_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintp_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintp_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintp_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintp_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintp_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintp_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintp_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintp_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintp_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintp_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintp_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintp_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintp_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintp_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintp_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintp_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintp_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintp_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintp_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintp_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintp_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintp_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintp_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintp_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintp_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintp_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintp_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintp_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintp_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintp_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintp_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintp_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintx_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintx_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintx_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintx_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintx_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintx_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintx_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintx_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintx_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintx_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintx_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintx_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintx_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintx_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintx_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintx_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintx_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintx_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintx_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintx_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintx_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintx_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintx_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintx_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintx_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintx_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintx_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintx_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintx_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintx_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintx_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintx_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintx_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintx_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintx_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintx_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintz_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintz_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintz_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintz_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintz_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintz_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintz_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintz_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintz_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintz_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintz_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintz_f32_x_impl() }
}
