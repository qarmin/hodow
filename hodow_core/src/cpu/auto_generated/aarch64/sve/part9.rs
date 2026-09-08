use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclz_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[14]).map_err(|e| format!("{e} | call: svclz_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclz_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[14]).map_err(|e| format!("{e} | call: svclz_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s16_x(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclz_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[14]).map_err(|e| format!("{e} | call: svclz_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s16_z(create_svbool_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclz_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[30]).map_err(|e| format!("{e} | call: svclz_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclz_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[30]).map_err(|e| format!("{e} | call: svclz_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s32_x(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclz_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[30]).map_err(|e| format!("{e} | call: svclz_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s32_z(create_svbool_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclz_s64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[62]).map_err(|e| format!("{e} | call: svclz_s64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclz_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[62]).map_err(|e| format!("{e} | call: svclz_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s64_x(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_s64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclz_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[62]).map_err(|e| format!("{e} | call: svclz_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_s64_z(create_svbool_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_s64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclz_u8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svclz_u8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclz_u8_x(create_svbool_t(), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svclz_u8_x(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u8_x(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svclz_u8_z(create_svbool_t(), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[6]).map_err(|e| format!("{e} | call: svclz_u8_z(create_svbool_t(), create_svuint8_t_from(2u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u8_z(create_svbool_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclz_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[14]).map_err(|e| format!("{e} | call: svclz_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclz_u16_x(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[14]).map_err(|e| format!("{e} | call: svclz_u16_x(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u16_x(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svclz_u16_z(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[14]).map_err(|e| format!("{e} | call: svclz_u16_z(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u16_z(create_svbool_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclz_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[30]).map_err(|e| format!("{e} | call: svclz_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclz_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[30]).map_err(|e| format!("{e} | call: svclz_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u32_x(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svclz_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[30]).map_err(|e| format!("{e} | call: svclz_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u32_z(create_svbool_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclz_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[62]).map_err(|e| format!("{e} | call: svclz_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclz_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[62]).map_err(|e| format!("{e} | call: svclz_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u64_x(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svclz_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svclz_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[62]).map_err(|e| format!("{e} | call: svclz_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svclz_u64_z(create_svbool_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svclz_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svclz_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_m::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| format!("{e} | call: svcmla_f32_m::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_f32_m::<90>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_f32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_x::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| format!("{e} | call: svcmla_f32_x::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_f32_x::<90>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_f32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_z::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| format!("{e} | call: svcmla_f32_z::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_f32_z::<90>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_f32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_m::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| format!("{e} | call: svcmla_f64_m::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_f64_m::<90>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_f64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_x::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| format!("{e} | call: svcmla_f64_x::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_f64_x::<90>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_f64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_z::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| format!("{e} | call: svcmla_f64_z::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_f64_z::<90>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_f64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_lane_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_lane_f32::<0, 90>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[7.0]).map_err(|e| format!("{e} | call: svcmla_lane_f32::<0, 90>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmla_lane_f32::<0, 90>(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmla_lane_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmla_lane_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_f32(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_f32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_f32(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_f32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_f64(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_f64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_f64(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_f64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_f64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_s16(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_s16(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_s16(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_s16(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_s32(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_s32(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_s32(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_s32(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_s64(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_s64(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_s64(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_s64(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_u8(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_u8(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_u8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_u8(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_u8(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_u8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_u16(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_u16(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_u16(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_u16(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_u32(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_u32(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_u32(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_u32(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_u64(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_u64(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_n_u64(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_n_u64(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_wide_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_wide_s8(create_svbool_t(), create_svint8_t_from(2i8), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_wide_s8(create_svbool_t(), create_random_svint8_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_wide_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_wide_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmpeq_wide_n_s8_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svcmpeq_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svcmpeq_wide_n_s8(create_svbool_t(), create_svint8_t_from(2i8), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svcmpeq_wide_n_s8(create_svbool_t(), create_random_svint8_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve_svcmpeq_wide_n_s8() -> Result<(), String> {
    unsafe { test_aarch64_sve_svcmpeq_wide_n_s8_impl() }
}
