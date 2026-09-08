use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmad_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmad_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmad_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmad_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmad_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmad_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmad_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmad_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| format!("{e} | call: svnmad_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmad_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmad_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmad_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| format!("{e} | call: svnmla_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmla_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmla_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmla_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmls_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmls_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmls_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmls_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmls_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmls_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmls_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmls_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmls_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmls_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmls_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmls_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmls_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[10.0]).map_err(|e| format!("{e} | call: svnmls_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmls_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmls_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmls_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmsb_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmsb_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmsb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmsb_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmsb_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmsb_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmsb_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_n_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmsb_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_n_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmsb_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_n_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmsb_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_n_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmsb_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmsb_n_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmsb_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svnmsb_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnmsb_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnmsb_n_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnmsb_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnor_b_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svnor_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svnor_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnor_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnor_b_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnor_b_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnot_b_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svnot_b_z(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svnot_b_z(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnot_b_z(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnot_b_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnot_b_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnot_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svnot_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-4]).map_err(|e| format!("{e} | call: svnot_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnot_s8_m(create_random_svint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnot_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnot_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnot_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svnot_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svnot_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnot_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnot_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnot_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnot_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svnot_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svnot_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnot_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnot_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnot_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnot_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svnot_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-4]).map_err(|e| format!("{e} | call: svnot_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnot_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnot_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnot_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnot_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svnot_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-3]).map_err(|e| format!("{e} | call: svnot_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svnot_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svnot_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svnot_s16_x_impl() }
}
