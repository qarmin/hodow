use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsl_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsl_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsl_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsl_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsl_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svlsl_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svlsl_wide_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svlsl_wide_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svlsl_wide_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svlsl_wide_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svlsl_wide_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svlsl_wide_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svlsl_wide_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svlsl_wide_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svlsl_wide_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svlsl_wide_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svlsl_wide_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svlsl_wide_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlsl_wide_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlsl_wide_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlsl_wide_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlsl_wide_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlsl_wide_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svlsl_wide_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsl_wide_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsl_wide_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsl_wide_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsl_wide_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsl_wide_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsl_wide_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsl_wide_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsl_wide_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsl_wide_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsl_wide_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsl_wide_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svlsl_wide_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_wide_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_wide_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_wide_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_wide_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_wide_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsl_wide_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svlsl_wide_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svlsl_wide_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsl_wide_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsl_wide_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsl_wide_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svlsr_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svlsr_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svlsr_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svlsr_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svlsr_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svlsr_u8_x_impl() }
}
