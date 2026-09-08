use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaddp_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaddp_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddp_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svaddp_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddp_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddp_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddp_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddwb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_s16(create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddwb_n_s16(create_svint16_t_from(1i16), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_n_s16(create_svint16_t_from(1i16), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_n_s16(create_random_svint16_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddwb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_s32(create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddwb_n_s32(create_svint32_t_from(1i32), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_n_s32(create_svint32_t_from(1i32), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_n_s32(create_random_svint32_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddwb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_s64(create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddwb_n_s64(create_svint64_t_from(1i64), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_n_s64(create_svint64_t_from(1i64), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_n_s64(create_random_svint64_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddwb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_u16(create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddwb_n_u16(create_svuint16_t_from(1u16), 2u8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_n_u16(create_svuint16_t_from(1u16), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_n_u16(create_random_svuint16_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddwb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_u32(create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddwb_n_u32(create_svuint32_t_from(1u32), 2u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_n_u32(create_svuint32_t_from(1u32), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_n_u32(create_random_svuint32_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddwb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_u64(create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddwb_n_u64(create_svuint64_t_from(1u64), 2u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwb_n_u64(create_svuint64_t_from(1u64), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwb_n_u64(create_random_svuint64_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddwt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_s16(create_svint16_t_from(1i16), create_svint8_t_from(2i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_s16(create_random_svint16_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svaddwt_n_s16(create_svint16_t_from(1i16), 2i8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_n_s16(create_svint16_t_from(1i16), 2i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_n_s16(create_random_svint16_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddwt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_s32(create_svint32_t_from(1i32), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_s32(create_random_svint32_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svaddwt_n_s32(create_svint32_t_from(1i32), 2i16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_n_s32(create_svint32_t_from(1i32), 2i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_n_s32(create_random_svint32_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddwt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_s64(create_svint64_t_from(1i64), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_s64(create_random_svint64_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svaddwt_n_s64(create_svint64_t_from(1i64), 2i32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_n_s64(create_svint64_t_from(1i64), 2i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_n_s64(create_random_svint64_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddwt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_u16(create_svuint16_t_from(1u16), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_u16(create_random_svuint16_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svaddwt_n_u16(create_svuint16_t_from(1u16), 2u8));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_n_u16(create_svuint16_t_from(1u16), 2u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_n_u16(create_random_svuint16_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddwt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_u32(create_svuint32_t_from(1u32), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_u32(create_random_svuint32_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svaddwt_n_u32(create_svuint32_t_from(1u32), 2u16));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_n_u32(create_svuint32_t_from(1u32), 2u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_n_u32(create_random_svuint32_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddwt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_u64(create_svuint64_t_from(1u64), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_u64(create_random_svuint64_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaddwt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svaddwt_n_u64(create_svuint64_t_from(1u64), 2u32));
        check_array_equality(&result, &[3]).map_err(|e| format!("{e} | call: svaddwt_n_u64(create_svuint64_t_from(1u64), 2u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaddwt_n_u64(create_random_svuint64_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaddwt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaddwt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaesd_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaesd_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[213]).map_err(|e| format!("{e} | call: svaesd_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaesd_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaesd_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaesd_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaese_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaese_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[123]).map_err(|e| format!("{e} | call: svaese_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaese_u8(create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaese_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaese_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaesimc_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaesimc_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svaesimc_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaesimc_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaesimc_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaesimc_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svaesmc_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaesmc_u8(create_svuint8_t_from(1u8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svaesmc_u8(create_svuint8_t_from(1u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svaesmc_u8(create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svaesmc_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svaesmc_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbcax_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_s8(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svbcax_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_s8(create_svint8_t_from(1i8), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_s8(create_random_svint8_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbcax_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_s16(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svbcax_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_s16(create_svint16_t_from(1i16), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_s16(create_random_svint16_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbcax_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_s32(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svbcax_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_s32(create_svint32_t_from(1i32), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_s32(create_random_svint32_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svbcax_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_s64(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svbcax_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svbcax_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svbcax_n_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svbcax_n_s64(create_random_svint64_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svbcax_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svbcax_n_s64_impl() }
}
