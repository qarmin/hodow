use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmls_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16), 4i16));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16), 4i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmls_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16), create_svint16_t_from(4i16)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16), create_svint16_t_from(4i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svmls_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16), 4i16));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16), 4i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), create_svint32_t_from(4i32)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), create_svint32_t_from(4i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), 4i32));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), 4i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), create_svint32_t_from(4i32)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), create_svint32_t_from(4i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), 4i32));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), 4i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), create_svint32_t_from(4i32)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), create_svint32_t_from(4i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmls_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), 4i32));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32), 4i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), create_svint64_t_from(4i64)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), create_svint64_t_from(4i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), 4i64));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), 4i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), create_svint64_t_from(4i64)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), create_svint64_t_from(4i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), 4i64));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), 4i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), create_svint64_t_from(4i64)));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), create_svint64_t_from(4i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svmls_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), 4i64));
        check_array_equality(&result, &[-10]).map_err(|e| format!("{e} | call: svmls_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64), 4i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmls_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), create_svuint8_t_from(4u8)));
        check_array_equality(&result, &[246]).map_err(|e| format!("{e} | call: svmls_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), create_svuint8_t_from(4u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmls_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), 4u8));
        check_array_equality(&result, &[246]).map_err(|e| format!("{e} | call: svmls_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), 4u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmls_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), create_svuint8_t_from(4u8)));
        check_array_equality(&result, &[246]).map_err(|e| format!("{e} | call: svmls_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), create_svuint8_t_from(4u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmls_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), 4u8));
        check_array_equality(&result, &[246]).map_err(|e| format!("{e} | call: svmls_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), 4u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmls_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), create_svuint8_t_from(4u8)));
        check_array_equality(&result, &[246]).map_err(|e| format!("{e} | call: svmls_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), create_svuint8_t_from(4u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svmls_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), 4u8));
        check_array_equality(&result, &[246]).map_err(|e| format!("{e} | call: svmls_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8), 4u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), create_svuint16_t_from(4u16)));
        check_array_equality(&result, &[65526]).map_err(|e| format!("{e} | call: svmls_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), create_svuint16_t_from(4u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), 4u16));
        check_array_equality(&result, &[65526]).map_err(|e| format!("{e} | call: svmls_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), 4u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), create_svuint16_t_from(4u16)));
        check_array_equality(&result, &[65526]).map_err(|e| format!("{e} | call: svmls_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), create_svuint16_t_from(4u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), 4u16));
        check_array_equality(&result, &[65526]).map_err(|e| format!("{e} | call: svmls_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), 4u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), create_svuint16_t_from(4u16)));
        check_array_equality(&result, &[65526]).map_err(|e| format!("{e} | call: svmls_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), create_svuint16_t_from(4u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svmls_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), 4u16));
        check_array_equality(&result, &[65526]).map_err(|e| format!("{e} | call: svmls_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16), 4u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), create_svuint32_t_from(4u32)));
        check_array_equality(&result, &[4294967286]).map_err(|e| format!("{e} | call: svmls_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), create_svuint32_t_from(4u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), 4u32));
        check_array_equality(&result, &[4294967286]).map_err(|e| format!("{e} | call: svmls_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), 4u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), create_svuint32_t_from(4u32)));
        check_array_equality(&result, &[4294967286]).map_err(|e| format!("{e} | call: svmls_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), create_svuint32_t_from(4u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), 4u32));
        check_array_equality(&result, &[4294967286]).map_err(|e| format!("{e} | call: svmls_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), 4u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), create_svuint32_t_from(4u32)));
        check_array_equality(&result, &[4294967286]).map_err(|e| format!("{e} | call: svmls_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), create_svuint32_t_from(4u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmls_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), 4u32));
        check_array_equality(&result, &[4294967286]).map_err(|e| format!("{e} | call: svmls_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32), 4u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), create_svuint64_t_from(4u64)));
        check_array_equality(&result, &[18446744073709551606]).map_err(|e| format!("{e} | call: svmls_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), create_svuint64_t_from(4u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), 4u64));
        check_array_equality(&result, &[18446744073709551606]).map_err(|e| format!("{e} | call: svmls_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), 4u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), create_svuint64_t_from(4u64)));
        check_array_equality(&result, &[18446744073709551606]).map_err(|e| format!("{e} | call: svmls_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), create_svuint64_t_from(4u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), 4u64));
        check_array_equality(&result, &[18446744073709551606]).map_err(|e| format!("{e} | call: svmls_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), 4u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), create_svuint64_t_from(4u64)));
        check_array_equality(&result, &[18446744073709551606]).map_err(|e| format!("{e} | call: svmls_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), create_svuint64_t_from(4u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svmls_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), 4u64));
        check_array_equality(&result, &[18446744073709551606]).map_err(|e| format!("{e} | call: svmls_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64), 4u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_n_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_lane_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmls_lane_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: svmls_lane_f32::<0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_f32::<0>(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_lane_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_lane_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmls_lane_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmls_lane_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[-5.0]).map_err(|e| format!("{e} | call: svmls_lane_f64::<0>(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmls_lane_f64::<0>(create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmls_lane_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmls_lane_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmmla_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[13.0]).map_err(|e| format!("{e} | call: svmmla_f32(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmmla_f32(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmmla_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmmla_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svmmla_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[13.0]).map_err(|e| format!("{e} | call: svmmla_f64(create_svfloat64_t_from(1.0f64), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmmla_f64(create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmmla_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmmla_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svmmla_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[49]).map_err(|e| format!("{e} | call: svmmla_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmmla_s32(create_random_svint32_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmmla_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmmla_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmmla_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svmmla_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[49]).map_err(|e| format!("{e} | call: svmmla_u32(create_svuint32_t_from(1u32), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmmla_u32(create_random_svuint32_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmmla_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmmla_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmov_b_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svmov_b_z(create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svmov_b_z(create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmov_b_z(create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmov_b_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmov_b_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmsb_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmsb_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-2.0]).map_err(|e| format!("{e} | call: svmsb_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmsb_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmsb_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmsb_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmsb_n_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmsb_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-2.0]).map_err(|e| format!("{e} | call: svmsb_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmsb_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmsb_n_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmsb_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmsb_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmsb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-2.0]).map_err(|e| format!("{e} | call: svmsb_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmsb_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmsb_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmsb_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svmsb_n_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svmsb_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-2.0]).map_err(|e| format!("{e} | call: svmsb_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svmsb_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svmsb_n_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svmsb_n_f32_x_impl() }
}
