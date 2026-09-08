use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasr_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3u64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svasr_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasr_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svasr_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasr_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3u64));
        check_array_equality(&result, &[0i64; 1]).map_err(|e| format!("{e} | call: svasr_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_wide_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_wide_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_wide_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u64));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_wide_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_wide_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_wide_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u64));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_wide_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_wide_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasr_wide_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u64));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_wide_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_wide_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_wide_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u64));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_wide_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_wide_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_wide_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u64));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_wide_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_wide_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasr_wide_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u64));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_wide_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_wide_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_wide_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_wide_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_wide_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_wide_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_wide_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_wide_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasr_wide_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasr_wide_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svasr_wide_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasr_wide_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasr_wide_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasr_wide_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s8_m::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s8_m::<1>(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s8_x::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s8_x::<1>(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svasrd_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s8_z::<1>(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s8_z::<1>(create_svbool_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s16_m::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s16_m::<1>(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s16_x::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s16_x::<1>(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svasrd_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s16_z::<1>(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s16_z::<1>(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s32_m::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s32_m::<1>(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s32_x::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s32_x::<1>(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svasrd_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s32_z::<1>(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s32_z::<1>(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s64_m::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s64_m::<1>(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s64_x::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s64_x::<1>(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svasrd_n_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svasrd_n_s64_z::<1>(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svasrd_n_s64_z::<1>(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svasrd_n_s64_z::<1>(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svasrd_n_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svasrd_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_b_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svbic_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svbic_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t())"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_b_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_b_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbic_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svbic_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbic_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svbic_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbic_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svbic_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbic_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svbic_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbic_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svbic_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbic_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svbic_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbic_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svbic_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbic_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svbic_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbic_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svbic_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbic_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svbic_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbic_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svbic_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbic_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svbic_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbic_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svbic_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbic_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svbic_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbic_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svbic_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svbic_n_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbic_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svbic_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbic_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svbic_n_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svbic_n_s32_x_impl() }
}
