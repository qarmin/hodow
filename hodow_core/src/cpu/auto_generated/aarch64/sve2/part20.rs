use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshl_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshl_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshl_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshl_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshl_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshl_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshl_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshl_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshl_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshl_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u16_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshl_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u16_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshl_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u32_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshl_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u32_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshl_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u32_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshl_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u32_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshl_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svint32_t_from(3i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u32_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshl_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3i32));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3i32)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u32_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqrshl_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u64_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqrshl_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u64_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqrshl_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u64_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqrshl_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u64_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqrshl_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svint64_t_from(3i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshl_n_u64_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svqrshl_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3i64));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqrshl_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshl_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshl_n_u64_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshl_n_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshrnb_n_s16::<1>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0i8; 1]).map_err(|e| format!("{e} | call: svqrshrnb_n_s16::<1>(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnb_n_s16::<1>(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshrnb_n_s32::<1>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0i16; 1]).map_err(|e| format!("{e} | call: svqrshrnb_n_s32::<1>(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnb_n_s32::<1>(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshrnb_n_s64::<1>(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0i32; 1]).map_err(|e| format!("{e} | call: svqrshrnb_n_s64::<1>(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnb_n_s64::<1>(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnb_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshrnb_n_u16::<1>(create_svuint16_t_from(1u16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svqrshrnb_n_u16::<1>(create_svuint16_t_from(1u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnb_n_u16::<1>(create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnb_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnb_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnb_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshrnb_n_u32::<1>(create_svuint32_t_from(1u32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svqrshrnb_n_u32::<1>(create_svuint32_t_from(1u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnb_n_u32::<1>(create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnb_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnb_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnb_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshrnb_n_u64::<1>(create_svuint64_t_from(1u64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svqrshrnb_n_u64::<1>(create_svuint64_t_from(1u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnb_n_u64::<1>(create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnb_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnb_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqrshrnt_n_s16::<1>(create_svint8_t_from(1i8), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrnt_n_s16::<1>(create_svint8_t_from(1i8), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnt_n_s16::<1>(create_random_svint8_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqrshrnt_n_s32::<1>(create_svint16_t_from(1i16), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrnt_n_s32::<1>(create_svint16_t_from(1i16), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnt_n_s32::<1>(create_random_svint16_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqrshrnt_n_s64::<1>(create_svint32_t_from(1i32), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrnt_n_s64::<1>(create_svint32_t_from(1i32), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnt_n_s64::<1>(create_random_svint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnt_n_u16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshrnt_n_u16::<1>(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrnt_n_u16::<1>(create_svuint8_t_from(1u8), create_svuint16_t_from(2u16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnt_n_u16::<1>(create_random_svuint8_t(), create_random_svuint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnt_n_u16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnt_n_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnt_n_u32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshrnt_n_u32::<1>(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrnt_n_u32::<1>(create_svuint16_t_from(1u16), create_svuint32_t_from(2u32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnt_n_u32::<1>(create_random_svuint16_t(), create_random_svuint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnt_n_u32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnt_n_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrnt_n_u64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshrnt_n_u64::<1>(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrnt_n_u64::<1>(create_svuint32_t_from(1u32), create_svuint64_t_from(2u64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrnt_n_u64::<1>(create_random_svuint32_t(), create_random_svuint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrnt_n_u64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrnt_n_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrunb_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshrunb_n_s16::<1>(create_svint16_t_from(1i16)));
        check_array_equality(&result, &[0u8; 1]).map_err(|e| format!("{e} | call: svqrshrunb_n_s16::<1>(create_svint16_t_from(1i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrunb_n_s16::<1>(create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrunb_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrunb_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrunb_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshrunb_n_s32::<1>(create_svint32_t_from(1i32)));
        check_array_equality(&result, &[0u16; 1]).map_err(|e| format!("{e} | call: svqrshrunb_n_s32::<1>(create_svint32_t_from(1i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrunb_n_s32::<1>(create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrunb_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrunb_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrunb_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshrunb_n_s64::<1>(create_svint64_t_from(1i64)));
        check_array_equality(&result, &[0u32; 1]).map_err(|e| format!("{e} | call: svqrshrunb_n_s64::<1>(create_svint64_t_from(1i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrunb_n_s64::<1>(create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrunb_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrunb_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrunt_n_s16_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svqrshrunt_n_s16::<1>(create_svuint8_t_from(1u8), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrunt_n_s16::<1>(create_svuint8_t_from(1u8), create_svint16_t_from(2i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrunt_n_s16::<1>(create_random_svuint8_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrunt_n_s16() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrunt_n_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrunt_n_s32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svqrshrunt_n_s32::<1>(create_svuint16_t_from(1u16), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrunt_n_s32::<1>(create_svuint16_t_from(1u16), create_svint32_t_from(2i32))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrunt_n_s32::<1>(create_random_svuint16_t(), create_random_svint32_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrunt_n_s32() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrunt_n_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqrshrunt_n_s64_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svqrshrunt_n_s64::<1>(create_svuint32_t_from(1u32), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[1]).map_err(|e| format!("{e} | call: svqrshrunt_n_s64::<1>(create_svuint32_t_from(1u32), create_svint64_t_from(2i64))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqrshrunt_n_s64::<1>(create_random_svuint32_t(), create_random_svint64_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqrshrunt_n_s64() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqrshrunt_n_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqshl_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s8_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqshl_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s8_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqshl_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s8_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqshl_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s8_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqshl_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s8_z_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqshl_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s8_z() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqshl_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_n_s16_m_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqshl_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_n_s16_m() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqshl_s16_x_impl() -> Result<(), String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqshl_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[16]).map_err(|e| format!("{e} | call: svqshl_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = svqshl_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
            }
        }
    }
    Ok(())
}

pub(super) fn test_aarch64_sve2_svqshl_s16_x() -> Result<(), String> {
    unsafe { test_aarch64_sve2_svqshl_s16_x_impl() }
}
