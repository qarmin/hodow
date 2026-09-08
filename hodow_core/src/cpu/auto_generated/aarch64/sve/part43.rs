use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintz_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrintz_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintz_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintz_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintz_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintz_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintz_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintz_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svrintz_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintz_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintz_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintz_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintz_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintz_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintz_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintz_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintz_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintz_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrintz_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrintz_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svrintz_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrintz_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrintz_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrintz_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrsqrte_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrsqrte_f32(create_svfloat32_t_from(1.0f32)));
        check_float_array_equality(&result, &[0.9980469]).map_err(|e| format!("{e} | call: svrsqrte_f32(create_svfloat32_t_from(1.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsqrte_f32(create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrsqrte_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrsqrte_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrsqrte_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrsqrte_f64(create_svfloat64_t_from(1.0f64)));
        check_float_array_equality(&result, &[0.998046875]).map_err(|e| format!("{e} | call: svrsqrte_f64(create_svfloat64_t_from(1.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsqrte_f64(create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrsqrte_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrsqrte_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrsqrts_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svrsqrts_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[0.5]).map_err(|e| format!("{e} | call: svrsqrts_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsqrts_f32(create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrsqrts_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrsqrts_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrsqrts_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svrsqrts_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[0.5]).map_err(|e| format!("{e} | call: svrsqrts_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svrsqrts_f64(create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svrsqrts_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svrsqrts_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64));
        check_float_array_equality(&result, &[16.0]).map_err(|e| format!("{e} | call: svscale_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svscale_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svscale_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svscale_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_b_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svsel_b(create_svbool_t(), create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svsel_b(create_svbool_t(), create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_b(create_svbool_t(), create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_b() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_b_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsel_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svsel_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svsel_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svsel_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsel_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsel_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsel_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsel_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsel_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsel_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsel_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsel_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsel_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsel_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsel_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsel_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsel_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsetffr_impl() -> Result<(), String> {
    unsafe {
        svsetffr();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                svsetffr();
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsetffr() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsetffr_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsplice_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svsplice_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svsplice_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svsplice_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svsplice_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svsplice_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsplice_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svsplice_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svsplice_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svsplice_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsplice_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsplice_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svsplice_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svsplice_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsplice_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsplice_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsplice_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsqrt_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsqrt_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[1.7320508]).map_err(|e| format!("{e} | call: svsqrt_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqrt_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsqrt_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsqrt_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsqrt_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsqrt_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.4142135]).map_err(|e| format!("{e} | call: svsqrt_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqrt_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsqrt_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsqrt_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsqrt_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsqrt_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[1.4142135]).map_err(|e| format!("{e} | call: svsqrt_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqrt_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsqrt_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsqrt_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsqrt_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svsqrt_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[1.7320508075688772]).map_err(|e| format!("{e} | call: svsqrt_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqrt_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsqrt_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsqrt_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsqrt_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svsqrt_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.4142135623730951]).map_err(|e| format!("{e} | call: svsqrt_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqrt_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsqrt_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsqrt_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsqrt_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svsqrt_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[1.4142135623730951]).map_err(|e| format!("{e} | call: svsqrt_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsqrt_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsqrt_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsqrt_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsub_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsub_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| format!("{e} | call: svsub_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsub_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsub_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsub_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsub_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svsub_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| format!("{e} | call: svsub_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svsub_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svsub_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svsub_n_f32_m_impl() }
}
