use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqshl_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqshl_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqshl_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqshl_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqshl_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqshl_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqshl_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqshl_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqshl_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqshl_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqshl_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqshl_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqshl_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqshl_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqshl_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshl_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshl_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshl_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshl_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshl_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshl_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshl_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshl_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshl_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshl_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshl_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshl_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshl_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshl_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshl_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshl_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshl_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshl_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshl_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshl_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshl_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshl_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshl_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshl_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s8_m::<1>(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s8_x::<1>(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqshlu_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s8_z::<1>(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s16_m::<1>(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s16_x::<1>(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqshlu_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s16_z::<1>(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s32_m::<1>(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s32_x::<1>(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqshlu_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s32_z::<1>(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s64_m::<1>(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshlu_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqshlu_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[4]).map_err(|e| format!("{e} | call: svqshlu_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshlu_n_s64_x::<1>(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshlu_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshlu_n_s64_x_impl() }
}
