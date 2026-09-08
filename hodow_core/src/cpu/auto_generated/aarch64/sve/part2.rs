use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabd_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabd_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabd_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svabd_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabd_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabd_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabd_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabd_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabd_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabd_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svabd_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svabd_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabd_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabd_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabd_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svabs_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svabs_f32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_f32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svabs_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svabs_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_f32_x(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svabs_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svabs_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_f32_z(create_svbool_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svabs_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| format!("{e} | call: svabs_f64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_f64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svabs_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svabs_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_f64_x(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svabs_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| format!("{e} | call: svabs_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_f64_z(create_svbool_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svabs_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svabs_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s8_m(create_random_svint8_t(), create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svabs_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s8_x(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svabs_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s8_z(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabs_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svabs_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabs_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svabs_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabs_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svabs_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabs_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svabs_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabs_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svabs_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabs_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svabs_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svabs_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[2]).map_err(|e| format!("{e} | call: svabs_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svabs_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svabs_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svabs_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacge_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacge_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacge_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacge_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacge_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacge_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacge_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacge_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacge_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacge_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacge_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacge_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacge_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacge_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacge_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacge_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacge_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacge_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacge_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacge_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacge_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacge_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacge_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacge_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacgt_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacgt_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacgt_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacgt_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacgt_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacgt_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacgt_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacgt_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacgt_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacgt_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacgt_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacgt_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacgt_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacgt_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacgt_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacgt_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacgt_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacgt_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacgt_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacgt_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svacgt_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacgt_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacgt_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacgt_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacle_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacle_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svacle_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacle_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacle_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacle_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacle_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacle_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svacle_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacle_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacle_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacle_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacle_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacle_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svacle_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacle_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacle_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacle_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svacle_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svacle_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svacle_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svacle_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svacle_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svacle_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svaclt_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svaclt_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svaclt_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaclt_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svaclt_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svaclt_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svaclt_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svaclt_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svaclt_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaclt_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svaclt_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svaclt_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svaclt_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svaclt_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svaclt_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaclt_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svaclt_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svaclt_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svaclt_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svaclt_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svaclt_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaclt_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svaclt_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svaclt_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadd_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svadd_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| format!("{e} | call: svadd_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadd_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svadd_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svadd_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadd_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svadd_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[5.0]).map_err(|e| format!("{e} | call: svadd_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadd_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svadd_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svadd_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadd_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svadd_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| format!("{e} | call: svadd_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadd_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svadd_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svadd_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadd_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svadd_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[5.0]).map_err(|e| format!("{e} | call: svadd_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadd_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svadd_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svadd_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadd_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svadd_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| format!("{e} | call: svadd_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadd_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svadd_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svadd_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svadd_n_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svadd_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[5.0]).map_err(|e| format!("{e} | call: svadd_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svadd_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svadd_n_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svadd_n_f32_z_impl() }
}
